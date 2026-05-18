Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D5D3FBB46
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106078; cv=none; b=QOvxisFDwQC7n+9jzKqMsvpBwG4jAW9fhHndkKUAVmILq1W3yiVMl3aVaBR23roscAM7blk9/RxXIogiHui1j84vys0uM3L8tcXTFvdXWd3d/+wDVySpdXx2sHbjb41Y+WcrxjNhiNWu8eto0ecXntqY5hSxHX1keYylyl8xdSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106078; c=relaxed/simple;
	bh=3YUspg6uIbaeDumRMWuDrGn+dKwQhPe3oM9mXxiQdys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CQ5Q7LmL1f4C6EA5w40VtGggls+qrX4W/FwPRB3Yb0IMQ0qlIrjHdPJECi0vpcAEf19qI+Y1aJPbAccIorsUPEfLykkNGH7zyPG3h5M3OG3eeDBhvOZLDLlXdZvuVkisu0zcV/xYCCpUKVmhaAhUS0pjBPOv1YvU2Hur47npNB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U32YwxIs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U32YwxIs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F8BC2BCB8;
	Mon, 18 May 2026 12:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779106078;
	bh=3YUspg6uIbaeDumRMWuDrGn+dKwQhPe3oM9mXxiQdys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U32YwxIsnZ/pp3rIAmXu8kK0bQGKiEaptAHRH1aOUvi7mMMj86gKXBkIo0kQ4RFhy
	 L/NmWYqRn67/E2zb+kN12PP7xrukXBUEM+G8CyYxz+qT9J8FRMF/MOEkp2IaeMtpnK
	 I2n9GM/+9LHlovZYAstBjWtoGP9LWaaNXH5maLxhLCJ78muBTDNMxFNF5f+5vLM2wv
	 /9ipD1PlFhWk9sopksJ0XY3HjHMX9an6AIiaImK70ZaDj1q1tKJ2tPIL3qTqo7PT51
	 CIRTwMTzbn7lYN+EwwK6KknwQvTLqRTlFepQ6MNFStPZnu3TawZxQXlOgktXf/P4SD
	 nAwCIpXshDGNg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v13 02/12] nvmet-tcp: define target tcp_proto struct
Date: Mon, 18 May 2026 20:07:27 +0800
Message-ID: <157ffe3dbecf3779c2633b493241180753f5e9e8.1779104752.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779104752.git.tanggeliang@kylinos.cn>
References: <cover.1779104752.git.tanggeliang@kylinos.cn>
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

A proto field is added to struct nvmet_tcp_port, which points to the
appropriate protocol structure. The proto pointer is set during port
creation and remains valid for the lifetime of the port.

Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 50 ++++++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7fc37ce2c050..4ba6bc9480af 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -198,6 +198,15 @@ struct nvmet_tcp_queue {
 	void (*write_space)(struct sock *);
 };
 
+struct nvmet_tcp_proto {
+	int			protocol;
+	void (*set_reuseaddr)(struct sock *sk);
+	void (*set_nodelay)(struct sock *sk);
+	void (*set_priority)(struct sock *sk, u32 priority);
+	void (*no_linger)(struct sock *sk);
+	void (*set_tos)(struct sock *sk);
+};
+
 struct nvmet_tcp_port {
 	struct socket		*sock;
 	struct work_struct	accept_work;
@@ -205,6 +214,7 @@ struct nvmet_tcp_port {
 	struct kref		kref;
 	struct sockaddr_storage addr;
 	void (*data_ready)(struct sock *);
+	const struct nvmet_tcp_proto *proto;
 };
 
 static DEFINE_IDA(nvmet_tcp_queue_ida);
@@ -1714,7 +1724,6 @@ static void nvmet_tcp_state_change(struct sock *sk)
 static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
-	struct inet_sock *inet = inet_sk(sock->sk);
 	int ret;
 
 	ret = kernel_getsockname(sock,
@@ -1732,14 +1741,13 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	 * close. This is done to prevent stale data from being sent should
 	 * the network connection be restored before TCP times out.
 	 */
-	sock_no_linger(sock->sk);
+	queue->port->proto->no_linger(sock->sk);
 
 	if (so_priority > 0)
-		sock_set_priority(sock->sk, so_priority);
+		queue->port->proto->set_priority(sock->sk, so_priority);
 
 	/* Set socket type of service */
-	if (inet->rcv_tos > 0)
-		ip_sock_set_tos(sock->sk, inet->rcv_tos);
+	queue->port->proto->set_tos(sock->sk);
 
 	ret = 0;
 	write_lock_bh(&sock->sk->sk_callback_lock);
@@ -2066,6 +2074,23 @@ static void nvmet_tcp_listen_data_ready(struct sock *sk)
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 
+static void tcp_sock_set_tos(struct sock *sk)
+{
+	struct inet_sock *inet = inet_sk(sk);
+
+	if (inet->rcv_tos > 0)
+		ip_sock_set_tos(sk, inet->rcv_tos);
+}
+
+static const struct nvmet_tcp_proto nvmet_tcp_proto = {
+	.protocol	= IPPROTO_TCP,
+	.set_reuseaddr	= sock_set_reuseaddr,
+	.set_nodelay	= tcp_sock_set_nodelay,
+	.set_priority	= sock_set_priority,
+	.no_linger	= sock_no_linger,
+	.set_tos	= tcp_sock_set_tos,
+};
+
 static int nvmet_tcp_add_port(struct nvmet_port *nport)
 {
 	struct nvmet_tcp_port *port;
@@ -2092,6 +2117,13 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		goto err_port;
 	}
 
+	if (nport->disc_addr.trtype == NVMF_TRTYPE_TCP) {
+		port->proto = &nvmet_tcp_proto;
+	} else {
+		ret = -EINVAL;
+		goto err_port;
+	}
+
 	ret = inet_pton_with_scope(&init_net, af, nport->disc_addr.traddr,
 			nport->disc_addr.trsvcid, &port->addr);
 	if (ret) {
@@ -2106,7 +2138,7 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		port->nport->inline_data_size = NVMET_TCP_DEF_INLINE_DATA_SIZE;
 
 	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
-				IPPROTO_TCP, &port->sock);
+				port->proto->protocol, &port->sock);
 	if (ret) {
 		pr_err("failed to create a socket\n");
 		goto err_port;
@@ -2115,10 +2147,10 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 	port->sock->sk->sk_user_data = port;
 	port->data_ready = port->sock->sk->sk_data_ready;
 	port->sock->sk->sk_data_ready = nvmet_tcp_listen_data_ready;
-	sock_set_reuseaddr(port->sock->sk);
-	tcp_sock_set_nodelay(port->sock->sk);
+	port->proto->set_reuseaddr(port->sock->sk);
+	port->proto->set_nodelay(port->sock->sk);
 	if (so_priority > 0)
-		sock_set_priority(port->sock->sk, so_priority);
+		port->proto->set_priority(port->sock->sk, so_priority);
 
 	ret = kernel_bind(port->sock, (struct sockaddr_unsized *)&port->addr,
 			sizeof(port->addr));
-- 
2.53.0

