Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2327B2562
	for <mptcp@lists.linux.dev>; Mon, 17 Oct 2022 18:38:05 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id c7-20020a05600c0ac700b003c6cad86f38so13358115wmr.2
        for <mptcp@lists.linux.dev>; Mon, 17 Oct 2022 11:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XWlGvO5aPWHmzSUcRMoVaCxLdK6gBqqhWx2tmPh60Ek=;
        b=0zVbhXCTojVedMzXEbDmumtVJHjsLqQ0RYdRXZuMfxsH8o74vhtMbye5/koH9zDwM0
         fJSaR9qrr1xxHNtxnjf/d65sottQQ7xRVFP7MJYPETn1WXWHwNLclM3mEyL9Vbgbi1nS
         +0kFMo00Jpb5Ta9A1P43UZiG5CH9s0/OdQ2GNGmeF03RsM40qk9Ck6eW49aLfDZAq3H5
         BEsTxQhZiLnVmhMVaYPub2CLNeRl6jarLkZnA5ksa0ViPBxxl6XxTBMeqfUVKuEb1eTS
         RbUmBXovVdH5ih+22kNcuIUSuAVjY+qm8/6etUNrtCuRcvwOGsCNhnAVEb1n/vIAe07s
         aX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XWlGvO5aPWHmzSUcRMoVaCxLdK6gBqqhWx2tmPh60Ek=;
        b=T0Rm/Ay9D3zIlSkzUsYp1yHg/ajC+hCXbawliu2N7kt/DQ3fLQOhVegV40qy+wflS1
         PPjsjeD226LaSU2+eJ0rvhlaSj+98m0dGkaLrTwhBC62/xLunSbC9/SWGNFGiocaqwou
         OoOt9vM5boGmegnvHD7Ui9QKQOvMMVfClM2Mx14SKXBRRlzR2eitoBki/BTZAz9h3z7R
         VgJA7wFfvNbDQ+B3MaYRWeP9wYXHut/voRBTNkWcgC5wQSnKWPcLE8zhM9QeEUUXO4p6
         hTiJp58atitQ2gOGXgHEH+dYHzDb5u+zTLGn6euGCo3jzWl3aXqZdZAdp43Ch0/q6oMW
         It8Q==
X-Gm-Message-State: ACrzQf2oKRpmF7c/Mf4k/NhNN0dHlbfhaneZY869zCxROthhnj1xvxLu
	YyzoSCyAx/+ETVI6RptV7SVA6o72CnUKPFAG
X-Google-Smtp-Source: AMsMyM5SGGL94bp2iSiyHwV4C8rJ7qQWKRqNcUU312rbGjB8LgR88bjZocWhhH31cLN5ep75p/zR+A==
X-Received: by 2002:a05:600c:3d08:b0:3c6:fb56:ac9f with SMTP id bh8-20020a05600c3d0800b003c6fb56ac9fmr2138191wmb.193.1666031883898;
        Mon, 17 Oct 2022 11:38:03 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:12ab:d13e:911e:ceab? ([2a02:578:8593:1200:12ab:d13e:911e:ceab])
        by smtp.gmail.com with ESMTPSA id u5-20020a5d5145000000b00232251d71c7sm8928558wrt.68.2022.10.17.11.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 11:38:03 -0700 (PDT)
Message-ID: <7ee2d85c-b408-74c5-6be2-ccbac5f62e9f@tessares.net>
Date: Mon, 17 Oct 2022 20:38:02 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC PATCH] selftests: mptcp: set test-case parameters
 consistently
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <2abed554f2050c7626dede74c92a181506a92682.1665779933.git.pabeni@redhat.com>
 <3d92e0ca-46dc-816f-87b2-17c32cd8993f@tessares.net>
 <5bb5893162902b8c86cdf7a42af715a1b3631472.camel@redhat.com>
Content-Language: en-GB
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <5bb5893162902b8c86cdf7a42af715a1b3631472.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 17/10/2022 19:29, Paolo Abeni wrote:
> On Mon, 2022-10-17 at 15:35 +0200, Matthieu Baerts wrote:
>> On 14/10/2022 22:39, Paolo Abeni wrote:

(...)

>>> +	if [[ "${addr_nr_ns2}" = "userspace_"* ]]; then
>>
>> Should this be re-factored as well?
>>
>>     userspace=1    \
>>     addr_nr_ns2=1  \
>>         run_tests (...)
> 
>>
>> Same for fullmesh below? And when arguments are negatives?
>> This is maybe quite a bit of work and maybe not needed (at least not to
>> reduce the number of parameters). That can also be done later (or never
>> :) ).
> 
> I thought about things, too. But the current code I think it's clear
> enough and the refactor would have been significantly more invasive.

I understand, fine without that.

>>> @@ -1024,6 +1018,7 @@ do_transfer()
>>>  	fi
>>>  
>>>  	cat "$capout"
>>> +	fail_test
>>
>> Does it mean some tests were maybe failing before and we didn't catch
>> that? 
> 
> Exactly. While testing intermediate version of this patch I got a few
> instances where the files did not match, but the test was succesful.
> 
> This perhaps deserves a separate patch.

Yes please.

(...)

>>> @@ -1828,7 +1816,7 @@ subflows_error_tests()
>>>  		pm_nl_set_limits $ns1 0 1
>>>  		pm_nl_set_limits $ns2 0 1
>>>  		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
>>> -		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
>>> +		speed=slow run_tests $ns1 $ns2 10.0.1.1
>>
>> detail: should we always move "run_tests" to the next line to make it
>> clear it is run_tests which is executed? (I don't know if it would be
>> better, just an idea :) )
>>
>>     speed=slow    \
>>         run_tests (...)
> 
> I tried that option, but it looked unnecessary noisy. Just my opinion!

Fine for me without this option!

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
