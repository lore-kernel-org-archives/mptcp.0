Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D751F4AC14D;
	Mon, 28 Sep 2026 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790594668; cv=none; b=eSV+bgF+jl5GV+y49ExHCo+dhOcKiw4KEUPzmpSRZtiM33Z6NJBaBdYF20pFThrab7por0jvVmddH7mc+Bp4pkd+Vmn/+xxSQjfd1LxTpUFVNN1R5CnsYsYspG4yz4s0vyrvI1n3Y7WRp4SNuOlmvbcfV2Fe6oXsXF8bupaonz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790594668; c=relaxed/simple;
	bh=96zShvewS0FUHaZkV3Ypl0XopKvOITUxP8nkh+iwyhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t0cwjGLSVXYyg0typ7QZNJCVXrXaf5MWpvXGLvNpbwQmv+ahr/za6B3V0pfinyIpV61JV5ER2JFjUXkyGc3IrKanH5dXiAdIfPdxBY6JUhzmypJOzQIUZWa/mu/4apjV6CzC7t5Juo3iUaSTE2cYFeRKdY1AWQfYSJ8oJeaJe90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TO+4cgpM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TO+4cgpM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7411F00898;
	Mon, 28 Sep 2026 11:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790594666;
	bh=Z+flXo99CE7ujWH6j+CbkZKQFDT8A/xMdJen7Hp7HEs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TO+4cgpMI7cf2a5cTLrlWYEyzxwFlGMfCpGu3Ij/ESyVcyhh77hhoJbDzu7OxdA00
	 u+YaDm0OSpMlu/bC99BpR2ptk+jdv1WHmS3N4dX02Z16jM34Z4KO34TRiBSEe8PdLb
	 z/DJfwfBMqDJNDe5Umwwk8vDD/OWQWThon70Rh9VI6qLtcsFMmIC6mSVuNtTMPBfiy
	 7wqwk1lk/81LMeEEgD+Kc2wM1lpJkraL+HDZzDkmJFNMsY4DseaEE9Z6CqmOsrNpvz
	 Ovdhusi0G+JmcW1rxHil+F36NtOVdcnseNS6CJ7AXqoXhLAwMlYKeh8RzxzXVHKVrP
	 eRPYjTy/43YUA==
Message-ID: <deb5e3b3-d1d7-4d1e-8bb6-95050769d656@kernel.org>
Date: Mon, 28 Sep 2026 13:24:20 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next 5/5] selftests: mptcp: convert iptables to
 nftables for mptcp_join.sh
Content-Language: fr
To: netdev-bot+sashiko@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 quanyeyang@proton.me
References: <20260926-net-next-mptcp-misc-feat-7-4-v1-5-67af4ab37406@kernel.org>
 <179058242453.3145.1450534124183352369@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <179058242453.3145.1450534124183352369@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

On 28/09/2026 10:00, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.

TL;DR: It looks like there are issues with NFTables, but no new version
needed here for these MPTCP patches.

> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] In endpoint_tests()
>   (tools/testing/selftests/net/mptcp/mptcp_join.sh), the new rule `tcp…
> - [Low] The patch removes CONFIG_NFT_COMPAT from
>   tools/testing/selftests/net/mptcp/config, "since we don't need it now".
> 
> --
> 
> selftests: mptcp: convert iptables to nftables for mptcp_join.sh
> 
> This converts the iptables/ip6tables rules in mptcp_join.sh to nftables.
> It keeps the same table and chain names and adds init_nftables() to set
> up the tables only when a test needs them. The cBPF bytecode that matched
> the ADD_ADDR and RM_ADDR suboptions is replaced with "tcp option mptcp
> subtype" matching. In the config fragment, CONFIG_NFT_COMPAT is swapped
> for the nft modules that are now needed.

(...)

>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index 18ce7136a2b0e..b16e24418e737 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> 
> [ ... ]
> 
>> @@ -4402,12 +4372,10 @@ endpoint_tests()
>>  
>>  		# To make sure RM_ADDR are sent over a different subflow, but
>>  		# allow the rest to quickly and cleanly close the subflow
>> -		local ipt=1
>> -		ip netns exec "${ns2}" ${iptables} -I OUTPUT -s "10.0.1.2" \
>> -			-p tcp -m tcp --tcp-option 30 \
>> -			-m bpf --bytecode \
>> -			"$CBPF_MPTCP_SUBOPTION_RM_ADDR" \
>> -			-j DROP || ipt=0
>> +		local nft=1
>> +		ip netns exec "${ns2}" nft insert rule ip filter OUTPUT \
>> +			ip saddr 10.0.1.2 meta l4proto tcp \
>> +			tcp option mptcp subtype remove-addr drop || nft=0
> 
> [Severity: Medium]
> Can this rule ever match an RM_ADDR packet on an established connection?
> 
> nft_exthdr_tcp_eval() stops at the first TCP option whose kind matches
> (30 for MPTCP). The subtype check therefore only ever sees the first
> MPTCP suboption:
> 
> net/netfilter/nft_exthdr.c:nft_exthdr_tcp_eval() {
>     ...
> 	for (i = sizeof(*tcph); i < tcphdr_len - 1; i += optl) {
> 		optl = optlen(opt, i);
> 
> 		if (priv->type != opt[i])
> 			continue;
> 		...
> 		return;
> 	}
>     ...
> }

Indeed, the RM_ADDR will be added in a second MPTCP option. It looks
like Netfilter doesn't handle that case. But that seems to be an issue
on the Netfilter side, rather than with the command that should work. I
will follow up with Netfilter devs. If a fix cannot be added on their
side, I will change the nft command to look at a specific offset.

Note that the command here is just to check there is no RM_ADDR sent on
the wrong side: it shouldn't catch any packets here anyway.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

