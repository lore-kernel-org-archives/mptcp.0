Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9956B10962
	for <mptcp@lists.linux.dev>; Thu,  4 Apr 2024 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712253127; cv=none; b=YSd1cmNNGwDPYDRfCGj7WBANNxmsa6tDFlyCa6ppNHRJ0tuYh9ef+CDSQUb6hTQaujlUP/h5UIEqWAgDyMwLrZJyFfhSjCTajeabnkQXagKVtSghqMApGcD2AXn02eQ7f7xDl+RY/Fd7IDELg03m3vsazUd0GEP5VaVzDgp7jSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712253127; c=relaxed/simple;
	bh=2kJjY9ra5SBt9K2cfu258ss2hYibTJm5JZdGE+xB6i4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gt3qH3zcRdahTUokOf8miGhF777V296hdBAc1yw5DLsO22kOcAfDcP3uzhU4moKzxuykOwXEsEM5THmGPTLefu28LLHiltSXMCuRxl7njfNVDR+l1W3serEMSMHx/tEmm6g5S+Yq+PV+7CJlwBDSmWKFC/e5jh/vyEGAIdXvHHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gcW9dwCr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gcW9dwCr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F27DC433F1;
	Thu,  4 Apr 2024 17:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712253127;
	bh=2kJjY9ra5SBt9K2cfu258ss2hYibTJm5JZdGE+xB6i4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gcW9dwCr7QqrbL9p1EK/JgVwoqqJpALHNojIFWiMd9zCvxHOzGRHMayrHKBMDJkId
	 SRQm9M1sTRI3cHdFOqqbt5FKnMtlF402Jl4sKRdIODolaEVz++3fiIF2HIN08rvQeN
	 eYc5FlC5OfvdbwhoUWQNh6Ts3dgOBBc2Mf3TtaPLnjZlnJIYCC9DmKcsvzXUWcVSjg
	 bRQ8hMROp3lXTzhSRE8NsxntcFzjnI6jiMZf4TTe+mzW6+6hZ5rX07pMBAmj7vnZ4l
	 sD0NtTJlBC7zQ9pFWIDMd0eQWRiUHRFp7QK1aMpMta0KD/NcKUcyjrnB7dKmAQSnj4
	 QqhKT7RPRfSwQ==
Message-ID: <5a8d79cb-5dfc-45d8-b708-7d4c798408c7@kernel.org>
Date: Thu, 4 Apr 2024 19:52:04 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v6 4/9] selftests/bpf: Add MPTCP_SCHED_TEST
 macro
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1712235379.git.tanggeliang@kylinos.cn>
 <ae75e2c884eb6a1742af12aaeae9015bb0b4d90c.1712235380.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <ae75e2c884eb6a1742af12aaeae9015bb0b4d90c.1712235380.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 04/04/2024 15:03, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch defines MPTCP_SCHED_TEST macro, a template for all scheduler
> tests. Every scheduler is identified by argument name, and use sysctl
> to set net.mptcp.scheduler as "bpf_name" to use this sched. Add two
> veth net devices to simulate the multiple addresses case. Use 'ip mptcp
> endpoint' command to add the new endpoint ADDR2 to PM netlink. Arguments
> addr1/add2 means whether the data has been sent on the first/second subflow
> or not. Send data and check bytes_sent of 'ss' output after it using
> send_data_and_verify().

Should we not squash this in "selftests/bpf: Add bpf scheduler test" as
well? We already have a lot of different commits.

> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../testing/selftests/bpf/prog_tests/mptcp.c  | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index ffcd5ebe38b9..8a6b09a97698 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -498,6 +498,36 @@ static void test_default(void)
>  	cleanup_netns(nstoken);
>  }
>  
> +#define MPTCP_SCHED_TEST(name, addr1, addr2)			\
> +static void test_##name(void)					\
> +{								\
> +	struct mptcp_bpf_##name *skel;				\
> +	struct nstoken *nstoken;				\
> +	struct bpf_link *link;					\
> +	struct bpf_map *map;					\
> +								\
> +	skel = mptcp_bpf_##name##__open_and_load();		\
> +	if (!ASSERT_OK_PTR(skel, "open_and_load " #name))	\
> +		return;						\
> +								\
> +	map = bpf_object__find_map_by_name(skel->obj, #name);	\
> +	link = bpf_map__attach_struct_ops(map);			\
> +	if (!ASSERT_OK_PTR(link, "attach_struct_ops " #name))	\
> +		goto skel_destroy;				\
> +								\
> +	nstoken = sched_init("subflow", "bpf_" #name);		\
> +	if (!ASSERT_OK_PTR(nstoken, "sched_init " #name))	\
> +		goto link_destroy;				\
> +								\
> +	send_data_and_verify(#name, atoi(#addr1), atoi(#addr2));\

Can you not use the values of addr1 and addr2 directly as number instead
of string + atoi()?

> +								\
> +	cleanup_netns(nstoken);					\
> +link_destroy:							\
> +	bpf_link__destroy(link);				\
> +skel_destroy:							\
> +	mptcp_bpf_##name##__destroy(skel);			\
> +}

I don't mind having functions defined in macros, but I think we should
try to reduce their size to the minimum (if possible) because they are
hard to read and debug in case of error.

Here, do you think we could have a smaller macro passing the name as a
string (for the error messages) and the different functions pointers you
need to a new helper? (+ using generic skel structure?)

Maybe it will not work or will not be easier to read, but worth a try I
think. If it is not possible, please explain why.


> +
>  static void test_first(void)
>  {
>  	struct mptcp_bpf_first *first_skel;

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

