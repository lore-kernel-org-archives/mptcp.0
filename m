Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6206E23F434
	for <mptcp@lists.linux.dev>; Thu,  8 May 2025 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746695148; cv=none; b=Aa3oCHa5xZHt9xZrnZrpSiOoQO1iFk2UZi2uGiMkdZMldG5YC3qgZkaOuEIdRH33pAJ93v5GPUMGmPWwov8R/bC8nzS09OzMniz9E0oPo6isYlY/4BGL6PpW1sIH50Hc2fIGW32sDSVEsr4ahAUbEXNuk7BIpMGr+vr1LgNoe6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746695148; c=relaxed/simple;
	bh=X6191Wk9wiEo/26+GZqT0NuzTIIpI0JE3L/15tYc+ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=CbU8FZB+5pfeBDgnLgIdPUqvaRAL8WB/La4/NqD4rnGIrw3GHTgEOt028FIV1RCUdFrF8ORACWwXr8TZwzNSfDn4t9jBQ3+c1HlvliZ4z0mdoeunuVTvkrHTqBF8kb8hBpHnhDVqPH/lyMO+5Wi9dkyL0Fevxpt5jZpjPMosxIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1ql1wnH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1ql1wnH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC51C4CEE7;
	Thu,  8 May 2025 09:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746695147;
	bh=X6191Wk9wiEo/26+GZqT0NuzTIIpI0JE3L/15tYc+ms=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=c1ql1wnH43ay/13N6r4QbUxzuBWCDhuoa+XW85fhwcLwnuD+GNm5n2qvoVe9Qr0tx
	 IzfWAXhups+/hR4oCLXjeMcNttLemJTL1OVtlLF7iPUlEnbJtu52pyAl/Zn9Py4vTV
	 PSLr7vBVL88F0oL7+3TX37EY9M8lxne2o8w2HyLANrdSnUEvcMug/404KurJRsXjxE
	 yf6eqRby2T9jnYqKRFUjfv6EATSr91Xt8mwQpS94gSJtc9RnW1cVbPM26gmdBoyvuE
	 BB9NJXwxgsXoIBGt6U2yJPLYaOLlNcU9wd2rEBgo/SkA+hB53fwv/u5xafQ+lZidvz
	 5LtkdURaTymRw==
Message-ID: <c2827259-e58b-4d7f-9e38-91cf7f517112@kernel.org>
Date: Thu, 8 May 2025 11:05:45 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] mptcp: validate maxseg sockopt
To: Geliang Tang <geliang@kernel.org>
References: <cover.1745991978.git.geliang@kernel.org>
 <b10aabf6c4529977b61e7662cf1f09db4752edaa.1745991826.git.geliang@kernel.org>
 <f5a3b547-d6d8-4448-a679-c638d918c9d6@kernel.org>
 <dd08686eee5b757ba526e3da3c062894655f56f3.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Content-Language: en-GB, fr-BE
Cc: mptcp@lists.linux.dev
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <dd08686eee5b757ba526e3da3c062894655f56f3.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 08/05/2025 09:21, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for the review.
> 
> On Wed, 2025-04-30 at 11:42 +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 30/04/2025 07:49, Geliang Tang wrote:
>>> This patch validates the newly added TCP_MAXSEG sockopt.
>>
>> If you don't mind and have access, do you mind creating a PR on
>> GitHub
>> instead please?
> 
> Here's the PR:
> 
> https://github.com/multipath-tcp/packetdrill/pull/161

Thanks, I just did a review:

  https://github.com/multipath-tcp/packetdrill/pull/161/files

(...)

> In this PR, I almost addressed all your comments above ...
> 
>> Then, if you don't mind, please also create a new subflow by
>> injecting
>> an MP_JOIN with a MSS of 1460, and check that the SYN+ACK+MP_JOIN
>> generated by the kernel has a MSS of 1000 as expected. For an
>> example,
>> check mptcp/mp_join/mp_join_server.pkt.
> 
> But I still have some problems when creating a new subflow, which will
> be added later.

Do not hesitate to share this WIP code and the error you have on the PR.
I also added a few pointers there.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

