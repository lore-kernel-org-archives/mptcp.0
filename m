Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58DF2597
	for <mptcp@lists.linux.dev>; Sun, 28 May 2023 16:37:08 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3f6094cb2ebso16374485e9.3
        for <mptcp@lists.linux.dev>; Sun, 28 May 2023 09:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685291826; x=1687883826;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PiQZoEyjbagDW3WakrVJF4X0zuK1GGXAfD2iJ4WHMLc=;
        b=x/lI2xMgm8guBebZcjaJDg4yVaFvFiVZFLlZhTg9PzXoOqqIlvuJN1KhmEP2cin87p
         p4jELGjazp3Lgc7C1PRTR04vvFHhNPqcITPphAnGvXE32k9EPKsgVF3rl6U35S3WTU7i
         79i4Juz9eImCQN8o+GQraoxtM5wUt2wDBZPLdvRI//Axd1DnBs2qqixkJR/tXY7QMEqM
         KK5ak4MFk3fCaK9whFanearyxOpDGu80jrOAQZ8CgnqhlF7oBS5OpmVUFBgmjCl0iPfs
         Sd0ZBmUhMOid5b7/fVZS/q64GFPZRVfY9Ry/4ONRYJPuLbFsENpNNFpjxXbcxM+NGjZi
         c+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685291826; x=1687883826;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PiQZoEyjbagDW3WakrVJF4X0zuK1GGXAfD2iJ4WHMLc=;
        b=h8EMN/cSiMdBszx2NDeVwcYZUAsT+TbQRyaUTYm30hRxOOLrXw7iFS5868dFnIuilj
         YaQKdPC5C4+DVMamBauT1ZvkaGEd0lf8VyjM8A1XNljUe3e/ChvgEmCM5UyzCDu1+0L0
         gBgpjz7M6sw/tC0NBAgq0i8UFtKl8inqQEQ78XKaHYZtiYEZ4bB4pDH+oIe5lxSgIjQS
         S68GAHqD+8kauDZbpPWG4tYVpbyUjA8jGgx/+GiYmnR4D2cAdiEK+Qd3W3vJdvVFJ4CH
         BXOcq3rjnQSF16wkMH437ZWG2tX7G72LNuCoWwfa6+vDH4wzNIrwkwpeh88BXnpvbLOi
         1f8g==
X-Gm-Message-State: AC+VfDx72aTAgym6LvVrnahGB2kqK4MCEtgYSLphe5ySuQMpEc2cNwcx
	sRff/o7nZds+UViNYOQFYn3ZUoFmswkStIFrSxE=
X-Google-Smtp-Source: ACHHUZ5fOEHvovuwmLlKI7QFLsJChxjP0EUGlChen5ao3Gp0mIHgSVBaUeaHLXLWA0bpjcCBGJmAVA==
X-Received: by 2002:a1c:7415:0:b0:3f5:fb97:eafe with SMTP id p21-20020a1c7415000000b003f5fb97eafemr7955420wmc.30.1685291826217;
        Sun, 28 May 2023 09:37:06 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:80da:cc14:918a:5418? ([2a02:578:8593:1200:80da:cc14:918a:5418])
        by smtp.gmail.com with ESMTPSA id c3-20020a05600c0ac300b003f50e88ffc1sm15316191wmr.0.2023.05.28.09.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 May 2023 09:37:05 -0700 (PDT)
Message-ID: <b707053e-013f-6c53-7dd8-d2245a82a7f8@tessares.net>
Date: Sun, 28 May 2023 18:37:04 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Squash to "selftests/bpf: Add bpf_rr scheduler": Tests Results
Content-Language: en-GB
To: mptcp@lists.linux.dev, Geliang Tang <geliang.tang@suse.com>
References: <ef47cf1485fc292a8f613c3f507dab8c6e7c7a65.1685191581.git.geliang.tang@suse.com>
 <3ea4474b-df97-b641-4f4e-fb24b84570cf@gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <3ea4474b-df97-b641-4f4e-fb24b84570cf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

Thank you for this new series.

