Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1E379C9
	for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 17:11:55 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id s12so18274243edd.5
        for <mptcp@lists.linux.dev>; Mon, 14 Nov 2022 09:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1agH5Y89aZku/baKXZ8DgLnGgKpxXs9POnVmUwMNEnU=;
        b=gxJVXndQNGTaoFgxud/HuJBMnlOt1Xv2RYiw7EToHW80QhXilwn4FtxghRIx6ErHdz
         L20OU3xmOWSmqnkwE86qTc6kgDtzVzlSw1ruP8xpdc47w9MPLZ/0ZUOfz6pcQqo7TjzF
         W5QqyO0gc7kf0Z0e1hwIM9bN+FJamyMMDPN0tWnWkBbfx1dHVF0LU+5maESrr9hsUXnq
         xn3dJP2odyRjDcCQFL+C/Xzdv4aI5sRvzN/RIDzNF7tCSSk7FfAAN5HQphZIEtWAB8q/
         38j/jnCtD9JTr4Uu7wqcdRtwA3L6OkfRYL2xIRmcFg1Rcqd1NhHUl6OE86Lxx7+TmIQM
         eZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1agH5Y89aZku/baKXZ8DgLnGgKpxXs9POnVmUwMNEnU=;
        b=TaH1lpRkv6IAnl8/NcPIonodfql4CvOojjNuE+20mFdcGSVBjGFVGYpF5Vgk/MRpst
         XyMBjdk1RgPsH0AiafvNrugIJMyAS0Zbt2mUIjID0BV5B0ZppUIdqjpYOvQf98aCE9+n
         YX6O4c9dSbzzru+TimEA0Ex/xLDVBk16vFEfoDPVDNMpvXQEChc9hNs/SIWNU83tPUzv
         yhCzrlZ0DK4FAe0J3FhwOEhOVJW+loj3OA+uoQej0YvsX8rp0QPdl8gA6AH8Cna3iAWb
         fqg2YK/25l4/lnlmeIn/L2wRlG2t+QLAchFouiyWPDYf2VoeFAPsU1RaGTOvnnVWwxL4
         kJ9g==
X-Gm-Message-State: ANoB5pkbTSIsThA3O7fX6PD3EkIFZD2wIeWJyZGF0d0l2q8WrtYdCjNh
	mamvW1mJgGfpDnFQqeiCUx0i+u/HUtDZeFrF
X-Google-Smtp-Source: AA0mqf5iFqOdFkHeheEBmrAXJduUR8EHl4l40xYSfScROkblr4bXDHgw/GGxU/cUmVmShj57PWMvEA==
X-Received: by 2002:a05:6402:5005:b0:462:a00e:1dab with SMTP id p5-20020a056402500500b00462a00e1dabmr11860230eda.135.1668445913292;
        Mon, 14 Nov 2022 09:11:53 -0800 (PST)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id i34-20020a0564020f2200b00458947539desm5104661eda.78.2022.11.14.09.11.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 09:11:52 -0800 (PST)
Message-ID: <f79c0855-7458-1e63-49fc-10b3168911b3@tessares.net>
Date: Mon, 14 Nov 2022 18:11:52 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH mptcp-next 0/5] mptcp: uniform code style and fix
 checkpatch splats
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
References: <20221114164601.861295-1-matthieu.baerts@tessares.net>
 <1a4372b7-3206-162c-c198-c16891391f01@tessares.net>
 <0a7f892acf37dfeea5f0ee072f76b526e9345c1f.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <0a7f892acf37dfeea5f0ee072f76b526e9345c1f.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 14/11/2022 18:08, Paolo Abeni wrote:
> On Mon, 2022-11-14 at 17:58 +0100, Matthieu Baerts wrote:
>> Hello,
>>
>> On 14/11/2022 17:45, Matthieu Baerts wrote:
>>> Just some small quick fixes about "issues" I saw when I applied the patches last
>>> week. Nothing important: function names, place in the .h and small checkpatch
>>> splats.
>>
>> An additional thing to do is to update the commit message of the first
>> patch of the "TFO listener" series which is currently:
>>
>>   mptcp: introduce MSG_FASTOPEN flag
>>
>>   In the following patches we will analyse the MSG_FASTOPEN flag
>>   in the mptcp_sendmsg() and invoke the MPTFO.
>>
>> Maybe by:
>>
>>   mptcp: add MSG_FASTOPEN sendmsg flag support
>>
>>   Since commit 54f1944ed6d2 ("mptcp: factor out mptcp_connect()") from
>>   Paolo Abeni, all the infrastructure is now in place to support this
>>   flag.
>>
>>   The remaining action to do is to allow it and treat it as a fastopen
>>   message to be able to access this:
>>
>>     sendto(sockfd, ..., ..., MSG_FASTOPEN, ..., ...);
>>
>> What do you think?
> 
> Possibly something a little less verbose? Alike:
> 
> """
> mptcp: add MSG_FASTOPEN sendmsg flag support
> 
> Since commit 54f1944ed6d2 ("mptcp: factor out mptcp_connect()") all the
> infrastructure is now in place to support the MSG_FASTOPEN flag, we
> just need to call into the fastopen path in mptcp_sendmsg()
> """

I know you would prefer a version without your name :-)

Sure, it is good to me!

Is it OK for you if I do the modifications and apply the 5 other small
patches? (no hurry :) )

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
