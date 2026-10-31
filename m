Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793487476;
	b=jWFN9GS8P+++wq3144TLH2Imo/45rnDZHJ/RhFaU6mnIDshcRWfrCmXxosTex0yBbiBo
	 SrfNB923HNAw2SSFWU9DjIW9XfOrqxmic5v1tCP00WHYaCyNjOqWzJzrelJY812ZFt6Zf
	 T9gI1X7ONZgFqYNaDvVi2QIIzgDlYFP4QRTndCRitnB89CVDghHCVzIid2gv3ZYTA/ya0
	 aqNU+64rreLKRsAJb6/aivH0E0mjXqb126Vk/N/e/4AO4j4WhHMNBCig4JDFTEIHW8ekl
	 SR1PhQyTwBOwObOretbp/2uhXDRltlpcGIcZau4QV6bNZ2NYitTtTKy9eyudF9d2RRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793487476;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iGRJ4yg49hVy907co+S0rPLfB6OWrrKGGhVtYOYO4Jw=;
	b=f5UlSMNXhst8JwkKBw20Uw+yNHoLVU1TTAbSHrlKXb34SeWRtQJO+LL6xLNuBj9Gj0lY
	 LQQ2GkM2uGFcdtU5fxE4W0kpOCal3aNBHH5+JmJERaWUUiAwxw6ICb48IpXBll+8AXBTA
	 ICQbCxe4mLwbIlPdh1AHMSYEWjRJoCWV8vN2CQeHSUIMOhWq3fko/a5/brA7V1+ZT2wbY
	 MJQ6Nk07dS1+UM/wT/1a4wsuVsxZJlAZkK9LtjkgyFHTBpdVJiDo4Gg145RZxprZQmZZT
	 19RyZP57h6/GmmeKqoe6GvX46jSXyI8+oUlAd5zcIfYfU1T9rR596bb+fp9cgAEUGKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="I4l/b2Eu";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6704D606A31A
	for <mptcp@lists.linux.dev>; Sat, 31 Oct 2026 22:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I4l/b2Eu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9DF1F00919;
	Sat, 31 Oct 2026 22:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793487476;
	bh=iGRJ4yg49hVy907co+S0rPLfB6OWrrKGGhVtYOYO4Jw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=I4l/b2EuBlrcnyGHUzVGIi9yoduGQWD+qlRrMUjRllVRN3wBdGQbYXylimt0HHCVA
	 /gzXU0gaaevK1TZXiRbYZrMMf9VJEiVgJwrXMOzvCDifLPyXMqVSHa2mCIxVkH2eyF
	 S3XldMmWssukviQpRho31E/E0qe4y6/L2rZwgOuReYUL+RmjdlMab9qRlAJZVCjFCk
	 H8LUYKiN7uoeGzjq3YDrAyw4FoIykEQ4WbOvcqhlbjgGJSYUwC7zDPSEuR6MLCEdx0
	 vW00A+KdIkg4d50WR7NML6zAz5Z0QN6yUEQ7RzPTLqPZljXQTSFQ3IwjXyAH4oMRGX
	 MNm4mkUDy8UbQ==
Message-ID: <sashiko-outbox-192214@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v2 3/8] mptcp: sched: let get_retrans
 reinject on an idle subflow
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261031-mptcp-sched-opp-retrans-v2-3-e9c4a30f6841@kernel.org>
References: <20261031-mptcp-sched-opp-retrans-v2-0-e9c4a30f6841@kernel.org>
 <20261031-mptcp-sched-opp-retrans-v2-3-e9c4a30f6841@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 22:57:55 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] mptcp: 32-bit overflow in __mptcp_oppr() and mptcp_oppr_send_ran=
ge() budget math
- [Medium] mptcp: __mptcp_oppr() continues to later DSN ranges after partia=
l send failure
--

commit be2c71f8537cecaea5b15cddbe5f79d5a824718f
Author: Abdul Wasey <w453y.me@gmail.com>

mptcp: sched: let get_retrans reinject on an idle subflow

