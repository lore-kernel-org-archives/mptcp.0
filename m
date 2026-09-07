Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44CF3890EE
	for <mptcp@lists.linux.dev>; Mon,  7 Sep 2026 05:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788760209; cv=none; b=tOgYH0IVRZFs4N1w5+md61XVAEJzykeUalhZlh43n8WUD5yumBXwDXpDd2kv5/+/lleCoz7rarHsxMJiYMKqh4VimW91U8ZBEKdTR7yXNF/OywImyL9GBFkn5wnlYhG82hIw32oTJZWtr9sh3Pp/e566DSzqlcB+KoOqA3sIOOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788760209; c=relaxed/simple;
	bh=AmYyyVBE3ykRiihXjZh+FTHO896Zvpg2qFKIBK3S7Vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rv6yq0FCdlRYO6jZTMKoUs3+dqkfX1aJyU6UfcIlz6lHJUGT3WzGEEnHr7KZmglaLaq1ypZdkaZcMjM2t6GYhcf5Viyxgb8xE59AxiKWhxB1/P/niDqZ0m1u+QLgTi/xbYtbYSdWiptZgWYt6/+Tbw/OUEKws+4N5VkHfwWlS7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXcM0FoQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXcM0FoQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD6B1F00A3A;
	Mon,  7 Sep 2026 05:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788760207;
	bh=dwzqH3fxLAq/Iv7oHrFZe6ol0B+tlY3anP0rxgOPP4g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AXcM0FoQPyMH2ylrYWulF2PBCQfrJ8nhpnNMDFAutZtsQ1uTaNVOxJyC1e5wIObcV
	 Cn9M6p4nVoHGCgUXzBd5ecx3DqAQftiHujH5qIVKxQsnjitmSRht7rqqsiOA5+p00r
	 qURGvORZtl+BAesdN+076x3GD2kJFiZI9qt3alkQNByGM+z+VIFBJDeS3w8+KlK1E3
	 XqImZZxrROaI1ujGD2GWOa/NK5pRBpz85M2EPtg0vP9Q8szIbrmd00JfPDXLBr20u4
	 SAxolzPsXZb5vUeVwuj8Cp4yutaxWWzp+jr4TS2gWgGGInyAbe8o/iIsgt7GBCd7Nk
	 14jOTVgzT0rtQ==
Message-ID: <afad1474-88ac-413c-b81c-1ff1de2c6738@kernel.org>
Date: Mon, 7 Sep 2026 07:50:04 +0200
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
Cc: MPTCP Linux <mptcp@lists.linux.dev>
References: <20260902-mptcp_nft-v1-0-559caa16f410@kylinos.cn>
 <20260902-mptcp_nft-v1-2-559caa16f410@kylinos.cn>
 <513e6559-a06a-45d8-a8b7-72b3a1a77e71@kernel.org> <apjU-uM8dvxnVcaP@fedora>
 <6c9dd599-e9d2-470f-bc7f-2af2e9d003b6@kernel.org> <app68h1_rYkPBpvn@fedora>
 <aa5678f7-7089-4049-9120-6604372667ac@kernel.org> <ap4NEvXYLC1U8hqO@fedora>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ap4NEvXYLC1U8hqO@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Hangbin,

On 07/09/2026 03:02, Hangbin Liu wrote:
> 
> Hi Matthieu,
> On Fri, Sep 04, 2026 at 06:40:02PM +0200, Matthieu Baerts wrote:
>>>
>>> Yes, if not in purpose, I feel flush the whole table is dangerous.
>>> Some rules may still in using in later testing.
>>
>> Indeed. But in our case, each subtest uses a dedicated netns. Plus only
>> some tests add Netfilter rules. At the end, it is clearer to delete a
>> specific rule, but I think that makes sense only if the nft_handle var
>> is set locally, and used a few lines below.
>>
>> If a global nft_handle var is used, that doesn't seem clear, and I think
>> it would be clearer/easier to:
>>
>> - either delete a specific rule (but I don't think that's supported)
>>
>> - get the handle from the test and use it to delete the rule
>>
>> - or flush the table.
>>
>> So up to you, but probably best to avoid using nft_handle as global var.
> 
> Thanks, endpoint_tests is the only test that could delete iptables rules.
> I use the nft_handle mainly because the iptables also delete rules with
> specific match (iptables -D OUTPUT -s .. -p tcp -j REJECT) other than flush
> the table directly.
> 
> endpoint_tests
>   - reset_with_tcp_filter
>     - iptables -D
>     - iptables -I
>     - iptables -D
>   - reset_with_events
>     - iptables -I
>     - iptables -D
>   - reset_with_tcp_filter
>     - iptables -D
> 
> While from the logic it should be safe to flush the tables. I can avoid the
> nft_handle in v4 (after v3 review).

Just to be sure it is clear: nft_handle can be used, just better to
avoid using it globally I think. An alternative could be to pass a local
nft_handle to reset_with_tcp_filter and set it there, but in bash,
that's not very clear either.

> Just one question, why we use
> iptables -I here? Is there any intend? If not I will use "add" instead of
> "insert" in nft rules.

I don't remember. I would say probably best not to change the behaviour
during the transition. We could add a commit switching back to "add",
but if that doesn't change anything, probably easier for the reviewers
to keep "insert" (or add an explicit message in the commit message
explaining why it is better to change).

>>> However, I cannot perform a reset on the b4 branch, and git rebase also failed.
>>> These steps have blocked me a little. I have to manually recreate the b4 branch,
>>> or perhaps avoid using b4 when working on mptcp changes.
>>
>> You need to use `|git rebase --onto` instead, e.g.
>>
>>   git fetch origin  # adapt here and below if needed
> 
> For export branch, I think git fetch is not enough? I have to reset
> to latest net/net-next merge commit and pull on that.

I'm not sure to understand. 'git fetch' with the right remote should get
the latest <remote>/export branch ...

>>   git rebase --onto origin/export "$(b4 prep --show-info base-commit)"

... then this command will use this new ref. Why do you need to reset
net/net-next merge commit?

> Yes, it works! New git usage learned :)
> 
>>
>> Can you check if it works for you, please? (so I can update the wiki
>> page if needed)
>>
>> The alternative is to use `for-review`, with a continuous history, see:
>>
>>   https://github.com/multipath-tcp/mptcp_net-next/wiki/Git-Branches
> 
> I will try this tree next time

Up to you, but "export" is good as well, and required when using "git
blame".

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

