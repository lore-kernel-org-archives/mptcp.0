Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAD2C138
	for <mptcp@lists.linux.dev>; Mon,  4 Sep 2023 15:48:46 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-31ad779e6b3so1377093f8f.2
        for <mptcp@lists.linux.dev>; Mon, 04 Sep 2023 08:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1693842524; x=1694447324; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pX/4PpzmwuQBq/A6+sUwLhEfaFXZM7wbuwa2YKUWz9c=;
        b=F3nxVdjQdG6Al+L0x39Z6JLjhhSVfW1gLHjAE0IRyhKudyO3v5jgoeA6TfVS7i07fD
         2mjlbkHJt0datrZBHo40NidXymTHwzjMrbtqtbaJxMLLVGXJqLunKqdtxQf1MVJ5V9U6
         67qNQvjCYbPgVtwk9yALX2e53uxTVJJ7dpAZUxdaEEUxwnn8l+i329hhihqbnmeVCD3O
         NUKhRvzV8gSzG+rUCvESyJj6cc6iHMdbT/cgd0R7uC5CXYjh7LyPGXd3oFHcRh/PMXRE
         jBDr1xaXQHjmRGphp6hPq/DGr3JmpL/UjdIaH5fhKgSd+Aicw56QvVkk8ezhms8PHX/z
         Q0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693842524; x=1694447324;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pX/4PpzmwuQBq/A6+sUwLhEfaFXZM7wbuwa2YKUWz9c=;
        b=guYpjxv9lPkt4vY48oWyClZ8jcHZtbFoXnaxU6DBg4QgL0Al17j7wTDS9g40vHfzl3
         UrAF0jk/PGTnAKbK0ZmS8RcV11hJzIEZV2JIWXC1e7Yyr95hyP6Rn9EHhs2V3RW8NOh9
         HzAzVYRnlfN6qP9VqyPdaeq9LglMVrjYp3c/eeUmkEa+meAlSKs+RJRKymc+drZzhmRk
         mPeKpznnNBs/f5iyTG/MvrCHh/gjlyJFD5FsWVhYgPbc3TfwjH6nY7LzjaL9GYb58HW8
         zEVQRrmrXPdGCB5ycnimxFbFLBQ4dP2h4WFvXuvVt987kuW2c+JUqjwkdEgcxq0jiMgO
         Dqiw==
X-Gm-Message-State: AOJu0YxCYK9J6GHTYcImLkqROyiHP/XvFZ6vrjgKI8SfoYAy/KUbxYrM
	xjKJd7DqcU9h9aboENev3NIZQe7zz0J3XBRL2sY=
X-Google-Smtp-Source: AGHT+IEheDr6JG2zbsRUEEpUrhXjmz8xqQOkb1OCUISKGerFrUJjeBjwTY2mxZ5HCQ0kDroyZDYKTQ==
X-Received: by 2002:a5d:5242:0:b0:31a:e728:8682 with SMTP id k2-20020a5d5242000000b0031ae7288682mr8676432wrc.68.1693842524450;
        Mon, 04 Sep 2023 08:48:44 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id i14-20020adfdece000000b003142e438e8csm14750879wrn.26.2023.09.04.08.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 08:48:44 -0700 (PDT)
Message-ID: <e0ab04b3-6d74-4871-a36a-0c2654f94178@tessares.net>
Date: Mon, 4 Sep 2023 17:48:43 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next] mptcp: add a new sysctl for make after break
 timeout
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
References: <85f43bff28d6d080642a968c12f68f87ee4baf5c.1693835482.git.pabeni@redhat.com>
 <4a3f0eaa-f915-49dc-8948-a581a6e78542@tessares.net>
 <a696b90406710bbc3a0e6f58ade4468b97726a3e.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <a696b90406710bbc3a0e6f58ade4468b97726a3e.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

Thank you for your reply!