On 27/05/2023 17:28, MPTCP CI wrote:
> Hi Geliang,
> 
> Thank you for your modifications, that's great!
> 
> Our CI did some validations and here is its report:
> 
> - KVM Validation: normal (except selftest_mptcp_join):
>   - Unstable: 1 failed test(s): selftest_simult_flows 🔴:
>   - Task: https://cirrus-ci.com/task/6601570566012928
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/6601570566012928/summary/summary.txt
> 
> - KVM Validation: normal (only selftest_mptcp_join):
>   - Success! ✅:
>   - Task: https://cirrus-ci.com/task/6707669310898176
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/6707669310898176/summary/summary.txt
> 
> - KVM Validation: debug (except selftest_mptcp_join):
>   - Unstable: 3 failed test(s): packetdrill_add_addr packetdrill_fastopen selftest_diag - Critical: 1 Call Trace(s) ❌:
>   - Task: https://cirrus-ci.com/task/5897883124236288
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/5897883124236288/summary/summary.txt
> 
> - KVM Validation: debug (only selftest_mptcp_join):
>   - Critical: 1 Call Trace(s) ❌:
>   - Task: https://cirrus-ci.com/task/5003560975335424
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/5003560975335424/summary/summary.txt

I guess you saw it but unfortunately it looks like the public CI
reported a `slab-use-after-free` in `__mptcp_close_ssk`
(`net/mptcp/protocol.c:2461`) with this series:

