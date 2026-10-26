Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793000191;
	b=FSBT1StuqLjO0J6HN0D2WBedKR7RoW2RZbO1qsya6kHO4ktDMbm/hfA1d+DVlk8eMeQF
	 k2l9jFoHKX9CJX/X5pflBB/+5HxH2qAZ5qI00025Qfkxsj4PREgsVa2EXFmqEb9gnNdyP
	 uZUKPScBgiFzvZGX/RL4MBxcWpd0DGCWtlqp1RUugPNLu/22kosBb/WxfdVIGvLIMjauH
	 Qejkvu43aI5/QXnl4hXzRGd+XQ4x0sGXToLxwlaZccjehV7LG2uHiXyjv7muKDEKufWqH
	 DGzoEzliE5WLLszsQaB6+waGAeOYkl0knuBL8QbPKdsumdi//d5c9dJRK/kIurnNlsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793000191;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FcyZ/23EO9wCaimpG8uixyj/1tWZ+pqjTJz3x+0Dc/c=;
	b=iHtALZBrC/kzDP2S7fAQTS/uaREQVY0ORrolDlwH2M9oTTrSx3zhZ9pDz5K+Gfx1T8uI
	 HTrwX42cKnF9yJCAydc3s5Und+2phvx4uUG5fK+LnO3dDAGufFAQSNf1Rtxn0BLKzefWi
	 7JV80l3coajnq3w1+gLeCLT+FpFc0CKTXGYaGDhHFgiGzhVnkmsVLd+3yfccEi5183YCc
	 oIdOrkgIYtUw/37Em1jG3feoum3xi1wrJeFnZ4hYMZct/lfNlcaMfs85B8ojVDOYb9Buj
	 IEWcJC4OVxjw6Sp2+VZQh/GgIjwlvBFfM8Sb8FLveAWgjT2PAgSM/o+kKdJ7vqfTBzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gkTuVZ/u";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076A0606A31A
	for <mptcp@lists.linux.dev>; Mon, 26 Oct 2026 07:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gkTuVZ/u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277211F01825;
	Mon, 26 Oct 2026 07:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793000190;
	bh=FcyZ/23EO9wCaimpG8uixyj/1tWZ+pqjTJz3x+0Dc/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gkTuVZ/ubXjZvcZqZ1F8yAsUcfYX0S913/KR7q62R2bO4okpZ9zmKcaJ06fobyd1H
	 +DD3BV2JThUItBFDvJ5zHzQQEG50sY2wt7L7ayz70YbbNj9y5XcpUSemlUEcpbiHW5
	 WmbVcoPNk9q1XjWvhLROkOqVeiraasM4BcYHZdvNMqxBssaf4D9cq4J1oNUhm/Xx24
	 DI5D03h0uA6n2Lda2cA6IUARvUJ7cdMhFWknozQ8+6X5PmAlP1IZAflNI4T3UWa2kh
	 69T2HvScIpTYqBHQUPnesrwbNan0pIIX70r30wmUemKtMuVbueoZh+YTd7hk0bV62L
	 eQ/jjjBRsqy4w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next 1/6] mptcp: update mptcp_check_readable
Date: Mon, 26 Oct 2026 15:36:17 +0800
Message-ID: <56b390f4512669bab42f013024891aa2af0dca95.1792999988.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792999988.git.tanggeliang@kylinos.cn>
References: <cover.1792999988.git.tanggeliang@kylinos.cn>
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

