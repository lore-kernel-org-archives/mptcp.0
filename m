Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6453B37AA63
	for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705142; cv=none; b=DpVnEm+ohkgmlfA/8hCNCjzNIjUMqFBlehADF8WFYorXkBCYdIImlLIkYbQJyaEkVlgX+v1GjpMvgA2v0eOyiSM9BiUvFtXHaINd+2X/1Yofn9D/AksQL8wR4TO8iKUaDXdpbP+qCAhL+W2a9y0UaosG8ZA6F24wf0zYfiNhzHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705142; c=relaxed/simple;
	bh=xRng/d98VtuT3zVSS6RhZ+eSFHOMYyMTGZga4XXclUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ozow+dJcyoR8ZWJkUn+aCpbDB2GRPlnIlmDitH/rd8BRp0rUF3O4rWFUhcYTU01p3vJMV3giugWHUz7g+NdjjstQmOpPM333T3lbpVDiPY9qrKPDleAgrta90ISwKViKp+LuwZanLPpMcrnPKk0HWQAh7i6XNarCGpH6KXuEoGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVF5UJvc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVF5UJvc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513A6C19425;
	Mon, 20 Apr 2026 17:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776705142;
	bh=xRng/d98VtuT3zVSS6RhZ+eSFHOMYyMTGZga4XXclUQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qVF5UJvcbrBNvPXWUfaE65PSc/G0kqeOQMm/JTDG0EQrpwLXIcHuXiEu0+7CrD+wH
	 qi7offtQdMFecWwpHj4GGFba/xQfMVfMTUrOu2g9BCuidfevhxzkQvI6WnbBVd54k8
	 lqyTKHfdmYdcOZ6ine3CXi4nsvNVanFb4cnD93NaDcM1X5DVNJsffo89+oMjQkNOHE
	 8/tMkw5CSsKtCr6Cp7MO/hPIgvu71Pq8MCznYfrd39bVbtEihHsLmRHzAbZSatzd1i
	 1Hz+kFnLS4PCFEcKJAU7M9Figo82GjC3xrfBedMHW2OT7B2f6XswBC3H/+aR1IoaPl
	 O5jlhqFUM5Csg==
Message-ID: <0b920b72-2da1-490b-b2fa-69518bf911b8@kernel.org>
Date: Mon, 20 Apr 2026 19:12:18 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v5 05/20] mptcp: pm: ADD_ADDR rtx: free sk if
 last
Content-Language: fr
To: Mat Martineau <martineau@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org>
 <20260415-mptcp-inc-limits-v5-5-e54c3bf80e4e@kernel.org>
 <679eb0b7-304f-43b7-0f6b-5a9d6b7d382f@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <679eb0b7-304f-43b7-0f6b-5a9d6b7d382f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

Thank you very much for this review!

On 18/04/2026 20:00, Mat Martineau wrote:
> On Wed, 15 Apr 2026, Matthieu Baerts (NGI0) wrote:
> 
>> When an ADD_ADDR is retransmitted, the sk is held in sk_reset_timer(),
>> and released at the end.
>>
>> If at that moment, it was the last reference being held, the sk would
>> not be freed. sock_put() should then be called instead of __sock_put().
>>
>> But that's not enough: if it is the last reference, sock_put() will call
>> sk_free(), which will end up calling sk_stop_timer_sync() on the same
>> timer, and waiting indefinitely to finish. So it is needed to mark that
>> the timer is done at the end of the timer handler when it has not been
>> rescheduled, not to call sk_stop_timer_sync() on "itself".

(...)

>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>> index d3fcf441b208..0ff35f49d451 100644
>> --- a/net/mptcp/pm.c
>> +++ b/net/mptcp/pm.c

(...)

>> @@ -369,9 +371,13 @@ static void mptcp_pm_add_timer(struct timer_list
>> *timer)
>>         mptcp_pm_subflow_established(msk);
>>
>> out:
>> +    if (timeout)
>> +        sk_reset_timer(sk, timer, jiffies + timeout);
>> +    else
>> +        /* if sock_put calls sk_free: avoid waiting for this timer */
>> +        entry->timer_done = true;
>>     bh_unlock_sock(sk);
>> -exit:
> 
> This label was just added in the previous patch (which was quite small).
> I suggest squashing these two patches, but not a big problem to leave
> them separate.

I understand, but if that's OK, I would prefer to keep them separated:
even if they are linked, the problems are different. The previous patch
makes sure the refcount is decremented in all cases, while this one
actually free the socket if it was the last one.

In fact, I was looking at squashing them, but I didn't know what commit
message to add. Having "while at it, always decrement the refcount"
feels like hiding this important issue. But maybe not. Up to you for the
squashing.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

