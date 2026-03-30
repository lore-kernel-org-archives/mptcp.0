Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48342609DC
	for <mptcp@lists.linux.dev>; Mon, 30 Mar 2026 09:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863950; cv=none; b=LZrMziDzNKKKWtnn32upwF5KGRB8n3Mhe2tM8BjNeAKGCdEAwx4ABaIvi/30yl+BzKyJao/iUYNr6pg5ODnVc61AiBix+wvIdTWE9tFIFhdRI+xRiQ9LtjH2v2nPfvDDes3Ab60lJE7QpL6nZT/VpWEkXnbwWYPxE+YczFf8vkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863950; c=relaxed/simple;
	bh=oTuHnBcqhcQab8zjFJAQBmyp/J1OIPvsUcVP3MqUafA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzhDLUAz/xfC118yz5wfVxUfu9wx1qToABp3UOXBpVZjLTgWI0/7sCbJ63bdg106dBLUi/1KC/JklL1OLAUprbnsUtfv0JVxiPzfW0LkINSRBQM9RqDhR2N9LtwjuXFnHt/D5Sb5K1PTUZZ3m3mGEzSiYW+UF3nEeCXACz+oZSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cR10CiNT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cR10CiNT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591E7C2BC9E;
	Mon, 30 Mar 2026 09:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774863950;
	bh=oTuHnBcqhcQab8zjFJAQBmyp/J1OIPvsUcVP3MqUafA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cR10CiNTzlny0WhwgIXzF0id99MWyq8Ec99xZae2Oy1pU8OcXjNt4br3YxQuKukkL
	 4yyjcq19Yql8KPzEyifECsHHeBq9Q112wpJdOii9nGWrV6FrTEV7uebcfbeEJXVSbl
	 BD/GGhk0YIJmUHRnL7g0NIY6GlEM9D+Rxdfxp/apWVEHyn4+9dlMdowGhVBEgA5V6r
	 G8CdGwQ/uu846asq4r23end1UsyDX8EfdC+kL7EndcJX/n4D8OJEK0paxWp2sNh3Du
	 5JFKQBwNXRbRtK564H7TcqQtJVcSNekpQSjyt55GxpsV047bk1P0Ad4hH+yaTYnPqy
	 RTfy0O1Tnr7Pg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v6 6/7] nvme-tcp: register host mptcp transport
Date: Mon, 30 Mar 2026 17:43:31 +0800
Message-ID: <af7efa6b35e633b4c423e6436530c4d650581bb5.1774862875.git.tanggeliang@kylinos.cn>
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

This patch defines a new nvmf_transport_ops named nvme_mptcp_transport,
which is almost the same as nvme_tcp_transport except .type and
.allowed_opts.

MPTCP currently does not support TLS. The four TLS-related options
(NVMF_OPT_TLS, NVMF_OPT_KEYRING, NVMF_OPT_TLS_KEY, and NVMF_OPT_CONCAT)
have been removed from allowed_opts. They will be added back once MPTCP
TLS is supported.

It is registered in nvme_tcp_init_module() and unregistered in
nvme_tcp_cleanup_module().

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
 drivers/nvme/host/tcp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index cf80f9354471..9231310d4a9b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -3063,6 +3063,18 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
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
@@ -3088,6 +3100,7 @@ static int __init nvme_tcp_init_module(void)
 		atomic_set(&nvme_tcp_cpu_queues[cpu], 0);
 
 	nvmf_register_transport(&nvme_tcp_transport);
+	nvmf_register_transport(&nvme_mptcp_transport);
 	return 0;
 }
 
@@ -3095,6 +3108,7 @@ static void __exit nvme_tcp_cleanup_module(void)
 {
 	struct nvme_tcp_ctrl *ctrl;
 
+	nvmf_unregister_transport(&nvme_mptcp_transport);
 	nvmf_unregister_transport(&nvme_tcp_transport);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
-- 
2.51.0

