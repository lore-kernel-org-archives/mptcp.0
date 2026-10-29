Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793259511;
	b=Y1V7C/CedkAg1q/UPwytqMhCeI1Ln+6UKguvRoHS+tohx01toZTa+GgIj2RPk1uXlyyD
	 bHmsC84B01IoAmpe8/iKsD8dQOZF06Ss9AcYvWc8q2P9LKWxX2Ba17tz8xmDS3IJy+lF7
	 l0FRkmfH4l6pPye6WWKHmx7MXPv6VygrxFSN3zYGRBPbsazK0Rjm4n7FyUEcK1bJn8nPJ
	 sZQDo3UQFCbXf9GxGjVZlmRWutOm8HHnhS/E7+VG27nXOABwGvm5MebYmvRKzErbcTsy9
	 KgJ9/Z4S8KcOadPeNZ0nynU2ejVS36psRFS7CiBzDnGNBKD5g+zNyIqhvEDioAHbV2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793259511;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FcyZ/23EO9wCaimpG8uixyj/1tWZ+pqjTJz3x+0Dc/c=;
	b=f7ZaVmr25n3n7HlhLcdE1xXGHXxA3Y6h4Fnjr5b4J7/J5GgLkp1L6994tAz78XPWZaJw
	 5hVIX6Lpvf3dQJ+0lW7sDw6us9znkE8CX6OYPbxcH6dyDUPGMBuutT5hocvISqiFcb0p/
	 WYK3lYbvwqCPskweO34pBZRFHS2PTVpp4z2FdhXENOFAt/WFKJekdhgAHxwSw+H9U32Mp
	 MTEETmoeDXKquW/kX+Hw6cQ0MgqPVnOuDeg8tsHS+h3Iw4ptIxh//hJt/VhKLWN/7adNp
	 UPGINkKY5UNbn0Yy66leeT5BPIA5WbCxmycq+EgELKI7v70sO7Zvpz1v+aUEa9jk85Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pm6PFOOj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580F0606A321
	for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 07:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pm6PFOOj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C9B1F01829;
	Thu, 29 Oct 2026 07:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793259511;
	bh=FcyZ/23EO9wCaimpG8uixyj/1tWZ+pqjTJz3x+0Dc/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pm6PFOOjDqlS0TAwpbJJFjPA6Xes6LnPeKSkTZxE12ORw9BvjeCaBQgLjfcuiYdNZ
	 rb5EbE3K8PyXpDCDV0maQxnn9tNM+N4DOVmKaIwT01e5UyTI5iwROEd0F3JOndV2TI
	 WtjSTQlBS22Xn3OQLy4WLhkw5mukujwP1qESZx6kHwEKiMd5s7PcJJ9UOFftsilxmt
	 muI63dRacnegvCOPKMihCZ6zgZRWpvXTvqRiUsPQ5ldZsk6qgVzl9af7yZPIoErNpL
	 zed+iSnef5tA5JEN73gUK/IvWyw8vBeF3uEku69dvY6HGc+/CnbQ3DleCcVYrwM47g
	 PfNARMS4AABkQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH mptcp-next v2 1/5] mptcp: update mptcp_check_readable
Date: Thu, 29 Oct 2026 15:38:13 +0800
Message-ID: <de481bab97c658f60f74a37b61a817756d19439e.1793258749.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1793258749.git.tanggeliang@kylinos.cn>
References: <cover.1793258749.git.tanggeliang@kylinos.cn>
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

