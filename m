Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E34F21B9FD
	for <mptcp@lists.linux.dev>; Tue,  3 Feb 2026 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113964; cv=none; b=NAVLvtn4AWalR8zdTomgjF/1D5O5WXZujFDuj2VrTYb36TfrPltzdAeURlFrJOwUYu4w+1uwONyZ/7pzP2s9zGg+rvRGmavBLknLZU677VBE7C0GIO1o40a6CYGKrHXHnZVD1vRzbxCLuEdSXVGv3d9BRw/CeycFp41iQKK/0UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113964; c=relaxed/simple;
	bh=DBpvkTXwPOz7dw46WNdgBY8eBRzys61qyn9wSY7Wo1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jaEcFIZRG38i9VTnzD8EBPkaU6CNkA72YKxd9rfbyjcGm5UichKG7mY9Hilwj7f+GwffdK3pAxkvS5R3WqtygVF5ujA/IqEmX8tH4wzpKvxTK7lKF17xMJYupCF4+26kvSITCun5TpC3elWKS7ivt4t5dTDLrrVjOB5diaUPMQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oek1WqD+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oek1WqD+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF09C19421;
	Tue,  3 Feb 2026 10:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770113963;
	bh=DBpvkTXwPOz7dw46WNdgBY8eBRzys61qyn9wSY7Wo1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oek1WqD+U61493FHZwntpabJa+090S696KUe3/GfB4ok592M1Hzi3tvZcSrMkZnfo
	 e1Zat8NcWiIspYJ2P+Q/DrUZkTw4Lil4y0kE2jebtDpAAc+UIwhILvl5g95rBaa6ve
	 bjjiNq93lkkQQF+UapMkDJYTEeBU/FyrAncpkCtbTsFhdlEJeCPqc2Jm8ROiOPJSYK
	 dhXEY4E60GTwYQN+DBXn3y9TKV+uBSqI5FXoUKfv/Crx034Mnaae+MWboHpZIJZliM
	 JhR5WRxE1usj7mH0c8cDjT0cUSF5h5roAEy9TNuti2jQ/1Lkj+KwO6PEHN6dlT57q0
	 aZGGotLR5jd0w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v2 2/3] mptcp: implement .splice_eof
Date: Tue,  3 Feb 2026 18:19:08 +0800
Message-ID: <4f176c6cfbc7731d17c273b10e12ec1490facc49.1770113743.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1770113743.git.tanggeliang@kylinos.cn>
References: <cover.1770113743.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch implements the .splice_eof interface for MPTCP, namely
mptcp_splice_eof(), which calls do_tcp_splice_eof() for each active
subflow when a sendfile() operation reaches end-of-file.

do_tcp_splice_eof() flushes any remaining data in the TCP send queue.
MPTCP operates over multiple TCP subflows, and each subflow may have
pending data in its send buffer that needs to be properly finalized
when splicing data through an MPTCP socket.

sock_splice_eof() calls the .splice_eof interface from struct proto_ops.
To maintain consistency with regular TCP behavior, the .splice_eof
interface of mptcp_stream_ops is set to inet_splice_eof, which will
switch to the protocol-specific implementation (sk->sk_prot->splice_eof)
- for MPTCP, that is mptcp_splice_eof().

This is an improvement; nothing was broken before. MPTCP previously did not
handle the splice EOF notification, while TCP did. Without .splice_eof()
support, the queue is not flushed immediately when sendfile() reaches EOF,
but it will eventually be flushed after a small delay.

Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/protocol.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c88882062c40..e4c5fe285f97 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4018,6 +4018,27 @@ static int mptcp_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
 	return 0;
 }
 
+static void mptcp_splice_eof(struct socket *sock)
+{
+	struct mptcp_subflow_context *subflow;
+	struct sock *sk = sock->sk, *ssk;
+	struct mptcp_sock *msk;
+
+	msk = mptcp_sk(sk);
+
+	lock_sock(sk);
+	mptcp_rps_record_subflows(msk);
+	mptcp_for_each_subflow(msk, subflow) {
+		ssk = mptcp_subflow_tcp_sock(subflow);
+
+		if (ssk->sk_state == TCP_CLOSE)
+			continue;
+
+		do_tcp_splice_eof(ssk);
+	}
+	release_sock(sk);
+}
+
 static struct proto mptcp_prot = {
 	.name		= "MPTCP",
 	.owner		= THIS_MODULE,
@@ -4049,6 +4070,7 @@ static struct proto mptcp_prot = {
 	.obj_size	= sizeof(struct mptcp_sock),
 	.slab_flags	= SLAB_TYPESAFE_BY_RCU,
 	.no_autobind	= true,
+	.splice_eof	= mptcp_splice_eof,
 };
 
 static int mptcp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int addr_len)
@@ -4540,6 +4562,7 @@ static const struct proto_ops mptcp_stream_ops = {
 	.set_rcvlowat	   = mptcp_set_rcvlowat,
 	.read_sock	   = mptcp_read_sock,
 	.splice_read	   = mptcp_splice_read,
+	.splice_eof	   = inet_splice_eof,
 };
 
 static struct inet_protosw mptcp_protosw = {
-- 
2.52.0

