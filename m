Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A28918B463
	for <mptcp@lists.linux.dev>; Tue,  7 Jan 2025 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269790; cv=none; b=oJW4ySZJd0ULrk3eaZuNa3VBqC3INUohGuPY57+VB9ij7hDHrYj/0acDfAZfoh3wPbsXTCZk1w8JO3I7r1b94eWI92rzEZKlVr5j5tVT+hXYg1sfhMKV9x6U4Tsj6tlzKRfeXtd7wmEf0OLq3w2mdJy83ceoSvnTQvXSBPGhXyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269790; c=relaxed/simple;
	bh=kdyl867fMuPZoDrOImq5FUpYCNBMLD841FZqfsKL63w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DPwOXXGwnTyPjnxnKgMfXe1OFCg9tspGvgsozlJkAZG5Pv/zFueKC4enSkBxzY+bMAL2Ggbcp/RjMPYq6Rj9ediuwYcDKuSKXRd4ouNga7lKaC86xgzeS99R85nUBC1f8n2SXwoZq0B/7j8JLKTIP+AS/gNqLVyLlzpDWBKHUvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urMvjR+H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urMvjR+H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B816C4CEDD;
	Tue,  7 Jan 2025 17:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736269789;
	bh=kdyl867fMuPZoDrOImq5FUpYCNBMLD841FZqfsKL63w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=urMvjR+HSsTswg3INwYuDGSUFZBPcqSl9NbHvaFvSsJsGWrua0mewwAlNxQaizt17
	 pAZ8XoWNTHC96bWhJ0ORR3jsTwm5aPGUTWQMsf5ASeiTjNoV6fqh+zYbr2IlBeIPEE
	 TWmV+CzV5F3hBMeX0iYi21CZ5Ez2+gUjf8QzvHEhYFVCyq6BK9whuCo2gGWVmAazn1
	 wTHIJWAXrPAtt8t1vcFYDEUVom0vm7uf5jDfO2vPg+WUMPvDBUTm53SMnhWXczm1Bs
	 WnVirl4Lt2ZizR1jtxsmOw0Nny5XGlYxHZB1k/8TWxze1FL8MblPJykRb1Y23egSKy
	 lLvLH60pItfJw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 07 Jan 2025 18:09:26 +0100
Subject: [PATCH mptcp-net 2/9] mptcp: sysctl: sched: avoid using
 current->nsproxy
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-mptcp-sysfs-netns-v1-2-2fa7075d9970@kernel.org>
References: <20250107-mptcp-sysfs-netns-v1-0-2fa7075d9970@kernel.org>
In-Reply-To: <20250107-mptcp-sysfs-netns-v1-0-2fa7075d9970@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7947; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=kdyl867fMuPZoDrOImq5FUpYCNBMLD841FZqfsKL63w=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnfV/ahOlMZT+ToD4kOcKcc56wHknvUTILcI67C
 /Z4mKxVcTaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ31f2gAKCRD2t4JPQmmg
 c1IfD/9cR13nGiUGwH3W+EdGg2CbLLEDU+dXpwJLbhKpV1sKmNAYD0ZhldN4WHtM3HX88HFDaIC
 NpOvNRPtC224GVu6vCp3iO/cd2G5yo/oyOHCygFU8ySoz3f09YfevduMNshT7pb/ZKGSWlO84+6
 pojvVEgEdLV3DDZMvYxMsNuBCCktKihRAvZXOtkLHg7iHlF8tgLMmS7xbY3d9O/4HQz92ZcwQI0
 kcC4JzwuF49sdKUgZb0tAE1bL3B6s52nNwGb55glYupErhJtFKCkgSm1pCzmWvqtO4X73aq9K9e
 ZK26uc1fc14+Ph37aj2LLG7f5BJKxicucbwZ6lU6leUYismpRagVl4XCj3OpRgLk2uOhNFQhvbr
 TpLJqwVCyfKlN/MM3Fqvom+uhHc4hMKjJW6knlX6hqdsLC/c/0G+b3+ur+tjCsdlZ6ZoWHNGNfk
 aVZpClAoc0O+4uQWVGBSsysifwGOYqkFijbz6HsVlbqca+nVjTGAOPKKDt6q1ACVYoj/P4s7v3J
 pJ33dlxSUd15x5pQNYjKblRXMGKn+lLZujZJAf0jaBFL/dDZZDJIlsPYjfrZYIN7E9Wvie+a0c9
 kC/LzQoslzhMsb9azjHvN5Ysnd2e/Haa41xz+Y5pudnrD6mnjKbE3BsK0EHwqf6J8D6T8y35rwN
 lZ02NLHP2561TVw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Using the 'net' structure via 'current' is not recommended for different
