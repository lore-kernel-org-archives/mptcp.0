Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2933A2EB84E
	for <mptcp@lists.linux.dev>; Wed, 12 Aug 2026 06:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786514824; cv=none; b=nYhNnPF0MDb/f/JddKA0Zz7f0iFwWKP+VdvahdVDHxU1nibCG6Ft6lVFNJejh48dAf22kUIttyrVBAF5ou+c2t5kh4+svAH0zf3BUba1ZVDaNf8k9yvolDSS3e5pMosXLxphZlI1fBdql9l1ZlvWlKCfD0TwZrDz5s3Np6ol4+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786514824; c=relaxed/simple;
	bh=4+X+9JconcqGhBUZHfQMNOJSWgIuG1LWGOlSOa57J+k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oOSZNJ1oSvmuOQdpm4wHP11Xy64fEoHJfdfDdGz8KE8pD/hmwA4HLGtanyjFMbnD5VBqvW5Rw8byifZ/q+lLuBKR8FlbSCquOdV7VuxJd7fCAw7To1BllzSULrcOSgliBLPcFttYDPEFQ5d5pVXTwDTrETo33QQKEu9c1iWuWAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7AJP2l5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7AJP2l5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93AD1F000E9;
	Wed, 12 Aug 2026 06:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786514822;
	bh=Zr0z4bCMNR/dSx0/ws2pvrVSt34Y01Q0xGeEDrlfvNU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C7AJP2l5jY42fMatP0XzyME0hRLSq4qA9TkFjG/fkR6OGWgBPGl0VPofGCCJDDP+j
	 V9dqVxRunvRuqSEvMPkEIc05WNtZeXRRgJsZmJHxlQ/rCqLXXcay08rQf6TFUIXrff
	 DnEp8ojq681SsPogRsov2ms/wQbBnThP9nkelpF7VoNOyLmWGTjp6cP5i3xAlxwmM/
	 qEHfhCxoLCJZA89g7g+z2bgXbwr5YfOd5dJKv32IrhdVE2nNQ5/4H+NcoUZfw+makm
	 wTE1dR/rtzFAh/MuEtNeQg+iF06KafV+wn/ySvT7R5WXi1gdP51XtIb0afcGAgdZE3
	 qdymMGJUviTFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH export v3 3/4] mptcp: reset subflow on MP_FAIL when OoO
 queue is non-empty
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chenguang Zhao" <chenguang.zhao@linux.dev>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260812054653.43799-4-chenguang.zhao@linux.dev>
References: <20260812054653.43799-1-chenguang.zhao@linux.dev>
 <20260812054653.43799-4-chenguang.zhao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 06:07:02 +0000
Message-Id: <20260812060702.B93AD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] TOCTOU race due to lockless access of `msk->out_of_order_queue`.
--

--- Patch [3]: [PATCH export v3 3/4] mptcp: reset subflow on MP_FAIL when O=
oO queue is non-empty ---
commit fe6cef2f543d25c806aed2ee11c8a4d7a936c259
Author: Chenguang Zhao <zhaochenguang@kylinos.cn>

mptcp: reset subflow on MP_FAIL when OoO queue is non-empty

This commit updates the handling of an MP_FAIL response to reset the subflow
instead of falling back when the out-of-order queue is not empty. This is d=
one
to ensure the contiguous data requirements for infinite mapping are met.

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index ba7c6f80a183c..8c263084db7be 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -882,6 +882,16 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 =
fail_seq)
>  		spin_unlock_bh(&msk->fallback_lock);
>  		return;
>  	}
> +
> +	/* RFC8684 =C2=A73.7: Infinite mapping requires contiguous data */
> +	if (!subflow->fail_tout &&
> +	    !RB_EMPTY_ROOT(&msk->out_of_order_queue)) {

[Severity: High]
Can this lockless check of the out-of-order queue lead to a race condition?

Looking at mptcp_pm_mp_fail_received(), the out_of_order_queue is checked
for emptiness while only holding msk->fallback_lock, without the required
mptcp_data_lock.

If another active subflow concurrently receives out-of-order data, acquires
the msk data lock, and inserts data into the queue, this check might
incorrectly conclude the queue is empty.

If the queue is populated right after this lockless check but before
mptcp_try_fallback() is called, could this cause an infinite map TCP ACK to
be incorrectly transmitted before the fallback is ultimately aborted?=20

Furthermore, if the queue is populated immediately after fallback occurs,
could this stranded MPTCP out-of-order data be improperly appended to the
plain TCP receive queue as the stream advances, resulting in data duplicati=
on
and stream corruption?

> +		spin_unlock_bh(&msk->fallback_lock);
> +		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_FALLBACKFAILED);
> +		mptcp_subflow_reset(sk);
> +		return;
> +	}
> +
>  	msk->allow_subflows =3D false;
>  	spin_unlock_bh(&msk->fallback_lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812054653.4379=
9-1-chenguang.zhao@linux.dev?part=3D3
