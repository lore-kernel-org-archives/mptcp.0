Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820833AFB07
	for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 17:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792258047; cv=none; b=hlk0vVLJw+8uMywus7QzJI4GYXQ6KBsxe16ZtYISGZg0AownGFmoWUQ3ALZr7cNNO+SO+jBI2AJirRbkaQQK8FkCOoh2wxlPr+4va8qZroqLcKceRhNRtvIVUF4fGTMwi34mjbW3bITGgUlDNUL50vjXPdVwTxGfty3dJxHqEI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792258047; c=relaxed/simple;
	bh=3QMEFnqdppoZNqILGSU0YnltC7ALjgN08lwe4nIYRgI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b0G65hGSvr0KOJHo5rM7VhH5Eh24joTEhb7a7MTxg06KqyUCiukJ+RCzQ2OLUILofAHL/5dbiHapQtnI+f7mhuUtPkQHo+6q61aCRnfbnrz3Mppm9rL+zvJWh+NUZI3vnO/myrs807gj0jOjRShKpmBXhX+o7uS6tyDuaAarKTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvHph9+J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvHph9+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31EA1F000C5;
	Sat, 17 Oct 2026 17:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792258044;
	bh=a8vAG6CjdUaDC8m2fGPeWC0Il/J9l0SryqkAJc0CHE0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XvHph9+J79MeyURfC+ORx3fX1vrHRg7OX1A0so/D+V9XujrMLfGRS5AM0A3JXJ7aQ
	 5Z8fZLpoPZ6whzhoZBQxofmD+/Xv+zVb1/EZbhThZqU0ABi5lNHbCsDGoNPtgqGQnq
	 JG3zXKT6iOBvMsgPNxjvM1SJ9ZRIunkHX9Lp6b1B76E8YSTv73R42R/Taz7dWfjrd5
	 teEqYqqeJtN3NoUmDdtYKiNyqmuLIwhnIWsB8uB2yQBhPbhecK1D/2vUaIywyYBwoD
	 Jz/0y4rarXFM0I/ioNAApqGhDcJ5z/Rn35zv9EQBz1ir0DyYXfR95OeYi1mfLyp0Z6
	 pyn+3PAe+9f0Q==
Subject: Re: [PATCH mptcp-next v2 2/2] mptcp: kunit: add sockopt test for
 subflow socket locking
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Sat, 17 Oct 2026 17:27:23 +0000
Message-ID: <179225804350.3133.12494514393089653943@kernel.org>
In-Reply-To: =?utf-8?q?=3Ce32025457f5b30b3d859e85077752b761757a35f=2E1792114?=
 =?utf-8?q?102=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3Ce32025457f5b30b3d859e85077752b761757a35f=2E17921141?=
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

- [High] The fix this test is meant to cover is commit "mptcp: give MPTCP
  sockets a distinct lockdep class", in the same reviewed range.
- [Medium] The new test mptcp_sockopt_reuseaddr()
  (net/mptcp/sockopt_test.c) cannot detect the regression it is meant to…
- [Low] The MPTCP_KUNIT_TEST help text in net/mptcp/Kconfig still says
  "Currently covers the MPTCP crypto and token helpers." This patch adds…

--

mptcp: kunit: add sockopt test for subflow socket locking

This commit adds a KUnit test that creates a kernel AF_INET MPTCP socket
and sets SO_REUSEADDR on it. That goes through
mptcp_setsockopt_sol_socket(), which locks the msk and then calls
sk_setsockopt() on the subflow. The test is meant to check that the msk
has a lockdep class distinct from its subflows.

> diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
> index bd72b300a0f68..e9ae91cff940a 100644
> --- a/net/mptcp/Makefile
> +++ b/net/mptcp/Makefile
> @@ -10,7 +10,9 @@ obj-$(CONFIG_INET_MPTCP_DIAG) += mptcp_diag.o
>
>  mptcp_crypto_test-objs := crypto_test.o
>  mptcp_token_test-objs := token_test.o
> -obj-$(CONFIG_MPTCP_KUNIT_TEST) += mptcp_crypto_test.o mptcp_token_test.o
> +mptcp_sockopt_test-objs := sockopt_test.o
> +obj-$(CONFIG_MPTCP_KUNIT_TEST) += mptcp_crypto_test.o mptcp_token_test.o \
> +				  mptcp_sockopt_test.o

[Severity: Low]
This isn't a bug, but should the MPTCP_KUNIT_TEST help text in
net/mptcp/Kconfig be updated as well? It still says:

	  Currently covers the MPTCP crypto and token helpers.

The crypto and token tests only exercise helpers. This new one creates
real kernel MPTCP sockets and subflows in init_net.

[ ... ]

> diff --git a/net/mptcp/sockopt_test.c b/net/mptcp/sockopt_test.c
> new file mode 100644
> index 0000000000000..ebd43de025432
> --- /dev/null
> +++ b/net/mptcp/sockopt_test.c
> @@ -0,0 +1,37 @@

