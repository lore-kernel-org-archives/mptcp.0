Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D04D3FC0
	for <mptcp@lists.linux.dev>; Mon, 20 Sep 2021 16:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1632156781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K2ks4Xd4/Q+IDAbvKvpNQ/+AM5ZjZpelPlO2BzUAHYQ=;
	b=HEMoDfIDPnVhcsHHHTjXSHZ35jdR3L9Gp9v1hGiv9BYlm826rtOHOLrvMCKl1IPVFB8N+p
	nyFhhyiJjKncDPeLl2piDs7Eykjold4+/zK2HnerqhgMCUyrbTZycXBsm4aAkgEuh0aazR
	kvM7HqP1VwfQZWKhtVPvSxvL9w6jD0s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-bknYXoLGMA65c3Fr7HVYAA-1; Mon, 20 Sep 2021 12:52:58 -0400
X-MC-Unique: bknYXoLGMA65c3Fr7HVYAA-1
Received: by mail-wr1-f71.google.com with SMTP id h5-20020a5d6885000000b0015e21e37523so6617284wru.10
        for <mptcp@lists.linux.dev>; Mon, 20 Sep 2021 09:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=K2ks4Xd4/Q+IDAbvKvpNQ/+AM5ZjZpelPlO2BzUAHYQ=;
        b=y3RtsiSMC1+XbyCCrri5fmTCCLguDe76vUMW0Ilsx2VCSRpKSuS1ez8bQtDU8Pf5fs
         fw2bywfskMQyfU5rEPwF1PmVCxDTGc5ASV5blnMYwOlZ+zoZd5zX5PgAZEHEPD0l4Dcy
         YloolL9iZCSupIM4m7xXZhC9lJqOib/xOMcptgT0vhr3f/hgZelanVMXxOunuxDYt6A5
         MJaR521c2y1iO9yUkW1VVwKBUiagxeHaok1ughWG6aswwPDICxh+XjG7qgeTYfem9lcz
         2jKGWsx6ojTXx14ho8jwyoRbO7EKXECxD2QZ+gR0XJOo8qalKqXNVNqG/TweHynFK8FV
         EPbQ==
X-Gm-Message-State: AOAM531eEsoEGLGW0a9HDF4fXhZcWW1lQRBCmagEcpi6BGRQJLjHrgtP
	LrB4FHfoGbFC1OkNF0sIhtSJI+IPaj/oqNPGxMKOKQVF6pJe9x77jUGijWw7gtziSaIE1zXUTLC
	FFYDU/v58zDKdX6E=
X-Received: by 2002:adf:e44c:: with SMTP id t12mr30687347wrm.49.1632156776758;
        Mon, 20 Sep 2021 09:52:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz78FAvKgs3Gcg4ofCEj/ko5rNo6sosRsKZ1AEXorKBHZyDfRxEAg4aNeQ6+5libiOllB/i1w==
X-Received: by 2002:adf:e44c:: with SMTP id t12mr30687326wrm.49.1632156776514;
        Mon, 20 Sep 2021 09:52:56 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-102-46.dyn.eolo.it. [146.241.102.46])
        by smtp.gmail.com with ESMTPSA id c8sm9603028wru.30.2021.09.20.09.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 09:52:56 -0700 (PDT)
Message-ID: <a709cccb3c51596fa4438ec99ca8429655e518e8.camel@redhat.com>
Subject: Re: [syzbot] WARNING in mptcp_sendmsg_frag
From: Paolo Abeni <pabeni@redhat.com>
To: syzbot <syzbot+263a248eec3e875baa7b@syzkaller.appspotmail.com>, 
	mptcp@lists.linux.dev, syzkaller-bugs@googlegroups.com
Date: Mon, 20 Sep 2021 18:52:36 +0200
In-Reply-To: <000000000000bf031105cc00ced8@google.com>
References: <000000000000bf031105cc00ced8@google.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2021-09-14 at 21:05 -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f306b90c69ce Merge tag 'smp-urgent-2021-09-12' of git://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10694371300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2bfb13fa4527da4e
> dashboard link: https://syzkaller.appspot.com/bug?extid=263a248eec3e875baa7b
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+263a248eec3e875baa7b@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 810 at net/mptcp/protocol.c:1366 mptcp_sendmsg_frag+0x1362/0x1bc0 net/mptcp/protocol.c:1366
> Modules linked in:
> CPU: 1 PID: 810 Comm: syz-executor.4 Not tainted 5.14.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:mptcp_sendmsg_frag+0x1362/0x1bc0 net/mptcp/protocol.c:1366
> Code: ff 4c 8b 74 24 50 48 8b 5c 24 58 e9 0f fb ff ff e8 13 44 8b f8 4c 89 e7 45 31 ed e8 98 57 2e fe e9 81 f4 ff ff e8 fe 43 8b f8 <0f> 0b 41 bd ea ff ff ff e9 6f f4 ff ff 4c 89 e7 e8 b9 8e d2 f8 e9
> RSP: 0018:ffffc9000531f6a0 EFLAGS: 00010216
> RAX: 000000000000697f RBX: 0000000000000000 RCX: ffffc90012107000
> RDX: 0000000000040000 RSI: ffffffff88eac9e2 RDI: 0000000000000003
> RBP: ffff888078b15780 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffffff88eac017 R11: 0000000000000000 R12: ffff88801de0a280
> R13: 0000000000006b58 R14: ffff888066278280 R15: ffff88803c2fe9c0
> FS:  00007fd9f866e700(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007faebcb2f718 CR3: 00000000267cb000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  __mptcp_push_pending+0x1fb/0x6b0 net/mptcp/protocol.c:1547
>  mptcp_release_cb+0xfe/0x210 net/mptcp/protocol.c:3003
>  release_sock+0xb4/0x1b0 net/core/sock.c:3206
>  sk_stream_wait_memory+0x604/0xed0 net/core/stream.c:145
>  mptcp_sendmsg+0xc39/0x1bc0 net/mptcp/protocol.c:1749
>  inet6_sendmsg+0x99/0xe0 net/ipv6/af_inet6.c:643
>  sock_sendmsg_nosec net/socket.c:704 [inline]
>  sock_sendmsg+0xcf/0x120 net/socket.c:724
>  sock_write_iter+0x2a0/0x3e0 net/socket.c:1057
>  call_write_iter include/linux/fs.h:2163 [inline]
>  new_sync_write+0x40b/0x640 fs/read_write.c:507
>  vfs_write+0x7cf/0xae0 fs/read_write.c:594
>  ksys_write+0x1ee/0x250 fs/read_write.c:647
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x4665f9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fd9f866e188 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 000000000056c038 RCX: 00000000004665f9
> RDX: 00000000000e7b78 RSI: 0000000020000000 RDI: 0000000000000003
> RBP: 00000000004bfcc4 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056c038
> R13: 0000000000a9fb1f R14: 00007fd9f866e300 R15: 0000000000022000

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

tentative -net fix

---
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2602f1386160..f0673541a764 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1325,7 +1325,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, struct sock *ssk,
 	}
 
 alloc_skb:
-	if (!must_collapse && !ssk->sk_tx_skb_cache &&
+	if (!must_collapse &&
 	    !mptcp_alloc_tx_skb(sk, ssk, info->data_lock_held))
 		return 0;
 

