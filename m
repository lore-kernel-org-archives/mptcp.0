Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409BC2BEC52
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791475825; cv=none; b=K7OuvxsTouh+yfhKQBgkW424Sz3YnjtJSE/z+wv1IyF5AaGNtqXwdg7bXgnyCUcT+K80u4L1GOdzB5Jp010Xn2vlJYX0kiuSeuJvfkl5mfqaiUhxGcejZuyDYlrrO52/glsbze0QXABBXGt7Z271eHu4i3h6z7r62JdTAH7YFfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791475825; c=relaxed/simple;
	bh=ZsgZ+hK2V4sC0VlIOqfIqEOOfoAgyLmj/AriSXhEeXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtIVYI6sMh86iczEsu9ULKIWOCE3kpHRYz9GiuQWHE6RxT3HbAp21LJt7XMJ8BBJFVLIWGwbeZx6SKJbl7PqKeMdCIrSiRBhZ3ZbSI23Di9Z9mW2vJVwFbzNFjOdjwChdfBEV8FWaH6PT0ziBQlAcTFyvTXEN4+9W4LJ35BnT4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3oaxvz8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3oaxvz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28B8A1F000FF;
	Thu,  8 Oct 2026 16:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791475823;
	bh=l8M2YYCJlp8huf67nph4INTltuWJol+vCBN0okXGOVM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=D3oaxvz85oOFoYfr1YNtcrwGhbKA5a8Rf5kvj2/raM13DsFMQgQw3vyawo73ccdGm
	 mNS1vjC8nUdi6KAWCt6efvaE6YO0hsmKkMU/zbaaB6mNZdTlwogne6J7aCx4cZHYcu
	 7D+sLEcP2VuM9W/NQzXoN2Fw2oUDxdXcj2DvBd7w5lmwsdBy9a/s+w0cAfILPCEQQp
	 uG3tr9L3f0t7N5XwkhfhB/zG/3X4wBxDfOU4w/vtBbqehhv1peVkIh7EsB9Z+wxbmU
	 x0SaCo7vPaimIc/fDvBERU7kQN1LBy9Gmp0S2scuBzu7BsfOxdep4tc3ZKjch83Iek
	 PoXTG26swaXiQ==
Message-ID: <ae2e3936-5467-43ba-a8ce-287202fa50f1@kernel.org>
Date: Thu, 8 Oct 2026 18:10:20 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4] mptcp: push queued data on passive TFO subflows
 becoming established
Content-Language: fr
To: Petar Sakic <petar.sakic@ink.fish>
Cc: T S Rameshkumar <Rameshkumar.t@phytecembedded.in>,
 MPTCP Linux <mptcp@lists.linux.dev>
References: <20261008124220.213016-1-rameshkumar.t@phytecembedded.in>
 <a6269e21-a506-4607-b39a-3b4d2e4cccf6@kernel.org>
 <PN0PR01MB9382C18780E137E3013A097CF4932@PN0PR01MB9382.INDPRD01.PROD.OUTLOOK.COM>
 <a1ed275c-d455-480c-b12c-d44eeedbed65@kernel.org>
 <CAFPPu1hphgMCQWxUUENR=2+VfE++PG7eW-EeBd1cy8qyPHsDqA@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CAFPPu1hphgMCQWxUUENR=2+VfE++PG7eW-EeBd1cy8qyPHsDqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/10/2026 16:39, Petar Sakic wrote:
>> @Petar: are you working with T S? Because if you suggested the patch, we
>> should at least add a "Suggested-by" tag. Is it OK with the
>> attributions?
> 
> No, I'm not working with T S. I don't know him; he picked up my report
> from the list.
> 
> Suggested-by is fine with me, and so is T S carrying the patch. I'm not
> a kernel developer, so I'm glad someone who can do the formal
> submission and the packetdrill test is taking it on.

Great!

>> (Next time, please send a formal patch to avoid any conflicts here ;))
> 
> Understood, will do.

Note that you can also report issues with MPTCP on GitHub:

  https://github.com/multipath-tcp/mptcp_net-next

> For context: we hit this with xray Shadowsocks-2022 proxies over MPTCP.
> The client puts the whole request in the first write, so small requests
> ride the SYN, and replies from targets close to the server hang. We
> reproduced it in network namespaces at ~120 ms RTT, and the single
> options.c hunk fixed 30/30 requests on 6.12.111. Happy to run our
> reproducer against v6 when it is posted.

Interesting use-case! That's a shame we didn't find this issue earlier.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

