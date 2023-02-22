Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9762F3F
	for <mptcp@lists.linux.dev>; Wed, 22 Feb 2023 15:25:11 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id j19-20020a05600c1c1300b003e9b564fae9so806909wms.2
        for <mptcp@lists.linux.dev>; Wed, 22 Feb 2023 07:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Um7gRWwev2c+N3nMZi2QHP/qlfqJsbaL3buV+Tif08=;
        b=ZWsRRi22MC3XTFOmxg7oO8jvkzSzfKeHJahlG0+IkOgl46eiEao45hbdyvbI1hUh4v
         jSFFB6I7zZQ1pROB0w0tTUQBTqf6e0IZW+IKBHvDXOPkTaJJ9ND+K//ccTQU/loJaivB
         TPlnDRlVy9jWpxxVcL+zCedREjI3C8xPyJTf1rTCLIIq/D8YzPaDrUln8uvGoiKb/VvT
         XHIrVOdI+5Z8Fps8PYY/0Xj7fe+4leOkmdjSU7HQMgiAh0eftc6YlgkqzLMKw/Nn+Hiw
         6YTbUgrfz/6+Z7YVVFrq+LedHMi8KLQ6ldyXUU5VzB4pYP8sixCrFCn8ed4Cg414YlqT
         N5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Um7gRWwev2c+N3nMZi2QHP/qlfqJsbaL3buV+Tif08=;
        b=6AhW0SZQvXb9sbxhfgCIbBsdJOuoBwwhMl+RhFofRctL1u74pnWTMHG4LgHAyR9OC7
         l9w5k9kfyJEBJbsEQMuQXTUNZPhFELMviencASHgxm5OjkuHJ6NWXxer6N5A2cuOfDA/
         h+vakF8yeNujd/DNDtc1pUCxGmWi00A+4EHQEaViJdpxAlItX30NR7PvByJJhr44IFnW
         e4RFtxGF992cZNdwhJBFP88CAr5QKrjoDj9r8xFCtq70XVWohg5n5/nU1l7HbS+39+lo
         lxJuc+MVUxrYRNIHZCNdODGB4XJd1327ZWD01nnVH/OghA5Cu79Y5oWQSn6QW81vifCB
         Rmjw==
X-Gm-Message-State: AO0yUKVrrrCmEvZKFDOlfW5AgbyDNoPdZQtRyEP3AunX7+ilrA6TaR5Y
	jbQlhwhuBLGoMlUY3TKamz4hmg==
X-Google-Smtp-Source: AK7set+0LqDOTYF/5LirrfNoUpwdflz6RfgCnV/lXbOco6Fxqx1kSDLsmdGM2C8OIz/6LeyzzhtCqA==
X-Received: by 2002:a05:600c:1c17:b0:3df:eda1:439c with SMTP id j23-20020a05600c1c1700b003dfeda1439cmr8265303wms.11.1677079509411;
        Wed, 22 Feb 2023 07:25:09 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:ea8d:3a00:8f98:6fb? ([2a02:578:8593:1200:ea8d:3a00:8f98:6fb])
        by smtp.gmail.com with ESMTPSA id n30-20020a05600c3b9e00b003e206cc7237sm9273312wms.24.2023.02.22.07.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 07:25:09 -0800 (PST)
Message-ID: <2c17ceb5-09c8-18c2-24e4-cd094d5933bf@tessares.net>
Date: Wed, 22 Feb 2023 16:25:08 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH mptcp-net 1/2] mptcp: avoid setting TCP_CLOSE state twice
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20230221-mptcp-warn-tcp-done-close-v1-0-d248242b29b6@tessares.net>
 <20230221-mptcp-warn-tcp-done-close-v1-1-d248242b29b6@tessares.net>
 <5634a811ff8da65d6063ec03218a6462f5a189e7.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <5634a811ff8da65d6063ec03218a6462f5a189e7.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 22/02/2023 15:32, Paolo Abeni wrote:
> On Tue, 2023-02-21 at 18:54 +0100, Matthieu Baerts wrote:
>> tcp_set_state() is called from tcp_done() already.
>>
>> There is then no need to first set the state to TCP_CLOSE, then call
>> tcp_done().
>>
>> Fixes: d582484726c4 ("mptcp: fix fallback for MP_JOIN subflows")
>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/362
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>>  net/mptcp/subflow.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index 28c64811a8af..a36d1b1088d7 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -406,7 +406,6 @@ void mptcp_subflow_reset(struct sock *ssk)
>>  	/* must hold: tcp_done() could drop last reference on parent */
>>  	sock_hold(sk);
>>  
>> -	tcp_set_state(ssk, TCP_CLOSE);
>>  	tcp_send_active_reset(ssk, GFP_ATOMIC);
>>  	tcp_done(ssk);
>>  	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags) &&
>>
> 
> I think this one could be squashed to:
> 
> mptcp: fix possible deadlock in subflow_error_report
> 
> WDYT?

Thank you for your reply!

I'm a bit confused: the commit you mention ("mptcp: fix possible
deadlock in subflow_error_report"):
- modifies subflow_error_report() function
- fixes 15cc10453398 ("mptcp: deliver ssk errors to msk")

While my patch here:
- modifies mptcp_subflow_reset() function
- fixes: d582484726c4 ("mptcp: fix fallback for MP_JOIN subflows")

They seem to fix different issues: better to keep them separated, no?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
