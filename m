Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083E57475
	for <mptcp@lists.linux.dev>; Fri, 17 Mar 2023 17:59:06 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id x3so23468949edb.10
        for <mptcp@lists.linux.dev>; Fri, 17 Mar 2023 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1679075945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CURlZjlwXFBYnr22NG5seE+9tLCX5eL5DZHpPYvttPk=;
        b=qmd/CN745cn4LhYQ0lO3SPLXta/uEBfAThJzBEAkvsTEC/C34wzUXzWWUv+9dsm/zr
         q9x2rvwcf3i5UNSPeN2y9fLIj5gYH7vFYZS1W/6/srnbeli5xE2qKoykOOyKPTp8RdeP
         CPgHX03iN8JwjbB6jQOrm3urlHiwOZe/LviSJQu/pRN0iS49rgxTM+crr0pVRn3JX3Zk
         /ktK8GX4O0GjpF0YIRNDg5dUNBFCZHwz74AXHEDh04gO+aHAhaWaM+1Yu3fHMqORkMD3
         Q4bJBdy4CRe1CkthMTtX08AsZQKATwFJck0WVYNpxRsw4AowMfBGKcEYEc7NdZ+vrfqd
         l6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679075945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CURlZjlwXFBYnr22NG5seE+9tLCX5eL5DZHpPYvttPk=;
        b=EsN2VohD3vNv1WuCzY/1CDQ0EBBtKI+TvIegOFPGYL8Tcvx2HQJdY4ILGnp75gizHP
         1HA2LLr3jL4BSB6a5rdfkWdtoV38DV0PbVi541gNGxbE3IxYbiJ+GGkF8IYiF2qsEsvv
         Xh83GHhjYgLrX38plNNLW58hXR1BROsAu/wTGLhYsxDmfwpdF80D3ZxOI+Hc8ijMWFJ0
         A6yDKVu7f6DQQYGvpWN3NIC34Gkjap0Qw07i0RTNf36d7k5J3plgCBPel3dYwDIZwPYo
         twRAjaBVlr1Ii653VFjPHTTIgKAXkckWmvvOp9k56aUfh46SDMj0RBFb7VLXlYEfJeEq
         R1sQ==
X-Gm-Message-State: AO0yUKUv08mTmWiONUejufcjAJg7xqkxx1QDAQ56Fdl/noHBN6QvmHbZ
	iN7fRzzVpn38nBnp+p663hkTbA==
X-Google-Smtp-Source: AK7set9OAo5PzMdo/PUAVySCz6yI6OKUJS97VHyaHKf5oJmmwavA29dc1XCBRfhMw1OvbJT5TF2n5Q==
X-Received: by 2002:a05:6402:2143:b0:4fd:29a1:6a58 with SMTP id bq3-20020a056402214300b004fd29a16a58mr4077018edb.19.1679075944990;
        Fri, 17 Mar 2023 10:59:04 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id q30-20020a50aa9e000000b004fadc041e13sm1382394edc.42.2023.03.17.10.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 10:59:04 -0700 (PDT)
Message-ID: <618e9ca8-29fd-abf2-9f0b-eca253b6d2f4@tessares.net>
Date: Fri, 17 Mar 2023 18:59:04 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH net-next 09/10] mptcp: preserve const qualifier in
 mptcp_sk()
Content-Language: en-GB
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 David Ahern <dsahern@kernel.org>, Simon Horman <simon.horman@corigine.com>,
 Willem de Bruijn <willemb@google.com>, eric.dumazet@gmail.com,
 MPTCP Upstream <mptcp@lists.linux.dev>
References: <20230317155539.2552954-1-edumazet@google.com>
 <20230317155539.2552954-10-edumazet@google.com>
 <b9b3e7a2-788b-13ca-91a6-3017c8afbbf4@tessares.net>
 <CANn89i+xOmDmD2=1EQF0U5F5+GQb_HfAWmQD=1FP+6L=qK-E5w@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <CANn89i+xOmDmD2=1EQF0U5F5+GQb_HfAWmQD=1FP+6L=qK-E5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Eric,

Thank you for your quick reply!

On 17/03/2023 18:47, Eric Dumazet wrote:
> On Fri, Mar 17, 2023 at 10:32 AM Matthieu Baerts
> <matthieu.baerts@tessares.net> wrote:
>> On 17/03/2023 16:55, Eric Dumazet wrote:
>>
>> (...)
>>
>>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>>> index 61fd8eabfca2028680e04558b4baca9f48bbaaaa..4ed8ffffb1ca473179217e640a23bc268742628d 100644
>>> --- a/net/mptcp/protocol.h
>>> +++ b/net/mptcp/protocol.h
>>
>> (...)
>>
>>> @@ -381,7 +378,7 @@ static inline struct mptcp_data_frag *mptcp_pending_tail(const struct sock *sk)
>>>       return list_last_entry(&msk->rtx_queue, struct mptcp_data_frag, list);
>>>  }
>>>
>>> -static inline struct mptcp_data_frag *mptcp_rtx_head(const struct sock *sk)
>>> +static inline struct mptcp_data_frag *mptcp_rtx_head(struct sock *sk)
>>
>> It was not clear to me why you had to remove the "const" qualifier here
>> and not just have to add one when assigning the msk just below. But then
>> I looked at what was behind the list_first_entry_or_null() macro used in
>> this function and understood what was the issue.
>>
>>
>> My naive approach would be to modify this macro but I guess we don't
>> want to go down that road, right?
>>
>> -------------------- 8< --------------------
>> diff --git a/include/linux/list.h b/include/linux/list.h
>> index f10344dbad4d..cd770766f451 100644
>> --- a/include/linux/list.h
>> +++ b/include/linux/list.h
>> @@ -550,7 +550,7 @@ static inline void list_splice_tail_init(struct
>> list_head *list,
>>   * Note that if the list is empty, it returns NULL.
>>   */
>>  #define list_first_entry_or_null(ptr, type, member) ({ \
>> -       struct list_head *head__ = (ptr); \
>> +       const struct list_head *head__ = (ptr); \
>>         struct list_head *pos__ = READ_ONCE(head__->next); \
>>         pos__ != head__ ? list_entry(pos__, type, member) : NULL; \
>>  })
>> -------------------- 8< --------------------
> 
> This could work, but it is a bit awkward.
> 
> mptcp_rtx_head() is used  in a context where we are changing the
> socket, not during a readonly lookup ?

Indeed, you are right. It is currently only used in a context where we
are changing the socket.

I can see cases where a new packets scheduler might just need to check
if the rtx queue is empty but then we should probably add a new helper
using list_empty() instead.

So yes, no need to change anything!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
