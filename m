Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC79639
	for <mptcp@lists.linux.dev>; Thu, 18 Jul 2024 11:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721300977; cv=none; b=t1KOhL0g3h8tId8QT7moMOSEoVc6yBHDEWTKE88/UDThKadB2iQ9GCF9vTV/dc1Tv1FgLIR2SLxX1utDMF4pn9pOtJkxlC11lQl6vXOck/pZjJ55omLxTXKZk0q3UyGv0+WUZFPyb0jLZWitISHRcwb4eYe/niU4rj1LY/TUFHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721300977; c=relaxed/simple;
	bh=DIYuSyPfmPJ1GdUuOnjOIJpU5cpuZO5WU/+FPbZqxN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gj6luHCgsgpVpb2LQSPf0tNFUd0nTFo4aDG6pO8m3GvTmU4gEp6mN7ym02UCaVCWp6m7Fjun7MyXhSvBOe2afiw6XZ4YxaFfAFV3hK45rTn8a/ykYxLR4Tb1LwjX3oH67/sUHJ+3GDbTbI5AxMA8kD9C41k6wLHL7txaTOtTMwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8TMuMSS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8TMuMSS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9309FC4AF09;
	Thu, 18 Jul 2024 11:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721300977;
	bh=DIYuSyPfmPJ1GdUuOnjOIJpU5cpuZO5WU/+FPbZqxN0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=j8TMuMSSXBt+oPkk/pE+hdIwSiRZz9rff5gQtbmw0cg49OafDLOUgd0G9dutKqVxh
	 CJZO7spqKPmBOQWJU+9xTcNvbjiduXyGZzNRLL2zd80sdhyw8BQ0S3jcVcy+Hfi2j0
	 DDkE6nvbjhULMiFNZrHnzDtzpCgRMMpfe32QKSYmn1iymwzlFCJ9+mJ5MTjv+U34Yv
	 Rst+7o28brfzG0myXktdAGwEYFA6zAYY3RJCjSj3brh/APCC52CSuyXwyKN2PyTvRX
	 Xwq7k8WiWBMEhFCYjd6bzCDbKMPbPz1XfbNK3hdzyC1mm9+AUtGhN9TI7GSx5IPYP9
	 X/bCdqd4cS3tQ==
Message-ID: <2a8792e5-6035-4202-8496-3f1f5c60d844@kernel.org>
Date: Thu, 18 Jul 2024 13:09:34 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-net v2 5/9] selftests: mptcp: join: validate backup
 in MPJ
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20240716-mptcp-backup-mpj-v2-0-4d50247405fb@kernel.org>
 <20240716-mptcp-backup-mpj-v2-5-4d50247405fb@kernel.org>
 <108fbeaf69fdbc390287704b7a4f4af94890d244.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <108fbeaf69fdbc390287704b7a4f4af94890d244.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 17/07/2024 03:25, Geliang Tang wrote:
> Hi Matt,
> 
> Thanks for these patches.
> 
> On Tue, 2024-07-16 at 22:53 +0200, Matthieu Baerts (NGI0) wrote:
>> A peer can notify the other one that a subflow has to be treated as
>> "backup" by two different ways: either by sending a dedicated MP_PRIO
>> notification, or by setting the backup flag in the MP_JOIN handshake.
>>
>> The selftests were previously monitoring the former, but not the
>> latter.
>> This is what is now done here by looking at these new MIB counters
>> when
>> validating the 'backup' cases:
>>
>>   MPTcpExtMPJoinSynBackupRx
>>   MPTcpExtMPJoinSynAckBackupRx
>>
>> The 'Fixes' tag here below is the same as the one from the previous
>> commit: this patch here is not fixing anything wrong in the
>> selftests,
>> but it will help to validate a new fix for an issue introduced by
>> this
>> commit ID.
>>
>> Fixes: 4596a2c1b7f5 ("mptcp: allow creating non-backup subflows")
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 42
>> +++++++++++++++++++------
>>  1 file changed, 32 insertions(+), 10 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index 55d84a1bde15..175127a9c00c 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -1634,6 +1634,8 @@ chk_prio_nr()
>>  {
>>  	local mp_prio_nr_tx=$1
>>  	local mp_prio_nr_rx=$2
>> +	local mpj_syn=$3
>> +	local mpj_syn_ack=$4
> 
> How about setting default values for them:
> 
>         local mpj_syn=${3:-0}
>         local mpj_syn_ack=${4:-0}

I prefer not to: in our existing test suite, these counters can be set,
it is then important to review all of these test cases.

I also think it is important to check them in all our backup cases.
That's why I don't want to not check them if they are not set.

> 
>>  	local count
>>  
>>  	print_check "ptx"
>> @@ -1655,6 +1657,26 @@ chk_prio_nr()
>>  	else
>>  		print_ok
>>  	fi
>> +
>> +	print_check "syn backup"
>> +	count=$(mptcp_lib_get_counter ${ns1}
>> "MPTcpExtMPJoinSynBackupRx")
>> +	if [ -z "$count" ]; then
>> +		print_skip
>> +	elif [ "$count" != "$mpj_syn" ]; then
>> +		fail_test "got $count MPJ SYN[s] with Backup
>> expected $mpj_syn"
> 
> And make this log more like the one in chk_join_nr:
> 
> 	fail_test "got $count JOIN[s] syn with Backup expected
> $mpj_syn"

Good point!

>> +	else
>> +		print_ok
>> +	fi
>> +
>> +	print_check "synack backup"
>> +	count=$(mptcp_lib_get_counter ${ns2}
>> "MPTcpExtMPJoinSynAckBackupRx")
>> +	if [ -z "$count" ]; then
>> +		print_skip
>> +	elif [ "$count" != "$mpj_syn_ack" ]; then
>> +		fail_test "got $count MPJ SYNACK[s] with Backup
>> expected $mpj_syn_ack"
> 
> The same here.

Will do!

>> +	else
>> +		print_ok
>> +	fi
>>  }
>>  
>>  chk_subflow_nr()
>> @@ -2612,7 +2634,7 @@ backup_tests()
>>  		sflags=nobackup speed=slow \
>>  			run_tests $ns1 $ns2 10.0.1.1
>>  		chk_join_nr 1 1 1
>> -		chk_prio_nr 0 1
>> +		chk_prio_nr 0 1 1 0
> 
> The last value is the default one, only "chk_prio_nr 0 1 1" is enough.

I think it is also better to avoid that in the 'chk_*' helpers,
otherwise it is hard to follow what is going to be done.

> 
>>  	fi
>>  
>>  	# single address, backup
>> @@ -2625,7 +2647,7 @@ backup_tests()
>>  			run_tests $ns1 $ns2 10.0.1.1
>>  		chk_join_nr 1 1 1
>>  		chk_add_nr 1 1
>> -		chk_prio_nr 1 1
>> +		chk_prio_nr 1 1 0 0
> 
> With default values, no need to change this then.

Please note that I also find this change safer for the backports: if the
commit cannot be backported without conflicts, we can check why: maybe
the test behaviour was different before, and the number of MPJ with
backup flags was different. (But this is only because here it is a
series for -net. If we extend a check to verify more things in very
specific cases, something that doesn't make sense to check in other
cases, then it can be fine to have optional parameters I think.)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

