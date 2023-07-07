Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460F9168BC
	for <mptcp@lists.linux.dev>; Fri,  7 Jul 2023 17:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C31F9C433C7;
	Fri,  7 Jul 2023 17:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688752457;
	bh=rEapzgy1XAJlA8j9ba+OSwM+KqqXQnUfBT8+eQ1oDyY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=RTKKVgUlENJRbeuLIUBG4XViG+urY75QAp3G+J2wWNrg1cl12HZl6WgXnPkjYSNLD
	 f+YBeRfcd1BSLW9ccVHBJPkHE0T7RWGVEjrBSce+oiLE3OOxq/EW5rlNXciI+nV5MW
	 eyTsWmqGL7rWddfDUiNs1grDtLgFVTt/fnFAt4tTjw9p4ztoStwTIYHjKu2NzsjuHR
	 pbMwAIR1YwXZCTNDMYNSBPbynsrft0D+qNmOF6fyQHVHXS2HrKF02G0Qq1f4feQfGZ
	 1zeiqzdrZ2cqqIJ349czKl2hDjnjVJNazgaHB2N2O3bfkyfbMQXhb7zuW3klKwSlFp
	 dxW1ufLwTzWgw==
Date: Fri, 7 Jul 2023 10:54:16 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 07/10] selftests/bpf: Add bpf_stale test
In-Reply-To: <fdec34dec183bc427faebf45f8feb3f88a575478.1687829823.git.geliang.tang@suse.com>
Message-ID: <be8e77a8-1fa3-230c-9bc7-6b23123a4280@kernel.org>
References: <cover.1687829823.git.geliang.tang@suse.com> <fdec34dec183bc427faebf45f8feb3f88a575478.1687829823.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 27 Jun 2023, Geliang Tang wrote:

> This patch adds the bpf_stale scheduler test: test_stale(). Use sysctl to
> set net.mptcp.scheduler to use this sched. Add two veth net devices to
> simulate the multiple addresses case. Use 'ip mptcp endpoint' command to
> add the new endpoint ADDR_2 to PM netlink. Send data and check bytes_sent
> of 'ss' output after it to make sure the data has been only sent on ADDR_1
> since ADDR_2 is set as stale.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> .../testing/selftests/bpf/prog_tests/mptcp.c  | 38 +++++++++++++++++++
> 1 file changed, 38 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 4b346eeaf8e2..851ea32dc1d0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -11,6 +11,7 @@
> #include "mptcp_bpf_bkup.skel.h"
> #include "mptcp_bpf_rr.skel.h"
> #include "mptcp_bpf_red.skel.h"
> +#include "mptcp_bpf_stale.skel.h"
>
> char NS_TEST[32];
>
> @@ -488,6 +489,41 @@ static void test_red(void)
> 	mptcp_bpf_red__destroy(red_skel);
> }
>
> +static void test_stale(void)
> +{
> +	struct mptcp_bpf_stale *stale_skel;
> +	int server_fd, client_fd;
> +	struct nstoken *nstoken;
> +	struct bpf_link *link;
> +
> +	stale_skel = mptcp_bpf_stale__open_and_load();
> +	if (!ASSERT_OK_PTR(stale_skel, "bpf_stale__open_and_load"))
> +		return;
> +
> +	link = bpf_map__attach_struct_ops(stale_skel->maps.stale);
> +	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
> +		mptcp_bpf_stale__destroy(stale_skel);
> +		return;
> +	}
> +
> +	nstoken = sched_init("subflow", "bpf_stale");
> +	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_stale"))
> +		goto fail;
> +	server_fd = start_mptcp_server(AF_INET, ADDR_1, 0, 0);
> +	client_fd = connect_to_fd(server_fd, 0);
> +
> +	send_data(server_fd, client_fd, "bpf_stale");
> +	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
> +	ASSERT_GT(has_bytes_sent(ADDR_2), 0, "has_bytes_sent addr_2");

I don't think it is guaranteed that ADDR_2 will always be at index 1 like 
the bpf_stale_get_subflow() expects. How about using checking for an 
odd/even value in the last byte of the IPv4 addresses for ADDR_1/ADDR_2 
instead?

- Mat

> +
> +	close(client_fd);
> +	close(server_fd);
> +fail:
> +	cleanup_netns(nstoken);
> +	bpf_link__destroy(link);
> +	mptcp_bpf_stale__destroy(stale_skel);
> +}
> +
> void test_mptcp(void)
> {
> 	if (test__start_subtest("base"))
> @@ -502,4 +538,6 @@ void test_mptcp(void)
> 		test_rr();
> 	if (test__start_subtest("red"))
> 		test_red();
> +	if (test__start_subtest("stale"))
> +		test_stale();
> }
> -- 
> 2.35.3
>
>
>
