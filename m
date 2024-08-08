Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40B414A09F
	for <mptcp@lists.linux.dev>; Thu,  8 Aug 2024 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723112542; cv=none; b=Pnrpg9Jen8oIFOl1e6xUH7iWQSJip6I37mSaQtoPoLF+aZ4h/etiu+SXBkDPb/J8RXyzyUcbJTt9LJlS3QfOaKIkkx4+88zQ+Ggbq7vk/7t1ugXik2d4noKKYIoKY/cFzao2EBVuPhvt0SlYoeGiJ7ZhB0RPlZ2SMS56yEVsP6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723112542; c=relaxed/simple;
	bh=pf63nByEH4KLnm90tD6HgCuasXtVLISX161CYjoZzKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h+UklyV2ncStav1juJA9RLAP22FATfVIJFYiBAz8AIzSltuo137jzfIOhfi13wIvWGfReia20YdxxGuciiCfYe3eo09eHz3uZxUYiK9YEpV5Q1nkdEdSwFIJL503EdnggxWNGleSKdgbZTnc8ZO2DOWKuzDXsgU2EGIfntAfoyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGz+VGU2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGz+VGU2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42222C32782;
	Thu,  8 Aug 2024 10:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723112541;
	bh=pf63nByEH4KLnm90tD6HgCuasXtVLISX161CYjoZzKo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=WGz+VGU2zMVmvED64S+wObE83rP+eRi+4ge2/oY9ffIrheec9OXWN2W3/C34jNiJA
	 Eny/2e5Q2VjGeeXNk+K+eqMZRMzXEoxCnD/X3au7cznJ9VcPreQo9kY3rbuU6rME1k
	 /mAMWb03gD8zML/WHU/4Vl55kEJlQfqOiGvbMLpocW6fj8ygED+oOCUgzDEavLEzTz
	 CSrfTjk0ppiCwPBQX5Wf47wwNNmphcWMJUkgES1N6EFEHUKKrk75t6DNHLFKfuVQMo
	 g0+vn9qN++Xc1NRT9r2Nigsgj/XFi9XDrPSVPncCAdPIBqNzlXMIvz4gTBcsDpUTTP
	 iMpcnkAwXissQ==
Message-ID: <2743512d-4772-4e42-9abd-6849c36f1885@kernel.org>
Date: Thu, 8 Aug 2024 12:22:19 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v3 3/8] selftests: mptcp: join: reduce join_nr
 params
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20240806-mptcp-join-tx-mib-v3-0-c3b54d2099e9@kernel.org>
 <20240806-mptcp-join-tx-mib-v3-3-c3b54d2099e9@kernel.org>
 <23fc6138bd31d81783683cf041fbf75e8280a204.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <23fc6138bd31d81783683cf041fbf75e8280a204.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 08/08/2024 05:28, Geliang Tang wrote:
> On Tue, 2024-08-06 at 13:18 +0200, Matthieu Baerts (NGI0) wrote:
>> chk_join_nr() currently takes 9 positional parameters, 6 of them are
>> optional. It makes it hard to read:
>>
>>   chk_join_nr 1 1 1 1 0 1 1 0 4
>>
>> Naming these vars helps to make it easier to read:
>>
>>   join_csum_ns1=1 join_csum_ns2=0 \
>>     join_fail_nr=1 join_rst_nr=1 join_infi_nr=0 \
>>     join_corrupted_pkts=4 \
>>     chk_join_nr 1 1 1
>>
>> It will then be easier to add new optional parameters.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 31
>> ++++++++++++++++++-------
>>  1 file changed, 22 insertions(+), 9 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index a1f80dac59a7..0401ba1aaf1b 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -61,6 +61,12 @@ unset sflags
>>  unset fastclose
>>  unset fullmesh
>>  unset speed
>> +unset join_csum_ns1
>> +unset join_csum_ns2
>> +unset join_fail_nr
>> +unset join_rst_nr
>> +unset join_infi_nr
>> +unset join_corrupted_pkts
>>  
>>  # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
>>  #				  (ip6 && (ip6[74] & 0xf0) ==
>> 0x30)'"
>> @@ -1314,12 +1320,12 @@ chk_join_nr()
>>  	local syn_nr=$1
>>  	local syn_ack_nr=$2
>>  	local ack_nr=$3
>> -	local csum_ns1=${4:-0}
>> -	local csum_ns2=${5:-0}
>> -	local fail_nr=${6:-0}
>> -	local rst_nr=${7:-0}
>> -	local infi_nr=${8:-0}
>> -	local corrupted_pkts=${9:-0}
>> +	local csum_ns1=${join_csum_ns1:-0}
>> +	local csum_ns2=${join_csum_ns2:-0}
>> +	local fail_nr=${join_fail_nr:-0}
>> +	local rst_nr=${join_rst_nr:-0}
>> +	local infi_nr=${join_infi_nr:-0}
>> +	local corrupted_pkts=${join_corrupted_pkts:-0}
>>  	local count
>>  	local with_cookie
>>  
>> @@ -3138,7 +3144,8 @@ fastclose_tests()
>>  		MPTCP_LIB_SUBTEST_FLAKY=1
>>  		test_linkfail=1024 fastclose=server \
>>  			run_tests $ns1 $ns2 10.0.1.1
>> -		chk_join_nr 0 0 0 0 0 0 1
>> +		join_rst_nr=1 \
>> +			chk_join_nr 0 0 0
>>  		chk_fclose_nr 1 1 invert
>>  		chk_rst_nr 1 1
>>  	fi
>> @@ -3157,7 +3164,10 @@ fail_tests()
>>  		MPTCP_LIB_SUBTEST_FLAKY=1
>>  		test_linkfail=128 \
>>  			run_tests $ns1 $ns2 10.0.1.1
>> -		chk_join_nr 0 0 0 +1 +0 1 0 1 "$(pedit_action_pkts)"
>> +		join_csum_ns1=+1 join_csum_ns2=+0 \
>> +			join_fail_nr=1 join_rst_nr=0 join_infi_nr=1
>> \
> 
> Can we drop this "join_rst_nr=0"?

We could, but I prefer not: I think it is better to specify all
variables here, to make it clear we expect no RST, compared to the next
test where instead we expect an infinite mapping. It is easier to
compare the expectations from the two tests.

It is different from the 'fastclose_tests()' test, where it is just an
exception there, just one test where there is a rst.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

