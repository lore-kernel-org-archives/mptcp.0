Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC063438B6
	for <mptcp@lists.linux.dev>; Wed, 20 May 2026 04:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779250695; cv=none; b=Vjc0/Co+Wsv98koPn5AAQJ25FGFZdqrN2GKywu/TvSHoQ9755A8b9NS63/yESyDV6VOJzS/7Tk8u/zlg4SK2XN37IJATmlywmJw8h7Axdp+EDrXfJqBmIswp6agt8l90f8nsHHbl5yENIs4HPFRcdcZ1vu5IccfSsFyjGThfSvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779250695; c=relaxed/simple;
	bh=e0zoP1SW64E3C24gimXLk+EgYE7Qda6fe21XWG3ytwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAQFbNBn9D54uNG14i67pjuXvw4VEPEAwfUp4QZwE/0IsA5yzRlBM/D504YBOjMWL8UOWJzURt3ugwuUgVzpQnV6a55ChQOZnYNilPhXqnqjqkX0Gvg1xcE4f4t2y8aopoUs/woE2JjEjqDTZqbPwSHT7uZbCNk9YW7gSFGrnFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/L538Q8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/L538Q8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254231F000E9;
	Wed, 20 May 2026 04:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779250694;
	bh=6D5/TPgfpOo8LKEnupoAZL2qbpHynIAqGNS9MOuIszA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J/L538Q8ruSbaAa475dNZUFTOm2TJI61kLpoq8BO6w66tnb6ILWQQ6y/X/mUtl6z9
	 rHb12oF2IJgFwoIuOgqgD5d71sjnO+onNvx+HPhKcVnRhkhXfrMjAnPkdBJz51DUPM
	 X2osgLMTsekgIgivBVbW/xUvP0Ce0XIqpDdkSbBlsGj8om0WRr+uKprjl+1VqKw8lR
	 xavufU1GdzRccMmCpSOWxPlvKq0NxdBbilGC0yd/jCWl1KP4OWw69onWNz7KZTSPTO
	 nGXsX8YMRXaE3fRxiK3WjOa1znzutVdvOvEvcFN+vADEn9Aai6HJV7foadC/wS5gNG
	 7kDeAbuNyZ+lQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v15 04/10] nvme-tcp: define host tcp_proto struct
Date: Wed, 20 May 2026 12:17:37 +0800
Message-ID: <3c669912d27ea035563400b73df467fb7c5c239c.1779249906.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779249906.git.tanggeliang@kylinos.cn>
References: <cover.1779249906.git.tanggeliang@kylinos.cn>
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
to ctrl->proto.

All locations that previously called TCP setsockopt functions are updated
to call the corresponding function pointers in the nvme_tcp_proto
structure. The controller's proto pointer is set during initialization and
remains valid throughout the controller's lifetime.

Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c | 44 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 15d36d6a728e..13a5240623ef 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -182,6 +182,16 @@ struct nvme_tcp_queue {
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
 	/* read only in the hot path */
 	struct nvme_tcp_queue	*queues;
@@ -198,6 +208,8 @@ struct nvme_tcp_ctrl {
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
+
+	const struct nvme_tcp_proto *proto;
 };
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
@@ -1799,7 +1811,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 	ret = sock_create_kern(current->nsproxy->net_ns,
 			ctrl->addr.ss_family, SOCK_STREAM,
-			IPPROTO_TCP, &queue->sock);
+			ctrl->proto->protocol, &queue->sock);
 	if (ret) {
 		dev_err(nctrl->device,
 			"failed to create socket: %d\n", ret);
@@ -1816,24 +1828,24 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	nvme_tcp_reclassify_socket(queue->sock);
 
 	/* Single syn retry */
-	tcp_sock_set_syncnt(queue->sock->sk, 1);
+	ctrl->proto->set_syncnt(queue->sock->sk, 1);
 
 	/* Set TCP no delay */
-	tcp_sock_set_nodelay(queue->sock->sk);
+	ctrl->proto->set_nodelay(queue->sock->sk);
 
 	/*
 	 * Cleanup whatever is sitting in the TCP transmit queue on socket
 	 * close. This is done to prevent stale data from being sent should
 	 * the network connection be restored before TCP times out.
 	 */
-	sock_no_linger(queue->sock->sk);
+	ctrl->proto->no_linger(queue->sock->sk);
 
 	if (so_priority > 0)
-		sock_set_priority(queue->sock->sk, so_priority);
+		ctrl->proto->set_priority(queue->sock->sk, so_priority);
 
 	/* Set socket type of service */
 	if (nctrl->opts->tos >= 0)
-		ip_sock_set_tos(queue->sock->sk, nctrl->opts->tos);
+		ctrl->proto->set_tos(queue->sock->sk, nctrl->opts->tos);
 
 	/* Set 10 seconds timeout for icresp recvmsg */
 	queue->sock->sk->sk_rcvtimeo = 10 * HZ;
@@ -2900,6 +2912,17 @@ nvme_tcp_existing_controller(struct nvmf_ctrl_options *opts)
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
+
+};
+
 static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
@@ -2964,13 +2987,20 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		goto out_free_ctrl;
 	}
 
+	if (!strcmp(ctrl->ctrl.opts->transport, "tcp")) {
+		ctrl->proto = &nvme_tcp_proto;
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
2.53.0

