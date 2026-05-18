Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633E43C76AD
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 07:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779087704; cv=none; b=oNiMypADZilUpTOwZgk6QbgS567q58z77c0/fIwyVbszS3x66CItyEz3dg656j2RAilXjgorzsqdl4cHiux9RWcxhDLgs/yGr1nP+HsiQ/ur7XS/Gkdf8j8EXTvdtFcfFSSlGXc2b0CZnCWci+i6HYq2w25Ru46h9wcJAdYCmaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779087704; c=relaxed/simple;
	bh=Lpr1vvBxQBeRt+BzId8G5mZKquLQCqxEKb2bblqzH6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRsWYouhGG70cWvxlnV0ooEnPulF+me/PDoQZ6xfbImr5KLMoF7l4T79WgAU6fHrvnOVPf2zceQR2tZZekoYX/lMDiWprjeq+ZHH5w1SUR4+scoEuFdW3kmqip9rzagUOX+oXOpBonsfEkXHVTftKaT1xKrrg3Gc8eNSQ4nLYcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBE9d0Mr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBE9d0Mr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871B5C2BCC6;
	Mon, 18 May 2026 07:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779087704;
	bh=Lpr1vvBxQBeRt+BzId8G5mZKquLQCqxEKb2bblqzH6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eBE9d0MrQknym086w9y3tVy7fmWG1AKrZCEO1kFiHXM7h9wePlQrwMsIPkHVzpEc2
	 mtydvTOnxaQC/gPRpFHKZZZbWv+GNA9v6ZZ4p5RbNTNp+v17dFKpqTw4x19u/Kk4CL
	 x5h/y7QB+LCM/WZbsf7CGq6uf3na5vn6canW75AYH25+GYMqmNJzr9d+RgoUdtugK1
	 p4OMG3em7UomgF59udj5BN/GPy6r8dJXPqIGevjl6vICSmrjVWv8cRmjDz5GXgQ/D1
	 jiOQ7m5+AK3/QRD7tYO9Fx2X/+oqI7oF2d4NopIeXV4RbJlOBel130khyvm/S1P0UP
	 GKG0bE2CotY+g==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v12 02/11] nvmet-tcp: define target tcp_proto struct
Date: Mon, 18 May 2026 15:01:21 +0800
Message-ID: <376df73086d11f059258149fb8cb0a7b79d7e4f2.1779087443.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779087443.git.tanggeliang@kylinos.cn>
References: <cover.1779087443.git.tanggeliang@kylinos.cn>
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

This patch defines the nvmet_tcp_proto structure, which contains the
protocol of the socket and a set of function pointers for these socket
operations.

A TCP-specific version of struct nvmet_tcp_proto is defined. In
nvmet_tcp_add_port(), a local proto variable is set based on trtype.
All locations that previously called TCP setsockopt functions are updated
to call the corresponding function pointers in the nvmet_tcp_proto
structure.

A proto field is added to struct nvmet_tcp_queue directly, rather than
to struct nvmet_tcp_port. This avoids the need for RCU protection when
accessing proto, as it points to static const data that never changes
during the queue's lifetime.

The proto pointer is determined based on port->sock->sk->sk_protocol
during queue allocation, and stored in the queue for subsequent use.

Cc: Hannes Reinecke <hare@suse.de>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 47 +++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index ebd7aa689c5a..1cf5a27063d1 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -145,6 +145,15 @@ enum nvmet_tcp_queue_state {
 	NVMET_TCP_Q_FAILED,
 };
 
