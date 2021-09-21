Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2E33FC5
	for <mptcp@lists.linux.dev>; Tue, 21 Sep 2021 20:38:08 +0000 (UTC)
Received: by mail-io1-f72.google.com with SMTP id z14-20020a05660229ce00b005d616a6f35aso297929ioq.23
        for <mptcp@lists.linux.dev>; Tue, 21 Sep 2021 13:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=w1TIygeMmy3ktGoVIMKKd0XypxxjNFTrwoaPq0Y/s84=;
        b=mVY//v8DzMkRy8H8OWzNerx7si9xOw/wer7IU8xHD/ysob83EAxRzbcoRfAa1YfVJ6
         JrgyRn8/6hWjhMse41LB3lpHggPi9o2+iEJamZlCLmoB3GkyeyWYDIV72VZvyU+tnONO
         R+mptTnGUzcNO+ko3TCkfymKtfgoDvJK1PmrC2EGnFcAFtCXgqYykMVutJY3vCEQ9kJZ
         wtTb7BFRoj5N1ZRVJeVAwpVCeWHez7HgUIDiz6Nd0F1kcpZ/N3CqW4+Gbc3vx6TuhGUW
         6LelClEuakq1/st2fAcHehyCEzdypwRCMVxmdJFOSUE0FRErmecMdg3bx87d8smAeu8V
         Pl1g==
X-Gm-Message-State: AOAM531kH759pCaJqGwyzno3QfIz6tAqKsM0fJBNTrIOwACD6GZzd7a3
	mWCVUZMcI2mO1eQEefquz0oH8OB1EJ7EWzuQh4baRJzPx6ne
X-Google-Smtp-Source: ABdhPJyD1qMGMFWAagu9f3HkcS7cIBP13YUzX2DaHhH7VheghesBi/0IQ0U+Wcel2MYWdK3TT7rYNxBcdi0Xn/Wp5LxkmZ5eXaw7
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a92:c24f:: with SMTP id k15mr17662672ilo.3.1632256687501;
 Tue, 21 Sep 2021 13:38:07 -0700 (PDT)
Date: Tue, 21 Sep 2021 13:38:07 -0700
In-Reply-To: <199f35338f122f32d70d440938b7dba2d4623cd9.camel@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a78e805cc8760cd@google.com>
Subject: Re: [syzbot] WARNING in mptcp_sendmsg_frag
From: syzbot <syzbot+263a248eec3e875baa7b@syzkaller.appspotmail.com>
To: mptcp@lists.linux.dev, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in mptcp_sendmsg_frag

MPTCP: must_collapse=1 old skb=ffff88807de82a00 avail_size=-376 zero_window_probe=0 ws=32729 state=1 frags=17:17
------------[ cut here ]------------
WARNING: CPU: 0 PID: 7472 at net/mptcp/protocol.c:1373 mptcp_sendmsg_frag.cold+0xe0/0x113 net/mptcp/protocol.c:1369
Modules linked in:
CPU: 1 PID: 7472 Comm: syz-executor252 Not tainted 5.15.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:mptcp_sendmsg_frag.cold+0xe0/0x113 net/mptcp/protocol.c:1373
Code: 4d 38 53 41 0f b6 f4 4c 89 fa 8b 44 24 54 48 c7 c7 c0 6e b6 8a 50 41 55 44 8b 44 24 70 8b 4c 24 2c 41 83 e0 01 e8 e3 77 be ff <0f> 0b 41 bc ea ff ff ff 48 83 c4 18 e9 5e 5d b6 ff 48 c7 c7 18 b3
RSP: 0018:ffffc9000375f838 EFLAGS: 00010286
RAX: 0000000000000070 RBX: 0000000000000011 RCX: 0000000000000000
RDX: ffff8880760ab900 RSI: ffffffff815dbd98 RDI: fffff520006ebef9
RBP: ffff888016660600 R08: 0000000000000070 R09: 0000000000000000
R10: ffffffff815d5b3e R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000001 R14: 0000000000000000 R15: ffff88807de82a00
FS:  00005555563a6300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f065b9f3000 CR3: 000000007db04000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __mptcp_push_pending+0x1fb/0x6b0 net/mptcp/protocol.c:1554
 mptcp_sendmsg+0xc29/0x1bc0 net/mptcp/protocol.c:1755
 inet6_sendmsg+0x99/0xe0 net/ipv6/af_inet6.c:643
 sock_sendmsg_nosec net/socket.c:704 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:724
 sock_write_iter+0x289/0x3c0 net/socket.c:1057
 call_write_iter include/linux/fs.h:2163 [inline]
 new_sync_write+0x429/0x660 fs/read_write.c:507
 vfs_write+0x7cf/0xae0 fs/read_write.c:594
 ksys_write+0x1ee/0x250 fs/read_write.c:647
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f0a4ab2efa9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffee3a1d078 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f0a4ab2efa9
RDX: 00000000000e7b78 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000900f0b5ff R09: 0000000900f0b5ff
R10: 0000000000000004 R11: 0000000000000246 R12: 000000000001a80f
R13: 00007ffee3a1d0a0 R14: 00007ffee3a1d090 R15: 00007ffee3a1d084


Tested on:

commit:         92477dd1 Merge tag 's390-5.15-ebpf-jit-fixes' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13c58a4b300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e917f3dfc452c977
dashboard link: https://syzkaller.appspot.com/bug?extid=263a248eec3e875baa7b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14a55423300000

