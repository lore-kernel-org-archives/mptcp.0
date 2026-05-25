Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD0B41C71
	for <mptcp@lists.linux.dev>; Mon, 25 May 2026 09:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779701626; cv=none; b=I+06a/j65pacz0hdLeL6+a9+XQGUVYA9VsM1PQwHv9/XOF6BTKHqW6JhQ5C/u5iKL7Xln8bQggM+5xHRh6aJuJf0S9cE6n/2xRfjT7NjbqJXKKIKD2MaxkKnXO+0qJxY5v97+PUODw3Lo9c3IWP+jvHio7Lc4UwjHicAqJCJTgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779701626; c=relaxed/simple;
	bh=qRJh71CNrOxqes94cD9mxBxBWowIncSl6wO8z/4hh0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPER5qngP5elTx5PcaI3Is/K4ZoHHDVDLYmvZzQ3XqLov831UCSC1+q/hC6LjdKpqDIj32OvxMXu6Hk2ZmDzPJtPCVKugE/HSs/87CqaEoFKqlhtYwAfJoU9Lw++RaAXPUnZ+7ErPcrQrSbjHXde++wzl89USRBaXdep2WrDYxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXd2Cbfa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXd2Cbfa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546621F000E9;
	Mon, 25 May 2026 09:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779701625;
	bh=CX30/KzfBi4zd6HLC1PSlaRiBuq4VbxIBmU36VV2CJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NXd2CbfaIi1vvaVvksfqCn7aalJDpwzuu1eVqiOArOmbiF94jYo5d5X6a1pMlsPL7
	 9S7AG6zsePdv8P+H9MZjSSSNbau21VIy5EhzWSPVERAaP/BaUIpUj1yKjX0IDk4X4T
	 TxVBpYXJYWnsL1CPHi5yFsQRBOgoqCLTAt300G2Atz+YiDN+SghDpL//Gfh6igRg9M
	 fPIx9k6OUaqCGwAW+SIa7X/3Z8xk3QsNx3/Lw9gE5H1go42x/xVOvKPRZ2VZfzOh9F
	 KIqMfozeqiNdOtmfdKQRYSxJoT1bw7Ll+7EotLAfqXFBcBdqUxCoZ9wZ8LmOfQskEb
	 faTEnJWdxmswg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v17 04/14] nvmet-tcp: define accept tcp_proto struct
Date: Mon, 25 May 2026 17:32:59 +0800
Message-ID: <b433e0aa671138a807f0d12dfe851a84652eccf4.1779701391.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779701391.git.tanggeliang@kylinos.cn>
References: <cover.1779701391.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To handle accepted sockets, this patch adds struct nvmet_tcp_proto to
hold accept socket operations (no_linger, set_priority, set_tos, ops).
A proto field is added to struct nvmet_tcp_queue, which points to the
appropriate protocol structure. A TCP version is defined and assigned
to queue->proto for TCP connections.

Also modify nvmet_tcp_set_queue_sock() and nvmet_tcp_done_recv_pdu()
to use queue->proto for socket operations and fabrics callbacks.

Cc: Hannes Reinecke <hare@suse.de>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/target/tcp.c | 40 +++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7093faf3e985..4c198be45bef 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -145,6 +145,13 @@ enum nvmet_tcp_queue_state {
 	NVMET_TCP_Q_FAILED,
 };
 
+struct nvmet_tcp_proto {
+	void (*no_linger)(struct sock *sk);
+	void (*set_priority)(struct sock *sk, u32 priority);
+	void (*set_tos)(struct sock *sk);
+	const struct nvmet_fabrics_ops *ops;
+};
+
 struct nvmet_tcp_queue {
 	struct socket		*sock;
 	struct nvmet_tcp_port	*port;
@@ -196,6 +203,7 @@ struct nvmet_tcp_queue {
 	void (*data_ready)(struct sock *);
 	void (*state_change)(struct sock *);
 	void (*write_space)(struct sock *);
+	const struct nvmet_tcp_proto *proto;
 };
 
 struct nvmet_tcp_port {
@@ -1081,7 +1089,8 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 	req = &queue->cmd->req;
 	memcpy(req->cmd, nvme_cmd, sizeof(*nvme_cmd));
 
-	if (unlikely(!nvmet_req_init(req, &queue->nvme_sq, &nvmet_tcp_ops))) {
+	if (unlikely(!nvmet_req_init(req, &queue->nvme_sq,
+				     queue->proto->ops))) {
 		pr_err("failed cmd %p id %d opcode %d, data_len: %d, status: %04x\n",
 			req->cmd, req->cmd->common.command_id,
 			req->cmd->common.opcode,
@@ -1698,7 +1707,6 @@ static void nvmet_tcp_state_change(struct sock *sk)
 static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 {
 	struct socket *sock = queue->sock;
-	struct inet_sock *inet = inet_sk(sock->sk);
 	int ret;
 
 	ret = kernel_getsockname(sock,
@@ -1716,14 +1724,13 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	 * close. This is done to prevent stale data from being sent should
 	 * the network connection be restored before TCP times out.
 	 */
-	sock_no_linger(sock->sk);
+	queue->proto->no_linger(sock->sk);
 
 	if (so_priority > 0)
-		sock_set_priority(sock->sk, so_priority);
+		queue->proto->set_priority(sock->sk, so_priority);
 
 	/* Set socket type of service */
-	if (inet->rcv_tos > 0)
-		ip_sock_set_tos(sock->sk, inet->rcv_tos);
+	queue->proto->set_tos(sock->sk);
 
 	ret = 0;
 	write_lock_bh(&sock->sk->sk_callback_lock);
@@ -1906,6 +1913,21 @@ static int nvmet_tcp_tls_handshake(struct nvmet_tcp_queue *queue)
 static void nvmet_tcp_tls_handshake_timeout(struct work_struct *w) {}
 #endif
 
+static void tcp_sock_set_tos(struct sock *sk)
+{
+	struct inet_sock *inet = inet_sk(sk);
+
+	if (inet->rcv_tos > 0)
+		ip_sock_set_tos(sk, inet->rcv_tos);
+}
+
+static const struct nvmet_tcp_proto nvmet_tcp_proto = {
+	.no_linger	= sock_no_linger,
+	.set_priority	= sock_set_priority,
+	.set_tos	= tcp_sock_set_tos,
+	.ops		= &nvmet_tcp_ops,
+};
+
 static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		struct socket *newsock)
 {
@@ -1923,6 +1945,12 @@ static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
 	kref_init(&queue->kref);
 	queue->sock = newsock;
+	if (newsock->sk->sk_protocol == IPPROTO_TCP) {
+		queue->proto = &nvmet_tcp_proto;
+	} else {
+		ret = -EINVAL;
+		goto out_free_queue;
+	}
 	queue->port = port;
 	queue->nr_cmds = 0;
 	spin_lock_init(&queue->state_lock);
-- 
2.53.0

