Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127EC58207
	for <mptcp@lists.linux.dev>; Tue, 12 Mar 2024 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710241324; cv=none; b=N7mk8DpV9i6Lo/lT37+t/wM90TH1ekuxGjOQJcx/U4/F7n/BKJ6zgAawiZwZAsSKvjDkH337HoJ82u9ObBVVHVRPbYtfM9dLT/GVZVPMyNe+HoO8wmaun0JPiN091sirjTTd03DHdZ+Nj4foaX3Y7+k8xKtPzkkqQdQHnytnveM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710241324; c=relaxed/simple;
	bh=lxmgYVB2xj2v2V86d1biA618iCegDqQ5lbkVs+5u7bM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kD8eSJRhU/ExnwAhN6Ekv3mwDIT0kjUuV+4QEkIF1UN4ZJi4tt8ADm2vlovW9/FZYU10jA8RO8i6nz+ni56KDGXwpIgNSOKkoaWVSzaSYKNmf75FTJFoL9AfrQBcrXXeWKDTtHfCwDt5g5cleuIkJuO/v/viiMnatrP0I7iIQac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyg1qP2O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyg1qP2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605D4C433C7;
	Tue, 12 Mar 2024 11:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710241323;
	bh=lxmgYVB2xj2v2V86d1biA618iCegDqQ5lbkVs+5u7bM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tyg1qP2Ot5k9X1gTCdDPt3hQmDtiynwfPDm7I2pPpL63SbybLVvsZB4DRfOelx0zw
	 v+IfiySIDG4UQcEE+e6lb3O1Dpz0jsYu/5V4Scs8bsgrKV7sN/VfNOGwzGdAHo7uYc
	 nlDUOzf8M0MIaxc6LTkQa7rRP0QJCNzRfQv8IA64c2yr91No1VWiOtaeQQlz3CyqNo
	 xKLePsHgzs5RtMynCf5UjBxrF3K02ivTw5oZarao4XFjk3CUCcKXMqHEUSW5qJkry+
	 abErANJtqgzQpXgtZOPEeQlIhKDdkTH6x+I3h6o5/8SzG4d1Cs67ot/cEjjOr73XOa
	 RfMGvVPhv45Hw==
Message-ID: <9d2c80f9-9dc2-44ba-9017-c1110089af5c@kernel.org>
Date: Tue, 12 Mar 2024 12:01:59 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next] selftests: mptcp: iperf mptcp tests
Content-Language: en-US
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <8f95589ded2c77edbc5086a808703c63b4641e60.1710206580.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <8f95589ded2c77edbc5086a808703c63b4641e60.1710206580.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 12/03/2024 02:23, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> MPTCPv1 protocol support has been added in iperf3 recently. This patch
> add some tests for iperf3 to demonstrate the advantages of MPTCP over
> TCP in latency or packet loss situations.
> 
> Note:

Thank you for the note, it is useful.

> Does 'delay 1' in below command mean 'delay 1ms'? I'm not sure.
>> tc -n $ns2 qdisc add dev ns2eth1 root netem rate 1mbit delay 1

Accoring to 'man tc-netem' (8), it is in milliseconds:

   delay
       adds the chosen delay to the packets outgoing to chosen network
       interface.  The  optional  parameters allows one to introduce a
       delay variation and a correlation.  Delay and jitter values are
       expressed in ms while correlation is percentage.

But I think you can specify '1ms' to make it clear, no?

> Should this test be put in a standalone test script or just like in this
> patch, as a subtest of mptcp_join.sh?

I don't know. I don't think we should add IPerf tests in the selftests:

- I don't think it is validating any more kernel code path than what we
already have: we already have a lot of tests in MPTCP Join selftest,
let's only add new ones validating untested kernel code, no?

- I don't think we should validate many userspace tools from the kernel
side: we probably don't have the resources to do that. We should focus
on minimal tools validating different code paths.

- Probably best not to depend on external tools: it makes it harder to
have these tests validated by other CIs.

In other words, I think tests for userspace apps should not be on the
kernelspace side, but stay on the userspace side. WDYT?

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 1052b85d8170..f2279bfa27c3 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -141,7 +141,7 @@ init() {
>  
>  	mptcp_lib_check_mptcp
>  	mptcp_lib_check_kallsyms
> -	mptcp_lib_check_tools ip ss "${iptables}" "${ip6tables}"
> +	mptcp_lib_check_tools ip ss "${iptables}" "${ip6tables}" iperf

This means 'iper3' with MPTCP support is now a hard dependence for this
selftests: without it, nothing is launched. We cannot do: most CIs will
not have this tool, many tests will then no longer be validated.

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

