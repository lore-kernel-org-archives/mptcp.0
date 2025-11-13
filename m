Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98FF330306
	for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030129; cv=none; b=ir08VRDBQQ+ZfBOyDPEG17I7wiPVH8522Q5j9n0EZMn7hiLbJHcs1UpJf7c2sR4KX85XgHkFbVUfAP5mPfh1VVRBtAnUdvVYbqTjRrrH1bc/hGLY6mG2J2FhSvMfKFBl9H13N+7DP+8ZElHnph/IqyMftTKNYzMALiZ3EcMCBFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030129; c=relaxed/simple;
	bh=IgQgjGtFBP7AF+NZw7x3LDmSXHsIm8i+o+6jOICboEU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AJIvFgec8Fn3eyIUQFxLQWkLoxo1xyIKLWGKHItlT77lKU0929op64vh2ydiNJqlJ6QcZLimNqI7kuEZH4OgdFSJhSR10jOX0r6EhKpoGWOxBMlgp3SeD4ciZ6JFXXpaE0MDm6MiILSUoOl8gjxp3ZrxCwHIdu6wndBUlwkD/b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-43327c30cb1so7832265ab.2
        for <mptcp@lists.linux.dev>; Thu, 13 Nov 2025 02:35:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030127; x=1763634927;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FbdEWJA56FdSIhplP5wNxS54najxWArCAOLlDXVaQYE=;
        b=KKR/obA63gYclg+3QhRwwaqkVRAaM6V9w2+lmrcuX2fBcHImx821YmSVMWT/l04XUe
         e5kJXp7xwJhObATopem39rglBrd+i/Z2uCBN1tzKr8vIGBRdKRf0LRZGZqaXcNvAJxxs
         qgVIhgh4B+ZUvjnTTJ/ikO/ZqgXnrSH2u0mJBVuxr6sYjb0bVwJl/hI1z6CKKh8MTPvR
         NW86GMQv5yBcxe5qZNSZtTR50P3d3/e/kfaNgxNWIEiO1CPt9jNslfmSAAB3mPh/p751
         uABuezeUMioNfVPOisoAhiAdj7peR+AFIW74tJrU40U4Y4oUvEtJ6dt82pi0Q6kNli52
         a1Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVuLJN73BMmXQpdZHxA/TkpDkplrskcyrFgO3HVnX6YfbD5HKue1Hm/bq2K8DTS0O+fyULKww==@lists.linux.dev
X-Gm-Message-State: AOJu0YzSa6OmWB0Kmm/VrCf5r6EFdgvfu62BlfsnV4q9xqLKwCIE2qKH
	Ynn3IJiBH1SUtTWnG2oLU/KikRtMAc2AOH/tFpucCfRvZbdRJEi+gQVadrv4fTJiWMiuV1pyYs6
	BD1dBUZbqy3r+tynCXhT9TrdBnqyB9kA6CvdXfPB9LmEyPmI+jA1tg2lKfHE=
X-Google-Smtp-Source: AGHT+IHIMygvJ0QGQ9pVbXAgtD7mvDrcbNhKzdQ0GRQ2mpHNwLxpAeEclC0oGseOQWc80tJQtPOdoaXHj15IlmGI2ADMJxFqQqhq
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2194:b0:433:7673:1d with SMTP id
 e9e14a558f8ab-43473db48a9mr75823835ab.31.1763030127042; Thu, 13 Nov 2025
 02:35:27 -0800 (PST)
Date: Thu, 13 Nov 2025 02:35:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6915b46f.050a0220.3565dc.0028.GAE@google.com>
Subject: [syzbot] [mptcp?] WARNING: refcount bug in mptcp_schedule_work (2)
From: syzbot <syzbot+355158e7e301548a1424@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    24172e0d7990 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11da1c12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41ad820f608cb833
dashboard link: https://syzkaller.appspot.com/bug?extid=355158e7e301548a1424
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/38a395e6659a/disk-24172e0d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/23093acc54e6/vmlinux-24172e0d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ef12edc574bd/bzImage-24172e0d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+355158e7e301548a1424@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 0 PID: 16 at lib/refcount.c:25 refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:25
Modules linked in:
CPU: 0 UID: 0 PID: 16 Comm: ktimers/0 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:25
Code: 00 00 e8 79 5a 45 fd 5b 41 5e c3 cc cc cc cc cc e8 6b 5a 45 fd c6 05 3f 24 47 0a 01 90 48 c7 c7 80 2e 3d 8b e8 57 a1 09 fd 90 <0f> 0b 90 90 eb d7 e8 4b 5a 45 fd c6 05 20 24 47 0a 01 90 48 c7 c7
RSP: 0018:ffffc90000157830 EFLAGS: 00010246
RAX: 8853f029dd577500 RBX: 0000000000000002 RCX: ffff88801b2dda00
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000100
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000100
R10: dffffc0000000000 R11: ffffed101710487b R12: 1ffff9200002af18
R13: ffff88805cbc5e60 R14: ffff88805cbc5a80 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff888126df7000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ee13ff8 CR3: 0000000056192000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __refcount_add include/linux/refcount.h:-1 [inline]
 __refcount_inc include/linux/refcount.h:366 [inline]
 refcount_inc include/linux/refcount.h:383 [inline]
 sock_hold include/net/sock.h:816 [inline]
 mptcp_schedule_work+0x164/0x1a0 net/mptcp/protocol.c:943
 mptcp_tout_timer+0x21/0xa0 net/mptcp/protocol.c:2316
 call_timer_fn+0x17e/0x5f0 kernel/time/timer.c:1747
 expire_timers kernel/time/timer.c:1798 [inline]
 __run_timers kernel/time/timer.c:2372 [inline]
 __run_timer_base+0x648/0x970 kernel/time/timer.c:2384
 run_timer_base kernel/time/timer.c:2393 [inline]
 run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2403
 handle_softirqs+0x22f/0x710 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 run_ktimerd+0xcf/0x190 kernel/softirq.c:1138
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
