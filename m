Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6300C7B
	for <mptcp@lists.linux.dev>; Tue, 13 Sep 2022 00:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663027301; x=1694563301;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WRbl4k3bd69O43nSMyoSyYnpUTeKGPeDxB2i+bfO+7w=;
  b=Lzuxr+IXtSWnZ4Df0ffOvOwJOvP/lvgRajBF37iPLzRTAsUBGJj60sHX
   Oi70NFjyRYOBABq8EcsNYYa3hk/1BtVFv0DAUkN75CGij3N8RbZGT4y9G
   xcD3UewlXLEcRBHFSAsrYNofNqWv/8dyzKNkNcYIb+71W8NBhWnQROCVU
   UkZcGPlZp5OZOJ799hs7bvnFVY77tNhGrIZOzfdRNjdiTnTWQ2LJNP+bo
   3s3Naqt292/5JQQuD027YugLtNiRAdKfJDjtR/b1Lwsf2+HqzrVDpVCiQ
   w8KDnZjwBVI+EiswWb4GHy2MFjTaEU58CDeNTnYto0pIYm7wLzlWFVi0W
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="285018703"
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="285018703"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 17:01:40 -0700
X-IronPort-AV: E=Sophos;i="5.93,311,1654585200"; 
   d="scan'208";a="618723881"
Received: from mvtrejo-mobl1.amr.corp.intel.com ([10.209.119.110])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 17:01:40 -0700
Date: Mon, 12 Sep 2022 17:01:39 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v11 0/5] BPF redundant scheduler
In-Reply-To: <cover.1662714028.git.geliang.tang@suse.com>
Message-ID: <a3095b2a-d4ae-d617-cc4a-16fe55cdab9b@linux.intel.com>
References: <cover.1662714028.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 9 Sep 2022, Geliang Tang wrote:

> v11:
> - address to Mat's comments in v10.
> - rebase to export/20220908T063452
>

Hi Geliang -

Thanks for the updates to this series.

I get slightly different kernel splats than the CI. For example, here's my 
kmsg output with the first test in mptcp_connect.sh:

[ 3102.670021] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth2: link becomes ready
[ 3102.885448] IPv6: ADDRCONF(NETDEV_CHANGE): ns2eth3: link becomes ready
[ 3103.112575] IPv6: ADDRCONF(NETDEV_CHANGE): ns3eth4: link becomes ready
[ 3103.463347] IPv6: ADDRCONF(NETDEV_CHANGE): ns2eth1: link becomes ready
[ 3107.580236] ------------[ cut here ]------------
[ 3107.581325] WARNING: CPU: 2 PID: 1112 at net/mptcp/protocol.c:1306 mptcp_sendmsg_frag (/home/mjmartin/work/mptcp-nn/net/mptcp/protocol.c:1306 (discriminator 1)) 
[ 3107.583192] Modules linked in:
[ 3107.585317] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-1.fc36 04/01/2014
[ 3107.587250] RIP: 0010:mptcp_sendmsg_frag (/home/mjmartin/work/mptcp-nn/net/mptcp/protocol.c:1306 (discriminator 1)) 
[ 3107.588421] Code: 0f 85 21 fd ff ff 48 c7 c2 a0 c1 1a 83 be 78 00 00 00 48 c7 c7 80 c7 1a 83 c6 05 9e 31 f2 01 01 e8 03 83 03 00 e9 fd fc ff ff <0f> 0b 0f b6 44 24 63 88 44 24 30 e9 dc f4 ff ff 8b 74 24 18 48 89
All code
========
    0:	0f 85 21 fd ff ff    	jne    0xfffffffffffffd27
    6:	48 c7 c2 a0 c1 1a 83 	mov    $0xffffffff831ac1a0,%rdx
    d:	be 78 00 00 00       	mov    $0x78,%esi
   12:	48 c7 c7 80 c7 1a 83 	mov    $0xffffffff831ac780,%rdi
   19:	c6 05 9e 31 f2 01 01 	movb   $0x1,0x1f2319e(%rip)        # 0x1f231be
   20:	e8 03 83 03 00       	call   0x38328
   25:	e9 fd fc ff ff       	jmp    0xfffffffffffffd27
   2a:*	0f 0b                	ud2    		<-- trapping instruction
   2c:	0f b6 44 24 63       	movzbl 0x63(%rsp),%eax
   31:	88 44 24 30          	mov    %al,0x30(%rsp)
   35:	e9 dc f4 ff ff       	jmp    0xfffffffffffff516
   3a:	8b 74 24 18          	mov    0x18(%rsp),%esi
   3e:	48                   	rex.W
   3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
    0:	0f 0b                	ud2
    2:	0f b6 44 24 63       	movzbl 0x63(%rsp),%eax
    7:	88 44 24 30          	mov    %al,0x30(%rsp)
    b:	e9 dc f4 ff ff       	jmp    0xfffffffffffff4ec
   10:	8b 74 24 18          	mov    0x18(%rsp),%esi
   14:	48                   	rex.W
   15:	89                   	.byte 0x89
