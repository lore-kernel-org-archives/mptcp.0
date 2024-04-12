Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11BB33997
	for <mptcp@lists.linux.dev>; Fri, 12 Apr 2024 23:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712964738; cv=none; b=I0iRwKuXhFWQNi2VGNWlYAlPCKp/x0zlv8LNSoWkABcvv1ruEuVEnUhnUCgC5yW+JfIsYTSSYpbUVDZMDVJu6ktdykgqy30Lzr80Vcf297AybTVCjlyNYjQVtbgJ7BCGMD6LmhAhrQwg4Kvh2sRq0f7t8kepn8JGc1oyMcxF/LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712964738; c=relaxed/simple;
	bh=dboaD/KWCf5693sVQrwzEPpaUQLK98H17cFHFOnimsE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=h7tl9xvxvLllN9oqLx3FkWFztlEPWB0EsNrGCs3dAOh90r99KozaMfwKnIIPqbKsBAGPYpEeJxIxonz7pTyjXyvh8rHVMbd0OAWjS5nBDt74G/iewKynd6cV0R/DufP5xUtNHx34HbzWICh4C0APN1YW6WEX2P7RXao37ULExfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVmX1pen; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVmX1pen"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3EAC113CC;
	Fri, 12 Apr 2024 23:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712964738;
	bh=dboaD/KWCf5693sVQrwzEPpaUQLK98H17cFHFOnimsE=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=cVmX1penvs/9ZlZHBqRVryr6/RGzswNqIel59EYrrdXDf39d0JK24S0JcCZhZYUUq
	 fyifESmdCNsYlOhEa/WywkRD5ZCQc+pvVdtZEVrofDRr5/tBvVMIH8LGUPr+KHWpj4
	 34GTPDcpEyAPhXetqr+vnwT96nk+YnYLuGiOBzDf9bhdTeDLvVeRCDwdCGI/XEHLoN
	 3NLufZTKVjhXnNdq+XbIqFlwUh+X3nMnVz3YqTB7/V82hcu1jYHFVV5FHQTJ9qcQgE
	 28oIl3ktVYAzS6nPIwPwG7GKRtCm1Vpkul7xUQy7z9NYMOkc21yU5bqb4toBZR44wk
	 SoHtqPempC1LA==
Date: Fri, 12 Apr 2024 16:32:17 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v8 5/9] Squash to "selftests/bpf: Add bpf_first
 scheduler & test"
In-Reply-To: <3a8e8688d120d18525004dec7d214a901ce8f30c.1712714407.git.tanggeliang@kylinos.cn>
Message-ID: <a13fc562-ad37-5c63-17cd-68ff88170af2@kernel.org>
References: <cover.1712714407.git.tanggeliang@kylinos.cn> <3a8e8688d120d18525004dec7d214a901ce8f30c.1712714407.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 10 Apr 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> After squashing into this change, the patch "selftests/bpf: Add bpf_first
> test" can be merged into the patch "selftests/bpf: Add bpf_first scheduler"
> appending the following lines into commit log:
>
> '''
> Using MPTCP_SCHED_TEST macro to add a new test for this bpf_first
> scheduler, the arguments "1 0" means data has been only sent on the
> first subflow ADDR1. Run this test by RUN_MPTCP_TEST macro.
> '''
>
> And update the subject to "selftests/bpf: Add bpf_first scheduler & test".
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +------------------
> .../selftests/bpf/progs/mptcp_bpf_first.c     |  1 +
> 2 files changed, 3 insertions(+), 36 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 0144db1425ed..d56a5aa0cf85 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -530,40 +530,7 @@ skel_destroy:							\
> 	mptcp_bpf_##sched##__destroy(skel);			\
> }
>
> -static void test_first(void)
> -{
> -	struct mptcp_bpf_first *first_skel;
> -	int server_fd, client_fd;
> -	struct nstoken *nstoken;
> -	struct bpf_link *link;
> -
> -	first_skel = mptcp_bpf_first__open_and_load();
> -	if (!ASSERT_OK_PTR(first_skel, "bpf_first__open_and_load"))
> -		return;
> -
> -	link = bpf_map__attach_struct_ops(first_skel->maps.first);
> -	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
> -		mptcp_bpf_first__destroy(first_skel);
> -		return;
> -	}
> -
> -	nstoken = sched_init("subflow", "bpf_first");
> -	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_first"))
> -		goto fail;
> -	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
> -	client_fd = connect_to_fd(server_fd, 0);
> -
> -	send_data(server_fd, client_fd, "bpf_first");
> -	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
> -	ASSERT_GT(has_bytes_sent(ADDR_2), 0, "has_bytes_sent addr_2");
> -
> -	close(client_fd);
> -	close(server_fd);
> -fail:
> -	cleanup_netns(nstoken);
> -	bpf_link__destroy(link);
> -	mptcp_bpf_first__destroy(first_skel);
> -}
> +MPTCP_SCHED_TEST(first, WITH_DATA, WITHOUT_DATA);
>
> static void test_bkup(void)
> {
> @@ -716,8 +683,7 @@ void test_mptcp(void)
> 	RUN_MPTCP_TEST(base);
> 	RUN_MPTCP_TEST(mptcpify);
> 	RUN_MPTCP_TEST(default);
> -	if (test__start_subtest("first"))
> -		test_first();
> +	RUN_MPTCP_TEST(first);
> 	if (test__start_subtest("bkup"))
> 		test_bkup();
> 	if (test__start_subtest("rr"))
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> index 23a3e8e69e8f..2d067b25d60b 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> @@ -1,5 +1,6 @@
> // SPDX-License-Identifier: GPL-2.0
> /* Copyright (c) 2022, SUSE. */
> +/* Copyright (c) 2024, Kylin Software */

Hi Geliang -

Please wait until making a code change within this file before updating 
the copyright. This comment also applies to patches 6 through 9.

- Mat
