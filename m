Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F04B3FC7
	for <mptcp@lists.linux.dev>; Wed, 22 Sep 2021 16:05:25 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1632326280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2wi0PRAB6UmeIsO/wM+nnnFS+lDvKWvgCJyCvgt6O10=;
	b=gCaVRp/fbJrzW9MuaOCMbH65WV2UYLsXyY1RUz/9j2S5Nz6PM7ABOni1fY6m1vyiFloPkg
	DqqYnzqVogspwMU3P42y4tX1xCiF1Uth1nJrwABur0LN0X3NXzFSEwuNMAGCoNT5nlo3ux
	8JnpjZKwtdnRAwOIb3/WxZAtZolf0YEVDyMWxqX9v8mUO0uY/OZ8oKkgZJI8qWsmMp8nl2
	gdIw5GAHgDFw55SDSD5hiMwAtOKL8V5U+8N8/qP82zU1AmwdXG2b1KoXQAcFFGUIc83FeB
	RN4sxjFq4jPt4BWd0GUuhgkKuZYPlhZzYs/54+YviFOeWpuTFb0vza+VsNWEvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1632326280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2wi0PRAB6UmeIsO/wM+nnnFS+lDvKWvgCJyCvgt6O10=;
	b=HjSscceYUWNsUDQnsorqiNOrRaPLu6+R8F62G3lY2Sztj0jMfgyddW4lHqYW9976kZ+Ixi
	zf2ec40LDfZKL9Ag==
To: syzbot <syzbot+1dd53f7a89b299d59eaf@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, fw@strlen.de, kuba@kernel.org,
 linux-kernel@vger.kernel.org, mathew.j.martineau@linux.intel.com,
 matthieu.baerts@tessares.net, mptcp@lists.linux.dev,
 netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [syzbot] possible deadlock in mptcp_close
In-Reply-To: <0000000000005183b005cc74779a@google.com>
References: <0000000000005183b005cc74779a@google.com>
Date: Wed, 22 Sep 2021 17:57:59 +0200
Message-ID: <87zgs4habc.ffs@tglx>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 20 2021 at 15:04, syzbot wrote:
> The issue was bisected to:
>
> commit 2dcb96bacce36021c2f3eaae0cef607b5bb71ede
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Sat Sep 18 12:42:35 2021 +0000
>
>     net: core: Correct the sock::sk_lock.owned lockdep annotations

Shooting the messenger...

> MPTCP: kernel_bind error, err=-98
> ============================================
> WARNING: possible recursive locking detected
> 5.15.0-rc1-syzkaller #0 Not tainted
> --------------------------------------------
> syz-executor998/6520 is trying to acquire lock:
> ffff8880795718a0 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_close+0x267/0x7b0 net/mptcp/protocol.c:2738
>
> but task is already holding lock:
> ffff8880787c8c60 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1612 [inline]
> ffff8880787c8c60 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_close+0x23/0x7b0 net/mptcp/protocol.c:2720

So this is a lock nesting issue and looking at the stack trace this
comes from:

>  lock_sock_fast+0x36/0x100 net/core/sock.c:3229

which does not support lockdep nesting. So from a lockdep POV this is
recursive locking the same lock class. And it's the case I was worried
about that lockdep testing never takes the slow path. The original
lockdep annotation would have produced exactly the same splat in the
slow path case.

So it's not a new problem. It's just visible by moving the lockdep
annotations to a place where they actually can detect issues which were
not reported before.

See also https://lore.kernel.org/lkml/874kacu248.ffs@tglx/

There are two ways to address this mptcp one:

  1) Teach lock_sock_fast() about lock nesting

  2) Use lock_sock_nested() in mptcp_close() as that should not be
     really a hotpath. See patch below.

Thanks,

        tglx
---

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2602f1386160..27ea5d4dfdf6 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2735,10 +2735,10 @@ static void mptcp_close(struct sock *sk, long timeout)
 	inet_csk(sk)->icsk_mtup.probe_timestamp = tcp_jiffies32;
 	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		bool slow = lock_sock_fast(ssk);
 
+		lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 		sock_orphan(ssk);
-		unlock_sock_fast(ssk, slow);
+		unlock_sock(ssk);
 	}
 	sock_orphan(sk);
 
