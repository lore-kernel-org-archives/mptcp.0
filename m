Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22CD3537ED
	for <mptcp@lists.linux.dev>; Mon, 25 May 2026 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779701640; cv=none; b=KvV1CYNpnkD/XxpZ+GtiKEsmxTqQGmDATR20/+T/dHcazkL64ILKbI4FiTHx9LF57Hvk8BNz/xDxFO0Kc8glVqZAVlGHwlWO7EXmdSGuSm+EVunIpQSWNozDDH9IYZzmu16NKvAgQVQEjscFG16lIO5/ABbKFJE65N6CCvpt3dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779701640; c=relaxed/simple;
	bh=G3OApdTCjuOewvHSYGBUUDZYzD7d0WKMs9vTBUKKWpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yo51sWivbMopAlkS96sW70hG+7BQNnQhyjSc3Co8A8ECQ67mIknW8pXPcr6OljduVuiZGvjWE5DczcdIQSjLMwqzzFeo98arp58+5gmpxbJZFnmcR83t8EvTiBwpfOc4bbJAqJvD4gSLWc8/hsDNPGWnUZBt3DK8iWfUBJvVasU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Slrcxq8J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Slrcxq8J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169F01F00A3A;
	Mon, 25 May 2026 09:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779701639;
	bh=9E98rJDebtkrmniVOv6GhgzET2aDoHLnpUSZmwh9LEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Slrcxq8JvZh5lGd8topxtIr9o19Cz5cq3jR0AjQOuGQ31qQfMGqJ0aJi2jZdbtdQY
	 ry7a3sSDFI/Z8mH0NfW7dG/kQRZBkeBKkiNYZPd7raPDFyOwm9Kn7mJ5zMNmq8n+CG
	 9deIzdu0oZcH5LeXdJTpzZ0zmJAfM0VQL7mh2GMVIddPBxqHVrHtMu7BzPs2G+ywS5
	 IhRaB7X8/muCvGO2rm25AY98AXqgqpbt4bAnJ6tiefTNk0x4ESILJNJN5PEfQ3UOBo
	 c4IRmeZCL5fmQ3F/XePSRsa4e93YAw44Z7VC2xZZtz/qR3jLxOMqnTtb/61y4Yvidz
	 2h/9iiBUN2now==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Hannes Reinecke <hare@suse.de>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v17 09/14] nvme-fabrics: compare transport in ip_options_match
Date: Mon, 25 May 2026 17:33:04 +0800
Message-ID: <37a0840daaf0668b42c86f975a91edb554d3f3a5.1779701391.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779701391.git.tanggeliang@kylinos.cn>
References: <cover.1779701391.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

When checking for an existing controller, nvmf_ip_options_match() does
not compare the transport type. This can cause a TCP connection request
to incorrectly match an existing MPTCP controller, or an MPTCP connection
request to match an existing TCP controller, resulting in a false
-EALREADY error.

Fix this by adding strcmp(opts->transport, ctrl->opts->transport) to the
matching condition.

Cc: Hannes Reinecke <hare@suse.de>
Cc: zhenwei pi <zhenwei.pi@linux.dev>
Cc: Hui Zhu <zhuhui@kylinos.cn>
Cc: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/fabrics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ac3d4f400601..e086e61e8f94 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1220,6 +1220,7 @@ bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
 		struct nvmf_ctrl_options *opts)
 {
 	if (!nvmf_ctlr_matches_baseopts(ctrl, opts) ||
+	    strcmp(opts->transport, ctrl->opts->transport) ||
 	    strcmp(opts->traddr, ctrl->opts->traddr) ||
 	    strcmp(opts->trsvcid, ctrl->opts->trsvcid))
 		return false;
-- 
2.53.0

