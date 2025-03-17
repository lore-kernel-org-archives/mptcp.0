Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22901FAA
	for <mptcp@lists.linux.dev>; Mon, 17 Mar 2025 03:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742182179; cv=none; b=S23ormiftcr3A5U1dIDc05iNKImLXMI7jmoDUxUaqJ6mgHYV89JONmMwI/dlS7USBLSRhLnbqjLdFoyJ9lpevWUzzdDAdkxOoN39oa4jKQDFlx+meVO2yEXNOMfOaW/UbcAT2boi7LUMM6Hw2sd8cqTAacOfaMJboCTE04YGuB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742182179; c=relaxed/simple;
	bh=oT+Q0fCDbskubogdgnUfHfXCKhDMaKyX71+zz177ing=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cwaeYUmsb3zMKUtryE97SqoCliAQUV4tHWMyaFN+1Vh68xJ7/hANcjTvL9gfPy3GJ41gdIw/dWTnjCVremxTzMhWVnie3RyzH+vNmNay1z7sEDf88SZ4UmkJt8J+QRfTZpk/tqNuXibSJBR7WhBNCiUQKL27W112p4Sqx8dAnuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxtIPquF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxtIPquF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9FCC4CEED;
	Mon, 17 Mar 2025 03:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742182179;
	bh=oT+Q0fCDbskubogdgnUfHfXCKhDMaKyX71+zz177ing=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UxtIPquFCX0i1cwxQ8PgUX6pv/VCxYOuSILsVVjIS0yFWFtFouAaAVffxht0UvlVp
	 7lktNL7EZV+SYofXmeNjcDP7YvzntgSlwqoTPFdliD9r9FrOmsbFlqn0l8gj/NkGpZ
	 C18uIMqxYof706FmAY0rNZr1fhdwiEP5+Ju8f4IHd4tgpY3FPzHiqQRu2cRN4d3gcg
	 6HpXZLXqWAVFB6Gi3VFtpdfkOzYFrH3GlQWPvQsA2FvhaPEOyhenLSt2GZCLAzJbJD
	 vJ9m/UZvP8LGUpUmGX0+ZB76WywiUFmBCx2g2bwyNu/iL4pQpf/Gw+T2UV17urhJtQ
	 aildYGVExc0Tw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v1 1/3] Squash to "mptcp: pm: add subflow_established() interface"
Date: Mon, 17 Mar 2025 11:29:27 +0800
Message-ID: <fd999b67d8b2635e320a462805c65190362757f6.1742181977.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742181977.git.tanggeliang@kylinos.cn>
References: <cover.1742181977.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

.subflow_established can't be invoked under mptcp pm lock, otherwise
this error occurs:

