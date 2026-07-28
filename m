Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986723A7F48
	for <mptcp@lists.linux.dev>; Tue, 28 Jul 2026 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238824; cv=none; b=hW/xD5h5bPqn4hWdUA6KM9f/VY4Ellk6N3yMq+2JCrbkQ/zR8HeQfcPbLHGKHpTWYRengwAnonX3Ow6U3Zlwe4Do6yxo+FDlbS4HsDix2+xP+Ai9iPls0yYU2b3fKGBNQNAlTyjZ28LtOahe334KF0WFawTrMYkMVpKKrKM9nWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238824; c=relaxed/simple;
	bh=AjZ1WSulHSmj89YlRW2OgkXlmqRlw11HjQRD4f4M34Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poDXrz9ig69BPzzLe2NX6DKsETbVra30hjpYRJc1UfXaVc0v1iZJ0Jb3G9mlGGP14y5yvv0c8RLywSdP3rsCp4cslL/Sz1o/zGqUt463cRNUtzerDGrXP8dnkREZLQkB4d2D1yqUd+vJD7GZ3UziAlOpl8/oy17QsHNDevMeC+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMTbs44O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMTbs44O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156FB1F000E9;
	Tue, 28 Jul 2026 11:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785238823;
	bh=tIcG6b3HvL/2LQLJf2cMCuROBvCrA274D5Z+Qrjw5Ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aMTbs44OVaTvPAFL+J+6KFigLcWAT8AJ61ipFh9kYVAXHwbsYTZMjzZGW4S4vhikz
	 jgy58hPAjhHMw4gSlHp2oECX0TftRJHHVP5lzQzkeKlT5cpowlEUPsQnFPe0mE+FAf
	 gjKGLS3o9wAlpzj3osJEkqO2jbFq1Z5D9LPqNDU3LutMQKhCA0BBzfqmWflwM+E/x3
	 TGDLzWqSKoCSEYsHAh1tjbBukhA8d1MjAfQiUtvsQ1PBziUvx5f6ZIIBNCWqnJ66NK
	 rJAuyK4h/Qbl90KH3lBw2Ba0tGpqpVj1deLpsuBnngqf3msuK3qNXKbc2aNrCYlNeS
	 FfBvrXd9IhwnQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 6/9] nvme-tcp: support IPv6 traffic class
Date: Tue, 28 Jul 2026 19:39:39 +0800
Message-ID: <d039bbbdeeb369915c85fc8fd8b32dc052b5c3da.1785238723.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785238723.git.tanggeliang@kylinos.cn>
References: <cover.1785238723.git.tanggeliang@kylinos.cn>
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
 drivers/nvme/host/tcp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ba5c7b3e2a7c..a9bb1568d929 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1837,6 +1837,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	/* Set socket type of service */
 	if (nctrl->opts->tos >= 0)
 		ip_sock_set_tos(queue->sock->sk, nctrl->opts->tos);
+	if (nctrl->opts->tclass >= 0)
+		ip6_sock_set_tclass(queue->sock->sk, nctrl->opts->tclass);
 
 	/* Set 10 seconds timeout for icresp recvmsg */
 	queue->sock->sk->sk_rcvtimeo = 10 * HZ;
@@ -3041,7 +3043,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
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

