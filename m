Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF0536AF6
	for <mptcp@lists.linux.dev>; Sun, 17 May 2026 06:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778997981; cv=none; b=RkvscHSCSEr3ILEZ6A6lHN9/5Md0DPLoNSIJpkPD1YTb7ePLmyDhhGAZ9gKwVNamZHK7NoRpGkIemWOCJvKJFZV84e6qfww1WyJ+h2EKSsLj1VVvqKrIm+6A9F1ITrLInEDz/OfuK2F8YqURfitXe3FCTL3Y0iKVWjYOAOfk3lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778997981; c=relaxed/simple;
	bh=psEx0nb4bCMLmQGIAUSIXx9YeRyZNf2fNRG/If0FBwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YW/gIeXrPP81LV21FEI1W2tssfQjoP9PPp0D4TqAT/3FdPkbsM9emOhbNMfNg4N6Li7MtXyqtBw9J0YZTVLs35xt0WwmSDEE1D0papfKGXnlDVfSuRkTJsstdg8Fdmg5FNCn+mk9H4Nk7iDrJxU9KYtD6DPeZ2cSqyGf6wfE6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lIASKMR8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lIASKMR8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD46C2BCF6;
	Sun, 17 May 2026 06:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778997980;
	bh=psEx0nb4bCMLmQGIAUSIXx9YeRyZNf2fNRG/If0FBwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lIASKMR8VmLyHsKLYzvP6ju9DFBnlWIB5VI8BWsCzEiytwhxKcZmjzgjpjSR4A8on
	 zLxgClO1xtarjoXpuYKdWFJUkNzuxMwHO3Wpdg/DR9wXYAL9HMk244H3bkb5BfTAck
	 YCvWQtCvaJPvmutC+/eBfaudnJwvrCknRtf2XP/Wggcwb4BZF3PPnWQQ3QSGA8q/Sv
	 MwE5Rt5VI5CiUF/bqJwlX+ZbV8Pn4rw51VoAw7DC23k/nlRPhRzv0DWeC815a5CW6r
	 ZIqUy5jYsg5sCUW+ppHymUcrRwdJ4uS0OOxyope3+rXHw3OjEazBoYHahFMGiSB2cf
	 NzK2VVkmHWGAw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v11 03/10] nvmet-tcp: define target tcp_proto struct
Date: Sun, 17 May 2026 14:05:07 +0800
Message-ID: <51260b7724246471d5147c05ec8e620094561ec8.1778997507.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1778997507.git.tanggeliang@kylinos.cn>
References: <cover.1778997507.git.tanggeliang@kylinos.cn>
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

RCU protection is added when accessing queue->port in the I/O path to
prevent use-after-free when a port is removed while asynchronous operations
are pending. The queue->port pointer is cleared using RCU assignment and
synchronized with RCU grace period, and the port structure is then released
after all RCU readers have completed.

Note: This is not a bug fix; it is a preparatory change for MPTCP support.
The RCU conversion makes the code consistent with the __rcu annotation
introduced here, and does not address any existing issue.

Cc: Hannes Reinecke <hare@suse.de>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 114 +++++++++++++++++++++++++++++++++-----
 1 file changed, 100 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 8a243d22a511..20b7b5447cfc 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -18,6 +18,7 @@
 #include <net/handshake.h>
 #include <linux/inet.h>
 #include <linux/llist.h>
+#include <linux/rcupdate.h>
 #include <trace/events/sock.h>
 
 #include "nvmet.h"
