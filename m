Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCFE37C83
	for <mptcp@lists.linux.dev>; Mon, 16 Oct 2023 20:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRjS8XPg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D798C433D9;
	Mon, 16 Oct 2023 20:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697487999;
	bh=zHcRWgnu1ympZ3h1VLkss7hHA7getBzctmbZoEtcEbk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pRjS8XPg82YeQ5MvBDXpQR5mJRpGvqsKYEA8BTBxcYF7S4LMUyfb5P0hf5ctErqXu
	 TdrPdiCG2II2lQVbPmVPTjYn+kkRd2U5En764Rm4ofes1hK7daCwYeNW3szrbNumrd
	 NkJmTNjZMnoUyOkUkYjvAJTHtN7sBm/19fcwUAFeJM59I9HlCxzpJMqJBJW/Ou/fSn
	 vJxc4WgxUIswVsQtjex993dqhSKNOI9jT+cBrAz4oxlh9QidODSR6vT8qnNKy25Vs6
	 AZu38DTZyIM7IylAP1FRKht90Rj9Z0tsNYMh1cxCD6dLQA14cVHmPjS4zE5AVkG5PN
	 YRgzk55Iy8LWw==
Message-ID: <67be1103-aeac-41f8-a524-42fc8b6363dd@kernel.org>
Date: Mon, 16 Oct 2023 22:26:35 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v16 3/8] Squash to "mptcp: add
 mptcpi_subflows_total counter"
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <cover.1697175899.git.geliang.tang@suse.com>
 <4f136ef2b23fb55e2e42397f1e07e74b355d5f61.1697175899.git.geliang.tang@suse.com>
 <e3769002c1ff6139f9359413cd1ad415e593a3f2.camel@redhat.com>
 <b7f0d827-ff8f-4348-be2b-c33e56b736ff@kernel.org>
 <5f72f297be7687b86eec5ac19ef51c8a3df98048.camel@redhat.com>
 <68dcded0-6821-4c51-9031-f3cce40d98ce@kernel.org>
 <87c2af7f16c03e093fc6efc4be0e022f85be5323.camel@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 Fe7fduHbABmYz9cefQpO7wDE/Q==
Organization: Tessares
In-Reply-To: <87c2af7f16c03e093fc6efc4be0e022f85be5323.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Geliang,

On 16/10/2023 15:50, Paolo Abeni wrote:
> On Mon, 2023-10-16 at 13:53 +0200, Matthieu Baerts wrote:
>> On 13/10/2023 17:35, Paolo Abeni wrote:
>>> On Fri, 2023-10-13 at 12:46 +0200, Matthieu Baerts wrote:
>>>> On 13/10/2023 12:32, Paolo Abeni wrote:
>>>>
>>>>> You can list explicitly add the valid states with something alike:
>>>>>
>>>>> 	(1 << inet_sk_state_load(ssk)) & (TCPF_ESTABLISHED |
>>>>> TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_LISTEN | TCPF_CLOSE_WAIT)
>>>>>
>>>>> I'm unsure if we should include CLOSE_WAIT here: the remote has shut
>>>>> down, but this end can still send data...
>>>>
>>>> Maybe better, no? As long as the behaviour is similar to the one with
>>>> 'msk->pm.subflows'.
>>>
>>> If we keep the way we account for MPJ subflows as a reference
>>> CLOSE_WAIT status must be excluded. I agree/now see it's the better
>>> option.
>>
>> OK, so no CLOSE_WAIT, right?
> 
> Exactly, no CLOSE_WAIT

@Geliang: do you mind including what Paolo suggested -- without
CLOSE_WAIT -- in the next version?

>> I suggest to also modify the title, something like:
>>
>>     mptcp: avoid sending RST when closing the initial subflow
>>
>> And this Fixes tag:
>>
>>     Fixes: c2b2ae3925b6 ("mptcp: handle correctly disconnect() failures")
> 
> Fine by me.

Great, just applied the patches in our tree (fixes for -net):

New patches for t/upstream-net and t/upstream:
- 6c7131fb5cc7: mptcp: avoid sending RST when closing the initial subflow
- 1f39dcb567ca: selftests: mptcp: join: no RST when rm subflow/addr
- Results: 83a52a5f95c9..2fa503488095 (export-net)
- Results: c0f977cdc194..92a5724f0df6 (export)

Tests are now in progress:

https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export-net/20231016T201914
https://cirrus-ci.com/github/multipath-tcp/mptcp_net-next/export/20231016T201914

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
