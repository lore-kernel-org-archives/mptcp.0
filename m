Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C26CE55E
	for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 14:41:38 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-51d9865b7bdso1997476a12.1
        for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 07:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688136097; x=1690728097;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mG3mRNISzvY5WqhEi7QxPX8Y6CSqzGl7WDKHPTIyQMU=;
        b=We85pHOs9u68GqsHDPmxL0q3rtScB80J1t5n+VjBStOX4QEm5aTk6GDhYiqhag4sDb
         IRy/IBKSG9JS2WseEYg3TRy0UKWH/+O9eYs9u0f6NUhLf6gUZdEgvVgaPNOTlG5PH5qz
         gId6Y6927nqIBDnzhNH1lV5XH0ChwyGu+k89AEj8RKLu1ABl2lc69r1drkeqEYsa4SzB
         gOc1dDL0h64ZnkyNUk0OvzajjiWj9uDEKxen6U291VxJpxj8sCktSUHdHTSpn+pxf3mq
         fvfurwclLu3g8UbdWohW7fBc/Rdd9DPgP+z3EpG+O0wukXgPc2TA3ASi6Zop7h9b9nK0
         iFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688136097; x=1690728097;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mG3mRNISzvY5WqhEi7QxPX8Y6CSqzGl7WDKHPTIyQMU=;
        b=AS/KYs/6ekt7MUlWueNUWK5k+euvrQugF6hPRAbJ44zEbtvSxb7M7TICCfMSz+tGNw
         dMh/TWOCPwWUbz6Uu166cxqjjphjBdkwxXp44CpXB9yNmehPfytzmXGaUWk3zwJw/Iif
         mlBEubRZ6sIzw+CF1s8ssTkJl+G7WgZSip0sfnmMuMNxXcJVZctl7/qSPh1APJ2A0qQQ
         Gj9dgKRFN26rzKXPYrvFq8GeKOAytVfBVPVkOqNCJ/IqXDFT8PWM40X1LAiR5sKS0Ety
         kJHIFJlR3PU3SFF6E4o+BOcE3tF465Mb+lrba3Bkg7RviL8pbNL9lMH7fjTPWDUMxcII
         wFxw==
X-Gm-Message-State: ABy/qLaXIJfONQ8So1aY5PXBhzEgBXdJqGUXyhx6FrjpLzgiYYC3fLLb
	TSPM9NeQspuivY++TKfHr05smhrdDdxduG5oYHr0o0pa
X-Google-Smtp-Source: APBJJlHx2gOtjr1qezn6B6kbo0AoLE6en9uqAYktFPQuUAWtwDm2/CBribKKjlQyrzg9SnvvFDcuZw==
X-Received: by 2002:a05:6402:1812:b0:51d:f813:fd28 with SMTP id g18-20020a056402181200b0051df813fd28mr536809edy.35.1688136096903;
        Fri, 30 Jun 2023 07:41:36 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id w1-20020a50fa81000000b0051df67eaf62sm358926edr.42.2023.06.30.07.41.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 07:41:36 -0700 (PDT)
Message-ID: <a7d7b29d-625d-46ef-06b7-4d31bb90a8a7@tessares.net>
Date: Fri, 30 Jun 2023 16:41:36 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next 06/18] selftests: mptcp: connect: don't stop if
 error
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
 <20230621-mptcp-issue-368-selftests-subtests-v1-6-0cae453ae1fa@tessares.net>
 <76ee3a32adb98108a88c81babcfbb9cf3edd724c.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <76ee3a32adb98108a88c81babcfbb9cf3edd724c.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/06/2023 12:52, Paolo Abeni wrote:
> browsers! ;)
> On Wed, 2023-06-21 at 19:18 +0200, Matthieu Baerts wrote:
>> No more tests were executed after a failure but it is still interesting
>> to get results for all the tests to better understand what's still OK
>> and what's not after a modification.
>>
>> Now we only exit earlier if the basic tests are failing: no ping going
>> through namespaces or unable to transfer data on the loopback interface.
>>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_connect.sh | 27 ++++++++++++++++------
>>  1 file changed, 20 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>> index 780b8fef2261..dba58875ef4c 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>> @@ -7,6 +7,7 @@ time_start=$(date +%s)
>>  
>>  optstring="S:R:d:e:l:r:h4cm:f:tC"
>>  ret=0
>> +final_ret=0
>>  sin=""
>>  sout=""
>>  cin_disconnect=""
>> @@ -837,14 +838,25 @@ display_time()
>>  	echo "Time: ${time_run} seconds"
>>  }
>>  
>> -stop_if_error()
>> +log_if_error()
>>  {
>>  	local msg="$1"
>>  
>>  	if [ ${ret} -ne 0 ]; then
>>  		echo "FAIL: ${msg}" 1>&2
>> +
>> +		final_ret=${ret}
>> +		ret=0
>> +
>> +		return ${final_ret}
>> +	fi
> 
> It's not clear to me which is the return value for log_if_error() in
> the '${ret} -eq 0' case.

It will be "0" because there was no command launched in this case.

> What about moving the return after the 'if' statement?

I don't think I can do that now that we have "ret" and "final_ret":
- "ret" is reset after each section when calling log_if_error(): it is
the result per section.
- "final_ret" is one we will use for the final exit: it is set to 0 at
the beginning and it can only be set to a non zero value later in case
of error. It represent the global result.

So here, in case of error, I cannot return "ret" because it is reset to
0 and if there was no error, I cannot return "final_ret" because it will
be set to 1 if there was an error in the previous section.

But I can add an explicit "return 0" if there is no error:

  if [ ${ret} -eq 0 ]; then
  	return 0

  echo "FAIL: ${msg}" 1>&2

  final_ret=${ret}
  ret=0

  return ${final_ret}

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
