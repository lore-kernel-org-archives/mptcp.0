Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F4237B012
	for <mptcp@lists.linux.dev>; Sat,  8 Aug 2026 16:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786206876; cv=none; b=UDIdtrjLYHXWAYWFUL2MnZqlVngaeQv20J5+IoHIwokvXEWRScFDmu9/92TbrAoZxBUiNhvyjk/gpywOd2YFNEKkC2Ufqn0KVqM8z/gOq723fwcc7XFzQGiZ9etgVesZ4u8K6o9ZoGP0o9LipPtgdx2dY4rf1emZvxwqeGOmKic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786206876; c=relaxed/simple;
	bh=fVrFaoUoePib5L4VkjWiN83i3hDSnqzO0CwGCxLCd2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=kgUHk4II4l3cRIW3y7G1kM8KF4tByI/q8ykM4lcVACVdjRwEJzvhD5MSpVueUBbG+xfiyOy5iLzkNzsNt15Ny3mEb2gCb1k/3v8P7c0Kerkebgzasq0MKYPKsn214e43M86IRRsuHaIH7Pv5GDcqCdOuQ020eDc3WG9uAiqiqlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTjXf0KK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTjXf0KK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A31F71F000E9;
	Sat,  8 Aug 2026 16:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786206875;
	bh=hYERsV9DCWUq1qOZt9roawi/Wcleo+KboqWC/PaE+Yw=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=PTjXf0KKAewxhClM7P9SHnPkEe9MOk/m+F2t3JFLmYa+m6VesyfAIqVM1PpIrSPKU
	 6hl1/Sd4Exs+bpQiOKjRHQTQfKe6iLUKGyq16FULpwh9Kcar1T3IMkM01RUevW+OUp
	 Mdo3rFbrzmhiNjKlF9breZIxDY3hzfrHNi+l3j0UxBqT0NLlfFyKVxyZ/1iikMMpzD
	 /26pKLrnzIGME/6kOQ7jxZinkPQ9Mer4UFmvCCvMEGaEmRcAHGH04hsvUrQKsMJlYA
	 75xxXHO2Phgn+y5dRLEZjC71+ANFbalBfrOJlQ3azthbgmyIB2iwU0JsXB/x2DcaEY
	 szktoShvjiuNg==
Message-ID: <eb437699-4e3a-422d-93fa-3efde2985189@kernel.org>
Date: Sat, 8 Aug 2026 18:34:32 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 mptcp-next 7/7] mptcp: implemented OoO queue pruning
Content-Language: fr
To: Geliang Tang <geliang@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <cover.1786026372.git.pabeni@redhat.com>
 <be9dcbef291a424fdd54d19fc72f9f28fb239b81.1786026372.git.pabeni@redhat.com>
 <80572775-6e76-4c79-83e2-efdedbd3f3b8@redhat.com>
 <b0d961b3-7a06-4237-92b2-67d8ab2ff28b@kernel.org>
 <a8cf012f365d1885f773d5959829cb42298477bb.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
Cc: mptcp@lists.linux.dev
In-Reply-To: <a8cf012f365d1885f773d5959829cb42298477bb.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang, Paolo,

On 08/08/2026 04:31, Geliang Tang wrote:
> On Thu, 2026-08-06 at 18:46 +0200, Matthieu Baerts wrote:
>> On 06/08/2026 18:42, Paolo Abeni wrote:
>>> On 8/6/26 4:45 PM, Paolo Abeni wrote:
>>>> When moving incoming skbs in the msk receive queue and the latter
>>>> is above limits, prune it as needed quite alike what TCP is doing
>>>> at the subflow level. The main difference relies in the stop
>>>> condition:
>>>> since MPTCP does not perform collapsing, it's better off dropping
>>>> the
>>>> bare minimum to fit the (newer) incoming packet.

(...)

>>>> +/* The stack can't drop packets for fallback socket at the msk
>>>> level, or the
>>>> + * stream will break.
>>>> + */
>>>> +static bool mptcp_can_ingest(const struct sock *sk)
>>>> +{
>>>> +	return unlikely(sk_rmem_alloc_get(sk) <= READ_ONCE(sk-
>>>>> sk_rcvbuf)) ||
>>>> +			__mptcp_check_fallback(mptcp_sk(sk));
>>> The above should obviously be: 'likely(...)'
>>>
>>> @Matttbe: please LMK if you prefer a repost or you could adjust
>>> that
>>> while applying to the export branch.
>> No problem, I can adjust them when applying them (if there are no
>> other
>> big modifications required, but I guess no).
> 
> It seems you forgot to update this on the export branch.

Arf, indeed I did, my bad... good catch!

I just fixed it in our tree (and the alignment of the next line), but I
will wait for Paolo's feedback to know if he judges that a new version
is needed for upstream, or if that can be done in follow-up patches.

Maybe only the comments on the last patch actually requires
modifications? (but maybe can be done in a follow-up patch?)

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260807-net-next-mptcp-oooq-pruning-v3-0-dbc1eb853cc3%40kernel.org

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

