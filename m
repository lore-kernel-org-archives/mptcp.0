Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E698F72
	for <mptcp@lists.linux.dev>; Fri, 24 Sep 2021 13:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1632490190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y8biByU5FSSvpqSJuMXFDLtNS9Hbg/TA4rQl1nCIa+E=;
	b=TexeAt4ZegXg7+Ro/PNHX2oa0OzGzsZ+IGPDdLOt5F7AU88DHZa+pkzCKg8eIUJZy4M2rK
	KMWe9igo+T0RoCqJA4mEzukQR4JaWTYpxEc+zwtmWIkDZi9SNIei7RpZmlV0S/Ne9eK4zo
	AHiSjZnz0l9E8GJ0zKhzWbpcZ418mLU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-AZ80NAYbNJeaEEDAs6LnXA-1; Fri, 24 Sep 2021 09:29:49 -0400
X-MC-Unique: AZ80NAYbNJeaEEDAs6LnXA-1
Received: by mail-wr1-f71.google.com with SMTP id z2-20020a5d4c82000000b0015b140e0562so8100452wrs.7
        for <mptcp@lists.linux.dev>; Fri, 24 Sep 2021 06:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=y8biByU5FSSvpqSJuMXFDLtNS9Hbg/TA4rQl1nCIa+E=;
        b=VoxjcaNAI8f2ynKPTt3JO18ja4Wjm6zbEnf84+wKS6g36oGGmQdbjb8jzqvoO8J1i3
         WztSKjS0uR9/dlaImveU0VF06aICP+e9AUVG6TC0gaEANBj37v0WVBrw2ljoSCIAwZ0d
         G0W3QT4ILfT7CP7H771A/8sPNvqYnuFtVANYMikfNIDaF1bgSgsa5sA6QdU26Vf7JHwN
         ypZwMVmmup1z+bwhVDXjFOldiI48uF6Mo82mrB4Rv69R2REk9GiD2JTL+ZV/sR22Z5nP
         x9ovOpE8jfFPUp8Jer0wmPb9LJ0gRirBp0wYIMNbYhWdtlaAypScvWIaSJCUiwBd/3Wi
         NMfA==
X-Gm-Message-State: AOAM533y+5ZdtdsTwcbBmSZwgTRDTyJCaSO94PYqvWEhpzNhFUZt4bkE
	yMQ82IW7UB66zNe+mEsuNArrZGZZ1KfGoy1fBBL3de/peW0XnBTJ5/95uUDXfTxRb+9HJBy6Lp7
	MILfIBL2fJC0batw=
X-Received: by 2002:a1c:7c0f:: with SMTP id x15mr2038607wmc.149.1632490188078;
        Fri, 24 Sep 2021 06:29:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVWE6RdawUC4fc9CQlEZ9kWlnRyBt5QmHaNfJJVpWeVEXeNn5Dl9HO9ntntyyREaiB9TJkUw==
X-Received: by 2002:a1c:7c0f:: with SMTP id x15mr2038593wmc.149.1632490187805;
        Fri, 24 Sep 2021 06:29:47 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-102-46.dyn.eolo.it. [146.241.102.46])
        by smtp.gmail.com with ESMTPSA id h125sm8711794wmh.9.2021.09.24.06.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 06:29:47 -0700 (PDT)
Message-ID: <0e473d46b664d652d7df20de49aebe8385ec3a87.camel@redhat.com>
Subject: Re: [PATCH mptcp-net] net: introduce and use lock_sock_fast_nested()
From: Paolo Abeni <pabeni@redhat.com>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
Date: Fri, 24 Sep 2021 15:29:46 +0200
In-Reply-To: <9f04ce8-a770-11c-8b3-d6a9284b190@linux.intel.com>
References: <edc906c6750186d75e2cf2b87d84c10284c8dd8b.1632396844.git.pabeni@redhat.com>
	 <9f04ce8-a770-11c-8b3-d6a9284b190@linux.intel.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2021-09-23 at 15:28 -0700, Mat Martineau wrote:
