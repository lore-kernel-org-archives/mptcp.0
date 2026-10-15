Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD6252FE49;
	Thu, 15 Oct 2026 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792072882; cv=none; b=Oq3a9e/t6P0kE0iWcO8FZsnmDBsXBo9O2puwqq7XGhjAQyeDgrpeew7fXIeF2m/MgJtt7m62KuZNMwRlJL2AXdIcMM7Jk0SY3DIrwaUPU+AadZglT/gRv8ghTpVrSYqbd6UkubhKB8de2tGu6821n8hiTqPZXUSgXVkymTphUg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792072882; c=relaxed/simple;
	bh=zQL3qSUowu0rrs8+iZQGoZGjL/KOJYqqe1X0AwjWNIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bKCeg3HWoQnGpqOmq0/EuedS1ixqG/Mbbo3y7YjrWlwRpPzI3aOEqeF3YNTI/swqnBxgkiK8gsAD4QC+BXpvCTRJ3wa2wsWhBlMttSs1rqTgiO7PWTzQEHVtdpmxBGBQ1oRlCorMHmQUZKdbM3ggCz7QkrTbHEAXv7ChE03dtLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtT5lg5R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtT5lg5R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071241F000C5;
	Thu, 15 Oct 2026 14:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792072880;
	bh=klUThUGZ1hiPn8RzG4E3smXlt9xowrUvd+yKdXtjHsw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mtT5lg5R6WFY8oSxtTTjl2OW7U8LwGFcmqn2Qp+jo2BGmt6+cx1krXuS0BAWSIoVn
	 QZVoNp+4l+OCPvKYnXh5DmYLhZM4se+u0H9MJHpK04bdJVBRAtG8MMZvHWvo5aEn9W
	 3k6eWsLtr7NasHsJTqXHQkU6z2WeZiYl9LiVWK8z5lrWn3lRJIG2wZZpl89M1+rSkd
	 +QaYzJMlGbu7OHLxpsjgCSnm3SdVi5zdnxOD5XhGEUNZv0KV9560F3LL6I1FHI15q2
	 3HxWdzUNxwtLjdeL8BTBnA4mnG6l2XW+gru8HL3+0IJzkjrbPz3yr4pjD5jtnkGoXc
	 fM5F1EkF5dX8g==
Message-ID: <a3bd583f-f942-4636-8057-593357f10ec0@kernel.org>
Date: Thu, 15 Oct 2026 16:01:13 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next 3/4] selftests: mptcp: convert iptables to
 nftables for mptcp_sockopt.sh
Content-Language: fr
To: netdev-bot+sashiko@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 cpaasch@openai.com, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, liuhangbin@kylinos.cn, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 Hangbin Liu <hangbin.liu@linux.dev>
References: <20261013-net-next-mptcp-misc-feat-7-4-part2-v1-3-1181e5d2fda4@kernel.org>
 <179201140828.434549.10971881913720826839@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <179201140828.434549.10971881913720826839@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/10/2026 22:56, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:
> 
> - [Low] The commit message does not mention two new runtime requirements
>   added by this patch.

(...)

>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
>> index e850a87429b61..ef2738720e249 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> 
> [ ... ]
> 
>> @@ -105,32 +109,31 @@ cleanup()
>>  
>>  mptcp_lib_check_mptcp
>>  mptcp_lib_check_kallsyms
>> -mptcp_lib_check_tools ip "${iptables}" "${ip6tables}"
>> +mptcp_lib_check_tools ip nft jq
> 
> [Severity: Low]
> This isn't a bug, but should the commit message list the new runtime
> requirements? The script now needs jq and an nft built with JSON support
> (nft -j list ruleset). The shared mptcp_lib_check_tools() helper in
> mptcp_lib.sh also gets new "nft" and "jq" cases.
> 
> The commit message only says:
> 
>     After conversion, the generated output matches the original
>     iptables/ip6tables behavior.
> 
> The reason for using JSON and jq appears only in the v2 notes below the
> --- line, and those notes are dropped when the patch is applied.
> 
> This check runs at top level, before any subtest. So a system that has
> iptables but no jq, or an nft without JSON support, now skips the whole
> script. That includes do_mptcp_sockopt_tests and do_tcpinq_tests, which
> don't use netfilter.
> 
> Could the commit message mention the jq and nft JSON dependencies and the
> mptcp_lib.sh change?

nft is implicit. 'jq' is used in many other selftests. No need to
re-spin (but if we do, yes we can mention it just to please Clashiko).

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

