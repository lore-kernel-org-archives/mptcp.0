Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9990147ACC5
	for <mptcp@lists.linux.dev>; Thu, 20 Aug 2026 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787241841; cv=none; b=QjIykbSJqJrMtXPHiOSY7kpunU7mnU4bMkw+GA0baSuiaW1ALdloQkz415Js3GtxhnqWgVfBYcy+MdAkIQz9QqUXRKLsjxIja656spn8Ao5e9G8zcrhEYMIqbc4HUdkk0z/Oea83gq9xfHi2YFlV6zz3l1iR8BFZabKZaA1qY/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787241841; c=relaxed/simple;
	bh=gQhSMy9VM9ZBiuqB3pME/3XeXjsNEKPI7hNykgtF6gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gko3beAPY3wM3CUfKTkYu/rUGDOEKyd754NdWwFHrfk7SoSHB2Va3MTMm02EMiBB7PCNaDuPuiNx0OBZtakP7PFnovWjEx3M08GvjBsw1/IPw7D/WEwr6aa0ctpu0a/ChRRNjUpccSOEqDU4NLC3lxCybUmWmQReuRERzZjJ3Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fmc5jzT2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fmc5jzT2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF37C1F000E9;
	Thu, 20 Aug 2026 16:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787241839;
	bh=Juiu+jZnExXFp5Y3thLZE3HHicJVl/CLH4Pg4WYN5X8=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=Fmc5jzT2K2oUIZTijbqE4rLDM4ZtpPp3stlOZ8lwwOqa4/zvfkm7FsTn6AHcxFvsE
	 DXwF1Td8+wHp5ioihuLgNn4yXlcUjtT5WdZ2ST/3ywRhK1WQDiYSx7V8XwI+Uf84MG
	 Hm9kBE5nobX/iArohdMlwvshbQa/7E1rR1c7xWqob7tnst7c/sdL4gxOmIOFQZeIRI
	 EbOkuEaXsFGaYM0K3YvI8qYQF7ttRAi7n2/JYGRwjN1L+ouEq4WKhF1i2HKPW2Jde3
	 hBr7CeTT7rqFOez3oc5eUEU+d9x1BCmVRSEJtLFpXGlpwAnvRCzhbnfJqEgo90KUUP
	 8XKksjkkQMSxA==
Message-ID: <ed014fca-ce98-4ea9-bf69-5fa328000877@kernel.org>
Date: Thu, 20 Aug 2026 18:03:57 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: options: fix uninit-value in
 mptcp_write_data_fin
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>, MPTCP Linux <mptcp@lists.linux.dev>
References: <20260814-mptcp-dfin-csum-v1-1-08d0b9b86bb7@kernel.org>
 <0680b4cbbcb963684af9101936825fa09b71a335.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <0680b4cbbcb963684af9101936825fa09b71a335.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 19/08/2026 11:09, Geliang Tang wrote:
> Hi Matt,
> 
> On Fri, 2026-08-14 at 23:38 +0200, Matthieu Baerts (NGI0) wrote:
>> When sending a DATA_FIN without data, and because the DATA_FIN
>> occupies
>> 1 octet of the connection-level sequence space [1], it is then
>> required
>> to add a DSS mapping with specific values.
>>
>> If the checksum has been negotiated, it also needs to be computed,
>> and
>> included in the outgoing packet, and thus the initial csum data needs
>> to
>> be reset to 0 as well. This is no longer the case since commit
>> cfcceb7a39fc ("tcp: shrink per-packet memset in
>> __tcp_transmit_skb()"),
>> because the whole ext_copy structure is no longer zeroed by default.
>>
>> This seems to be the only case where use_map is changed and set
>> afterwards, so initialising the csum field only in this case, along
>> with
>> other fields for this specific case.
> 
> Initially, I was wondering if we could skip calling mptcp_make_csum()
> for data_fin in mptcp_write_options(), similar to how we skip it for
> the infinite mapping:
> 
>         /* data_len == 0 is reserved for the infinite mapping,
>          * the checksum will also be set to 0.
>          */
>         put_len_csum(mpext->data_len,
>                      (mpext->data_len ? mptcp_make_csum(mpext) : 0),
>                      ptr);
> 
> But I realized that your modification is more straightforward.
> 
>>
>> Fixes: cfcceb7a39fc ("tcp: shrink per-packet memset in
>> __tcp_transmit_skb()")
>> Link: https://datatracker.ietf.org/doc/html/rfc8684#section-3.3.3 [1]
>> Link:
>> https://sashiko.dev/#/patchset/20260812-net-next-mptcp-misc-feat-7-3-v1-0-1905a818f6cb%40kernel.org?part=2
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> Looks good to me!
> 
>     Reviewed-by: Geliang Tang <geliang@kernel.org>

Thank you for the review!

New patches for t/upstream-net and t/upstream:
- fbdc41264992: mptcp: options: fix uninit-value in mptcp_write_data_fin
- Results: e9b9aadd7dfb..d251bdc7d65e (export-net)
- Results: 8cefef708ced..77661003be12 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/439ace86ec3085a503e16283cf2719876d9a9d7e/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/7c1c363f2cd4fb1dbd7edb83dc2d57313289d200/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

