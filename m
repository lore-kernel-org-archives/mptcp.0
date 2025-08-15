Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4368E4315F
	for <mptcp@lists.linux.dev>; Fri, 15 Aug 2025 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271789; cv=none; b=uWnLMczyKFjNuREK8g0QlLfmfHJsEgT8rtatVg82XeFNlXf1dIE1mVm3DIXnv4EEouAP6aBzkKCQ60/9LXOkynRSq3YHHoAS7gvnjuvKtyUb0XBSVIegFvQAbidW4piFY3+hcJYtQq7G7zXAbHyJYBPLzUwyWWSFSarNhkvW4Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271789; c=relaxed/simple;
	bh=WPnYyGNSWZsMLSb7varqKtmRK3YyFxu4t6nf41GF4Eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/9a+f7f6j8mF7xGo2H08gVd908hicKHes387+QkKMETXsOoLYkDONaIQu1wvllanzeXyedQkGz63a2V+wuLQXAXJBAyWzfKp2ar72z6LEZEphmyzRXJ6Ap7iaFTVUY/d3lMLRrjjXOBPIBOygfDB1/nnX8vhar5+sAWKj5Lajw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXNuFyMj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXNuFyMj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432CDC4CEEB;
	Fri, 15 Aug 2025 15:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755271789;
	bh=WPnYyGNSWZsMLSb7varqKtmRK3YyFxu4t6nf41GF4Eg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qXNuFyMj47DJt/IADQMQLxcXnEsYjgY8BIbUcT2YwXGE8EAXc15sOInmTmajaRYeD
	 9j66Ooof0jSo/9AAo4B7E74IrVQvPhfcd1REYmErKoDGTRUu5WCUTaxyWDPVEO7+Fl
	 h8md2XQXaVJptI2yp4A7vdfPokUmqQL78uSLcP6J7SjLJpJbPYSoHpCoA9KkHwMtDJ
	 5NlqlsDGDFP8vqEKKc/oPrGbKN11RrqwsdV0D05RLo4XqtsVSvFpuYmEwSQlnxkwHz
	 xWJaOq0i/ILK69xjZQ+4I1tNeChXp9mv9wZdkkSwCxn5KoUI9m1g4kTbL2B2YFxBbi
	 SHjGZ0IWfIGpg==
Message-ID: <eae1b929-f9a6-4416-af33-750cf936febc@kernel.org>
Date: Fri, 15 Aug 2025 17:29:45 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v4 1/2] mptcp: make ADD_ADDR retransmission
 timeout adaptive
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
 Christoph Paasch <cpaasch@openai.com>
References: <cover.1754987655.git.tanggeliang@kylinos.cn>
 <a0d3e4caeb991f06de2ce2692b4c00c57c0460e6.1754987655.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <a0d3e4caeb991f06de2ce2692b4c00c57c0460e6.1754987655.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 12/08/2025 10:39, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Currently the ADD_ADDR option is retransmitted with a fixed timeout. This
> patch makes the retransmission timeout adaptive by using the maximum RTO
> among all the subflows, while still capping it at the configured maximum
> value (add_addr_timeout_max). This improves responsiveness when
> establishing new subflows.
> 
> Specifically:
> 1. Adds mptcp_adjust_add_addr_timeout() helper to compute the adaptive
> timeout.
> 2. Uses maximum subflow RTO (icsk_rto) when available.
> 3. Applies exponential backoff based on retransmission count.
> 4. Maintains fallback to configured max timeout when no RTO data exists.

I might be good to add a note about the behavioural change:

  This slightly change the behaviour of the MPTCP "add_addr_timeout"
  sysctl knob to be used as a maximum instead of a fixed value, but this
  is seen as an improvement: the ADD_ADDR might be sent quicker than
  before to improve the overall MPTCP connection. Also, the default
  value is set at 2 min, which was way too big, and caused the ADD_ADDR
  not to be retransmitted for connections shorter than 2 minutes.

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/576
> Reviewed-by: Christoph Paasch <cpaasch@openai.com>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  Documentation/networking/mptcp-sysctl.rst |  4 ++--
>  net/mptcp/pm.c                            | 28 +++++++++++++++++++----
>  2 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
> index 1683c139821e..2b8e8fb99ee2 100644
> --- a/Documentation/networking/mptcp-sysctl.rst
> +++ b/Documentation/networking/mptcp-sysctl.rst
> @@ -8,8 +8,8 @@ MPTCP Sysfs variables
>  ===============================
>  
>  add_addr_timeout - INTEGER (seconds)
> -	Set the timeout after which an ADD_ADDR control message will be
> -	resent to an MPTCP peer that has not acknowledged a previous
> +	Set the maximum value of timeout after which an ADD_ADDR control message
> +	will be resent to an MPTCP peer that has not acknowledged a previous
>  	ADD_ADDR message.

I suggest adding this at the end:

  A dynamically estimated retransmission timeout based on the estimated
  connection round-trip-time is used if this value is lower than the
  maximum one.

I can do that when applying the patch. I can update the text if needed
later on.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

