Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43152224FA
	for <mptcp@lists.linux.dev>; Thu,  6 Mar 2025 08:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250320; cv=none; b=QTgDtuF2D6sMUUQDa3uaQn8c7oBn3GgTu/U8eq2HDhayo4V4lW5cNB1dIH+kKyQjyZJRiA6Y5Xnr2bA+cdPWjYoFXX9IP1dFPLwgLmYp5Lu/RuqkLek/BQb24TW9DYtLGMV5KhCGnO/mU5ZOD3FEX8y2TKbrsNsAKEA5dbgMZ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250320; c=relaxed/simple;
	bh=nmZZbkr+hBr+R5e9pxBuLL6MquB6zfj3+srIkuuljEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U7X2AALjjOdK4OXtO54sTLA8y8r5S56Jd1FJETMXnHfWbAtPja1acSsDr0lPz9/8jXgrdpfe+BqY6PQ545r/JEzEQbKZDVQABA88EPiWCg1Tj3Xx9ZAlrq20x/0XIxZDTXjoE2bTnh4BWIc9c1ae1cmFRelloWJ44/UryVnX1KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i96qDCMV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i96qDCMV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BC1C4CEE0;
	Thu,  6 Mar 2025 08:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741250319;
	bh=nmZZbkr+hBr+R5e9pxBuLL6MquB6zfj3+srIkuuljEE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i96qDCMVeGFhGTA2ZgKv1M5aJoQvuV9UAIGT1Id9IdSsaNVB/BWebIBsB/V1XDExD
	 CI+skjGwIUeornFWcJo643K2PVKbz5V9xGCW/q5PvMRHNDsKHF6YReYyA+3y2WnFlI
	 i9R1ji/WNd+/ZR0izGDgO5HKnCwg/mqmDzYhnRuD7Pvj7D1H6VUZoW8g6SbOs21Atm
	 C6EiKU7DEM/zsPmK83dCCsp7eSLxYyWIkQGmBV1I/1+SMV6aWy1mHTCAERl7BjRIzr
	 PZ17lDlkEJHZg5Qug6J/BAbW4orUAzb/cXc/PQWD/bsWd0/fAoCjkOsK89nT/07xMl
	 wRioZZBpFEJuw==
Message-ID: <46fd9f11-eea0-4a14-abc9-66af712b0b87@kernel.org>
Date: Thu, 6 Mar 2025 09:38:35 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v4 0/5] Squash to "Add mptcp_subflow bpf_iter
 support"
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1740368110.git.tanggeliang@kylinos.cn>
 <e6f4c2e46d6089e4b76fe8a0e8b83557ddfd53de.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <e6f4c2e46d6089e4b76fe8a0e8b83557ddfd53de.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 06/03/2025 02:50, Geliang Tang wrote:
> Hi Matt,
> 
> On Mon, 2025-02-24 at 11:37 +0800, Geliang Tang wrote:
>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>
>> v4:
>>  - drop sock_owned_by_user_nocheck and spin_is_locked. According to
>>    comments from Mat and Martin, in this set mptcp_subflow
>>    bpf_iter only used from a cg sockopt bpf prog, no need to add
>> these
>>    check at this moment.
>>
>> v3:
>>  - patch 3, continue to use sock_owned_by_user_nocheck() and
>> spin_is_locked()
>> checks instead of using msk_owned_by_me().
>>  - patch 5, drop declaration of bpf_mptcp_subflow_tcp_sock. It's no
>> longer
>> used.
>>  - patch 5, update the comment for mptcp_subflow_tcp_sock(), which is
>> a BPF
>> helper, not a kfunc.
>>
>> The commit log of "bpf: Register mptcp common kfunc set" doesn't
>> match the
>> code, please update it as:
>>
>> '''
>> bpf: Register mptcp common kfunc set
>>
>> MPTCP helper mptcp_subflow_ctx() is used to convert struct sock to
>> struct mptcp_subflow_context. It will be used in MPTCP BPF programs.
>>
>> This patch defines corresponding wrapper of this helper, and put it
>> into the newly defined mptcp common kfunc set and register this set
>> with the flag BPF_PROG_TYPE_CGROUP_SOCKOPT to let it accessible to
>> the 'cgroup/getsockopt' type of BPF programs.
>> '''
> 
> Thanks for applying this set. Please update this commit log too.

Done. The modification will be visible soon:

New patches for t/upstream:
- 061566ebfca8: tg:msg: adapt 'bpf: Register mptcp common kfunc set'
- Results: 6c4b1c674680..ccf37aa90567 (export)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

