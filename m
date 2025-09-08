Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6673126DB
	for <mptcp@lists.linux.dev>; Mon,  8 Sep 2025 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757351773; cv=none; b=UcpgoZDaTUUVfQmVHHpcsasHbXeNWsoyGFZTL1L3N+q0JZc8tw3c9zv8HjxNc5WWtNdFKTgas3fbN4Zgh+/bdG9/h388VVstx9xm8dBjJAW4OiYPProf0Ju6WCl6PKcbJLrp5gylbwjNAp5g47yMeTtBA49BFM8F8llqMlslOm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757351773; c=relaxed/simple;
	bh=Hs+gWkOlbzzT2YICZ9kx8jveGKfVRXUpVN2Xvm1IhTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y9RyDNddCAn3HzGHQvXDMHaApc2YT1dxus6gCotRRXsrCP4v3zvkhgRjKMcWqnZKHhtqSVCNQlZCs7iuatFC7exTi2UohHcttQpQUJ6EVaqMOzhZL/krMpyhCkTEfP0KVKQIJNsN0nIEquGPZFFzB28tjjoXxJe4d2hcqp4tjnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PD9gR6ba; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PD9gR6ba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFF0C4CEF5;
	Mon,  8 Sep 2025 17:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757351772;
	bh=Hs+gWkOlbzzT2YICZ9kx8jveGKfVRXUpVN2Xvm1IhTY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=PD9gR6ba6oD3ueDFMWdQFhM2j69H1Vg/+UN+lNV6ksAbTOd51mBiQwbmE8PxEbSgy
	 FDEMKqmmElo0GA+wcJgO3izIITXw47W/WjR8eMhU2rUdWgLTnMuzmcavwFb4DIiOk8
	 rq32DlQOqkVpL/QklMubjcwqr7mUmNu2MDO9r4yl2c/L+hE+8Eq7jcCsBbMMhtGbLP
	 qzBC7AVwJHvmpIEYg8dxapAjM8+56eNYUS2iqJsTPlS7o4Ze2lQ5nCJ3FOXZ4rCpOd
	 AEq0gfLp6I3TWK95Ece7E2BjFj1i6XEZs6WZmIhoukUGAaVbXiyJuaTGzBi/cjpTBg
	 rypANZ6HoieSw==
Message-ID: <2bea37bc-4ef2-439c-a71f-55e460a7edd6@kernel.org>
Date: Mon, 8 Sep 2025 19:16:09 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net 4/7] netlink: specs: mptcp: fix if-idx attribute
 type
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20250829-mptcp-pm-user-c-flag-v1-0-78b25dda7708@kernel.org>
 <20250829-mptcp-pm-user-c-flag-v1-4-78b25dda7708@kernel.org>
 <f6f2bdcba4fed92a6257c2faeafb65b570551773.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <f6f2bdcba4fed92a6257c2faeafb65b570551773.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 06/09/2025 16:16, Geliang Tang wrote:
> Hi Matt,
> 
> On Fri, 2025-08-29 at 22:33 +0200, Matthieu Baerts (NGI0) wrote:
>> This attribute is used as a signed number in the code in
>> pm_netlink.c:
>>
>>   nla_put_s32(skb, MPTCP_ATTR_IF_IDX, ssk->sk_bound_dev_if))
>>
>> The specs should then reflect that. Note that other 'if-idx'
>> attributes
>> from the same .yaml file use a signed number as well.
>>
>> Fixes: bc8aeb2045e2 ("Documentation: netlink: add a YAML spec for
>> mptcp")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> 
> Patches 4-6 LGTM!
> 
> Reviewed-by: Geliang Tang <geliang@kernel.org>
> 
> [mptcp-net,4/7] netlink: specs: mptcp: fix if-idx attribute type
> [mptcp-net,5/7] doc: mptcp: net.mptcp.pm_type is deprecated
> [mptcp-net,6/7] selftests: mptcp: shellcheck: support v0.11.0 
> 
> These three patches are relatively independent and can be removed from
> this series. They should be merged into the export branch first and do
> not need to be included in the v2 iteration. I changed the states of
> them as "Queued".

These patches were ordered by kernel versions these patches should be
backported to. But good idea, I can apply and send them today so it is done.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

