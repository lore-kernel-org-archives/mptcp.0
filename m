Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B6148A8D3
	for <mptcp@lists.linux.dev>; Fri,  9 Oct 2026 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791538717; cv=none; b=TwNs3USI7oF6CTqVP0C+nj5M8BSV4vrWIaf6Yk566pAXc5fgy9eKV55mjsVx/lyZS2I7+AWkWIoFQNBMSY9P6Dr8qjnyYLoQk+nAr4gPZWlSp2GBCH7uvB3kV2OvRkETPoEdYUqzrGOuzguFopEx1CjJkIpioDZ/W6a6yn5agAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791538717; c=relaxed/simple;
	bh=JgEDPF96M3jG5lQ9WGrfUhPsGBbPKlm9yQkex/rYRFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aUMGdPF6kN4jXQ2pDqUIMYwChpCcO8qD9Lh57pHgseJ8TXWf9idqF3yt9hOO63JXUsMSMBM4QMm1Bq+n3EnjlqjLj/Z1aIEPNNvHqlDUktZNDuL6XbthI1CuLJTSBs214J5O6TVJp7NsUmd8W/DMD4d6Cw1Pwhc2bYXbLh5gu2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMwywM19; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMwywM19"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F22231F000FF;
	Fri,  9 Oct 2026 09:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791538708;
	bh=fF6mPBSENCI9r1CMSUObb9CL1DZHlWNzVxX52szqYG4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eMwywM19DcNFE7iqpTzpbjrQeychF0BhLDjcyhpApTRyQbW3HTjO4nYcz0BilsDGp
	 qkrHUTbYjx5Rdo5ZXRWHGGcXe1QO3O4t+9/IZ2Rc6qVOQ51iNNbnTQpqvFrqHmUlwR
	 pgOBD55Hrdd5JHFILNH/XH+5MD3VZ7cCqL8AVbzZ2dvK6nc6tzqehIaVnHP9HtPZ9W
	 w7j5u2fTlXei1GWrBYiNbnoPmp5UEOIQzRqpAswWNcqW7gvNuqIBurWKXLFBLHrTF8
	 YUHjyjGHAEa2ObkWENs7lDO866M9Py583AOega83Xydk23IVFRzaBs8Rhp9iosW6le
	 ax72nIBZkZWyA==
Message-ID: <115e155e-734f-44d9-95d1-d82b6fcfed08@kernel.org>
Date: Fri, 9 Oct 2026 11:38:26 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: convert iptables
 to nftables for mptcp_join.sh"
Content-Language: fr
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: MPTCP Linux <mptcp@lists.linux.dev>, Hangbin Liu <liuhangbin@kylinos.cn>
References: <20261009-mptcp_remove_addr-v1-1-4471d460e026@kylinos.cn>
 <f76282e6-9120-414b-8402-72beb0a12ec9@kernel.org> <asizQp6ewh2fF0Q5@fedora>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <asizQp6ewh2fF0Q5@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/10/2026 11:26, Hangbin Liu wrote:
> On Fri, Oct 09, 2026 at 11:03:07AM +0200, Matthieu Baerts wrote:
>> Hi Hangbin,
>>
>> On 09/10/2026 09:26, Hangbin Liu wrote:
>>> From: Hangbin Liu <liuhangbin@kylinos.cn>
>>>
>>> After squash, the new commit description could be:
>>
>> Thank you for the new version!
>>
>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> index b16e24418e73..cf079c18af12 100755
>>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>> @@ -97,6 +97,20 @@ unset add_addr_tx_nr
>>>  unset add_addr_echo_tx_nr
>>>  unset add_addr_drop_tx_nr
>>>  
>>> +# A tcpdump capture of the RM_ADDR message looks like:
>>> +#
>>> +#   [TCP header: 20 bytes] [nop] [nop] [timestamp: 10 bytes] \
>>> +#         [MPTCP DSS: 12 bytes] [MPTCP RM_ADDR: 4 bytes]
>>> +#
>>> +# nft cannot process the RM_ADDR option because it stops parsing after
>>> +# matching the first DSS option. Use hard-coded byte offsets to match
>>> +# RM_ADDR messages. We verify:
>>> +#
>>> +# TCP Data Offset (12 x 4 = 48 bytes), DSS (TCP[32] x 8) kind (MPTCP 0x1e)
>>> +# and length (0x0c). RM_ADDR (TCP[44] x 8) kind (MPTCP 0x1e) and subtype (4)
>>> +
>>> +RM_ADDR_OFFSETS="tcp doff 12 @th,256,16 == 0x1e0c @th,352,8 == 0x1e @th,368,4 == 4"
>>
>> The subtype is on 4 bits. For the moment, the rest are not used, but
>> would it not be better to compare the 20 first bits of this offset?
>>
>> So using this: (not tested)
>>
>>   "tcp doff 12 @th,256,20 == 0x1e0c2 @th,352,12 == 0x1e044"
> 
> Here it should be @th,352,20 == 0x1e044

Yes indeed, 20, not 12.

>> Or maybe we prefer not to be strict for the RM_ADDR size to match
>> options with multiple IDs? Then having:
>>
>>   "tcp doff 12 @th,256,20 == 0x1e0c2 @th,352,8 == 0x1e @th,368,4 == 4"
>>
>> and for the comment:
>>
>> # TCP Data Offset (12 x 4 = 48 bytes).
>> # DSS (TCP[32] x 8) kind (MPTCP 0x1e), length (0x0c), subtype (2).
>> # RM_ADDR (TCP[44] x 8) kind (MPTCP 0x1e), variable length, subtype (4).
>>
>> I can modify this when applying if that's OK for you (and validated).
> 
> And both works for me. I tested these 2 rules, all are able to capture the
> RM_ADDR messages.
> 
>         chain OUTPUT {
>                 type filter hook output priority filter; policy accept;
>                 ip saddr 10.0.2.1 tcp doff 12 @th,256,24 & 0xfffff0 == 0x1e0c20 @th,352,24 & 0xfffff0 == 0x1e0440 counter packets 1 bytes 68 accept
>                 ip saddr 10.0.1.1 tcp doff 12 @th,256,24 & 0xfffff0 == 0x1e0c20 @th,352,24 & 0xfffff0 == 0x1e0440 drop

Did you use 24 for the length because 20 is not accepted?

>         }
> 
>         chain OUTPUT {
>                 type filter hook output priority filter; policy accept;
>                 ip saddr 10.0.2.2 tcp doff 12 @th,256,24 & 0xfffff0 == 0x1e0c20 @th,352,8 0x1e @th,368,8 & 0xf0 == 0x40 counter packets 3 bytes 204 accept
>                 ip saddr 10.0.1.2 tcp doff 12 @th,256,24 & 0xfffff0 == 0x1e0c20 @th,352,8 0x1e @th,368,8 & 0xf0 == 0x40 drop

Same here for 8 instead of 4.

Or is it nft which automatically converted the length to a multiple of 8
with a mask?

>         }
> 
> Thanks
> Hangbin

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

