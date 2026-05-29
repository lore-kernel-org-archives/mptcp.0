Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D043546C6
	for <mptcp@lists.linux.dev>; Fri, 29 May 2026 01:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780018569; cv=none; b=hOWMEeQ4B5wv7OLusF4pDSfeD1nqIkSNAYnNwngdIFpLRLyAylM/z1TkpiDuqLV0p4MXZInPJn0poqMHmk87XNRo6xs0U5tdyvg+JNQEMGtkvCnC++8nehX5jBpP0Eu2wy91gQI8gg8Ct0RfPavj1qL3AMeV1/z6ejsQeHAnoSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780018569; c=relaxed/simple;
	bh=f1qFNYKUDClXPBCdbFRisRcGFtZJAtKSdTATvo2roQk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZXWgO7RwPa0am4Y0pPHekr1dnuTRSoM9QnbeQL3FYLIBEyDblNSVz1+VL8uUW+EFxSjPZTXg1R+p3epgu2EekSfR5KIFaPh6hmxjSLLIKn3N4LCDuxfHUSb352LwudW46SfZZyWwTEy2OUjN2aDN2+nyAv/8vJwIt6nEC/47GQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHpW+nOw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHpW+nOw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BC01F000E9;
	Fri, 29 May 2026 01:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780018568;
	bh=Q6SEbIThINxPvF9/h5rONW4skP4uzXnM40xN16vEfFI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=DHpW+nOwV5L2qbUiimuBXo9beU1fFArDnkHvUWO+oR18zC3t9RuQIVZa6yxyTrxFI
	 lx6SHOkN9TsF2Wa8xMbblZAUDu8UzBTg+wRBjp6u5ZPxr5OmZmR26Lh/K8V3hjmSe9
	 SubkRxiH0aWb2yMD0TUM+5qnfTEfMUUI5Qd6Dz32H8B1vB+VpqtLtpa2VRDXQUOrRZ
	 Eqmw6utBqbPa3NcqPmFCgaYRoN3G3jfPgYY+Q3L3xqGc2bbJqcZgmPBPKY+hhrR7Hs
	 Cfj96FNotc+9anMl2bhkcChbABnwA1Qn8cVwu07UvHJUmBs5sis9Itl2Nmat+VvPqh
	 7UlMgnKmevVSQ==
Date: Thu, 28 May 2026 18:36:07 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net] mptcp: sockopt: set sockopt on all subflows
In-Reply-To: <20260527-mptcp-sockopt-all-sf-no-break-v1-1-4318be7b1e22@kernel.org>
Message-ID: <b069734f-4343-05a3-1661-0fa4ae92da05@kernel.org>
References: <20260527-mptcp-sockopt-all-sf-no-break-v1-1-4318be7b1e22@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 27 May 2026, Matthieu Baerts (NGI0) wrote:

> The mptcp_setsockopt_all_sf(), currently used only with TCP_MAXSEG,
> stopped when one subflow returned an error.
>
> Even if it is not wrong, this is different from the other helpers trying
> to set the option on all subflows, and then returning an error if at
> least one of them had an issue.
>
> Follow this behaviour, for a question of uniformity.
>
> Fixes: 51c5fd09e1b4 ("mptcp: add TCP_MAXSEG sockopt support")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> net/mptcp/sockopt.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 87b5796d0135..bc2cded00187 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -813,10 +813,11 @@ static int mptcp_setsockopt_all_sf(struct mptcp_sock *msk, int level,
>
> 	mptcp_for_each_subflow(msk, subflow) {
> 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +		int err;
>
> -		ret = tcp_setsockopt(ssk, level, optname, optval, optlen);
> -		if (ret)
> -			break;
> +		err = tcp_setsockopt(ssk, level, optname, optval, optlen);
> +		if (err < 0 && ret == 0)
> +			ret = err;
> 	}
>
> 	if (!ret)
>
> ---
> base-commit: 19d4169d06892e0c451ec370292ec71fa6bd8028
> change-id: 20260527-mptcp-sockopt-all-sf-no-break-ad14ff690358

Thanks for the fix, good idea to stay consistent here.

Reviewed-by: Mat Martineau <martineau@kernel.org>
