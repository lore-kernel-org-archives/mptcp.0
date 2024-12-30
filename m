Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B421AE877
	for <mptcp@lists.linux.dev>; Mon, 30 Dec 2024 18:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735583078; cv=none; b=L3wq+NQNpVYGj5ajKJYxY9MEFtQE3LdkFoBiG4V5EOzgFbFFMONEyTI5HCd1eoC2omIsE9LGV7O2weTrvuDfeXCxATEQhqPOovu/wRWWiHF4oLhiFXe0O+taWfQbBnEQJi0yLQ6isrrY/k0wXG+k8mwrE6N899zzTj2gr6DLHGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735583078; c=relaxed/simple;
	bh=FeCv9nCvbk8qahplJohZAwYrPyKFQKjKOkWrO693p+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+YHPshUGVqh+aiAX26Szi/yooxarjFk+1y8W5Q+efVr0T9DtVy35xfnfuGWN5kI9shRDxrYwnH6u39h/N2wD8R7RzVtn77LMh943QxhA/55WV9+h8QXUiowEL1kqkjiiqdkUBW2g3lod0tazL5jPl03pzhuxnWUfzOvPJlC0zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YPh8WbxJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YPh8WbxJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8F8C4CED0;
	Mon, 30 Dec 2024 18:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735583077;
	bh=FeCv9nCvbk8qahplJohZAwYrPyKFQKjKOkWrO693p+E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YPh8WbxJkXiaMt05Jg31JyJx7RyYZ9H33tCQU31uc0By0adnhu9W0sKz9pRK23myX
	 BnuGED2hQU1lWHzu3DkyUdZG/qZYjDiIMQeaXQReTAXuDHMcLbn0M2FgxHvQYTG3Kv
	 E3g6y/n4fmKsSer4zC2JDaFUg0VGPkw7XxvJZJLa5ko+i4xNc5+9pecOC7Kr3TNpdQ
	 GsfOCq8hJkuernIa9052PcDCsBlEYaPEGMPaeJajQeGtm4yUDLTlmuWqJTnMnZA8sU
	 SsdPkFEE+zzOZNQcaVbuMHpzgh/M1Ok2WymL+SrRBnl2aTR2hGtQnOgJ/CvhFL5P4Y
	 5E5X0ET3yucXQ==
Message-ID: <b657cb5a-d374-499c-ab31-92f5f6022f66@kernel.org>
Date: Mon, 30 Dec 2024 19:24:35 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 1/7] mptcp: prevent excessive coalescing on
 receive
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <cover.1733486870.git.pabeni@redhat.com>
 <9c5947ad3b55695cb6000900acad5471b7314195.1733486870.git.pabeni@redhat.com>
 <70d5e604-26e1-43f0-a36d-504d2b99c584@kernel.org>
 <22fe2214-b009-46b1-84b9-84559ebe339c@kernel.org>
 <e50db525-cf52-4ff1-94bc-3314878b64e4@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <e50db525-cf52-4ff1-94bc-3314878b64e4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/12/2024 10:40, Paolo Abeni wrote:
> On 12/21/24 11:00, Matthieu Baerts wrote:
>> On 10/12/2024 13:03, Matthieu Baerts wrote:
>>> On 06/12/2024 13:10, Paolo Abeni wrote:
>>>> Currently the skb size after coalescing is only limited by the skb
>>>> layout (the skb must not carry frag_list). A single coalesced skb
>>>> covering several MSS can potentially fill completely the receive
>>>> buffer. In such a case, the snd win will zero until the receive buffer
>>>> will be empty again, affecting tput badly.
>>>
>>> Good idea! Thank you for having looked at this!
>>>
>>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>>> ---
>>>> No fixes tag because the problem is not very visible in practice
>>>> currently, but will be apparent after the rx refactor.
>>>> Still I hope this could affect positively the simlut flows self-tests
>>>
>>> The modification looks safe enough to me: it should not make thing worst.
>>
>> Do you still prefer not targetting -net for this patch here? Or is it OK
>> to do so and add a Fixes tag?
> 
> Whatever is easier to do in practice works for me. Perhaps monitoring
> the simult_flows ST flakes could give an idea - if that get more
> stable/less unstable we should possibly target 'net'.

Thank you for your reply!

It looks OK so far. I just sent this patch to netdev, so we can also get
some tests over there. I will monitor if it helps on NIPA as well.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

