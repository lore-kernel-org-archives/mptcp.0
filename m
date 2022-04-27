Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26078A50
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 16:53:33 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id gh6so4697709ejb.0
        for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 09:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nvP/K9J70s5xg3f5nfpfd2+bmBXiYqfjcp3efCigFN8=;
        b=MxmySpuLXRRpec7vuvdjqFZtagQCnAqCxTX8BxI98dRvfbubbn/thdd7TEc63C86tc
         Fv2+7v5Ky6+YI/73l1B0zGv8kqk0sFyWwgcf2bzkmrHogy/yagNgQx2CgiGrnt7ySUEi
         F5sKPtHkMtI1cH59zJK/QiCXaiEPvVtetHB4vn+qmk8DZ8ERFbCTu3eOrTmg5Ey23orZ
         YxrI7NIcFbOyH+NxLqn3hEoMmD+ftxLGEzm6iZ1LwPQkwEDBcs7AmZa5q6gwVuQZLdn7
         sq/2Y5OU6ugYWUqenj5kQIcfNG8uZXIixdC6xVRDTBn1hEKjNfFbgYlPyRWolveSj25f
         7dqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nvP/K9J70s5xg3f5nfpfd2+bmBXiYqfjcp3efCigFN8=;
        b=HbW9jLA5d54d/j7OGwg14ss/3sVr/rYQ8KA16nYO1RAH06Ar/KW0kP7bT1ZLoGOaCI
         Pz4u/0TIy7N8wjG1EKsyLiL19BqWzqKWo55jRqOerEJXmvHRjUrrW3HN9Oby93EaJJaq
         TbEulQ5WgD80ZY53o3QQdd3eLlZ1wpXRe0oAr742z3/keuCzUXzAblIHh9OU4NvC0Fr2
         lH3bL+eOjB3NkANkZzQ5oXWP59KGomzp68AQJVJxCF9qH4/WOcL9U6B2r1eQaQ25lHKQ
         Mx3EXHhCaW0AsTYBC7UpLMJthu91iAXZQNiHEZe9+lsrAp/6Ci8j2uDO1Pnioa9mH64O
         5aUA==
X-Gm-Message-State: AOAM533GxjQsIYJ1jo4cvmrK7xiQ/W5XHwsVdCA/9v35O6O138YpuNQ/
	9wbBqvyDo6O5JXWwjBgmu0kRVt9uz9TVfjt0crM=
X-Google-Smtp-Source: ABdhPJxmN2qWyYLfLp+Ck2rn//sbz67vgdC3CFjSJb62gxCxuoyf4FknVe0gyvbuPPOPYKeAaoTXOA==
X-Received: by 2002:a17:906:974e:b0:6bb:4f90:a6ae with SMTP id o14-20020a170906974e00b006bb4f90a6aemr28307533ejy.452.1651078411226;
        Wed, 27 Apr 2022 09:53:31 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:3b64:994c:90d3:9913? ([2a02:578:8593:1200:3b64:994c:90d3:9913])
        by smtp.gmail.com with ESMTPSA id s6-20020a170906960600b006f3bef377easm2097953ejx.83.2022.04.27.09.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 09:53:30 -0700 (PDT)
Message-ID: <f49973cf-ac7e-bbf8-11b5-79092c5255aa@tessares.net>
Date: Wed, 27 Apr 2022 18:53:29 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH mptcp-next v16 5/8] mptcp: add get_subflow wrapper
Content-Language: en-GB
To: Geliang Tang <geliangtang@gmail.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <geliang.tang@suse.com>,
 MPTCP Upstream <mptcp@lists.linux.dev>
References: <cover.1651024344.git.geliang.tang@suse.com>
 <f69a828ffffa6b0a57d8913a273d84a9150cc860.1651024344.git.geliang.tang@suse.com>
 <d0234513a342a1c3e833c73663feac656d935cfc.camel@redhat.com>
 <CA+WQbwt-gm1yqNVqvX4pFfTyj7kmJV5sts+PGHQ4YQn=4WQcgg@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CA+WQbwt-gm1yqNVqvX4pFfTyj7kmJV5sts+PGHQ4YQn=4WQcgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang, Paolo,

