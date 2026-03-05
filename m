Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7B829CE9
	for <mptcp@lists.linux.dev>; Thu,  5 Mar 2026 04:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772683552; cv=none; b=VMRUvz+sF9vRYfJmo/Nf2GM8tb7Udct0FYi2I2CcUDSsCjZcZrMAoByh9DY9x6wlCnT0YH2GpCWYexxLgCe/33yVAxH0fXyZVTypr4hRW78PJQc8FC6A2RA/MZVLMjZgVPBPo+xTn58wq3d9zfktlfwDInkOqv27RbKc5VkD5jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772683552; c=relaxed/simple;
	bh=8rOxL4vSeVBdS6+Z/LwLGxEQ3cFSgcTZVUdWvXjPsNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jjx0TQnp1OzmdegIg7ZslpT1Mf5rmIOIKVFaSQufs5POuJwPRurQfvF610rA8RiRxHfLyX0QTm+KkYrlj3jxWPbAFdq5jMuOMR7qbd3eKCHFIaGVf9riOxQOocCs7qQorEwFRyIFV5xwyIX6HOBxG6VcM4yZENbq0glj34XNGfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyEnMdqq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyEnMdqq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3E4C116C6;
	Thu,  5 Mar 2026 04:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772683551;
	bh=8rOxL4vSeVBdS6+Z/LwLGxEQ3cFSgcTZVUdWvXjPsNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KyEnMdqq74EyVzUAHWPWH76NbK7aHJQZDd0RBQtYYbJduwpvdrGBTCQ8k1da/QuA6
	 GWBaZkAg+fQtIoRHwK6UIhB4IE3tyVSJNyhnyk6owVgMv3XpjW7aLjorDACWRLRByO
	 Q++2dWYjUn28H1QdwRyQTucpHl4Q/X8T9OKRPuESy9urp08K9OlXmpIjCqiz1YGoYH
	 ZHSRhqXVVuJ6pQGT34VdfpKhdSk96Vtz9X7r81pQ1pjSdOiBPNk8acIU7WpPBHuRrk
	 /3NhFXl75VfT3HvEheFy7Dv/V07yG0/retgNWY8YcY1u5Kc3mh3sCGfzkwpJwtkbaO
	 +X1PvfMYtHlKA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	hare@suse.de
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v4 3/8] nvme-tcp: add mptcp support
Date: Thu,  5 Mar 2026 12:05:21 +0800
Message-ID: <21f43910f36f2911da95bd9fe768f7097a5f82a2.1772683110.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1772683110.git.tanggeliang@kylinos.cn>
References: <cover.1772683110.git.tanggeliang@kylinos.cn>
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
index 9ab3f61196a3..8446630cceca 100644
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
@@ -3022,6 +3028,18 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
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
@@ -3047,6 +3065,7 @@ static int __init nvme_tcp_init_module(void)
 		atomic_set(&nvme_tcp_cpu_queues[cpu], 0);
 
 	nvmf_register_transport(&nvme_tcp_transport);
+	nvmf_register_transport(&nvme_mptcp_transport);
 	return 0;
 }
 
@@ -3054,6 +3073,7 @@ static void __exit nvme_tcp_cleanup_module(void)
 {
 	struct nvme_tcp_ctrl *ctrl;
 
+	nvmf_unregister_transport(&nvme_mptcp_transport);
 	nvmf_unregister_transport(&nvme_tcp_transport);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
-- 
2.53.0

