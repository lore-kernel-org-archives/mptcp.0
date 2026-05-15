Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F2B43C06B
	for <mptcp@lists.linux.dev>; Fri, 15 May 2026 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838404; cv=none; b=YYSfbkfHFG3ERxm14XNF/w5dJFvj+uTTHpLPDQKFN8/xBhoIJr5wPvX90e+9uRLsbh0eBp4mLEN1C4hspyK2nn1QOZwAu1iYtL/R2GuBwooiN2L/hduBQTUXPJwJkIvxNeW49nmr8gK9m3XfYZlM6H9m+DGdhDfLIopTiEszRCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838404; c=relaxed/simple;
	bh=8HC3fDaEofGerA5yJHiBos5fwxdcuEiJ5kjHH/ADavY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCMUF1MML1YIaJ09/cXLy0VtJE4cGsx1Yh24lBO5uwXErO7ZXKAieHrjDuRfYt96OOdqiwjj+CmvG0tBN1bP+IAZyxDn3fc3bWvONBmUnXUoYy+OK0c8jQuC+R5Sf7dT+XgnG5aPtLsxZxShm0k2lodb70VaEGD0aCdXwEdjrn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmmvc///; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmmvc///"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A46C2BCB0;
	Fri, 15 May 2026 09:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778838404;
	bh=8HC3fDaEofGerA5yJHiBos5fwxdcuEiJ5kjHH/ADavY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmmvc///bDzMynIXIpQ3cUNMQXwsXQDLmbzKTap9J29JIXLrGDZoRi2OuFmeFiFnl
	 d/5UvNnQfhVstqP8/u4Xx7OSwTqQeUe5GeeTboq+jjskHj3XJYvhOkAhG47rZawk7Z
	 mPT2A3H8n+JsulUiv5zCeoQEdz0qzyW6Ct5hrpBNbnq5x207UpxB0a+qyBnW1z443D
	 XCv++fwKt00BUnL1U1EcA38HcT5lagBRncNES1YRxPexXWE4kiWeQrAg6Meuz7IlKx
	 chK7fSAm8+VfljUARsoHV5Jbmcc230z3BYrx5cX+8XcIUleOSdR9XGX1xs1Nl3ycak
	 12S3Xzv5gZE8Q==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v9 4/8] nvme-tcp: define host tcp_proto struct
Date: Fri, 15 May 2026 17:46:18 +0800
Message-ID: <78a9cac7438ad44ad2c670345279fb55529d1441.1778837549.git.tanggeliang@kylinos.cn>
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
structure.

The proto field points to a statically allocated nvme_tcp_proto structure
that is never freed, so no RCU protection is needed. The controller's
proto pointer is set during initialization and remains valid throughout
the controller's lifetime.

Cc: Hannes Reinecke <hare@suse.de>
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
index 15d36d6a728e..f54b1eb86940 100644
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
@@ -182,6 +183,16 @@ struct nvme_tcp_queue {
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
@@ -198,6 +209,8 @@ struct nvme_tcp_ctrl {
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
+
+	const struct nvme_tcp_proto *proto;
 };
 
 static LIST_HEAD(nvme_tcp_ctrl_list);
@@ -1799,7 +1812,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 
 	ret = sock_create_kern(current->nsproxy->net_ns,
 			ctrl->addr.ss_family, SOCK_STREAM,
-			IPPROTO_TCP, &queue->sock);
+			ctrl->proto->protocol, &queue->sock);
 	if (ret) {
 		dev_err(nctrl->device,
 			"failed to create socket: %d\n", ret);
@@ -1816,24 +1829,24 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
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
@@ -2900,6 +2913,16 @@ nvme_tcp_existing_controller(struct nvmf_ctrl_options *opts)
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