> + ./mptcp_join.sh
> # Created /tmp/tmp.FC1TzYQDFn (size 1 KB) containing data sent by client
> # Created /tmp/tmp.M8EVH4NZGj (size 1 KB) containing data sent by server
> [   63.584639][   T24] IPv6: ADDRCONF(NETDEV_CHANGE): ns2eth1: link becomes ready
> [   63.593396][   T24] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth1: link becomes ready
> [   66.013274][   T24] IPv6: ADDRCONF(NETDEV_CHANGE): ns2eth2: link becomes ready
> [   66.020623][   T24] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth2: link becomes ready
> [   68.388253][    T9] IPv6: ADDRCONF(NETDEV_CHANGE): ns2eth3: link becomes ready
> [   68.396729][    T9] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth3: link becomes ready
> [   70.754933][   T71] IPv6: ADDRCONF(NETDEV_CHANGE): ns2eth4: link becomes ready
> [   70.761723][   T71] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth4: link becomes ready
> [   74.549238][  T233 ]
> ==================================================================
> BUG: KASAN: slab-use-after-free in __mptcp_close_ssk (net/mptcp/protocol.c:2461) 
> Read of size 8 at addr ffff888007885388 by task mptcp_connect/233
> 
> CPU: 3 PID: 233 Comm: mptcp_connect Not tainted 6.4.0-rc3-gf83d4fc5e61e #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Call Trace:
>  <TASK>
> dump_stack_lvl (lib/dump_stack.c:107) 
> print_address_description.constprop.0 (mm/kasan/report.c:352) 
> print_report (mm/kasan/report.c:463) 
> ? kasan_addr_to_slab (arch/x86/include/asm/bitops.h:207) 
> ? __mptcp_close_ssk (net/mptcp/protocol.c:2461) 
> kasan_report (mm/kasan/report.c:574) 
> ? __mptcp_close_ssk (net/mptcp/protocol.c:2461) 
> __mptcp_close_ssk (net/mptcp/protocol.c:2461) 
> mptcp_destroy_common (net/mptcp/protocol.c:3313) 
> ? __kmem_cache_free (mm/slub.c:3786) 
> mptcp_destroy (include/net/sock.h:1471) 
> __mptcp_destroy_sock (net/mptcp/protocol.c:2977) 
> __mptcp_close (net/mptcp/protocol.c:3076) 
> ? __mptcp_unaccepted_force_close (net/mptcp/protocol.c:3012) 
> ? lockdep_hardirqs_on_prepare.part.0 (kernel/locking/lockdep.c:4273) 
> mptcp_close (net/mptcp/protocol.c:3091) 
> inet_release (net/ipv4/af_inet.c:427) 
> __sock_release (net/socket.c:654) 
> sock_close (net/socket.c:1399) 
> __fput (fs/file_table.c:321) 
> task_work_run (kernel/task_work.c:181 (discriminator 1)) 
> ? task_work_func_match (kernel/task_work.c:44) 
> ? task_work_cancel (kernel/task_work.c:147) 
> exit_to_user_mode_prepare (include/linux/resume_user_mode.h:49) 
> syscall_exit_to_user_mode (kernel/entry/common.c:130) 
> do_syscall_64 (arch/x86/entry/common.c:87) 
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
> RIP: 0033:0x7fb807331117
> Code: ff e8 2d 16 02 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 43 b9 f7 ff
> All code
> ========
>    0:	ff                   	(bad)  
>    1:	e8 2d 16 02 00       	call   0x21633
>    6:	66 2e 0f 1f 84 00 00 	cs nopw 0x0(%rax,%rax,1)
>    d:	00 00 00 
>   10:	0f 1f 00             	nopl   (%rax)
>   13:	f3 0f 1e fa          	endbr64 
>   17:	64 8b 04 25 18 00 00 	mov    %fs:0x18,%eax
>   1e:	00 
>   1f:	85 c0                	test   %eax,%eax
>   21:	75 10                	jne    0x33
>   23:	b8 03 00 00 00       	mov    $0x3,%eax
>   28:	0f 05                	syscall 
>   2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
>   30:	77 41                	ja     0x73
>   32:	c3                   	ret    
>   33:	48 83 ec 18          	sub    $0x18,%rsp
>   37:	89 7c 24 0c          	mov    %edi,0xc(%rsp)
>   3b:	e8 43 b9 f7 ff       	call   0xfffffffffff7b983
> 
> Code starting with the faulting instruction
> ===========================================
>    0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
>    6:	77 41                	ja     0x49
>    8:	c3                   	ret    
>    9:	48 83 ec 18          	sub    $0x18,%rsp
>    d:	89 7c 24 0c          	mov    %edi,0xc(%rsp)
>   11:	e8 43 b9 f7 ff       	call   0xfffffffffff7b959
> RSP: 002b:00007fff341972a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 00007fb807331117
> RDX: 0000000000000000 RSI: 00007fff34195260 RDI: 0000000000000004
> RBP: 0000000000000000 R08: 00000000050d5de2 R09: 00007fb807435280
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000004 R14: 00007fff34197460 R15: 00007fff34197360
>  </TASK>
> 
> Allocated by task 240:
> kasan_save_stack (mm/kasan/common.c:46) 
> kasan_set_track (mm/kasan/common.c:52) 
> __kasan_kmalloc (mm/kasan/common.c:384) 
> mptcp_init_sched (net/mptcp/sched.c:102) 
> mptcp_sk_clone_init (include/linux/instrumented.h:40 (discriminator 3)) 
> subflow_syn_recv_sock (net/mptcp/subflow.c:818) 
> tcp_check_req (net/ipv4/tcp_minisocks.c:809) 
> tcp_v4_rcv (net/ipv4/tcp_ipv4.c:2079) 
> ip_protocol_deliver_rcu (net/ipv4/ip_input.c:205) 
> ip_local_deliver_finish (include/linux/rcupdate.h:802) 
> ip_local_deliver (include/linux/netfilter.h:303) 
> ip_rcv (include/linux/netfilter.h:303) 
> __netif_receive_skb_one_core (net/core/dev.c:5484) 
> process_backlog (include/linux/rcupdate.h:802) 
> __napi_poll.constprop.0 (net/core/dev.c:6500) 
> net_rx_action (net/core/dev.c:6566) 
> __do_softirq (arch/x86/include/asm/jump_label.h:27) 
> 
> Freed by task 233:
> kasan_save_stack (mm/kasan/common.c:46) 
> kasan_set_track (mm/kasan/common.c:52) 
> kasan_save_free_info (mm/kasan/generic.c:523) 
> ____kasan_slab_free (mm/kasan/common.c:238) 
> slab_free_freelist_hook (mm/slub.c:1807) 
> __kmem_cache_free (mm/slub.c:3786) 
> mptcp_release_sched (net/mptcp/sched.c:124) 
> __mptcp_destroy_sock (net/mptcp/protocol.c:2975) 
> __mptcp_close (net/mptcp/protocol.c:3076) 
> mptcp_close (net/mptcp/protocol.c:3091) 
> inet_release (net/ipv4/af_inet.c:427) 
> __sock_release (net/socket.c:654) 
> sock_close (net/socket.c:1399) 
> __fput (fs/file_table.c:321) 
> task_work_run (kernel/task_work.c:181 (discriminator 1)) 
> exit_to_user_mode_prepare (include/linux/resume_user_mode.h:49) 
> syscall_exit_to_user_mode (kernel/entry/common.c:130) 
> do_syscall_64 (arch/x86/entry/common.c:87) 
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120) 
> 
> The buggy address belongs to the object at ffff888007885380
>  which belongs to the cache kmalloc-96 of size 96
> ==========================================

https://cirrus-ci.com/task/5003560975335424?logs=test#L7842-L7971

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
