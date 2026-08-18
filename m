Received: from mta1.migadu.com (out-61.mta1.migadu.com [95.215.58.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DED43F4AA
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 09:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046537; cv=none; b=nT2MfHdceCuEScMyj3IdwGQZECJVAD9d6lX1rYGonoUjzLwsg0KYV74f/1uBO66OtqZ0SxIFl+ug1jKJUdrXqh2QzKW+jfZZoVcRWlc3WV+9gvlaUwO5MXCdQ7Tsw6wgWaLV1NaR+6PtVQE7A3owulX80t8c9f05MPPgJroUsSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046537; c=relaxed/simple;
	bh=NSdLMyuCUdqkBCf9KMVvSC32qRaTcLIIV7XjRyKfEl8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXUi9azN6Ph4r0VEAa7xMXPT+qJJ9wZ44QhYkaKw32i9tWkxA4TdDtasscqnfQ16dj84tGT4L/FI2qZPJN+JMfRk4CbDts/YoV+7Hpo6FNsoFIKcZisX2j5LqEI2hzUtXw8YRhGxuLXAGghTBA2agfJrix4k0CfApssxzmkdVgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Cei67Gh6; arc=none smtp.client-ip=95.215.58.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Cei67Gh6"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=NSdLMyuCUdqkBCf9KMVvSC32qRaTcLIIV7XjRyKfEl8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787046533; v=1; x=1787651333;
 b=Cei67Gh6vWijeuY1n8jG4rVleuDQm3u2Xvr7ocv5HPrFALhGU0ZfhFH17VSztMFFFc9O9p4O
 ODW8Xhl1kHPLW04QVOWvQIMaEJDrkNhM17LhN1H5WBM0s8zwq2wHnDJV+54BH2FOs3eC8atxk8N
 tduhuXXiDXrVo62yniuG7Zos=
X-Envelope-To: mptcp@lists.linux.dev
Received: from thinkbook16p.. (223.70.159.239)
	by smtp.migadu.com with ESMTPS id d1dccfa21b7bc23d;
	Tue, 18 Aug 2026 09:48:53 +0000
X-Migadu-Flow: FLOW_OUT
From: Gang Yan <gang.yan@linux.dev>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next v2 5/5] Squash to "bpf: Add mptcp packet scheduler struct_ops"
Date: Tue, 18 Aug 2026 17:48:25 +0800
Message-ID: <20260818094825.48446-6-gang.yan@linux.dev>
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

The pernet sysctl patches in this series swap the scheduler pointer
with xchg() without taking any module reference: this is fine while
ops can only be registered from built-in code.

This commit is what makes BPF schedulers registerable, i.e. the first
one whose ops can be unloaded while a pernet still stores them. Take
the reference accordingly:

  - mptcp_pernet_set_defaults() pins &mptcp_sched_default, mirroring
    tcp_sk_init() pinning &tcp_reno;
  - mptcp_set_scheduler() takes a reference on the new ops and
    releases the one held on the ops it replaces, mirroring
    tcp_set_default_congestion_control();
  - mptcp_net_exit() releases the last reference, mirroring
    tcp_sk_exit().

Assisted-by: Claude:GLM5.2
Co-developed-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
 net/mptcp/ctrl.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 32268aa26097..309bbb2a4eb0 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -123,7 +123,8 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 	pernet->stale_loss_cnt = 4;
 	pernet->pm_type = MPTCP_PM_TYPE_KERNEL;
 
-	RCU_INIT_POINTER(pernet->scheduler, &mptcp_sched_default);
+	if (bpf_try_module_get(&mptcp_sched_default, mptcp_sched_default.owner))
+		RCU_INIT_POINTER(pernet->scheduler, &mptcp_sched_default);
 
 	if (bpf_try_module_get(&mptcp_pm_kernel, mptcp_pm_kernel.owner))
 		RCU_INIT_POINTER(pernet->path_manager, &mptcp_pm_kernel);
@@ -134,15 +135,22 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 #ifdef CONFIG_SYSCTL
 static int mptcp_set_scheduler(struct mptcp_pernet *pernet, const char *name)
 {
-	struct mptcp_sched_ops *sched;
+	struct mptcp_sched_ops *sched, *prev;
 	int ret = 0;
 
 	rcu_read_lock();
 	sched = mptcp_sched_find(name);
-	if (sched)
-		xchg(&pernet->scheduler, sched);
-	else
+	if (sched) {
+		if (bpf_try_module_get(sched, sched->owner)) {
+			prev = xchg(&pernet->scheduler, sched);
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
@@ -603,10 +611,15 @@ static int __net_init mptcp_net_init(struct net *net)
 static void __net_exit mptcp_net_exit(struct net *net)
 {
 	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
+	struct mptcp_sched_ops *sched;
 	struct mptcp_pm_ops *pm;
 
 	mptcp_pernet_del_table(pernet);
 
+	sched = rcu_dereference_protected(pernet->scheduler, true);
+	if (sched)
+		bpf_module_put(sched, sched->owner);
+
 	pm = rcu_dereference_protected(pernet->path_manager, true);
 	if (pm)
 		bpf_module_put(pm, pm->owner);
-- 
2.43.0

