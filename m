Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7093B5843
	for <mptcp@lists.linux.dev>; Mon, 30 Mar 2026 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863937; cv=none; b=QmIab23hf4gzScjksWrgjOnRjh4W4sIyMxe3qrk3GwU5AOvXFWo8J4qzmjFqIFzTOB4yr+ITflzKAMt38Nlp5mJBiT5uGc2Q20kWchI0Z5gPaHg3qBCk26Re+pDWlVR3AaJubOwux8vVefHl1YvsOxOSvcZpk1BLVBqIG/ynlpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863937; c=relaxed/simple;
	bh=a6a9elLO5pbsPZwCLVSkYM8VOjFqcciy8j35wvE6els=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1fpqOeOdHJR77p+WNQuQjNfQKeLA3Yc5hly8caQSxTnJP3h+K/YEZBhN+wmThIPr/bHhp6HbeCIeU+eT7NyTfvF/Zv3gBkrsGta+CwFoYaRN7FnfgetVll9XMPlaFK+XzwEbvzMe9F4w4DyVwpf6nXMcNGjEad6Zu4Kencnupo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4+rJfg+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4+rJfg+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84709C4CEF7;
	Mon, 30 Mar 2026 09:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774863937;
	bh=a6a9elLO5pbsPZwCLVSkYM8VOjFqcciy8j35wvE6els=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t4+rJfg+Nz5l3xD+HXJCWYyA76ubnVCdI5i5e+mvqqp7Oqvik/obVPFaQYuszJCVq
	 6jWgJFC4YgTB02hxW87OQJ890KHi4kYcbh9MsGo/M2hy2AejiNabbSW1V7YOZmeGSW
	 NRRo6QQM/RFowZ3b1FEEInlO8haBlTMmTkzXsKAO6XSWPJ6+2TjaJeMIQ7X+ZGLif4
	 MFVNfmPosk64givyCSatK6ic1KKTIyGNq61wt7Jrb+/cyJ59YkGaGAYOfC+vG5tLy3
	 tG7ki1hVnm7yLJ+hN0LYujd503QAGt9zKsp4R8ekul5vo8YPHfKMIl+IAI8jqlWBCf
	 /bjsfjNyD/C+g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v6 1/7] nvmet-tcp: define target tcp_sockops struct
Date: Mon, 30 Mar 2026 17:43:26 +0800
Message-ID: <e8ce1eae682a0c478d976f8ab1572e2004bd3815.1774862875.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1774862875.git.tanggeliang@kylinos.cn>
References: <cover.1774862875.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To add MPTCP support in "NVMe over TCP", the target side needs to pass
IPPROTO_MPTCP to sock_create() instead of IPPROTO_TCP to create an MPTCP
socket. Additionally, the setsockopt operations for this socket need to
be switched to a set of MPTCP-specific functions.

This patch defines the nvmet_tcp_sockops structure, which contains the
protocol of the socket and a set of function pointers for these socket
operations. A "sockops" field is also added to struct nvmet_tcp_port.

A TCP-specific version of struct nvmet_tcp_sockops is defined. In
nvmet_tcp_add_port(), port->sockops is set to nvmet_tcp_sockops based on
whether trtype is TCP. All locations that previously called TCP setsockopt
functions are updated to call the corresponding function pointers in the
nvmet_tcp_sockops structure.

Cc: Hannes Reinecke <hare@suse.de>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 40 ++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index acc71a26733f..b20adfb10737 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -198,12 +198,22 @@ struct nvmet_tcp_queue {
 	void (*write_space)(struct sock *);
 };
 
+struct nvmet_tcp_sockops {
+	int			proto;
+	void (*set_reuseaddr)(struct sock *sk);
+	void (*set_nodelay)(struct sock *sk);
+	void (*set_priority)(struct sock *sk, u32 priority);
+	void (*no_linger)(struct sock *sk);
+	void (*set_tos)(struct sock *sk, int val);
+};
+
 struct nvmet_tcp_port {
 	struct socket		*sock;
 	struct work_struct	accept_work;
 	struct nvmet_port	*nport;
 	struct sockaddr_storage addr;
 	void (*data_ready)(struct sock *);
+	struct nvmet_tcp_sockops sockops;
 };
 
 static DEFINE_IDA(nvmet_tcp_queue_ida);
@@ -1703,14 +1713,14 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	 * close. This is done to prevent stale data from being sent should
 	 * the network connection be restored before TCP times out.
 	 */
-	sock_no_linger(sock->sk);
+	queue->port->sockops.no_linger(sock->sk);
 
 	if (so_priority > 0)
-		sock_set_priority(sock->sk, so_priority);
+		queue->port->sockops.set_priority(sock->sk, so_priority);
 
 	/* Set socket type of service */
 	if (inet->rcv_tos > 0)
-		ip_sock_set_tos(sock->sk, inet->rcv_tos);
+		queue->port->sockops.set_tos(sock->sk, inet->rcv_tos);
 
 	ret = 0;
 	write_lock_bh(&sock->sk->sk_callback_lock);
@@ -2030,6 +2040,15 @@ static void nvmet_tcp_listen_data_ready(struct sock *sk)
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 
+static const struct nvmet_tcp_sockops nvmet_tcp_sockops = {
+	.proto		= IPPROTO_TCP,
+	.set_reuseaddr	= sock_set_reuseaddr,
+	.set_nodelay	= tcp_sock_set_nodelay,
+	.set_priority	= sock_set_priority,
+	.no_linger	= sock_no_linger,
+	.set_tos	= ip_sock_set_tos,
+};
+
 static int nvmet_tcp_add_port(struct nvmet_port *nport)
 {
 	struct nvmet_tcp_port *port;
@@ -2054,6 +2073,13 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		goto err_port;
 	}
 
+	if (nport->disc_addr.trtype == NVMF_TRTYPE_TCP) {
+		port->sockops = nvmet_tcp_sockops;
+	} else {
+		ret = -EINVAL;
+		goto err_port;
+	}
+
 	ret = inet_pton_with_scope(&init_net, af, nport->disc_addr.traddr,
 			nport->disc_addr.trsvcid, &port->addr);
 	if (ret) {
@@ -2068,7 +2094,7 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		port->nport->inline_data_size = NVMET_TCP_DEF_INLINE_DATA_SIZE;
 
 	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
-				IPPROTO_TCP, &port->sock);
+				port->sockops.proto, &port->sock);
 	if (ret) {
 		pr_err("failed to create a socket\n");
 		goto err_port;
@@ -2077,10 +2103,10 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	port->sock->sk->sk_user_data = port;
 	port->data_ready = port->sock->sk->sk_data_ready;
 	port->sock->sk->sk_data_ready = nvmet_tcp_listen_data_ready;
-	sock_set_reuseaddr(port->sock->sk);
-	tcp_sock_set_nodelay(port->sock->sk);
+	port->sockops.set_reuseaddr(port->sock->sk);
+	port->sockops.set_nodelay(port->sock->sk);
 	if (so_priority > 0)
-		sock_set_priority(port->sock->sk, so_priority);
+		port->sockops.set_priority(port->sock->sk, so_priority);
 
 	ret = kernel_bind(port->sock, (struct sockaddr_unsized *)&port->addr,
 			sizeof(port->addr));
-- 
2.51.0

