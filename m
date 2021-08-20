Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1E43FC1
	for <mptcp@lists.linux.dev>; Fri, 20 Aug 2021 08:02:52 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id z20so18439399ejf.5
        for <mptcp@lists.linux.dev>; Fri, 20 Aug 2021 01:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7S76ur/iGWesNvpZ2LdG1GIUoki3pfEFM9mgwkM1/fs=;
        b=gQa3+okokK644U7qHfRUBTkYNr+DSEOuUc29uNR3NZ0uMtHRGIxsBDrfk6H+9blx/a
         aRvxshKs8YEDuIOqBmgfWx9A4ZlQvD3k7KD174fTY+vcM4Djpbn4wOBTwN9Z+kHnhBAa
         gxzoV2H6qyQTzg+bjVSmPek7aUCuPyj5vnLp/5PBisbo+CAjK2KPJsLRcfMNtbNHWq8Q
         0gmg/I88sykzpEIdT6L3zG4k9DbdK41QO1pBcD3LPzTEFXKs7IPyGonFISxmQKvLxcvx
         /xMzXRRT/RVRhNjdLaq2dCTozdBlDBSeMmZu9yUfuGFqrku1C9RADGW3aTGi0CNgaJQk
         3/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7S76ur/iGWesNvpZ2LdG1GIUoki3pfEFM9mgwkM1/fs=;
        b=ozZS4/tX85pW/oywxEjOLR41BmV+C6NiIwE+xfoyyxuSijOwniLKJcZcNOl3I9gYMg
         qlBzR3EN3KiIHkgdiVLxjIbMZRNUNwjlczi8Br9WL+H+Bv09Kyw6rNCj25iRK02RKK70
         qpu9QPlNp3tTjkD+KdmFegXKGd8sbW9YTH3raWEWtAZcLHZduuU3x9lzIH/1PUj+q+tD
         QhQrbISU+bmkV8x3Zx4e7m72eswfoVuM1sMN6e8UyD1IWlCEAgzmKegmjpX+oqE+BmJ7
         VT9neG02ccF+fI/2/A1q/f5o4HGeiFMBquZ0s5EHWxE1AJpcoy/P0WV1DkD0nXuaQdAq
         JbOg==
X-Gm-Message-State: AOAM532itOLbGwADcnoYyvCesvRTvfaT/2pogdqvvqCDx3dqQ40AFGjz
	2NZPoyiOS2eLm7mKT2EOSaSGYopPlvkFSIgA
X-Google-Smtp-Source: ABdhPJz/QiCB1TZJgaGM+tR2jcxPnH58Pzn6x8lP4xsZ1tU9EbP6M3+8IOzq/Oj7dR8lOKfBv/3KOg==
X-Received: by 2002:a17:906:3486:: with SMTP id g6mr20426270ejb.71.1629446570719;
        Fri, 20 Aug 2021 01:02:50 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([213.211.142.31])
        by smtp.gmail.com with ESMTPSA id r6sm3107446edq.20.2021.08.20.01.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 01:02:50 -0700 (PDT)
Subject: Re: [PATCH v2 mptcp-next 4/4] mptcp: optimize the input options
 processing.
To: Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <cover.1629386016.git.pabeni@redhat.com>
 <1eb5eb91a3cdb5d0f03e20120b1c5c109d690fc8.1629386016.git.pabeni@redhat.com>
 <65cee750-5e3-aeb0-fd2-8342357b4ba7@linux.intel.com>
 <5875cffd7ed62665e7ed5770087f7094e690e828.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <34844b44-b898-b4cf-195a-d73fef222909@tessares.net>
Date: Fri, 20 Aug 2021 10:02:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <5875cffd7ed62665e7ed5770087f7094e690e828.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 20/08/2021 09:58, Paolo Abeni wrote:
> On Thu, 2021-08-19 at 17:24 -0700, Mat Martineau wrote:
>> On Thu, 19 Aug 2021, Paolo Abeni wrote:
>>
>>> Most MPTCP packets carries a single MPTCP subption: the
>>> DSS containing the mapping for the current packet.
>>>
>>> Check explicitly for the above, so that is such scenario we
>>> replace most conditional statements with a single likely() one.
>>>
>>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>>> ---
>>> net/mptcp/options.c | 70 +++++++++++++++++++++++----------------------
>>> 1 file changed, 36 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>> index 0d33c020062f..af22d76f1699 100644
>>> --- a/net/mptcp/options.c
>>> +++ b/net/mptcp/options.c
>>> @@ -1111,48 +1111,50 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>>> 	if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
>>> 		return sk->sk_state != TCP_CLOSE;
>>>
>>> -	if ((mp_opt.suboptions & OPTION_MPTCP_FASTCLOSE) &&
>>> -	    msk->local_key == mp_opt.rcvr_key) {
>>> -		WRITE_ONCE(msk->rcv_fastclose, true);
>>> -		mptcp_schedule_work((struct sock *)msk);
>>> -	}
>>> +	if (unlikely(mp_opt.suboptions != OPTION_MPTCP_DSS)) {
>>
>> This diff is a lot shorter when ignoring whitespace :)
>>
>> One question - is it worth optimizing for the mp_opt.suboptions = 0 case 
>> too? While our stack will send duplicate DSS mappings when the mapped data 
>> is split across multiple TCP packets, other stacks might send each mapping 
>> only once (hopefully not, since that will affect GRO/etc).
> 
> I *think* even mptcp.org is sending DSS on every packets, to help
> GRO/GSO.

Yes it does. (or at least, that's what is expected :) )

> Generally speaking, with intermittent DSS, we kill both TSO and GRO.

Hopefully, NIC vendors could recognise MPTCP options and aggregate
packets if they are in-order from MPTCP point of view as well.

> It does not looks like a fast path. I guess we could add that check with
> time, if we see it being useful.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
