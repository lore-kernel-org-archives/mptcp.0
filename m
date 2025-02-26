Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0C822171C
	for <mptcp@lists.linux.dev>; Wed, 26 Feb 2025 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740587393; cv=none; b=Rh1PkcAQFk7C1FZ6GV1Hn10H5QALeVrfTYpYS2jy3UKUqXbzjJWWGSfCPpYhER21x3uqRPONl8pxgbXfsggFcfLX1O/0j+kcuSgYuxiBgBcThvyyDMvjOnz0CcofpQU8C/Tg78SYW3+GnxM0rnAzmq+LqGsuDN+yPpWq45ak3tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740587393; c=relaxed/simple;
	bh=ID5MJUAzO+8tcjW6lFWOXV7fRLPW5I62B9M5UtxrSmc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rRuEQ5Sw7vjwnBO5ZYsXfktGkLFCHcJsSGiee9p5RP2LjTILhXKOWVQilcHmzzbI5l0vjMy9mvxZR22Ppnmo+f/NNwY2nKrFBtkUNwnRboiFqMJbdsXTopaqlZsXMmSZPpX1PjGveYH02TP2Sf5AmUi+n7kTvCGp+2nwfg6I5iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NHU/HBGW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NHU/HBGW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08604C4CEE4;
	Wed, 26 Feb 2025 16:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740587393;
	bh=ID5MJUAzO+8tcjW6lFWOXV7fRLPW5I62B9M5UtxrSmc=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=NHU/HBGWtML1/xB6NSNoMR2VW7gOElkE7Mulcoz/bcGBZ+3XUM8it7lmCO2WKaEv0
	 aAqD4QKVy6sPHDmCBQsLDLd9mwRAZBbq9WsbyAn5+D7Mg1es0CcN8ORNxVZ+UWgeYc
	 7rt7gglIJwC7psLOOIocvuLb6oAAyw+KjUgBIUDLRHuaPSGU52uySX8I+PfJ7YBGS1
	 v+BI5nXmXncQ7aeSF36jXrQmozT8WhkPcC0HphTFmQtfImUdLidXzrkbdzAt0pXa96
	 ooKzMbX87HkdTkFOz7oAm71gh9Nf3SMdRsaSeyMlqQNZnan9/4doHst1qYq3cMJynX
	 rfHDkBSUlckKg==
Message-ID: <c2012b0e-6bd4-4519-b466-4e6b31cd3f70@kernel.org>
Date: Wed, 26 Feb 2025 17:29:49 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v1 0/6] BPF path manager, part 4
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1740384564.git.tanggeliang@kylinos.cn>
 <dcd5cd26-03d6-4b8e-bd60-c27c7ed07497@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <dcd5cd26-03d6-4b8e-bd60-c27c7ed07497@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 24/02/2025 12:05, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 24/02/2025 09:13, Geliang Tang wrote:
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> Some path manager related refactoring and cleanups.
>>
>> Geliang Tang (6):
>>   mptcp: pm: in-kernel: avoid access entry without lock
>>   mptcp: pm: in-kernel: reduce parameters of set_flags
>>   mptcp: pm: use addr entry for get_local_id
> 
> For these 3 patches above:
> 
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

These 3 patches are now in our tree (feat. for next), with the proper
SHA in the Fixes tag for the first patch:

New patches for t/upstream:
- c8a2f8c2afac: mptcp: pm: in-kernel: avoid access entry without lock
- 91606b7d16da: mptcp: pm: in-kernel: reduce parameters of set_flags
- 29b6fd0cf693: mptcp: pm: use addr entry for get_local_id
- Results: 1238896935ea..3635c12a532c (export)

Tests are now in progress:

- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/100f5ffc0c317c10656b1397607f52d95d0d8911/checks

Note that there was a small conflict with "mptcp: fix 'scheduling while
atomic' in mptcp_pm_nl_append_new_local_addr".

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

