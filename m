Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FFA37883E
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788427713; cv=none; b=uQSrgrlij9bBXTJwtIpc4uegrm88zy8gBIpmFZhrFr1E04KvyjVtSBaMi391HOcoEiIVQIGPvGZKZ/RhEzKp4+C64udmflQVB2iKSTWBEcK+pYT6l+rLEeKTN8A3jzcNlmXRkaUc7kL96Rmbk3lB7fh/laUKHMFtT7q84cz2KD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788427713; c=relaxed/simple;
	bh=YMFCrdI2tBYtwrY/hJv8qLECNrgLtSQQvRoxnFkGbCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e0lstdVroTFShvwtxnErYcB9E9Q+Wy9AZ97gqyRdn0R7gJuNLr4GBRXzXGStXellHmpHdbPxIHsfLBTioSaBzpp9ZNlWiI1PF43xD8scDiaWhE7TK9gNpAgnfUPk+MYKW2Xq0REvkiaIxSVbi0u/tU9dVsbaRp+uMkdJybAD8p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNEoAtP8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNEoAtP8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF6B1F000E9;
	Thu,  3 Sep 2026 09:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788427711;
	bh=02glPddpqK9Gv7aBmCe9ANb7gyjJLn4SnCoiJMPs2R8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gNEoAtP8yelrGXs5w3FbsxGULMCg7RA2Qi6RN6wyuyHTczpLbFPrC7XZ/qckgYfvR
	 OiKtNyL1QRVfQ7dxK+rXB3dou79FyRAwzkNhkGp8HbrHClaLZMspZ2LVTE0RkKml41
	 XrWFbeen2j3CDuliVKAifsVPP1ln+XN/hyzkB3+th/i2Ia8fn3Cc0eRYbhTp9OHAIo
	 GZBa0plvpgRaBAT3Oesxz2OA95r2jlRnG+xFCb7DvwvaaFBqO5noEc3y8Ylx8JN8ol
	 zwMDQJ18HyMd/yFDakQwovIbRLGp0kW6eTDxz9wO4rEwf902MBFBiP+ENk0ogwC/7C
	 n0UoK4DfML5JQ==
Message-ID: <6c9dd599-e9d2-470f-bc7f-2af2e9d003b6@kernel.org>
Date: Thu, 3 Sep 2026 11:28:28 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 2/2] selftests: mptcp: convert iptables to
 nftables for mptcp_join.sh
Content-Language: fr
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Hangbin Liu <liuhangbin@kylinos.cn>, MPTCP Linux <mptcp@lists.linux.dev>
References: <20260902-mptcp_nft-v1-0-559caa16f410@kylinos.cn>
 <20260902-mptcp_nft-v1-2-559caa16f410@kylinos.cn>
 <513e6559-a06a-45d8-a8b7-72b3a1a77e71@kernel.org> <apjU-uM8dvxnVcaP@fedora>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <apjU-uM8dvxnVcaP@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Hangbin,

On 03/09/2026 04:02, Hangbin Liu wrote:
> Hi Matthieu,
> 
> Sorry, My mbsync has some delays and I post v2 too quick before catching
> your feedback.

No problem.

Just in case, maybe korgalore can help?

https://people.kernel.org/monsieuricon/tracking-kernel-development-with-korgalore

> I will update the patch with your feed back and re-post tomorrow.

Thanks!

> On Wed, Sep 02, 2026 at 12:00:40PM +0200, Matthieu Baerts wrote:

(...)

>> If you don't need this one (or any set in helpers), don't set it/them,
>> and don't use a global variable. Or reset it in init_partial, but prefer
>> using local variable with a limited scope.
> 
> Yes, we don't need the handle in other place, which I will remove them.
> But for endpoint_tests(), after adding rules in reset_with_tcp_filter,
> we need to remove the rule outside. I will reset it after each test.

Perhaps you could flush the whole table instead? But if it makes more
sense to assign this variable, fine by me.

>> Also, maybe clearer to use 'nft -j' with 'jq' to get that (if possible)?
> 
> I check the output of `nft -j` (paste an example at the end of mail),
> which looks not each to get the rule handle easily.

I just noticed that in nft's latest release, it is possible to set a
handle when adding the rules. That looks cleaner for our case here, but
it requires the version released 2 days ago, so no :)

Probably best to support the version from Debian Stable, 1.1.3, apparently.

  https://repology.org/project/nftables/versions

>> One last note: for new features linked to MPTCP that might take multiple
>> versions to get ready, it might be better to send these patches only to
>> the MPTCP ML (no need to add anybody else in cc). Then we will apply
>> them in our tree and send them to netdev when we consider them as
>> "ready" (and hope for Clashiko not to get back to them days/weeks later,
>> but that should be a temporally issue :) ).
> 
> Thanks for the notes. I used to rely on `b4 auto-to-cc` too much...

Most of the time, that's fine. It's just for some subsubtrees where
(urgent & simple) fixes can go to the parent tree (netdev here)
directly, but the rest can go only to the subsubtree ML.

BTW, if you are on top of our export(-net) (or for-review(-net)) branch,
there is a .b4-config: you just need to use 'b4 send' then :)

> An example of `nft -j` output:

Thanks for the output!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

