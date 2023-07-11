Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6EC18C36
	for <mptcp@lists.linux.dev>; Tue, 11 Jul 2023 13:55:17 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-99313a34b2dso667680566b.1
        for <mptcp@lists.linux.dev>; Tue, 11 Jul 2023 06:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689083715; x=1691675715;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pR802lHuS9W5mviHsvqGE7SRiwh+F5BBZ7c5IpFncM0=;
        b=VlJ9ljN73EPl/y8kR9IC1b5QTU3bZW5lGawco6gI9SSgC3R+Po+K3yK+RaUsPsmfLu
         cZ4HPzJ3ArLqjxaOZV0a+LQLQmlc9p6OtsaEEAQEdBFQD/5Z9ujldyBQJxOQrt/qPlO6
         Xd/5anaELLlT5U+uSPtVPTOlPY+sN4Gsj/eZoEvlI9r9EsYSnqWYtx7yI/U+CKwW+Q7l
         Zz8/9Hl0e1OON//G5XqSlR07P3r5SZuyXELzsG0hBMue8xj+Sw8Pdg0vivvc5LzDJE2W
         05u8CDQWvS945OXo3aI7Us5A/649RKCvXxreccVSvGm+E6NF7m5oOYOb0s+kPcNqqXXf
         BhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689083715; x=1691675715;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pR802lHuS9W5mviHsvqGE7SRiwh+F5BBZ7c5IpFncM0=;
        b=ICER3xs3shx4Hdxd0S2uV3IoI4sfZVI2dY9hUh4Lq6HL02D0xFqB/PlE4VbDC16N79
         CwYQjCkV+yVvJlz+/mTCcZPM2plomYV6LRnimAuz3pgFo3A+EUAG1EmlaJNsaT57OXnD
         wMu4LgPv88LSRi0ZqqIhnP5WubykQv/UkV+tK9EcxkRzA1L3TnRqFxG+SIlmBm5NkHMD
         CZIZFuF3f+poFtClq0yoq2wZbeyNQ7m/5OoqM06MAQPhM+olZtM0TMTV1lw0kAr0wosj
         DsX+Olo8APBRV2ujPShGFQTIu9ZCd5UeoCflDpKQcGf6WmlxzYOFcRo0FQKQFtndmCa4
         we1A==
X-Gm-Message-State: ABy/qLaZ7XYcJsCXgF8ZA02juQ5JRVy7ZvkXuB5mRbpqqHYO6zP4UqG9
	gmivvlMcFusKNHMxXY1qDo2ZS9cXitIteuHh1ynFUA==
X-Google-Smtp-Source: APBJJlFVJuELCSicfNOERbUC64EQVcN1ZBqZY3DBSa9EY5Sm2d4rmX1cIRC0GJvuZOwj0+7ng6i/6A==
X-Received: by 2002:a17:906:c0cf:b0:98e:f13:e908 with SMTP id bn15-20020a170906c0cf00b0098e0f13e908mr336091ejb.60.1689083715424;
        Tue, 11 Jul 2023 06:55:15 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:311:9dd3:e9de:8b52? ([2a02:578:8593:1200:311:9dd3:e9de:8b52])
        by smtp.gmail.com with ESMTPSA id f26-20020a1709062c5a00b0098242730348sm1219204ejh.72.2023.07.11.06.55.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 06:55:15 -0700 (PDT)
Message-ID: <e8ffd6b7-533e-cc19-9bcc-02f035c73e9a@tessares.net>
Date: Tue, 11 Jul 2023 15:55:14 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next 0/6] mptcp: sockopt: uniform code to get/set
 values
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20230707-mptcp-unify-sockopt-issue-353-v1-0-693e15c06646@tessares.net>
 <9de27c12da208e32efc43e2b36840d941cd1575f.camel@redhat.com>
 <bc861997-4f71-c254-6e49-f92ba86dce67@tessares.net>
 <ec5fbde82d1da490192bf44682a562ee7cfa5400.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <ec5fbde82d1da490192bf44682a562ee7cfa5400.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/07/2023 14:50, Paolo Abeni wrote:
