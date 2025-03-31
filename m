Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924DE1C5489
	for <mptcp@lists.linux.dev>; Mon, 31 Mar 2025 12:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743424267; cv=none; b=cF+z6U3POiCIWReCNQgy8n98Ub3JeBDYCTnLImJfg+53ivNIeKd9HFezendrdj+GxJ+P39k7CEuSFJYNKlKqbgLrUZK08oj/tRHJ3fD7Lky2EemtITV5q1z5/3QXX0sdTSKnnJpNZd1sS1X+qKufAuykMEKTtcFkTxvhufZJ4iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743424267; c=relaxed/simple;
	bh=vUtIo09FAuFgzDSca66kEDJNYIHdUEgmeU7bDtr52DY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=is75DCuV4ovNjRA+PmsJdsNHiY9qI/C49xTYOK+ZZMbceuPb0UHY3bbfB+7bxQ6Lmpb+RRKHl6A8S/5pei0t1/c73nJ4NhiU9Disb2KcNe5SZviS34l3gDQee2nIh5CY84ULIywslPjtF/SIBvIDX2dHLz95ztsvB9AK97dSlBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AA61QgbB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AA61QgbB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BF0C4CEE3;
	Mon, 31 Mar 2025 12:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743424266;
	bh=vUtIo09FAuFgzDSca66kEDJNYIHdUEgmeU7bDtr52DY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=AA61QgbB+cIotqhs1QSrIoIO3tlCy1F+Sh92bv+AoKw2VPjwJgDe0FAbif/uRbWGo
	 /uir9LO85uDSiP90jvVXg+tiS8MseTcabur92txB2nCCvr5UdHkcfrBQfdY9HNN4Xk
	 THIOMTMVGeB/rhJpX8Meou+DSSCjJPNqAtDUai/mtA7EaKJ5UDJPO+8XxyBQwDehkM
	 mvlPx2k+dN5SNQO8TsqQGpdOJ2WLbtMict+VyuKVbdLG7WqE1usuCYbIh+HHd5rHvz
	 oNSslesXqO2AwyrUx6XZBU1GJ2EnPw7NOz9Hp42fijlb8sUXKhtkk7HBirn6xOETiF
	 uGZinvXQpvdjA==
Message-ID: <610655ed-02e8-4c33-b1d9-b2f224638b84@kernel.org>
Date: Mon, 31 Mar 2025 14:31:02 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next 2/5] selftests: mptcp: validate MPJoin
 HMacFailure counters
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
References: <20250329-mptcp-mpj-reject-v1-0-2396d5666e8f@kernel.org>
 <20250329-mptcp-mpj-reject-v1-2-2396d5666e8f@kernel.org>
 <36791aea3d151d35234f88c57b8205abcc1cca69.camel@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <36791aea3d151d35234f88c57b8205abcc1cca69.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 30/03/2025 01:15, Geliang Tang wrote:
> 
> Hi Matt,
> 
> Thanks for this patch.
> 
> On Sat, 2025-03-29 at 17:26 +0100, Matthieu Baerts (NGI0) wrote:
>> The parent commit fixes an issue around these counters where one of
>> them
>> -- MPJoinAckHMacFailure -- was wrongly incremented in some cases.
>>
>> This makes sure the counter is always 0. It should be incremented
>> only
>> in case of corruption, or a wrong implementation, which should not be
>> the case in these selftests.
>>
>> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>> ---
>> Note: this can go to mptcp-net as well, with the parent patch.
>> ---
>>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 18
>> ++++++++++++++++++
>>  1 file changed, 18 insertions(+)
>>
>> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> index
>> 13a3b68181ee14eb628a858e5738094c3c936b74..5060b7e24f94550246c2b1f0465
>> dcaf42b869313 100755
>> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
>> @@ -1441,6 +1441,15 @@ chk_join_nr()
>>  		fi
>>  	fi
>>  
>> +	count=$(mptcp_lib_get_counter ${ns2}
>> "MPTcpExtMPJoinSynAckHMacFailure")
>> +	if [ -z "$count" ]; then
>> +		rc=${KSFT_SKIP}
>> +	elif [ "$count" != "0" ]; then
>> +		rc=${KSFT_FAIL}
>> +		print_check "ack HMAC"
> 
> Should here be "synack HMAC"...
> 
>> +		fail_test "got $count JOIN[s] synack HMAC failure
>> expected 0"
>> +	fi
>> +
>>  	count=$(mptcp_lib_get_counter ${ns1} "MPTcpExtMPJoinAckRx")
>>  	if [ -z "$count" ]; then
>>  		rc=${KSFT_SKIP}
>> @@ -1450,6 +1459,15 @@ chk_join_nr()
>>  		fail_test "got $count JOIN[s] ack rx expected
>> $ack_nr"
>>  	fi
>>  
>> +	count=$(mptcp_lib_get_counter ${ns1}
>> "MPTcpExtMPJoinAckHMacFailure")
>> +	if [ -z "$count" ]; then
>> +		rc=${KSFT_SKIP}
>> +	elif [ "$count" != "0" ]; then
>> +		rc=${KSFT_FAIL}
>> +		print_check "synack HMAC"
> 
> ... and here be "ack HMAC"?

Good catch! I can fix that when applying the patches.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

