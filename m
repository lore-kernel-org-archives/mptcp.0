Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C3E3ED128
	for <mptcp@lists.linux.dev>; Tue, 31 Mar 2026 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774952926; cv=none; b=bG6idNZ+rEKtT9X3jpzOFreH07ORu5CX4a+eufCgDgwyvPjqA2KvK+Y4mSYNdsEZlfLrfT1hDhozwNxCXS3MHaiYois9lZAJsfd8lK0dokxa1BVS0wFKIDGMqXGus+LC2XyutMFozr+I/nyH9N0Io/LsUHXjseUuwHRFL+OoG7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774952926; c=relaxed/simple;
	bh=WNGyQP0yiyg2l5WSpsWeNaSyG2Y9MPeEGVueFkXO1oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dgnSVS6pycyCn3TS0rVfsUar25lFy0bxCRM400npcg5dEbLERBotEL57lF/sJQOZcZou5CQpFXThL3I24QSlimO3lBsSDuTe/uuj5bECwdd24vuyJ7gvq+CiOkvplgR/qP94jnWuNt5KL4aZSZtiSHc5ZzOM+LhwmDSgWFD2YLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcIDfIcI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcIDfIcI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E66C19423;
	Tue, 31 Mar 2026 10:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774952926;
	bh=WNGyQP0yiyg2l5WSpsWeNaSyG2Y9MPeEGVueFkXO1oI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TcIDfIcId1xmft2B374wNaSca98OorjLA9SIEUj6M7aNV8pM81fFRpwNw1nmTfac1
	 b507keFFeGdg+J3s6C7Szp8Ypi69NZSxBeYZp5cUnvi0HRsI2cPKAH7RUabmong77e
	 kumWSzqjx1asixiYqX2prrgC6n/QZM4ECBhi8jIsDRhgVd8ugtkdsS/Zcocm8T9Pyo
	 Ot93KwIgyKHSpicArZ3dEljh+d88WXcVHWdARj6IeaQ+GitEx7UJe+VTsY8PV3JkZ0
	 IJgLIeCACCkagsDw+WSxbT9I1WKlS3ReWpjXer1HXckkOw6uJvc6YOorvGotwSQLsP
	 gYcIYnq28xxhw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v7 4/7] nvme-tcp: define host tcp_sockops struct
Date: Tue, 31 Mar 2026 18:28:28 +0800
Message-ID: <c4d56a2f61b36ee68f88675c667dee89eaa252c0.1774952107.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1774952107.git.tanggeliang@kylinos.cn>
References: <cover.1774952107.git.tanggeliang@kylinos.cn>
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
index 243dab830dc8..1f45f388b9c1 100644
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
+	const struct nvme_tcp_sockops *sockops;
 };
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
@@ -1785,7 +1796,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 	ret = sock_create_kern(current->nsproxy->net_ns,
 			ctrl->addr.ss_family, SOCK_STREAM,
-			IPPROTO_TCP, &queue->sock);
+			ctrl->sockops->proto, &queue->sock);
 	if (ret) {
 		dev_err(nctrl->device,
 			"failed to create socket: %d\n", ret);
@@ -1802,24 +1813,24 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	nvme_tcp_reclassify_socket(queue->sock);
 
 	/* Single syn retry */
-	tcp_sock_set_syncnt(queue->sock->sk, 1);
+	ctrl->sockops->set_syncnt(queue->sock->sk, 1);
 
 	/* Set TCP no delay */
-	tcp_sock_set_nodelay(queue->sock->sk);
+	ctrl->sockops->set_nodelay(queue->sock->sk);
 
 	/*
 	 * Cleanup whatever is sitting in the TCP transmit queue on socket
 	 * close. This is done to prevent stale data from being sent should
 	 * the network connection be restored before TCP times out.
 	 */
-	sock_no_linger(queue->sock->sk);
+	ctrl->sockops->no_linger(queue->sock->sk);
 
 	if (so_priority > 0)
-		sock_set_priority(queue->sock->sk, so_priority);
+		ctrl->sockops->set_priority(queue->sock->sk, so_priority);
 
 	/* Set socket type of service */
 	if (nctrl->opts->tos >= 0)
-		ip_sock_set_tos(queue->sock->sk, nctrl->opts->tos);
+		ctrl->sockops->set_tos(queue->sock->sk, nctrl->opts->tos);
 
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
@@ -2950,6 +2970,13 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		goto out_free_ctrl;
 	}
 
+	if (!strcmp(ctrl->ctrl.opts->transport, "tcp")) {
+		ctrl->sockops = &nvme_tcp_sockops;
+	} else {
+		ret = -EINVAL;
+		goto out_free_ctrl;
+	}
+
 	ctrl->queues = kzalloc_objs(*ctrl->queues, ctrl->ctrl.queue_count);
 	if (!ctrl->queues) {
 		ret = -ENOMEM;
-- 
2.51.0

