Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F679241E0
	for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 12:55:40 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-31aec0a1a8bso637308f8f.0
        for <mptcp@lists.linux.dev>; Thu, 14 Sep 2023 05:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1694696139; x=1695300939; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OANwCdaaNo6x2bjqHfTcEZIMESgOE2EVQ0fvXiRKxkM=;
        b=Vp+UNudXSKGiLDhjjEB+2xjhr0XG/K9RRMpBdSWKibFOXLN1QAdP/CUGD8I7XhsaCF
         UsNbUuv6hMUAIzDZLGLj15rsZP0oP4r52ARSPfUMmocFjuiWlY9QTK0Kn2NB+Rgwm+yJ
         6q1Na6lxgVU71Z8P+scyuna4qc+5zFgdWBF19va/dePZBynrFj3ZhJsn3IoClzjibKX4
         QvMbGl1RTfMbTXYw6gjiRh7CIIr9yG9PesAXODAsOOQMFdpxaCVUyfiesE+wjTNfe81m
         TEfSPIM/5RCYAL6iBLeoRbvLJrQdn9SBAQPVhl7iSuFaT1IEQ6fj7WhLbtxr0BTnOjDO
         c2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694696139; x=1695300939;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OANwCdaaNo6x2bjqHfTcEZIMESgOE2EVQ0fvXiRKxkM=;
        b=kLecgpDlWLFbPOeFef+uzbwsuFWH9+6CbhXJLFiT0NGrU3tLR5QvLTpk+OH/koFQX3
         N4TMrTAd+hyKWw2J7XxeKXSJLzmvMdE1vq8936N/D82101qUPEPuNLylS3OLdTp0Wgm1
         mQh/c9MlrLXZOLK46vIIj7Jrq3C0MQYycAQZLLUzT96Mt4CPnUhc0GabxTBRDxMT9yJv
         scMk9rN7f39Z2TA0YPXBf8Q3v/5Csclcy5oNpsy4rs7e4EmobuktOkzo6q82r9J2gNBP
         3rxV9pf5+dOCemt0cTdVArpTEUGkHKph6G9o6oIEM/6ubicazUdxY0rAaHM1uEEx8DcL
         ZgMA==
X-Gm-Message-State: AOJu0YxETGG3jgyEDvMV6dDC3puzNfbm/jTVMOGhXHBQioD/Jpi64X+4
	xuYGuvb15FYtH2OV6b0p0KeW9p/1DzkK9aOkqJr0xw==
X-Google-Smtp-Source: AGHT+IFbYrcX3z8lYE3uwqnGiCa09sWpC1nylHl1cQ5jmJvLKsx7/CyqM9koxDPIJTjG2N94wIOz5g==
X-Received: by 2002:adf:8b92:0:b0:31f:e02b:18ae with SMTP id o18-20020adf8b92000000b0031fe02b18aemr1251731wra.24.1694696138873;
        Thu, 14 Sep 2023 05:55:38 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:e0c0:cbdd:bd42:c2e6? ([2a02:578:8593:1200:e0c0:cbdd:bd42:c2e6])
        by smtp.gmail.com with ESMTPSA id z4-20020a5d4c84000000b003197c7d08ddsm1711854wrs.71.2023.09.14.05.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 05:55:38 -0700 (PDT)
Message-ID: <c6aab443-34db-497c-a834-c4963fbe2705@tessares.net>
Date: Thu, 14 Sep 2023 14:55:37 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v8 1/8] mptcp: add NO_INITIAL_SUBFLOW flag
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <cover.1694685050.git.geliang.tang@suse.com>
 <a98118c4c5347fcc1c53909c6677d84485cb0651.1694685050.git.geliang.tang@suse.com>
 <93643f82-21ff-4a54-9c1b-3d5be689793c@tessares.net>
 <20230914124301.GA3508@bogon>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Autocrypt: addr=matthieu.baerts@tessares.net; keydata=
 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
In-Reply-To: <20230914124301.GA3508@bogon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 14/09/2023 14:43, Geliang Tang wrote:
> Hi Matt,
> 
> On Thu, Sep 14, 2023 at 12:19:01PM +0200, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 14/09/2023 12:03, Geliang Tang wrote:
>>> If the initial subflow has been removed, we cannot know without checking
>>> other counters, e.g. ss -ti <filter> | grep -c tcp-ulp-mptcp or
>>> getsockopt(SOL_MPTCP, MPTCP_FULL_INFO, ...) (or others except MPTCP_INFO
>>> of course) and then check mptcp_subflow_data->num_subflows to get the
>>> total amount of subflows.
>>>
>>> This patch adds a new flag NO_INITIAL_SUBFLOW in mptcpi_flags to know if
>>> the initial subflow has been removed. With this bit, we can then compute
>>> the total amount of subflows from mptcp_info by doing something like:
>>>
>>>   if (mptcpi_flags & MPTCP_INFO_FLAG_HAS_INITIAL_SUBFLOW)
>>> 	  mptcpi_subflows += 1;
>>
>> Thank you for looking at that!
>>
>> (...)
>>
>>> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
>>> index 8260202c0066..aebf692543a5 100644
>>> --- a/net/mptcp/sockopt.c
>>> +++ b/net/mptcp/sockopt.c
>>> @@ -919,6 +919,8 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
>>>  		flags |= MPTCP_INFO_FLAG_FALLBACK;
>>>  	if (READ_ONCE(msk->can_ack))
>>>  		flags |= MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED;
>>> +	if (__mptcp_check_no_initial_subflow(msk))
>>> +		flags |= MPTCP_INFO_FLAG_NO_INITIAL_SUBFLOW;
>>
>> I had a very brief look but can we not just check if msk->first == NULL
>> instead?
> 
> msk->first is not NULL in this case.

Thank you for having looked!

> When closing the initial subflow in __mptcp_close_ssk(), dispose_it is
> false, it goes to:
> 
>         if (!dispose_it) {
>                 /* The MPTCP code never wait on the subflow sockets, TCP-level
>                  * disconnect should never fail
>                  */
>                 WARN_ON_ONCE(tcp_disconnect(ssk, 0));
>                 mptcp_subflow_ctx_reset(subflow);
>                 release_sock(ssk);
> 
>                 goto out;
>         }
> 
> ... ...
> 
>         if (ssk == msk->first)
>                 WRITE_ONCE(msk->first, NULL);
> 
> out:
>         if (need_push)
>                 __mptcp_push_pending(sk, 0);
> 
> "WRITE_ONCE(msk->first, NULL)" is skipped in this case.

I didn't check further but is it normal? Is 'msk->first' still valid at
the end of __mptcp_close_ssk() if we close the initial subflow?

If yes, can we not check something like "msk->first->sk_state"?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
