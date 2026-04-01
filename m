Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2373C457D
	for <mptcp@lists.linux.dev>; Wed,  1 Apr 2026 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775048055; cv=none; b=UYvpsQq4M+cJGXr5+nXgqAy3JTGwSBSIBpGdXg7+nfHfPMfOAIljE9iKONH1Xq67Pn5sHFgY6rpy68LAnZDmoMzJKZO7MbCSTL3kYaJgcZYUYCuVzd7/nqqo8cb1tthI4yuqO7hM7jhdVGrAtynQKpirRfqoDroJJV8B76PlSSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775048055; c=relaxed/simple;
	bh=lPqEDVAibGOo8RUs2/Z21JT7XruoP5DXlmqZpTgU6U8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JT8Q7/OxxEkGOb3eLEXheaNntXXZ0IboLOr6/gnU5Q0EeLTSwtjz3G5maqWrwGXeiqCEhjC5BcKlxkHf6DQAbiG47XAjmgNhPKLKED9GdjtLXyvhzDXKz0eAI3uOkHKeF4sPrd10epeoIUvyWPildsNvp1fOAJnElPk0iW2WrSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYmtDebO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYmtDebO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4657C4CEF7;
	Wed,  1 Apr 2026 12:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775048054;
	bh=lPqEDVAibGOo8RUs2/Z21JT7XruoP5DXlmqZpTgU6U8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NYmtDebOcL8hEvcldFyLBmoHnM4zT7bXxrZpZFvbxtTf1w0PfmU6u7+/B0u3ZtjV8
	 JxqNfDHlQmc9Hr9SOcvuYd7TZWPOW62Ve1v2dxmFRr5yea6+s+VW4MbO9e+/jzvcan
	 1N4u3uq8aMtCftCF5XwE07Guds11krW01H2fL1VmE9tMWRQ0GjqYVCvH+085mcgP3W
	 yKGlq6c9uU6mK+h8xP7xCkjPSox8naY4gHAuP77/wLIdFnq/Xg7MY05j+kcUE11dU3
	 z2icB/TRgNCKy8MY83jwqpCnB3Ymprfk2ZMFR81IF+vBg05dvFa9OjmNUVqKSpp8oG
	 0k3GZq2YdiNLg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v8 1/7] nvmet-tcp: define target tcp_proto struct
Date: Wed,  1 Apr 2026 20:53:39 +0800
Message-ID: <519fa1af4856352621362298296af7b0ed6765aa.1775047736.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775047736.git.tanggeliang@kylinos.cn>
References: <cover.1775047736.git.tanggeliang@kylinos.cn>
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
(nvmet_tcp_alloc_cmd, nvmet_tcp_done_recv_pdu, nvmet_tcp_set_queue_sock)
to prevent use-after-free when a port is removed while asynchronous
operations (e.g., TLS handshake) are pending. The port structure is
released using kfree_rcu() in nvmet_tcp_remove_port(), and queue->port is
assigned using rcu_assign_pointer() in nvmet_tcp_alloc_queue().

Cc: Hannes Reinecke <hare@suse.de>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 66 ++++++++++++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index acc71a26733f..d8d3d97de8ed 100644
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
@@ -1027,6 +1040,7 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 {
 	struct nvme_tcp_hdr *hdr = &queue->pdu.cmd.hdr;
 	struct nvme_command *nvme_cmd = &queue->pdu.cmd.cmd;
+	const struct nvmet_fabrics_ops *ops;
 	struct nvmet_req *req;
 	int ret;
 
@@ -1067,7 +1081,10 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 	req = &queue->cmd->req;
 	memcpy(req->cmd, nvme_cmd, sizeof(*nvme_cmd));
 
-	if (unlikely(!nvmet_req_init(req, &queue->nvme_sq, &nvmet_tcp_ops))) {
+	rcu_read_lock();
+	ops = rcu_dereference(queue->port)->proto->ops;
+	rcu_read_unlock();
+	if (unlikely(!nvmet_req_init(req, &queue->nvme_sq, ops))) {
 		pr_err("failed cmd %p id %d opcode %d, data_len: %d, status: %04x\n",
 			req->cmd, req->cmd->common.command_id,
 			req->cmd->common.opcode,
@@ -1686,6 +1703,7 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
 	struct inet_sock *inet = inet_sk(sock->sk);
+	const struct nvmet_tcp_proto *proto;
 	int ret;
 
 	ret = kernel_getsockname(sock,
@@ -1698,19 +1716,23 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	if (ret < 0)
 		return ret;
 
+	rcu_read_lock();
+	proto = rcu_dereference(queue->port)->proto;
+	rcu_read_unlock();
+
 	/*
 	 * Cleanup whatever is sitting in the TCP transmit queue on socket
 	 * close. This is done to prevent stale data from being sent should
 	 * the network connection be restored before TCP times out.
 	 */
-	sock_no_linger(sock->sk);
+	proto->no_linger(sock->sk);
 
 	if (so_priority > 0)
-		sock_set_priority(sock->sk, so_priority);
+		proto->set_priority(sock->sk, so_priority);
 
 	/* Set socket type of service */
 	if (inet->rcv_tos > 0)
-		ip_sock_set_tos(sock->sk, inet->rcv_tos);
+		proto->set_tos(sock->sk, inet->rcv_tos);
 
 	ret = 0;
 	write_lock_bh(&sock->sk->sk_callback_lock);
@@ -2030,6 +2052,16 @@ static void nvmet_tcp_listen_data_ready(struct sock *sk)
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
@@ -2054,6 +2086,13 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
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
@@ -2068,7 +2107,7 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		port->nport->inline_data_size = NVMET_TCP_DEF_INLINE_DATA_SIZE;
 
 	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
-				IPPROTO_TCP, &port->sock);
+				port->proto->protocol, &port->sock);
 	if (ret) {
 		pr_err("failed to create a socket\n");
 		goto err_port;
@@ -2077,10 +2116,10 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
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
@@ -2111,11 +2150,16 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 static void nvmet_tcp_destroy_port_queues(struct nvmet_tcp_port *port)
 {
 	struct nvmet_tcp_queue *queue;
+	struct nvmet_tcp_port *qport;
 
 	mutex_lock(&nvmet_tcp_queue_mutex);
-	list_for_each_entry(queue, &nvmet_tcp_queue_list, queue_list)
-		if (queue->port == port)
+	list_for_each_entry(queue, &nvmet_tcp_queue_list, queue_list) {
+		rcu_read_lock();
+		qport = rcu_dereference(queue->port);
+		rcu_read_unlock();
+		if (qport == port)
 			kernel_sock_shutdown(queue->sock, SHUT_RDWR);
+	}
 	mutex_unlock(&nvmet_tcp_queue_mutex);
 }
 
@@ -2135,7 +2179,7 @@ static void nvmet_tcp_remove_port(struct nvmet_port *nport)
 	nvmet_tcp_destroy_port_queues(port);
 
 	sock_release(port->sock);
-	kfree(port);
+	kfree_rcu(port, rcu);
 }
 
 static void nvmet_tcp_delete_ctrl(struct nvmet_ctrl *ctrl)
-- 
2.51.0

