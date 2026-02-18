Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055CA309F18
	for <mptcp@lists.linux.dev>; Wed, 18 Feb 2026 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771416795; cv=none; b=X6MZWsSqfEOfEEuPkYzfzWoAUhDNBgpuZCBaAT8+WenAhvStLtYnFSMtzk1akEtOyj0lHkiKkEoFexqS5KMzWsRyy3JhKPNj3rudqZIGJrWwIK6ZxSkFAycH206bXWXUCqfZjoewAyJ/PRdyT1QufIkjGFB2vnjLkUy9e0co9Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771416795; c=relaxed/simple;
	bh=nDwykEoAbQyL+JtBoqtCMMsQZ1wBzA1aYrlqV9M3MlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VgXQynhDK2IjGdL0jQbrJRS5JEdRWImGoBdYRzVC/z8rfvkdNO6RrGKvClGrD/vZRfwHAsBKEXQCT+0nAl1z6+ctQq1vtMGPGrMA62TT/fBzhvVZHc4YtB45z8eFnqWJFWHY8NgTf+FOHwsXvEJMKg6kOL+fUKYFz7UHpyOXlco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t86s5fhB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t86s5fhB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0549BC19421;
	Wed, 18 Feb 2026 12:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771416794;
	bh=nDwykEoAbQyL+JtBoqtCMMsQZ1wBzA1aYrlqV9M3MlE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=t86s5fhBTMsEtNjplDkHf2cMERc206BuyRrbH1tB4t0c73EJtzXnAetEHdfrpODtF
	 irecY5dJIWzp2ZJ7OePm5aZj9wRRhB+c5zb/t5J/2YGeKxHoKCQhX4Pw8yjGl2Qlvh
	 aIjIE1oHzWjq5jt2hExFZ+TSAzVQuEBG2gcn6Swb9/797MKJVgC/XqbhOS+u+m+dD3
	 lNkQLHYPp8IH4EX3MzYmRht6muzerAJxj9iYxk3poWfcCzB2nCnMJKL71p9cq9DCj9
	 RhOcsJ6XHEPa7MS4TQC/ox7cv+FL0qj4PMSAW7fr0Hd6aLfJl2zmBwarHCByOYC5CN
	 8Zcp7JdOjWKaw==
Message-ID: <45ade886-44c0-4889-b825-82fa12fb03cc@kernel.org>
Date: Wed, 18 Feb 2026 13:13:11 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] selftests: mptcp: more stable simult_flows
 tests
Content-Language: en-GB, fr-BE
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <ec938f018aed693c624c7a61366b28c863a1d56d.1771276854.git.pabeni@redhat.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ec938f018aed693c624c7a61366b28c863a1d56d.1771276854.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 16/02/2026 22:20, Paolo Abeni wrote:
> By default, the netem qdisc can keep up to 1000 packets under its belly
> to deal with the configured rate and delay. The simult flows test-case
> simulates very low speed links, to avoid problems due to slow CPUs and
> the TCP stack tend to transmit at a slightly higher rate than the
> (virtual) link constraints.
> 
> All the above causes a relatively large amount of packets being enqueued
> in the netem qdiscs - the longer the transfer, the longer the queue -
> producing increasingly high TCP RTT samples and consequently increasingly
> larger receive buffer size due to DRS.
> 
> When the receive buffer size becomes considerably larger than the needed
> size, the tests results can flake, i.e. because minimal inaccuracy in the
> pacing rate can lead to a single subflow usage towards the end of the
> connection for a considerable amount of data.
> 
> Address the issue explicitly setting netem limits suitable for the
> configured link speeds and unflake all the affected tests.

Thank you for having taken the time to analyse this, and provided a fix!
Bufferbloat is a plague, even in the selftests!

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

I suggest applying this in -net, hopefully to help to validate stable
kernel versions.

> Fixes: 1a418cb8e888 ("mptcp: simult flow self-tests")
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  tools/testing/selftests/net/mptcp/simult_flows.sh | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
> index a9c9927d6cbc..d11a8b949aab 100755
> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
> @@ -237,10 +237,13 @@ run_test()
>  	for dev in ns2eth1 ns2eth2; do
>  		tc -n $ns2 qdisc del dev $dev root >/dev/null 2>&1
>  	done
> -	tc -n $ns1 qdisc add dev ns1eth1 root netem rate ${rate1}mbit $delay1
> -	tc -n $ns1 qdisc add dev ns1eth2 root netem rate ${rate2}mbit $delay2
> -	tc -n $ns2 qdisc add dev ns2eth1 root netem rate ${rate1}mbit $delay1
> -	tc -n $ns2 qdisc add dev ns2eth2 root netem rate ${rate2}mbit $delay2
> +
> +	# keep the queued pkts number low, or the RTT estimator will see
> +	# increasing latency over time.
> +	tc -n $ns1 qdisc add dev ns1eth1 root netem rate ${rate1}mbit $delay1 limit 50
> +	tc -n $ns1 qdisc add dev ns1eth2 root netem rate ${rate2}mbit $delay2 limit 50
> +	tc -n $ns2 qdisc add dev ns2eth1 root netem rate ${rate1}mbit $delay1 limit 50
> +	tc -n $ns2 qdisc add dev ns2eth2 root netem rate ${rate2}mbit $delay2 limit 50
>  
>  	# time is measured in ms, account for transfer size, aggregated link speed
>  	# and header overhead (10%)
> @@ -304,7 +307,7 @@ run_test 10 10 1 25 "balanced bwidth with unbalanced delay"
>  # we still need some additional infrastructure to pass the following test-cases
>  MPTCP_LIB_SUBTEST_FLAKY=1 run_test 10 3 0 0 "unbalanced bwidth"

By any chance, did you check if your modification was helping this case
as well? If not, I can try on my side when I have the opportunity (no
urgency anyway).

>  run_test 10 3 1 25 "unbalanced bwidth with unbalanced delay"
> -MPTCP_LIB_SUBTEST_FLAKY=1 run_test 10 3 25 1 "unbalanced bwidth with opposed, unbalanced delay"
> +run_test 10 3 25 1 "unbalanced bwidth with opposed, unbalanced delay"
>  
>  mptcp_lib_result_print_all_tap
>  exit $ret

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

