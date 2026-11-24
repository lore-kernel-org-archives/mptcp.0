Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795559782;
	b=H9NZ4+srZH3mhc3jjqpWK7mD9fUF5kGt+olUT/Pm0rCc7wmr2ISiVT4JWS0laibNh14f
	 z8rUgCM4uvvtAC7uSt0t3SRWm4d92koLUGPyBgiSsq2cHJoR8O7bUXay22VpHJ7n4MhKS
	 qaKOyLturCFQjdNqsh2m6hrRyzaLK4DTxCJ612N3T8AjIEkY0otS4EQNN1JVytMIEihJb
	 kgXYkexaRaSMcnGpiIT6VBLjnZR3wrLDOWSeo1ptBvk+GRACB8RjfwdMT3dm/BKQ39HYB
	 LboQeumPXYvJd3lxOrCyJbzD3IrYa9yr8rDg5wSpP2FE9U97NILEi9Y74nafGPLd07w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795559782;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9FGsiOYkk4skWHVXTrxLh3Jvp88t2/xr6/jY8uWr8zk=;
	b=Hu1FaSOYgtGwp89BznQBXFPGRGpFWWniGyHp4lFb1y4yEKJY7xxr24O2brTeemBkD3wM
	 OUwPn7d+b9I+IA3WtCygNvtMcB4R29Phx/lS3TwllWxkOc2HOYQyb12gs0939ghVnOOTv
	 UUQKd/vlcEvH8zQbePLUv+gIWfDIUHLiiHDitRnGB4R2FPrPujOHxCTrt3xhxdiEBVj+h
	 xG144KUR1PlFfx8GRFV4GHJvOzv57PxyfN8BUzk6Rtq1xoBSswXVWCg71kOug0aeo4t+R
	 4PrnuGkWaGBuaEgH2P4RJYF9gs66Cf/fqO0Ymm22CHbWAdhntZ0JnmJlPnIS3UJZSLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QMRA3R/p";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF624606A31E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 22:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QMRA3R/p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D571F000C0;
	Tue, 24 Nov 2026 22:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795559782;
	bh=9FGsiOYkk4skWHVXTrxLh3Jvp88t2/xr6/jY8uWr8zk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=QMRA3R/plDsoeh60t5tucEaZxIzvcCCKgTXGZksXsIKBOurBsybNpGgCTRy65PIyn
	 KctgQ8e0s30U1oR9SQP5JAlnOf7Lg36AP7tgrahXs16XXHrqHMjaxFMajeZfKaQa8B
	 tmRbrdKq5NXFotwwNKfblnPzOTF7D74Me1zzR9k2Gw8cECF2eLZP8oMMyx37Ej3PVe
	 mreFkirKz2B1PKkNddyeX2k5b/ZZGvSYTmCdEAgSY0eeSnX9ZsbdA0JC7g3voLkHwi
	 vQ5IMl6+QmtkNaNYBcBacI2u/FD41wB/VT+a+m60gwh8LYx9yP/2jojqCIHjE1+vSh
	 +1X/M6jwwycIg==
Message-ID: <sashiko-outbox-232142@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC mptcp-next mptcp-net v3 50/50] mptcp: reset when the
 DSS disappears after a DATA_ACK
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-50-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-0-416c0920c73f@kernel.org>
 <20261124-mptcp-cmason-fixes-v3-50-416c0920c73f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 22:36:22 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] mptcp: fallback after dss_confirmed in mptcp_dss_corruption()
  on partial map
--

commit 52bcf0ed394d73280e0a61e58a2314837d68feb0
Author: Matthieu Baerts (NGI0) <matttbe@kernel.org>

mptcp: reset when the DSS disappears after a DATA_ACK

This commit tracks whether a received DATA_ACK has acknowledged sent data
on a subflow and resets the subflow instead of falling back to TCP when a
subsequent packet lacks a DSS mapping or has an invalid mapping.

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 190c75311ff69..efbd3efd379ed 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
[ ... ]
> @@ -1523,7 +1542,9 @@ static bool subflow_check_data_avail(struct sock *s=
sk)
>  			return true;
>  		}
> =20
> -		if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSFALLBACK)) {
> +		if (((status =3D=3D MAPPING_NODSS || status =3D=3D MAPPING_INVALID) &&
> +		     subflow_nodss_is_fatal(msk, subflow)) ||
> +		    !mptcp_try_fallback(ssk, MPTCP_MIB_DSSFALLBACK)) {
>  			/* fatal protocol error, reset the subflow and let the
>  			 * worker close it
>  			 */

[Severity: Medium]
Can an skb that starts within the current mapping but extends past
subflow->map_data_len (for example, after middlebox resegmentation or
coalescing) still trigger a fallback after subflow->dss_confirmed is set?

In get_mapping_status(), validate_mapping() only checks that the starting
subflow sequence number lies within the active mapping range, without
verifying that the mapping covers the full skb length:

net/mptcp/subflow.c:validate_mapping() {
	...
	if (unlikely(before(ssn, subflow->map_subflow_seq))) {
		...
		return false;
	}
	if (unlikely(!before(ssn, subflow->map_subflow_seq +
				  subflow->map_data_len))) {
		...
		return false;
	}
	return true;
}

get_mapping_status() therefore returns MAPPING_OK, bypassing
subflow_nodss_is_fatal() in subflow_check_data_avail().  When
__mptcp_move_skbs_from_subflow() then sees map_remaining < len, it calls
mptcp_dss_corruption(), which calls mptcp_try_fallback() directly without
checking subflow->dss_confirmed:

net/mptcp/protocol.c:mptcp_dss_corruption() {
	if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSCORRUPTIONFALLBACK)) {
		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCORRUPTIONRESET);
		mptcp_subflow_reset(ssk);
	}
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-mptcp-cmas=
on-fixes-v3-0-416c0920c73f@kernel.org?part=3D50
