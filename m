Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4601543D516
	for <mptcp@lists.linux.dev>; Fri, 15 May 2026 09:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838397; cv=none; b=NLvSXxgBGdhe7XYwFFB8NaKrA7QHPHfdICP85vL+2/57kboj/XKss8RQVZXZoCM2UlhMo37IveHjHKt4+Sp0EdTHdII5fEpV4yeCbmSEYE/lBCT90L7zrjNVDu2mf7pkAXAfL/5kMLJ0BFNoaBwLnpGwPm0EsaJm2gTs7ip6FI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838397; c=relaxed/simple;
	bh=2qSXmmdRji29Z589AQWpwOeekelWKlF0zayOHrm0fxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apoYnDXj6MLKcHEI/XxRt1AJQQ5CEFlXvPAQouxcDUSjkX/GzFLDojdSoNJO3OTZrPOhRtxeI/ZlQ/FdTFNNnWT8BAm6GACZ260XM1uX71s9rC/4At+Ps1MxUgGBYe9rirr9/HRl9dHFi8N0EEdkUA0SrR39jJHYrCpICpDCYjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5nhsAxM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5nhsAxM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE4AC2BCF7;
	Fri, 15 May 2026 09:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778838397;
	bh=2qSXmmdRji29Z589AQWpwOeekelWKlF0zayOHrm0fxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B5nhsAxMDoGmWtGcX8h4LGVf6nlN+IYMSnqJ844A0xm/Ak+X1PiZSpB0XASfW5Su4
	 Q8WH1wtrtPIh2fNmsgOf4eKbPSn9ktCLNBXognAQUhQB8sOXArvI81ZBmv9u0c1JsF
	 4ge4i/8T0xRps1VmQjyxYCCaJFh/vFB+WNmhhhfbcm9AAhzOLea3JQGiYME0MTLj/T
	 5P4BUrjOkuG1RSYZTKK+Oho7hV6i75CJW968CB5Tvh7AJ8SYu+5qLom6rOjmh7QFcE
	 xXYFYhBJ+2lwGxclovKXYQRD7NWjcjplU1FQd89gol/+8wuKo9nenzGTgcKG/HM9mN
	 Erbg1OFfKsHPA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v9 1/8] nvmet-tcp: define target tcp_proto struct
Date: Fri, 15 May 2026 17:46:15 +0800
Message-ID: <77d7c48df2e6b531f3817a4434aa2625dd8993e1.1778837549.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778837549.git.tanggeliang@kylinos.cn>
References: <cover.1778837549.git.tanggeliang@kylinos.cn>
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
operations. A "proto" field is also added to struct nvmet_tcp_port.

A TCP-specific version of struct nvmet_tcp_proto is defined. In
nvmet_tcp_add_port(), port->proto is set to nvmet_tcp_proto based on
whether trtype is TCP. All locations that previously called TCP setsockopt
functions are updated to call the corresponding function pointers in the
nvmet_tcp_proto structure.

This new nvmet_fabrics_ops is selected in nvmet_tcp_done_recv_pdu() based
on the protocol type.

RCU protection is added when accessing queue->port in the I/O path
(nvmet_tcp_done_recv_pdu and nvmet_tcp_set_queue_sock) to prevent
use-after-free when a port is removed while asynchronous operations
(e.g., TLS handshake) are pending. The port structure is released using
kfree_rcu() in nvmet_tcp_remove_port(). The queue->port pointer is
cleared using rcu_assign_pointer() and synchronized with synchronize_rcu()
in nvmet_tcp_destroy_port_queues().

Cc: Hannes Reinecke <hare@suse.de>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 74 +++++++++++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 164a564ba3b4..3ed3767dceaf 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -18,6 +18,7 @@
 #include <net/handshake.h>
 #include <linux/inet.h>
 #include <linux/llist.h>
+#include <linux/rcupdate.h>
 #include <trace/events/sock.h>
 
 #include "nvmet.h"
@@ -198,12 +199,24 @@ struct nvmet_tcp_queue {
 	void (*write_space)(struct sock *);
 };
 
+struct nvmet_tcp_proto {
+	int			protocol;
+	void (*set_reuseaddr)(struct sock *sk);
+	void (*set_nodelay)(struct sock *sk);
+	void (*set_priority)(struct sock *sk, u32 priority);
+	void (*no_linger)(struct sock *sk);
+	void (*set_tos)(struct sock *sk, int val);
+	const struct nvmet_fabrics_ops *ops;
+};
+
 struct nvmet_tcp_port {
+	struct rcu_head		rcu;
 	struct socket		*sock;
 	struct work_struct	accept_work;
 	struct nvmet_port	*nport;
 	struct sockaddr_storage addr;
 	void (*data_ready)(struct sock *);
+	const struct nvmet_tcp_proto *proto;
 };
 
 static DEFINE_IDA(nvmet_tcp_queue_ida);
