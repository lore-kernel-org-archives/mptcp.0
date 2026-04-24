Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66E73264E2
	for <mptcp@lists.linux.dev>; Fri, 24 Apr 2026 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777024303; cv=none; b=B+aSuxPY9bubVIV13d49ZhVwjxyD5kng+0FNorU5PZ0ci1F/BRWGXtpytGk51v1EQMs2lf0hm7BycCHM3KNPC83qk47+k4BBMd8/hbZIHyoz2TDskg9h33ZaHMUMHVAq+Z6iqPObj7JD8ZpFal1n8ZoOEOwBuAsVha6yAIuxCag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777024303; c=relaxed/simple;
	bh=svyYPSrH7QyI8o21KzCyOeGa2lev9XDU31r2ePAa1PQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=irh3IhHp8RTkLCDxPSX2oeP4mJo9BnIiO8gKFknSQY5BHam4XB7tb5Kk7WScRE69IvTQDwuY2j095kT1XPEjquf949QUbd3QkcoToejriEm5rFOOPIlLBiL0iS3it7zT4zGtuTuLeZYZedOoYzOIkmPLXdh/igADRNyfMFpEQts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Motm48qM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Motm48qM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9A3C19425;
	Fri, 24 Apr 2026 09:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777024302;
	bh=svyYPSrH7QyI8o21KzCyOeGa2lev9XDU31r2ePAa1PQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Motm48qMGUt/IJsSWYt2GJorjYIOSfucNf2Fxkw2HLGIeTofhJBOnd4rZH+8wfSa6
	 ht7BnpJqB6lk/tfmdX98B5F7Wjte98XU84uqpyiOxqIgVv5+gmIUdvavxeQGIw3U6C
	 RYUmfIu9UDNQK0uUer5DVY/H3e6XUQQQFSeK6ek0O0tNdvFQHwgRXS3Kd7MKgRmwez
	 4EkbLbZAKwf58YLbza8Y2MAwbfTbYFEtiPZhiwdn9Q31fyTZGgFHCrN/4QarohD3Xe
	 rUHmyBYf9OojddeqJ1CwX3ocW0cOZ+Hoj5DMdsP8qEQ6W9NBeX4Wo5QJK9WIxUoiSz
	 kzpCWNLtEbRkQ==
Message-ID: <d3e7d9f1-f759-4e3b-85e4-b67bf6b3b855@kernel.org>
Date: Fri, 24 Apr 2026 11:51:38 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: pm: kernel: reset fullmesh counter after
 flush
Content-Language: fr
To: Mat Martineau <martineau@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Sashiko <sashiko-bot@kernel.org>
References: <20260423-mptcp-pm-reset-endp_fullmesh_max-v1-1-e43a46fc8d49@kernel.org>
 <6bbf7614-1952-1d6c-bce0-c30023cb5213@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <6bbf7614-1952-1d6c-bce0-c30023cb5213@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 24/04/2026 01:48, Mat Martineau wrote:
> On Thu, 23 Apr 2026, Matthieu Baerts (NGI0) wrote:
> 
>> This variable counts how many MPTCP endpoints have a 'fullmesh' flag
>> set. After having flushed all MPTCP endpoints, it is then needed to
>> reset this counter.
>>
>> Without this reset, this counter exposed to the userspace is wrong, but
>> also non-fullmesh endpoints added after the flush will not be taken into
>> account to create subflows in reaction to ADD_ADDRs.
>>
>> Fixes: f88191c7f361 ("mptcp: pm: in-kernel: record fullmesh endp nb")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Closes: https://sashiko.dev/#/patchset/20260422-mptcp-inc-limits-
>> v6-0-903181771530%40kernel.org?part=15
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> net/mptcp/pm_kernel.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
>> index 7895fb5f982e..382893f22f6a 100644
>> --- a/net/mptcp/pm_kernel.c
>> +++ b/net/mptcp/pm_kernel.c
>> @@ -1279,6 +1279,7 @@ static void __reset_counters(struct pm_nl_pernet
>> *pernet)
>>     WRITE_ONCE(pernet->endp_signal_max, 0);
>>     WRITE_ONCE(pernet->endp_subflow_max, 0);
>>     WRITE_ONCE(pernet->endp_laminar_max, 0);
>> +    WRITE_ONCE(pernet->endp_fullmesh_max, 0);
> 
> LGTM
> 
> Reviewed-by: Mat Martineau <martineau@kernel.org>

Thank you for the review! I will wait for the other PM fixes to send all
of them upstream.

Now in our tree:

New patches for t/upstream-net and t/upstream:
- 8d936865e442: mptcp: pm: kernel: reset fullmesh counter after flush
- Results: 2795355c5cb6..152ab3edc9a1 (export-net)
- Results: c4b8cb69b9fa..2b52586ab290 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/3ec57500f66f2d20368b844f6aeeb7da4d5f6e43/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/e598d5bb47cfbecb2dd9c98b5030894463445267/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

