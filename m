Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863AA4A7C9F;
	Mon, 28 Sep 2026 11:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790594663; cv=none; b=SB0fWmuU1CIqdo1J8Ace+ILaxMFZn+tfhwvGVfAxcHBocvE+inaNSZMC8nwgL+9GLic7/1FSURk733+nF+BiA0IEw2wZVHy8UilsEhp8GY2Em9nuA+ynWoTltKUkaNmXweOrIcEs12yNEsvSg0eAHFof8TJHkYxu5bGoAySyPwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790594663; c=relaxed/simple;
	bh=gtZDbubhec8csC6UVvBqQ4f8lijBqvFrlIsRpAyroKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qqew/9TSbmkIVEjDFablTHAgzq1DJyTRVnkqIFNJtUtCCKWo7Qs5QPA008jhyhLI67YxPrzPAT1sTuDQADH2Rn9sZYI0P6h5OLIds3+eltAO1vag80SN1+pfq8GXttMxKm+/tvOg/rxKdEkRsRhTi5PBouTAA0lXR1/Dx2G5CZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhTm68xE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhTm68xE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2306C1F000FF;
	Mon, 28 Sep 2026 11:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790594662;
	bh=8vz7DW6qXG0wgoJPsKce8ZATJmLbORV6eL3r0XDbp7Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LhTm68xEuTe1a5nNaW6U37A7iuKqHGdNXEf0cHf8e1d/0cifUpWnAJzC9c1dzJGNb
	 ZqRw1u5xGdgy/qv4fcAvWhFJpj9mKlMAcuBYSXOdXcxjvAKyAM60v0ogIKtfLUuq24
	 yc98o8ALVYYKcBn9A5zaSH2TK3lXl6UE+qgua2E7agp8+qDmEuBD4JDWmMad6aa9c/
	 lqj1LAyJi7lWt3FbIWtEZ+IDyVLI2o0HD+pBYos7mHO4WEat/5dNb8/OYNeQ//noJT
	 OctyteAclRf/+Mj3Gr2IPEiiIh+Jq8+nx05Z4UwV/oMIR7MHkGPMWbJTCdZ51u55+T
	 7q+7bzEKwu6hQ==
Message-ID: <a6b1c774-ab85-4c58-93bf-aa0e24385139@kernel.org>
Date: Mon, 28 Sep 2026 13:24:12 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next 4/5] selftests: mptcp: convert iptables to
 nftables for mptcp_sockopt.sh
Content-Language: fr
To: netdev-bot+sashiko@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 quanyeyang@proton.me
References: <20260926-net-next-mptcp-misc-feat-7-4-v1-4-67af4ab37406@kernel.org>
 <179058242329.3145.13094983040753478975@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <179058242329.3145.13094983040753478975@kernel.org>
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

TL;DR: False positive: no new version needed here.

> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The nft/jq tool check added to mptcp_lib_check_tools()
>   (tools/testing/selftests/net/mptcp/mptcp_lib.sh:531-532) only runs…
> - [Low] In add_mark_rules()
>   (tools/testing/selftests/net/mptcp/mptcp_sockopt.sh:57-60), the…
> 
> --
> 
> selftests: mptcp: convert iptables to nftables for mptcp_sockopt.sh
> 
> This commit makes mptcp_sockopt.sh use nftables instead of
> iptables/ip6tables. It creates ip/ip6 filter tables with an OUTPUT chain,
> and check_mark() now reads the drop counter through nft -j and jq. It also
> extends mptcp_lib_check_tools() to probe for nft and jq.
> 
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>> index b9d14647f4019..e65b4ebee06a6 100644
>> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>> @@ -528,7 +528,7 @@ mptcp_lib_check_tools() {
>>  				exit ${KSFT_SKIP}
>>  			fi
>>  			;;
>> -		"iptables"* | "ip6tables"*)
>> +		"iptables"* | "ip6tables"* | "nft" | "jq")
>>  			if ! "${tool}" -V &> /dev/null; then
> 
> [Severity: Medium]
> Is nft -V the right probe for nft here?
> 
> For nft, -V prints extended build information, and only newer nftables
> releases have it. The portable version flag is -v or --version, which is
> what the other selftests use. For example, the netfilter/*.sh scripts call
> nft --version.

It requires nft >= 0.9.4, released in 2020. I think we are good.

> If an older nft rejects -V, would mptcp_lib_check_tools() exit with
> KSFT_SKIP from the top-level call in mptcp_sockopt.sh?
> 
>     mptcp_lib_check_tools ip nft jq
> 
> That would also skip the transfer, sockopt and TCP_INQ subtests, which
> don't use nft at all.
> 
> The opposite case is also a concern. check_mark() needs an nft that was
> built with JSON support:
> 
>     drops=$(ip netns exec "$ns" nft -j list table "$tables" filter | \
>     ...
>     if [ -z "$drops" ] || [ "$drops" -ne 0 ]; then
>             mptcp_lib_pr_fail "got $tables $drops in ns $ns," \
>                               "not 0 - not all expected packets marked"
>             ret=${KSFT_FAIL}
> 
> On an nftables build without libjansson, nft -V still exits 0 and just
> reports json: no. add_mark_rules() works, because it only uses nft -f.
> 
> nft -j then fails with "JSON support not compiled-in", so drops is empty.
> The test then reports "not all expected packets marked" and sets
> KSFT_FAIL. Should a missing userspace feature give a skip here instead?
> 
> The later patch in the series, "selftests: mptcp: convert iptables to
> nftables for mptcp_join.sh", keeps the same "nft" | "jq" case with the -V
> probe. So it looks like this is still present at the end of the series.
> 
> Would a separate nft check match the real dependency better? For example,
> nft --version plus a JSON check such as nft -j list ruleset.

I don't expect packet distributions not building nft with JSON support.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

