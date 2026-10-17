Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A9F19F137
	for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 00:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792198700; cv=none; b=KbQydHeyWVD7qoLs50jRFyOLwNat1YsB9IF8TpeefFC2QXE+9ugWGqcZw8d6Ervj7eqcs/UImCE4zYTXbu1r/MPncQc7htGeNMby0wsESsEUtBVcTqkLGUTxYkq+SWb1Y1p8KQzBqskw7Tkix2zg5kebPmEzOiNscNWpFaFFGMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792198700; c=relaxed/simple;
	bh=xF5wpYVDep0hIhKKtwMEw+qh8AsX9CY9DjNzp9hkEa0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m6i2I2o6EywZuMj79skq3DQLmXYsSUG5qQCs3TZuv6NKMbKGqzHK+wk65KJiPdz1HWhfIHwvqnPypC+2Z30kkzzkLjf+IdsRJBvql2ohwjMETCZHE4BoyBA4/5WosCHA6jbuY6Mr3knplPSR1qU/rpWjVw7R06Ul/HbGwES9N/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z95NWGl0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z95NWGl0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011021F000C5;
	Sat, 17 Oct 2026 00:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792198699;
	bh=orJSMhSFkGzbqg7hEy00+nfJpNwX+VzhTRkjHp+zofw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z95NWGl0c+r5OK3GGzeWVmiLJRbmA3rMbY79P70rpWlKAIXEa48GF1IKNMKEJXjEn
	 FcCGJoWnOruX+hJG0nfhWutFYKZPiv61qj8Nj+Cm/J3lCdUyU7F21eNauhFrdzPDu+
	 FcqOA2x91bIeO0GJKj57FUqZJs0+rhWRWuesh2JM5XgSvqSY3qmbh5dPIoYaERdVjq
	 RqYeSwHwTptuphQzazQQDt30612huyIH4OuIpMEund4T/Xm9gH9QfWhYjlnunoHdHh
	 jd2Ya5M4YTYzEBaiNfayTPSyyyHrD4vYfZ8kMhQqMV5Iii3jNz7ggWVGdYui6Qs8C4
	 J67QftNsnOylA==
Subject:
 Re: [PATCH mptcp-next 1/2] mptcp: give MPTCP sockets a distinct lockdep class
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Sat, 17 Oct 2026 00:58:18 +0000
Message-ID: <179219869851.3135.6956177385873762857@kernel.org>
In-Reply-To: =?utf-8?q?=3C23c5f34fa80bff87b4c49981b1ab19d13bf7f136=2E1792060?=
 =?utf-8?q?837=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C23c5f34fa80bff87b4c49981b1ab19d13bf7f136=2E17920608?=
 =?utf-8?q?37=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
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

- [High] In mptcp_stream_accept(), net/mptcp/protocol.c, the patch leaves
  the passive (accepted) side unfixed, so the recursive-locking splat it…
- [Medium] mptcp_reclassify_socket() (net/mptcp/protocol.c:59-92) uses
  one key per address family and ignores sk->sk_kern_sock.
- [Low] The patch adds a second MPTCP msk lockdep scheme next to an
  existing one, without removing or mentioning the first.

--

mptcp: give MPTCP sockets a distinct lockdep class

This commit moves the MPTCP socket lock into its own lockdep class
(sk_lock-AF_INET-MPTCP / sk_lock-AF_INET6-MPTCP) in mptcp_init_sock().
The goal is that locking a subflow while holding the msk lock is no
longer reported as recursive locking when both are kernel sockets. The
implementation is modeled on nvme_tcp_reclassify_socket().

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 60cbd91be6320..e63896a605953 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -56,6 +56,41 @@ DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions) = {
>  };
>  static struct net_device *mptcp_napi_dev;
>  
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +/* distinct lockdep class for MPTCP sockets */
> +static struct lock_class_key mptcp_sk_key[2];
> +static struct lock_class_key mptcp_slock_key[2];

[Severity: Low]
Does this duplicate the msk reclassification that already exists in
net/mptcp/pm_kernel.c? mptcp_pm_nl_create_listen_socket() has its own
keys and reclassifies the PM listener for the same reason:

net/mptcp/pm_kernel.c:
static struct lock_class_key mptcp_slock_keys[2];
static struct lock_class_key mptcp_keys[2];

mptcp_pm_nl_create_listen_socket() {
    ...
	/* The subflow socket lock is acquired in a nested to the msk one
	 * in several places, even by the TCP stack, and this msk is a kernel
	 * socket: lockdep complains. Instead of propagating the _nested
	 * modifiers in several places, re-init the lock class for the msk
	 * socket to an mptcp specific one.
	 */
	sock_lock_init_class_and_name(newsk,
				      is_ipv6 ? "mlock-AF_INET6" : "mlock-AF_INET",
				      &mptcp_slock_keys[is_ipv6],
				      is_ipv6 ? "msk_lock-AF_INET6" : "msk_lock-AF_INET",
				      &mptcp_keys[is_ipv6]);
    ...
}

With this patch the PM listener is reclassified twice. First this path
sets sk_lock-AF_INET-MPTCP:

sock_create_kern(IPPROTO_MPTCP)
  inet_create()
    mptcp_init_sock()
      mptcp_reclassify_socket()

