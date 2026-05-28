Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDB8390CBE
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960456; cv=none; b=Lbm5iIkJmA2Evmbs2nnWEpnAPuLk3N5tc55enN09Xtv1GEDErU1bPg2iRgYN8xazRy4mwnnuD4kH8K9c61FaolM+Z38k7kLd4D2gBGH/hyLV9dZUhMBoBBHXpQbGXf/sDMlZX4bPDqBBJquYLZ7KFMwcJ1tfc5ts5BgkuPyC2fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960456; c=relaxed/simple;
	bh=KCU7YwIvtG4/+w7KZqpnHpRPfcJZP1pjKvbBm5J7oLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQ/2ce/3IcQvGQOK8H8EFrU2jxAwFcttIsEpmbjeJiD+8qfknIyU97W0qT+24oplF1jWDggQ6mcEiHAH9rXkA9BK+PZFHztc1axSwe7nJ58Vp5BgRwwfNesqZc9CanXBvOL+083xkOVs3lx4DjDsWrkfeaI1i5wTuaxQD1KtlT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNNp6Jec; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNNp6Jec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCC391F00A3C;
	Thu, 28 May 2026 09:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779960453;
	bh=8H7BUdeSDcR41hXnsnfzQUdPkXFX2J39t8GM9DTZxxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SNNp6JecxaxLQ4oOPXgH/hYR/vJP6k43JC/Q0Or3JSYnudC1aJI4H8S5APNqdmVk+
	 TPuUs+iHS1kzAJtxNO8ojCScDp4QT2IBHHTGNyk576d8mdOFHaVgRrjGWBEGtS0UkM
	 NYQoblFqxU5arD9xKZK58Nx2J2q8A+ykGRTrqRh17fY/lmvv+GmKmmI4VPwtUidwud
	 Ed0H7OmLKxxhBXlSiDzf9Efm8vRoDREQ2xeiplCF0w9fs2Ep/Cx5Cj+SRpB3MfjonE
	 ONUWaPsqrTl7DgOXWZMliS16yvGFU3uJEd5B9qv4MFNnqfrNWsu2RDLjGBSj600UCP
	 cj1b4r0YyGSJQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [RFC mptcp-next v21 06/18] mptcp: update mptcp_check_readable helper
Date: Thu, 28 May 2026 17:26:57 +0800
Message-ID: <0c44d14e94050fb5ac4206d705e1c909cd42ee49.1779959644.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779959644.git.tanggeliang@kylinos.cn>
References: <cover.1779959644.git.tanggeliang@kylinos.cn>
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
index 1d67728d4233..366ad42eb0a7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3284,9 +3284,11 @@ void __mptcp_unaccepted_force_close(struct sock *sk)
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
@@ -4350,7 +4352,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
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

