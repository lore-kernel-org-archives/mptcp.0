Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4DD3BE628
	for <mptcp@lists.linux.dev>; Wed,  1 Jul 2026 07:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891472; cv=none; b=utVasz1GGLU2h9/DYw3lELZU21YqR2p3o+P0yGWGTeTN6JUL5aqB4QZ6Y1My2dXoqRuVp5fWd+NVg4ZY6xcwvRrRrn3gvnsVIeXJtZ32VI0mYrvagoE2pOVWbkd362PBDd+LEwxw38XwMSEv0xOcf1I2BwTLiQO1q2P6822W43w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891472; c=relaxed/simple;
	bh=XVU+PbldUk536hhHNXJus9FHG73lcwM6nQn5h/RCF68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EvQT3v4oL7AQA2AtNokA+BCe72LJNLDubIhcR28rf8M7SUS3X8CzhACoxFv5fkHlBS70YkzhlgX1NWbAuMh5Noyz9J4e7XYyIDaAz3aRCvK92rAi/AYgIY41VCVgaa2i5Mmq4NxkhoNApxbCtRtl6V+PR/oVWaouSNvdx7kQFYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qkajlFnR; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qkajlFnR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782891466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CguyfUlAmb9uU5S4XBAR2WzyGZGPcFySfhFKgdJYyQA=;
	b=qkajlFnRAMMF9oFChSezzk75+j+rhoZ86TyRuWFweb+thMiPyeTmJ/z1awJ2AxQjCwYuZT
	mlNVa7FXMXEYOkRLeKpR0Uwucj3M1jyc3mKG3dkHTOdgD0HrIiYgXAQx1VirAtHuSHGgDc
	dpnUVGZpzNtimj7Rg2cauEliqINBQDc=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	geliang@kernel.org,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v2] Squash-to "mptcp: pm: init and release mptcp_pm_ops"
Date: Wed,  1 Jul 2026 15:37:13 +0800
Message-ID: <20260701073713.197616-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Gang Yan <yangang@kylinos.cn>

This patch removes the need to handle a NULL pm_ops in the fallback
path, and moves the rcu_read_lock\unlock into mptcp_pm_ops_init.

Following sashiko's comments, it also moves the pr_debug() before
bpf_module_put() in mptcp_pm_ops_release.

Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/pm.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 9dc7b41fb562..5fe4276cf895 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1137,12 +1137,14 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 }
 
-static void mptcp_pm_ops_init(struct mptcp_sock *msk,
-			      struct mptcp_pm_ops *pm_ops)
+static void mptcp_pm_ops_init(struct mptcp_sock *msk, const char *pm_name)
 {
+	struct mptcp_pm_ops *pm_ops;
+
+	rcu_read_lock();
+	pm_ops = mptcp_pm_find(pm_name);
 	if (!pm_ops || !bpf_try_module_get(pm_ops, pm_ops->owner)) {
-		pr_warn_once("pm %s fails, fallback to default pm",
-			     pm_ops->name);
+		pr_warn_once("pm %s fails, fallback to default pm", pm_name);
 		pm_ops = &mptcp_pm_kernel;
 	}
 
@@ -1151,6 +1153,7 @@ static void mptcp_pm_ops_init(struct mptcp_sock *msk,
 		msk->pm.ops->init(msk);
 
 	pr_debug("pm %s initialized\n", pm_ops->name);
+	rcu_read_unlock();
 }
 
 static void mptcp_pm_ops_release(struct mptcp_sock *msk)
@@ -1161,9 +1164,9 @@ static void mptcp_pm_ops_release(struct mptcp_sock *msk)
 	if (pm_ops->release)
 		pm_ops->release(msk);
 
-	bpf_module_put(pm_ops, pm_ops->owner);
-
 	pr_debug("pm %s released\n", pm_ops->name);
+
+	bpf_module_put(pm_ops, pm_ops->owner);
 }
 
 void mptcp_pm_destroy(struct mptcp_sock *msk)
@@ -1184,9 +1187,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	pm->rm_list_rx.nr = 0;
 	WRITE_ONCE(pm->pm_type, pm_type);
 
-	rcu_read_lock();
-	mptcp_pm_ops_init(msk, mptcp_pm_find(pm_name));
-	rcu_read_unlock();
+	mptcp_pm_ops_init(msk, pm_name);
 }
 
 void mptcp_pm_data_init(struct mptcp_sock *msk)
-- 
2.43.0

