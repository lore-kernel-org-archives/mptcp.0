Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F48037E2EB
	for <mptcp@lists.linux.dev>; Mon,  4 May 2026 18:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777918804; cv=none; b=G9U7C8Cx6BIez3e3ch/jNtX+JWFjaQx3J+hPiIDrGZ3PcVLbcPBX/E25nX/JK4Hmq5p8cfOE+g1RmyG71RMaxTPrb9dcH4rUreGHZ4xkGdV6u2DURIHRbIZLvJreh4e1T/grUuapl9NIyVTjPxc4Px++y4fZQvA8Nx4Rs5xd7Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777918804; c=relaxed/simple;
	bh=NvuBeBBzWo8uz4TCbv8Xsjo+TKqTGpJAck+SMkMDtoc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sIhdWZLiYle3tQE66uxlZG79e4NyqNrdIjn9mrBQBwGsTjJR+V98m7cXDHp4jWRmJ1QErAwLL7EBHllE7dFLqW9/ReGIdcyK/MkDDK96kjUz/TOAdAXAwysekCXBFsBGYgyFDhygUlMGdrioNAL9ET/X2HUImloG5R3moiwlwak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-696307c7ee0so5490962eaf.0
        for <mptcp@lists.linux.dev>; Mon, 04 May 2026 11:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777918802; x=1778523602;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M7g8wb1uur/zjSKRNhNOjliv4opR82CS6hmxJoMV2tE=;
        b=rBmz4GptlQQ2pfl5qXUpLhR7UCb9CTlpEJMORf045lAl92icIhWmYwo27I7w9irFIx
         Mo4ZoL8fZj/n1XO7CPbmI41NBMfPk01WEtu5Tn+wQdWpdFVVRl6ngJR9xgeasMt38xKy
         2uOVv9BI7bNd4GoatN2KhpDiljh4EdIlsel52UgzVVgoqobolkvklKptlN0WRJ58x/Z3
         sQAlwqOMeB9446hHrQNHheEGhhYFbtv77TF7jWb1brgBRTsODgMMf/3OQCDH7K7CnWTb
         X94uFXFn5HGy/3xq0JnZzmYvSEbapCJ3i5CcJYFBz4dVN2Y0USp9tNuga9+EwgU2CXYB
         aahQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Hh+LHKMw13nugsPnJYwqhPj9cwOdexhLSfghg4hQqxiMN0AOEkJS5037XkHaPD1J0HEWNkA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEG2DNSG4b5Y6u34Imof+gtxmNjIrPHC7zYQQ8l0XTCtdRgNIu
	ezrVttf8Ol3aH5+r4oE7fGp7jzIj9jg6WOtgWYXC6dcB/6llOjXSNUiLLQRzIpGk+uLgjOWrN4h
	jm10cdcOM+1T708fUoll8jlT73WWzug+LY9OUYrZtG2JedzkbI7xfcFwRGwQ=
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:178e:b0:67e:244a:7dd5 with SMTP id
 006d021491bc7-69697db7691mr5316600eaf.51.1777918802451; Mon, 04 May 2026
 11:20:02 -0700 (PDT)
Date: Mon, 04 May 2026 11:20:02 -0700
In-Reply-To: <024e0baa-a16a-4899-ad51-249868c1967b@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f8e352.170a0220.bb392.0005.GAE@google.com>
Subject: Re: [syzbot] [mptcp?] KMSAN: uninit-value in mptcp_established_options
From: syzbot <syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com>
To: kuniyu@google.com, linux-kernel@vger.kernel.org, matttbe@kernel.org, 
	mptcp@lists.linux.dev, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KMSAN: uninit-value in irqentry_exit_to_kernel_mode_preempt

=====================================================
BUG: KMSAN: uninit-value in irqentry_exit_to_kernel_mode_preempt+0xb0/0xc0 include/linux/irq-entry-common.h:472
 irqentry_exit_to_kernel_mode_preempt+0xb0/0xc0 include/linux/irq-entry-common.h:472
 irqentry_exit_to_kernel_mode include/linux/irq-entry-common.h:547 [inline]
 irqentry_exit+0x7b/0x760 kernel/entry/common.c:164
 sysvec_apic_timer_interrupt+0x52/0x90 arch/x86/kernel/apic/apic.c:1061
 asm_sysvec_apic_timer_interrupt+0x1f/0x30 arch/x86/include/asm/idtentry.h:697
 kmsan_get_metadata+0x17/0x160 mm/kmsan/shadow.c:125
 kmsan_get_shadow_origin_ptr+0x4a/0xb0 mm/kmsan/shadow.c:102
 get_shadow_origin_ptr mm/kmsan/instrumentation.c:38 [inline]
 __msan_metadata_ptr_for_load_4+0x24/0x40 mm/kmsan/instrumentation.c:93
 tcp_data_queue+0xdc/0x7c90 net/ipv4/tcp_input.c:5589
 tcp_rcv_established+0x19bb/0x3200 net/ipv4/tcp_input.c:6656
 tcp_v4_do_rcv+0xc4b/0x1b10 net/ipv4/tcp_ipv4.c:1852
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
 exit_to_user_mode_loop+0x306/0x1b60 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x236/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable mp_opt created at:
 mptcp_incoming_options+0x11d/0x43b0 net/mptcp/options.c:1171
 tcp_data_queue+0x80/0x7c90 net/ipv4/tcp_input.c:5584

CPU: 1 UID: 0 PID: 8009 Comm: syz.0.635 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
=====================================================


Tested on:

commit:         6d35786d Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10070d06580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c3f61154f3bb7e5
dashboard link: https://syzkaller.appspot.com/bug?extid=ff020673c5e3d94d9478
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13d0b96a580000

