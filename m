Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2276FBD
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 17:14:19 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id j22so9720038ejv.1
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 10:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680887657;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x0uVcYU0m2uOxacs93IRrBj51h1qEScROwltgPuThok=;
        b=A7+BybQ3xy0qPqzHo5Sa8nVy+OcQQstFzCIQnn3tMVsBL64Wtey4jARR4zaTKDbOBg
         PchYKmxU6zNswRPlDbBbvp+h0YU/qctnOdpRnAromgzqc+8RBDc6fil4kLcultlYw6HX
         15aQhdNMhg8Fx8NwHlnrv5tOsGyMz5huW1mKx3eVqI1dJ12DF1PZ0+gYEfI3R8rnFFtp
         /ljeP1EK+BzzZsuaiAXCeWyDb08wmYpzH2ocsIrRjuZEy9S54HWsiQWjttoWwurwXQBT
         mvsAuyPs71ahs/2cotmkWRMU0V7nI/YbR4ktqP4mnzX5m/hb1oYQAzxk4qjjuNYAzVoB
         /scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680887657;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0uVcYU0m2uOxacs93IRrBj51h1qEScROwltgPuThok=;
        b=5XuI1aXo9/hb6t1QTXxTXX9V0akNbw50owKGQ1jmaHIatf1nDAQOnKfHr2c7eLTG55
         wxCloaDpny54nWu3KJg9fDX1opMbYQ6tJNdHsNjgIXugbmdQygakDHlWWSYLN5WMEPuc
         fFVvLWjepQk7UuIFmSRlkGKdGsk+rJ+lzZ24sqTOLc9Tjw456rE81eE9witDSba6cMbi
         VQX5f1glqCbo2DNfZnnosBXVg39W4PCRNalmDADK19XZz6z13z9X1O61EdAFStjJbH7h
         1lT+T6+IpSWxB54ZmB54TX4OYFc0MTKyskX19xaIHfUmXgRrQoYeYh+AXjMWAKEAUXqB
         h43w==
X-Gm-Message-State: AAQBX9czvlgrc51FfXelsh5XzQWT/viBUVMrFOPYOzNq0UWvsY9mYc4d
	l77u3RvFd3PiTtK2pFN3nvl0Rw==
X-Google-Smtp-Source: AKy350aovuBtBSBhgq3cs0QgLaotqGZ3T0OPKfaP9SlotfkyH/PFu8C1sGDXBLGCzB3bk2u933Z3tQ==
X-Received: by 2002:a17:906:82cb:b0:91f:c7e:22ba with SMTP id a11-20020a17090682cb00b0091f0c7e22bamr202964ejy.27.1680887657574;
        Fri, 07 Apr 2023 10:14:17 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id f21-20020a1709067f9500b00947abb70c93sm2210482ejr.112.2023.04.07.10.14.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 10:14:17 -0700 (PDT)
Message-ID: <4afcb9b4-0bcf-97b9-0019-e958895568a9@tessares.net>
Date: Fri, 7 Apr 2023 19:14:16 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH mptcp-next v2 1/2] selftests: mptcp: join: avoid using
 'cmp --bytes'
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20230404-mptcp-selftests-join-busybox-shellcheck-v2-0-9113fa4d2ce2@tessares.net>
 <20230404-mptcp-selftests-join-busybox-shellcheck-v2-1-9113fa4d2ce2@tessares.net>
 <fd34566a70fdfaed72644e6b13c635058b833bce.camel@redhat.com>
 <208afa12-9ff7-a4cf-ffdf-71bfc82194a9@tessares.net>
 <2088a3dd668887cfa67d78a4b0c2ec2e349258af.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <2088a3dd668887cfa67d78a4b0c2ec2e349258af.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 07/04/2023 18:29, Paolo Abeni wrote:
