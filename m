Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8517030ACE6
	for <mptcp@lists.linux.dev>; Mon, 12 Oct 2026 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810718; cv=none; b=akLfnehtPXXHrMWBgNpu+s6j4yqoxmUqTe22KXqH4SPXN2U8hQbWUSFZH80DpfIa7r9ziUXRAGasj5fZhNuvDeRwAbax6axtvHRyGh3aRHxEWFoFeU7p8Q3gVZAddXWnioBPJx7nHUy+Z1cE1rWq9ot+lPSGYp6hqnV/b1vMZds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810718; c=relaxed/simple;
	bh=S2H32v3aSIiNtsf3NicUhJA0asvQIyj/xJTDt+zh/3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJUrFxfzs2BdWf7fNpFUwwwTadCZnHeyNhHUM2sBmx8tMsEFFikcS+CsJDe76xaYvJa7X9D2OETSYUFrPbMJPd0qVmaBAKfbDbdEwQjHP51G8ojodOQxXvwzwwUHedjpNmc1BdzVfpknMTyb30LSXLCct/Ed5jyOOYzTu5jkEtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSfxjV6k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSfxjV6k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B6B1F0089E;
	Mon, 12 Oct 2026 13:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791810717;
	bh=15QsKANBqhl6XUin7qfQ07aiBggi10KGLATQp2QT0S0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=VSfxjV6kxSp8OGPFe6gFU93A/xIcWowa/Ec51MZBtRYa9swBQUwy6YGFc3nt21h7C
	 I2wpIUBqiNAZH5QIO4hNXZuJKuX9XNB/37EsjqHdjAlAhV+MdH+3zYYUuFuqYhfOY7
	 GBeVlA18l4CNwye4lZlTUhieQuWva+ZXzVvg94L+WOgUTzTGa/WlcGCOuEo0fNGb99
	 ngdmY7EzWB9g/GufHnS6WKSQ60B09VKWQje/C8CgkJn3A45ZiRLR8XrTHuyQBCXe/P
	 kTk30bzih8OnRE8wvEApm0EiPZq476banCAWj0gZOHOo3BAvVTZ0BgAYQ9FAePzK9W
	 eDlLMpKzyjjlQ==
Message-ID: <7da818ff-d263-4138-808c-e4bd23d110d6@kernel.org>
Date: Mon, 12 Oct 2026 15:11:53 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: reset MP_JOIN subflows on missing or
 invalid DSS options
Content-Language: fr
To: T S Rameshkumar <rameshsv06@gmail.com>, mptcp@lists.linux.dev
Cc: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
References: <20261012112625.578911-1-rameshkumar.t@phytecembedded.in>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261012112625.578911-1-rameshkumar.t@phytecembedded.in>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi T S,

On 12/10/2026 13:26, T S Rameshkumar wrote:
> Per RFC 8684 Section 3.7, fallback to regular TCP is only permitted
> on the initial subflow. Additional subflows established via MP_JOIN
> MUST NOT fall back to regular TCP, and if an additional subflow
> encounters missing DSS mappings, corrupted mappings, or unmapped data,
> it MUST be closed with a reset.
> 
> Currently, in subflow_check_data_avail(), when an MP_JOIN subflow
> receives data without DSS mapping or with invalid mappings, it branches
> to the fallback label. If fallback was already performed or allowed on
> the connection, the subflow bypasses reset and incorrectly accepts
> plain TCP data, synthesizing a fake fallback mapping.

Do you have a reproducer for this?

> Fix this by explicitly checking if the subflow is a joined subflow
> (subflow->mp_join || ssk != READ_ONCE(msk->first)) under the fallback
> label. If so, immediately set the appropriate reset reason
> (MPTCP_RST_EMIDDLEBOX on MAPPING_NODSS, MPTCP_RST_EMPTCP otherwise),
> increment MPTCP_MIB_DSSRESET, and jump to reset.
> 
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/544
> Signed-off-by: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
> ---
>  net/mptcp/subflow.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 78e886b20..5faab6ffd 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1446,7 +1446,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
>  	return false;
>  
>  fallback:
> -	if (!__mptcp_check_fallback(msk)) {
> +	if (subflow->mp_join || ssk != READ_ONCE(msk->first)) {

Here you are changing the condition "did we already fallback". Is it
because a fallback already happened but yet you have a second subflow?
That's not consistent, and the root cause is elsewhere.

Maybe it is linked to:

https://lore.kernel.org/20260814-mptcp-reset-mpj-early-v1-0-3ca3260f9474@kernel.org

I didn't have time to work on a v2.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

