Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676623;
	b=1kCOE8/urmnsOpk4aFD7/7t+t0NRDJjt6oHO133IHf46VpwFxWUURCJ/FHfdRF2Laof3
	 6WzOBFV8a7Wh0qMPxM/zdl5uoIf8JeG34B21aqxNZdym7v+6S59MoLKwiKYwIzehlZ7je
	 b+InC66zNOvUiVtaypKeTuqAQMp3CaG+usRf+uJH1i2LHRltIUV1gIR2SmBaH27IS/Lrq
	 ur1utxCcwTJlp/NegGvwUK9b/TQiwO6g4sBV9Z7deyEDh5p5TkMyYp15zEdTfhuzlT1tF
	 8e1saoFKgIRO1YdaDPx9VqycEWT+1369ZldR9uQoG7nprIdVEKk0an4BQsCtcrEZdtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676623;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FcyZ/23EO9wCaimpG8uixyj/1tWZ+pqjTJz3x+0Dc/c=;
	b=VBBLJqzkZ82sZRi3Wm6D31Z+RSV8oVM09on41Q88xPLUdydZ2kk9yKn7iHm3VdyenLgQ
	 cJmkDjAsNm9VZPJL04S2Vv9D3+Qr+8vSuZCb8lwWQaDx0JYV35Fapp9Jtnowwj5YYYUJ5
	 yg44cie5hl1EQTuXxzaC/NmWUHh4sjGC3RqLOdsD2RoGf34RX1BNHN5ibN4S/LmcdY3vL
	 +dk6wSUr9zVi5nJL+phX7/Nx7ocJsIBuQYrVcHTCMtCGQfIeDDyG42VPXW/hvbTI1BHDd
	 ByTOBtDp62wIRRx5w8s/epc+wo9/KZ3u+VD1Q/MO9dVNGuPO6d+WQ6gpY0l9CI8p6Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QRDYBNZF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7B5606A327
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QRDYBNZF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9429F1F0093A;
	Tue,  3 Nov 2026 03:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793676622;
	bh=FcyZ/23EO9wCaimpG8uixyj/1tWZ+pqjTJz3x+0Dc/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QRDYBNZF3NgrmTadGAwwkqMd8Dr6qvMOId1dbcKaswj6xipdXjrMT2lpHX1opwWUr
	 itqCaJYvFNvQie9t4n5DudDm9HMgbIXUFwa4eeVbJ6fAiBnY72grE8MlB+8SAfWOxO
	 Co4tNItftnDHlKYLYW4BNzKslBFPX14DAaA+me8zXBJ3J120pTdKK1vD3V+dLkpWD4
	 c0F0WV8kQrrYdplW7FKS7PPeOif+WhfNSPbLYDrs3ezsiHqhE/0f6R5Q5CO8dctYKn
	 hcctC8K+YqpB7A5lx4eucoJNh4zDMON1yA0fPlOsvKsBLKAQVCKLY3yJ9odSk4IZqh
	 O88EfW5tmEn1A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v5 1/7] mptcp: update mptcp_check_readable
Date: Tue,  3 Nov 2026 11:29:50 +0800
Message-ID: <184d0f6d5246d68be7c8a824a1fa3ac936166b2e.1793676064.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793676064.git.tanggeliang@kylinos.cn>
References: <cover.1793676064.git.tanggeliang@kylinos.cn>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
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
index 02a4f479d9d8..0caa31525b90 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3476,9 +3476,11 @@ void __mptcp_unaccepted_force_close(struct sock *sk)
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
@@ -4580,7 +4582,8 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 		mask |= EPOLLIN | EPOLLRDNORM | EPOLLRDHUP;
 
 	if (state != TCP_SYN_SENT && state != TCP_SYN_RECV) {
-		mask |= mptcp_check_readable(sk);
+		if (mptcp_stream_is_readable(sk))
+			mask |= EPOLLIN | EPOLLRDNORM;
 		if (shutdown & SEND_SHUTDOWN)
 			mask |= EPOLLOUT | EPOLLWRNORM;
 		else
-- 
2.55.0

