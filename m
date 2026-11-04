Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793812597;
	b=cHwUhV7pjKa/EWiKlQkmDClVP286MITS/doHg6w68pitIFRa7WMES50IC76NBI/+BJ+7
	 zvSk/KUKg0/u3EhLAFKmgJW3QN8Xmy5FW9LZ4SRoceaRSyuRLQwMbn9LO47U1sxopKwGe
	 9dO+lZ1KcuP4GKP1ma2RJUg9cPtT17/m3knx6GjfvyxMJ99IrQ9Q+kL5NaQFF9aEiN5X/
	 ZYMYpqF+tu3kEBbzZd2hZjCwFUceFyhA0hSF15pwGWNqU6zfDCf1z2FDKjie9MGIML5r5
	 us3l5CpLeAUF1O+ynjmNTiLDYP9HOVdCnbJY4dDpmF/1HrWMZKOvZ6xjDz5LG0+Lplg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793812597;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=lxeEhd30M0sTJZ1pznmonnPabPV7DzIFIuDxou7v1MI=;
	b=iBepeSAbsiqi3vwW6xaSqalDXzOEB8DbmPMe4tnvciX2U5qV+zzEgPH6nmc2XRah6ytS
	 Os+y13InSEf/VS8ermSQCkBwdepEIUWWlMiOvR8QRIJ8JfVT0Xg4G73NRVVhylJ2csDzx
	 3ivOcbK/Z82AjowJCcIeSMeIBBi9FDwFYy+YDVwAW4/YPTHrifJiOgtfAKrH6co5r7JH3
	 HQg2xN5u/8ZuLjBAJm/PP0Z/TA7FzJ6eLhntYqPSAFmYm7QBywQLyIUvDKLCX0etVwhO8
	 lE/Bwp2t06rZUnI1fIHO2s7airm3atS6ya8PyOx2HNhHZQC3O/d4uo1xikKDHzVQXdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bl6295R1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC5F606A328
	for <mptcp@lists.linux.dev>; Wed,  4 Nov 2026 17:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bl6295R1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5419C1F000C1;
	Wed,  4 Nov 2026 17:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793812596;
	bh=lxeEhd30M0sTJZ1pznmonnPabPV7DzIFIuDxou7v1MI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Bl6295R1YoH5u8bjKyGbNgACZGgnjlnuJdXhndPBC30D0CMCKasBBhLBJGixGavu5
	 u4u1mYqUvI4LGgESHtc5eOfWzPZNxa2Dw5mIGqd8lHTAZ7qtOzjzkJ7oSJsD9o5peI
	 AtG2hNJs62obKNMgFkh3nxh9605Inq9wY/0xZHmB3+hLzvOlH8mDQnl6oh2SVrECCx
	 IFbVhhzfuuClt/e/kyp7fK3/8WYrel9k7GLLDmgo08+oMKzr+x/giKALmsAb+Rg6Lp
	 vpnIbeWU9GQkC2ttxsg7jddU7FdUzVcVbZD5erAFBXUc7/fK6wJYS0R1lAOUGXlTzG
	 kQdyGAPme4NBQ==
Subject: Re: [PATCH mptcp-next v5 4/7] mptcp: implement peek_len for proto_ops
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Wed, 04 Nov 2026 17:16:35 +0000
Message-ID: <179381259589.488855.387291530229407590@kernel.org>
In-Reply-To: <52dd6aede4a899de3ab622bf7329a95521e9770f.1793676064.git.tanggeliang@kylinos.cn>
References: <52dd6aede4a899de3ab622bf7329a95521e9770f.1793676064.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The new mptcp_inq() in net/mptcp/protocol.c (used only by the new
  mptcp_peek_len() for proto_ops.peek_len) repeats the core of the…
- [Low] The commit author is `Geliang Tang <geliang@kernel.org>`, but
  Geliang's only Signed-off-by on commit "mptcp: implement peek_len for…

--

mptcp: implement peek_len for proto_ops

This commit adds mptcp_inq(), which uses mptcp_data_avail() to compute the
readable bytes at the MPTCP level. It wires mptcp_inq() into a new
mptcp_peek_len() callback set in both mptcp_stream_ops and
mptcp_v6_stream_ops. It prepares for upcoming kTLS and sockmap support.

> Co-developed-by: Zqiang <qiang.zhang@linux.dev>
> Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
This isn't a bug, but the author line is Geliang Tang <geliang@kernel.org>,
while Geliang's only sign-off here uses tanggeliang@kylinos.cn. checkpatch
reports this as FROM_SIGN_OFF_MISMATCH.

The first patch in the series ("mptcp: update mptcp_check_readable") signs
off with geliang@kernel.org.

Could the addresses be made consistent? Either a matching Signed-off-by or
an in-body From: line would work.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 1704e689bc938..aed25c901e4b1 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -4791,6 +4791,26 @@ static ssize_t mptcp_splice_read(struct socket *sock, loff_t *ppos,
>  	return ret;
>  }
>  
> +static int mptcp_inq(struct sock *sk)
> +{
> +	const struct mptcp_sock *msk = mptcp_sk(sk);
> +	u64 avail;
> +
> +	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
> +		return 0;
> +
> +	avail = mptcp_data_avail(msk);
> +	if (avail >= INT_MAX)
> +		return INT_MAX;
> +
> +	return (unsigned int)avail;
> +}

[Severity: Low]
Does this need to be a separate copy of mptcp_inq_hint()? The core of that
existing helper in net/mptcp/protocol.c does the same computation:

net/mptcp/protocol.c:mptcp_inq_hint() {
	u64 hint_val = mptcp_data_avail(msk);

	if (hint_val >= INT_MAX)
		return INT_MAX;

	if (!hint_val &&
	    (sk->sk_state == TCP_CLOSE || (sk->sk_shutdown & RCV_SHUTDOWN)))
		return 1;

	return (unsigned int)hint_val;
}

The two helpers differ in ways the commit message does not mention.

mptcp_inq() returns 0 in SYN_SENT/SYN_RECV and leaves out the end-of-file
hint of 1. That matches tcp_inq(), so it looks right for peek_len, but the
difference isn't documented.

SIOCINQ also drains the backlog before it reads the counters:

net/mptcp/protocol.c:mptcp_ioctl() {
	...
	case SIOCINQ:
		...
		lock_sock(sk);
		if (mptcp_move_skbs(sk))
			mptcp_cleanup_rbuf(msk, 0);
		*karg = mptcp_inq_hint(sk);
		release_sock(sk);
	...
}

mptcp_peek_len()->mptcp_inq() reads mptcp_data_avail() without the socket
lock and without draining msk->backlog_list.

While skbs are still waiting on the backlog, can peek_len report fewer bytes
than SIOCINQ for the same socket? For TCP, tcp_peek_len() and SIOCINQ both
return tcp_inq(), so the two values cannot differ this way.

For a consumer such as strp_peek_len(), this would only delay parsing until
the next data_ready. There is also no in-tree MPTCP user of peek_len yet.

Separately, the earlier commit "mptcp: use mptcp_data_avail in
mptcp_inq_hint" says it "aligns mptcp_inq_hint() with mptcp_inq()".
However, mptcp_inq() is only added by this patch, and the two helpers are
still separate copies at the end of the series.

Could mptcp_inq_hint() be built on mptcp_inq() plus the end-of-file hint?
If not, could the reasons for leaving the backlog drain and the end-of-file
hint out of peek_len be documented?

> +
> +static int mptcp_peek_len(struct socket *sock)
> +{
> +	return mptcp_inq(sock->sk);
> +}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793676064.git.tanggeliang%40kylinos.cn
