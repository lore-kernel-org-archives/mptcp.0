Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5DE127B7D
	for <mptcp@lists.linux.dev>; Thu,  4 Apr 2024 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712253005; cv=none; b=PUSqeRdqm3ysFPKrdykqSXEuFCm+lP39IIj8R5aJeUJkYKpkabvptpSLDKgB5snpdw4Kjg7WupGi/hbTWmMNCQhZqZ3eEavugMuO3btAaoh1KE3ekkMBK69l5SmPnFEKPS38ICZ5IvUK+J/l3Bw4Q+P19aqA9oNt+8iBs2kCZfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712253005; c=relaxed/simple;
	bh=S6nWyPFvGMW4NUTAWnIrh5TIWimZgoDoNPJWQtuyu9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FlfMKu/D7VsOAABzNZ/AJOasgQQ1MMxkX7KpLxSoKbNtXs/5Ucq6wkJB26NdFgjPMGXqbmky6nYyNjsHSfQ35kvOSKKMGXSgMEOakp6x27NBnDns39VUZ/TB5DXwDACVHmN59g09SilmFc9RDmApmmrUEiafSwNK7gMClQUaM08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lul7uX76; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lul7uX76"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561D3C433F1;
	Thu,  4 Apr 2024 17:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712253005;
	bh=S6nWyPFvGMW4NUTAWnIrh5TIWimZgoDoNPJWQtuyu9Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lul7uX76kdsIe/mAlXBfPFQnnOlE8/P1LJi2NsnvLfET1K2kbWFngGyM1biPjFgJ+
	 G47ETBeYndvsIdU4L1idn4IT31wuh/bNEkR35HNeY4AgBjoJAC3cEuplP8m0POL/YE
	 GWRxvsxUTcvzPVTfAmssoeDZNa8e0n8u3oYCNRB1WAvWwS4jw3YnGTIBN/aFBmJyQ5
	 7Z3024T736g1gHX9t9BG0TYVAPX2E63245Y7S7Rv3JN/sIAzjJnNgjf215dt8/Jd0i
	 sIQyrDBHRCDy7HkcPs2XNL6g9LfIJ3kV15Kc7j1hK+x60U7tdxDwevGISO6QUQNE7j
	 8fzzkWsRcV67A==
Message-ID: <8f5499c7-a5b5-43b2-805c-e09887472f06@kernel.org>
Date: Thu, 4 Apr 2024 19:50:02 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v6 2/9] Squash to "selftests/bpf: Add bpf
 scheduler test" 1 verify
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1712235379.git.tanggeliang@kylinos.cn>
 <266c39f2ef6f77d139b0abb015b255a0dfb2307c.1712235379.git.tanggeliang@kylinos.cn>
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <266c39f2ef6f77d139b0abb015b255a0dfb2307c.1712235379.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 04/04/2024 15:03, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Add send_data_and_verify helper.

Please always add the reason, even if it is just a "to avoid duplicated
code".
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 40 ++++++++++++++-----
>  1 file changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index c29c81239603..e1114745da63 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -457,23 +457,44 @@ static int has_bytes_sent(char *addr)
>  	return system(cmd);
>  }
>  
> -static void test_default(void)
> +static void send_data_and_verify(char *msg, int addr1, int addr2)
>  {
>  	int server_fd, client_fd;
> -	struct nstoken *nstoken;
>  
> -	nstoken = sched_init("subflow", "default");
> -	if (!ASSERT_OK_PTR(nstoken, "sched_init:default"))
> -		goto fail;
>  	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
> +	if (!ASSERT_NEQ(server_fd, -1, "start_mptcp_server"))
> +		return;
> +
>  	client_fd = connect_to_fd(server_fd, 0);
> +	if (!ASSERT_NEQ(client_fd, -1, "connect_to_fd"))
> +		goto close_server;
>  
> -	send_data(server_fd, client_fd, "default");
> -	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
> -	ASSERT_OK(has_bytes_sent(ADDR_2), "has_bytes_sent addr_2");
> +	send_data(server_fd, client_fd, msg);
> +
> +	if (addr1)

Maybe clearer to use booleans if you use addr1 and addr2 as such, no?

> +		ASSERT_OK(has_bytes_sent(ADDR_1), "Should have bytes_sent on addr1");
> +	else
> +		ASSERT_GT(has_bytes_sent(ADDR_1), 0, "Shouldn't have bytes_sent on addr1");
> +	if (addr2)
> +		ASSERT_OK(has_bytes_sent(ADDR_2), "Should have bytes_sent on addr2");
> +	else
> +		ASSERT_GT(has_bytes_sent(ADDR_2), 0, "Shouldn't have bytes_sent on addr2");

In case of error, will we directly understand from which scheduler the
error is linked to? I understood that some BPF tests can be run in
parallel, maybe we need a prefix to know which tests had an issue? Or
maybe the prefix is not needed because these schedulers tests are
executed in sequence and we print which one is being executed?

In other words, what do you see if on purpose you create an error by
inverting 'addr2' value for example in only one sched test, and you
launch the tests with 'test_progs -j'?

>  
>  	close(client_fd);
> +close_server:
>  	close(server_fd);
> +}
> +
> +static void test_default(void)
> +{
> +	struct nstoken *nstoken;
> +
> +	nstoken = sched_init("subflow", "default");
> +	if (!ASSERT_OK_PTR(nstoken, "sched_init:default"))
> +		goto fail;
> +
> +	send_data_and_verify("default", 1, 1);


It is good to have such helper to reduce duplicated code, but having:

  1, 1

is really not clear, no?

Maybe clearer (especially later if you use this a lot), to use macros?
e.g. to have:

  send_data_and_verify("default", USE_ADDR1, NO_ADDR2);

or

  send_data_and_verify("default", WITH_DATA, WITHOUT_DATA);

(we might understand one is for addr1 and the other for addr2)

WDYT? I don't know if it is clearer.

> +
>  fail:
>  	cleanup_netns(nstoken);
>  }
> @@ -663,8 +684,7 @@ void test_mptcp(void)
>  {
>  	RUN_MPTCP_TEST(base);
>  	RUN_MPTCP_TEST(mptcpify);
> -	if (test__start_subtest("default"))
> -		test_default();
> +	RUN_MPTCP_TEST(default);
>  	if (test__start_subtest("first"))
>  		test_first();
>  	if (test__start_subtest("bkup"))

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

