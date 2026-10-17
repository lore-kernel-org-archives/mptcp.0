Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E16014F70
	for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 00:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792196167; cv=none; b=r/C/nt+zpQOJ87AWi28KTdS8PECGJd5qnb63f002hi7J8rAk7bPtKcHATXySUdfCS+klZqOCcB1lToo1oPzKUnZk29QasMUphTQnL5XDbl7GUYQO5go4XthcLrqQIWf1XPxgdN1nrMTpIOqqBId0wUncfbqxCBNn5TbhswR0j2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792196167; c=relaxed/simple;
	bh=/tuwoKA1YSuiF3phdw6u/hGyYaQcTTTSNj3Y4EG2img=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E9xquT4TDbMzeC/DSbUTkX/R6YfTJKnvskYmZMKtb5cYcdKsjsPTuBWp8PTgPyT5UxA7F3lHKTVRWhO0qEe4fseFrqFYG+gl3wKKD6xJsT28pSv6Npew/6mzWC42JS1zRW/hJv+hZT4FQIi+gMhxKzcSdVJPC6sdSxgJ4KnnHS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghLnJ4UF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghLnJ4UF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2716A1F000C4;
	Sat, 17 Oct 2026 00:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792196166;
	bh=oWEgHFjrlSv6ejZFWJf4V9ddOEqw66h8AaYRaKiF69E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ghLnJ4UFOXUrx0qXyQ8f+kMh5tHUGcoJ8vVFsPsuL37HzVEaA854w3IvlwdiAiHog
	 W7DSyjpIuVGe1o22xOIRNTmlFGieO4QHRPP8kIEkvZOqVIKwIfoS3e+qVgrKZQS2nf
	 VQqzx5ZdGKchHl+RvN2idUDGAxZu4dx+3wv827nZU7oL06Vda/aOdZQbC+NRupMAFX
	 Dlo6QvQAJtPbssfiBopiJNZUd+W7CJ5uie/ljPcm1+TfJWg6IV9EJS7bCBX1qWnasb
	 82H4d/8PyZAqfbbx17R7A24jeItII+YRkY4ZZmHNB8OtfpSSZIeBpTmtv6TWTt4ZPx
	 Egm+ygDdDgewA==
Subject:
 Re: [PATCH net-next v9] mptcp: normalize seq numbers reported in mptcp_info
From: netdev-bot+sashiko@kernel.org
To: kalpan.jani@mpiricsoftware.com
Cc: mptcp@lists.linux.dev, shardul.b@mpiricsoftware.com, janak@mpiric.us,
 kalpanjani009@gmail.com, kuba@kernel.org
Date: Sat, 17 Oct 2026 00:16:05 +0000
Message-ID: <179219616568.3135.11934165875223757638@kernel.org>
In-Reply-To: <20261015101303.144541-1-kalpan.jani@mpiricsoftware.com>
References: <20261015101303.144541-1-kalpan.jani@mpiricsoftware.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] After the patch, the MPTCP diag ABI uses two different
  baselines for the same data-sequence space.
- [Medium] In mptcp_diag_fill_info() (net/mptcp/sockopt.c) each baseline
  and the value it is subtracted from are not read as one consistent…

--

mptcp: normalize seq numbers reported in mptcp_info

This patch adds local_idsn and remote_idsn baselines to struct mptcp_sock.
mptcp_diag_fill_info() now reports mptcpi_write_seq, mptcpi_snd_una and
mptcpi_rcv_nxt relative to those baselines. The baselines are set in
mptcp_connect(), mptcp_sk_clone_init() and subflow_set_remote_key().

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/445

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

[Severity: Medium]
Can this subtract a baseline from a value that belongs to a different
connection?

local_idsn is read under lock_sock_fast(), and that lock is dropped before
snd_una is read under mptcp_data_lock(). mptcp_data_lock() is only
spin_lock_bh(&sk->sk_lock.slock). It does not exclude a task that already
owns the socket through lock_sock().

mptcp_connect() runs under the owner lock and writes the baseline and
snd_una without taking the data lock:

net/mptcp/protocol.c:mptcp_connect() {
    ...
	WRITE_ONCE(msk->local_idsn, subflow->idsn);
	WRITE_ONCE(msk->write_seq, subflow->idsn);
	WRITE_ONCE(msk->snd_nxt, subflow->idsn);
	WRITE_ONCE(msk->snd_una, subflow->idsn);
    ...
}

Suppose the diag reader reads local_idsn before this runs and snd_una
after it. local_idsn is 0 on a fresh socket, or the previous IDSN after
connect(AF_UNSPEC). mptcpi_snd_una would then be either the raw new IDSN
or new_idsn - old_idsn.

mptcp_disconnect() has a similar problem. It clears can_ack and ack_seq at
separate points, again holding only the owner lock:

net/mptcp/protocol.c:mptcp_disconnect() {
    ...
	WRITE_ONCE(msk->can_ack, false);
    ...
	/* for fallback's sake */
	WRITE_ONCE(msk->ack_seq, 0);
    ...
}

If the reader sees can_ack == false while ack_seq still holds the old
absolute value, mptcpi_rcv_nxt exports the raw remote DSN. If it sees
can_ack == true and then ack_seq == 0, it reports 0 - remote_idsn, which
wraps to a huge 64-bit value.

getsockopt(MPTCP_INFO), MPTCP_FULL_INFO and inet_diag all call
mptcp_diag_fill_info() without holding the msk socket lock. INET_DIAG_INFO
also does not require CAP_NET_ADMIN.

Could this briefly expose the "raw connection-level values" that the commit
message says are no longer exposed? One option is to read each baseline and
its value inside a single section that excludes the owner. Another is to
have connect and disconnect update these fields under the data lock.

> +	info->mptcpi_rcv_nxt = msk->ack_seq - remote_idsn;

[Severity: Medium]
With this change, mptcpi_rcv_nxt is relative to remote_idsn. However,
subflow_get_info() in net/mptcp/diag.c still exports the absolute map_seq:

net/mptcp/diag.c:subflow_get_info() {
    ...
	     nla_put_u64_64bit(skb, MPTCP_SUBFLOW_ATTR_MAP_SEQ, sf->map_seq,
			       MPTCP_SUBFLOW_ATTR_PAD) ||
    ...
}

subflow_set_remote_key() initializes both subflow->map_seq and
msk->ack_seq from subflow->iasn, so the two values share one remote DSN
space. A single inet_diag dump of an MPTCP connection can now show
rcv_nxt as roughly 1 + N alongside map_seq as roughly iasn + N. Before
this patch both values were absolute and could be compared directly.

remote_idsn and local_idsn are not exported anywhere. How would userspace
match a subflow mapping against the connection-level rcv_nxt?

Should MPTCP_SUBFLOW_ATTR_MAP_SEQ be normalized in the same way? If not,
could the switch from absolute to relative values be documented next to
struct mptcp_info in include/uapi/linux/mptcp.h?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015101303.144541-1-kalpan.jani%40mpiricsoftware.com