reasons.

First, if the goal is to use it to read or write per-netns data, this is
inconsistent with how the "generic" sysctl entries are doing: directly
by only using pointers set to the table entry, e.g. table->data. Linked
to that, the per-netns data should always be obtained from the table
linked to the netns it had been created for, which may not coincide with
the reader's or writer's netns.

Another reason is that access to current->nsproxy->netns can oops if
attempted when current->nsproxy had been dropped when the current task
is exiting. This is what syzbot found, when using acct(2):

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN PTI
  KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
  CPU: 1 UID: 0 PID: 5924 Comm: syz-executor Not tainted 6.13.0-rc5-syzkaller-00004-gccb98ccef0e5 #0
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
  RIP: 0010:proc_scheduler+0xc6/0x3c0 net/mptcp/ctrl.c:125
  Code: 03 42 80 3c 38 00 0f 85 fe 02 00 00 4d 8b a4 24 08 09 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 cc 02 00 00 4d 8b 7c 24 28 48 8d 84 24 c8 00 00
  RSP: 0018:ffffc900034774e8 EFLAGS: 00010206

  RAX: dffffc0000000000 RBX: 1ffff9200068ee9e RCX: ffffc90003477620
  RDX: 0000000000000005 RSI: ffffffff8b08f91e RDI: 0000000000000028
  RBP: 0000000000000001 R08: ffffc90003477710 R09: 0000000000000040
  R10: 0000000000000040 R11: 00000000726f7475 R12: 0000000000000000
  R13: ffffc90003477620 R14: ffffc90003477710 R15: dffffc0000000000
  FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007fee3cd452d8 CR3: 000000007d116000 CR4: 00000000003526f0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   <TASK>
   proc_sys_call_handler+0x403/0x5d0 fs/proc/proc_sysctl.c:601
   __kernel_write_iter+0x318/0xa80 fs/read_write.c:612
   __kernel_write+0xf6/0x140 fs/read_write.c:632
   do_acct_process+0xcb0/0x14a0 kernel/acct.c:539
   acct_pin_kill+0x2d/0x100 kernel/acct.c:192
   pin_kill+0x194/0x7c0 fs/fs_pin.c:44
   mnt_pin_kill+0x61/0x1e0 fs/fs_pin.c:81
   cleanup_mnt+0x3ac/0x450 fs/namespace.c:1366
   task_work_run+0x14e/0x250 kernel/task_work.c:239
   exit_task_work include/linux/task_work.h:43 [inline]
   do_exit+0xad8/0x2d70 kernel/exit.c:938
   do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
   get_signal+0x2576/0x2610 kernel/signal.c:3017
   arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
   exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
   exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
   __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
   syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
   do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7fee3cb87a6a
  Code: Unable to access opcode bytes at 0x7fee3cb87a40.
  RSP: 002b:00007fffcccac688 EFLAGS: 00000202 ORIG_RAX: 0000000000000037
  RAX: 0000000000000000 RBX: 00007fffcccac710 RCX: 00007fee3cb87a6a
  RDX: 0000000000000041 RSI: 0000000000000000 RDI: 0000000000000003
  RBP: 0000000000000003 R08: 00007fffcccac6ac R09: 00007fffcccacac7
  R10: 00007fffcccac710 R11: 0000000000000202 R12: 00007fee3cd49500
  R13: 00007fffcccac6ac R14: 0000000000000000 R15: 00007fee3cd4b000
   </TASK>
  Modules linked in:
  ---[ end trace 0000000000000000 ]---
  RIP: 0010:proc_scheduler+0xc6/0x3c0 net/mptcp/ctrl.c:125
  Code: 03 42 80 3c 38 00 0f 85 fe 02 00 00 4d 8b a4 24 08 09 00 00 48 b8 00 00 00 00 00 fc ff df 49 8d 7c 24 28 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 cc 02 00 00 4d 8b 7c 24 28 48 8d 84 24 c8 00 00
  RSP: 0018:ffffc900034774e8 EFLAGS: 00010206
  RAX: dffffc0000000000 RBX: 1ffff9200068ee9e RCX: ffffc90003477620
  RDX: 0000000000000005 RSI: ffffffff8b08f91e RDI: 0000000000000028
  RBP: 0000000000000001 R08: ffffc90003477710 R09: 0000000000000040
  R10: 0000000000000040 R11: 00000000726f7475 R12: 0000000000000000
  R13: ffffc90003477620 R14: ffffc90003477710 R15: dffffc0000000000
  FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007fee3cd452d8 CR3: 000000007d116000 CR4: 00000000003526f0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  ----------------
  Code disassembly (best guess), 1 bytes skipped:
     0:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
     5:	0f 85 fe 02 00 00    	jne    0x309
     b:	4d 8b a4 24 08 09 00 	mov    0x908(%r12),%r12
    12:	00
    13:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
    1a:	fc ff df
    1d:	49 8d 7c 24 28       	lea    0x28(%r12),%rdi
    22:	48 89 fa             	mov    %rdi,%rdx
    25:	48 c1 ea 03          	shr    $0x3,%rdx
  * 29:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
    2d:	0f 85 cc 02 00 00    	jne    0x2ff
    33:	4d 8b 7c 24 28       	mov    0x28(%r12),%r15
    38:	48                   	rex.W
    39:	8d                   	.byte 0x8d
    3a:	84 24 c8             	test   %ah,(%rax,%rcx,8)

