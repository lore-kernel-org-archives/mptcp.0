Received: from mta0.migadu.com (out-75.mta0.migadu.com [91.218.175.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC1A44C513
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046532; cv=none; b=potldTQ5hsMRfUODEBasal8+LP4zDEaywZi3yujEthYoJko7sZM/qlRTUxpdrDV98VZLYUHSlVLOobiTdjmf6Ys5woVW1s8AWAFN1m9jfutZCAsvA8DB270D8zZRcZkNPl+m5nzKQBN0t+uH+/dHGzBHFoSX6B/bUxTOcnFjYNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046532; c=relaxed/simple;
	bh=PCgQov3XvsNDfArAKr+YVccRtPp71eAPEDq75chPIho=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmHfvIZin2raL3bhbCzJYpuZZT9DmCFOzviL8AX9SiDD+fFibD4ZHBpB7O0Wqj034yvrp/rmpCfg3ETQ9l7gMxz84mlDXK0sToeOtZPpYD/L8TRRh4xaQn8oNqLX7GIsWL0tjI/RD4N/xXKsbcBPMCH3viyKq7O1YjmhmbxYnP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kzvlzRdb; arc=none smtp.client-ip=91.218.175.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kzvlzRdb"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=PCgQov3XvsNDfArAKr+YVccRtPp71eAPEDq75chPIho=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787046528; v=1; x=1787651328;
 b=kzvlzRdbP93jZcBCV6weXZXtuIzHfqoGNc1vxJurj/+b/DPwcDFvMq0ioTxiBldimqfRPB6b
 NeiwrnjIQIBN5Amfo9sy+bFAzOnzjW9CLHUt722iQ5gzVcWjp6EQvBKVZ4QNt8hH8ASzESfeKnR
 NeLKH6vPX+RfghWR/fv/Gqk8=
X-Envelope-To: mptcp@lists.linux.dev
Received: from thinkbook16p.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id 49beae16f087b2a2;
	Tue, 18 Aug 2026 09:48:48 +0000
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 4/5] Squash to "mptcp: pm: init and release mptcp_pm_ops"
Date: Tue, 18 Aug 2026 17:48:24 +0800
Message-ID: <20260818094825.48446-5-gang.yan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818094825.48446-1-gang.yan@linux.dev>
References: <20260818094825.48446-1-gang.yan@linux.dev>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

This commit introduces the mptcp_pm_ops lifetime handling on sockets
(mptcp_pm_ops_init/release taking a module reference), and would then
be the first one whose per-net path managers can be unloaded while a
pernet still stores them. Extend the same reference handling to the
pernet level:

  - mptcp_pernet_set_defaults() pins &mptcp_pm_kernel;
  - mptcp_set_path_manager() takes a reference on the new ops and
    releases the one held on the ops it replaces;
  - mptcp_net_exit() releases the last reference.

Depends on the sysctl patches earlier in this series.

Assisted-by: Claude:GLM5.2
Co-developed-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/ctrl.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 733706f06f1b..32268aa26097 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -124,7 +124,9 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 	pernet->pm_type = MPTCP_PM_TYPE_KERNEL;
 
 	RCU_INIT_POINTER(pernet->scheduler, &mptcp_sched_default);
-	RCU_INIT_POINTER(pernet->path_manager, &mptcp_pm_kernel);
+
+	if (bpf_try_module_get(&mptcp_pm_kernel, mptcp_pm_kernel.owner))
+		RCU_INIT_POINTER(pernet->path_manager, &mptcp_pm_kernel);
 
 	pernet->add_addr_v6_port_drop_ts = 1;
 }
@@ -208,15 +210,22 @@ static int proc_blackhole_detect_timeout(const struct ctl_table *table,
 
 static int mptcp_set_path_manager(struct mptcp_pernet *pernet, const char *name)
 {
-	struct mptcp_pm_ops *pm_ops;
+	struct mptcp_pm_ops *pm_ops, *prev;
 	int ret = 0;
 
 	rcu_read_lock();
 	pm_ops = mptcp_pm_find(name);
-	if (pm_ops)
-		xchg(&pernet->path_manager, pm_ops);
-	else
+	if (pm_ops) {
+		if (bpf_try_module_get(pm_ops, pm_ops->owner)) {
+			prev = xchg(&pernet->path_manager, pm_ops);
+			if (prev)
+				bpf_module_put(prev, prev->owner);
+		} else {
+			ret = -EBUSY;
+		}
+	} else {
 		ret = -ENOENT;
+	}
 	rcu_read_unlock();
 
 	return ret;
@@ -594,8 +603,13 @@ static int __net_init mptcp_net_init(struct net *net)
 static void __net_exit mptcp_net_exit(struct net *net)
 {
 	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
+	struct mptcp_pm_ops *pm;
 
 	mptcp_pernet_del_table(pernet);
+
+	pm = rcu_dereference_protected(pernet->path_manager, true);
+	if (pm)
+		bpf_module_put(pm, pm->owner);
 }
 
 static struct pernet_operations mptcp_pernet_ops = {
-- 
2.43.0

