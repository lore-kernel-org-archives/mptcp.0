Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FB85CA1
	for <mptcp@lists.linux.dev>; Sat, 28 Jan 2023 13:54:38 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so7168663wml.3
        for <mptcp@lists.linux.dev>; Sat, 28 Jan 2023 05:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IZd2mFuO+U7mru8PcBz4+54JnKwPQ4diiRFDp6H4+58=;
        b=c22oI/hOOqPvKv4J+hnUQCLPYj6x2FHsrSLkgh/6Pw8WRWyk+3QYkR/pHKzjBxTIaL
         GkwC6FIHlNUZNCUC/kd8RrpFYjIr9Klf8TFxD4lNV6L8NH4ygNwyRcx4fwiqhVyCA+Dv
         6JrecQ4uRHCgRekxQsi/EBYjbFfTWGZedX1BD1NiV+PYL5aKd3jIwPGLnd/nONLvEcYf
         eSwmGL5QI5FtUie5gAhj3xXDNUHsHaVAeUaEX5Gi90Bw9atss1iYioqVJZBuQ52q8Tqg
         mePa4DaYlDF9uwEm2TcYMAtFpRLlEntP9dY8CycFPtGe1Khqifxl7rO+95MrIqFFXukP
         7HsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZd2mFuO+U7mru8PcBz4+54JnKwPQ4diiRFDp6H4+58=;
        b=XUQ5XxYwtzKCU84PlMLKSUnPZZB6JkKuCR+qef63FBVYVWZyOocj46E17oM0Weo6m6
         EP13JQXhaJG461j+daOGS2FZxja/jhgkAhiu2FnjgDmkJOtFDLCSA7ikIxS3dOEFlEsu
         TQbI8yEzy6QW57ISijrFAQh3cq3JKl1j46rKKrdEy3ugNHn3kzR3l5W5B01M7hUwgmym
         iuXfE3snx35bBTjYtVQyJjnoOHdG7+cqVfuV8O82EwO6IEAXwBQeOptjBpwe5yaBjA3F
         rPUSJxXisYOGTJGaCk6Uek5t1O+53pczaWqbshBDtOaCeS+u7uSaYhIivZSO2Rzk0cf2
         GzjQ==
X-Gm-Message-State: AFqh2kpyvJba1x2HKGdhoIYdxNVCzJCD8ia3AFFDqvvEp/SLHPsSPdIF
	5fqhXYsJ1puvcdU2pyVbxstMtN7gjpRvJHlWxvw=
X-Google-Smtp-Source: AMrXdXvnK404VXG9fZUGPZl+5DqqZ2PrbYmxtViWMZWmfqSWCuLuN2rRBYAizK1W7BZhINOE6gDhqg==
X-Received: by 2002:a05:600c:1d8e:b0:3d9:f9ef:3d23 with SMTP id p14-20020a05600c1d8e00b003d9f9ef3d23mr45802273wms.23.1674914076477;
        Sat, 28 Jan 2023 05:54:36 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:7882:c567:a355:7df6? ([2a02:578:8593:1200:7882:c567:a355:7df6])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c1c0500b003dc4aae4739sm1938199wms.27.2023.01.28.05.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 05:54:36 -0800 (PST)
Message-ID: <46759470-1a59-6909-84e5-8333562b37eb@tessares.net>
Date: Sat, 28 Jan 2023 14:54:35 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH mptcp-next v2] mptcp: update userspace pm subflows info
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <d262f6beb6899f0a79acbeb1d3c8c855e95e098a.1673599496.git.geliang.tang@suse.com>
 <5d756f95-0a7e-fd18-ccf8-4c206b5621d6@tessares.net>
 <20230128024449.GA3720@bogon>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230128024449.GA3720@bogon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 28/01/2023 03:44, Geliang Tang wrote:
> On Wed, Jan 25, 2023 at 07:13:31PM +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 13/01/2023 09:45, Geliang Tang wrote:
>>> Increase pm subflows counter when userspace pm creates a new subflow,
>>> and decrease the counter when it closes a subflow.
>>>
>>> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/329
>>
>> (sorry for the delay)
>>
>> Thank you, the patch looks good to me! But I don't think it is enough to
>> close the ticket 329.
>>
>> I think there are other fields visible in `MPTCP_INFO` but only updated
>> by the in-kernel PM. e.g.
>>
>> - add_addr_signaled
>> - add_addr_accepted
>> - local_addr_used
>>
>> I guess these counters should be modified as well (in different
>> commits), no?
> 
> Yes, I'll modify these counters in v3.
> 
>>
>> Also, I don't know if we should consider this as a "new feature" for
>> net-next: to me, it looks like we forgot to update the counters and it
>> is not really a new feature to update them but more a bug-fix. So maybe
>> we can target -net? I'm open to suggestions on that point :)
> 
> Sure. I'll update this in v3.
> 
>>
>> Not directly related but for the issue #330 -- 'subflows' counters not
>> incremented for the server side -- it could be considered as a bug fix
>> as well depending on how it is implemented: if it is backported, we
>> would have the same behaviour with all kernels. Or we add new field(s)
>> in MPTCP_INFO but this is maybe not needed.
> 
> OK, I'll address #330 in v3 too.

Great, thank you!

Happy New Year!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
