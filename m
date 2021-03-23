Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5455F
	for <mptcp@lists.linux.dev>; Tue, 23 Mar 2021 10:19:56 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id b16so22810404eds.7
        for <mptcp@lists.linux.dev>; Tue, 23 Mar 2021 03:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CTRIfkSk4J2bq98G/iENGuAM1nULflA53YUPrypmW1w=;
        b=HbmAKsjWfZgs4PfPWTSd2q4apg3TBZVLVFgLhO/llfSzgWhuRJU8oVkVPYOltqbfgj
         cYaX2itDu/rEa6aHnqMSIWLVYz0sFydG+dAs7tpg5nKz/tjSpwQuTJ0vs6Tf4bX+gFIT
         67EqXTWxUwT4p7juD+igz0P2ZvaYgmIN/h9HUVhvWKgORzfxEelh6uk9+AoKk125NinE
         MgH09E+3pB2qCckLxWjuDdNflmCF5K7FrwUVzZkVzs4stoXV2FN8VRqYb9y4+H6XHfFY
         lV2O1SwgzsfD5t8f0AlszBXdCDEZ11mComSei23lO0hRp96dXtTLNJaKpdgYQ6jNsIeM
         hNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CTRIfkSk4J2bq98G/iENGuAM1nULflA53YUPrypmW1w=;
        b=YYUrEYSF1cC1XoPgqT0AwslMq2NTHxAinmjuIOhLplQdgUx9x72xR8jsgSk7OAs883
         dYxkIQecxiCeA0lC08WeQl2rOKL7cpUYKFxUIBt3W9Hxg1+aBUEvmUDssALHmkwWfNoD
         dpiLe2E5z3x1aqwj5uouqYVxmfoeWVjvo14Ae01PcWQgZXsxWjXNYW0fXQpUsDdDsoMV
         PjaS0CLjNi0hhDYq1XiXijwLbZJeXXeVn4FG9oRfwdVXQqA+SOPoNBOeWMvdHjNtUqi+
         Vx6x/T/Tmwr5CsQ7ytYtAnaYjb4uhTxJcrSWgQzPLYpq30GvzduEhNxW8EW0oMhUEUAs
         zJ4g==
X-Gm-Message-State: AOAM531rASRdnKatP+cfCe6di4ZG4lH4K8J1QlTUcTDI0wCygEs1AG1h
	2pwPJjkNhGAJ31Mlk4SI9rlPcA==
X-Google-Smtp-Source: ABdhPJw1OpUDBFmlj6sUvKiW/9g8+PHKRvZEdMZ9MK7vNlj3jsXl6xj8QoF8O/ulojNn0ftMiZrRlw==
X-Received: by 2002:aa7:cd6a:: with SMTP id ca10mr3858604edb.7.1616494794617;
        Tue, 23 Mar 2021 03:19:54 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:5b6b:b53e:da10:3507])
        by smtp.gmail.com with ESMTPSA id ga28sm6423181ejc.82.2021.03.23.03.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Mar 2021 03:19:54 -0700 (PDT)
To: Geliang Tang <geliangtang@gmail.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev, mptcp <mptcp@lists.01.org>
References: <20210322162132.2471823-1-matthieu.baerts@tessares.net>
 <20210322162132.2471823-3-matthieu.baerts@tessares.net>
 <502b4037-3ca0-1fb9-8985-5fbc7fdb2e2@linux.intel.com>
 <CA+WQbwt0XaT5EfTi9LR8ZDroNk=74cHA5Yf7_RgKarHGtNWBUw@mail.gmail.com>
 <946858fc-f303-52a3-65c0-1f9c76316703@tessares.net>
 <CA+WQbwtBpbh8Y++JyHOK69J36tOA50z5XWo5yDQzDfLE6RHcpQ@mail.gmail.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH mptcp-next 3/3] Squash to "mptcp: drop
 MPTCP_ADDR_IPVERSION_4/6"
Message-ID: <13754e25-4860-cd1f-09ca-7d5d0778aa49@tessares.net>
Date: Tue, 23 Mar 2021 11:19:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwtBpbh8Y++JyHOK69J36tOA50z5XWo5yDQzDfLE6RHcpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

Hi Geliang, Mat,

On 23/03/2021 09:09, Geliang Tang wrote:
> Matthieu Baerts <matthieu.baerts@tessares.net> 于2021年3月23日周二 下午3:59写道：
>> On 23/03/2021 04:06, Geliang Tang wrote:
>>> Mat Martineau <mathew.j.martineau@linux.intel.com> 于2021年3月23日周二 上午5:56写道：
>>>> On Mon, 22 Mar 2021, Matthieu Baerts wrote:
>>>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>>>> index 071b446aa2c9..d9e5f864d774 100644
>>>>> --- a/net/mptcp/options.c
>>>>> +++ b/net/mptcp/options.c
>>>>> @@ -586,6 +586,7 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
>>>>> static u64 add_addr_generate_hmac(u64 key1, u64 key2,
>>>>>                                   struct mptcp_addr_info *addr)
>>>>> {
>>>>> +     u16 port = be16_to_cpu(addr->port);
>>>
>>> I prefer to use ntohs/htons instead of be16_to_cpu/cpu_to_be16 in these
>>> three patches to keep the consistency of the port number converting.
>>>
>>> WDYT?
>>
>> No you are right, I don't know why I didn't use ntohs/htons, I think I
>> was focused on the compiler issue forgetting the network env :)
>>
>> I hope you don't mind if I apply the modifications (code and commit
>> messages) directly without sending a v2. Then I would be able to unblock
>> the CI to have new versions of the export branch.
> 
> Great, please apply them directly.

These 3 patches have been applied in our tree:

- 8759990266aa: "squashed" patch 1/3 in "mptcp: use mptcp_addr_info in 
mptcp_out_options"
- 1d75960e024f: "Signed-off-by" + "Co-developed-by"
- 57de81e7976c: mptcp: switch from be16_to_cpu to ntohs
- a22ece40c7b5: tg:msg: ntohs is used in more places

- 4b727db7b8d8: "squashed" patch 2/3 in "mptcp: use mptcp_addr_info in 
mptcp_options_received"
- 9306df23ef10: "Signed-off-by" + "Co-developed-by"
- d04e57dd8194: mptcp: switch from be16_to_cpu to ntohs
- 6ae92a7f3931: tg:msg: ntohs and htons are used in more places

- f2a9929ffe7b: conflict in t/mptcp-unify-add_addr-6-_generate_hmac
- fcd019ff3bb7: "squashed" patch 3/3 in "mptcp: unify 
add_addr(6)_generate_hmac"
- 1b3803eed9bd: "Signed-off-by" + "Co-developed-by"
- 49306de67569: mptcp: switch from be16_to_cpu to ntohs
- (commit message doesn't need to be modified)

- Results: 7a40c945f992..158c472c9dd4

Tests + export are in progress!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