[ ... ]

> +static void mptcp_sockopt_reuseaddr(struct kunit *test)
> +{
> +	struct socket *sock;
> +	int err, reuse = 1;
> +
> +	err = sock_create_kern(&init_net, AF_INET, SOCK_STREAM, IPPROTO_MPTCP,
> +			       &sock);

[Severity: High]
This question is about the companion fix that this test is meant to
cover, commit 61c155e850cb ("mptcp: give MPTCP sockets a distinct lockdep
class"). That commit message says calling mptcp_reclassify_socket() from
__mptcp_init_sock() is done:

    to cover both active (connect)
    and passive (accept/clone) socket creation paths.

Is the passive path actually reclassified? __mptcp_init_sock() only
reclassifies when sk_socket is set:

net/mptcp/protocol.c:__mptcp_init_sock() {
    ...
	if (sk->sk_socket)
		mptcp_reclassify_socket(sk);
}

Passive msk sockets come from mptcp_sk_clone_init(), which goes through
sk_clone_lock()->sk_clone(). sk_clone() calls sock_lock_init(newsk) and
bh_lock_sock(newsk). It also calls sk_set_socket(newsk, NULL) before it
returns.

So by the time mptcp_sk_clone_init() calls __mptcp_init_sock(nsk),
sk->sk_socket is NULL and the reclassification is skipped.

mptcp_stream_accept() then only does this, without re-initializing the
lock class:

		newsk->sk_kern_sock = arg->kern;
		lock_sock(newsk);
		__inet_accept(sock, newsock, newsk);

sock_lock_init() picks the class from sk_kern_sock, and that field is
copied from the listener. Take an MP_CAPABLE connection accepted on a
kernel-created MPTCP listener. Wouldn't the passive msk end up in
k-sk_lock-AF_INET (or AF_INET6)?

Its first subflow is cloned from a listener subflow that was created with
sock_create_kern(), so it would be in the same class. A sequence like
this would then seem to produce the same "possible recursive locking"
report that the fix is meant to remove:

kernel_accept()
setsockopt(SO_REUSEADDR) on the accepted msk
  mptcp_setsockopt_sol_socket()
    lock_sock(sk)             <- msk, k-sk_lock-AF_INET
    sk_setsockopt(ssk, ...)   <- takes the ssk lock, same class

After that report, lockdep turns itself off for the rest of the boot.

The in-tree PM listeners reject MP_CAPABLE, so reaching this needs a
kernel user that calls sock_create_kern(), kernel_listen() and
kernel_accept() on an MPTCP socket.

Removing the sk_socket guard does not look like a fix by itself. On the
clone path bh_lock_sock() holds the slock, and
sock_lock_init_class_and_name() would then spin_lock_init() a lock that
is held.

Would the passive msk have to be reclassified at accept/graft time
instead, when the lock is not held? This test only creates an active
AF_INET socket, so it would not catch this gap.

> +	KUNIT_ASSERT_EQ(test, err, 0);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sock);
> +
> +	err = sock_common_setsockopt(sock, SOL_SOCKET, SO_REUSEADDR,
> +				     KERNEL_SOCKPTR(&reuse), sizeof(reuse));
> +
> +	KUNIT_EXPECT_EQ(test, err, 0);

[Severity: Medium]
Can this check ever fail if the lockdep reclassification regresses? The
commit message says the test is there:

    to verify that MPTCP sockets have a distinct lockdep
    class from their subflows.

Here err comes from sk_setsockopt(ssk, ...) through
mptcp_setsockopt_sol_socket(), and it does not depend on the msk lock
class. If mptcp_reclassify_socket() is removed or broken, or the call in
__mptcp_init_sock() is dropped, err is still 0 and the case still passes.

A "possible recursive locking" report only prints a splat and calls
debug_locks_off(). Nothing in kernel/locking/ calls
kunit_fail_current_test(), and lib/kunit/ has no lockdep or debug_locks
hook. So KUnit never marks the case as failed.

The test only tells us anything about locking when all of these hold:

  - CONFIG_PROVE_LOCKING is enabled. MPTCP_KUNIT_TEST does not depend on
    lockdep.
  - Lockdep has not already turned itself off after an earlier splat.
  - Someone reads dmesg.

Could the test check the classes directly, under IS_ENABLED(CONFIG_LOCKDEP)?
For example, after the setsockopt call it could assert that
sock->sk->sk_lock.dep_map.key differs from
mptcp_sk(sock->sk)->first->sk_lock.dep_map.key.

The coverage is also narrow:

  - Only AF_INET is created, so the msk_lock-AF_INET6 branch of
    mptcp_reclassify_socket() is never run. An AF_INET6 case under
    CONFIG_MPTCP_IPV6 would cover it.
  - sock->sk->sk_reuse is never checked, even though SO_REUSEADDR is the
    option being set.

> +
> +	sock_release(sock);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792114102.git.tanggeliang%40kylinos.cn
