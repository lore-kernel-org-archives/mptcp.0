Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE7540823D
	for <mptcp@lists.linux.dev>; Wed,  1 Apr 2026 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775048062; cv=none; b=q4mmilQKZyKLK/EvkatBGijeaZpOUFLlyDYd0gIGCjqR1OPFLFj/c3hKYb/iSbCWpgCzZsx91T/AivFQwCSXvGkK4/g2MBMqWqrW/dx55iW+vL/RwCk22RbcoXetojcL7r4saxozSjVu9yzM//4puNO05ZjCsoFQDTYSc6zfTHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775048062; c=relaxed/simple;
	bh=k4kz0JiqAuLT1IazLigfeNqVPkREnEsIkrzlroD0eAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0E58aNJvuGhkGMGr04O6tjNOMVbVALvw762cPXy8MoOXEAXUbj23Yn1U4FR3TjuLPZW3VrftAjADGbhOqsGioiEMaUqAdnjvxEbqrg6fEwwfPAphPWZa+iEFX9spDnqRzxbbfxH6aGQD8YtfewWZNlp+pM+Z96+Q2NIvhv6kGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwVHJ+f7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwVHJ+f7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8234C2BCB0;
	Wed,  1 Apr 2026 12:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775048062;
	bh=k4kz0JiqAuLT1IazLigfeNqVPkREnEsIkrzlroD0eAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uwVHJ+f7zlOcOxxfulYg/WWZM8rJ3r0G+MsYHCH3QUn0cLpBeEUBxYPS6wbIFnhPM
	 I1TX7KdIk/lpWS1wdtJuaEC2eJbwQVlcuXjeOY2qc1zQPd9a4kxOEzAEvCjOjxiqil
	 0pFhntM92/lpj1P5wkZIO7xMcJTdDj5etstiWhtn4ddUfpnP2P466st6xJVP4VNjG1
	 Z/TRM+uQ7RcquJNyvYqp5t5VJmX/vhWn0qzgDWKekfAOzVlyzDg7zxwx3ovol4Gnqf
	 vxHYTm//DA0k5n71H0QWCoV1PiTpJudUf/b/x2p186T3Y1jaK7HYp+5xocYa3XvSmV
	 yLEUlP+ukpTcQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v8 4/7] nvme-tcp: define host tcp_proto struct
Date: Wed,  1 Apr 2026 20:53:42 +0800
Message-ID: <643f4040bb6cd03ff408b90ba7c160eed5c3895d.1775047736.git.tanggeliang@kylinos.cn>
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

To add MPTCP support in "NVMe over TCP", the host side needs to pass
IPPROTO_MPTCP to sock_create_kern() instead of IPPROTO_TCP to create an
MPTCP socket.

Similar to the target-side nvmet_tcp_proto, this patch defines the
host-side nvme_tcp_proto structure, which contains the protocol of the
socket and a set of function pointers for socket operations. The only
difference is that it defines .set_syncnt instead of .set_reuseaddr.

A TCP-specific version of this structure is defined, and a proto field is
added to nvme_tcp_ctrl. When the transport string is "tcp", it is assigned
to ctrl->proto using RCU assignment.

All locations that previously called TCP setsockopt functions are updated
to call the corresponding function pointers in the nvme_tcp_proto
structure. RCU protection is added when accessing ctrl->proto in the I/O
path (nvme_tcp_alloc_queue()) to prevent use-after-free when the controller
is being removed concurrently. The proto field is released using
kfree_rcu() in nvme_tcp_free_ctrl().

Cc: Hannes Reinecke <hare@suse.de>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c | 53 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 243dab830dc8..30e4d915011e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -11,6 +11,7 @@
 #include <linux/crc32.h>
 #include <linux/nvme-tcp.h>
 #include <linux/nvme-keyring.h>
+#include <linux/rcupdate.h>
 #include <net/sock.h>
 #include <net/tcp.h>
 #include <net/tls.h>
@@ -182,7 +183,19 @@ struct nvme_tcp_queue {
 	void (*write_space)(struct sock *);
 };
 
