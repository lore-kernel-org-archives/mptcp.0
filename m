Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F7F3FC0
	for <mptcp@lists.linux.dev>; Mon, 20 Sep 2021 20:48:17 +0000 (UTC)
Received: by mail-io1-f69.google.com with SMTP id i11-20020a056602134b00b005be82e3028bso43704600iov.18
        for <mptcp@lists.linux.dev>; Mon, 20 Sep 2021 13:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=PryYZi3LaKyviYsqgvNP4cTn3jLVkF60DIhriJ6OKmc=;
        b=Nfa4dpyA+QdErcOJZTZqshjQ6mwt+HAa6aYAUJ+i9oKyNae//WHEg2LK2mf4C/rlLp
         06/ADPaAA7WwVYP6ecBdlPcUsk1eBEjpqjpih/Fw5RsYgPA6LXZ3VdEFsq+4AmdkEkDF
         gRp2EgFs9RqouUUbO+KDAr0pIVe3KNvNGrDDUSNT4HXfK0hKRuDAqbAwtwiljjBW9XGU
         7HbyMyec5rOX5apWmKhZl4eglpJM7Yj3y1Tcxjt2s6tQjS+H9ge52pX+DA2e1WK320HD
         7nAIwEV9ccOOxo8HeNdBq6/gD7neoGpG237GEhasEmSvwlSLrtM8GROfK2C1NxkVpAM4
         fgig==
X-Gm-Message-State: AOAM532ad0hxcMlSATtwAOQVaOgNThpSihCoJ1zBb/Jk4a9Zfq++CmU6
	6/gbad/UtJjKNBPaAxKmWxHd8yKvdwwDvELmvlJL0B0948pA
X-Google-Smtp-Source: ABdhPJzvXX8Em1/BTVf9zfEXN3O+Og7n9o7o15gDRGxNaVQUaeIRFVc8TGiO11deh+MqRoqbvovbfPlSCxHs/sFqNtIqKQ1Q/XuK
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a02:c9d9:: with SMTP id c25mr4724266jap.81.1632170896466;
 Mon, 20 Sep 2021 13:48:16 -0700 (PDT)
Date: Mon, 20 Sep 2021 13:48:16 -0700
In-Reply-To: <a709cccb3c51596fa4438ec99ca8429655e518e8.camel@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f270205cc736671@google.com>
Subject: Re: [syzbot] WARNING in mptcp_sendmsg_frag
From: syzbot <syzbot+263a248eec3e875baa7b@syzkaller.appspotmail.com>
To: mptcp@lists.linux.dev, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
WARNING in mptcp_sendmsg_frag

------------[ cut here ]------------
WARNING: CPU: 0 PID: 7555 at net/mptcp/protocol.c:1366 mptcp_sendmsg_frag+0x16e1/0x1b90 net/mptcp/protocol.c:1366
Modules linked in:
CPU: 0 PID: 7555 Comm: syz-executor840 Not tainted 5.15.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:mptcp_sendmsg_frag+0x16e1/0x1b90 net/mptcp/protocol.c:1366
Code: f8 4c 89 ef 45 31 f6 e8 ed 57 2e fe e9 ad f2 ff ff e8 a3 3b 8b f8 89 de 4c 89 ef e8 99 b9 ff ff e9 a4 fc ff ff e8 8f 3b 8b f8 <0f> 0b 41 be ea ff ff ff e9 87 f2 ff ff e8 7d 3b 8b f8 31 d2 44 89
RSP: 0018:ffffc9000432f850 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff888079549c80 RSI: ffffffff88ead031 RDI: 0000000000000003
RBP: ffff888025f78c80 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff88eac5de R11: 0000000000000000 R12: ffff88801ac03b80
R13: ffff88801ac03900 R14: 0000000000000000 R15: ffff88807bca8000
FS:  00005555572f0300(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffed96ab948 CR3: 0000000074a2a000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __mptcp_push_pending+0x1fb/0x6b0 net/mptcp/protocol.c:1547
 mptcp_sendmsg+0xc29/0x1bc0 net/mptcp/protocol.c:1748
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
RIP: 0033:0x7f9576e96fa9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffed96ab968 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f9576e96fa9
RDX: 00000000000e7b78 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000f0b5ff R09: 0000000000f0b5ff
R10: 0000000000000004 R11: 0000000000000246 R12: 000000000001a761
R13: 00007ffed96ab990 R14: 00007ffed96ab980 R15: 00007ffed96ab974


Tested on:

commit:         4c17ca27 Merge tag 'spi-fix-v5.15-rc2' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c699ab300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e917f3dfc452c977
dashboard link: https://syzkaller.appspot.com/bug?extid=263a248eec3e875baa7b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=115e8cad300000

