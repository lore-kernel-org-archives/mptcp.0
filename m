Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B82415C14F
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 00:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779843589; cv=none; b=X93Dw0+U4KcNSRFq0KamujfkH9v5JxgRDt52K6LMcVZzuW1oTlW3zsn6PJG0WPAl6Ip5ycvamu0VW31Alb2u7muaYPbf5qCmyLt4s1RAypEa+ezFiRiwKNT1Cu6S4q2dpY9U5OmXYAKPeS66jfGHeZ43kIbP2J2grQ6nT3ctaik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779843589; c=relaxed/simple;
	bh=qkLzQXN4luJLUnyBjqNfXSiRa1VXuLmX4B6Qve0azPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTi2N848l7ZABx06U75ZvGp7mEeNHFPcc6H9EvEz5XHDCyuzvGXJWFmMXEQlAjnq91qX6vyXwLC2ycIrYBQNh/7/ouSNTZweG/BN3hISKlMt/kgyutFFtIleQToAU4/JO17ugwASN2D+Aa295qX+2RwAxRtgT5rkFzJVz/YLBmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kr5CFOu0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kr5CFOu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8186D1F000E9;
	Wed, 27 May 2026 00:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779843588;
	bh=k0LWpQXG3BKTJgYAJyuqgLaGYD6/oMecJAFUQdoQets=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kr5CFOu0+0o663ogb4gJyPJ7sfA0PfDnKyVcUrigzgy1xNeCb2UprLTxwC7YvXuMy
	 mGtHiHa88ra3jWpb0/z226d4T/Hg/YdTU58GEuRDqKw1aNtlen5EMwwPZ0Kgh36eGl
	 HDPp3hmXOqPZa9H/EtwJSp76LxrXZKNktyP18M1ZEYMlhFHkrj7gDM0IzRfIFaOglY
	 85SiQTVxpvcSJJTNJ83sKJ7oZk+TtpJtNGzZ43f+IPnsEqqhKai/v5gIhG0V4dQWgH
	 tabddLsYthZVYcz66YBk1TORK5tic0GTwsYCqYBZR075Llel43RUoJD1u+rKCCmSl5
	 Yskcrjr/2OJig==
Message-ID: <6dd054c7-63c6-4d50-8f03-52684a0d9e67@kernel.org>
Date: Wed, 27 May 2026 10:59:42 +1000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net] mptcp: pm: don't WARN on re-announced addr in kernel
 PM
Content-Language: fr
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp <mptcp@lists.linux.dev>, martineau <martineau@kernel.org>,
 pabeni <pabeni@redhat.com>, janak <janak@mpiric.us>,
 "shardul.b" <shardul.b@mpiricsoftware.com>,
 kalpanjani009 <kalpanjani009@gmail.com>, shardulsb08 <shardulsb08@gmail.com>
References: <20260525121911.2410171-1-kalpan.jani@mpiricsoftware.com>
 <07bf06c0-20dd-4e31-960a-b79f6fffcecc@kernel.org>
 <19e63fedc1e.19d76b97534353.4482082124048801251@mpiricsoftware.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <19e63fedc1e.19d76b97534353.4482082124048801251@mpiricsoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kalpan,

On 26/05/2026 21:15, Kalpan Jani wrote:
> Hi Matt,
> 
> Thank you for the review.
> 
> On 26/05/2026 ..:.., Matthieu Baerts wrote:
>>> The WARN assumes the kernel PM can never reselect an address that is
>>> still in msk->pm.anno_list. That is not true: [...]
>>
>> From what I understand, it means that if a "signal" MPTCP endpoint is
>> removed the echo got received, the in-kernel PM will continue
>> retransmitting the ADD_ADDR. That doesn't seem correct. I didn't check
>> in the code, but I thought that the retransmit timer was at least
>> stopped, but maybe the entry was not removed from the list?
> 
> You are right to expect the teardown. I checked the code, and it is not
> uniform across the two removal paths:
> 
> - For a non-zero id endpoint, mptcp_nl_remove_subflow_and_signal_addr()
>   -> mptcp_pm_remove_anno_addr() -> mptcp_remove_anno_list_by_saddr()
>   -> mptcp_pm_del_add_timer(.., false): the timer is stopped and the
>   anno_list entry is unlinked and freed. This path is fine.
> 
> - For the id 0 endpoint, mptcp_nl_remove_id_zero_address() does NOT
>   call that teardown. It only queues a RM_ADDR and marks the id as
>   available again; the pending anno_list entry and its armed timer are
>   left alive.
> 
> So a stale entry can only survive on the id 0 removal path. When that
> endpoint is re-added, the kernel PM reselects id 0, reaches
> mptcp_pm_alloc_anno_list() a second time, finds the stale entry and
> hits the WARN. That is the actual bug here.

I guess there were some confusions at some points that the ID 0 wouldn't
be sent as an ADD_ADDR. But that can be the case when the linked address
is removed, then re-added. Then, I guess to have the bug, you need to
create a connection, with an extra subflow, then remove and re-add the
endpoint linked to the initial subflow, and repeat this once more to hit
the bug, no?

>> Does it also mean that if an ADD_ADDR echo is never received, the entry
>> is never removed, even after having reached the max retransmissions?
> 
> Yes. In mptcp_pm_add_timer(), once retrans_times reaches
> ADD_ADDR_RETRANS_MAX the timer stops re-arming (timeout = 0), but the
> anno_list entry itself is not freed there; it stays on the list until
> the endpoint is removed.

Only for the ID0, when re-added then.

>>> This is a benign transient state, so drop the WARN. [...]
>>
>> If I understand correctly, the transient state is not benign, and the
>> WARN should not be dropped.
> 
> Agreed. I will drop this patch. The WARN is a valid assertion; the fix
> should keep it and instead make the id 0 removal path tear down the
> pending ADD_ADDR, mirroring the non-zero id path (drop the anno_list
> entry, stop its timer, and decrement add_addr_signaled if it had been
> announced). I will send that as v2.

Thanks!

>> Also, it would be nice to add a new test to validate that. Here, it
>> might be easier with a packetdrill test [1] [...]
> 
> Will do. I will add a packetdrill test that sends an ADD_ADDR, withholds
> the echo, and then removes and re-adds the endpoint, based on
> add_addr4_server.pkt.
See above: you might need an extra subflow (see the tests in mp_join),
and re-add the endpoint twice, because once is enough to trigger the
fact the entry is not removed, but not enough to hit the WARN if I
understood correctly.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