Then pm_kernel.c overwrites it with msk_lock-AF_INET. The result is two
sets of keys and two class names for the same msk lock role, and the PM
listener sits in a different class from every other msk.

Could the pm_kernel.c reclassification be dropped, or could the two
places share one set of keys? It would also help if the commit message
mentioned the existing mitigation.

> +
> +static void mptcp_reclassify_socket(struct socket *sock)
> +{
> +	struct sock *sk = sock->sk;
> +
> +	if (WARN_ON_ONCE(!sock_allow_reclassification(sk)))
> +		return;
> +
> +	switch (sk->sk_family) {
> +	case AF_INET:
> +		sock_lock_init_class_and_name(sk, "slock-AF_INET-MPTCP",
> +					      &mptcp_slock_key[0],
> +					      "sk_lock-AF_INET-MPTCP",
> +					      &mptcp_sk_key[0]);

[Severity: Medium]
Should this check sk->sk_kern_sock? The same key is used for every
socket of a given family. mptcp_init_sock() calls this for all MPTCP
sockets, so user space msks move into this class as well.

Before the patch, the core sock_lock_init() kept the two groups apart:

net/core/sock.c:sock_lock_init() {
	if (sk->sk_kern_sock)
		sock_lock_init_class_and_name(
			...
			af_family_kern_keys + sk->sk_family);
	else
		sock_lock_init_class_and_name(
			...
			af_family_keys + sk->sk_family);
}

After the patch, user and kernel msks both end up in
sk_lock-AF_INET-MPTCP. The commit message only describes the case "When
both are kernel sockets" and does not say that every user space MPTCP
socket changes class too.

The nvme-tcp helper this code is based on explains why that split
matters:

drivers/nvme/host/tcp.c:
/* lockdep can detect a circular dependency of the form
 *   sk_lock -> mmap_lock (page fault) -> fs locks -> sk_lock
 * because dependencies are tracked for both nvme-tcp and user contexts. Using
 * a separate class prevents lockdep from conflating nvme-tcp socket use with
 * user-space socket API use.
 */

nvme-tcp only reclassifies the sockets it owns. Here, user space msks
would record sk_lock-AF_INET-MPTCP -> mmap_lock by faulting in sendmsg,
recvmsg or setsockopt. A kernel msk used under fs or storage locks would
record fs lock -> sk_lock-AF_INET-MPTCP. Could the two together produce
false circular dependency reports that the default classes would have
prevented?

Today the only in-tree kernel MPTCP socket is the PM listener, and
pm_kernel.c reclassifies it again, so no in-tree cycle is shown yet.

Would separate user and kernel keys, or reclassifying only when
sk->sk_kern_sock is set, fit the stated problem better?

[ ... ]

> @@ -3292,6 +3327,8 @@ static int mptcp_init_sock(struct sock *sk)
>  	sk->sk_sndbuf = READ_ONCE(net->ipv4.sysctl_tcp_wmem[1]);
>  	sk->sk_write_space = sk_stream_write_space;
>  
> +	mptcp_reclassify_socket(sk->sk_socket);
> +

[Severity: High]
Does this cover passive (accepted) msks? mptcp_init_sock() is only
reached through the proto .init hook. An msk created on the accept side
is a clone and never goes through it:

subflow_syn_recv_sock()
  mptcp_sk_clone_init(listener->conn, ...)
    sk_clone_lock(sk, GFP_ATOMIC)
      sk_clone()
        sock_copy(newsk, sk);
        ...
        sock_lock_init(newsk);
    __mptcp_init_sock(nsk)

sock_lock_init() picks the class from the sk_kern_sock value copied
from the listener. A clone of a kernel listener therefore goes back to
k-sk_lock-AF_INET(6), and the MPTCP class set on the listener is lost.

Subflows are always kernel sockets, created by
mptcp_subflow_create_socket() through sock_create_kern(..., IPPROTO_TCP,
...), so they are in that same k-sk_lock-AF_INET class.

For a kernel MPTCP listener used with kernel_accept(), it looks like
this still nests two locks of the same class with no annotation:

mptcp_stream_accept()
  lock_sock(newsk);                 k-sk_lock-AF_INET
  ...
  mptcp_graft_subflows(newsk)
    lock_sock(ssk);                 k-sk_lock-AF_INET

Wouldn't lockdep still report "possible recursive locking" here? The
same goes for the later msk->ssk paths on the accepted socket that the
commit message lists, such as the lock_sock(sk) then lock_sock(ssk)
sequence in mptcp_setsockopt_sol_tcp_congestion() and the worker's
send-ack path. Lockdep also turns itself off after the first report,
which hides anything it would have found later in that run.

The next patch in the series ("mptcp: kunit: add sockopt test for
subflow socket locking") only adds a kunit test for an active side
socket and does not touch protocol.c. So the accept side is still not
covered at the end of the series.

Could the clone path also be reclassified, for example in
mptcp_sk_clone_init() after sk_clone_lock()? nsk's slock is already
held at that point, so sock_allow_reclassification() would reject the
helper as written, and that case would need separate handling.

>  	return 0;
>  }
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792060837.git.tanggeliang%40kylinos.cn
