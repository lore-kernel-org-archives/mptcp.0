Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6346449B11
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045428; cv=none; b=KtNG82Q3Urm0cGR827ePnDO2KQfM00qFAlC2srUW0ravRuOCLFxJ7PeDvMxwB8LWc1j1nCMjmYrIMA3ZZh9kcR28pTzx7ih/Opgy5K9+G1ltO1iRpSbJknaKN9cLI06ozaNeXA9hAknOBg69zVFofd48oJE6i+IUH6XoPfzRdrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045428; c=relaxed/simple;
	bh=ERZ7GF+tk6Go+nbNYcSXU0oMgjbw7uVXeOtVkvrj+Q8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bmUL6sPNa4uzAdoCjC2CWGrANg6YjQHI+5Z1Xrjk5ncRcRk431ND2vYSBWGMWbGVFKtivGNFQcPcm2ULb9N0QA45P+nNinm0krBvt1xcayPj7jDo8IPR8X9fMMQ/vCF6HdTsqrkKO+ASa8Ypvgz8M7dg8eurKq/fiWlUHGNXKWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGxqirOO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGxqirOO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C4A1F000E9;
	Tue, 18 Aug 2026 09:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787045426;
	bh=e6HIXFgD5UAqint4/9Fres57tWvq+td+BzvvD7rRlK0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WGxqirOOc8EMKE3F194G574HFVNCcLZ7iNxOkjGcAd3Oev2nK+g8c/ngH8LGMXVtQ
	 mLCguXjVFRF+miJh5RZLCNvV5YhsAsX8oklu9+e1SSxiVI/pxQqIIcXu4WSOkFHfTa
	 bs7k2v5xmc1WkntRJaXJ1+gF/Po93Oy/30V/0NQkfhGhfx1gYsHGXMrraiKyGx7NXT
	 MWWcABsqiMOM7S/sE2KCvIZPlalgiJ+1hD8lHisM045IWCdxvVnYDscQakBcgT/xaX
	 swvMUZFYQZObmJKq7sH6NkXgbVTjNbehAteuEUAB9ZOpOBCqH0h1iF0Mqq9NPt8lqA
	 +VNYWIjbnXFQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next RFC v4 2/2] mptcp: send MP_FAIL and infinite
 mapping on the same ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chenguang Zhao" <chenguang.zhao@linux.dev>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20260818091417.2200986-3-chenguang.zhao@linux.dev>
References: <20260818091417.2200986-1-chenguang.zhao@linux.dev>
 <20260818091417.2200986-3-chenguang.zhao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 09:30:25 +0000
Message-Id: <20260818093026.46C4A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] MP_FAIL is permanently dropped due to TCP options space exhaustion=
 when packed alongside DSS and Timestamps.
- [High] Dropped pure ACKs cause a fatal connection reset because immediate=
 fallback disables MPTCP options on retransmissions.
- [High] The send_infinite_map flag is cleared when transmitting a pure ACK=
, omitting the map from the first data packet if the ACK drops.
--

--- Patch [2]: [PATCH mptcp-next RFC v4 2/2] mptcp: send MP_FAIL and infini=
te mapping on the same ACK ---
commit fa151aec0663a3e5b6abb8fb25a4fd411a972b0a
Author: Chenguang Zhao <zhaochenguang@kylinos.cn>
mptcp: send MP_FAIL and infinite mapping on the same ACK

This commit updates the handling of an MP_FAIL response on a single subflow.
It emits the infinite mapping on the MP_FAIL reply ACK and then immediately
transitions the socket into fallback mode.

> mptcp: send MP_FAIL and infinite mapping on the same ACK
>
> On a single subflow, accepting MP_FAIL must leave MPTCP mode at once
> (RFC8684 =C2=A73.7). Emit the infinite mapping on the MP_FAIL reply ACK,
> then call mptcp_try_fallback() immediately after.

[Severity: High]
If we pack both the MP_FAIL and the infinite mapping on the same ACK,
is there enough TCP options space if timestamps are enabled?

With standard TCP Timestamps (12 bytes), the remaining option space is 28
bytes.

The infinite mapping requires at least 24 bytes (base + 64-bit map + ACK),
leaving at most 4 bytes.

Since MP_FAIL requires 12 bytes, will it fail the space check in
mptcp_established_options() and be silently dropped?

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 2f571766db440..e4f8e976ff163 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c

[ ... ]

> @@ -1567,6 +1589,15 @@ void mptcp_write_options(struct tcphdr *th, __be32=
 *ptr, struct tcp_sock *tp,
>  						   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
>  			}
>  			ptr +=3D 1;
> +
> +			if (unlikely(mpext->infinite_map)) {
> +				subflow =3D mptcp_subflow_ctx(ssk);
> +				if (subflow->send_infinite_map) {
> +					subflow->send_infinite_map =3D 0;

[Severity: High]
Does clearing this flag on a pure ACK risk losing the infinite mapping if
the network drops the packet?

Since TCP does not retransmit pure ACKs, the infinite mapping would need to
be piggybacked on the next data packet.

If we clear the send_infinite_map flag here, will the next data packet fail
to include the mapping and transmit as plain TCP instead?

> +					MPTCP_INC_STATS(sock_net(ssk),
> +							MPTCP_MIB_INFINITEMAPTX);
> +				}
> +			}
>  		}
> =20
>  		/* We might need to add MP_FAIL options in rare cases */

[ ... ]

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index d7c5b50b34cc9..351f9c998d7b6 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -895,6 +895,11 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 =
fail_seq)
>  		pr_debug("MP_FAIL response received\n");
>  		WRITE_ONCE(subflow->fail_tout, 0);
>  	}
> +
> +	if (!mptcp_try_fallback(sk, MPTCP_MIB_MPFAILFALLBACK)) {

[Severity: High]
Does entering fallback immediately after sending the pure ACK prevent
retransmission of MPTCP options if the ACK is lost?

If the initial pure ACK drops, the remote peer will retransmit its MP_FAIL.
When the local stack responds with another pure ACK, skb is NULL.

Because the socket is already in fallback mode, it looks like
mptcp_established_options() will fail the fallback check:

    if (unlikely(__mptcp_check_fallback(msk) && !mptcp_check_infinite_map(s=
kb)))
        return 0;

Could this permanently prevent recovery by omitting the MP_FAIL option on
subsequent ACKs?

> +		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_FALLBACKFAILED);
> +		mptcp_subflow_reset(sk);
> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818091417.2200=
986-1-chenguang.zhao@linux.dev?part=3D2