[ 3107.592031] RSP: 0018:ffff888010f67910 EFLAGS: 00010202
[ 3107.593172] RAX: e585171f95821f87 RBX: ffff888113b04f00 RCX: ffffffff8260bb19
[ 3107.594458] RDX: 0000000000000001 RSI: ffffffff8260bac4 RDI: ffff88800fa84848
[ 3107.596326] RBP: e585171f95821f88 R08: 0000000000000000 R09: ffff88800fa848af
[ 3107.597665] R10: ffffed1001f50915 R11: 0000000000000000 R12: ffff888010f67a78
[ 3107.599903] R13: 0000000000000001 R14: ffff888107691800 R15: ffff8880357a0000
[ 3107.601366] FS:  00007f668bdb0740(0000) GS:ffff88811b100000(0000) knlGS:0000000000000000
[ 3107.603201] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3107.604495] CR2: 00007ffe77890328 CR3: 0000000115318005 CR4: 0000000000370ee0
[ 3107.606212] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 3107.607854] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 3107.610532] Call Trace:
[ 3107.611229]  <TASK>
[ 3107.611746] ? mptcp_init_sock (/home/mjmartin/work/mptcp-nn/net/mptcp/protocol.c:1230) 
[ 3107.612654] ? lockdep_hardirqs_on_prepare (/home/mjmartin/work/mptcp-nn/kernel/locking/lockdep.c:4252 /home/mjmartin/work/mptcp-nn/kernel/locking/lockdep.c:4319 
/home/mjmartin/work/mptcp-nn/kernel/locking/lockdep.c:4271) 
[ 3107.613890] ? __local_bh_enable_ip (/home/mjmartin/work/mptcp-nn/./arch/x86/include/asm/irqflags.h:45 /home/mjmartin/work/mptcp-nn/./arch/x86/include/asm/irqflags.h:80 
/home/mjmartin/work/mptcp-nn/kernel/softirq.c:401) 
[ 3107.614952] __mptcp_push_pending (/home/mjmartin/work/mptcp-nn/net/mptcp/protocol.c:1569) 
[ 3107.615948] ? mptcp_close (/home/mjmartin/work/mptcp-nn/net/mptcp/protocol.c:1532) 
[ 3107.616850] ? __sk_mem_raise_allocated (/home/mjmartin/work/mptcp-nn/net/core/sock.c:2810 /home/mjmartin/work/mptcp-nn/net/core/sock.c:2981) 
[ 3107.617982] ? copy_page_from_iter (/home/mjmartin/work/mptcp-nn/lib/iov_iter.c:751 /home/mjmartin/work/mptcp-nn/lib/iov_iter.c:738) 
[ 3107.618991] mptcp_sendmsg (/home/mjmartin/work/mptcp-nn/net/mptcp/protocol.c:1789) 
[ 3107.619896] ? __mptcp_push_pending (/home/mjmartin/work/mptcp-nn/net/mptcp/protocol.c:1682) 
[ 3107.621006] ? inet_send_prepare (/home/mjmartin/work/mptcp-nn/net/ipv4/af_inet.c:807) 
[ 3107.622087] ? inet_send_prepare (/home/mjmartin/work/mptcp-nn/net/ipv4/af_inet.c:816) 
[ 3107.623082] sock_sendmsg (/home/mjmartin/work/mptcp-nn/net/socket.c:717 /home/mjmartin/work/mptcp-nn/net/socket.c:734) 
[ 3107.624372] sock_write_iter (/home/mjmartin/work/mptcp-nn/net/socket.c:1109) 
[ 3107.625361] ? sock_sendmsg (/home/mjmartin/work/mptcp-nn/net/socket.c:1092) 
[ 3107.626261] ? file_has_perm (/home/mjmartin/work/mptcp-nn/security/selinux/hooks.c:1724) 
[ 3107.627185] ? selinux_file_permission (/home/mjmartin/work/mptcp-nn/security/selinux/hooks.c:3570 /home/mjmartin/work/mptcp-nn/security/selinux/hooks.c:3590) 
[ 3107.628345] vfs_write (/home/mjmartin/work/mptcp-nn/./include/linux/fs.h:2187 /home/mjmartin/work/mptcp-nn/fs/read_write.c:491 /home/mjmartin/work/mptcp-nn/fs/read_write.c:578) 
[ 3107.629171] ? __ia32_sys_pread64 (/home/mjmartin/work/mptcp-nn/fs/read_write.c:559) 
[ 3107.630159] ? bit_wait_io_timeout (/home/mjmartin/work/mptcp-nn/kernel/locking/mutex.c:902) 
[ 3107.631177] ? __fget_light (/home/mjmartin/work/mptcp-nn/fs/file.c:1007 (discriminator 1)) 
[ 3107.632005] ksys_write (/home/mjmartin/work/mptcp-nn/fs/read_write.c:631) 
[ 3107.632957] ? __ia32_sys_read (/home/mjmartin/work/mptcp-nn/fs/read_write.c:621) 
[ 3107.633859] ? lockdep_hardirqs_on_prepare (/home/mjmartin/work/mptcp-nn/kernel/locking/lockdep.c:466 /home/mjmartin/work/mptcp-nn/kernel/locking/lockdep.c:4320 
/home/mjmartin/work/mptcp-nn/kernel/locking/lockdep.c:4271) 
[ 3107.635041] ? syscall_enter_from_user_mode (/home/mjmartin/work/mptcp-nn/./arch/x86/include/asm/irqflags.h:45 /home/mjmartin/work/mptcp-nn/./arch/x86/include/asm/irqflags.h:80 
/home/mjmartin/work/mptcp-nn/kernel/entry/common.c:109) 
[ 3107.636398] do_syscall_64 (/home/mjmartin/work/mptcp-nn/arch/x86/entry/common.c:50 /home/mjmartin/work/mptcp-nn/arch/x86/entry/common.c:80) 
[ 3107.637254] entry_SYSCALL_64_after_hwframe (/home/mjmartin/work/mptcp-nn/arch/x86/entry/entry_64.S:120) 
[ 3107.638351] RIP: 0033:0x7f668beb48f7
[ 3107.639336] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
All code
========
    0:	0f 00                	(bad)
    2:	f7 d8                	neg    %eax
    4:	64 89 02             	mov    %eax,%fs:(%rdx)
    7:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
    e:	eb b7                	jmp    0xffffffffffffffc7
   10:	0f 1f 00             	nopl   (%rax)
   13:	f3 0f 1e fa          	endbr64
   17:	64 8b 04 25 18 00 00 	mov    %fs:0x18,%eax
   1e:	00
   1f:	85 c0                	test   %eax,%eax
   21:	75 10                	jne    0x33
   23:	b8 01 00 00 00       	mov    $0x1,%eax
   28:	0f 05                	syscall
   2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
   30:	77 51                	ja     0x83
   32:	c3                   	ret
   33:	48 83 ec 28          	sub    $0x28,%rsp
   37:	48 89 54 24 18       	mov    %rdx,0x18(%rsp)
   3c:	48                   	rex.W
   3d:	89                   	.byte 0x89
   3e:	74 24                	je     0x64