+struct nvmet_tcp_proto {
+	int			protocol;
+	void (*set_reuseaddr)(struct sock *sk);
+	void (*set_nodelay)(struct sock *sk);
+	void (*set_priority)(struct sock *sk, u32 priority);
+	void (*no_linger)(struct sock *sk);
+	void (*set_tos)(struct sock *sk, int val);
+};
+
 struct nvmet_tcp_queue {
 	struct socket		*sock;
 	struct nvmet_tcp_port	*port;
@@ -196,6 +205,7 @@ struct nvmet_tcp_queue {
 	void (*data_ready)(struct sock *);
 	void (*state_change)(struct sock *);
 	void (*write_space)(struct sock *);
+	const struct nvmet_tcp_proto *proto;
 };
 
 struct nvmet_tcp_port {
@@ -1714,14 +1724,14 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	 * close. This is done to prevent stale data from being sent should
 	 * the network connection be restored before TCP times out.
 	 */
-	sock_no_linger(sock->sk);
+	queue->proto->no_linger(sock->sk);
 
 	if (so_priority > 0)
-		sock_set_priority(sock->sk, so_priority);
+		queue->proto->set_priority(sock->sk, so_priority);
 
 	/* Set socket type of service */
 	if (inet->rcv_tos > 0)
-		ip_sock_set_tos(sock->sk, inet->rcv_tos);
+		queue->proto->set_tos(sock->sk, inet->rcv_tos);
 
 	ret = 0;
 	write_lock_bh(&sock->sk->sk_callback_lock);
@@ -1904,6 +1914,15 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
 static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w) {}
 #endif
 
+static const struct nvmet_tcp_proto nvmet_tcp_proto = {
+	.protocol	= IPPROTO_TCP,
+	.set_reuseaddr	= sock_set_reuseaddr,
+	.set_nodelay	= tcp_sock_set_nodelay,
+	.set_priority	= sock_set_priority,
+	.no_linger	= sock_no_linger,
+	.set_tos	= ip_sock_set_tos,
+};
+
 static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		struct socket *newsock)
 {
@@ -1923,6 +1942,12 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	queue->sock = newsock;
 	queue->port = port;
 	queue->nr_cmds = 0;
+	if (port->sock->sk->sk_protocol == IPPROTO_TCP) {
+		queue->proto = &nvmet_tcp_proto;
+	} else {
+		ret = -EINVAL;
+		goto out_free_queue;
+	}
 	spin_lock_init(&queue->state_lock);
 	if (queue->port->nport->disc_addr.tsas.tcp.sectype ==
 	    NVMF_TCP_SECTYPE_TLS13)
@@ -2043,6 +2068,7 @@ static void nvmet_tcp_listen_data_ready(struct sock *sk)
 
 static int nvmet_tcp_add_port(struct nvmet_port *nport)
 {
+	const struct nvmet_tcp_proto *proto;
 	struct nvmet_tcp_port *port;
 	__kernel_sa_family_t af;
 	int ret;
@@ -2065,6 +2091,13 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		goto err_port;
 	}
 
+	if (nport->disc_addr.trtype == NVMF_TRTYPE_TCP) {
+		proto = &nvmet_tcp_proto;
+	} else {
+		ret = -EINVAL;
+		goto err_port;
+	}
+
 	ret = inet_pton_with_scope(&init_net, af, nport->disc_addr.traddr,
 			nport->disc_addr.trsvcid, &port->addr);
 	if (ret) {
@@ -2079,7 +2112,7 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		port->nport->inline_data_size = NVMET_TCP_DEF_INLINE_DATA_SIZE;
 
 	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
-				IPPROTO_TCP, &port->sock);
+				proto->protocol, &port->sock);
 	if (ret) {
 		pr_err("failed to create a socket\n");
 		goto err_port;
@@ -2088,10 +2121,10 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	port->sock->sk->sk_user_data = port;
 	port->data_ready = port->sock->sk->sk_data_ready;
 	port->sock->sk->sk_data_ready = nvmet_tcp_listen_data_ready;
-	sock_set_reuseaddr(port->sock->sk);
-	tcp_sock_set_nodelay(port->sock->sk);
+	proto->set_reuseaddr(port->sock->sk);
+	proto->set_nodelay(port->sock->sk);
 	if (so_priority > 0)
-		sock_set_priority(port->sock->sk, so_priority);
+		proto->set_priority(port->sock->sk, so_priority);
 
 	ret = kernel_bind(port->sock, (struct sockaddr_unsized *)&port->addr,
 			sizeof(port->addr));
-- 
2.53.0

