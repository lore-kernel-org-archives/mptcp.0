Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D143A4C77AA
	for <mptcp@lists.linux.dev>; Tue, 12 May 2026 10:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580485; cv=none; b=EQbGFasvX+0ETFkRVHL6SeVFb833SMIzwU3OOUs3bUijAq9jC0Ta35Tb6cUkpsV2wId5B6ZoQqhwbcrO6sl+GtOchG5eHf/R3NrYoLnRiyHUuac+I0fRxjqCLEVy+77XUx1CZiUNozbd9Ra3lxBxnvfPiNsm6YVzvBJ2y0c6BMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580485; c=relaxed/simple;
	bh=RZ/bBeX0iUYn5lI2es9VtQr9K+kApUpdxWnpel9mU+c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HTQyVNp1C3DKusQr4EAJVuNcXihts3GhTsDlob1GtrQeWwaE/pf0/0oUsZ6APKzAWZYUiNFrAiuHQoDVBhcTvE2Us24p6JEImmP3rOXmhwgQP+dMyVYDNDQkoLjcDz3ZMaDqrlMNmaIDas4NZffVPNP1Phb/wUa1ES+1/3p3WhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7dccdbdf5c2so6941656a34.3
        for <mptcp@lists.linux.dev>; Tue, 12 May 2026 03:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778580483; x=1779185283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bJXbmx1oVg5LK3fibdOuya8W9nsAxUoYlR408xm7E/c=;
        b=YB3hnspa3lDUf5dnZdt2rwKAftF6h407c+cEYbTxA5RHsOkRmw3kjnpN9Wu6SpWPea
         c8DDh/NMVOrJokL/pG9Z4Ge7KA3di6ABG73KcfhV+Dwnq0VTDj8+BtPfjj7zl/Gz/jLO
         orclgK5TVG5X/yEBJyCKTXxVo5V0Uaj0RWlzhqPKf86Bw7PV2LYeh9ZYKbi5Txtvo6DM
         XXZ0Vrq9U24eFsNai/yFYcNnZ8IdKnTqN3pv8x5xH4H4OIXmXQYiYbzWMmdQCeVXOxAN
         ZFLe968OraPxJCrkucMmOTsxE8MvcJAk+rpnu5XLuXvwyLk+eOBb/JBBh7hAT9seRY2m
         m0pA==
X-Forwarded-Encrypted: i=1; AFNElJ8pQt7yzLMxsNWfUwxyNgv3kJkxpbaH8l7COZezp/S9U4YmDNcreN+OF3Q6qnElx0nmt80szg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwBAsBntR411RFCt1TsBaUPLY/Uu88jSRvFVJCK39MxAxlmmSTf
	nCDLmvAUUxIZTblY8pwGqu8cjuAqd5YCAlv3AtMsbfozApdXwZDXnLyl7PFHJBOprHwG1K2XBKL
	rntKMSTPT/BzC3BrpIFAjhgPrjZcCtczqRiLFYMtXrXlt3a9yXWems159sIo=
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c0c2:20b0:69b:4bff:d0a9 with SMTP id
 006d021491bc7-69b4bffd90emr3707222eaf.44.1778580482795; Tue, 12 May 2026
 03:08:02 -0700 (PDT)
Date: Tue, 12 May 2026 03:08:02 -0700
In-Reply-To: <88d94464-9391-49f4-848f-f359b09b0500@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a02fc02.050a0220.12f528.0142.GAE@google.com>
Subject: Re: [syzbot] [mptcp?] KMSAN: uninit-value in mptcp_established_options
From: syzbot <syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com>
To: glider@google.com, kuniyu@google.com, linux-kernel@vger.kernel.org, 
	matttbe@kernel.org, mptcp@lists.linux.dev, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in irqentry_exit_to_kernel_mode_preempt

=====================================================
BUG: KMSAN: uninit-value in irqentry_exit_to_kernel_mode_preempt+0xb0/0xc0 include/linux/irq-entry-common.h:474
 irqentry_exit_to_kernel_mode_preempt+0xb0/0xc0 include/linux/irq-entry-common.h:474
 irqentry_exit_to_kernel_mode include/linux/irq-entry-common.h:549 [inline]
 irqentry_exit+0x7b/0x820 kernel/entry/common.c:164
 sysvec_apic_timer_interrupt+0x52/0x90 arch/x86/kernel/apic/apic.c:1061
 asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:697
 __msan_metadata_ptr_for_load_4+0x5/0x40 mm/kmsan/instrumentation.c:93
 tcp_rcv_established+0x19bb/0x3200 net/ipv4/tcp_input.c:6656
 tcp_v4_do_rcv+0xc5b/0x1b70 net/ipv4/tcp_ipv4.c:1851
 sk_backlog_rcv include/net/sock.h:1190 [inline]
 __release_sock+0x360/0x7d0 net/core/sock.c:3216
 release_sock+0x22d/0x300 net/core/sock.c:3815
 mptcp_subflow_shutdown+0x358/0x690 net/mptcp/protocol.c:3144
 mptcp_check_send_data_fin+0x31b/0x3d0 net/mptcp/protocol.c:3218
 __mptcp_wr_shutdown net/mptcp/protocol.c:3234 [inline]
 __mptcp_close+0x860/0x1360 net/mptcp/protocol.c:3313
 mptcp_close+0x42/0x260 net/mptcp/protocol.c:3367
 inet_release+0x1ee/0x2a0 net/ipv4/af_inet.c:442
 __sock_release net/socket.c:722 [inline]
 sock_close+0xd6/0x2f0 net/socket.c:1514
 __fput+0x60e/0x1010 fs/file_table.c:510
 ____fput+0x25/0x30 fs/file_table.c:538
 task_work_run+0x208/0x2b0 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0x306/0x1ea0 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x236/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable mp_opt created at:
 mptcp_incoming_options+0x11d/0x43b0 net/mptcp/options.c:1171
 tcp_data_queue+0x80/0x7c90 net/ipv4/tcp_input.c:5584

CPU: 0 UID: 0 PID: 10313 Comm: syz.0.1815 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
=====================================================


Tested on:

commit:         50897c95 Merge tag 'linux_kselftest-kunit-fixes-7.1-rc..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=121c20c8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9f364ffbbe4c1e9
dashboard link: https://syzkaller.appspot.com/bug?extid=ff020673c5e3d94d9478
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1555c7ce580000

