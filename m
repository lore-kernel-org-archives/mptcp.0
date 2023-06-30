Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DBB16400
	for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 15:00:58 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9891c73e0fbso342715566b.1
        for <mptcp@lists.linux.dev>; Fri, 30 Jun 2023 08:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688137256; x=1690729256;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BTnTdp2Ze72oKlA23SNBEUbhM7oM+r6P2xd924ODGac=;
        b=xbEXArkY36d6BnqObTD9DNeqHgEhlZCOQd3nZAK8rvagW8Jt1Vy5ysg7nb4d7NB7fr
         hMbW111yrylPKORyuAXMAfon9C63sheO3tg54f7WHAewY2yP32VKElbyywo0ZyBBjzcC
         s0R3RMnhqhnQ5zIBzZtGMAkV7WyxSuk9ioBJ9QyKPF4+/MZDuRZTmoBYAl7KXN1KAjot
         MxMpaStvnl3rlQVYQ/UZ3kvmxV8T38BJ4pCL1aOdob60hKJuAonU3yjojudMYRiJLiZD
         GoPCRkb+ej6qcIpGYIJVIrIotwXbx7CtPRvu/cm8tGB8wFGcbhKAB4ce2y9eK5ILGBC4
         p7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688137256; x=1690729256;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BTnTdp2Ze72oKlA23SNBEUbhM7oM+r6P2xd924ODGac=;
        b=A48FKbHTzARwo7V8ZW5KwT2ErD8J/I4T97pIYHysCOEwN+Svn7Zzo0LPVFXV6rzwr8
         OtzX1rnfAMpwWVqSG35Vf+xzRzqy9LXS8TZeVw/9Z0QqacvBrEGud9SrIl8zuNtNaRfr
         5GJSc4MNj6HuVIM1Pi+Kpjnu5eSewkNwal+5Wd+7l1A9Ytq1IIyBs98IBtuzDSkIetZA
         WM5iASA8O4qsPO2gl//SO7P5dTYxp0bU2tTaIjYtrgojLZqtHKBb2JTasNo4lRKVA66u
         kKGvQTIZHdRkgroBFtXyacx47QjjBClzmaPokPhoSsX/FnBOi4TcmFQDJ7Msobggahy8
         IbOg==
X-Gm-Message-State: ABy/qLb1sm6z9km8I9t4uWB1yEEXDEAlJZ0QIy3Ugrb3QCyCwtWsesm6
	pAZ++gq5p5M0DsW1f9CvzVF75leYg6HGPyms60kuNng0
X-Google-Smtp-Source: APBJJlEkTBkPfGXq8IAaUAUqviI011BYXHEIbNrWLvaVm7BYnxBrrY8WsOWFaVaKY1UoJ36mi4szmg==
X-Received: by 2002:a17:906:830b:b0:988:15f4:fdba with SMTP id j11-20020a170906830b00b0098815f4fdbamr2883455ejx.14.1688137256344;
        Fri, 30 Jun 2023 08:00:56 -0700 (PDT)
Received: from [10.44.2.5] ([81.246.10.41])
        by smtp.gmail.com with ESMTPSA id w23-20020a17090633d700b0098cf565d98asm8020327eja.22.2023.06.30.08.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 08:00:56 -0700 (PDT)
Message-ID: <10c549f6-c83c-1a4c-415f-e2292dedb940@tessares.net>
Date: Fri, 30 Jun 2023 17:00:55 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH mptcp-next 14/18] selftests: mptcp: join: format subtests
 results in TAP
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <20230621-mptcp-issue-368-selftests-subtests-v1-0-0cae453ae1fa@tessares.net>
 <20230621-mptcp-issue-368-selftests-subtests-v1-14-0cae453ae1fa@tessares.net>
 <7dad11d32d2f6afb1f27a1a730f1976164b188b1.camel@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <7dad11d32d2f6afb1f27a1a730f1976164b188b1.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

Thank you for the reviews!

