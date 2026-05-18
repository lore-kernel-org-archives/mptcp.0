Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2013FD14B
	for <mptcp@lists.linux.dev>; Mon, 18 May 2026 12:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106104; cv=none; b=RtFcruvedGJqcEsgzBaeA8HlhfV34GpcTHtGtbit2yopLP5dSbBpQb3YJckQ+XuCbp0o03GAz6G2IdLpQWRHVLU2JpQc0Kr6rz0GQa5NiQUQlwQubrjJqHM18p9klNHpBhz3wupSaEJJyPAmD4D4Fe5tWVO+96q0Qhi3R6CGCys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106104; c=relaxed/simple;
	bh=MCzYtqCuQY9Gbb37KYrhQLnVl9NjufkMifYjSb5DHIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jei2N6i1YtTu0NOTscfzHPdF6JE3OU83rN1s6xWaFrFeWysKquIwLAiRYuCue/cifBqxM1TK38ScBP/JqIXKoLDx6zB2XaRaU4Gf0xSya4smrnBo59ZvgWNPfJFO9ReLtLl9COm1oX9ZL14Cy95GicGaXMb3LGgbAHRzfjqTa6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAsHM3vn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAsHM3vn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344D4C2BCB7;
	Mon, 18 May 2026 12:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779106103;
	bh=MCzYtqCuQY9Gbb37KYrhQLnVl9NjufkMifYjSb5DHIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DAsHM3vnpZ8iE8KCgjFCsIXK4zN0YhvDqSylbCzr+B84Bvd6eALZvi+hT8VIygjnG
	 U4kITJDR49jWeZFi/QQ6AaQ8CM2I35x+ip6hb81di2/8tfuAdhuUDlx4xzCbuttbaM
	 OIPC3s1NYhIwh8POkTauYWfcSUUEMceHAG+y89aCohJBdwpU7br3k9QMp7kYIfsllh
	 xptSY/hy6Ck7aUzd3hHID8PQgwQ1sB7CrK343Mc+7K99FEvHhltk4wdFaYQXazHq3R
	 R5GKF8RlrZDlmihCuHA6uflfdNivVspP1n2bkm1HLxpmzkoKqrb2jRC7GQNU0iddjm
	 nAMJw0hFyCBcg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v13 12/12] nvme-tcp: wait for synchronous controller deletion on module unload
Date: Mon, 18 May 2026 20:07:37 +0800
Message-ID: <7ac2ed162f9a87c419af3ab042d6a6e65fee5e0b.1779104752.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779104752.git.tanggeliang@kylinos.cn>
References: <cover.1779104752.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Module unload can race with synchronous controller deletion via sysfs,
leading to use-after-free when the sysfs thread calls into unloaded
module code.

Fix by using nvme_delete_ctrl_sync() to wait for each controller deletion
to complete before unloading the module.

Cc: zhenwei pi <zhenwei.pi@linux.dev>
Cc: Hui Zhu <zhuhui@kylinos.cn>
Cc: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index eafe750a8be8..97678196204a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -3152,7 +3152,8 @@ static int __init nvme_tcp_init_module(void)
 
 static void __exit nvme_tcp_cleanup_module(void)
 {
-	struct nvme_tcp_ctrl *ctrl;
+	struct nvme_tcp_ctrl *ctrl, *tmp;
+	LIST_HEAD(ctrl_list);
 
 #ifdef CONFIG_MPTCP
 	nvmf_unregister_transport(&nvme_mptcp_transport);
@@ -3160,10 +3161,16 @@ static void __exit nvme_tcp_cleanup_module(void)
 	nvmf_unregister_transport(&nvme_tcp_transport);
 
 	mutex_lock(&nvme_tcp_ctrl_mutex);
-	list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list)
-		nvme_delete_ctrl(&ctrl->ctrl);
+	list_for_each_entry_safe(ctrl, tmp, &nvme_tcp_ctrl_list, list) {
+		nvme_get_ctrl(&ctrl->ctrl);
+		list_move(&ctrl->list, &ctrl_list);
+	}
 	mutex_unlock(&nvme_tcp_ctrl_mutex);
-	flush_workqueue(nvme_delete_wq);
+
+	list_for_each_entry_safe(ctrl, tmp, &ctrl_list, list) {
+		nvme_delete_ctrl_sync(&ctrl->ctrl);
+		nvme_put_ctrl(&ctrl->ctrl);
+	}
 
 	destroy_workqueue(nvme_tcp_wq);
 }
-- 
2.53.0

