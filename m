Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9131635A6
	for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713458550; cv=none; b=JR528YereuEkanxIzPAQ1ZUvincu51LOiN9unq8oozQ0XBq7p8Robpx+7TOXvFRYz745lTRSScB37zgewGXyeyv0XsdqVMa7MxAXLqr62DIKJHS22dL2NijyVPLBCzOvlL0jZ0oH2giJ8tjRu3kdpBN/IVMWL3Hff3si10ucb9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713458550; c=relaxed/simple;
	bh=nO2R7eYU4p8xQPIMJ/Xkw6M3rpjp6fau7+LDsaWbGig=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kkXfRAvG2edgc+Vguhwhkfr2oekzLawtEq/cuGS1k3HsckPbwecGxQyNPUH1JedSyfS8460EUzHRaEHtUO9v2bnsqRTh5GQ4LwI8AOUDkkTaaUsZs+ShHyjuZLuT6++TKuWrxdDNLT/3m1ZFp18P+15SI48RbcmOZ+BhrPBKpLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k36h06oe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k36h06oe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1347C113CC;
	Thu, 18 Apr 2024 16:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713458549;
	bh=nO2R7eYU4p8xQPIMJ/Xkw6M3rpjp6fau7+LDsaWbGig=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=k36h06oeKLpvLyw4JRJhHylX4d8/zR9J2PDXvNC3aKjR0J3H6jTK/qC8ZIxz9a/RS
	 /DM9+2DrSbOXNvLqMjjh3HEnJSx9vf2if4auIwIZA1xeG/bzasCfcKCbK0+j+54NVA
	 pM+ozClNciz/Etj9fa2FVi53gYZRwj93YgABd9vfeo8E8ftuYZuV7NFq/buimhGOAR
	 RRs1//2z83Q1I6N0RtjjAUKi3JEsCrRse9a4mhkAIDaGJiSXF58uL7JONyjE6yhk4e
	 2ZAbQQCvZYbRLhOQhk7RI4vBhspLBmcqu88l5VxQqAmvgk77oe4Fk9EH4nXUC1Xhj3
	 i/81plhkOAENw==
Date: Thu, 18 Apr 2024 09:42:29 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v9 1/8] selftests/bpf: Add RUN_MPTCP_TEST
 macro
In-Reply-To: <87f974d9431af3018c35cbd4db147ea807e3c451.1713321357.git.tanggeliang@kylinos.cn>
Message-ID: <79b6295b-7536-9b32-1131-c85fac417698@kernel.org>
References: <cover.1713321357.git.tanggeliang@kylinos.cn> <87f974d9431af3018c35cbd4db147ea807e3c451.1713321357.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 17 Apr 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Each MPTCP subtest tests test__start_subtest(suffix), then invokes
> test_suffix(). It makes sense to add a new macro RUN_MPTCP_TEST to
> simpolify the code.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

With 
https://patchwork.kernel.org/project/mptcp/patch/cc01abb2882608ac5f719e0f7960aa2a2d9fca41.1713404174.git.tanggeliang@kylinos.cn/,
v9 of the series looks good to apply.

The rest of the series is all "squash-to" patches, but for this first 
patch:

Reviewed-by: Mat Martineau <martineau@kernel.org>


> ---
> tools/testing/selftests/bpf/prog_tests/mptcp.c | 12 ++++++++----
> 1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index cbdb15922949..c29c81239603 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -653,12 +653,16 @@ static void test_burst(void)
> 	mptcp_bpf_burst__destroy(burst_skel);
> }
>
> +#define RUN_MPTCP_TEST(suffix)					\
> +do {								\
> +	if (test__start_subtest(#suffix))			\
> +		test_##suffix();				\
> +} while (0)
> +
> void test_mptcp(void)
> {
> -	if (test__start_subtest("base"))
> -		test_base();
> -	if (test__start_subtest("mptcpify"))
> -		test_mptcpify();
> +	RUN_MPTCP_TEST(base);
> +	RUN_MPTCP_TEST(mptcpify);
> 	if (test__start_subtest("default"))
> 		test_default();
> 	if (test__start_subtest("first"))
> -- 
> 2.40.1
>
>
>