On 27/04/2022 16:34, Geliang Tang wrote:
> Hi Paolo,
> 
> Thanks for your review!
> 
> Paolo Abeni <pabeni@redhat.com> 于2022年4月27日周三 16:27写道：
>>
>> Hello,
>>
>> First of all I'm sorry for the very late feedback: I had some
>> difficulties to allocate time to follow this development.
>>
>> On Wed, 2022-04-27 at 09:56 +0800, Geliang Tang wrote:
>>> This patch defines a new wrapper mptcp_sched_get_subflow(), invoke
>>> get_subflow() of msk->sched in it. Use the wrapper instead of using
>>> mptcp_subflow_get_send() directly.
>>>
>>> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
>>> ---
>>>  net/mptcp/protocol.c |  9 ++++-----
>>>  net/mptcp/protocol.h | 16 ++++++++++++++++
>>>  2 files changed, 20 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 7590e2d29f39..c6e963848b18 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -1515,7 +1515,6 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>>>       subflow->avg_pacing_rate = div_u64((u64)subflow->avg_pacing_rate * wmem +
>>>                                          READ_ONCE(ssk->sk_pacing_rate) * burst,
>>>                                          burst + wmem);
>>> -     msk->last_snd = ssk;
>>>       msk->snd_burst = burst;
>>>       return ssk;
>>>  }
>>
>> This breaks "mptcp: really share subflow snd_wnd": When the MPTCP-level
>> cwin is 0, we want to do 0-window probe (so mptcp_subflow_get_send()
>> return a 'valid' subflow) but we don't want to start a new burst for
>> such 0 win probe (so mptcp_subflow_get_send() clears last_snd).
>>
>> With this change, when MPTCP-level cwin is 0, 'last_send' is not
>> cleared anymore.
>>
>> A simple sulution would be:
>>
>> ---
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 653757ea0aca..c20f5fd04cad 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -1507,7 +1507,7 @@ static struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
>>         burst = min_t(int, MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
>>         wmem = READ_ONCE(ssk->sk_wmem_queued);
>>         if (!burst) {
>> -               msk->last_snd = NULL;
>> +               msk->snd_burst = 0;
>>                 return ssk;
>>         }
>> ---
> 
> I think it's better to add back "msk->last_snd = ssk;" in
> mptcp_subflow_get_send(), keep the original mptcp_subflow_get_send()
> unchanged. And set msk->last_snd in the get_subflow() of the
> scheduler, the same as v12:
> 
> https://patchwork.kernel.org/project/mptcp/patch/396f8edcbf8e4f65a1d76c228dc3d12aa4dd2f11.1650430389.git.geliang.tang@suse.com/

It might be interesting to discuss about the scheduler API at the
meeting tomorrow (sadly I will not be there).

Maybe it is interesting to separate the work in two steps like it is
done in mptcp.org: select data, then select subflow.

If the scheduler needs to know if it is is selecting a subflow for a
zero window test or not: we are getting closer to the mptcp.org API :)

(or maybe just enough to reset msk->snd_burst instead of asking all
schedulers to set 'last_snd' + give access to that for BPF)

Cheers,
Matt

