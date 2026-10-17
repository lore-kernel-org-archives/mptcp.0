Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDFE35C1BC
	for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 17:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258044; cv=none; b=m1emKAinxoWgp1wRKxArAJLw3kdgJo7zV5w+42rGwEyKoncOo/cOHRsAkxivBnnyp7te00E5MXDhHJucDxQi6aTHgHW/GntbnYkfVdMcg46cyL1dSLUUvdZjvbf74eNJAMeLr5BawrWYBqxutdjdrOBhETJc9ixi1H1dPRi5TYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258044; c=relaxed/simple;
	bh=YrNLJ1Y7MQfU2D+lSEYqDYLoMLCdAexvbTNj9qlfTJ4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XYSRTaB9mPvNEviFnKDSMmm/QJks0JYE/g3Fj1Y7Ago5YslOz2ASKX/rcpOD39d5FacgNIt2i2+RH688kekOoxr9zZ77T3jBFIZswTjQwZC8RQ+nyGIaJQPfkv+A1iNNxfMbM/8vx1Es6CqYY5R5CXhz6vjrQ834r2jAkXFx+CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1LH8b3X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1LH8b3X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DC81F000C6;
	Sat, 17 Oct 2026 17:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792258043;
	bh=B3mHagbXGVFTwSTskEEEyXJDfMX/EPURCotIG0hhf6M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=c1LH8b3XfLYmBaaTo0tQg2WOr61mSlQLVXDeGETFftTaHu7d1tIqmzDL8/eXxn6mT
	 NEc0R9dpQPE7KHEV/IISVVU1qClBIa3CqiqCZ7HlBk4T5z53cIt71DhgWzDZvxIY6A
	 l37XyoWQTGO85rTIAg9l3aLkbMi0Hp2TDWV8PrqoXY2kh7RE9skjOfBEDrDAaPrmlA
	 q9yeoLnqbwgg9Y44IEVW1NBhps2j26j/L/pAqSZlXZ8Gd7xFmX00UAOkuhpe2Vz0BO
	 Lp0e/LqXx/0qElKZyktW3gNJ5AWzd/qIvJy+O9tu3rvVN5+B2FpBqT11+I1xJp9e10
	 feHXNTtzoZquQ==
Subject: Re: [PATCH mptcp-next v2 1/2] mptcp: give MPTCP sockets a distinct
 lockdep class
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Sat, 17 Oct 2026 17:27:22 +0000
Message-ID: <179225804264.3133.5374808777837243575@kernel.org>
In-Reply-To: =?utf-8?q?=3C8651f29fb4e11de14a7ea7d05d97a33b1e5390f3=2E1792114?=
 =?utf-8?q?102=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C8651f29fb4e11de14a7ea7d05d97a33b1e5390f3=2E17921141?=
 =?utf-8?q?02=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix leaves out the passive (accept/clone) path, although the
  commit message says "Call it from __mptcp_init_sock() to cover both…
- [Medium] The new call site in __mptcp_init_sock() checks only
  `sk->sk_socket`, not `sk->sk_kern_sock`.
- [Low] The refactor is incomplete: mptcp_pm_nl_create_listen_socket()
  still calls mptcp_reclassify_socket(newsk) explicitly…

--

mptcp: give MPTCP sockets a distinct lockdep class

This patch moves the msk lock reclassification out of PM listener
creation and into a new mptcp_reclassify_socket() helper. The helper is
then called from __mptcp_init_sock(). The aim is to stop lockdep from
reporting recursive locking when a kernel msk and its kernel subflows
share the k-sk_lock-AF_INET class.

> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index d3014bf57bf3c..5e8792ad38ca7 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -849,10 +849,20 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
>  static struct lock_class_key mptcp_slock_keys[2];
>  static struct lock_class_key mptcp_keys[2];
>  
> +void mptcp_reclassify_socket(struct sock *sk)
> +{
> +	bool is_ipv6 = sk->sk_family == AF_INET6;
> +
> +	sock_lock_init_class_and_name(sk,
> +				      is_ipv6 ? "mlock-AF_INET6" : "mlock-AF_INET",
> +				      &mptcp_slock_keys[is_ipv6],
> +				      is_ipv6 ? "msk_lock-AF_INET6" : "msk_lock-AF_INET",
> +				      &mptcp_keys[is_ipv6]);
> +}
> +

[ ... ]

> @@ -874,11 +884,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
>  	 * modifiers in several places, re-init the lock class for the msk
>  	 * socket to an mptcp specific one.
>  	 */
> -	sock_lock_init_class_and_name(newsk,
> -				      is_ipv6 ? "mlock-AF_INET6" : "mlock-AF_INET",
> -				      &mptcp_slock_keys[is_ipv6],
> -				      is_ipv6 ? "msk_lock-AF_INET6" : "msk_lock-AF_INET",
> -				      &mptcp_keys[is_ipv6]);
> +	mptcp_reclassify_socket(newsk);