@@ -147,7 +148,7 @@ enum nvmet_tcp_queue_state {
 
 struct nvmet_tcp_queue {
 	struct socket		*sock;
-	struct nvmet_tcp_port	*port;
+	struct nvmet_tcp_port __rcu *port;
 	struct work_struct	io_work;
 	struct nvmet_cq		nvme_cq;
 	struct nvmet_sq		nvme_sq;
@@ -198,12 +199,23 @@ struct nvmet_tcp_queue {
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
 	struct socket		*sock;
 	struct work_struct	accept_work;
 	struct nvmet_port	*nport;
 	struct sockaddr_storage addr;
 	void (*data_ready)(struct sock *);
+	const struct nvmet_tcp_proto *proto;
 };
 
 static DEFINE_IDA(nvmet_tcp_queue_ida);
@@ -1044,6 +1056,8 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 {
 	struct nvme_tcp_hdr *hdr = &queue->pdu.cmd.hdr;
 	struct nvme_command *nvme_cmd = &queue->pdu.cmd.cmd;
+	const struct nvmet_tcp_proto *proto;
+	struct nvmet_tcp_port *port;
 	struct nvmet_req *req;
 	int ret;
 
@@ -1081,7 +1095,16 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 	req = &queue->cmd->req;
 	memcpy(req->cmd, nvme_cmd, sizeof(*nvme_cmd));
 
-	if (unlikely(!nvmet_req_init(req, &queue->nvme_sq, &nvmet_tcp_ops))) {
+	rcu_read_lock();
+	port = rcu_dereference(queue->port);
+	if (!port || !port->proto) {
+		rcu_read_unlock();
+		return -EINVAL;
+	}
+	proto = port->proto;
+	rcu_read_unlock();
+
+	if (unlikely(!nvmet_req_init(req, &queue->nvme_sq, proto->ops))) {
 		pr_err("failed cmd %p id %d opcode %d, data_len: %d, status: %04x\n",
 			req->cmd, req->cmd->common.command_id,
 			req->cmd->common.opcode,
@@ -1466,9 +1489,17 @@ static int nvmet_tcp_alloc_cmd(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *c)
 {
 	u8 hdgst = nvmet_tcp_hdgst_len(queue);
+	struct nvmet_tcp_port *port;
 
 	c->queue = queue;
-	c->req.port = queue->port->nport;
+	rcu_read_lock();
+	port = rcu_dereference(queue->port);
+	if (!port || !port->nport) {
+		rcu_read_unlock();
+		return -EINVAL;
+	}
+	c->req.port = port->nport;
+	rcu_read_unlock();
 
 	c->cmd_pdu = page_frag_alloc(&queue->pf_cache,
 			sizeof(*c->cmd_pdu) + hdgst, GFP_KERNEL | __GFP_ZERO);
@@ -1697,6 +1728,8 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
 	struct inet_sock *inet = inet_sk(sock->sk);
+	const struct nvmet_tcp_proto *proto;
+	struct nvmet_tcp_port *port;
 	int ret;
 
 	ret = kernel_getsockname(sock,
@@ -1709,19 +1742,29 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	if (ret < 0)
 		return ret;
 
+	rcu_read_lock();
+	port = rcu_dereference(queue->port);
+	if (!port || !port->proto ||
+	    port->proto->protocol != sock->sk->sk_protocol) {
+		rcu_read_unlock();
+		return -EINVAL;
+	}
+	proto = port->proto;
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
@@ -1752,6 +1795,7 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_queue *queue)
 {
 	struct nvme_tcp_hdr *hdr = &queue->pdu.cmd.hdr;
+	struct nvmet_tcp_port *port;
 	int len, ret;
 	struct kvec iov = {
 		.iov_base = (u8 *)&queue->pdu + queue->offset,
@@ -1764,8 +1808,18 @@ static int nvmet_tcp_try_peek_pdu(struct nvmet_tcp_queue *queue)
 		.msg_flags = MSG_PEEK,
 	};
 
-	if (nvmet_port_secure_channel_required(queue->port->nport))
+	rcu_read_lock();
+	port = rcu_dereference(queue->port);
+	if (!port || !port->nport) {
+		rcu_read_unlock();
+		return 0;
+	}
+
+	if (nvmet_port_secure_channel_required(port->nport)) {
+		rcu_read_unlock();
 		return 0;
+	}
+	rcu_read_unlock();
 
 	len = kernel_recvmsg(queue->sock, &msg, &iov, 1,
 			iov.iov_len, msg.msg_flags);
@@ -1876,19 +1930,30 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
 {
 	int ret = -EOPNOTSUPP;
 	struct tls_handshake_args args;
+	struct nvmet_tcp_port *port;
+	key_serial_t keyring;
 
 	if (queue->state != NVMET_TCP_Q_TLS_HANDSHAKE) {
 		pr_warn("cannot start TLS in state %d\n", queue->state);
 		return -EINVAL;
 	}
 
+	rcu_read_lock();
+	port = rcu_dereference(queue->port);
+	if (!port || !port->nport || !port->nport->keyring) {
+		rcu_read_unlock();
+		return -EINVAL;
+	}
+	keyring = key_serial(port->nport->keyring);
+	rcu_read_unlock();
+
 	kref_get(&queue->kref);
 	pr_debug("queue %d: TLS ServerHello\n", queue->idx);
 	memset(&args, 0, sizeof(args));
 	args.ta_sock = queue->sock;
 	args.ta_done = nvmet_tcp_tls_handshake_done;
 	args.ta_data = queue;
-	args.ta_keyring = key_serial(queue->port->nport->keyring);
+	args.ta_keyring = keyring;
 	args.ta_timeout_ms = tls_handshake_timeout * 1000;
 
 	ret = tls_server_hello_psk(&args, GFP_KERNEL);
@@ -2042,6 +2107,16 @@ static void nvmet_tcp_listen_data_ready(struct sock *sk)
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
@@ -2066,6 +2141,13 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
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
@@ -2080,7 +2162,7 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		port->nport->inline_data_size = NVMET_TCP_DEF_INLINE_DATA_SIZE;
 
 	ret = sock_create(port->addr.ss_family, SOCK_STREAM,
-				IPPROTO_TCP, &port->sock);
+				port->proto->protocol, &port->sock);
 	if (ret) {
 		pr_err("failed to create a socket\n");
 		goto err_port;
@@ -2089,10 +2171,10 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
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
@@ -2125,10 +2207,14 @@ static void nvmet_tcp_destroy_port_queues(struct nvmet_tcp_port *port)
 	struct nvmet_tcp_queue *queue;
 
 	mutex_lock(&nvmet_tcp_queue_mutex);
-	list_for_each_entry(queue, &nvmet_tcp_queue_list, queue_list)
-		if (queue->port == port)
+	list_for_each_entry(queue, &nvmet_tcp_queue_list, queue_list) {
+		if (rcu_access_pointer(queue->port) == port) {
+			rcu_assign_pointer(queue->port, NULL);
 			kernel_sock_shutdown(queue->sock, SHUT_RDWR);
+		}
+	}
 	mutex_unlock(&nvmet_tcp_queue_mutex);
+	synchronize_rcu();
 }
 
 static void nvmet_tcp_remove_port(struct nvmet_port *nport)
-- 
2.53.0

