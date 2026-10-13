Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DB53BBFC9
	for <mptcp@lists.linux.dev>; Tue, 13 Oct 2026 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882102; cv=none; b=WlMBm8tcPu8oxrQv2J8v/RQ7G3Wekm1vdW3+eBY4PqJQfok4ZAjKtgy0RgQgpc5j7yqOCWDyS0JK5vMmvfyPgrCuqflQpS2ZMmo9YqB6IG4GevZxtz1bFZJSzANrby0Zaw/e5kEnbP13qqxqwJO9IWYAACmWJ7uYIb/z0mu+Oe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882102; c=relaxed/simple;
	bh=ZXOKzo1V9DmP1+XK9esIWzWwFpDvHcvcMK1fr30OY2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=mx8Gq1fb+cQ3gvW0WSkA4+giKIkV/ScpNAjzSTkK4U09hVdAolhB3rddW3P9ZY8IZiSEp5sOJWlGnYhh0DsLdqatTBEYUYIugvGk1Kq+sXAX/M9F9XJWNPeXETOGCK1+zbuDGmhQ6ZA4IjjK9FaCjrUTf0SPIMirZ8epbF0CEcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1UX+5zu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1UX+5zu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79691F000FF;
	Tue, 13 Oct 2026 09:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791882101;
	bh=+ImHXOEkgTk2km2TUydmpBsfnqhwMqLVX/w7XmO/hdw=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=U1UX+5zuGeJYXlPNM8/fUA7MJzzzbD6peOMOyEZRqT2bueVqopVZbFWqQZQUA5lC+
	 xmiXtWjsxAMV+4+UJcxTslWaBHHPhE6J6ZTq3a12t8vwHX6HHXGExRIoFv76XnqKrV
	 5ks7BN5E7K76itziblnXCa22BUZoD035gE0bhZUL5hAhD+8J+qk9+FnBnZvPwUOjWx
	 0GjofMLzktML+jl0ZIcSA2ZP1dAPPFR/5sc+RNQY9ZLSBSDpZSE5tkMXr6fhdr6C7L
	 nNQxyRytXbIsZGvLSZOXt1eTMWLD/yE2ELplbvHjGu6ySHuQBSMHF7EKeLMbvpFTRd
	 o3mcY5dHGGX1Q==
Message-ID: <f6c396a4-13bd-4b6c-adc2-be2d8929e14e@kernel.org>
Date: Tue, 13 Oct 2026 11:01:38 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net] mptcp: reset MP_JOIN subflows on missing or
 invalid DSS options
Content-Language: fr
To: T S RAMESHKUMAR <rameshsv06@gmail.com>
References: <CADRhS2vwE7QCAPgGmt96gCQ7bwHBWJJXG-d0at13ZAO+Z5kHJg@mail.gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <CADRhS2vwE7QCAPgGmt96gCQ7bwHBWJJXG-d0at13ZAO+Z5kHJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi T S,

On 13/10/2026 10:18, T S RAMESHKUMAR wrote:
> Hi Matt,

Please reply in plain text, without HTML. And actually reply to a
message, don't start a new thread when you want to send a reply
otherwise it is not visible when looking at patches:


https://patchwork.kernel.org/project/mptcp/patch/20261012112625.578911-1-rameshkumar.t@phytecembedded.in/

> 1.)  Do you have a reproducer for this?
> 
> No, this was spotted during code review of subflow_check_data_avail()
> rather than from a reproducer in tests or production.

OK. Please mention that in the commit message next time. Or better,
check if this can really happen with a reproducer.

>> Here you are changing the condition "did we already fallback". Is it
>> because a fallback already happened but yet you have a second subflow?
>> That's not consistent, and the root cause is elsewhere.
>> Maybe it is linked to:
>> https://lore.kernel.org/20260814-mptcp-reset-mpj-early-
> v1-0-3ca3260f9474@kernel.org <https://lore.kernel.org/20260814-mptcp-
> reset-mpj-early-v1-0-3ca3260f9474@kernel.org>
>> I didn't have time to work on a v2.
> 
> You are completely right. Once fallback happens on the initial subflow,
> no MP_JOIN subflow should be accepted or established in the first place,
> so patching it under the fallback label in subflow_check_data_avail()
> is indeed only treating a symptom rather than the root cause.

OK, let's drop the patch then.

> I looked at your RFC series (20260814-mptcp-reset-mpj-early-
> v1-0-3ca3260f9474@kernel.org <mailto:20260814-mptcp-reset-mpj-early-
> v1-0-3ca3260f9474@kernel.org>)
> and Paolo's feedback on rejecting MP_JOIN earlier in subflow_check_req().
> If you don't mind, I would be very happy to take over and work on v2
> of that series to address Paolo's comments and get it completed.

Thank you, but I will take the time at some points to send a v2, no
urgency there.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

