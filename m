Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793860695;
	b=0UkO2xEsTqFPF+jz8hDiuq75s0C3mK6VebDd1JG/yqKj9teKsTdBv5GdA8MNjTOCCLgZ
	 y0Tx8/w90rPd8ShIPhuN0o/iHt+MS6JUMqcyi9nQhQ7GE8H0FGDclrCz7qK3BlFu0eBM8
	 bxcP/IoYleIrR+yGZWAbz+OOvCw2deBv6IJwtBiWsgFOOW6qz1k8mIEipqa3U269AcDRs
	 fQ82Kly6xvKvJpfW22o6jKdN/KR4+oDiOJVDkhY7TYd7xYvyQ+h4/CKBC28A7JMYbRr2S
	 u3dnpGNNlJEHXL/bpnwAhp+ugqzkASHN5uTYvdbhxEnphl+hKLURkOXd41qmu1TkO3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793860695;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FcyZ/23EO9wCaimpG8uixyj/1tWZ+pqjTJz3x+0Dc/c=;
	b=OZzCeEkQdtypgVB5sk8QypUgehUCVv+PCyXOWb8e14tymQ2vgurDaQ7gEHk8OcrJcE/Y
	 72oZpEwpbFtZ6gV0IeZz46109ZdsD9g1141Wecvt9P734yvVxiBv7OBD24Gh6WQWq0WzY
	 Nin+jXJmw2mAYCS9h5HhLs+mxMvg/bh/qYwwuAVopkihm2+wu2frfRLELm1vRDPpjkTyr
	 /hsbA4l5RuROQe87Jgnxvo2vvYza1wqCphKVZesFyfZejz9cix6JtEXxCMtDV7fG55FXg
	 zRYpy39i7FVkushj6p919TTPkOUh+Hz7YnvXceRiHda8GqpWidcogAPV6KLehg7X0+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N+dcnhZb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7F1606A31B
	for <mptcp@lists.linux.dev>; Thu,  5 Nov 2026 06:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N+dcnhZb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 018A81F00919;
	Thu,  5 Nov 2026 06:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793860695;
	bh=FcyZ/23EO9wCaimpG8uixyj/1tWZ+pqjTJz3x+0Dc/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N+dcnhZbXv9+SSZIzJfYN2fjbqhC0AgpW9kEheek6VoLryiZzA4YL7eDNmp4awF/Y
	 7tu5Rmi2w1E+b0SpMhh1XirCidtN7+Qkwc58Hr/zXfMvLkNkqKT1SEjJMqukeCHflA
	 Db18/6h1G4YCEz82YtGzrvZqkpHkzFNTqAwG9/7h36F44sBdwUMRio6ZgcsVeOLAGz
	 WEmib49VmKKu3/DDOhNWSad+vENVI8kdY8Gybj5SmzinWUmNVThTrnqcQOF26RhobR
	 QE4/Lp7FxJ9huJns1MK8yzlb6TbYagsqfaBK+0BVhI+fmaFgwS+HtMnhv8DQCinLB6
	 ogkWRT6mBf8UQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v6 1/7] mptcp: update mptcp_check_readable
Date: Thu,  5 Nov 2026 14:37:57 +0800
Message-ID: <39dbcb8350a0dc436687a4b27af6ba1007d11710.1793860134.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793860134.git.tanggeliang@kylinos.cn>
References: <cover.1793860134.git.tanggeliang@kylinos.cn>
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

