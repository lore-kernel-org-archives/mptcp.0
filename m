Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F8220010A
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 02:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380071; cv=none; b=mQE5l2RLlHNJV4MTNTUxuxJpeD2Uqtx/zm4JKEuxj2QyoGIlOp4vpc10MDyXGmC86xvFNrSft5LlZzv9KlXhpio+Qj6z7+HsZK8G2bU7+xCmDFkgty/ByjoZjNe/YYN0BWdjf2qGE9PIsTVZzSUNERMwDcDWxJb9BVjTlHqnj+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380071; c=relaxed/simple;
	bh=dAwJbbhisv6c8gC2dzKTH4A5eovHKTrfWG2t/k3o9D0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJdtRfap13MHAbGLa8SvS8SmDv/F8/RQlWbukUCHjpO/0PqxaALIQ+2cCJS6bTx4Ey/QPI5FPxqK8mSOVCqI2xK87YyLodRNLR5BTZMG2RoxUmCzcYVGFr51iftCuANRr9xPCI3aqRXmlM9gFwFsyOmBuZpG/lYUhYyHQf5X+YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5g1qbrl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5g1qbrl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8368E1F00A3A;
	Thu, 30 Jul 2026 02:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785380070;
	bh=EcY26xIbpg9yQEhZyAIFjgmMcirRMjpwCQnvzov/sz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A5g1qbrlUFCWupztMslbFePX4AWCDmi3F0x1h7lPVWOs+C1l/+QSwKx7bsPre/RAv
	 CNs66Wpn8/+dLiFwGJrP+PpfCa8tAaWXBMhmIYfgRra/jggWaww2HGyDM08DGOOFuY
	 ZBFWQsJx3Q3zeqp7OqZADfMU8bouk+6tXJewfm2CxGRuj2hCLk8zQfvZcYoncI+HwQ
	 eXwKXnq1JdPC+VAs+lEoVNt7lbqV8GydTBeW27TqSRG5YHylgiMBlcXPEZj6s+ANOD
	 KQdOflC+XZGkvuS/JrRfVA/UC2n6WSFtP7S7OukO27q3gRKuG5toVvytN/W3plqv7z
	 81fopVDAgaS2A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 09/10] nvme-tcp: support IPv6 traffic class
Date: Thu, 30 Jul 2026 10:54:02 +0800
Message-ID: <938a9ae9f52e27a496db53948fc07138b9acfb3e.1785378180.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785378180.git.tanggeliang@kylinos.cn>
References: <cover.1785378180.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The fabrics layer now supports parsing the tclass option, but the
NVMe/TCP transport does not currently advertise or apply it.

Allow NVMe/TCP to use NVMF_OPT_TCLASS and set IPV6_TCLASS on each queue
socket when a traffic class is specified. Keep the existing IPv4 TOS
handling unchanged.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ba5c7b3e2a7c..cabbf67d24f8 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1837,6 +1837,11 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	/* Set socket type of service */
 	if (nctrl->opts->tos >= 0)
 		ip_sock_set_tos(queue->sock->sk, nctrl->opts->tos);
+#if IS_ENABLED(CONFIG_IPV6)
+	if (nctrl->opts->tclass >= 0 &&
+	    queue->sock->sk->sk_family == AF_INET6)
+		ip6_sock_set_tclass(queue->sock->sk, nctrl->opts->tclass);
+#endif
 
 	/* Set 10 seconds timeout for icresp recvmsg */
 	queue->sock->sk->sk_rcvtimeo = 10 * HZ;
@@ -3041,7 +3046,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
 			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
 			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
-			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS |
+			  NVMF_OPT_TOS | NVMF_OPT_TCLASS |
+			  NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS |
 			  NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY | NVMF_OPT_CONCAT,
 	.create_ctrl	= nvme_tcp_create_ctrl,
 };
-- 
2.53.0

