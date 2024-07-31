Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6C617BA2
	for <mptcp@lists.linux.dev>; Wed, 31 Jul 2024 02:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722394752; cv=none; b=hTl7Aguwcoe+0C95vbvI1vQ2S5Vy4ooPCraUdiPEWuXY3waOffcEAiN1tU4tvyySRIEdlAJLnDZlGiWicP4ruObKRRa7cxp/ILSnfFdAW9g+21DHbepN/OOFgaf8XH509XJ8eCpUJV5D7rZjovs6FBGh3aEO6x4B0YlhnfPNs9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722394752; c=relaxed/simple;
	bh=JrbubCJsctlYZQhkQMye+VzRF0cObJIpsrRX3oN3ScA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UwvV3T02+F4pNuUuDguG6RsXy0hVCgY63+p75lI7RRrjGq2lqcbnFYHlGaLdtlVT5pERolQLvwlKbcobmE8iP50XcVsAgVrWZh4ewOh278vAss7adgHSy4K2cOxPZqktfOsG+uZzFDCUO2nkdUIUNM6EA5lwpce/woQ5B14HPbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7hJ/PIW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7hJ/PIW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4AC2C32782;
	Wed, 31 Jul 2024 02:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722394751;
	bh=JrbubCJsctlYZQhkQMye+VzRF0cObJIpsrRX3oN3ScA=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=b7hJ/PIWtjYqXBx/dWXvrkxr1POpErNuYcl0FJZptTcz07UbPFHAtCKdl4VCnt2vE
	 smOjVs5i93C0/josSguEGl3/zPBgw61qmCzTtVWfDnrq6EdC+gOxizTZTq9r4oG8Ip
	 Y14920YJcskDkxTuSTf7bkzyOzaukdx1D9zdP+I/B9U6ogZMGn9Pj1FEJ5AXnUt2v6
	 XUZkPqq2QUA88ADr//L/60PgpcHDyhDiOimuXwp22Lz6lIfQFn1nshppN+BJBW3Sd8
	 7kbAPF56YNK883LTDwXHvq9drW7yZyfz7VkMXr1qjnZFCXrNFIfkgZ9xfZbEbYCJPm
	 nzK04SgP6t/ug==
Message-ID: <54fe0a426f00ad7c6d4b2c639da7bb5925b408f7.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 2/2] selftests: mptcp: join: validate MPJ
 SYN TX MIB counters
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev
Date: Wed, 31 Jul 2024 10:59:03 +0800
In-Reply-To: <20240729-mptcp-join-tx-mib-v2-2-8ace70fd407a@kernel.org>
References: <20240729-mptcp-join-tx-mib-v2-0-8ace70fd407a@kernel.org>
	 <20240729-mptcp-join-tx-mib-v2-2-8ace70fd407a@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.0-1build2 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

Thanks for these patches.

On Mon, 2024-07-29 at 12:18 +0200, Matthieu Baerts (NGI0) wrote:
> A few new MIB counters have been added. They are being validated
> here.
> 
> Most of the time, there are no errors, but sometimes, more MPJ SYN
> are
> queued compared to the numbers that are received.
> 
> Only one test has an error, the one to connect to a broadcast IP
> address.
> 
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 63
> +++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index fbb0174145ad..c1f1ebd2340c 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -1372,6 +1372,66 @@ chk_join_nr()
>  	fi
>  }
>  
> +chk_join_tx_nr()
> +{
> +	local syn_nr=$1
> +	local festab=$2
> +	local create=$3
> +	local bind=$4
> +	local connect=$5
> +	local count
> +
> +	print_check "syn TX"
> +	count=$(mptcp_lib_get_counter ${ns2} "MPTcpExtMPJoinSynTx")
> +	if [ -z "$count" ]; then
> +		print_skip
> +	elif [ "$count" != "$syn_nr" ]; then
> +		fail_test "got $count JOIN[s] syn TX expected
> $syn_nr"
> +	else
> +		print_ok
> +	fi

Do you think it is necessary to check MPTcpExtMPJoinSynTx in
chk_join_nr()?

> +
> +	print_check "syn TX Fully Estab Error"
> +	count=$(mptcp_lib_get_counter ${ns2}
> "MPTcpExtMPJoinSynTxFEstabErr")
> +	if [ -z "$count" ]; then
> +		print_skip
> +	elif [ "$count" != "$festab" ]; then
> +		fail_test "got $count JOIN[s] syn TX Fully Estab
> Error expected $festab"
> +	else
> +		print_ok
> +	fi
> +
> +	print_check "syn TX Create Socket Error"
> +	count=$(mptcp_lib_get_counter ${ns2}
> "MPTcpExtMPJoinSynTxCreatSkErr")
> +	if [ -z "$count" ]; then
> +		print_skip
> +	elif [ "$count" != "$create" ]; then
> +		fail_test "got $count JOIN[s] syn TX Create Socket
> Error expected $create"
> +	else
> +		print_ok
> +	fi

There is no test that can trigger MPTcpExtMPJoinSynTxFEstabErr and
MPTcpExtMPJoinSynTxCreatSkErr. Does this mean that there is no need to
add these two MIBs? Maybe adding pr_debug logs is enough? WDYT?
 
> +
> +	print_check "syn TX Bind Error"
> +	count=$(mptcp_lib_get_counter ${ns2}
> "MPTcpExtMPJoinSynTxBindErr")
> +	if [ -z "$count" ]; then
> +		print_skip
> +	elif [ "$count" != "$bind" ]; then
> +		fail_test "got $count JOIN[s] syn TX Bind Error
> expected $bind"
> +	else
> +		print_ok
> +	fi
> +
> +	print_check "syn TX Connect Error"
> +	count=$(mptcp_lib_get_counter ${ns2}
> "MPTcpExtMPJoinSynTxConnectErr")
> +	if [ -z "$count" ]; then
> +		print_skip
> +	elif [ "$count" != "$connect" ]; then
> +		fail_test "got $count JOIN[s] syn TX Connect Error
> expected $connect"
> +	else
> +		print_ok
> +	fi
> +}
> +
>  # a negative value for 'stale_max' means no upper bound:
>  # for bidirectional transfer, if one peer sleep for a while
>  # - as these tests do - we can have a quite high number of
> @@ -1907,6 +1967,7 @@ subflows_error_tests()

Add an invalid address here in this test:

	pm_nl_add_endpoint $ns2 10.0.5.2 flags subflow

>  		speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
>  		chk_join_nr 0 0 0
> +		chk_join_tx_nr 0 0 0 0 0

It will trigger a "syn TX Bind Error":

		chk_join_tx_nr 0 0 0 1 0


Thanks!
Geliang 
>  	# multiple subflows, with subflow creation error
> @@ -1919,6 +1980,7 @@ subflows_error_tests()
>  		speed=slow \
>  			run_tests $ns1 $ns2 10.0.1.1
>  		chk_join_nr 1 1 1
> +		chk_join_tx_nr 2 0 0 0 0
>  	fi
>  
>  	# multiple subflows, with subflow timeout on MPJ
> @@ -2306,6 +2368,7 @@ remove_tests()
>  		addr_nr_ns1=-3 speed=10 \
>  			run_tests $ns1 $ns2 10.0.1.1
>  		chk_join_nr 1 1 1
> +		chk_join_tx_nr 2 0 0 0 1
>  		chk_add_nr 3 3
>  		chk_rm_nr 3 1 invert
>  		chk_rst_nr 0 0
> 

