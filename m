Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837D3372063
	for <mptcp@lists.linux.dev>; Thu,  2 Jul 2026 06:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782973830; cv=none; b=AxNWINsM4DdTiW9VDUy1yRSqbFTs7UPmobP8HcEsQbSpfSe2jUi9rX7hQR+usdLKFKe5LJIIkos8hV+d5bPsK6Lwt5VqlyW3k+Xr3esFwcZdR/97XXImBy/xUK/yIUjk6/CrhRiOcq3N1DbLrFU/z2Qt+5OnhSwuE3TAqdoRVLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782973830; c=relaxed/simple;
	bh=bZX7iAIMlp2yVtSKyZgmpen4+RQHQG338k/7iMEGaaI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V6tPPwtZAtRtptqf7j/9BfDl82Y/LADbyZd1pOJRC8eqll6sWA7XOHzsShzaBtn++vVW3ZkcDxptjwSvYObrtCH/xDA0/M1mOzMJwM1f1OB8AE0KOMzwNgJMM/04WgAd5oOh4HKh2tEthOc8Rm2Ryt3e4aiOHRfM+voSkz9AnRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cmVNrKaY; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cmVNrKaY"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782973825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2CyGOSjew59j+chx/NvPx+qw+mCWuePDNWIIY4v92AY=;
	b=cmVNrKaY0k+FIg5YxO7Ugi3Vi0Io2MtwIT6v45y6a/Gpk0b1kGC8RYILrA4WiVpM1sfc7U
	d8wzs+KOH6n18sW84YWAv4S5UxvqD1SbAM0/VizjcIJOZVM4ukHnqI1Z6OI2o10PY4GrNc
	GQJXRKOQC8YmScaVTLLTpXjMpsUoNvQ=
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Cc: Gang Yan <yangang@kylinos.cn>
Subject: [PATCH mptcp-next v3] Squash-to "mptcp: pm: init and release mptcp_pm_ops"
Date: Thu,  2 Jul 2026 14:30:02 +0800
Message-ID: <20260702063002.127027-1-gang.yan@linux.dev>
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
 net/mptcp/pm.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 9dc7b41fb562..033f783d4990 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -1137,12 +1137,13 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 	spin_unlock_bh(&msk->pm.lock);
 }
 
-static void mptcp_pm_ops_init(struct mptcp_sock *msk,
-			      struct mptcp_pm_ops *pm_ops)
+static void mptcp_pm_ops_init(struct mptcp_sock *msk, const char *pm_name)
 {
+	struct mptcp_pm_ops *pm_ops;
+
+	pm_ops = mptcp_pm_find(pm_name);
 	if (!pm_ops || !bpf_try_module_get(pm_ops, pm_ops->owner)) {
-		pr_warn_once("pm %s fails, fallback to default pm",
-			     pm_ops->name);
+		pr_warn_once("pm %s fails, fallback to default pm", pm_name);
 		pm_ops = &mptcp_pm_kernel;
 	}
 
@@ -1161,9 +1162,9 @@ static void mptcp_pm_ops_release(struct mptcp_sock *msk)
 	if (pm_ops->release)
 		pm_ops->release(msk);
 
-	bpf_module_put(pm_ops, pm_ops->owner);
-
 	pr_debug("pm %s released\n", pm_ops->name);
+
+	bpf_module_put(pm_ops, pm_ops->owner);
 }
 
 void mptcp_pm_destroy(struct mptcp_sock *msk)
@@ -1185,7 +1186,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk)
 	WRITE_ONCE(pm->pm_type, pm_type);
 
 	rcu_read_lock();
-	mptcp_pm_ops_init(msk, mptcp_pm_find(pm_name));
+	mptcp_pm_ops_init(msk, pm_name);
 	rcu_read_unlock();
 }
 
-- 
2.43.0

