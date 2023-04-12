Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBFA20EE
	for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 16:44:51 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id s8so6991449wmo.0
        for <mptcp@lists.linux.dev>; Wed, 12 Apr 2023 09:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681317890;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ghpv9cscfIZxtu8/JyVek7mJ4kodarz9aBKt11yTkA=;
        b=rkWOzgzlRzcBtFQdwYtzPYpQDtQE10Jr/1rlDIGOCLwb3vzdN3C5XJuL/pk/dUifHw
         f5b6PgSs2mDaAnCoNTC6SAgu86Oh+VotB98r2I6A0z3RMF3mvrO05E5RQmOfoTpg1ito
         OLe8XozyoPI3DSJGCPTqXtfoR92QSaXtMFoXSsmoAPeE2WVQn/laIAtE4WpVV+w3oWPt
         zCD1s1MoRIkHwDP6gbTmTcJ914BqB9i80ywZy8o1vGC8+1p4XJAeJdx12NMIv3jTJdMh
         N/h+0ELrRSyvgrUqvjC5f22OQ1b7uWZQosPZ8JW9wLI/PZ/eUP1xm/8Rv1Qmx30ehN5c
         KthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317890;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ghpv9cscfIZxtu8/JyVek7mJ4kodarz9aBKt11yTkA=;
        b=aFVyYkuyc9rfdQZ0Gb58oWRuL+dLe5qLXDNOQaz3U/4v1yEeNFAj0NTwfplTq4cidn
         3a+avmxFu/IujsFt9emb73MiUG6ENzu62OSKKwTKbqK5O3mML2MOuSPWnBOYUm80UwSp
         YDD0JC/t/8AbZ5YhJC7Qyk7QhD67oPhoppaML7/9taNfNRPBJQuseKJFyFxFAR8WZ2lR
         2OiDX8CtDY3fuqfusFpVBSE+3Il5+QAO4lDmfCtZh7d9nZNzgWTcKR1+/ntPuHHKwojj
         xxVQsXIG7R6LrVWkSfy4Fb/XRkVOv6CI/6yKG6mHLAlEuIs6vVwhyi1phNXRVcuOXRXx
         BIMg==
X-Gm-Message-State: AAQBX9foOOOd1t6HtVBzNrFFxRdSzMsrCZ0cLv4gZrs8vbxjl1lCUUlc
	KwabVjySjuXTfDGfqiqsyUFbJQ==
X-Google-Smtp-Source: AKy350bj1c74teNRrwL9U7AkFVBl73+q96DqvSrSG+LKE4nnbsPdnkvczbdMn6JcUnx8j8M0Kmya5Q==
X-Received: by 2002:a7b:ca43:0:b0:3ed:b094:3c93 with SMTP id m3-20020a7bca43000000b003edb0943c93mr4800921wml.23.1681317890019;
        Wed, 12 Apr 2023 09:44:50 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:9946:50ca:7635:b749? ([2a02:578:8593:1200:9946:50ca:7635:b749])
        by smtp.gmail.com with ESMTPSA id u10-20020a05600c19ca00b003f09d1a88c9sm3035672wmq.42.2023.04.12.09.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 09:44:49 -0700 (PDT)
Message-ID: <4fa60957-2718-cac2-4b01-12aaf48b76b4@tessares.net>
Date: Wed, 12 Apr 2023 18:44:48 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH net,v2] uapi: linux: restore IPPROTO_MAX to 256 and add
 IPPROTO_UAPI_MAX
Content-Language: en-GB
To: Jan Engelhardt <jengelh@inai.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Pablo Neira Ayuso
 <pablo@netfilter.org>, netfilter-devel@vger.kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
 mathew.j.martineau@linux.intel.com, mptcp@lists.linux.dev
References: <20230406092558.459491-1-pablo@netfilter.org>
 <ca12e402-96f1-b1d2-70ad-30e532f9026c@tessares.net>
 <20230412072104.61910016@kernel.org>
 <405a8fa2-4a71-71c8-7715-10d3d2301dac@tessares.net>
 <689os02o-r5o8-so9-rq11-p62223p87ns3@vanv.qr>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <689os02o-r5o8-so9-rq11-p62223p87ns3@vanv.qr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/04/2023 18:14, Jan Engelhardt wrote:
> 
> On Wednesday 2023-04-12 17:22, Matthieu Baerts wrote:
>>>> But I don't know how to
>>>> make sure this will not have any impact on MPTCP on the userspace side,
>>>> e.g. somewhere before calling the socket syscall, a check could be done
>>>> to restrict the protocol number to IPPROTO_MAX and then breaking MPTCP
>>>> support.
>>>
>>> Then again any code which stores the ipproto in an unsigned char will 
>>> be broken. A perfect solution is unlikely to exist.
> 
> IPPROTO_MPTCP (262) is new, anything using MPTCP is practically new code
> for the purposes of discussion, and when MPTCP support is added to some
> application, you simply *have to* update any potential uint8 check.

I hope such check doesn't exist :)

IPPROTO_MPTCP is only used when creating the socket, with the "protocol"
parameter which accepts an integer.

>> I wonder if the root cause is not the fact we mix the usage of the
>> protocol parameter from the socket syscall (int/s32) and the protocol
>> field from the IP header (u8).
>>
>> To me, the enum is linked to the socket syscall, not the IP header. In
>> this case, it would make sense to have a dedicated "MAX" macro for the
>> IP header, no?
> 
> IPPROTO_MAX (256) was the sensible maximum value [array size]
> for both the IP header *and* the socket interface.
> 
> Then the socket interface was extended, so IPPROTO_MAX, at the very
> least, keeps the meanings it can keep, which is for the one for the
> IP header.
> Makes me wonder why MPTCP got 262 instead of just 257.

Just in case a uint8 is used somewhere, we fallback to TCP (6):

  IPPROTO_MPTCP & 0xff = IPPROTO_TCP

Instead of IPPROTO_ICMP (1).

We did that to be on the safe side, not knowing all the different
userspace implementations :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
