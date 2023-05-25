Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82C13D7C
	for <mptcp@lists.linux.dev>; Thu, 25 May 2023 16:49:19 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f6e4554453so3472005e9.3
        for <mptcp@lists.linux.dev>; Thu, 25 May 2023 09:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685033358; x=1687625358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=396Mq62z9F2nVFk7uoWVOuSSrx+nR3o4Gcjs+Ubu2n8=;
        b=XbkhTB1Mj6/8vo1azC5XVzN6VXrniZgRBb+HZYoNmWFua9SOMZyNF8Ki7ZPb90bBRU
         xf1zhlkAyYVYeTjMUEna5ZetjMrH8jvhb4HOYKL8MsPWr3r1MJLfjTkCZekIDGWkIO+x
         Ql37NYBEvd8sSMipm/W+6sNVn4KRDNlILc1p1417cf0LljJFlo5aleVrAF7sYz66C1uh
         eX2GyO+Xct5CqMuP1f0JJkYXm8IMJD3++jATwoOApaeErMB6wZhq7L2oV/gDD58T/A5R
         va1mc5EnmUboNmXMIUC64QxJHp15ivDjhasxfdlf/W+U88BWffsHhyiCobW2AEv0ff79
         P5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685033358; x=1687625358;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=396Mq62z9F2nVFk7uoWVOuSSrx+nR3o4Gcjs+Ubu2n8=;
        b=I2BspylLOuZg9/ybXd5b6XzDo3/6TzMukXcr0zkxhzmN8nlYxMzFrY+GSLfd5l8R3x
         nA6zdRbar4DxI49zq2DixJS/85vB3ca7J+GzU1VzorrWiVu5n/zHFJ3jsa+E/4g3yj7z
         h6Xf/JSDr/qnr3cgciBUxOUe54T01L+8Uzy3aGVOJT53268X410guImyVhR5mLFAWlAC
         /+Pk5zTpa0VBkaxC3xQmx+3ZLOivMjKAYNPW5RrFTFZQi4isEw30wJqut4K1TbPDsGck
         v4ASaQmK7/bccSLUnZPOzTL7Tw7RZYc+nPciKzQTh91uFNx59/+WzI/4E0czsyWPKfQs
         4rEQ==
X-Gm-Message-State: AC+VfDw+tsBkMXzI6hUtrDTHpHN4ZCoZxnpjOOZAjbr5xRb+6IzMwans
	SKzDHxuL2qJyDG0OKZ6fvjpVAg==
X-Google-Smtp-Source: ACHHUZ6Y4iD2oaPY5vH24oHh4ZrRVuj4UWyN/IOlgpQfdlVaRa61zfo1NE98YUuDJnWy7BsC6lHQgA==
X-Received: by 2002:adf:ec0e:0:b0:2f0:2dfe:e903 with SMTP id x14-20020adfec0e000000b002f02dfee903mr2844029wrn.69.1685033357734;
        Thu, 25 May 2023 09:49:17 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:f7f1:b30b:79e4:1a7e? ([2a02:578:8593:1200:f7f1:b30b:79e4:1a7e])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d4e8f000000b00307bbbecd29sm2344544wru.62.2023.05.25.09.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 09:49:17 -0700 (PDT)
Message-ID: <0a6a8553-7888-e640-692c-8332ce41323d@tessares.net>
Date: Thu, 25 May 2023 18:49:16 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 mptcp-next 6/6] selftests: mptcp: add MPTCP_FULL_INFO
 testcase
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Florian Westphal <fw@strlen.de>
References: <cover.1684997011.git.pabeni@redhat.com>
 <576f5cf229e5b91d27e8411fab1ba7223cec0c17.1684997011.git.pabeni@redhat.com>
 <d26ed3cb-3dc3-0c7c-af56-ae0e62c403a6@tessares.net>
 <a6d754ce2b57e4827b733f885b3464cebb5c4eb2.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <a6d754ce2b57e4827b733f885b3464cebb5c4eb2.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 25/05/2023 18:39, Paolo Abeni wrote:
