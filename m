Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DC33859C3
	for <mptcp@lists.linux.dev>; Mon, 30 Mar 2026 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863946; cv=none; b=OufZ4P1gxKASLt6JxiwsL6LwMn3ukbS0fxRn+vesytvn2tCnR00A535aKPMaSV7VWQbVII8S+0Xz2o3T8OOLnLuUfaeVtpf4FCVT9eX/fU10fZapWgDvHCbfRShPTQV3TmPMLjIF6mqO9pcKPnZfpmZcqlE6Nn8f569Pt+ZfCzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863946; c=relaxed/simple;
	bh=7Er0tR6ixjiv9xTABi9G+WNwNdTiscNnW7jTLzlIDWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uas8wyJiwcNrXN/7h5xyqEWHYVKJOvEWm2Tzc0OwjhKRsCU1eH7bNbCjrUIoR2N7Wz3CKxyEoN4605Rawttwp/HUcnXVcBdBdtw4p1BKVe0dKgYEvbh3gGJVGCU3aOGdea93mZyKMIaT9cctyz8kMx43l1DevX04XMbY9D8wwes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rW88w2i4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rW88w2i4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B6AC4CEF7;
	Mon, 30 Mar 2026 09:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774863945;
	bh=7Er0tR6ixjiv9xTABi9G+WNwNdTiscNnW7jTLzlIDWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rW88w2i4507VDZm8IER3Zm5CmqsL7klL+C4yBdDyjkFkQfOc2oyfdNEVPr0k2FXdw
	 HlY9shqReT6I0sRkBqqbxCQHlYEqes291kiTvu+mOqgiW7PD6mx7ffTrEtv8CDaivH
	 tCjepHkLxAFqC0LXVE1szRpb/CJJ3enPJMmcw24CQZqp9bRXuu+caYz/QYzVX1pgs6
	 uJ5QXSVHfky+lXlsW7tuBJdUQQQ31X1KEO74h85EnHqb1WcyjefRLakGW90b0vErDU
	 4GnSxyTWQCmoIaF0QQiEKusxFtyWN2JqvWZWskGmEborZfLBVU+VLcnrjRxNbdbenN
	 cRMfDBgFn8MiA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v6 4/7] nvme-tcp: define host tcp_sockops struct
Date: Mon, 30 Mar 2026 17:43:29 +0800
Message-ID: <2900dc63a2313ed55b2e2a12cfe2f06853bd6411.1774862875.git.tanggeliang@kylinos.cn>
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

To add MPTCP support in "NVMe over TCP", the host side needs to pass
IPPROTO_MPTCP to sock_create_kern() instead of IPPROTO_TCP to create an
MPTCP socket.

Similar to the target-side nvmet_tcp_sockops, this patch defines the
host-side nvme_tcp_sockops structure, which contains the protocol of the
socket and a set of function pointers for socket operations. The only
difference is that it defines .set_syncnt instead of .set_reuseaddr.

A TCP-specific version of this structure is defined, and a sockops field is
added to nvme_tcp_ctrl. When the transport string is "tcp", it is assigned
to ctrl->sockops.

All locations that previously called TCP setsockopt functions are updated
to call the corresponding function pointers in the nvme_tcp_sockops
structure.

Cc: Hannes Reinecke <hare@suse.de>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 243dab830dc8..910c4186eb3b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -182,6 +182,15 @@ struct nvme_tcp_queue {
 	void (*write_space)(struct sock *);
 };
 
+struct nvme_tcp_sockops {
+	int			proto;
+	int (*set_syncnt)(struct sock *sk, int val);
+	void (*set_nodelay)(struct sock *sk);
+	void (*no_linger)(struct sock *sk);
+	void (*set_priority)(struct sock *sk, u32 priority);
+	void (*set_tos)(struct sock *sk, int val);
+};
+
 struct nvme_tcp_ctrl {
 	/* read only in the hot path */
 	struct nvme_tcp_queue	*queues;
@@ -198,6 +207,8 @@ struct nvme_tcp_ctrl {
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
+
+	struct nvme_tcp_sockops sockops;
 };
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
@@ -1785,7 +1796,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 	ret = sock_create_kern(current->nsproxy->net_ns,
 			ctrl->addr.ss_family, SOCK_STREAM,
-			IPPROTO_TCP, &queue->sock);
+			ctrl->sockops.proto, &queue->sock);
 	if (ret) {
 		dev_err(nctrl->device,
 			"failed to create socket: %d\n", ret);
@@ -1802,24 +1813,24 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	nvme_tcp_reclassify_socket(queue->sock);
 
 	/* Single syn retry */
-	tcp_sock_set_syncnt(queue->sock->sk, 1);
+	ctrl->sockops.set_syncnt(queue->sock->sk, 1);
 
 	/* Set TCP no delay */
-	tcp_sock_set_nodelay(queue->sock->sk);
+	ctrl->sockops.set_nodelay(queue->sock->sk);
 
 	/*
 	 * Cleanup whatever is sitting in the TCP transmit queue on socket
 	 * close. This is done to prevent stale data from being sent should
 	 * the network connection be restored before TCP times out.
 	 */
-	sock_no_linger(queue->sock->sk);
+	ctrl->sockops.no_linger(queue->sock->sk);
 
 	if (so_priority > 0)
-		sock_set_priority(queue->sock->sk, so_priority);
+		ctrl->sockops.set_priority(queue->sock->sk, so_priority);
 
 	/* Set socket type of service */
 	if (nctrl->opts->tos >= 0)
-		ip_sock_set_tos(queue->sock->sk, nctrl->opts->tos);
+		ctrl->sockops.set_tos(queue->sock->sk, nctrl->opts->tos);
 
 	/* Set 10 seconds timeout for icresp recvmsg */
 	queue->sock->sk->sk_rcvtimeo = 10 * HZ;
@@ -2886,6 +2897,15 @@ nvme_tcp_existing_controller(struct nvmf_ctrl_options *opts)
 	return found;
 }
 
+static const struct nvme_tcp_sockops nvme_tcp_sockops = {
+	.proto		= IPPROTO_TCP,
+	.set_syncnt	= tcp_sock_set_syncnt,
+	.set_nodelay	= tcp_sock_set_nodelay,
+	.no_linger	= sock_no_linger,
+	.set_priority	= sock_set_priority,
+	.set_tos	= ip_sock_set_tos,
+};
+
 static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
@@ -2960,6 +2980,13 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 	if (ret)
 		goto out_kfree_queues;
 
+	if (!strcmp(ctrl->ctrl.opts->transport, "tcp")) {
+		ctrl->sockops = nvme_tcp_sockops;
+	} else {
+		ret = -EINVAL;
+		goto out_kfree_queues;
+	}
+
 	return ctrl;
 out_kfree_queues:
 	kfree(ctrl->queues);
-- 
2.51.0

