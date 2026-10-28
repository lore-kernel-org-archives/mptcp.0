Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793216463;
	b=rO05MSOJMcEeQOL9UrI0svgmUa0Slq5nR/SSyHlHewcYgJ1rziu8E/KOpzEHIIuaNYQM
	 9vk/3wjJK7196VVkaueYlkYvrUU/69obR4KBykGqJ5UStp2qXk4JUdVp8ca3WAdbSnGEi
	 Wum8xANCd9TgRPSx8ywrbzvGqtWDA9oUwKtNAo3w15OE0idP34RcRHsdFoO2itFXqGWZO
	 Lw+/elnFsyxnmQKj7q+TGe2a17FJFWPoKDIboLx8dhLq+c2GSKMO+cQ9or26gosMk3Fp4
	 lF1/x74JwMF7dZdJuT6630ZvHix8KWylGhJwoHNypMFaCKfsNJu3iWWY6iovvUVQ3Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793216463;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=z1oH9nVXlfEJguFMjU2Q4+RBBImfUJG3G8ntqUgh6vw=;
	b=M9/JtipJRXEqmV0eCajpzC1QrdZvdKFfQnwzknnDCNGcgK7Z23zB4oDBuotsvYRag3WC
	 Ls/vvhy5p/fw/KOja6BMIYaBesxyV3L48BVGoccSFTLtwItRG5PRryeZzPZOwBWhfNc1C
	 AC4rO8PKY6cgNzh3VBkQhDcopn7P5V7t2aRpCNMFmDYH7zozNLUnTQIgWWsYuXum9wFvG
	 dcTM4dU6ailVnGHELJuUIE76jX+dyuZd9GuAmO2c0nHYgWfNfTjtxsOCza8m3cXzdzzFE
	 yqfYDByqjXbOUnVXTtf+CdlQNVC+AlNc2JUYNd9T7Z3X/9r21CRjI5kuudcZSOkqMgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d63i97x3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A58F606A331
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 19:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d63i97x3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9001F01825;
	Wed, 28 Oct 2026 19:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793216463;
	bh=z1oH9nVXlfEJguFMjU2Q4+RBBImfUJG3G8ntqUgh6vw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=d63i97x3uUMJ1ppnY5onUw3EyL2DyL0xvLRVH2sfhPIgXJfxvEh1F4LSOdD79ugD0
	 UqI3TUiU19DMbVKQI4RFRQw/bZyUgQ/CpF+BGASkwiEHtpb3ZCvHs9+8f4cFlp7Sdc
	 WR9RG1H6mAk1VchyBcm1nBmgR/vt0RZ0Bpg44FL8tzjWdeeh65/QJCa/nlS5a0rMPb
	 LSWJ7c4R/7D0/mK6j7jv6DVKcAUCQlh+t6qcv2lV32E3Y8dWxojLwERqGdGE446EWJ
	 ev58oaklXtqI2TCgSPfVCZY+cqPqibukY6LzmNkVzOKJeS3s5GqB4LmUJyQ2czD1gR
	 5esg9DsHAVu0w==
Subject:
 Re: [RFC net-next v10] mptcp: normalize seq numbers reported in mptcp_info
From: netdev-bot+sashiko@kernel.org
To: kalpan.jani@mpiricsoftware.com
Cc: mptcp@lists.linux.dev, shardul.b@mpiricsoftware.com, janak@mpiric.us,
 kalpanjani009@gmail.com, kuba@kernel.org
Date: Wed, 28 Oct 2026 19:41:02 +0000
Message-ID: <179321646231.3132.10355145486034253199@kernel.org>
In-Reply-To: <20261027062750.2095515-1-kalpan.jani@mpiricsoftware.com>
References: <20261027062750.2095515-1-kalpan.jani@mpiricsoftware.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] subflow_get_info() (net/mptcp/diag.c:39-42) adds a new read
  through the subflow context into the parent msk:…
- [Medium] The two places that normalize against msk->remote_idsn
  disagree on when it is valid, and remote_idsn is not reset when the…
- [Low] mptcp_diag_fill_info() (net/mptcp/sockopt.c) reads the local_idsn
  baseline (line 1012) inside a lock_sock_fast() section, releases the…
- [Low] subflow_get_info() (net/mptcp/diag.c:40) treats `sf->map_seq ==
  0` as 'no mapping' and exports 0 without normalizing.

