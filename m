Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD4B811E0
	for <mptcp@lists.linux.dev>; Wed, 22 May 2024 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716371450; cv=none; b=qpoReioNkhZyc2W3AyDNIcYd2izHIm/yzvuu8sRF1zfCpXxMs0SliT2ZCfZqIWyhserNaFyA9HhikRcjGInPREYEyiSliFLPIPkA3mZLuhdtGCMWRy0yKwGiPb8LZBs8C2roKU6JPY9k5Nrbwv5pSnQbB6KJIdjt4UgNoAnU650=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716371450; c=relaxed/simple;
	bh=Nvq/JM+0YZNW+5yJfocLZb1g/NBmldxCKcIzpIGPuIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ez528B24at41292KeOftJyVToaEXwqBPTl+XB5KQObcNNuhdnC7lpkZUu7H0LdiC5kiJsCbezjoVBbo8GUmF0d6swXwSDobqxm7JrFnYzJsYTGw6yqseL/DGJxGhlYqBlQxfyJc10vKvoBx+6r85U1DHf5dNbVD4WkeV95Ijoh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPZ87ped; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPZ87ped"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B20C2BD11;
	Wed, 22 May 2024 09:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716371449;
	bh=Nvq/JM+0YZNW+5yJfocLZb1g/NBmldxCKcIzpIGPuIY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qPZ87pedPNuNc2kYzwG64+BQ2z+FSnS/aCfj0qV+UKlR9NGSGyHBHK7aPpyoxCd6E
	 8n9qyuf8sN1Ad4iFeF4+coc9GlpRcKcl/klqXCWYd4Zn3IHxQKSQYejv9EMCf86+/p
	 ctbL0m4V1J21jhLPGLumGb7YCIe1+rBfQAB1aVlbFaw2ZV90mWhUWCRhk7D2b0/qQP
	 3rYtjLypUl4lwgIb8TLWUWALVSqAQFveagDG9xYK7+NThT5lYvivooMOHvpBRBVTrp
	 hEWxi2GeYqd3ANHlP/gDRXIHXXXAThDsh0SDQ5YaPctHDzAvEa2n8HJbm/qjyJLckG
	 y9gKHL7Ge2YPA==
Message-ID: <210bb3ad-2092-441b-8295-8d78e58f3239@kernel.org>
Date: Wed, 22 May 2024 11:50:47 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v2 1/4] selftests: mptcp: lib: support flaky
 subtests
Content-Language: en-GB
To: Mat Martineau <martineau@kernel.org>
Cc: mptcp@lists.linux.dev
References: <20240521-selftests-mptcp-disable-flaky-v2-0-eba143bcbad0@kernel.org>
 <20240521-selftests-mptcp-disable-flaky-v2-1-eba143bcbad0@kernel.org>
 <3a5062b1-98aa-77fe-a3ee-331456de7388@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <3a5062b1-98aa-77fe-a3ee-331456de7388@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mat,

Thank you for the review!

On 22/05/2024 02:27, Mat Martineau wrote:
> On Tue, 21 May 2024, Matthieu Baerts (NGI0) wrote:
> 
>> Some subtests can be unstable, failing once every X runs. Fixing them
>> can take time: there could be an issue in the kernel or in the subtest,
>> and it is then important to do a proper analysis, not to hide real bugs.
>>
>> To avoid creating noises on the different CIs, it is important to have a
>> simple way to mark subtests as flaky, and ignore the errors. This is
>> what this patch introduces: subtests can be marked as flaky by setting
>> MPTCP_LIB_SUBTEST_FLAKY env var to 1, e.g.
>>
>>  MPTCP_LIB_SUBTEST_FLAKY=1 <run flaky subtest>
>>
>> The subtest will be executed, and errors (if any) will be ignored. It is
>> still good to run these subtests, as it exercises code, and the results
>> can still be useful for the on-going investigations.
>>
>> Note that the MPTCP CI will continue to track these flaky subtests, and
>> a ticket should be created before marking a subtest as flaky.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> tools/testing/selftests/net/mptcp/mptcp_lib.sh | 38 ++++++++++++++++++
>> ++------
>> 1 file changed, 29 insertions(+), 9 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/
>> testing/selftests/net/mptcp/mptcp_lib.sh
>> index ad2ebda5cb64..44febbc11131 100644
>> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
>> @@ -21,6 +21,7 @@ declare -rx MPTCP_LIB_AF_INET6=10
>>
>> MPTCP_LIB_SUBTESTS=()
>> MPTCP_LIB_SUBTESTS_DUPLICATED=0
>> +MPTCP_LIB_SUBTEST_FLAKY=0
>> MPTCP_LIB_TEST_COUNTER=0
>> MPTCP_LIB_TEST_FORMAT="%02u %-50s"
>> MPTCP_LIB_IP_MPTCP=0
>> @@ -41,6 +42,18 @@ else
>>     readonly MPTCP_LIB_COLOR_RESET=
>> fi
>>
>> +# SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES env var can be set when
>> validating all
>> +# features using the last version of the kernel and the selftests to
>> make sure
>> +# a test is not being skipped by mistake.
>> +mptcp_lib_expect_all_features() {
>> +    [ "${SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES:-}" = "1" ]
>> +}
> 
> Hi Matthieu -
> 
> This is overloading SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES to also
> override any "flaky" flags, and treat those tests normally, correct?

Correct.

> I think it's preferable to add an environment varaible specific to this
> (like SELFTESTS_MPTCP_LIB_OVERRIDE_FLAKY), what do you think?

Sure: I initially started to do that, then I thought "expecting all
features" also means "expecting all tests to work" somehow, but I agree
it is not clear. I will add a new dedicated env var in the v3 (and
target mptcp-net), and set it on the CI side as well.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