> On Thu, 23 Sep 2021, Paolo Abeni wrote:
> 
> > Syzkaller reported a false positive deadlock involving
> > the nl socket lock and the subflow socket lock:
> > 
> > MPTCP: kernel_bind error, err=-98
> > ============================================
> > WARNING: possible recursive locking detected
> > 5.15.0-rc1-syzkaller #0 Not tainted
> > --------------------------------------------
> > syz-executor998/6520 is trying to acquire lock:
> > ffff8880795718a0 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_close+0x267/0x7b0 net/mptcp/protocol.c:2738
> > 
> > but task is already holding lock:
> > ffff8880787c8c60 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1612 [inline]
> > ffff8880787c8c60 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_close+0x23/0x7b0 net/mptcp/protocol.c:2720
> > 
> > other info that might help us debug this:
> > Possible unsafe locking scenario:
> > 
> >       CPU0
> >       ----
> >  lock(k-sk_lock-AF_INET);
> >  lock(k-sk_lock-AF_INET);
> > 
> > *** DEADLOCK ***
> > 
> > May be due to missing lock nesting notation
> > 
> > 3 locks held by syz-executor998/6520:
> > #0: ffffffff8d176c50 (cb_lock){++++}-{3:3}, at: genl_rcv+0x15/0x40 net/netlink/genetlink.c:802
> > #1: ffffffff8d176d08 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:33 [inline]
> > #1: ffffffff8d176d08 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x3e0/0x580 net/netlink/genetlink.c:790
> > #2: ffff8880787c8c60 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1612 [inline]
> > #2: ffff8880787c8c60 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_close+0x23/0x7b0 net/mptcp/protocol.c:2720
> > 
> > stack backtrace:
> > CPU: 1 PID: 6520 Comm: syz-executor998 Not tainted 5.15.0-rc1-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> > __dump_stack lib/dump_stack.c:88 [inline]
> > dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
> > print_deadlock_bug kernel/locking/lockdep.c:2944 [inline]
> > check_deadlock kernel/locking/lockdep.c:2987 [inline]
> > validate_chain kernel/locking/lockdep.c:3776 [inline]
> > __lock_acquire.cold+0x149/0x3ab kernel/locking/lockdep.c:5015
> > lock_acquire kernel/locking/lockdep.c:5625 [inline]
> > lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
> > lock_sock_fast+0x36/0x100 net/core/sock.c:3229
> > mptcp_close+0x267/0x7b0 net/mptcp/protocol.c:2738
> > inet_release+0x12e/0x280 net/ipv4/af_inet.c:431
> > __sock_release net/socket.c:649 [inline]
> > sock_release+0x87/0x1b0 net/socket.c:677
> > mptcp_pm_nl_create_listen_socket+0x238/0x2c0 net/mptcp/pm_netlink.c:900
> > mptcp_nl_cmd_add_addr+0x359/0x930 net/mptcp/pm_netlink.c:1170
> > genl_family_rcv_msg_doit+0x228/0x320 net/netlink/genetlink.c:731
> > genl_family_rcv_msg net/netlink/genetlink.c:775 [inline]
> > genl_rcv_msg+0x328/0x580 net/netlink/genetlink.c:792
> > netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2504
> > genl_rcv+0x24/0x40 net/netlink/genetlink.c:803
> > netlink_unicast_kernel net/netlink/af_netlink.c:1314 [inline]
> > netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1340
> > netlink_sendmsg+0x86d/0xdb0 net/netlink/af_netlink.c:1929
> > sock_sendmsg_nosec net/socket.c:704 [inline]
> > sock_sendmsg+0xcf/0x120 net/socket.c:724
> > sock_no_sendpage+0x101/0x150 net/core/sock.c:2980
> > kernel_sendpage.part.0+0x1a0/0x340 net/socket.c:3504
> > kernel_sendpage net/socket.c:3501 [inline]
> > sock_sendpage+0xe5/0x140 net/socket.c:1003
> > pipe_to_sendpage+0x2ad/0x380 fs/splice.c:364
> > splice_from_pipe_feed fs/splice.c:418 [inline]
> > __splice_from_pipe+0x43e/0x8a0 fs/splice.c:562
> > splice_from_pipe fs/splice.c:597 [inline]
> > generic_splice_sendpage+0xd4/0x140 fs/splice.c:746
> > do_splice_from fs/splice.c:767 [inline]
> > direct_splice_actor+0x110/0x180 fs/splice.c:936
> > splice_direct_to_actor+0x34b/0x8c0 fs/splice.c:891
> > do_splice_direct+0x1b3/0x280 fs/splice.c:979
> > do_sendfile+0xae9/0x1240 fs/read_write.c:1249
> > __do_sys_sendfile64 fs/read_write.c:1314 [inline]
> > __se_sys_sendfile64 fs/read_write.c:1300 [inline]
> > __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1300
> > do_syscall_x64 arch/x86/entry/common.c:50 [inline]
> > do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
> > entry_SYSCALL_64_after_hwframe+0x44/0xae
> > RIP: 0033:0x7f215cb69969
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffc96bb3868 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
> > RAX: ffffffffffffffda RBX: 00007f215cbad072 RCX: 00007f215cb69969
> > RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000005
> > RBP: 0000000000000000 R08: 00007ffc96bb3a08 R09: 00007ffc96bb3a08
> > R10: 0000000100000002 R11: 0000000000000246 R12: 00007ffc96bb387c
> > R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
> > 
> > the problem originates from uncorrect lock annotation in the mptcp
> > code and is only visible since commit 2dcb96bacce3 ("net: core: Correct
> > the sock::sk_lock.owned lockdep annotations"), but is present since
> > the port-based endpoint support initial implementation.
> > 
> > This patch addresses the issue introducing a nested variant of
> > lock_sock_fast() and using it in the relevant code path.
> > 
> > Fixes: 1729cf186d8a ("mptcp: create the listening socket for new port")
> > Fixes: 2dcb96bacce3 ("net: core: Correct the sock::sk_lock.owned lockdep annotations")
> > Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> > Reported-and-tested-by: syzbot+1dd53f7a89b299d59eaf@syzkaller.appspotmail.com
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > include/net/sock.h   | 31 ++++++++++++++++++++++++++++++-
> > net/core/sock.c      | 20 ++------------------
> > net/mptcp/protocol.c |  2 +-
> > 3 files changed, 33 insertions(+), 20 deletions(-)
> > 
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index c005c3c750e8..b5096e20fba5 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -1623,7 +1623,36 @@ void release_sock(struct sock *sk);
> > 				SINGLE_DEPTH_NESTING)
> > #define bh_unlock_sock(__sk)	spin_unlock(&((__sk)->sk_lock.slock))
> > 
> > -bool lock_sock_fast(struct sock *sk) __acquires(&sk->sk_lock.slock);
> > +bool __lock_sock_fast(struct sock *sk) __acquires(&sk->sk_lock.slock);
> 
> I think things look fine from an MPTCP perspective, but I have a couple of 
> questions about the sock.{h,c} changes.
> 
> Do you expect __lock_sock_fast() to be useful outside of 
> lock_sock_fast()/lock_sock_fast_nested()?

