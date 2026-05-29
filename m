Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E38189F43
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 11:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053270; cv=none; b=HE8pAhQJdsn99OptGt7bQRVF+FP+7a3N4HkwXiYBvWbuAaTVoHvXpmO9N1+Jt9m2Hh5ZCCvd0WSeR5Fc6UWuZwBPT9KE4Zqzpt0TPdXBlD5uQx9J/dOR4mxkiOy8BoVHrUFdwdxXln49+y4eQOZsjrsQyu8JKho+FslphrZ5I4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053270; c=relaxed/simple;
	bh=xkOmdXS493PXsswRrf3Se4sg9ZYAL/unp6qhF1FPYtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdlY460AggCH9wAS8PYasmnMpqdiXz6deYKoDtokJ4sKTQQ0UqkypBRntRoGACxJw4NDro9q0q2csNVGXIeADO+hrXPZ9Xs6KlFaTKpv2AjYIoDuhRhq2pjGiY6sUzcjdzF7wRCdNdeCWhUMHaiQlglZ163g7UYagQJlvG+8hzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xgx7lt6D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xgx7lt6D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5E11F00893;
	Fri, 29 May 2026 11:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780053269;
	bh=gu9GpY4sbcUoW5c0J9NA8wncRBEplx6/5//iMulJeDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xgx7lt6DSoQ3FHTKpkZtFZacAapfi2YiqirTFKlyeg9/vKmqUF0qYnuirIIhl7Y7s
	 ra0/YMQ2BMGY2Dm9vLLI3/aXM+O0umPSaE5JJ3mPbwFpfhKQHHo14J14Tv8BtP73i/
	 f09bt0Ls//6b+pVKo5X6leVICnwazNl8bhj8GTm/+HGtN9yOgoMJ3A7XOLUH/2EZ9m
	 2pNGCNY6kv9tDd3hQecJiolZR2sg2y0SVm+jPl/9RvEI2NOSh5O6CF5lOOPcXprFUh
	 dB3Wy1Srqi+v1CNJOLIZFAIc0VtvYpFjt9gb1pHvDIqx7S+ZzX5hR04tZUvqXXBiqq
	 WsFjHQZ1QLNwg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RFC mptcp-next v22 08/20] mptcp: update mptcp_check_readable helper
Date: Fri, 29 May 2026 19:13:50 +0800
Message-ID: <45ca86564cd7e9dd0a615dca44941badb67520c7.1780052851.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780052851.git.tanggeliang@kylinos.cn>
References: <cover.1780052851.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

This patch makes mptcp_check_readable() aligned with TCP, and renames it to
mptcp_stream_is_readable(). It will be used in the case of KTLS, because
'prot' will be modified, tls_sw_sock_is_readable() is expected to be called
from prot->sock_is_readable().

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/protocol.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7fe618e22d1b..b7976a551af0 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3401,9 +3401,11 @@ void __mptcp_unaccepted_force_close(struct sock *sk)
 	__mptcp_destroy_sock(sk);
 }
 
-static __poll_t mptcp_check_readable(struct sock *sk)
+static bool mptcp_stream_is_readable(struct sock *sk)
 {
-	return mptcp_epollin_ready(sk) ? EPOLLIN | EPOLLRDNORM : 0;
+	if (mptcp_epollin_ready(sk))
+		return true;
+	return sk_is_readable(sk);
 }
 
 static void mptcp_check_listen_stop(struct sock *sk)
@@ -4467,7 +4469,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 
 	if (state != TCP_SYN_SENT && state != TCP_SYN_RECV) {
-		mask |= mptcp_check_readable(sk);
+		if (mptcp_stream_is_readable(sk))
+			mask |= EPOLLIN | EPOLLRDNORM;
 		if (shutdown & SEND_SHUTDOWN)
 			mask |= EPOLLOUT | EPOLLWRNORM;
 		else
-- 
2.53.0

