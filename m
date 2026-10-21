Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792605321;
	b=rwwHE8Q+JIHDEA0o+4OTj7bDc7AAecOmRQpBzcChTeo1ppuKNwe0udqREcU9Im0F5fbr
	 5VQmWHyCtN+ipn6s0al8j3WQaZY9TQ7REJbV+iY4Ox7wfHUjerBY5glgbI+TjnOTteaGD
	 dK8inOysoNxj7QtEqpifCUQAcYfEsVSNoKe8MBRWcNc0NYiiiHK+RHcotJBKPQkQwJrg9
	 4HWA2hxdONnujpzBT1uMiUi45BwuzZQsF7AcqayI8hQ7sPcthNtUOLfjspFRaGhBSXMpR
	 nVBlWa4t16O/Wcx1wjaA/AGxXpDp0TTtZQ4QH1rtFTSeuCBuVie9qTH8Xze4jdzFvCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605321;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=86q/mfqtCdvFJz6xVVNTGPExrEt4cTj64U+tVcZ3vFc=;
	b=K9hzBjTqIYrh8mnwfxiRFiW6uzGK5ut0YSj1ZUJ+s5vLNJfOVdH5Wvqalm86+cpjPABI
	 djXg2mSgnNxN9a/QparN936jETU8HqpBFbtr5zx+XNL6pNHXyp7u5ndI63k8JKje3akQ5
	 kh77jJQ0AF6Co+lduc1ELVMo3cYX5XqsFqg4JDfRvEP/h37dBW7WOKaHzoJfVW2RPfPux
	 1CZ9GNCVJZuVvaj7epYLaz87YsR+77SeTou8qtygYmA91hfhJEq5c6IaK7xJKfmwqg7uX
	 Q+9BIwe8zoqmc95hy4Lu3iUm1xrJkTx79DphL/1SOOUrUhjXe/NIb+zA4LHqObQEmrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O0Pe6TRa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6B9606A319
	for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O0Pe6TRa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7BAE1F000C1;
	Wed, 21 Oct 2026 17:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792605321;
	bh=86q/mfqtCdvFJz6xVVNTGPExrEt4cTj64U+tVcZ3vFc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=O0Pe6TRa84DsGoJdn3150NJPVjUDanmKmVzzLg8gsGLteMeES1of2qdvOy+VsMW1q
	 g4cHZxByiu49GFAuYjuBPcubcHuuhbPs42U4HkbJ4q4AGimoTwV9vx2nN3Uz2U9SSd
	 nWlvFmGKLMrtUfOW4oFS55Q4411MuC3+LM57EEHRtF3hDo73/o8ypyV9GGslSDVqlh
	 /ayh1rD1mw8i+QOfWr+L90d2Xm8I0Pc7viykcujmnWp8tytGVh4hMLsvLnV+JzBLEf
	 jm+srxpilD3Dw1PpsO+AZGGtOuQ/fR9RNuHTrsTnZI7QrthHgKQF61jahx4nfeWX/q
	 IzGM8bLZiED2Q==
Subject: Re: [PATCH mptcp-next v4 2/3] mptcp: inherit sk_reuse and fix dev
 bind override
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Wed, 21 Oct 2026 17:55:20 +0000
Message-ID: <179260532035.3133.1916700556916202514@kernel.org>
In-Reply-To: =?utf-8?q?=3C4adf96455e63a35be3228434cfe2ba79ea99bcb0=2E1792470?=
 =?utf-8?q?313=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
References: =?utf-8?q?=3C4adf96455e63a35be3228434cfe2ba79ea99bcb0=2E17924703?=
 =?utf-8?q?13=2Egit=2Etanggeliang=40kylinos=2Ecn=3E?=
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Passive-side join subflows can now lose their per-connection
  device or VRF binding.
- [Low] The commit bundles a claimed bug fix with a new feature.
- [Low] The commit message gives no reason for propagating
  sk_reuse/sk_reuseport to MP_JOIN subflows ('Propagate sk_reuse and…
- [Low] Author and sign-off do not match.
- [Low] Join subflows now inherit sk_reuseport (and sk_reuse) from the
  msk, but subflow sk->sk_uid is never set to the msk owner's uid.

--

mptcp: inherit sk_reuse and fix dev bind override

This commit copies sk_reuse and sk_reuseport from the MPTCP msk to its
subflows in sync_socket_options(). It also bumps setsockopt_seq when
SO_REUSEADDR, SO_REUSEPORT, SO_BINDTODEVICE or SO_BINDTOIFINDEX is set.
In addition, __mptcp_subflow_connect() now overrides sk_bound_dev_if only
when local->ifindex is non-zero.

> Propagate sk_reuse and sk_reuseport from master socket to subflows, and
> bump setsockopt_seq so later subflows pick up the changes.

[Severity: Low]

Could the commit message explain why MP_JOIN subflows need these flags,
and what the user-visible effect is?

The call chain mptcp_subflow_create_socket()->mptcp_sockopt_sync_locked()
now sets ssk->sk_reuse and ssk->sk_reuseport before kernel_bind() in
__mptcp_subflow_connect().

That changes how inet_csk_get_port() handles conflicts for these
kernel-owned subflows. Explicit port binds from the userspace PM may share
ports with other SO_REUSEADDR sockets, and ephemeral port selection
follows reuse semantics.

> This patch also fixes unconditional sk_bound_dev_if override in
> __mptcp_subflow_connect(): only set it when local->ifindex is non-zero,
> otherwise preserve the value inherited from the master socket via
> sync_socket_options().

[Severity: Low]

This isn't a runtime bug, but should this fix be split out and sent
separately with a Fixes: tag?

Before this patch, take a socket with SO_BINDTODEVICE plus any other
option that bumps setsockopt_seq (SO_KEEPALIVE, for example).
sync_socket_options() copied the device to the subflow, and then
__mptcp_subflow_connect() reset it to local->ifindex (0) before
kernel_bind().

Here the fix is bundled with the new sk_reuse/sk_reuseport propagation and
has no Fixes: trailer. So it can't go to net/stable on its own, and a
backport would also pull in the new reuse semantics.

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]

