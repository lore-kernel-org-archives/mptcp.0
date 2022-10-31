Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA4333C5
	for <mptcp@lists.linux.dev>; Mon, 31 Oct 2022 17:09:23 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id v1so16878169wrt.11
        for <mptcp@lists.linux.dev>; Mon, 31 Oct 2022 10:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2kKCzVqqYaAJL5nO1CSVHGrXkK1WvmPe2NxVjT6b/Rg=;
        b=2jEmjCeEzRIMfkFEIqYIs7KUhX8leFqH8hTNN8EtmLGpRyClCh6hVPBxWY9cWjOv86
         7ssUdMrNcmdjLZ6fCv39/snw35xxC1y93eaIU3w5M6w4tMc3uOf48sHX9pXENxYlbZfb
         xgfoe2tqDFtVxibhXH36CM/IrIKO2f3TvQyO+MVRpz2mQUdDwYBTP3eW4R/SNLb0coyG
         ocoqGspqbm1GHDcId6RLzM7UU5cM+GSoiSSoyzcLzelvt8YJv1ZX4EM4e2OzsXkHgti0
         8Rp2toZEoWzp6LyZjWCdKSBkfWcpWYj+DMDmNdyM6KjCMvWP52miaeozgjHPluoAopzr
         8GkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2kKCzVqqYaAJL5nO1CSVHGrXkK1WvmPe2NxVjT6b/Rg=;
        b=A+fDvcN1IrL4Ovww97PyBS7kwrLDh32XUhDC9C7B/44sEZfhv+GYCfjYWAlGQs5Um8
         euJtogPgvfLXFe7/skD8vuy6EIC8dNrk2NN5gK5lg5NDPHR8HtJWsqha71E3l21VuKjt
         J3+5nws9PzmPs5SeDw3h3OkmgrwISbtiyPoq2/It6u6BSvwUZYeQXACmt7UGKle+qNZy
         iqIGGSOQkP2R90HkXEwnUuC4ZGfGmn5QzR5CUV2k5HJJBu2utObKcaRRD797KUZWmfLL
         cmIPdJQdM1vpJzf2rIvWAlYUhnJv+3Fp3URE+86HGOSRmiL457DcDcNEU44ybwbDFWYU
         NF0g==
X-Gm-Message-State: ACrzQf0otgIWmmDiRn0u7m15fMZbVVW4I/XLuRkw5G+IsopoaUcnXnQ3
	k4HiFdxzIiCIwNPDcDFoVx6e1m0v06mz6g==
X-Google-Smtp-Source: AMsMyM54xja9V/CVBOMBa6a4gRe6eRT0oZ9a03wnBNn1InlYuxUn/jU80dK26dWHLEnRGSX7mW0B3Q==
X-Received: by 2002:a5d:588f:0:b0:231:c661:5cee with SMTP id n15-20020a5d588f000000b00231c6615ceemr9166588wrf.18.1667236161982;
        Mon, 31 Oct 2022 10:09:21 -0700 (PDT)
Received: from [10.44.2.26] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id x16-20020a5d4450000000b0022a3a887ceasm7828467wrr.49.2022.10.31.10.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 10:09:21 -0700 (PDT)
Message-ID: <1e437f3e-7557-573a-cb13-b19fcbea35d1@tessares.net>
Date: Mon, 31 Oct 2022 18:09:21 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH mptcp-net 1/4] selftests: mptcp: run mptcp_sockopt from a
 new netns
Content-Language: en-GB
To: Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.linux.dev
References: <20221019161940.3178393-1-matthieu.baerts@tessares.net>
 <20221019161940.3178393-2-matthieu.baerts@tessares.net>
 <CA+WQbwuyOdNfg-g=QC-KF9dMyxdXp1vaEPoWn2LzpE+kM_w1yw@mail.gmail.com>
 <aaad626e-a646-f2a7-fb8b-158b459b73ea@tessares.net>
 <d183722a-b41c-57b4-38e7-356a263d313b@linux.intel.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <d183722a-b41c-57b4-38e7-356a263d313b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

On 31/10/2022 17:08, Mat Martineau wrote:
> On Mon, 31 Oct 2022, Matthieu Baerts wrote:
> 
>> Hi Geliang, Mat,
>>
>> On 23/10/2022 11:28, Geliang Tang wrote:
>>> Matthieu Baerts <matthieu.baerts@tessares.net> 于2022年10月20日周四
>>> 00:20写道：
>>>>
>>>> Not running it from a new netns causes issues if some MPTCP settings
>>>> are
>>>> modified, e.g. if MPTCP is disabled from the sysctl knob, if multiple
>>>> addresses are available and added to the MPTCP path-manager, etc.
>>>>
>>>> In these cases, the created connection will not behave as expected,
>>>> e.g.
>>>> unable to create an MPTCP socket, more than one subflow is seen, etc.
>>>>
>>>> A new "sandbox" net namespace is now created and used to run
>>>> mptcp_sockopt from this controlled environment.
>>>>
>>>> Fixes: ce9979129a0b ("selftests: mptcp: add mptcp getsockopt test
>>>> cases")
>>>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>>> ---
>>>>  tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 9 +++++----
>>>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
>>>> b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
>>>> index 0879da915014..80d36f7cfee8 100755
>>>> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
>>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
>>>> @@ -35,8 +35,9 @@ init()
>>>>
>>>>         ns1="ns1-$rndh"
>>>>         ns2="ns2-$rndh"
>>>> +       ns_sbox="ns_sbox-$rndh"
>>>
>>> Hi Matt, how about clearly defining ns_sbox (as well as ns1, ns2) as a
>>> global variable at the beginning of this file, and then assign values
>>> here, as the same as in mptcp_connect.sh and mptcp_join.sh?
>>
>> Thank you for the idea, it would be clearer.
>>
>> @Mat: Because this patch is for -net, would it not be better to do that
>> in an additional patch for net-next? Patch 2/4 is also for net-next and
>> depends on patch 1/4.
>>
>> Or maybe it is OK to do that in -net because it is in the selftests? I
>> would prefer to split but I'm fine to do that if we prefer.
> 
> Oh - I missed that the series was a mix of net and net-next!
> 
> Sure, fine to split it.

Great, I can do that.
Do you prefer a v2 or can I send a single patch on top of the v1?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
