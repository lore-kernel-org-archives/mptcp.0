Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BF52F4A04
	for <mptcp@lists.linux.dev>; Mon, 17 Nov 2025 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763398107; cv=none; b=cybrBAkx3L4j59qfpeIaMnKlmn5SZbjOSVlysUoHpo08YnxhQOyTHlpF3s1CyARGLwNBdZKD54S7N2KWHmgdGtKj4RSo3DJ9cY9G5/n9UbWnfqU4l9T+uKGnw0uCsx1IDLXPm0OXFVjSqNrw8DnQo5JvzneK07++geAVBNTZqGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763398107; c=relaxed/simple;
	bh=ts6CDiXFBeF92to0rGBZwpfEDp/60J+O2jVZ/fEC7C0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r8z3NTgn7ODZ9cKWGuNmMBueufDASpMX/w74be++iqT6Rt5KqtOHG3Dk12bs5NDj2Y5W0E2vwlGZCqx2x3U+Nkl3MN63f/OqBYRU8wb7atPEXRFgY01Ul5LuJIzpMuNTmapvbFxwOG+9KLoM6XR3/umj9+ia3Fo2BI1Oo85dNno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jXukOcre; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jXukOcre"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973FBC116B1
	for <mptcp@lists.linux.dev>; Mon, 17 Nov 2025 16:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763398106;
	bh=ts6CDiXFBeF92to0rGBZwpfEDp/60J+O2jVZ/fEC7C0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=jXukOcrePBJCigBSkDRoz8C/1N0IgraKea4syU49NZ90Q0q4PrqHqdHQLzUad+pyp
	 B9lXawbhhoo+qS7Vf4/MVGlJbxI51lWN3GDF1N4KOZAnJpN97iyNSDM6T6Ye9GSfzu
	 sDZa2dvl1xkUbl5XQb/LGbYEkWIXPXTMHuxr4ni7nzlW28mVfDrw9KJOvja9C7dlM9
	 3JLFNRLYCt9o8m1wnzvZGFs84NMzj39nT+rrB2nHZQdM6eUQMqMTc3JHV8lIN940kM
	 NBp6MAEmqcqtpDAH+Ddnmjw50gfGQXP8ag1eO2cVpI1k5kon3a/v/iCBw6+22tZshH
	 lvFjDTMw/Ssqg==
Message-ID: <c3642b9b-f6d4-4211-b286-16b138415596@kernel.org>
Date: Mon, 17 Nov 2025 17:48:24 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute-mptcp 3/6] mptcp: add 'laminar' endpoint support
Content-Language: en-GB, fr-BE
To: MPTCP Linux <mptcp@lists.linux.dev>
References: <20251112-laminar-v1-0-e23dbf584aa4@kernel.org>
 <20251112-laminar-v1-3-e23dbf584aa4@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20251112-laminar-v1-3-e23dbf584aa4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 12/11/2025 17:24, Matthieu Baerts (NGI0) wrote:
> This new endpoint type has been recently added to the kernel in v6.18
> [1]. It will be used to create new subflows from the associated address
> to additional addresses announced by the other peer. This will be done
> if allowed by the MPTCP limits, and if the associated address is not
> already being used by another subflow from the same MPTCP connection.
> Note that the fullmesh flag takes precedence over the laminar one.
> 
> The support of the new flag is easy: simply by adding it in the
> mptcp_addr_flag_names array.
> 
> The usage menu and the manual now references the new endpoint type. The
> new corresponding counter has also been added in ss.

(...)

> diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
> index 500dc671..d821f714 100644
> --- a/man/man8/ip-mptcp.8
> +++ b/man/man8/ip-mptcp.8
> @@ -66,6 +66,8 @@ ip-mptcp \- MPTCP path manager configuration
>  .RB "|"
>  .B subflow
>  .RB "|"
> +.B laminar
> +.RB "|"
>  .B backup
>  .RB "|"
>  .B fullmesh
> @@ -169,6 +171,17 @@ path manager will try to create an additional subflow using this endpoint
>  as the source address after the MPTCP connection is established. A client would
>  typically do this.
>  
> +.TP
> +.BR laminar
> +The endpoint will be used to create new subflows from the associated address to
> +additional addresses announced by the other peer. This will be done if allowed
> +by the MPTCP limits, and if the associated address is not already being used by
> +another subflow from the same MPTCP connection. Note that the
> +.BR fullmesh
> +flag takes precedence over the
> +.BR laminar
> +one.

I suggest adding here:

> .... Without any of these two flags, the path-manager will create new subflows
> to additional addresses announced by the other peer by selecting the source   
> address from the routing tables, which is harder to configure if the announced
> address is not known in advance.                                              

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