On 04/09/2023 17:04, Paolo Abeni wrote:
> On Mon, 2023-09-04 at 16:35 +0200, Matthieu Baerts wrote:
>>> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
>>> index c46c22a84d23..b22d41729076 100644
>>> --- a/net/mptcp/ctrl.c
>>> +++ b/net/mptcp/ctrl.c
>>> @@ -27,6 +27,7 @@ struct mptcp_pernet {
>>>  #endif
>>>  
>>>  	unsigned int add_addr_timeout;
>>> +	unsigned int close_timeout;
>>
>> Sometimes, it is good to add a suffix indicating the unit being used but
>> I guess here in jiffies, we don't need that because the time is usually
>> in jiffies, right?
> 
> I guess so. Also there is an hopefully self-documenting
> proc_dointvec_jiffies() below.

I'm fine with that. At the end, it's the same behaviour as the one above
('add_addr_timeout').

(I was thinking about all the "_us" (srtt_us, etc.) variables, mostly in
TCP but that's different: here it is maybe less common than jiffies and
probably needed when doing the conversion from ms to µs)

> 
> [...]
> 
>>> @@ -140,6 +149,12 @@ static struct ctl_table mptcp_sysctl_table[] = {
>>>  		.maxlen	= MPTCP_SCHED_NAME_MAX,
>>>  		.mode = 0644,
>>>  		.proc_handler = proc_dostring,
>>> +	},
>>> +		{
>>
>> (nit) it looks like the indentation is not OK?
> 
> c&p error. I'll fix that in v2.
> 
>>> +		.procname = "close_timeout",
>>
>> Do you mind documenting this new entry in
>> Documentation/networking/mptcp-sysctl.rst please?
> 
> I will in v2.
> 
>> Also, here as well I guess we don't need to add a suffix "_s" or "_sec"
>> for the unit because usually it is in seconds, right?
> 
> AFAICS almost all timeouts under net have no such suffix, I guess that
> is fine?!?

Yes indeed, no need to change.

> 
>>> +		.maxlen = sizeof(unsigned int),
>>
>> Just an idea: would it make sense to accept -1 as special case for "no
>> timeout"? (maybe not, we can always put a huge value? also I'm not sure
>> we can use proc_dointvec_jiffies() with -1 and I wonder if they handle
>> UINT_MAX with the conversion but that's a detail)
> 
> I'm unsure if that above is needed. A 0 timeout will fire (almost)
> immediately, should be a reasonable enough approximation.

Sorry, I wanted to suggest such special case: "never close the MPTCP
connection if there is no more subflows" (value of "-1", not "0"). But
that's maybe not needed if we can give a huge number?

>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 80d06cab8bc7..8022f00190ad 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -2501,7 +2501,7 @@ static bool mptcp_close_tout_expired(const struct sock *sk)
>>>  		return false;
>>>  
>>>  	return time_after32(tcp_jiffies32,
>>> -		  inet_csk(sk)->icsk_mtup.probe_timestamp + TCP_TIMEWAIT_LEN);
>>> +	    inet_csk(sk)->icsk_mtup.probe_timestamp + mptcp_close_timeout(sk));
>>
>> (nit: the indentation looks strange but maybe what you wanted?)
> 
> Just trying to fit 80 chars, probably it's better to align to the above
> '('

Maybe yes if you don't mind :)

>>> @@ -2643,7 +2643,8 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
>>>  	if (!fail_tout && !inet_csk(sk)->icsk_mtup.probe_timestamp)
>>>  		return;
>>>  
>>> -	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies + TCP_TIMEWAIT_LEN;
>>> +	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies +
>>> +			mptcp_close_timeout(sk);
>>
>> Do we need to do something special if mptcp_close_timeout(sk) returns 0,
>> AKA close the MPTCP connection immediately?
> 
> AFAIK, not needed. mod_timer() will be fine to schedule it ASAP.

OK, easier to maintain then! :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
