Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4E22C032E
	for <mptcp@lists.linux.dev>; Mon,  2 Feb 2026 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770024127; cv=none; b=R/8fRRRpEohOGQpqoIKksFzqpF7m9IMAIvNKn3gsuy95O4dfBv6Tlyx6RMcizl/CkGhH/XITgkXrkGdDSumsxVk3N+BwU0phnYhc5KTScasgWEntmLhwRAQQifQSepikE0F09LFBg+iyMEdBD2rSBSN/LvKdt918Otlu6XuCrpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770024127; c=relaxed/simple;
	bh=SSKgcmQCzsRkGbWx/PhgVdINC1OAKmnrTv959idBzyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVZeDi0PJFcwiXXeQ7/xS2sPGRS4RlujNLW/tbSdF1rFrhrDKqoXTSLBfQ0ROg/se9TBfFqPjiXJLvraJCOtdLYguDWnQVx+zmLoP+musRtYZ/rHw3Y0XYaPQRgMrTKsTtCURyYUpRyhXTW6ZXm7lW5idm60v2bf7w7gxaVgJD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WngQiKw5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WngQiKw5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D27FC116C6;
	Mon,  2 Feb 2026 09:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770024126;
	bh=SSKgcmQCzsRkGbWx/PhgVdINC1OAKmnrTv959idBzyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WngQiKw5fDodeOe64W3LhWxjEMBw0PCCzeHXUUDf6C+7fZRLVv03KWf/LGpEQWoDi
	 mTxDuYfnELVYezgN3kouZZWnLz3EV8p7TF+g4Xk95f6yJ33vkxnBf22doOnoZQWrPN
	 Aae6Kz17gUKOghpydYyYPgg4o7OoAfGyFcOKpQqvNlLln5ibTeKIIhJt2n/h/wZEHB
	 OIB/Y3o7TO62bTuM1e32gk0lL7knjBoItWkPMSiBUu2poseRcwUS5K1psyGcD3WvTr
	 yzu/bz77v/1cOfj1XNWO6BeiwX1oHxFl+sjvIQxD9e95fNHax7DkbH4aizCJI0aRDY
	 vGxprLJs5f16g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next 2/3] mptcp: implement .splice_eof
Date: Mon,  2 Feb 2026 17:21:50 +0800
Message-ID: <9e3dddfc65f24c1a11e5f0353b497f1d4f1c6f82.1770023932.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770023932.git.tanggeliang@kylinos.cn>
References: <cover.1770023932.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch implements the .splice_eof interface for MPTCP, namely
mptcp_splice_eof(), which sequentially calls do_tcp_splice_eof() for
each subflow.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c88882062c40..5635d196cb9f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4018,6 +4018,20 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	return 0;
 }
 
+static void mptcp_splice_eof(struct socket *sock)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = sock->sk, *ssk;
+
+	lock_sock(sk);
+	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
+		ssk = mptcp_subflow_tcp_sock(subflow);
+
+		do_tcp_splice_eof(ssk);
+	}
+	release_sock(sk);
+}
+
 static struct proto mptcp_prot = {
 	.name		= "MPTCP",
 	.owner		= THIS_MODULE,
@@ -4049,6 +4063,7 @@ static struct proto mptcp_prot = {
 	.obj_size	= sizeof(struct mptcp_sock),
 	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
 	.no_autobind	= true,
+	.splice_eof	= mptcp_splice_eof,
 };
 
 static int mptcp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int addr_len)
@@ -4540,6 +4555,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.splice_eof	   = inet_splice_eof,
 };
 
 static struct inet_protosw mptcp_protosw = {
-- 
2.51.0