No, it's just an artifact to avoid exporting more symbols.

> > +
> > +/**
> > + * lock_sock_fast - fast version of lock_sock
> > + * @sk: socket
> > + *
> > + * This version should be used for very small section, where process wont block
> > + * return false if fast path is taken:
> > + *
> > + *   sk_lock.slock locked, owned = 0, BH disabled
> > + *
> > + * return true if slow path is taken:
> > + *
> > + *   sk_lock.slock unlocked, owned = 1, BH enabled
> > + */
> > +static inline bool lock_sock_fast(struct sock *sk)
> > +{
> > +	/* The sk_lock has mutex_lock() semantics here. */
> > +	mutex_acquire(&sk->sk_lock.dep_map, 0, 0, _RET_IP_);
> > +
> > +	return __lock_sock_fast(sk);
> > +}
> 
> I'm curious why these are inlined now rather than implemented in sock.c?

So that we don't have to export more symbols

> Adding lock_sock_fast_nested() as a regular function would allow 
> __lock_sock_fast() to be static in sock.c, where the optimizer might do 
> better with handling the two variants.

I assumed that CONFIG_LOCKDEP=y is irrelevant from performance
perspective. When for build with

# CONFIG_LOCKDEP is not set

the compiler should emit no code at all
for lock_sock_fast()/lock_sock_fast_nested(), just a direct call
to __lock_sock_fast().

> > +
> > +/* fast socket lock variant for caller already helding a [different] socket lock */
> 
> Typo: "holding"

Thanks, will fix in v2,

Cheers.

Paolo

