Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD093A7F48
	for <mptcp@lists.linux.dev>; Tue, 28 Jul 2026 11:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238826; cv=none; b=PvVJQiYQ28C8WYJzZ2DXI9DDKGWcvUkJ5qWIkRlNamy9+JZpiBL7lyvf8fzZR7V8l6AvF92pLYygcU7omOuk9nwFic2XpnV6zJQpKPjfyEGZCNHyBBJnw6Y0vr3UVeXpUbrIJ4bY5EZyI+LPxT1hLJRfdz3l0GmVPqHwZnyeYas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238826; c=relaxed/simple;
	bh=jrmEqBcW+YfyX0GDfc5NSOoAfZUxpVbWWG3TGa3Vl80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLWc1pPIBrWFjNwqkIZ4TcHt9VzpD4PDdQK87o4k9LXs16rpwW6zKmLwuTuMUd32Jy7dUMBUMnQoObxPkM9LBsA/lWsB1eE7WVvt1j+LWdCSNNcG/JIPHddabBAgRsaZU2NimETS2VbRtp+lKpnXcvlewAY+b9eTPfZRncmDLmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buz4uBbn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buz4uBbn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2851F00A3A;
	Tue, 28 Jul 2026 11:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785238825;
	bh=pcL0niRVO2GkZX45imZtqOuw/NWgsuyAotnDCGLuWfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=buz4uBbnRLEDsfyNDVz+0GQYRh94ceeuRaO07giGUDTtA5Z/bCe37DlYd8H7OKARy
	 PGo+rPcusMY5QEwZ9hjTw3yXkGxxoA0MPGmbMtPslS/MaaW3y9HqY3P5P7BY4vSYtJ
	 4/o7bR1sBbCMxpBNzOdcbaN9NNjIM0ESjKq0HrV93x9v2ZkZvhq2Vmiq67W2fK4P90
	 VuKJIgarpmC9LCoeVBk8dw7nz1F1thnmbL4ozm7kIVNVbzmHuhXa9GOIbPFVZxb5+L
	 ChbMfFOFJ2Rfv4fuK5MohW9Onmu8fxL7/EG/4x3qL4D8vBb/+m7vkcKOWMVYc9t1fU
	 HkHhWka4G9Tlg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 7/9] nvmet-tcp: support IPv6 traffic class
Date: Tue, 28 Jul 2026 19:39:40 +0800
Message-ID: <c0601abe9391f2f4c30ede8dfb2537f5cd3ce7b9.1785238723.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785238723.git.tanggeliang@kylinos.cn>
References: <cover.1785238723.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

nvmet-tcp currently applies the received IPv4 TOS value when setting
up a queue socket, but does not handle the IPv6 traffic class.

Extend the queue socket setup to handle AF_INET6 sockets. Obtain the
traffic class from the IPv6 socket and apply it through IPV6_TCLASS.
Keep the existing IPv4 TOS handling unchanged.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 75a276d73be3..95cd57196973 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1699,7 +1699,6 @@ static void nvmet_tcp_state_change(struct sock *sk)
 static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
-	struct inet_sock *inet = inet_sk(sock->sk);
 	int ret;
 
 	ret = kernel_getsockname(sock,
@@ -1723,8 +1722,17 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 		sock_set_priority(sock->sk, so_priority);
 
 	/* Set socket type of service */
-	if (inet->rcv_tos > 0)
-		ip_sock_set_tos(sock->sk, inet->rcv_tos);
+	if (sock->sk->sk_family == AF_INET) {
+		struct inet_sock *inet = inet_sk(sock->sk);
+
+		if (inet->rcv_tos > 0)
+			ip_sock_set_tos(sock->sk, inet->rcv_tos);
+	} else if (sock->sk->sk_family == AF_INET6) {
+		struct ipv6_pinfo *np = inet6_sk(sock->sk);
+
+		if (np->tclass > 0)
+			ip6_sock_set_tclass(sock->sk, np->tclass);
+	}
 
 	ret = 0;
 	write_lock_bh(&sock->sk->sk_callback_lock);
-- 
2.53.0

