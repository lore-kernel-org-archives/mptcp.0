Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C89646AD
	for <mptcp@lists.linux.dev>; Mon,  4 Mar 2024 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550762; cv=none; b=h1JkX6SMc0xfU9lhcoRnyd5sya8ZER84kI5UHbOpo5C3o+JY4VHj9NLQGed87vnTQctjDcwkEE3RwsXc4sOL/PWX+u33R7Jmm/VS4RTb4isefBpkKvnSIgQAz3jNW7qY5yfRyUXaB3/2P6DvRlxQhlb8zLKLz1Lqd0XTXS5hw0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550762; c=relaxed/simple;
	bh=dfobZDgLr/X5T7GHxkTw1GuKe0SaVHCeKB+/34F9Vyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwWMRrEDQ4RVu8vEL/TpZh+AhzhfTnLTHAdmHR/WHCd7PadOlNM6KNm5KSg9IpA+THR5qikU6nKwDq4gsHHQ55jJbzmNlWs8Xtvt41oRmmgsiqoDHXJyFC4aAYzXyo/AbnezmV8+hQcOMeTUx/fg0S0KSjwIeR16SQ6ocayA/p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cb8VN88E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cb8VN88E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2746C433C7;
	Mon,  4 Mar 2024 11:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709550761;
	bh=dfobZDgLr/X5T7GHxkTw1GuKe0SaVHCeKB+/34F9Vyo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cb8VN88EcJL4Rxm6mapkVWtszdEPiU0RrwdBHDSHSoJ8Anqs5yXgPz53g6hQZdAsD
	 mClu2bdx9OjzBJRC3tp0H/3f9SMlctlQRx5b8+46dxydmUu1wu01JI2caVTJXbTNUc
	 rig7lBQdWDhAA0v0kfV+7NTKyyhhB31wwCAo6KpOApXDMkWhoRRboCtBMuYxy0zVIg
	 jQLZjOJzgc30DXHXCWnrcmI4WWgy8Rj1BsLv3xbhjcfdfEJRMqZY6w3VFjvz9SfJHe
	 E76mPK6fJdDPuxyus/lRzSXeGHMmtBI3solowMc05GqX2hGAKPA+l02HgHtiuCYoz2
	 Vd7Y7EAmexVmA==
Message-ID: <acc54b80-f14a-4803-a171-bf92c5d0b98c@kernel.org>
Date: Mon, 4 Mar 2024 12:12:39 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v7 8/8] selftests: mptcp: print test results
 with colors
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1709200070.git.tanggeliang@kylinos.cn>
 <81fd6204fc60dd90a4410b3435ab4552402b71c0.1709200070.git.tanggeliang@kylinos.cn>
 <409065cf-bab0-413b-8533-0b80b28862d4@kernel.org>
 <8f8665ba6e41497e0b5f90ec3022cf69abbc0037.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <8f8665ba6e41497e0b5f90ec3022cf69abbc0037.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 01/03/2024 08:16, Geliang Tang wrote:
> On Thu, 2024-02-29 at 14:04 +0100, Matthieu Baerts wrote:
>> On 29/02/2024 10:51, Geliang Tang wrote:
>>> From: Geliang Tang <tanggeliang@kylinos.cn>
>>>
>>> To unify the output formats of all test scripts, this patch adds
>>> four more helpers:
>>>
>>> 	mptcp_lib_pr_ok()
>>> 	mptcp_lib_pr_skip()
>>> 	mptcp_lib_pr_fail()
>>> 	mptcp_lib_pr_info()
>>>
>>> to print out [ OK ], [SKIP], [FAIL] and 'INFO: ' with colors. Use
>>> them
>>> in all scripts to print the "ok/skip/fail/info' using the same
>>> 'format'.
>>>
>>> Having colors helps to quickly identify issues when looking at a
>>> long
>>> list of output logs and results.
>>>
>>> Note that the mptcp_join.sh tests will now print these keywords
>>> with
>>> capital letters, like most of the other tests.
>>
>> I think it is not just mptcp_join.sh that was using different
>> keywords.
>>
>>   Note that now all print the same keywords, which was not the case
>>   before, but it is good to uniform that.
>>
>> (...)
>>
>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>>> b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>>> index 096ff8941c5b..70acbb19f568 100755
>>> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
>>
>> (...)
>>
>>> @@ -534,7 +534,6 @@ do_transfer()
>>>  			"${expect_ackrx}" "${stat_ackrx_now_l}"
>>>  	fi
>>>  
>>> -	echo
>>
>> Just to be sure: do we still have something good in case of error?
>>
>> I mean: why were we not printing a new line before? Maybe there was
>> no
>> reason, or maybe sometimes we print more details? (syn cookies?)
>>
>> Maybe that's fine with the new output, it is just to know if you
>> checked
>> that.
> 
> This 'echo' does need to be dropped. Here use mptcp_lib_pr_ok instead
> of 'printf "[ OK ]"'. 'printf "[ OK ]"' needs a new line but
> mptcp_lib_pr_ok don't need:

