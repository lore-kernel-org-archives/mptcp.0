Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7592AB55
	for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 07:58:45 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-51a52a7d859so6289032a12.0
        for <mptcp@lists.linux.dev>; Wed, 21 Jun 2023 00:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687334323; x=1689926323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NHU5luPz4OWBWLX+fC03FSKNksZbKv4pZkZ1sSGSWOM=;
        b=e8YNVx557H6yWIsf+Oc+Lpkp7rvd2y1oJ5tPN0430+tUTrqBgvGq+WHOqST5jde7lI
         9lvfanevAxdG2PKrR2XzfQWOAZyExr+y/f0su4ljVuXINkYfsAiEk5TbUk1helpfTWKX
         K1wndNx8cHQYgmB+180bAVNIap8yyLz0nme91KLCZNAiv/+xA+CnTzrH80En1GTqFceL
         V+Du63j9hv6cfvSelgGhJVjFsoXl510DvM8csqv7b9gGEAm/Md7mbyAOq9gw4W6WqGbA
         R8fN1sKOP/9KxTo9wuFNWJXfLHa5jzYwBQoOi9QaoEPY7vcSU7a74IkJCaJcy97weVaw
         V51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687334323; x=1689926323;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NHU5luPz4OWBWLX+fC03FSKNksZbKv4pZkZ1sSGSWOM=;
        b=bJPyO1tMMIwwCdteSQ8y95XCWZT5AIC3eW1PzHHcz0aVPXQ+XS8yvw0GtE6y2TOkEw
         2oxkedXPtbqIo5IE3hhTITT5XHdnohmuXAe2fj3vwVL1HSDpx3XvIsjlnNWI6KrUI3hp
         Xi95a4ykunkoO0gjoukFi3VouWUyaQ1UQY6Fjjtjc3xnElkcJeHFWPPvS4D6iRhTOKTx
         1H7SYMoaz8g+Kr+2sSbZu8MlJVXC54BDwOeDu1rtRVBdVeu+bajqtSI/CqlIMC8Axvdu
         jFDusHN7tQWUY8TAWDnf3eIw8TMtnLboTchVilbfRhDHd+h+JgN0DL/PMylj7NuIkL6O
         +/0w==
X-Gm-Message-State: AC+VfDz7CPzLNJa5r3uPa41J10YJ6URsILC+FVhMKCGxmpO9bbYMLFQ2
	DUo3wYQIbfvyLi35Ptip0Ak0dg==
X-Google-Smtp-Source: ACHHUZ4lM8haRjq/SwY5uTQ3TKDmxedgFvjEVvX7GNije42dyNjmQJdUrvRCIHKjevwgTdODbqSy2w==
X-Received: by 2002:a17:907:ea1:b0:98b:dc6c:b2f9 with SMTP id ho33-20020a1709070ea100b0098bdc6cb2f9mr1208783ejc.6.1687334322915;
        Wed, 21 Jun 2023 00:58:42 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:ec58:3685:faff:bbc2? ([2a02:578:8593:1200:ec58:3685:faff:bbc2])
        by smtp.gmail.com with ESMTPSA id h10-20020a1709067cca00b00969f44bbef3sm2692912ejp.11.2023.06.21.00.58.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 00:58:42 -0700 (PDT)
Message-ID: <8fb02d36-bcef-1290-837d-b4391abc259e@tessares.net>
Date: Wed, 21 Jun 2023 09:58:41 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-net] mptcp: ensure listener is unhashed before
 updating the sk status
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
References: <b96e12c9dd08dca94ce2539b01d0e609d472a22a.1686754464.git.pabeni@redhat.com>
 <a99660b20eb4499bb259371f959e307cdda6d2aa.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <a99660b20eb4499bb259371f959e307cdda6d2aa.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 21/06/2023 09:23, Paolo Abeni wrote:
> On Wed, 2023-06-14 at 16:54 +0200, Paolo Abeni wrote:
>> The MPTCP protocol access the listener subflow in a lockless
>> manner in a couple of places (poll, diag). That works only if
>> the msk itself leaves the listener status only after that the
>> subflow itself has been closed/disconnected. Otherwise we risk
>> deadlock in diag, as reported by Christoph.
>>
>> Address the issue ensuring that the first subflow (the listener
>> one) is always disconnected before updating the msk socket status.

(...)

>> @@ -2952,10 +2945,24 @@ static __poll_t mptcp_check_readable(struct mptcp_sock *msk)
>>  	return EPOLLIN | EPOLLRDNORM;
>>  }
>>  
>> -static void mptcp_listen_inuse_dec(struct sock *sk)
>> +static void mptcp_check_listen_stop(struct sock *sk)
>>  {
>> -	if (inet_sk_state_load(sk) == TCP_LISTEN)
>> -		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
>> +	struct sock *ssk;
>> +
>> +	if (inet_sk_state_load(sk) != TCP_LISTEN)
>> +		return;
>> +
>> +	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
>> +	ssk = mptcp_sk(sk)->first;
>> +	if (WARN_ON_ONCE(!ssk || inet_sk_state_load(ssk) != TCP_LISTEN))
>> +		return;
>> +
>> +	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
>> +	mptcp_subflow_queue_clean(sk, ssk);
>> +	
>> +	mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
>> +	tcp_set_state(ssk, TCP_CLOSE);
> 
> Ooops, too late I saw the above is wrong, should be:
> 
> 	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
> 
> 	tcp_set_state(ssk, TCP_CLOSE);
> 	mptcp_subflow_queue_clean(sk, ssk);
> 	inet_csk_listen_stop(ssk);
> 	mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
> 	
> tcp_set_state() also unhash the TCP socket, and that action should be
> taken first.
> 
> I hope I'll be able to send a follow-up by the end of the week.

Good catch!

No hurry because it looks like syzkaller didn't complain about that (yet) :)

(that's why I applied this fix on Monday and sent it with others to
netdev yesterday evening: but I'm sure it is fine to send another fix
next week after the 6.4 release)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