[Severity: Low]
This isn't a bug, but is this explicit call still needed?
sock_create_kern() already reclassifies the socket:

sock_create_kern()
  inet_create() / inet6_create()
    sock_init_data()                 <- sets sk_socket
    sk->sk_prot->init() == mptcp_init_sock()
      __mptcp_init_sock()
        if (sk->sk_socket)
            mptcp_reclassify_socket(sk);

So this second call re-initializes the same lock with the same keys. That
looks harmless because the lock is not held yet. The comment above it
still reads as if the PM listener needs special handling.

Also, mptcp_slock_keys[], mptcp_keys[] and mptcp_reclassify_socket() stay
in pm_kernel.c, but protocol.c now uses them for every msk. Would
protocol.c be a better home for them?

>  
>  	lock_sock(newsk);
>  	ssk = __mptcp_nmpc_sk(mptcp_sk(newsk));
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 60cbd91be6320..68f339311993e 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3245,6 +3245,9 @@ static void __mptcp_init_sock(struct sock *sk)
>  	/* re-use the csk retrans timer for MPTCP-level retrans */
>  	timer_setup(&sk->mptcp_retransmit_timer, mptcp_retransmit_timer, 0);
>  	timer_setup(&msk->sk.mptcp_tout_timer, mptcp_tout_timer, 0);
> +
> +	if (sk->sk_socket)
> +		mptcp_reclassify_socket(sk);

[Severity: High]
The commit message says this covers "both active (connect) and passive
(accept/clone) socket creation paths". Does the passive path actually
get reclassified?

On the passive side, the msk is created by mptcp_sk_clone_init():

mptcp_sk_clone_init()
  sk_clone_lock(sk, GFP_ATOMIC)
    sk_clone()
      sock_lock_init(newsk);     <- k-sk_lock-AF_INET* for a kernel listener
      bh_lock_sock(newsk);
      ...
      sk_set_socket(newsk, NULL);
  __mptcp_init_sock(nsk)
    if (sk->sk_socket)           <- always NULL here
        mptcp_reclassify_socket(sk);

sk_clone() clears sk_socket, so this guard is always false on the clone
path. The cloned msk keeps the generic class chosen by sock_lock_init().

Nothing later seems to fix this up. mptcp_stream_accept() does:

    newsk->sk_kern_sock = arg->kern;
    lock_sock(newsk);
    __inet_accept(sock, newsock, newsk);
    ...
    mptcp_graft_subflows(newsk);

Then mptcp_graft_subflows() calls lock_sock(ssk) on the subflow. That
subflow is a clone of the sock_create_kern() TCP listener subflow, so it
is also in k-sk_lock-AF_INET.

When an in-kernel MPTCP listener accepts an MP_CAPABLE connection, won't
lockdep still report "possible recursive locking" on the first accept,
and again later on the setsockopt and worker paths? The in-tree PM
listener rejects MP_CAPABLE, so this needs some other in-kernel MPTCP
listener. That is still the case the commit message says it covers.

Simply dropping the guard doesn't look safe either. At this point
nsk->sk_lock.slock is held by bh_lock_sock() from sk_clone(). Calling
sock_lock_init_class_and_name() would then spin_lock_init() a held lock.
It would also trip debug_check_no_locks_freed() and break the later
bh_unlock_sock(nsk) in mptcp_sk_clone_init().

Would it work to do the passive reclassification in
mptcp_stream_accept() instead, before lock_sock(newsk), when arg->kern
is set?

[Severity: Medium]
Should this also check sk->sk_kern_sock?

inet_create() and inet6_create() call sock_init_data(sock, sk) before
sk->sk_prot->init(sk), so sk_socket is also set for a socket() call from
user space. As a result, every actively created msk, user or kernel, now
ends up in msk_lock-AF_INET/AF_INET6. mptcp_reclassify_socket() picks
the keys by family only:

    &mptcp_keys[is_ipv6]

Before this patch, user msks were in sk_lock-AF_INET. That class was
already distinct from their k-sk_lock-AF_INET subflows, so user sockets
did not hit the recursion described here. The commit message also
places the problem at "When both are kernel sockets".

Merging user and kernel msks into one class undoes the split that
sock_lock_init() keeps between af_family_keys and af_family_kern_keys.
For example, user msks record msk_lock-AF_INET -> mmap_lock through
copy_from_user() in mptcp_sendmsg(). An in-kernel MPTCP user that holds
fs or reclaim locks would then share that same class.

Could this lead to false circular dependency reports? Limiting the
reclassification to sk_kern_sock sockets, or using separate key arrays
for user and kernel sockets, would avoid this.

>  }
>  
>  static void mptcp_ca_reset(struct sock *sk)

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792114102.git.tanggeliang%40kylinos.cn
