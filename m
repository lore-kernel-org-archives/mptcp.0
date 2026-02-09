Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB681E2614
	for <mptcp@lists.linux.dev>; Mon,  9 Feb 2026 09:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770627881; cv=none; b=CdD4ImT0GKglMt6ghm/NsRikEjbQqtwv+QvRYNi/e1irIj//eSjoQkj5JQMmqw4rQ8C2GAjASvr3JDPHOY8WKNN48z1jVApCEa8Z32/GHXuKGDa2ejklimbyT0Zddn0EweCSJUJOnAXEdtwsc6ynrfnr8tLC/kZKdu9gpqo71g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770627881; c=relaxed/simple;
	bh=cBgIGIaEflD5zbb38kAq9jssbnmmvqbY+gJOlYv96Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjGgm/2Jx8YRMBgRoHWDdGzPLV71JhAaH3yM7O/CaHoOHYnBmGF9PEqTT2kTYe2cPcbpGSY9oRh6TK1aGxcnKWHotc4QvP1VQchn9Xfuj3zxP3iFbbrNdJp2WLzWTM62VcMZ0+E76TwFjGytt4RzDexUmz2Q2fkmmEvwo+Q/E4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALhuTP+l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALhuTP+l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B501C19424;
	Mon,  9 Feb 2026 09:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770627881;
	bh=cBgIGIaEflD5zbb38kAq9jssbnmmvqbY+gJOlYv96Ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ALhuTP+l3wuu7OJYSP+jn3f6reNXZBcANH2qUoYYCDeWHGHO6aBVWPGh7DGd3pLh2
	 PLszc3/mjC4alxFCf8hxzP0hUNwou7515jyd61cutKlpi6lhgqI65HdEsXz+f493L/
	 WzqPf5AbTDpCaWZZz6H6Rb/q+IDCkBr1vLaeJC3QXGlM1164Mb+4MJiDm9RRQUFiq0
	 gDSsLXJQjIIQcl26FPzYAUM08ey3LnILmiIOD4dLIs43miY2ggNQ/+a82/OD37cAee
	 K6XlxhXPRSHX8iOXrShqkfrNWNvCUPoeC4JkcbW8SGkP7R5QBENCg0RQ4C5QIbjRUM
	 b9sx7oA6oMyOw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v3 3/7] nvme-tcp: add mptcp support
Date: Mon,  9 Feb 2026 17:04:18 +0800
Message-ID: <069016b5f65def8677de09c4ce750ebad3ac1ca8.1770627071.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1770627071.git.tanggeliang@kylinos.cn>
References: <cover.1770627071.git.tanggeliang@kylinos.cn>
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

Cc: Hannes Reinecke <hare@suse.de>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 69cb04406b47..40d96a77618a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1766,6 +1766,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
+	int proto = IPPROTO_TCP;
 	int ret, rcv_pdu_size;
 	struct file *sock_file;
 
@@ -1782,9 +1783,14 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
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
@@ -3023,6 +3029,18 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
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
+			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE,
+	.create_ctrl	= nvme_tcp_create_ctrl,
+};
+
 static int __init nvme_tcp_init_module(void)
 {
 	unsigned int wq_flags = WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS;
@@ -3048,6 +3066,7 @@ static int __init nvme_tcp_init_module(void)
 		atomic_set(&nvme_tcp_cpu_queues[cpu], 0);
 
 	nvmf_register_transport(&nvme_tcp_transport);
+	nvmf_register_transport(&nvme_mptcp_transport);
 	return 0;
 }
 
@@ -3055,6 +3074,7 @@ static void __exit nvme_tcp_cleanup_module(void)
 {
 	struct nvme_tcp_ctrl *ctrl;
 
+	nvmf_unregister_transport(&nvme_mptcp_transport);
 	nvmf_unregister_transport(&nvme_tcp_transport);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
-- 
2.53.0