> On Fri, 2023-04-07 at 15:35 +0200, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 07/04/2023 15:30, Paolo Abeni wrote:
>>> On Tue, 2023-04-04 at 18:21 +0200, Matthieu Baerts wrote:
>>>> BusyBox's 'cmp' command doesn't support the '--bytes' parameter.
>>>>
>>>> Some CIs -- i.e. LKFT -- use BusyBox and have the mptcp_join.sh test
>>>> failing [1] because their 'cmp' command doesn't support this '--bytes'
>>>> option:
>>>>
>>>>     cmp: unrecognized option '--bytes=1024'
>>>>     BusyBox v1.35.0 () multi-call binary.
>>>>
>>>>     Usage: cmp [-ls] [-n NUM] FILE1 [FILE2]
>>>>
>>>> Instead, 'head --bytes' can be used as this option is supported by
>>>> BusyBox.
>>>>
>>>> Because it is apparently quite common to use BusyBox, it is certainly
>>>> better to backport this fix to impacted kernels.
>>>>
>>>> Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose test-cases")
>>>> Link: https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.3-rc5-5-g148341f0a2f5/testrun/16088933/suite/kselftest-net-mptcp/test/net_mptcp_userspace_pm_sh/log [1]
>>>> Suggested-by: Paolo Abeni <pabeni@redhat.com>
>>>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>>>> ---
>>>> v2:
>>>>  - limit the input file, not the output of cmp...
>>>>    (strange that on my side, I didn't reproduce the issue but the CI did)
>>>> ---
>>>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 +++++++++++--
>>>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>>> index fafd19ec7e1f..bb26c406f09c 100755
>>>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>>>> @@ -378,9 +378,14 @@ check_transfer()
>>>>  			fail_test
>>>>  			return 1
>>>>  		fi
>>>> -		bytes="--bytes=${bytes}"
>>>> +
>>>> +		# note: BusyBox's "cmp" command doesn't support --bytes
>>>> +		head --bytes="$bytes" "$in" > "$in.cut"
>>>> +		head --bytes="$bytes" "$out" > "$out.cut"
>>>> +		in="$in.cut"
>>>> +		out="$out.cut"
>>>>  	fi
>>>> -	cmp -l "$in" "$out" ${bytes} | while read -r i a b; do
>>>> +	cmp -l "$in" "$out" | while read -r i a b; do
>>>>  		local sum=$((0${a} + 0${b}))
>>>>  		if [ $check_invert -eq 0 ] || [ $sum -ne $((0xff)) ]; then
>>>>  			echo "[ FAIL ] $what does not match (in, out):"
>>>> @@ -394,6 +399,10 @@ check_transfer()
>>>>  		fi
>>>>  	done
>>>>  
>>>> +	if [ -n "$bytes" ]; then
>>>> +		rm -f "$in" "$out"
>>>> +	fi
>>>
>>> I think it would be better additionally remove the above files in
>>> cleanup(), too.
>>
>> Thank you for this review!
>>
>> Should I maybe instead override the files? So have this above:
>>
>> +		head --bytes="$bytes" "$in" > "$in.cut"
>> +		head --bytes="$bytes" "$out" > "$out.cut"
>> +		mv "$in.cut" "$in"
>> +		mv "$out.cut" "$out"
>>
>> Then I don't need to make sure these specific files are really cleaned
>> up. We don't use these files after if I'm not mistaken.
> 
> I took to me validate the above, but I think you are right: should not
> be used later.
> 
> Note that if the script is interrupted after:
> 
> head --bytes="$bytes" "$in" > "$in.cut"
> 
> and before:
> 
> mv "$out.cut" "$out"

you really need not to be lucky :-P

> the truncated files will be leaked anyway, so perhaps the cleanup()
> function is the more straight forward solution?!?

I can but then we can also have issue before:

	sin=$(mktemp)
	sout=$(mktemp)
	cin=$(mktemp)
	cinsent=$(mktemp)
	cout=$(mktemp)
	evts_ns1=$(mktemp)
	evts_ns2=$(mktemp)

	trap cleanup EXIT

If the script is unlikely interrupted before the cleanup trap, some
files will not be removed.

But yes, I can add the "rm" in the cleanup function.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