On 30/06/2023 13:08, Paolo Abeni wrote:
> On Wed, 2023-06-21 at 19:18 +0200, Matthieu Baerts wrote:
>> The current selftests infrastructure formats the results in TAP 13. This
>> version doesn't support subtests and only the end result of each
>> selftest is taken into account. It means that a single issue in a
>> subtest of a selftest containing multiple subtests forces the whole
>> selftest to be marked as failed. It also means that subtests results are
>> not tracked by CIs executing selftests.
>>
>> MPTCP selftests run hundreds of various subtests. It is then important
>> to track each of them and not one result per selftest.
>>
>> It is particularly interesting to do that when validating stable kernels
>> with the last version of the test suite: tests might fail because a
>> feature is not supported but the test didn't skip that part. In this
>> case, if subtests are not tracked, the whole selftest will be marked as
>> failed making the other subtests useless because their results are
>> ignored.
>>
>> This patch formats subtests results in TAP in mptcp_join.sh selftest.
>>
>> In this selftest and before starting each subtest, the 'reset' function
>> is called. We can then check if the previous test has passed, failed or
>> has been skipped from there.
>>
>> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
>> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 41 ++++++++++++++++++++-----
>>  1 file changed, 33 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index e6c9d5451c5b..5c5c8b5e068f 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -39,7 +39,9 @@ evts_ns1=""
>>  evts_ns2=""
>>  evts_ns1_pid=0
>>  evts_ns2_pid=0
>> -stats_dumped=0
>> +last_test_failed=0
>> +last_test_skipped=0
>> +last_test_ignored=1
>>  
>>  declare -A all_tests
>>  declare -a only_tests_ids
>> @@ -97,7 +99,6 @@ init_partial()
>>  		fi
>>  	done
>>  
>> -	stats_dumped=0
>>  	check_invert=0
>>  	validate_checksum=$checksum
>>  	FAILING_LINKS=""
>> @@ -162,9 +163,7 @@ check_tools()
>>  	elif ! iptables -V &> /dev/null; then
>>  		echo "SKIP: Could not run all tests without iptables tool"
>>  		exit $ksft_skip
>> -	fi
>> -
>> -	if ! ip6tables -V &> /dev/null; then
>> +	elif ! ip6tables -V &> /dev/null; then
> 
> The above chunk looks unrelated/unnecessary ?!? after the
> 
> 		exit $ksft_skip
> 
> above, we neither 'if' nor 'elif' will be executed ??!

It is indeed a bit unrelated, it is just a small fix. Before, we had:

  if iptables-legacy -V; then
      iptables="iptables-legacy"
      ip6tables="ip6tables-legacy"
  elif ! iptables -V; then
      exit error
  fi

  if ! ip6tables -V; then
      exit error
  fi

if iptables-legacy is available, we will use "ip6tables-legacy" command
instead of "ip6tables". So no need to look for "ip6tables" command we
will not use (hence the "elif" instead of the "if").

But I can also drop this chunk if you prefer.


>>  		echo "SKIP: Could not run all tests without ip6tables tool"
>>  		exit $ksft_skip
>>  	fi
>> @@ -213,6 +212,8 @@ mark_as_skipped()
>>  
>>  	print_title "[ skip ] ${msg}"
>>  	printf "\n"
>> +
>> +	last_test_skipped=1
>>  }
>>  
>>  # $@: condition
>> @@ -245,14 +246,32 @@ skip_test()
>>  	return 0
>>  }
>>  
>> +append_prev_results()
>> +{
>> +	if [ ${last_test_failed} -eq 1 ]; then
>> +		mptcp_lib_result_fail "${TEST_NAME}"
>> +	elif [ ${last_test_skipped} -eq 1 ]; then
>> +		mptcp_lib_result_skip "${TEST_NAME}"
>> +	elif [ ${last_test_ignored} -ne 1 ]; then
>> +		mptcp_lib_result_pass "${TEST_NAME}"
>> +	fi
>> +
>> +	last_test_failed=0
>> +	last_test_skipped=0
>> +	last_test_ignored=0
>> +}
>> +
>>  # $1: test name
>>  reset()
>>  {
>> +	append_prev_results
> 
> Can't we dump the previous sub-test result here in tap format (when/if
> enabled) instead of dumping them all at the end?

I guess we can: Linaro's script should catch the different subtests. But
I don't think we should do that: from what I understood to be TAP 13
compliant, we are supposed to write the "test plan" before displaying
the results: so we need one line indicating the number of tests that are
going to be done (e.g. "1..115") and before starting the first test, we
don't know how many tests will be executed yet.

Also, if it is printed at the end, I can easily extract this TAP 13
results into a dedicated file and feed it to a tracking system. I
already added the extraction, you can see the results in the
"tap_result" directory in cirrus-ci, e.g. for mptcp_join:

  - global (like before):
https://api.cirrus-ci.com/v1/artifact/task/6071439883763712/tap_result/selftest_mptcp_join.tap
  - subtests:
https://api.cirrus-ci.com/v1/artifact/task/6071439883763712/tap_result/selftest_mptcp_join_subtests.tap

If we want to track subtests with existing TAP parsers, I think it would
be better to keep the results at the end if that's OK.

Don't forget we can easily set SELFTESTS_MPTCP_LIB_NO_TAP=1 not to have
this output. I would recommend to put that in a zshrc/bashrc/... :)

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