--

mptcp: normalize seq numbers reported in mptcp_info

This patch adds local_idsn and remote_idsn baselines to struct mptcp_sock.
It uses them to normalize mptcpi_write_seq, mptcpi_snd_una and
mptcpi_rcv_nxt, and zeroes those fields in INET_DIAG_INFO for callers
without CAP_NET_ADMIN. It also normalizes MPTCP_SUBFLOW_ATTR_MAP_SEQ
against remote_idsn, and passes a net_admin flag to the idiag_get_info
callbacks.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/445

> diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
> index 70cf9ebce8338..590cdee419ef9 100644
> --- a/net/mptcp/diag.c
> +++ b/net/mptcp/diag.c

[ ... ]

> @@ -35,6 +36,11 @@ static int subflow_get_info(struct sock *sk, struct sk_buff *skb, bool net_admin
>  		goto nla_failure;
>  	}
>  
> +	map_seq = 0;
> +	if (sf->conn && sf->map_seq)
> +		map_seq = sf->map_seq -
> +			  READ_ONCE(mptcp_sk(sf->conn)->remote_idsn);

[Severity: High]
Can this READ_ONCE() read from an mptcp_sock that has already been freed?

Before this patch, subflow_get_info() only read fields of the subflow
context, and that context is freed with kfree_rcu(). The new line follows
sf->conn into the parent msk. Nothing in the diag path seems to guarantee
that the ctx still holds its reference on sf->conn at this point.

The dump path reaches here like this:

inet_diag_dump_icsk()
  sk_diag_fill()          /* ssk held only by refcount, ehash lock dropped */
    inet_sk_diag_fill()
      tcp_diag_get_aux()  /* reads icsk->icsk_ulp_ops without the lock */
        tcp_diag_put_ulp()
          subflow_get_info()
            lock_sock_fast(sk);
            sf = rcu_dereference(inet_csk(sk)->icsk_ulp_data);

Suppose the subflow is destroyed between the icsk_ulp_ops read and
lock_sock_fast(). The teardown then runs:

tcp_done()
  inet_csk_destroy_sock()
    tcp_v4_destroy_sock()
      tcp_cleanup_ulp()
        subflow_ulp_release()

and subflow_ulp_release() does:

	sk = ctx->conn;
	if (sk) {
		...
		sock_put(sk);
	}

	mptcp_subflow_ops_undo_override(ssk);
	if (release)
		kfree_rcu(ctx, rcu);

tcp_cleanup_ulp() only clears icsk->icsk_ulp_ops. icsk_ulp_data and
ctx->conn are left in place, and subflow_get_info() does not check
icsk_ulp_ops again after it takes the lock.

If the user has already closed the msk, that sock_put() can drop the last
reference. Connected msks are not SOCK_RCU_FREE, because
mptcp_sk_clone_init() does:

	sock_reset_flag(nsk, SOCK_RCU_FREE);

So the rcu_read_lock() in subflow_get_info() would not keep the msk alive.

This read also happens before the net_admin check, so an unprivileged
dump such as ss -ti could reach it. A CAP_NET_ADMIN requester would also
get the stale value back as MAP_SEQ.

[Severity: Medium]
Should this be gated on msk->can_ack, as mptcp_diag_fill_info() does?

mptcp_diag_fill_info() only uses remote_idsn for mptcpi_rcv_nxt when
can_ack is set:

	if (READ_ONCE(msk->can_ack))
		remote_idsn = READ_ONCE(msk->remote_idsn);

Here, remote_idsn is subtracted whenever sf->map_seq is non-zero.

remote_idsn is also not reset on disconnect. mptcp_disconnect() clears
can_ack and ack_seq:

	WRITE_ONCE(msk->can_ack, false);
	...
	/* for fallback's sake */
	WRITE_ONCE(msk->ack_seq, 0);

local_idsn and remote_idsn are only zeroed in __mptcp_init_sock(), which
does not run on that path.

Consider this sequence:

socket(IPPROTO_MPTCP)
connect() to an MPTCP peer     /* subflow_set_remote_key() sets remote_idsn */
connect(AF_UNSPEC)             /* mptcp_disconnect() */
connect() to a non-MPTCP peer  /* fallback, remote key never set */