Yes, but my point was: I guess there was a reason to have:

  print "[ OK ]"

  (...)

  echo

and not just one line with:

  echo "[ OK ]"


After a quick look, it looks like that's because we want to add info
depending on some conditions, see all the "WARN" messages in between.

I guess we should instead move the "pr_ok" to the end, something like:


  local extra

  (...)

  ### <= the 'printf [ OK ]' was here, now moved to the end ↓

  if (...); then
      extra+=" WARN (...)"
  fi

  (...)

  if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
      mptcp_lib_pr_ok "${extra:1}"
      mptcp_lib_result_pass "${TEST_GROUP}: ${result_msg}"
  else
      if [ -n "${extra}" ]; then
          mptcp_lib_print_warn "${extra:1}"
      fi
      mptcp_lib_result_fail "${TEST_GROUP}: ${result_msg}"
  fi

  cat "$capout"
  [ $retc -eq 0 ] && [ $rets -eq 0 ]


no?

> 
>  	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
> -		printf "[ OK ]"
> +		mptcp_lib_pr_ok
>  		mptcp_lib_result_pass "${TEST_GROUP}: ${result_msg}"
>  	else
>  		mptcp_lib_result_fail "${TEST_GROUP}: ${result_msg}"
> @@ -540,7 +540,6 @@  do_transfer()
>  			"${expect_ackrx}" "${stat_ackrx_now_l}"
>  	fi
>  
> -	echo
>  	cat "$capout"
> 
>>
>>>  	cat "$capout"
>>>  	[ $retc -eq 0 ] && [ $rets -eq 0 ]
>>>  }
>>
>> (...)
>>
>>> @@ -810,7 +809,7 @@ log_if_error()
>>>  	local msg="$1"
>>>  
>>>  	if [ ${ret} -ne 0 ]; then
>>> -		echo "FAIL: ${msg}" 1>&2
>>> +		mptcp_lib_pr_fail "${msg}"
>>
>> Good to mention in the commit message that all errors messages are
>> printed to 'stdout' now, as part of the uniformation. (or do that in
>> an
>> dedicated commit)
> 
> A new commit added in v9.

Thanks!

>>
>>>  
>>>  		final_ret=${ret}
>>>  		ret=0
>>> @@ -858,11 +857,11 @@ done
>>>  mptcp_lib_result_code "${ret}" "ping tests"
>>>  
>>>  stop_if_error "Could not even run ping tests"
>>> -echo "[ OK ]"
>>> +mptcp_lib_pr_ok
>>>  MPTCP_LIB_TEST_FORMAT="%02u %-50s"
>>>  
>>>  [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root
>>> netem loss random $tc_loss delay ${tc_delay}ms
>>> -echo -n "INFO: Using loss of $tc_loss "
>>
>> Here, it was using 'echo -n' ...
> 
> I keep this 'echo -n' unchanged.

You don't use pr_info with the appended message, as suggested below?

> 
>>
>>> +mptcp_lib_pr_info "Using loss of $tc_loss "
>>
>> Now a new line will be printed at the end (with a trailing
>> whitespace)
>>
>>>  test "$tc_delay" -gt 0 && echo -n "delay $tc_delay ms "
>>
>> And this will be printed in a new line, it will look strange I think
>>
>> Maybe use a variable to store all the info?
>>
>>   tc_info="loss of $tc_loss "
>>   test "$tc_delay" -gt 0 && tc_info+="delay $tc_delay ms "
>>   (...)
>>   mptcp_lib_pr_info "Using ${tc_info}"
>>
>>>  
>>>  reorder_delay=$((tc_delay / 4))
>>
>> (...)
>>
>>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>>> b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>>> index 358d5b77fc0f..53867f9d212d 100644
>>> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>>> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>>> @@ -48,6 +48,23 @@ mptcp_lib_print_err() {
>>>  	mptcp_lib_print_color "${MPTCP_LIB_COLOR_RED}${*}"
>>>  }
>>>  
>>> +#shellcheck disable=SC2120
>>
>> Add a space after '#' and add a comment justifying the exception,
>> like
>> the one I shared in patch 1/9 from v6:
>>
>>   # shellcheck disable=SC2120  # parameters are optional
>>
>> Out of curiosity, we don't need this for 'skip' and 'fail'?
> 
> Not a single parameter was passed to mptcp_lib_pr_ok at a time.
> But 'skip' or 'fail' sometimes has parameters passed in.

OK, I see. It is just strange to put it only on one, and it would not
hurt to put it on the others as well, but OK, anyway a false positive
from shellcheck.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
