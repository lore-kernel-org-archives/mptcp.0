Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8665204F60
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 11:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258926; cv=none; b=tk1imXQEax8r9uQyYjLWDjE8rfEPmnKd4sTU/bqB12uopW/p+xRuLMKaBR9i0A89To7sItmCDv2mggsQVD0D8NrU7oDrGNo6Lo5wjllHXGxrQYNqyXGkLWAT1pviyQc6ThSMEXwEEzO+wwKr/fYmvxT4Ho6pIbP+L/uHvwBx390=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258926; c=relaxed/simple;
	bh=nG64M2SPPhyUFylq3DssOJHpSurZvx669gC7n6OSwu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZUrxuZRE3WLupwjrFHT5wUQWH14Rk0HC7PjwEk3EttZMTtIt/2kJHDbL0YGH2Ns0MxVikoxRSKKo0tEsc+HfPDM522Dptk7Mf5XicFrFEDIeozqigNjTiT6+vToawlX4N3J3QeOa/T+Ke5uQMxALdYi2kkkWUvrex9gmWD2lp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIfbUPU4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIfbUPU4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D458C4CEE2;
	Thu,  6 Mar 2025 11:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741258926;
	bh=nG64M2SPPhyUFylq3DssOJHpSurZvx669gC7n6OSwu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NIfbUPU4ReJUUX5c5fJHb2Gp/UT8QVzsRrKtkuW/KDhmG+xgR1jhmL2DPvaGh0uhV
	 1UF9IZFoJPMSXoFWuwB8l0PWxHh4UC11xxWpaTWWw5u7gXdV3c/YpN3/w+7sSbN1Nj
	 hSk3YZbN2ptTAVTM7Yw6OOuLvtr6MDHh4+FefI0qpY6fgrOAmeWCsnN7x9iWlw9JRc
	 /Cl2ZNunOZwsLy7v6eNQfFQ6ciLOZppcBu77u/79gBSWR/zqp/pS3Fol3RKXWAue85
	 XB9mvT0qrGOp+R5+Qn4/h+ZzX50YiWbf+O9JnoMfqv+/Y+6uohvjTyTGsvetuIHH/A
	 H8II3Jfv2vLrg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 08/12] mptcp: pm: validate mandatory ops
Date: Thu,  6 Mar 2025 19:01:43 +0800
Message-ID: <40c12b3865d03d2a173d10538ea38f3b2c9745ca.1741258415.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741258415.git.tanggeliang@kylinos.cn>
References: <cover.1741258415.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a helper mptcp_pm_validate() to check whether required
ops are defined. It will be invoked in .validate of struct bpf_struct_ops.

Currently mandatory ops of mptcp_pm_ops are get_local_id and get_priority.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c       | 16 ++++++++++++++++
 net/mptcp/protocol.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 29bc903658f7..5d666b0891b3 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1045,8 +1045,24 @@ struct mptcp_pm_ops *mptcp_pm_find(const char *name)
 	return NULL;
 }
 
+int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops)
+{
+	if (!pm_ops->get_local_id || !pm_ops->get_priority) {
+		pr_err("%s does not implement required ops\n", pm_ops->name);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int mptcp_pm_register(struct mptcp_pm_ops *pm_ops)
 {
+	int ret;
+
+	ret = mptcp_pm_validate(pm_ops);
+	if (ret)
+		return ret;
+
 	spin_lock(&mptcp_pm_list_lock);
 	if (mptcp_pm_find(pm_ops->name)) {
 		spin_unlock(&mptcp_pm_list_lock);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d26e89d960a1..1ce6c22cb295 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1059,6 +1059,7 @@ extern struct mptcp_pm_ops mptcp_pm_kernel;
 struct mptcp_pm_ops *mptcp_pm_find(const char *name);
 int mptcp_pm_register(struct mptcp_pm_ops *pm_ops);
 void mptcp_pm_unregister(struct mptcp_pm_ops *pm_ops);
+int mptcp_pm_validate(struct mptcp_pm_ops *pm_ops);
 
 void mptcp_userspace_pm_free_local_addr_list(struct mptcp_sock *msk);
 
-- 
2.43.0

