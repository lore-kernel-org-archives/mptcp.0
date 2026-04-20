Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF21038F950
	for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776677722; cv=none; b=SxHx0Gs+WJyWGqX2RoaqdCCZQrTggT8319Z3IK/jEkxSRuULvyWFmzPaknqXQHaGcolYIP2jB4TIC4EFgGt28jX6y0DYOMl88ZBow/dw5qLRIYtl4bIxy332eUgzRvhXzW3x7rvXKnVyXq2r3N6b8W7gaEjFMSTI5L52ob8phl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776677722; c=relaxed/simple;
	bh=dO/Tj571ZVl1h2QpabvJaLYKZJTh2zqzHAj2J9+qamY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TVgWJX12CVhjcRkj7r/hG4UGcl84+SncJsaiUAm/h75Fca2FXYC4EWdFb9xVLLoIgqnuEJh5ssWWbW6jR9L1aSmC3swgN/tG4je13huwWCi84MF0PwdNtRIdJ463bT/MXv7ajrDfFoN+YRLAPfYNJXtc65Ds7Z36dVlNOxud4Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQYLAO0R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQYLAO0R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C26C2BCB7;
	Mon, 20 Apr 2026 09:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776677722;
	bh=dO/Tj571ZVl1h2QpabvJaLYKZJTh2zqzHAj2J9+qamY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=GQYLAO0RrVYahZKbXgx+JnFtxEzNcs+iIMjyiej6Td4aaav3c+GqLMaRiWjJzaA13
	 aR72gqjdZFldD2rbNqKOPaCPFjmKo1tmMLiur+JoQr1N7lgcofxeAtBBH0Jsd8gSEA
	 EeESMGbu172KH8WLjtXX7Hr1kB1ZNo5sgrS2WjXQBms0KUwtoanW1BHUOz8xyXrjbL
	 LnG2L1A7e8kcExj3xzC7x58j8B0vcSAVH8ZctSeoAOqCWslM/8rBmT/cIRBjMN0aKz
	 3YMG05UZq1oOANSULOil290qo9uaZB7DGXlW4rfNJo6pGpsCV67TYhVSduooMjAbi/
	 +rRr9xghtEwWA==
Message-ID: <711cd795-c309-4d33-873d-d049df48622c@kernel.org>
Date: Mon, 20 Apr 2026 11:35:19 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RESEDN PATCH mptcp-net] mptcp: update window_clamp on subflows
 when SO_RCVBUF is set
Content-Language: fr
To: gang.yan@linux.dev, mptcp@lists.linux.dev
References: <20260420085613.4650-1-gang.yan@linux.dev>
 <05de925c-b9e6-4e85-997c-e98fcadc5980@kernel.org>
 <759c28ad07974bee4f83d69bd85ab5477690c0da@linux.dev>
 <7b58555aba7fc56f135ee198a592e4d72e01f849@linux.dev>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <7b58555aba7fc56f135ee198a592e4d72e01f849@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/04/2026 11:31, gang.yan@linux.dev wrote:
> -------- Forwarded message -------
> 
> From: gang.yan@linux.dev mailto:gang.yan@linux.dev 
> To: "Matthieu Baerts" <matttbe@kernel.org mailto:matttbe@kernel.org?to=%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%3E >
> Sent: April 20, 2026 at 5:30 PM
> Subject: Re: [RESEDN PATCH mptcp-net] mptcp: update window_clamp on subflows when SO_RCVBUF is set
> 
> April 20, 2026 at 5:24 PM, "Matthieu Baerts" <matttbe@kernel.org mailto:matttbe@kernel.org?to=%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%3E > wrote:
> 
> 
> 
>>
>> Hi Gang,
>>  
>>  On 20/04/2026 10:56, Gang Yan wrote:
>>  
>>  
>>  From: Gang Yan <yangang@kylinos.cn>
>>  
>>  Add __mptcp_subflow_set_rcvbuf() helper that calls the tcp_set_rcvbuf
>>  to update window_clamp, in addition to writing sk_rcvbuf. Use it in
>>  both mptcp_sol_socket_sync_intval() (setsockopt path) and
>>  sync_socket_options() (new subflow creation path).
>>  
>>  I didn't review the code yet, but just a note for next time: please
>>  don't use the RESEND tag if you did a modification, even if it is only
>>  in the commit message. Instead, increment the version and add a
>>  changelog describing the modifications.
>>
> Thanks for the advice and reminder!
> 
> The reason I sent this patch with the RESEND tag is that I wanted to
> trigger the CI checks, especially the AI reivew, to see if there are any
> issues that need to be fixed. It seems my previous patch didn't properly
> trigger those tests.

Strange, I don't see your previous patch on Patchew:

  https://patchew.org/MPTCP/

And sashiko had some issues with it:


https://sashiko.dev/#/patchset/20260416122945.324166-1-gang.yan%40linux.dev

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