The first subflow's iasn and map_seq were reset, so in fallback
subflow_check_data_avail() rebuilds map_seq starting from iasn == 0:

	subflow->map_seq = __mptcp_expand_seq(subflow->map_seq,
					      subflow->iasn +
					      TCP_SKB_CB(skb)->seq -
					      subflow->ssn_offset - 1);

MAP_SEQ would then be a small value minus the stale remote_idsn, which
wraps. For the same socket, mptcpi_rcv_nxt is reported as ack_seq - 0.

That seems to contradict this part of the commit message:

    Normalize MPTCP_SUBFLOW_ATTR_MAP_SEQ against remote_idsn as well, so
    subflow mapping sequence numbers use the same remote sequence space as
    mptcpi_rcv_nxt.

Should mptcp_disconnect() also reset local_idsn and remote_idsn?

[Severity: Low]
Is sf->map_seq == 0 a reliable test for "no mapping"?

get_mapping_status() stores whatever mptcp_expand_seq() returns and marks
the mapping valid:

	subflow->map_seq = map_seq;
	subflow->map_subflow_seq = mpext->subflow_seq;
	subflow->map_data_len = data_len;
	subflow->map_valid = 1;

So once the 64-bit data sequence space wraps, a valid mapping can start
at absolute DSN 0. With remote_idsn = 2^64 - k, that mapping's relative
sequence is k, but MAP_SEQ would be reported as 0. The peer picks its own
key, so it can make its IDSN close to 2^64.

Could the check use something other than the numeric sequence value?

>  	if (sf->mp_capable)
>  		flags |= MPTCP_SUBFLOW_FLAG_MCAP_REM;
>  	if (sf->request_mptcp)

[ ... ]

> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index fcf6feb2a9eb5..b1e41c967157e 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c

[ ... ]

> @@ -1008,9 +1009,11 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
>  	info->mptcpi_flags = flags;
>  
>  	slow = lock_sock_fast(sk);
> +	local_idsn = READ_ONCE(msk->local_idsn);
> +
>  	info->mptcpi_csum_enabled = READ_ONCE(msk->csum_enabled);
>  	info->mptcpi_token = msk->token;
> -	info->mptcpi_write_seq = msk->write_seq;
> +	info->mptcpi_write_seq = msk->write_seq - local_idsn;

[ ... ]

> @@ -1023,17 +1026,20 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
>  	unlock_sock_fast(sk, slow);
>  
>  	mptcp_data_lock(sk);
> +	if (READ_ONCE(msk->can_ack))
> +		remote_idsn = READ_ONCE(msk->remote_idsn);
>  	info->mptcpi_last_ack_recv = jiffies_to_msecs(now - msk->last_ack_recv);
> -	info->mptcpi_snd_una = msk->snd_una;
> -	info->mptcpi_rcv_nxt = msk->ack_seq;
> +	info->mptcpi_snd_una = msk->snd_una - local_idsn;
> +	info->mptcpi_rcv_nxt = msk->ack_seq - remote_idsn;

[Severity: Low]
Can the baseline and the counter here come from different connections?

local_idsn is read under lock_sock_fast(), the lock is dropped, and
snd_una is read later under mptcp_data_lock(). mptcp_connect() writes all
of these while holding only the msk owner lock:

	WRITE_ONCE(msk->local_idsn, subflow->idsn);
	WRITE_ONCE(msk->write_seq, subflow->idsn);
	WRITE_ONCE(msk->snd_nxt, subflow->idsn);
	WRITE_ONCE(msk->snd_una, subflow->idsn);

Holding the owner lock does not exclude a data lock holder.

Suppose another thread calls connect() between the two critical sections
on a fresh socket. The reader then holds local_idsn == 0 and reports the
absolute IDSN as mptcpi_snd_una. Across a disconnect and reconnect, the
result is the difference between two unrelated baselines.

mptcp_disconnect() also clears can_ack, and later ack_seq, without the
data lock. mptcpi_rcv_nxt can therefore combine can_ack == false with the
old ack_seq, or the old remote_idsn with ack_seq == 0.

mptcp_getsockopt_info() calls mptcp_diag_fill_info() without the socket
lock and copies the result out as is. Could the baselines and the
counters be sampled under one consistent lock?

>  	info->mptcpi_bytes_acked = msk->bytes_acked;
>  	mptcp_data_unlock(sk);
> +
>  }

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261027062750.2095515-1-kalpan.jani%40mpiricsoftware.com
