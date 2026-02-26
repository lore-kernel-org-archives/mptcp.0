Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5E738F92C
	for <mptcp@lists.linux.dev>; Thu, 26 Feb 2026 07:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772091598; cv=none; b=HL3dnrFCfEvfUgBYTHaSyCzjUuy8zhL4Nm0xVP7vCk7IS4mmzbDzdsJyPdGC09I7K3dmCw3aF41qSY5l+94/Wg4pTWfYGfj+rymToxzWsRIQKOyBwid7ebSv13DVGEkT79YIEVUdrHrsgaEFYrZRTX5jrt6U3daRpcsaJBpcY/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772091598; c=relaxed/simple;
	bh=dNTJ6NuIFrird7kTK7n6+WRRO89JZjdsYmWkioqNFy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKnbOs3oS0rr4gJX3GPCHJkq4JJ3YxrkxIKWnKEzQtyPoVdo8RYoqWv73PEtgptcsz5quS5j2t+wP6Pa0IKe1SRgdhWv5yjAqNnZO/hfDZNyYetcB/QobPx987nsewyxbtxa5dkLQ9tm7ARdXaV+JKhLXQFu0Ldq3ngWmEvrT6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hv7oPsCb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hv7oPsCb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A516C19424;
	Thu, 26 Feb 2026 07:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772091598;
	bh=dNTJ6NuIFrird7kTK7n6+WRRO89JZjdsYmWkioqNFy0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Hv7oPsCbljoT0cgLEjpDNSxF6KvH/8rYySWv5IXkT/b3kItS6KlOrk0XmL65l+lWB
	 x6vySRPA0PS42nV/B8iuQN/TUFi8wFmgwQoocmhL4Rf+/TbS1kmGSP5Mivps/Gw4GV
	 oioe04i9VOEpd27mdp+DGPX3PFrlKDTdHZjQeTW4LYcHdonAgDDG3oxRNzfWg7gmtX
	 igjS0ExDNpo7ivURbqIWVTtVBSiwiqjaLxBOXLsA/f4kpxM8EuZOuJ8HylJjzsQ83+
	 KYzKnrrgpEUWYuiKocWkrqOVIH6Cy4OskzLNPBi927lO7CGfrkdbSZl4Eh/gyFjGuA
	 swRKuXdgmHtcg==
Message-ID: <7e7ce1cb-2645-467d-855d-65258f9d2981@kernel.org>
Date: Thu, 26 Feb 2026 08:39:55 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-net v2 1/2] mptcp: pm: avoid sending RM_ADDR over
 same subflow
Content-Language: en-GB, fr-BE
To: Mat Martineau <martineau@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20260220-mptcp-issue-612-v2-0-089684a6edcb@kernel.org>
 <20260220-mptcp-issue-612-v2-1-089684a6edcb@kernel.org>
 <60bfc032-effc-f85f-6e64-7af0cd3daeeb@kernel.org>
 <886fecf3-e73c-4f23-9dc8-21a7c5aba9e4@kernel.org>
 <9e46338e-5f27-69fa-a3bd-7dbc7674a275@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <9e46338e-5f27-69fa-a3bd-7dbc7674a275@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mat,

On 25/02/2026 17:57, Mat Martineau wrote:
> On Wed, 25 Feb 2026, Matthieu Baerts wrote:
> 
>> Hi Mat,
>>
>> Thank you for the review!
>>
>> On 25/02/2026 05:12, Mat Martineau wrote:
>>> On Fri, 20 Feb 2026, Matthieu Baerts (NGI0) wrote:
>>>
>>>> RM_ADDR are sent over an active subflow, the first one in the subflows
>>>> list. There is then a high chance the initial subflow is picked. With
>>>> the in-kernel PM, when an endpoint is removed, a RM_ADDR is sent, then
>>>> linked subflows are closed. This is done for each active MPTCP
>>>> connection.
>>>>
>>>> MPTCP endpoints are likely removed because the attached network is no
>>>> longer available or usable. In this case, it is better to avoid sending
>>>> this RM_ADDR over the subflow that is going to be removed, but prefer
>>>> sending it over another active and non stale subflow, if any.
>>>>
>>>> This modification avoids situations where the other end is not notified
>>>> when a subflow is no longer usable: typically when the endpoint linked
>>>> to the initial subflow is removed, especially on the server side.
>>
>> (...)
>>
>>> This is definitely an improvement over the older code, thanks! It does
>>> still send RM_ADDR exactly once. It could also RM_ADDR using *all*
>>> active non-stale subflows (any that are delivered after the first would
>>> be ignored). In terms of interoperability there is the risk of confusing
>>> the peer's path manager if it doesn't handle RM_ADDR for a non-existant
>>> subflow.
>>>
>>> Maybe that's more of a mptcp-next feature (if it makes sense to do at
>>> all).
>>
>> I think implementing this would definitively be mptcp-next material. If
>> we want this, we will also need to change the way the option is added:
>> for the moment, the rm_list is copied in the msk, and a bit is set
>> before triggering the ACK, and when sending the ACK, the bit is reset.
>> So we would need to also record the subflow IDs that should send the
>> RM_ADDR, and only remove the main bit when all of subflows have sent it.
>>
>> Now regarding the behaviour, I think it more likely to have concurrent
>> issues: maybe a subflow could be re-created or an ADD_ADDR could be
>> received before all RM_ADDR are transmitted, e.g. in case of bufferbloat
>> on one path?
>>
>>> The v2 patch here is closer to the existing behavior so I'm ok with
>>> approving it:
>>>
>>> Reviewed-by: Mat Martineau <martineau@kernel.org>
>>
>> Thanks! Is this tag also covering patch 2/2?
>>
> 
> Yes, I had intended to reply to the cover letter to RvB the series.
> Thanks for clarifying.

Great, just applied:

New patches for t/upstream-net and t/upstream:
- 2f79a7def595: mptcp: pm: avoid sending RM_ADDR over same subflow
- c4a9449065db: selftests: mptcp: join: check RM_ADDR not sent over same
subflow
- Results: 4a4900c134dd..652750a9d6a6 (export-net)
- Results: 5e61492ae392..d3854ef490c9 (export)

Tests are now in progress:

- export-net:
https://github.com/multipath-tcp/mptcp_net-next/commit/f7b905d300ce1fb82367bb2e069fa067c4ae0d49/checks
- export:
https://github.com/multipath-tcp/mptcp_net-next/commit/07e1c275611e95ade08509cf5eeb2c39f181d116/checks

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