TAP version 13
1..1
[   65.985960][   T10] BUG: sleeping function called from invalid context at net/core/sock.c:3723
[   65.986336][   T10] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 10, name: kworker/0:1
[   65.986630][   T10] preempt_count: 0, expected: 0
[   65.986964][   T10] RCU nest depth: 1, expected: 0
[   65.987157][   T10] 5 locks held by kworker/0:1/10:
[   65.987373][   T10]  #0: ffff888001134d48 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x7e4/0x16b0
[   65.987799][   T10]  #1: ffffc900000a7d30 ((work_completion)(&msk->work)){+.+.}-{0:0}, at: process_one_work+0xdf9/0x16b0
[   65.988348][   T10]  #2: ffff88800816d818 (sk_lock-AF_INET6){+.+.}-{0:0}, at: mptcp_worker+0x7b/0xad0
[   65.988806][   T10]  #3: ffffffffae584460 (rcu_read_lock){....}-{1:3}, at: __bpf_prog_enter+0x1f/0x170
[   65.989204][   T10]  #4: ffff888011042258 (k-sk_lock-AF_INET6#2){+.+.}-{0:0}, at: mptcp_pm_addr_send_ack+0x31d/0x3b0
[   65.989583][   T10] CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Tainted: G        W  OE      6.14.0-rc6+ #137
[   65.989606][   T10] Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[   65.989608][   T10] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[   65.989609][   T10] Workqueue: events mptcp_worker
[   65.989632][   T10] Call Trace:
[   65.989634][   T10]  <TASK>
[   65.989637][   T10]  dump_stack_lvl+0x9e/0xe0
[   65.989642][   T10]  __might_resched+0x35d/0x590
[   65.989665][   T10]  ? __pfx___might_resched+0x10/0x10
[   65.989676][   T10]  __lock_sock_fast+0x2f/0xd0
[   65.989682][   T10]  __mptcp_pm_send_ack+0x72/0x190
[   65.989684][   T10]  ? mptcp_pm_addr_send_ack+0x31d/0x3b0
[   65.989709][   T10]  mptcp_pm_addr_send_ack+0x31d/0x3b0
[   65.989714][   T10]  ? __pfx_mptcp_pm_addr_send_ack+0x10/0x10
[   65.989719][   T10]  ? mptcp_pm_announce_addr+0x2ef/0x410
[   65.989726][   T10]  mptcp_pm_create_subflow_or_signal_addr+0x75a/0xd10
[   65.989731][   T10]  ? hlock_class+0x4e/0x130
[   65.989739][   T10]  ? __pfx_mptcp_pm_create_subflow_or_signal_addr+0x10/0x10
[   65.989746][   T10]  ? __lock_acquire+0xb70/0x1650
[   65.989762][   T10]  ? lock_acquire.part.0+0xed/0x340
[   65.989766][   T10]  ? bpf_prog_66794828a779e50d_mptcp_pm_netlink_subflow_established+0x2e/0x43
[   65.989775][   T10]  ? __pfx_lock_acquire.part.0+0x10/0x10
[   65.989782][   T10]  ? do_raw_spin_lock+0x131/0x270
[   65.989787][   T10]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   65.989791][   T10]  ? lock_acquire+0x31/0xc0
[   65.989795][   T10]  ? bpf_prog_66794828a779e50d_mptcp_pm_netlink_subflow_established+0x2e/0x43
[   65.989806][   T10]  bpf_prog_66794828a779e50d_mptcp_pm_netlink_subflow_established+0x36/0x43
[   65.989811][   T10]  bpf__mptcp_pm_ops_subflow_established+0x47/0xa3
[   65.989818][   T10]  mptcp_pm_worker+0x221/0x4e0
[   65.989825][   T10]  mptcp_worker+0xcd/0xad0
[   65.989828][   T10]  ? __pfx_lock_acquire.part.0+0x10/0x10
[   65.989833][   T10]  ? trace_lock_acquire+0x14e/0x1e0
[   65.989836][   T10]  ? trace_lock_acquire+0x14e/0x1e0
[   65.989840][   T10]  ? __pfx_mptcp_worker+0x10/0x10
[   65.989845][   T10]  ? process_one_work+0xdf9/0x16b0
[   65.989848][   T10]  ? lock_acquire+0x31/0xc0
[   65.989850][   T10]  ? process_one_work+0xdf9/0x16b0
[   65.989860][   T10]  process_one_work+0xe43/0x16b0
[   65.989875][   T10]  ? __pfx_process_one_work+0x10/0x10
[   65.989888][   T10]  ? assign_work+0x16c/0x240
[   65.989898][   T10]  worker_thread+0x593/0xf90
[   65.989911][   T10]  ? __kthread_parkme+0xba/0x1e0
[   65.989915][   T10]  ? __pfx_worker_thread+0x10/0x10
[   65.989920][   T10]  ? __pfx_worker_thread+0x10/0x10
[   65.989924][   T10]  kthread+0x34f/0x5d0
[   65.989928][   T10]  ? __pfx_kthread+0x10/0x10
[   65.989938][   T10]  ? __pfx_kthread+0x10/0x10
[   65.989943][   T10]  ret_from_fork+0x31/0x70
[   65.989946][   T10]  ? __pfx_kthread+0x10/0x10
[   65.989949][   T10]  ret_from_fork_asm+0x1a/0x30
[   65.989969][   T10]  </TASK>
[   66.432902][ T1536] ip (1536) used greatest stack depth: 23384 bytes left

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm.c        | 2 ++
 net/mptcp/pm_kernel.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d504f9b31893..38abf15718b9 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -942,7 +942,9 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 	}
 	if (pm->status & BIT(MPTCP_PM_SUBFLOW_ESTABLISHED)) {
 		pm->status &= ~BIT(MPTCP_PM_SUBFLOW_ESTABLISHED);
+		spin_unlock_bh(&msk->pm.lock);
 		pm->ops->subflow_established(msk);
+		spin_lock_bh(&msk->pm.lock);
 	}
 	__mptcp_pm_kernel_worker(msk);
 
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index d04dd1cece09..0c78715ed87f 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -374,7 +374,9 @@ static void mptcp_pm_kernel_established(struct mptcp_sock *msk)
 
 static void mptcp_pm_kernel_subflow_established(struct mptcp_sock *msk)
 {
+	spin_lock_bh(&msk->pm.lock);
 	mptcp_pm_create_subflow_or_signal_addr(msk);
+	spin_unlock_bh(&msk->pm.lock);
 }
 
 /* Fill all the local addresses into the array addrs[],
-- 
2.43.0

