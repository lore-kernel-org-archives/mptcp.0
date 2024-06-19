Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1651B7D3F8
	for <mptcp@lists.linux.dev>; Wed, 19 Jun 2024 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718786249; cv=none; b=ZjWtKwCqo9oUJlYej4CFYbhuFFQ5ufUYLhikZweV6Ide8k84okLfgVgl1ZixAolUVjl6gZqrDD9eicyvOMrpphTCCmyyDX8EvKv9w5SgeBOwrgb6v2+CK3syrOFH35bSgYLny+Xc/ORksckmbosXsI1VQHi2eIEAsG9PbNqcKKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718786249; c=relaxed/simple;
	bh=0tVB5E5tLOnqOPN7os1QWwdRGKLgQgNCOvsWYajy6oQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2dy14Pzgy0f/TqmWrFBgG7lKRJd8snTHTVVCE28aTfybURXWpehQnbo67Tx0l2HyA3l8/QPgqv0q4N8b01d/sor/fnLno/efsEjfcrWPHzTqwv5RFEc0vD/nUFlrtp8UPEWm39FKPkvkvCJDfBgiWYP6gLxWLc9qESkkvMhxlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVD+Gj+E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVD+Gj+E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28E7EC32786;
	Wed, 19 Jun 2024 08:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718786248;
	bh=0tVB5E5tLOnqOPN7os1QWwdRGKLgQgNCOvsWYajy6oQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FVD+Gj+EZigPH0CgQP+e/LlPRGlTMeJM32uOOO2+fpHNAcV9X4JRPY3+lzOOerk3P
	 j77BbEkQa7WPL5V8AK+r8VDSF0epYEUs3Ze3nlrdjo/rjSXfDTq9Vra2VS362KonDe
	 GPHfVLCIHh1Jpj0eBa5ZXjQH/ephKrriF8R6brbVq+qRPXwviiFO7nBQSAmxu02yMM
	 xEeNFhLyLdsgkhBYHAcjc3AHrn7kizS/uF0yVTkNTc2jEaezKTMiBKyJTthAHj/9iT
	 W1V55CXMNnDk5i2aKHqpZtzG1nxSIp28BqKbJYie1ip4mThdzXh1OrsYfyCNCYhw5H
	 D/oTZjKE9m9uQ==
Message-ID: <47c423d7-e405-45a4-8398-cd999c6049bd@kernel.org>
Date: Wed, 19 Jun 2024 10:37:25 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH iperf3 v3] add MPTCPv1 support
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
References: <4a85ab6ab759ba852647b03af58faded31fbb8f6.1710140596.git.geliang@kernel.org>
 <fd131421-bb46-4d40-befd-b2bcd6d2b832@kernel.org> <ZfADyFB1vDYABpf9@t480>
 <4a1febfb-54e0-4d1f-ac56-e5fa4e1bdead@kernel.org> <ZfAO4OKX8sjHTQW9@t480>
 <10ac1bd1eef26be7258aa6b67e4843d9c4f7ac88.camel@kernel.org>
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <10ac1bd1eef26be7258aa6b67e4843d9c4f7ac88.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 19/06/2024 03:52, Geliang Tang wrote:
> On Tue, 2024-03-12 at 16:14 +0800, Geliang Tang wrote:

(...)

>> Sorry, I open a new one before reading this:
>>
>> https://github.com/esnet/iperf/pull/1661
> 
> This pull request has not been merged yet, and I recently found that it
> has conflicted with other code, so I resolved the conflict and updated
> it this pull request again.

Thank you for having done that!

> In addition, I found that before my pull request, there was already a
> pull request for MPTCP support waiting
> (https://github.com/esnet/iperf/pull/1615 by "marcosfsch"). I guess it
> is because there are two conflicting requests with the same purpose
> that MPTCP support has not been merged. If this is the reason, can we
> contact "marcosfsch" to see if these two requests can be merged into
> one? It doesn't matter whether mine or his is merged.

I don't think that's the reason, but I just added a message on PR #1615.

> Or the reason why it has not been merged is that iperf maintainers are
> not interested in MPTCP support because he has not given us any
> feedback. If this is the case, it seems we have no choice but to give
> up supporting MPTCP in iperf.

Yes, that's a shame they didn't even provide any feedback... If they
don't want it, they should at least be clear about that. I just added a
message on your PR #1661, will see... Because I don't think we want to
maintain an MPTCP version on our side (who will use it apart from us?).

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