> 
>>
>> Probably a better solution would be adding 'snd_burst' to struct
>> mptcp_sched_data, and let mptcp_sched_get_subflow() update msk-
>>> snd_burst as specified by the scheduler. With this latter change the
>> 'msk' argument in mptcp_sched_ops->schedule() could be const.
>>
>>> @@ -1575,7 +1574,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
>>>                       int ret = 0;
>>>
>>>                       prev_ssk = ssk;
>>> -                     ssk = mptcp_subflow_get_send(msk);
>>> +                     ssk = mptcp_sched_get_subflow(msk, false);
>>>
>>>                       /* First check. If the ssk has changed since
>>>                        * the last round, release prev_ssk
>>> @@ -1644,7 +1643,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
>>>                        * check for a different subflow usage only after
>>>                        * spooling the first chunk of data
>>>                        */
>>> -                     xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
>>> +                     xmit_ssk = first ? ssk : mptcp_sched_get_subflow(mptcp_sk(sk), false);
>>>                       if (!xmit_ssk)
>>>                               goto out;
>>>                       if (xmit_ssk != ssk) {
>>> @@ -2489,7 +2488,7 @@ static void __mptcp_retrans(struct sock *sk)
>>>       mptcp_clean_una_wakeup(sk);
>>>
>>>       /* first check ssk: need to kick "stale" logic */
>>> -     ssk = mptcp_subflow_get_retrans(msk);
>>> +     ssk = mptcp_sched_get_subflow(msk, true);
>>>       dfrag = mptcp_rtx_head(sk);
>>>       if (!dfrag) {
>>>               if (mptcp_data_fin_enabled(msk)) {
>>> @@ -3154,7 +3153,7 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
>>>               return;
>>>
>>>       if (!sock_owned_by_user(sk)) {
>>> -             struct sock *xmit_ssk = mptcp_subflow_get_send(mptcp_sk(sk));
>>> +             struct sock *xmit_ssk = mptcp_sched_get_subflow(mptcp_sk(sk), false);
>>>
>>>               if (xmit_ssk == ssk)
>>>                       __mptcp_subflow_push_pending(sk, ssk);
>>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>>> index 22f3f41e1e32..91512fc25128 100644
>>> --- a/net/mptcp/protocol.h
>>> +++ b/net/mptcp/protocol.h
>>> @@ -633,6 +633,22 @@ int mptcp_init_sched(struct mptcp_sock *msk,
>>>                    struct mptcp_sched_ops *sched);
>>>  void mptcp_release_sched(struct mptcp_sock *msk);
>>>
>>> +static inline struct sock *mptcp_sched_get_subflow(struct mptcp_sock *msk, bool reinject)
>>> +{
>>> +     struct mptcp_sched_data data = {
>>> +             .sock           = msk->first,
>>> +             .call_again     = 0,
>>> +     };
>>
>> It's not clear to me:
>> - why we need the 'sock' argument, since the scheduler already get
>> 'msk' as argument?
> 
> sock is the selected subflow to return in the scheduer.
> 
>> - why we need to initialize it (looks like an 'output' argument ?!?)
> 
> Yes, it's an output argument. No need to init it.
> 
>> - what is the goal/role of the 'call_again' argument. It looks like we
>> just ignore it?!?
> 
> call_again is for supporting a "redundant" packet scheduler in the
> future indicate that get_subflow() function needs to be called again.
> 
>>
>> Side note: perhaps we should move the following chunk:
>>
>> ---
>>        sock_owned_by_me(sk);
>>
>>         if (__mptcp_check_fallback(msk)) {
>>                 if (!msk->first)
>>                         return NULL;
>>                 return sk_stream_memory_free(msk->first) ? msk->first : NULL;
>>         }
>> ---
>>
>>   out of mptcp_subflow_get_send() into mptcp_sched_get_subflow(), so
>> that every scheduler will not have to deal with fallback sockets.
>>
>>> +
>>> +     msk->sched ? INDIRECT_CALL_INET_1(msk->sched->get_subflow,
>>> +                                       mptcp_get_subflow_default,
>>> +                                       msk, reinject, &data) :
>>> +                  mptcp_get_subflow_default(msk, reinject, &data);
>>
>> With this we have quite a lot of conditionals for the default
>> scheduler. I think we can drop the INDIRECT_CALL_INET_1() wrapper, and
>> rework the code so that msk->sched is always NULL with the default
>> scheduler.
> 
> So I need to drop patch 2 (2/8 mptcp: register default scheduler) in
> this series, right?
> 
>>
>> And sorry to bring the next topic so late, but why a 'reinject'
>> argument instead of an additional mptcp_sched_ops op? the latter option
>> will avoid another branch in fast-path.
> 
> How about keeping th 'reinject' argument like this:
> 
> ----
> static inline struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
> {
>         struct mptcp_sched_data data;
> 
>         sock_owned_by_me((struct sock *)msk);
> 
>         /* the following check is moved out of mptcp_subflow_get_send */
>         if (__mptcp_check_fallback(msk)) {
>                 if (!msk->first)
>                         return NULL;
>                 return sk_stream_memory_free(msk->first) ? msk->first : NULL;
>         }
> 
>         if (!msk->sched)
>                 return mptcp_subflow_get_send(msk);
> 
>         msk->sched->get_subflow(msk, false, &data);
> 
>         return data.sock;
> }
> 
> static inline struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
> {
>         struct mptcp_sched_data data;
> 
>         sock_owned_by_me((const struct sock *)msk);
> 
>         if (__mptcp_check_fallback(msk))
>                 return NULL;
> 
>         if (!msk->sched)
>                 return mptcp_subflow_get_retrans(msk);
> 
>         msk->sched->get_subflow(msk, true, &data);
> 
>         return data.sock;
> }
> -----
> 
> Thanks,
> -Geliang
> 
>>
>> Thanks!
>>
>> Paolo
>>
>>
> 

-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