This isn't a bug, but the author address (geliang@kernel.org) doesn't
match the Signed-off-by: address (tanggeliang@kylinos.cn). checkpatch
reports this as FROM_SIGN_OFF_MISMATCH. The other patches in the series
seem to have the same mismatch.

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 922f6ae5c80cb..952bc015eee87 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -335,6 +335,8 @@ static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optname,
>  				sk->sk_bound_dev_if = ssk->sk_bound_dev_if;
>  			else if (optname == SO_BINDTOIFINDEX)
>  				sk->sk_bound_dev_if = ssk->sk_bound_dev_if;
> +
> +			sockopt_seq_inc(msk);

[Severity: Medium]

Can this make passive join subflows lose their device or VRF binding?

sockopt_seq_inc() bumps msk->setsockopt_seq here. It does not touch
ctx->setsockopt_seq of the first subflow, which is the socket
sk_setsockopt() was just applied to. Take a server that sets only
SO_REUSEADDR on its listener: the listener msk seq becomes non-zero, but
the listener subflow ctx seq stays 0.

On the passive side, mptcp_sk_clone_init() copies the listener msk seq
into the accepted msk:

	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;

Each MP_JOIN child, however, copies the stale listener subflow seq in
subflow_syn_recv_sock():

	/* ssk inherits options of listener sk */
	ctx->setsockopt_seq = listener->setsockopt_seq;

As a result, __mptcp_finish_join()->mptcp_sockopt_sync_locked() sees a
mismatch and runs sync_socket_options(), which does:

	ssk->sk_bound_dev_if = sk->sk_bound_dev_if;

For an unbound listener, that value is 0.

inet_csk_clone_lock() set the child's sk_bound_dev_if from ireq->ir_iif.
For IPv6 link-local peers this is the ingress ifindex, and with
tcp_l3mdev_accept it is the l3mdev master. Both get overwritten with 0,
and sk_dst_reset() is not called. Once the cached dst is invalidated, the
next route lookup uses oif 0.

Would the subflow then go out the wrong interface or use the wrong
routing table?

The same stale-seq resync could already be triggered by TCP_NODELAY,
IPV6_V6ONLY or the keepalive options. This patch makes it reachable for
the very common server that only sets SO_REUSEADDR. It also seems to work
against the goal of preserving sk_bound_dev_if on subflows.

>  		}
>  		release_sock(sk);
>  		return ret;
> @@ -1706,6 +1708,9 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
>  		assign_bit(b, &inet_sk(ssk)->inet_flags, src & BIT(b));
>  
>  	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
> +
> +	ssk->sk_reuse = sk->sk_reuse;
> +	ssk->sk_reuseport = sk->sk_reuseport;

[Severity: Low]

Now that subflows inherit sk_reuseport, do the uid-based reuseport checks
use the right uid?

mptcp_subflow_create_socket() creates the subflow with sock_create_kern(),
so sk_uid comes from the creator's current_fsuid(). After that, only the
inode ownership is switched:

	SOCK_INODE(sf)->i_uid = SOCK_INODE(sk->sk_socket)->i_uid;
	SOCK_INODE(sf)->i_gid = SOCK_INODE(sk->sk_socket)->i_gid;

Nothing updates sk->sk_uid. Join subflows created from the in-kernel PM
worker therefore carry GLOBAL_ROOT_UID. Subflows created by userspace PM
netlink requests carry the daemon's fsuid.

With sk_reuseport set, kernel_bind()->inet_csk_get_port() uses that uid
in two places:

  - inet_bind_conflict(), through uid_eq(uid, sk_uid(sk2))
  - inet_csk_update_fastreuse(), through tb->fastuid = sk_uid(sk)

For example, a userspace PM subflow with an explicit port could share
that port with root-owned SO_REUSEPORT sockets. Ephemeral buckets created
by in-kernel PM subflows would record fastuid as root.

Before this patch, subflows always had sk_reuseport == 0, so the stale
sk_uid didn't matter. Should sk_uid also be set to the msk owner's uid?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1792470313.git.tanggeliang%40kylinos.cn