> On Thu, 2023-05-25 at 17:22 +0200, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 25/05/2023 09:17, Paolo Abeni wrote:
>>> Add a testcase explicitly triggering the newly introduce
>>> MPTCP_FULL_INFO getsockopt.
>>
>> (...)
>>
>>> +static void do_getsockopt_mptcp_full_info(struct so_state *s, int fd)
>>> +{
>>> +	size_t data_size = sizeof(struct mptcp_full_info);
>>> +	struct mptcp_subflow_info sfinfo[2];
>>> +	struct tcp_info tcp_info[2];
>>> +	struct mptcp_full_info mfi;
>>> +	socklen_t olen;
>>> +	int ret;
>>> +
>>> +	memset(&mfi, 0, data_size);
>>> +	memset(tcp_info, 0, sizeof(tcp_info));
>>> +	memset(sfinfo, 0, sizeof(sfinfo));
>>> +
>>> +	mfi.size_tcpinfo_user = sizeof(struct tcp_info);
>>> +	mfi.size_sfinfo_user = sizeof(struct mptcp_subflow_info);
>>> +	mfi.size_arrays_user = 2;
>>> +	mfi.subflow_info = (unsigned long) &sfinfo[0];
>>> +	mfi.tcp_info = (unsigned long) &tcp_info[0];
>>> +	olen = data_size;
>>> +
>>> +	ret = getsockopt(fd, SOL_MPTCP, MPTCP_FULL_INFO, &mfi, &olen);
>>> +	if (ret < 0) {
>>> +		if (errno == EOPNOTSUPP) {
>>> +			perror("MPTCP_FULL_INFO test skipped");
>>> +			return;
>>> +		}
>>> +		xerror("getsockopt MPTCP_FULL_INFO");
>>> +	}
>>> +
>>> +	assert(olen <= data_size);
>>> +	assert(mfi.size_tcpinfo_user == mfi.size_tcpinfo_kernel);
>>> +	assert(mfi.size_tcpinfo_user == sizeof(struct tcp_info));
>>> +	assert(mfi.size_sfinfo_user == mfi.size_sfinfo_kernel);
>>> +	assert(mfi.size_sfinfo_user == sizeof(struct mptcp_subflow_info));
>>
>> Similar to the patch I sent to support old kernels, we cannot do these 4
>> last assert(), see:
>>
>> https://patchwork.kernel.org/project/mptcp/patch/20230406-mptcp-issue-368-selftests-old-kernels-v2-17-50313e4f83ab@tessares.net/
>>
>> Because we cannot guess the size of these two structures in the kernel,
> 
> Regarding mptcp_subflow_info we can infer it must be >=
> sizeof(mptcp_subflow_addrs) + 4...

Does that mean sizeof(mptcp_subflow_addrs) can never be modified?

>> I suggest to do this:
>>
>>   assert(mfi.size_tcpinfo_user > 0);
>>   assert(mfi.size_tcpinfo_kernel > 0);
>>   assert(mfi.size_sfinfo_user > 0);
>>   assert(mfi.size_sfinfo_kernel > 0);
>>
>> Better than nothing... In case of error, one would be set to 0 or we
>> would not get info from these structures below.
> 
> ... so we could check:
> 
>   int min_sfinfo_size = 4 + sizeof(struct mptcp_subflow_addrs);
> 
>   // ...
> 
>   assert(mfi.size_tcpinfo_kernel > 0);
>   assert(mfi.size_tcpinfo_user ==
>          min(mfi.size_tcpinfo_kernel, sizeof(struct tcp_info));

Good idea to use 'min' here!

>   assert(mfi.size_sfinfo_kernel >= min_sfinfo_size);    
>   assert(mfi.size_sfinfo_user ==
>          min(mfi.size_sfinfo_kernel, sizeof(struct mptcp_subflow_info));

I guess I should do the same in:

https://patchwork.kernel.org/project/mptcp/patch/20230406-mptcp-issue-368-selftests-old-kernels-v2-17-50313e4f83ab@tessares.net/

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
