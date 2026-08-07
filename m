Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FC6EEB3
	for <mptcp@lists.linux.dev>; Fri,  7 Aug 2026 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119004; cv=none; b=LfiO0pkKg0nb3ayOGllNw1509uQ0A4sAZnYo/+4TKofm5q+tc0ZW1PlZkFHJyS4SmoNN44M24zBCtkD01EWVKHF9v/15UMCCihK64SOqBm0qC8jxv58XSpUErk9WrGiG+GtvPQgQQTYOR1FZZszDRpu4avKwqJA82JyXFl8xP4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119004; c=relaxed/simple;
	bh=gsaSOHo3SGefqsy4hDslpLglCx5SAB23qyw0r9GJw5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HRdNJQNML0SgpJcp5mBi+7Zq3f5K6cUvuELnTLLzUhI44NYVHDp6HDHBwuQJOGIJDRzZ+VqehssE6piWv1AzC4PQhHZ0JGKWGO3Unvi06ktRgrTRxN4ERc6hNSNpI9HKkSBFjLDb6Fsakz5GTeRyUQcul7Nz/63K7QZE6BPL9q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U9VJDDtM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9VJDDtM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BFD1F000E9;
	Fri,  7 Aug 2026 16:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786119003;
	bh=XkQF/dym1AspfXKdlLBeYze48CiBLWBPn+jVL224n1E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=U9VJDDtM6DAbzehNwnEPXEZWKbVUuJKhW0/JArXMO2lHzcu8RTAGiAIqxGYKlBW0T
	 ZtNX3kv9OSgIiwdLyxcaJcyh4ssR/WEkQ7JUHsPUjDmGfYusBcbuyF/TQkyzCSZ/7a
	 pTkiJDu0qoQaUTMxq+6SlIQloS+V4ceGJuD0jc+sry6VfsRNoRQNeZweIMOqdfez9J
	 kAX7Df6szb5KmTiJvztqB9zm3wyByiqxfZuwiW9zy6vfOY1hXEB7Jt15WGSH8VvDAM
	 Cpbov9g6C40f1Y+tEpz06Pqa/0LzUilHRr+0JYFb8/WXMcSJDf/BPPM3HzKzjyaEpB
	 oN4AumBJ9brzQ==
Message-ID: <3240b6e2-e5d5-4356-8a8e-9374086c98ec@kernel.org>
Date: Fri, 7 Aug 2026 18:10:00 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 1/3] mptcp: sched: penalise a slow subflow by
 halving its cwnd
Content-Language: fr
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: MPTCP Linux <mptcp@lists.linux.dev>, janak@mpiric.us
References: <20260726-mptcp_penalise_send-v1-0-84485e0e995b@mpiricsoftware.com>
 <20260726-mptcp_penalise_send-v1-1-84485e0e995b@mpiricsoftware.com>
 <085c3192-1adc-4016-ab27-a0c053a2f2c1@kernel.org>
 <087874be7587606209365cb9e9791a9f0e11b934.camel@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <087874be7587606209365cb9e9791a9f0e11b934.camel@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Shardul,

Thank you for your reply!

On 07/08/2026 17:18, Shardul Bankar wrote:
> On Wed, 2026-07-29 at 13:49 +0200, Matthieu Baerts wrote:
>> On 26/07/2026 07:55, Shardul Bankar wrote:

(...)

>>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>>> index da40c6f3705f..2bf801292563 100644
>>> --- a/net/mptcp/protocol.h
>>> +++ b/net/mptcp/protocol.h
>>> @@ -587,6 +587,7 @@ struct mptcp_subflow_context {
>>>                 __unused : 8;
>>>         bool    data_avail;
>>>         bool    scheduled;
>>> +       bool    penalise;           /* scheduler flagged this
>>> subflow for cwnd halving */
>>
>> (If you don't need to read this locklessly, then you can probably use
>> one unused bit.)
>>
> 
> It is written under two locks (set in the scheduler under the msk lock,
> cleared in the push path under the subflow lock), so a shared bitfield
> word would race on the read-modify-write, and I kept it a bool for that
> reason. If you see a single-lock way to do it, I am glad to move it to
> a bit.

I didn't check all entries from the bitfield a few lines above, but are
they not also written under the subflow lock? (but maybe not under the
msk lock)

But if you saw a risk, fine to keep it like that.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