> On Tue, 2023-07-11 at 12:22 +0200, Matthieu Baerts wrote:
>> On 10/07/2023 18:51, Paolo Abeni wrote:
>>> On Fri, 2023-07-07 at 18:00 +0200, Matthieu Baerts wrote:
>>>> Here is the implementation of an idea I suggested a few months ago: it
>>>> is a factoring of the sockopt code trying to uniform it, mainly to rely
>>>> on {ip,ipv6,tcp}_[gs]etsockopt() instead of copying what is done there
>>>> to get and set values.
>>>>
>>>> That's a first step. More might come if we are OK with the approach,
>>>> e.g.
>>>>
>>>> - For SOL_TCP socket options we cannot store info in the MPTCP socket so
>>>>   we still need to "manually" store it somewhere in the msk. Maybe we
>>>>   could store info in the different subflows (and create a first one if
>>>>   there is no subflow) and retrieve info from there?
>>>>
>>>> - For SOL_SOCKET socket options, it looks like it should be feasible to
>>>>   do something similar to what I did here but I'm probably missing
>>>>   something. This could clean quite a lot of code, e.g. the last commit
>>>>   from:
>>>>
>>>>     https://github.com/matttbe/mptcp_net-next/commits/b4/mptcp-unify-sockopt-issue-353
>>>>
>>>> - To sync the socket options when a new subflow has been created, for
>>>>   the moment, we copy info from the msk to the subflow but maybe it
>>>>    would be fine to call some getsockopt() / setsockopt() to do the
>>>>   sync? If we take this approach, we might want to save a list of
>>>>   setsockopt() that have been done in the past on this socket and only
>>>>   re-do these ones? That should help with the maintenance of these
>>>>   socket options and ease the support of new ones.
>>>
>>> I would highly discourage this latest approach.
>>
>> Before going further, I want to insist on the fact that it is just an
>> idea, I didn't look at the implementation (and to be honest, I was not
>> looking at doing that now :) )
>>
>>> We will have to limit
>>> the list length, breaking the sync at some point.
>>
>> Why would we have to limit the list length and break the sync?
>>
>> I understand having a list might not feel good but I'm not sure what
>> else we can have.
> 
> Because otherwise syzkaller (or evil unprivileged user-space program)
> can easily exhaust the kernel memory doing a lot of setsockopt: we need
> to allocate the list entry, and we can't never flush the list.

I see, thank you. We could then add items (with just "level" and
"optname") in the list only if the initial setsockopt() operation was a
success and if there was no previous entry with the same info.

But I see the risk.

>>> And there are few
>>> quite gray area, e.g. how errors should be handled?
>>
>> Same as what we have now I guess: errors are ignored :)
>> But I don't see what else we can and it doesn't feel worst than before
>> (regarding how we handle errors during the sync)
> 
> Note the with the current schema sync can fail only while setting the
> CA, and even that requires a quite non trivial setup. If we start
> replying arbitrary complex sockopt sequence, I fear the we can hit
> failures much more frequently.

Maybe. We can also start with an "allow list".

>>> I also fear the
>>> "final" state of the subflow could be different from the
>>> expected/correct one for non trivial socktopt.
>>
>> I would expect it to be better because we would follow the "normal" flow
>> to set values. What bother me is the fact we bypass checks and directly
>> set values. 
> 
> Actually we don't! Such checks are performed once for the sockopt on
> the main/initial subflow (or by the mptcp impl).
> 
> IMHO it's safer then the list alternative. For passive socket the
> latter will do the full sockopt checking using a different initial sock
> internal state: the sockopt will be applied after cloning and the
> related initialization.
> 
> For plain TCP sockopt value are inherited from the parent via the clone
> itself, which is quite near to what the current sync implementation is
> doing.

Yes but that's only good for passive sockets. It would be nice if we
could clone all the attributes of the first subflow when new ones are
created :)

It might be safer now but if we don't follow the code we duplicated from
the other layers (i.e. what is exactly done with a TCP socket when a
setsockopt() is done), it might be less safe later than changing the
different values using the sockopt API.

>> If the code change on the different IP/TCP/SOCKET socket
>> options side, we might (very likely) miss the fact we also need to
>> update what we are doing on the MPTCP side, e.g. if new checks or extra
>> actions (BPF/Netfilter hooks) are added later, etc. So the idea of this
>> approach is to ease the maintenance (but maybe that's not needed and/or
>> not worth it) :)
> 
> The eBPF maintainer mentioned that new hooks are discouraged, IIRC ;)

Until someone comes with the new extended eBPF technology :-P

No but what is done by the kernel when a "setsockopt()" is emitted could
be modified, e.g. if the value is no longer a bit but an enum or if a
security check needs to be done before, etc. (Or maybe I'm thinking
about unrealistic/very unlikely/forbidden modifications)?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