Here with 'net.mptcp.scheduler', the 'net' structure is not really
needed, because the table->data already has a pointer to the current
scheduler, the only thing needed from the per-netns data.
Simply use 'data', instead of getting (most of the time) the same thing,
but from a longer and indirect way.

Fixes: 6963c508fd7a ("mptcp: only allow set existing scheduler for net.mptcp.scheduler")
Reported-by: syzbot+e364f774c6f57f2c86d1@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/67769ecb.050a0220.3a8527.003f.GAE@google.com
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/ctrl.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index d9b57fab2a13e64b6c8585e821ed5212f59f8651..81c30aa02196d69c55799e5963f6591e416c8831 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -102,16 +102,15 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 }
 
 #ifdef CONFIG_SYSCTL
-static int mptcp_set_scheduler(const struct net *net, const char *name)
+static int mptcp_set_scheduler(char *scheduler, const char *name)
 {
-	struct mptcp_pernet *pernet = mptcp_get_pernet(net);
 	struct mptcp_sched_ops *sched;
 	int ret = 0;
 
 	rcu_read_lock();
 	sched = mptcp_sched_find(name);
 	if (sched)
-		strscpy(pernet->scheduler, name, MPTCP_SCHED_NAME_MAX);
+		strscpy(scheduler, name, MPTCP_SCHED_NAME_MAX);
 	else
 		ret = -ENOENT;
 	rcu_read_unlock();
@@ -122,7 +121,7 @@ static int mptcp_set_scheduler(const struct net *net, const char *name)
 static int proc_scheduler(const struct ctl_table *ctl, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	const struct net *net = current->nsproxy->net_ns;
+	char (*scheduler)[MPTCP_SCHED_NAME_MAX] = ctl->data;
 	char val[MPTCP_SCHED_NAME_MAX];
 	struct ctl_table tbl = {
 		.data = val,
@@ -130,11 +129,11 @@ static int proc_scheduler(const struct ctl_table *ctl, int write,
 	};
 	int ret;
 
-	strscpy(val, mptcp_get_scheduler(net), MPTCP_SCHED_NAME_MAX);
+	strscpy(val, *scheduler, MPTCP_SCHED_NAME_MAX);
 
 	ret = proc_dostring(&tbl, write, buffer, lenp, ppos);
 	if (write && ret == 0)
-		ret = mptcp_set_scheduler(net, val);
+		ret = mptcp_set_scheduler(*scheduler, val);
 
 	return ret;
 }

-- 
2.47.1

