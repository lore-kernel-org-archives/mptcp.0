Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA70388392
	for <mptcp@lists.linux.dev>; Mon, 20 Apr 2026 21:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776719225; cv=none; b=VrkKIMG55ZAgws28Pd9CglRK+k2OxnAyZjvNYzEfVNtmXGNM+rOGFU0ZYZs/h4Q3DIeAuykjKHDeArc0aoZyBIOoTMJ8bjI8RTjkT6JZES03uOoGBKrzWusb72Np+rk5VwpiIJzFPa9pVduTVIYuJ0XYxYzbpQCjbdiYr4nORyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776719225; c=relaxed/simple;
	bh=gr5dkCmesRXB7nzAo4Pf5NMms5O0MzI4iZGperasuuY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=X8BAyoKqkJDxYFzALnDqa1G1/7Pwp84n9wPBW5TA+fL/Y+o8UUma9nxTMmjLYcQZaZNPUVr9Ztzp8DZdcBe0liwnc+G/tlpYjqnM0TW5UPYeV8lEsA4EB1ZAzyuWWgley7DkoISU/O5KvVcWXXoAH9r9tKBLo2MfnwA43HEbl9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rC+zJz+w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rC+zJz+w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B4DC19425;
	Mon, 20 Apr 2026 21:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776719224;
	bh=gr5dkCmesRXB7nzAo4Pf5NMms5O0MzI4iZGperasuuY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=rC+zJz+w5W522OLv4LWuwE3LhoHAevaP0eFssTeZ3JvGf+7TX6kuG/kRk4niCu+PQ
	 2lV3Y48M1LblXRRPh+7Tx7rxdEic4cg0v0NOw+3PMSOw7MUh1Ts/YDetX9BwBcCDpE
	 5vAVMtY3q2PeFH3N1o+VONVblcrde+wP+Iu4sejp2Ao6W0oT4luE4fklwK6HRa2JLO
	 xtgCANap1o23/C7wmCo8AeqqouI5OPeWngbf3B+aPZeI8vtuDMq0ZIn/NfAlEbBeQB
	 +lbJyTU2Ym69NHCrdj7psZtzzlArIt7PLJTqfxr1Rq7Q+QZC04EYpb2pjq4/rXJEpb
	 2gIiNYUa4abDg==
Date: Mon, 20 Apr 2026 14:07:04 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
cc: MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net v5 05/20] mptcp: pm: ADD_ADDR rtx: free sk if
 last
In-Reply-To: <0b920b72-2da1-490b-b2fa-69518bf911b8@kernel.org>
Message-ID: <31a54865-f4bd-630c-dddb-98df44aad162@kernel.org>
References: <20260415-mptcp-inc-limits-v5-0-e54c3bf80e4e@kernel.org> <20260415-mptcp-inc-limits-v5-5-e54c3bf80e4e@kernel.org> <679eb0b7-304f-43b7-0f6b-5a9d6b7d382f@kernel.org> <0b920b72-2da1-490b-b2fa-69518bf911b8@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2007030456-1776719224=:14764"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-2007030456-1776719224=:14764
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 20 Apr 2026, Matthieu Baerts wrote:

> Hi Mat,
>
> Thank you very much for this review!
>
> On 18/04/2026 20:00, Mat Martineau wrote:
>> On Wed, 15 Apr 2026, Matthieu Baerts (NGI0) wrote:
>>
>>> When an ADD_ADDR is retransmitted, the sk is held in sk_reset_timer(),
>>> and released at the end.
>>>
>>> If at that moment, it was the last reference being held, the sk would
>>> not be freed. sock_put() should then be called instead of __sock_put().
>>>
>>> But that's not enough: if it is the last reference, sock_put() will call
>>> sk_free(), which will end up calling sk_stop_timer_sync() on the same
>>> timer, and waiting indefinitely to finish. So it is needed to mark that
>>> the timer is done at the end of the timer handler when it has not been
>>> rescheduled, not to call sk_stop_timer_sync() on "itself".
>
> (...)
>
>>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>>> index d3fcf441b208..0ff35f49d451 100644
>>> --- a/net/mptcp/pm.c
>>> +++ b/net/mptcp/pm.c
>
> (...)
>
>>> @@ -369,9 +371,13 @@ static void mptcp_pm_add_timer(struct timer_list
>>> *timer)
>>>         mptcp_pm_subflow_established(msk);
>>>
>>> out:
>>> +    if (timeout)
>>> +        sk_reset_timer(sk, timer, jiffies + timeout);
>>> +    else
>>> +        /* if sock_put calls sk_free: avoid waiting for this timer */
>>> +        entry->timer_done = true;
>>>     bh_unlock_sock(sk);
>>> -exit:
>>
>> This label was just added in the previous patch (which was quite small).
>> I suggest squashing these two patches, but not a big problem to leave
>> them separate.
>
> I understand, but if that's OK, I would prefer to keep them separated:
> even if they are linked, the problems are different. The previous patch
> makes sure the refcount is decremented in all cases, while this one
> actually free the socket if it was the last one.
>
> In fact, I was looking at squashing them, but I didn't know what commit
> message to add. Having "while at it, always decrement the refcount"
> feels like hiding this important issue. But maybe not. Up to you for the
> squashing.
>

It's fine to leave them separate, thanks for explaining.

- Mat
--0-2007030456-1776719224=:14764--