This commit extends the MPTCP scheduler get_retrans callback to support
opportunistic reinjection on an idle subflow when no new data can be sent.
The core collects the unacknowledged DSN ranges held by other subflows and
resends them on the selected subflow up to reinject_limit and one cwnd.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/332 [1]

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index d960ab9c76b32..7117786e52513 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3057,6 +3057,92 @@ static int __mptcp_push_retrans(struct sock *sk, s=
truct mptcp_data_frag *dfrag,
>  	return len;
>  }
> =20
> +/* resend [start, end) on @ssk from the msk rtx queue; < 0 on a send err=
or */
> +static int mptcp_oppr_send_range(struct sock *sk, struct sock *ssk, u64 =
start,
> +				 u64 end, int budget,
> +				 struct mptcp_sendmsg_info *info)
> +{
> +	struct mptcp_data_frag *dfrag;
> +	int copied =3D 0, ret;
> +
> +	list_for_each_entry(dfrag, &mptcp_sk(sk)->rtx_queue, list) {
> +		if (!dfrag->already_sent || !before64(dfrag->data_seq, end))
> +			break;
> +		if (!after64(dfrag->data_seq + dfrag->already_sent, start))
> +			continue;
> +
> +		info->sent =3D before64(dfrag->data_seq, start) ?
> +			     start - dfrag->data_seq : 0;
> +		info->limit =3D min_t(u64, dfrag->already_sent,
> +				    end - dfrag->data_seq);
> +		info->limit =3D min_t(u64, info->limit,
> +				    info->sent + budget - copied);
> +		while (info->sent < info->limit && copied < budget) {
> +			ret =3D mptcp_sendmsg_frag(sk, ssk, dfrag, info);
> +			if (ret <=3D 0)
> +				return copied ? : -1;
> +			copied +=3D ret;
> +			info->sent +=3D ret;
> +		}
> +		if (copied >=3D budget)
> +			break;
> +	}
> +	return copied;
> +}
> +
> +/* Opportunistic reinjection: the scheduling part is in sched.c */
> +static void __mptcp_oppr(struct sock *sk)
> +{
> +	struct mptcp_sendmsg_info info =3D { .data_lock_held =3D true, };
> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
> +	int copied =3D 0, budget, ret, i;
> +	struct mptcp_sched_oppr oppr;
> +	struct sock *ssk;
> +
> +	mptcp_data_lock(sk);
> +	__mptcp_clean_una_wakeup(sk);
> +	oppr.una =3D msk->snd_una;
> +	mptcp_data_unlock(sk);
> +
> +	if (!mptcp_sched_oppr_get(msk, &oppr))
> +		return;
> +
> +	ssk =3D oppr.ssk;
> +	lock_sock(ssk);
> +	/* the scheduler's limit, and no more than one cwnd */
> +	budget =3D min_t(u64, oppr.limit,
> +		       tcp_snd_cwnd(tcp_sk(ssk)) * tcp_sk(ssk)->mss_cache);

[Severity: Medium]
Can the budget calculation in __mptcp_oppr() and mptcp_oppr_send_range()
overflow 32-bit integers when a scheduler sets a large subflow->reinject_li=
mit
on a subflow with a large cwnd?

In __mptcp_oppr(), tcp_snd_cwnd(tcp_sk(ssk)) and tcp_sk(ssk)->mss_cache are
both u32, so their multiplication is evaluated in 32-bit unsigned arithmetic
before min_t(u64, ...) promotes the product to u64, wrapping if the product
reaches 2^32.

In addition, oppr.limit is u32 while budget and copied are signed int. If b=
oth
oppr.limit and the cwnd * mss_cache product are >=3D 0x80000000U (for examp=
le
when a scheduler sets reinject_limit =3D U32_MAX on a high-BDP path), assig=
ning
the min_t(u64, ...) result to signed int budget makes budget negative. The
loop condition copied < budget in __mptcp_oppr() is then immediately false,
skipping reinjection without updating msk->oppr_una.

Similarly, in mptcp_oppr_send_range():

	info->limit =3D min_t(u64, info->limit,
			    info->sent + budget - copied);

info->sent + budget - copied is evaluated as a signed 32-bit int before
min_t(u64, ...) casts it to u64. If budget is near INT_MAX and info->sent >
copied (such as when start > dfrag->data_seq), the signed addition overflows
to a negative int, which sign-extends to a large u64 and fails to clamp
info->limit to the remaining budget.

> +
> +	spin_lock_bh(&msk->fallback_lock);
> +	if (__mptcp_check_fallback(msk) || !msk->allow_subflows)
> +		goto unlock;
> +
> +	for (i =3D 0; i < oppr.n && copied < budget; i++) {
> +		ret =3D mptcp_oppr_send_range(sk, ssk, oppr.r[i].start,
> +					    oppr.r[i].end, budget - copied,
> +					    &info);
> +		if (ret < 0)
> +			break;
> +		copied +=3D ret;
> +	}

[Severity: Medium]
If mptcp_sendmsg_frag() fails partway through sending a DSN range in
mptcp_oppr_send_range(), should __mptcp_oppr() stop rather than continuing =
to
subsequent ranges in oppr.r[]?

In mptcp_oppr_send_range(), when mptcp_sendmsg_frag() returns <=3D 0 (for
example -ENOMEM from sk_wmem_schedule() or 0 when hitting mptcp_wnd_end(msk=
))
after an earlier fragment in the same range already sent data (copied > 0),
it returns the positive copied count via:

	if (ret <=3D 0)
		return copied ? : -1;

Because the loop in __mptcp_oppr() only breaks on ret < 0, a partial send on
oppr.r[i] causes __mptcp_oppr() to advance to oppr.r[i + 1]. If a later,
smaller range succeeds, higher-DSN data is transmitted while leaving an uns=
ent
gap in the earlier range that holds back snd_una, and msk->oppr_una is still
recorded as oppr.una so the failed portion is not retried for this snd_una.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031-mptcp-sche=
d-opp-retrans-v2-0-e9c4a30f6841@kernel.org?part=3D3
