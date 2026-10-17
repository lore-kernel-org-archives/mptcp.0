Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6462741B6
	for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 00:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792198701; cv=none; b=PfgknvLA0URUYGV0GnVj98qiDgUokStjUvWtvE+TBwhf9BY4iWKEB8rWMgUt80JxxUEyB9+gMaOrn6q5MVw5U7hWh/DKDHzbryxnWQyeShIKMZrjdXFuHjtCN3i4XCaiJ4ZlQ9e1L00zk/uKl1UGfuvh7FGxR+zo2qpHBdBOsz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792198701; c=relaxed/simple;
	bh=nztDQ++2BjTrohqiZyCsxdX9kCoQILifSx4sjdCLwTY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DbcthH80reszHCd5yokeHKU3gr83egH+nr/M1kPS+Lr90MJmd4o6ZAP0GmkXzvGkWW7xrkxsofl6hVYmz+kfTHKdUrj0+0DyLYIM9gy+yfQB2qzp5FBAK3cQ163wHZR5iTdz/BBUaK9hlHHKzAFfJ06m4jkyjgnxR75lVZK9b98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LULyCEom; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LULyCEom"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE59B1F000C4;
	Sat, 17 Oct 2026 00:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792198700;
	bh=Ww9o42O5KmO/MlgBaiG+PfUlpRAMP+I0nTuLnzV/12Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LULyCEomzxfrDLhBSN+Fx/yOGYkCZVwgU22ZuSpuWIz3BW744vGzA1ZXEdTIz0ncC
	 mZB++8gf9mF3ooJL2L+iiFFPNt7b1NQPSlWNlKE46wlBhRiI3f+//yobMlXRdSEHk7
	 VtCDpJcIb+ubuG44wUkiplF1Yc/WleJyDkTLY2A/VJwHdQssUUQAyR+qCxXUPKycKL
	 derSW8cdXi/OHKsgiXavCWOrhoU3HXWfcR2Ih4nvB7l3lgjwhsaAutEMLTRDMmZ2ES
	 HqGfgRm+dIFOGDovsqSfkxzzS0onQk8PgiWDcPt0Pvs93BUc8gRQkvNm2z2NDKsF1P
	 lsFsVWByNhcSQ==
Subject: Re: [PATCH mptcp-next 2/2] mptcp: kunit: add sockopt test for subflow
 socket locking
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Sat, 17 Oct 2026 00:58:19 +0000
Message-ID: <179219869939.3135.2404720512751646888@kernel.org>
In-Reply-To: =?utf-8?q?=3C142cbcb29b102475a20728f41b3d696154f5e04d=2E1792060?=
 =?utf-8?q?837=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C142cbcb29b102475a20728f41b3d696154f5e04d=2E17920608?=
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

- [High] The fix this test accompanies (commit "mptcp: give MPTCP sockets
  a distinct lockdep class") reclassifies the msk lock only in…
- [Medium] The KUnit case mptcp_sockopt_reuseaddr() in
  net/mptcp/sockopt_test.c cannot fail if the lockdep reclassification…
- [Low] The MPTCP_KUNIT_TEST help text in net/mptcp/Kconfig (line 31)
  still says 'Currently covers the MPTCP crypto and token helpers.' The…

--

mptcp: kunit: add sockopt test for subflow socket locking

This commit adds a KUnit test that creates a kernel MPTCP socket and sets
SO_REUSEADDR on it. That exercises the path where
mptcp_setsockopt_sol_socket() locks the msk and then calls sk_setsockopt()
on the subflow. The goal is to verify that MPTCP sockets have a lockdep
class distinct from their subflows.

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
This isn't a bug, but the MPTCP_KUNIT_TEST help text in net/mptcp/Kconfig
still says:

	  Currently covers the MPTCP crypto and token helpers.

Should it also mention the new sockopt test? Unlike the other two, that test
creates real kernel MPTCP sockets in init_net.

>  
>  obj-$(CONFIG_BPF_SYSCALL) += bpf.o
>  
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
This only covers the active socket path. Does the companion fix ("mptcp:
give MPTCP sockets a distinct lockdep class") also handle passively created
msks?

The reclassification happens only from mptcp_init_sock(), which runs for
actively created sockets. Passive msks are created in mptcp_sk_clone_init():

net/mptcp/protocol.c:mptcp_sk_clone_init() {
    ...
    struct sock *nsk = sk_clone_lock(sk, GFP_ATOMIC);
    ...
}

sk_clone_lock() calls sock_lock_init(newsk). That resets the lock to the
default per-family class, picked from the copied sk_kern_sock value.

mptcp_sk_clone_init() never calls mptcp_reclassify_socket(). The accept path
in mptcp_stream_accept() only does this:

    newsk->sk_kern_sock = arg->kern;
    lock_sock(newsk);

For an MPTCP listener created with sock_create_kern(), wouldn't the accepted
msk end up in k-sk_lock-AF_INET? Its subflows are cloned from the kernel
listener subflow, so they would be in the same class.

If so, any path that locks the msk and then a subflow would still hit the
"possible recursive locking" splat on accepted kernel sockets. One example is
SO_REUSEADDR through mptcp_setsockopt_sol_socket().

Today the only in-tree kernel MPTCP listeners are the PM endpoint listeners,
and they reset MP_CAPABLE SYNs. Triggering this needs a kernel user that
calls kernel_accept() on a kernel MPTCP listener, such as an in-kernel
server.

Should the fix also reclassify the lock in mptcp_sk_clone_init()? And could
the test cover an accepted socket as well?

> +	KUNIT_ASSERT_EQ(test, err, 0);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, sock);
> +
> +	err = sock_common_setsockopt(sock, SOL_SOCKET, SO_REUSEADDR,
> +				     KERNEL_SOCKPTR(&reuse), sizeof(reuse));
> +
> +	KUNIT_EXPECT_EQ(test, err, 0);

[Severity: Medium]
Can this test fail if mptcp_reclassify_socket() is missing or broken? The
commit message says:

    Add a KUnit test to verify that MPTCP sockets have a distinct lockdep
    class from their subflows.

The only check, though, is on the return value of the setsockopt call.
Without the reclassification, the call chain still completes:

mptcp_setsockopt_sol_socket()
    lock_sock(sk)
    sk_setsockopt(ssk, SOL_SOCKET, optname, optval, optlen)
        lock on ssk -> lockdep splat, debug_locks_off()

sk_setsockopt() still returns 0. Nothing in kernel/locking/ calls
kunit_fail_current_test(), so the splat only shows up in dmesg and KUnit
reports the test as passed.

Also, MPTCP_KUNIT_TEST only depends on KUNIT. Without
CONFIG_DEBUG_LOCK_ALLOC, mptcp_reclassify_socket() is the empty stub, and the
test passes without exercising the fix at all. It also passes quietly if an
earlier splat has already turned debug_locks off.

Would it be better to compare the lockdep class of sock->sk (for example, the
sk_lock.dep_map key or name) with the subflow's class under
CONFIG_DEBUG_LOCK_ALLOC? Calling kunit_skip() when lockdep isn't available
would handle the other case.

> +
> +	sock_release(sock);
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792060837.git.tanggeliang%40kylinos.cn
