Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC83355F42
	for <mptcp@lists.linux.dev>; Wed, 20 May 2026 11:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779278138; cv=none; b=Vbo/TqunutSG4YB1PMdDeqH2nFreo0JsXr8vs6tU612fkb9udEUFkg7Sl4chLaN9Ti97ZdKNOkxvKyCj+Hs/3XHivc8PACuUJGgybbpBkH2jVUySr67C9tQLNANgBO+dQPML76VEsIj2ro6WoWBeSLgFNDbSlvArDZwb4yMJG4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779278138; c=relaxed/simple;
	bh=hje88MKRm504VTdbSlvpEtbK/6SzAqPKYbeaWtiQV9I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cwDrDpoxyY95CxGA1xLMUta2LHgVh2Kx9J1uDPD1GrjC0QaPGQK2aZWrDzGUGFscq4iokqeshIjZmmdQ9+tr3I8pYuaAzBvOHjjbLE1aGEL9PPpBrkN522wqC4VczWHrFwO7n16wwG07srobW2kQzQMbaXj8Mn0c9BodvRS1UDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-6853c2438b9so11629312eaf.3
        for <mptcp@lists.linux.dev>; Wed, 20 May 2026 04:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779278136; x=1779882936;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8GZol9qQ+dw2DLZfx9vE3fAfJaHwkWrSoxo+SKKzVtw=;
        b=md1EeTROvvMJAe2QzHzACUdFsmc8zLdhxgeSd1Z9Cu6U77CfWFOeWHPG6VPwT6uU/c
         8sJeJjytc8U8BeFh24lAs3FUlvO/BPloKMhPv4b+SHp4pm4UwgLvt8ZJUUQLsq+ZLLph
         11dJglpT61CvTVxDa3j73lQW5KuxWza973+tb8z17248+Zw9fk0fNohPKPNJ8Tb/ljD/
         iAtKboYcfhdcMPbdBWv0+JAIejDEeL2osFnoFfMkJXg4CMnsr8NsMH9Sfm/174nLByY0
         RudVaGqviM/PDOqQaI8lHU5HTUJysNJXl9FLZktmuNllvMcheUqGC0PV3MQuJjakP3D2
         KueA==
X-Forwarded-Encrypted: i=1; AFNElJ9Ho/LybO45XbY1XczpuTZRZjQwZa7hgwsQMDMajC/iVDskxqZ8lpTLJPZzzfPGx3L8ieV0Ew==@lists.linux.dev
X-Gm-Message-State: AOJu0YzQRQadm0LfZzjKAdfL6nq1x++vb5tu2bSFnpwcm+Li4K22n35a
	RuGXzBQ1xevtwJfqx3yXRLUyY0HO/i7Il4Bh4dRvpjSoNIuRORFPkprhqOKIq1in3mUIIeiaHXW
	AVFVHApI0sidDHvC5lzqe+T0eJXxJGNmQLWnnjlqryob3sCYoopzARJz7Jz8=
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f07:b0:67e:16b4:aa0d with SMTP id
 006d021491bc7-69c9437c154mr13458890eaf.30.1779278136388; Wed, 20 May 2026
 04:55:36 -0700 (PDT)
Date: Wed, 20 May 2026 04:55:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a0da138.170a0220.3cbd30.0141.GAE@google.com>
Subject: [syzbot] [mptcp?] WARNING in mptcp_pm_alloc_anno_list (2)
From: syzbot <syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang@kernel.org, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ab5fce87a778 Merge tag 'perf-tools-fixes-for-v7.1-2026-05-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=175fcca6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb5b551cf65fa040
dashboard link: https://syzkaller.appspot.com/bug?extid=55c2a5c871441261ed14
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e36518c61bd7/disk-ab5fce87.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cd934c0c8950/vmlinux-ab5fce87.xz
kernel image: https://storage.googleapis.com/syzbot-assets/88cf18661142/bzImage-ab5fce87.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com

------------[ cut here ]------------
mptcp_pm_is_kernel(msk)
WARNING: net/mptcp/pm.c:436 at mptcp_pm_alloc_anno_list+0x408/0x4d0 net/mptcp/pm.c:436, CPU#1: kworker/1:6/5792
Modules linked in:
CPU: 1 UID: 0 PID: 5792 Comm: kworker/1:6 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Workqueue: events mptcp_worker
RIP: 0010:mptcp_pm_alloc_anno_list+0x408/0x4d0 net/mptcp/pm.c:436
Code: 8d 7b 30 49 c7 c0 00 6f 64 9b 48 c7 c1 40 f5 28 8d 31 d2 48 c7 c6 b0 43 77 8b e8 c3 b3 7c f6 e9 c6 fc ff ff e8 c9 5b 91 f6 90 <0f> 0b 90 31 db e9 09 fd ff ff 48 c7 c7 c4 39 d8 90 e8 22 27 fe f6
RSP: 0018:ffffc90004187818 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888079295f00 RCX: ffffffff8b772ecf
RDX: ffff888029de1ec0 RSI: ffffffff8b773217 RDI: ffff888029de1ec0
RBP: ffff88807e593100 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff88807e593100 R15: ffff88806a3a5e80
FS:  0000000000000000(0000) GS:ffff88812446d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000020000035e030 CR3: 0000000068e39000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 mptcp_pm_create_subflow_or_signal_addr+0xa7a/0x18a0 net/mptcp/pm_kernel.c:373
 mptcp_pm_nl_subflow_established net/mptcp/pm_kernel.c:443 [inline]
 __mptcp_pm_kernel_worker+0xe5/0x1f0 net/mptcp/pm_kernel.c:1573
 mptcp_pm_worker+0x12b/0x320 net/mptcp/pm.c:1069
 mptcp_worker+0x15d/0x1420 net/mptcp/protocol.c:2976
 process_one_work+0xa0e/0x1980 kernel/workqueue.c:3314
 process_scheduled_works kernel/workqueue.c:3397 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3478
 kthread+0x370/0x450 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
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
