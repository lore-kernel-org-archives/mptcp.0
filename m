Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358E94A1F
	for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 11:31:42 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id r133-20020a1c448b000000b003b494ffc00bso3909830wma.0
        for <mptcp@lists.linux.dev>; Mon, 19 Sep 2022 04:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=SgyUbML6SUdl/MttOcWn/xsLtDxt678FnYSMQ4SbbDo=;
        b=rb+bobjy6mu/3OvxSDafRbMNEsfPnf8gZTdwk43ojPBXvEwJCyoG9x7PXPEBozy2Dx
         M3CbbNNjT1FRxV4ksGP2YlBoBu62hyrgdOvip07ikT40ye8N8pdjoZ+Xz4zmL1DSeAy1
         7DsnC7Y0qqnJi28XlxQnzsQcOg9e3/yvaeQo201qgsnDhcBc+2tP9F5RIVGXGA8A/r9y
         B049fsPkl7i0n4mfRQ/JIjEyV5Tz/H1iCIByx3XcDzhQ6bUw8unKULBDCB6d9wpOI091
         Vh+mbD2q1UZ0JNz3sA6WpPCQWW+NozWu32AAfpDWLy6IKB9oLtc2vl99wDCftmtqND1k
         hMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SgyUbML6SUdl/MttOcWn/xsLtDxt678FnYSMQ4SbbDo=;
        b=B5bt/Rmtv6gsHXzTWWSFuJzSLEWGZCx3EKkvJSoinirQLvOL9Q5C+GyeII8XVhofZL
         qdD0kEPKLgn8OOnynosZrYV/wHEaB9T0WRfSeG72lS7lcojps3nS1xUJhiuZleeEwxeN
         1VQgPe0MONHSmOTkWzM56PeDAKAgF7WoCZPzZyHwQjyyA82w1CkbhoVAMhBGxyeqsJCN
         iqgcPCZ7r4mAt+6gUjMw9ehs4eq6K3gBBm53lQqaAF/z3Hl4F3bdP4KmcyJ+z6DPDzOz
         rrUdTyxNU7XAoPNfKjB7KUJRDmJebGt4dP8E2JWUZWFgvKyoJrwgQi8+0X0c2JLVlYps
         HQ6w==
X-Gm-Message-State: ACrzQf2TA7HMdJuXwy5PlFjI74HRP9ZDqKcRhOtPXQx+67pctpgk1PYh
	XOSBDisZtbI9nNU1+h5EvcKg5A==
X-Google-Smtp-Source: AMsMyM5b7DSvFmXDBF3f/eHyGoRzYQbC2KEbYub3nUUEj1TyXok3p6LPnVCLaAtjM2MEJWIDy4HDCA==
X-Received: by 2002:a05:600c:4352:b0:3b4:84c0:2006 with SMTP id r18-20020a05600c435200b003b484c02006mr11983808wme.205.1663587101006;
        Mon, 19 Sep 2022 04:31:41 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id h21-20020a05600c351500b003b491f99a25sm14927041wmq.22.2022.09.19.04.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 04:31:40 -0700 (PDT)
Message-ID: <48aa48fa-85a7-b391-7095-204efbb63f97@tessares.net>
Date: Mon, 19 Sep 2022 13:31:39 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RFC PATCH mptcp-next v7 08/11] Fix unxpctd val of
 subflow->map_seq(dscrd packet)
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, Dmytro Shytyi <dmytro@shytyi.net>
References: <20220917222853.2406-1-dmytro@shytyi.net>
 <20220917222853.2406-9-dmytro@shytyi.net>
 <b83883829f7a8730207223178841f330617a72e4.camel@redhat.com>
Cc: mptcp@lists.linux.dev, Benjamin Hesmans <benjamin.hesmans@tessares.net>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <b83883829f7a8730207223178841f330617a72e4.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo, Dmytro,

On 19/09/2022 13:27, Paolo Abeni wrote:
> On Sun, 2022-09-18 at 00:28 +0200, Dmytro Shytyi wrote:
>> Fix unexpected value of subflow->map_seq (discarded and after
>> retransmitted 2nd packet)
>>
>> Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
>> ---
>>  net/mptcp/subflow.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index c7d49fb6e7bd..075c61d1d37f 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -1077,8 +1077,10 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
>>  		/* will validate the next map after consuming the current one */
>>  		goto validate_csum;
>>  	}
>> -
>> -	subflow->map_seq = map_seq;
>> +	if (msk->is_mptfo)
>> +		subflow->map_seq = READ_ONCE(msk->ack_seq);
>> +	else
>> +		subflow->map_seq = map_seq;
>>  	subflow->map_subflow_seq = mpext->subflow_seq;
>>  	subflow->map_data_len = data_len;
>>  	subflow->map_valid = 1;
> 
> 
> This is likely not needed, if you build a special dss mapping at
> incoming option processing time.

Also for this, Benjamin had another approach by delaying MPTCP data_ack
calculation, see from patch 5/10 from [1]. It might be good to discuss
about that at the next weekly meeting.

Cheers,
Matt

[1]
https://lore.kernel.org/mptcp/20220908133829.3410092-1-benjamin.hesmans@tessares.net/T/
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