Code starting with the faulting instruction
===========================================
    0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
    6:	77 51                	ja     0x59
    8:	c3                   	ret
    9:	48 83 ec 28          	sub    $0x28,%rsp
    d:	48 89 54 24 18       	mov    %rdx,0x18(%rsp)
   12:	48                   	rex.W
   13:	89                   	.byte 0x89
   14:	74 24                	je     0x3a
[ 3107.643426] RSP: 002b:00007ffe778943c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[ 3107.645335] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f668beb48f7
[ 3107.647101] RDX: 0000000000002000 RSI: 00007ffe778943f0 RDI: 0000000000000003
[ 3107.648756] RBP: 0000000000000000 R08: 00007f668bfab214 R09: 00007f668bfab280
[ 3107.650320] R10: 00007f668bdba140 R11: 0000000000000246 R12: 0000000000001500
[ 3107.651883] R13: 0000000000002000 R14: 0000000000000000 R15: 0000000000002000
[ 3107.653497]  </TASK>
[ 3107.654005] irq event stamp: 17761
[ 3107.654780] hardirqs last enabled at (17773): __up_console_sem (/home/mjmartin/work/mptcp-nn/./arch/x86/include/asm/irqflags.h:45 (discriminator 1) /home/mjmartin/work/mptcp-nn/./arch/x86/include/asm/irqflags.h:80 
(discriminator 1) /home/mjmartin/work/mptcp-nn/./arch/x86/include/asm/irqflags.h:138 (discriminator 1) /home/mjmartin/work/mptcp-nn/kernel/printk/printk.c:264 (discriminator 1)) 
[ 3107.656996] hardirqs last disabled at (17788): __schedule (/home/mjmartin/work/mptcp-nn/kernel/sched/core.c:6393 (discriminator 1)) 
[ 3107.658933] softirqs last enabled at (17806): __irq_exit_rcu (/home/mjmartin/work/mptcp-nn/kernel/softirq.c:445 /home/mjmartin/work/mptcp-nn/kernel/softirq.c:650) 
[ 3107.660848] softirqs last disabled at (17819): __irq_exit_rcu (/home/mjmartin/work/mptcp-nn/kernel/softirq.c:445 /home/mjmartin/work/mptcp-nn/kernel/softirq.c:650) 
[ 3107.662940] ---[ end trace 0000000000000000 ]---


Do you see anything similar in your testing? This was on a 4-cpu VM for 
me.


Line 1306 of protocol.c that caused the splat is:

 		WARN_ON_ONCE(reuse_skb);

and it looks like that is expected to happen with a zero window and all 
data acked. Sounds like a condition that wasn't expected with previous 
schedulers (that only sent on one subflow at a time), but could happen 
with redundant schedulers when msk->snd_una is updated by another subflow.

If you can't reproduce this, let me know and I can investigate some more. 
It's reproducible on my system.

--
Mat Martineau
Intel
