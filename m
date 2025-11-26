Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCE1315D32
	for <mptcp@lists.linux.dev>; Wed, 26 Nov 2025 10:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153641; cv=none; b=Mcg4oaz2ERzpuUkRU4bOPQhOhufW1R9UquFzveMdAoCADFO9aVDFxkzpuZ/RUvrM13Td3qGw8TW9a1auetLqen/VUDWOhEjAyW/LlL3Ec0iIBUWl7jnTCF9Vwt5NlJK6Hb9zo/1kuK7iuf7/tV3Przg+b24vGnej9PV1gu1Auk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153641; c=relaxed/simple;
	bh=KYekCXu6h9LgasFVlG19fPW+uaPOT3kYPm5SImFbNXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tql5IC/rO1egIB1QMe9Rqmt3GtlxRT8WCU91WCVOVvGfHwxIbrVX0aiKfklahwINMhVmvZBmTF9qe1uHeSiILICSv+GkWczSxQMHOl1EXcpgcEJ2/wuvOST+P3wD6guTPz1vogVerkf3JMCJdDiaj6YCYalihRAhV92FpH/0NWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tlIpPUoy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tlIpPUoy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41880C113D0;
	Wed, 26 Nov 2025 10:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764153640;
	bh=KYekCXu6h9LgasFVlG19fPW+uaPOT3kYPm5SImFbNXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tlIpPUoyHTtKyDBPP5+pG2YQhLIs+aK2OngNPIw4PeXr6A+1RtLgA8clKd7x91iwj
	 GFn4sQYfz0ieO/S/hfQW/9i3r/RUp5mTq5kztkI5Sbha/lWfYq8zYDpJflG/atWbQH
	 aY5LMxnO8VrfMJCOVqCYgFefG1vmWeDv7kZkZ3E4497QZ3t/4F9mba0WKFtzs5x+lA
	 dJwLwTd+mu7q5QGzWGeay9t1Vze+/QFyTtq+2COqBqG5qa/E+zqt61h4TyrnWMojnC
	 SUmHsQPZV/85O01DvdHGrgTTQXrmhbhWDK8WQM/KuQzaCUKl32sJmZ9twR7XRKInRQ
	 1UWfKrDfUDZxw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	hare@suse.de,
	hare@kernel.org
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>
Subject: [RFC mptcp-next v2 6/7] nvme-tcp: add mptcp support
Date: Wed, 26 Nov 2025 18:40:03 +0800
Message-ID: <097198247ebe26f15e8e576715b756541aa135db.1764152990.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1764152990.git.tanggeliang@kylinos.cn>
References: <cover.1764152990.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch defines a new nvmf_transport_ops named nvme_mptcp_transport,
which is almost the same as nvme_tcp_transport except .type.

Check if opts->transport is "mptcp" in nvme_tcp_alloc_queue() to decide
whether to pass IPPROTO_MPTCP to sock_create_kern() to create a MPTCP
socket instead of a TCP one.

v2:
 - use 'trtype' instead of '--mptcp' (Hannes)

v3:
 - check mptcp protocol from opts->transport instead of passing a
parameter (Hannes).

v4:
 - check CONFIG_MPTCP.

Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 6795b8286c35..383e56ccc539 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -19,6 +19,7 @@
 #include <linux/blk-mq.h>
 #include <net/busy_poll.h>
 #include <trace/events/sock.h>
+#include <net/mptcp.h>
 
 #include "nvme.h"
 #include "fabrics.h"
@@ -1766,6 +1767,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
+	int proto = IPPROTO_TCP;
 	int ret, rcv_pdu_size;
 	struct file *sock_file;
 
@@ -1782,9 +1784,14 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		queue->cmnd_capsule_len = sizeof(struct nvme_command) +
 						NVME_TCP_ADMIN_CCSZ;
 
+#ifdef CONFIG_MPTCP
+	if (!strcmp(ctrl->ctrl.opts->transport, "mptcp"))
+		proto = IPPROTO_MPTCP;
+#endif
+
 	ret = sock_create_kern(current->nsproxy->net_ns,
 			ctrl->addr.ss_family, SOCK_STREAM,
-			IPPROTO_TCP, &queue->sock);
+			proto, &queue->sock);
 	if (ret) {
 		dev_err(nctrl->device,
 			"failed to create socket: %d\n", ret);
@@ -1801,9 +1808,13 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	nvme_tcp_reclassify_socket(queue->sock);
 
 	/* Single syn retry */
+	proto == IPPROTO_MPTCP ?
+	mptcp_sock_set_syncnt(queue->sock->sk, 1) :
 	tcp_sock_set_syncnt(queue->sock->sk, 1);
 
 	/* Set TCP no delay */
+	proto == IPPROTO_MPTCP ?
+	mptcp_sock_set_nodelay(queue->sock->sk) :
 	tcp_sock_set_nodelay(queue->sock->sk);
 
 	/*
@@ -3022,6 +3033,19 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 	.create_ctrl	= nvme_tcp_create_ctrl,
 };
 
+static struct nvmf_transport_ops nvme_mptcp_transport = {
+	.name		= "mptcp",
+	.module		= THIS_MODULE,
+	.required_opts	= NVMF_OPT_TRADDR,
+	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_RECONNECT_DELAY |
+			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
+			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
+			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
+			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS |
+			  NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY | NVMF_OPT_CONCAT,
+	.create_ctrl	= nvme_tcp_create_ctrl,
+};
+
 static int __init nvme_tcp_init_module(void)
 {
 	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
@@ -3047,6 +3071,7 @@ static int __init nvme_tcp_init_module(void)
 		atomic_set(&nvme_tcp_cpu_queues[cpu], 0);
 
 	nvmf_register_transport(&nvme_tcp_transport);
+	nvmf_register_transport(&nvme_mptcp_transport);
 	return 0;
 }
 
@@ -3054,6 +3079,7 @@ static void __exit nvme_tcp_cleanup_module(void)
 {
 	struct nvme_tcp_ctrl *ctrl;
 
+	nvmf_unregister_transport(&nvme_mptcp_transport);
 	nvmf_unregister_transport(&nvme_tcp_transport);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
-- 
2.51.0

