Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF754C79
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 13:35:29 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-50240a3b7fcso2129050a12.0
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 06:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680874528;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Q9rplGn8yL7DfHf0xnLtcsyNWBY6wDdYIccJFXgPhw=;
        b=TqLmrBf4itdub/3RUal+SyeL4ElZrZLL7TnAVBj2o69B6YDSI7kncCcWWZnOCE8vVK
         gs1527EpPJUONqyWqkLwGUJ4jQ663z9TsXwRR9C0y9HqJuRQqY5AIdLEISvh66uEfxiW
         HvPYG54qNNAFaKtorcZQqupqBPCcmQ4Ql4VLTZ+Wt+u9df9mkjPdtACujHS5P3WUuYCr
         mMte2Ta1T/fsMCUjGQX534fzwPe33iXPP2f8XIlmrU57P3/C8ODAoV+7Myc+S0zi+Dii
         7+hi870H5x/tN05vFPTq+1kPpHeTqOm/+WjNEjSZbxrFcMn1fXV9kKPz3II1fqILukYi
         l0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680874528;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Q9rplGn8yL7DfHf0xnLtcsyNWBY6wDdYIccJFXgPhw=;
        b=3zJxkzRalSj0Fts9qyx7b0j8LDnotfyOkJ10QAMtn6tV7CWhUAxR179J4vtXfKJOgX
         Z8BQk2Pys+2eEGZUmwpIf+y4GF3/D1LzM+BL+BXinpo8uhFvrMm+f7KbnRuD9RVa9E1q
         W++l07SOywzIApyJ3MSHfiiUaDE6UxX3MullqfqCJlSYCjtrvDOCqtDLGj4bjOWQlsS+
         9sfbGrCpR+tvAnRSfYGlHCmvV55PDulHjjTydtVOZRwA8oLDpIJQDtIoGNpn1Q2uLWPv
         07GS6aURiyEUz73v4DmRv2upUYTUQCKdlaL/geJeKmMs3ThDL5iYE/60OfNQOxXOV+KS
         128Q==
X-Gm-Message-State: AAQBX9fBDSXAiEe12yxMnsOd1Fx1+0FPBQePyskKDNOi8tcTmKx0ZHeT
	ejfanoavlkhK4TBY5rCulqbz4Up/FEN3WwYjdZV55w==
X-Google-Smtp-Source: AKy350YBAse926mRb/NUgq7tueWAAA6RGXxSx6vnCSZP9vm9vUtwthpp8uNAfYVq8hMOOTxVQI0FQA==
X-Received: by 2002:aa7:dcc4:0:b0:504:81bb:5396 with SMTP id w4-20020aa7dcc4000000b0050481bb5396mr387818edu.4.1680874527877;
        Fri, 07 Apr 2023 06:35:27 -0700 (PDT)
Received: from [10.44.2.5] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id mf21-20020a170906cb9500b009495cfe446esm2081034ejb.223.2023.04.07.06.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 06:35:27 -0700 (PDT)
Message-ID: <208afa12-9ff7-a4cf-ffdf-71bfc82194a9@tessares.net>
Date: Fri, 7 Apr 2023 15:35:26 +0200
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
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <fd34566a70fdfaed72644e6b13c635058b833bce.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 07/04/2023 15:30, Paolo Abeni wrote:
> On Tue, 2023-04-04 at 18:21 +0200, Matthieu Baerts wrote:
>> BusyBox's 'cmp' command doesn't support the '--bytes' parameter.
>>
>> Some CIs -- i.e. LKFT -- use BusyBox and have the mptcp_join.sh test
>> failing [1] because their 'cmp' command doesn't support this '--bytes'
>> option:
>>
>>     cmp: unrecognized option '--bytes=1024'
>>     BusyBox v1.35.0 () multi-call binary.
>>
>>     Usage: cmp [-ls] [-n NUM] FILE1 [FILE2]
>>
>> Instead, 'head --bytes' can be used as this option is supported by
>> BusyBox.
>>
>> Because it is apparently quite common to use BusyBox, it is certainly
>> better to backport this fix to impacted kernels.
>>
>> Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose test-cases")
>> Link: https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.3-rc5-5-g148341f0a2f5/testrun/16088933/suite/kselftest-net-mptcp/test/net_mptcp_userspace_pm_sh/log [1]
>> Suggested-by: Paolo Abeni <pabeni@redhat.com>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>> v2:
>>  - limit the input file, not the output of cmp...
>>    (strange that on my side, I didn't reproduce the issue but the CI did)
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index fafd19ec7e1f..bb26c406f09c 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -378,9 +378,14 @@ check_transfer()
>>  			fail_test
>>  			return 1
>>  		fi
>> -		bytes="--bytes=${bytes}"
>> +
>> +		# note: BusyBox's "cmp" command doesn't support --bytes
>> +		head --bytes="$bytes" "$in" > "$in.cut"
>> +		head --bytes="$bytes" "$out" > "$out.cut"
>> +		in="$in.cut"
>> +		out="$out.cut"
>>  	fi
>> -	cmp -l "$in" "$out" ${bytes} | while read -r i a b; do
>> +	cmp -l "$in" "$out" | while read -r i a b; do
>>  		local sum=$((0${a} + 0${b}))
>>  		if [ $check_invert -eq 0 ] || [ $sum -ne $((0xff)) ]; then
>>  			echo "[ FAIL ] $what does not match (in, out):"
>> @@ -394,6 +399,10 @@ check_transfer()
>>  		fi
>>  	done
>>  
>> +	if [ -n "$bytes" ]; then
>> +		rm -f "$in" "$out"
>> +	fi
> 
> I think it would be better additionally remove the above files in
> cleanup(), too.

Thank you for this review!

Should I maybe instead override the files? So have this above:

+		head --bytes="$bytes" "$in" > "$in.cut"
+		head --bytes="$bytes" "$out" > "$out.cut"
+		mv "$in.cut" "$in"
+		mv "$out.cut" "$out"

Then I don't need to make sure these specific files are really cleaned
up. We don't use these files after if I'm not mistaken.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