+struct nvme_tcp_proto {
+	int			protocol;
+	int (*set_syncnt)(struct sock *sk, int val);
+	void (*set_nodelay)(struct sock *sk);
+	void (*no_linger)(struct sock *sk);
+	void (*set_priority)(struct sock *sk, u32 priority);
+	void (*set_tos)(struct sock *sk, int val);
+	const struct nvme_ctrl_ops *ops;
+};
+
 struct nvme_tcp_ctrl {
+	struct rcu_head		rcu;
+
 	/* read only in the hot path */
 	struct nvme_tcp_queue	*queues;
 	struct blk_mq_tag_set	tag_set;
@@ -198,6 +211,8 @@ struct nvme_tcp_ctrl {
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
+
+	const struct nvme_tcp_proto *proto;
 };
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
@@ -1767,6 +1782,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
+	const struct nvme_tcp_proto *proto;
 	int ret, rcv_pdu_size;
 	struct file *sock_file;
 
@@ -1783,9 +1799,13 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		queue->cmnd_capsule_len = sizeof(struct nvme_command) +
 						NVME_TCP_ADMIN_CCSZ;
 
+	rcu_read_lock();
+	proto = rcu_dereference(ctrl->proto);
+	rcu_read_unlock();
+
 	ret = sock_create_kern(current->nsproxy->net_ns,
 			ctrl->addr.ss_family, SOCK_STREAM,
-			IPPROTO_TCP, &queue->sock);
+			proto->protocol, &queue->sock);
 	if (ret) {
 		dev_err(nctrl->device,
 			"failed to create socket: %d\n", ret);
@@ -1802,24 +1822,24 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	nvme_tcp_reclassify_socket(queue->sock);
 
 	/* Single syn retry */
-	tcp_sock_set_syncnt(queue->sock->sk, 1);
+	proto->set_syncnt(queue->sock->sk, 1);
 
 	/* Set TCP no delay */
-	tcp_sock_set_nodelay(queue->sock->sk);
+	proto->set_nodelay(queue->sock->sk);
 
 	/*
 	 * Cleanup whatever is sitting in the TCP transmit queue on socket
 	 * close. This is done to prevent stale data from being sent should
 	 * the network connection be restored before TCP times out.
 	 */
-	sock_no_linger(queue->sock->sk);
+	proto->no_linger(queue->sock->sk);
 
 	if (so_priority > 0)
-		sock_set_priority(queue->sock->sk, so_priority);
+		proto->set_priority(queue->sock->sk, so_priority);
 
 	/* Set socket type of service */
 	if (nctrl->opts->tos >= 0)
-		ip_sock_set_tos(queue->sock->sk, nctrl->opts->tos);
+		proto->set_tos(queue->sock->sk, nctrl->opts->tos);
 
 	/* Set 10 seconds timeout for icresp recvmsg */
 	queue->sock->sk->sk_rcvtimeo = 10 * HZ;
@@ -2564,7 +2584,7 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 	nvmf_free_options(nctrl->opts);
 free_ctrl:
 	kfree(ctrl->queues);
-	kfree(ctrl);
+	kfree_rcu(ctrl, rcu);
 }
 
 static void nvme_tcp_set_sg_null(struct nvme_command *c)
@@ -2886,6 +2906,16 @@ nvme_tcp_existing_controller(struct nvmf_ctrl_options *opts)
 	return found;
 }
 
+static const struct nvme_tcp_proto nvme_tcp_proto = {
+	.protocol	= IPPROTO_TCP,
+	.set_syncnt	= tcp_sock_set_syncnt,
+	.set_nodelay	= tcp_sock_set_nodelay,
+	.no_linger	= sock_no_linger,
+	.set_priority	= sock_set_priority,
+	.set_tos	= ip_sock_set_tos,
+	.ops		= &nvme_tcp_ctrl_ops,
+};
+
 static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
@@ -2950,13 +2980,20 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		goto out_free_ctrl;
 	}
 
+	if (!strcmp(ctrl->ctrl.opts->transport, "tcp")) {
+		rcu_assign_pointer(ctrl->proto, &nvme_tcp_proto);
+	} else {
+		ret = -EINVAL;
+		goto out_free_ctrl;
+	}
+
 	ctrl->queues = kzalloc_objs(*ctrl->queues, ctrl->ctrl.queue_count);
 	if (!ctrl->queues) {
 		ret = -ENOMEM;
 		goto out_free_ctrl;
 	}
 
-	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_tcp_ctrl_ops, 0);
+	ret = nvme_init_ctrl(&ctrl->ctrl, dev, ctrl->proto->ops, 0);
 	if (ret)
 		goto out_kfree_queues;
 
-- 
2.51.0