@@ -1044,6 +1057,7 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 {
 	struct nvme_tcp_hdr *hdr = &queue->pdu.cmd.hdr;
 	struct nvme_command *nvme_cmd = &queue->pdu.cmd.cmd;
+	struct nvmet_tcp_port *port;
 	struct nvmet_req *req;
 	int ret;
 
@@ -1081,7 +1095,14 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 	req = &queue->cmd->req;
 	memcpy(req->cmd, nvme_cmd, sizeof(*nvme_cmd));
 
-	if (unlikely(!nvmet_req_init(req, &queue->nvme_sq, &nvmet_tcp_ops))) {
+	rcu_read_lock();
+	port = rcu_dereference(queue->port);
+	if (!port || !port->proto) {
+		rcu_read_unlock();
+		return -EINVAL;
+	}
+	rcu_read_unlock();
+	if (unlikely(!nvmet_req_init(req, &queue->nvme_sq, port->proto->ops))) {
 		pr_err("failed cmd %p id %d opcode %d, data_len: %d, status: %04x\n",
 			req->cmd, req->cmd->common.command_id,
 			req->cmd->common.opcode,
@@ -1697,6 +1718,7 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
 	struct inet_sock *inet = inet_sk(sock->sk);
+	struct nvmet_tcp_port *port;
 	int ret;
 
 	ret = kernel_getsockname(sock,
@@ -1709,19 +1731,28 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	if (ret < 0)
 		return ret;
 
+	rcu_read_lock();
+	port = rcu_dereference(queue->port);
+	if (!port || !port->proto ||
+	    port->proto->protocol != sock->sk->sk_protocol) {
+		rcu_read_unlock();
+		return -EINVAL;
+	}
+	rcu_read_unlock();
+
 	/*
 	 * Cleanup whatever is sitting in the TCP transmit queue on socket
 	 * close. This is done to prevent stale data from being sent should
 	 * the network connection be restored before TCP times out.
 	 */
-	sock_no_linger(sock->sk);
+	port->proto->no_linger(sock->sk);
 
 	if (so_priority > 0)
-		sock_set_priority(sock->sk, so_priority);
+		port->proto->set_priority(sock->sk, so_priority);
 
 	/* Set socket type of service */
 	if (inet->rcv_tos > 0)
-		ip_sock_set_tos(sock->sk, inet->rcv_tos);
+		port->proto->set_tos(sock->sk, inet->rcv_tos);
 
 	ret = 0;
 	write_lock_bh(&sock->sk->sk_callback_lock);
@@ -2041,6 +2072,16 @@ static void nvmet_tcp_listen_data_ready(struct sock *sk)
 	read_unlock_bh(&sk->sk_callback_lock);
 }
 
+static const struct nvmet_tcp_proto nvmet_tcp_proto = {
+	.protocol	= IPPROTO_TCP,
+	.set_reuseaddr	= sock_set_reuseaddr,
+	.set_nodelay	= tcp_sock_set_nodelay,
+	.set_priority	= sock_set_priority,
+	.no_linger	= sock_no_linger,
+	.set_tos	= ip_sock_set_tos,
+	.ops		= &nvmet_tcp_ops,
+};
+
 static int nvmet_tcp_add_port(struct nvmet_port *nport)
 {
 	struct nvmet_tcp_port *port;
@@ -2065,6 +2106,13 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
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
@@ -2079,7 +2127,7 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		port->nport->inline_data_size = NVMET_TCP_DEF_INLINE_DATA_SIZE;
 
 	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
-				IPPROTO_TCP, &port->sock);
+				port->proto->protocol, &port->sock);
 	if (ret) {
 		pr_err("failed to create a socket\n");
 		goto err_port;
@@ -2088,10 +2136,10 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
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
@@ -2124,10 +2172,14 @@ static void nvmet_tcp_destroy_port_queues(struct nvmet_tcp_port *port)
 	struct nvmet_tcp_queue *queue;
 
 	mutex_lock(&nvmet_tcp_queue_mutex);
-	list_for_each_entry(queue, &nvmet_tcp_queue_list, queue_list)
-		if (queue->port == port)
+	list_for_each_entry(queue, &nvmet_tcp_queue_list, queue_list) {
+		if (rcu_dereference(queue->port) == port) {
+			rcu_assign_pointer(queue->port, NULL);
 			kernel_sock_shutdown(queue->sock, SHUT_RDWR);
+		}
+	}
 	mutex_unlock(&nvmet_tcp_queue_mutex);
+	synchronize_rcu();
 }
 
 static void nvmet_tcp_remove_port(struct nvmet_port *nport)
@@ -2146,7 +2198,7 @@ static void nvmet_tcp_remove_port(struct nvmet_port *nport)
 	nvmet_tcp_destroy_port_queues(port);
 
 	sock_release(port->sock);
-	kfree(port);
+	kfree_rcu(port, rcu);
 }
 
 static void nvmet_tcp_delete_ctrl(struct nvmet_ctrl *ctrl)
-- 
2.53.0

