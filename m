Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB4A69976
	for <mptcp@lists.linux.dev>; Tue, 12 Mar 2024 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710230973; cv=none; b=pF67pcD4sgY4v2xWQS0H3GgVXe/W5POWr0R144CGBFlt/d0vJ6TBBzRKuk5bMLLMz3sGsPor9lW40cVF/nmxIcuxDuVv0j3OfeILTewVay5sLYt+s+xzGyZHPM1SnXqcmkt/lM6aADfHPQLdxR0cmeLKs5spxrnk7iSDFStaTP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710230973; c=relaxed/simple;
	bh=tOLGW2W1YOy+1EEjS5EJMW9Pr7fqtXiZgBXqE9qC8bQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g0P+Zt6fgYIGeN02I2K3UMk/OLl+ZK3ZmNaDoVUoJj7OFHwn+oCE1/a7QVUFkVVLwP7ur9PjGlejubVL0tWYQ59XoNyjBYuHd6YghOC0qtuApANpNeknklfktRdXDF4mFtDO2te6662ypozw3kclE2moM30OT6D/9uh0iRk4Dck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNCkHwaq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNCkHwaq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFEEC433F1;
	Tue, 12 Mar 2024 08:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710230971;
	bh=tOLGW2W1YOy+1EEjS5EJMW9Pr7fqtXiZgBXqE9qC8bQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mNCkHwaq3ryJWV4rDvvu1NFfFUO78oZxNDNGe9M168UMVRJ4J/WefO791ZZQur+3K
	 J95qNrdxFL3EwM+XfBZw6UUffxYiDFvU5360GxV7mwWrqlZDrmMc7b1GNBWWOFWud8
	 HhwzY2Qx53wofKfB4xp7qZxNfeEnV5J4JqAi5bPUmAqfGAPizhmpTu/RL93pu06+aD
	 GYhZtsOMjzYiVq6/M/Yo/Mma/lPhO95RgS8hs+16l3xocjjo71Zs/Rj5+MykyuOUlc
	 G0wJweTRyFM8C1HPnzvjoy7QNDpX/PVTChbm4Dy7qF4dTu1Vt0hfkNxX7peNYi2eS1
	 dAJtpzbMNZCMw==
Message-ID: <4a1febfb-54e0-4d1f-ac56-e5fa4e1bdead@kernel.org>
Date: Tue, 12 Mar 2024 09:09:27 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH iperf3 v3] add MPTCPv1 support
Content-Language: en-US
To: Geliang Tang <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
References: <4a85ab6ab759ba852647b03af58faded31fbb8f6.1710140596.git.geliang@kernel.org>
 <fd131421-bb46-4d40-befd-b2bcd6d2b832@kernel.org> <ZfADyFB1vDYABpf9@t480>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ZfADyFB1vDYABpf9@t480>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 12/03/2024 08:27, Geliang Tang wrote:
> Hi Matt,
> 
> On Tue, Mar 12, 2024 at 08:10:28AM +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> 11 Mar 2024 08:04:05 Geliang Tang <geliang@kernel.org>:
>>
>>> The Multipath TCP (MPTCP) protocol (v1 / RFC 8684) has been added in
>>> the upstream Linux kernel since v5.6.
>>>
>>> MPTCP is strongly tied to TCP, and the kernel APIs are almost the same.
>>> The only required dependency is the 'IPPROTO_MPTCP' protocol number
>>> definition, which should be provided by the netinet/in.h header if it
>>> is recent enough.
>>>
>>> This patch adds a new flag '-m' or '--multipath' to support MPTCPv1.
>>
>> I just noticed you switched back to "multipath" instead of "mptcp".
>> I think it is best to stick with "mptcp", because "multipath"
>> is too vague, thus confusing: it could be multipath as in multiple
>> flows, multicast, with other protocols like UDP, etc.
>>
>> Best to use "mptcp" everywhere: variables, strings, description, etc.
> 
> Sure, I'll send a v4 to update the flag to '--mptcp'.

Thanks!

> But I don't know
> how to update the pull request on github. Should I send another pull
> request?

No, please don't open a new pull request, nor close the old one, simply
override your remote branch on GitHub (`git push --force`).

>>> It can be used like this:>>>
>>>> iperf3 -m -s
>>>> iperf3 -m -c 127.0.0.1
>>
>> If the server doesn't have "-m", only the client, does it use MPTCP?
> 
> Yes, it use MPTCP in this case. I just tested it.

Great, thank you for having tested that!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

