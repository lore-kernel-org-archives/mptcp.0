Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77457632
	for <mptcp@lists.linux.dev>; Sat,  6 Apr 2024 00:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712363502; cv=none; b=Ax+Cmq65YP4X30rzy1i1MsMSslNVgvo9G680Z4bsnp1BGV1+XqDYZWKnwsAl9fvYrQisq+9fPSiLYEgK5zT1wUqD28Qp/pjbkIpxhqn+l/qvSFi6HRLGxjfMPWnYDgv3OeMybX5A8vRXlmywI3sgmjGJyRIilJJNxXScSpsel1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712363502; c=relaxed/simple;
	bh=EhAOSrNTSmsNJdzqLVpdmsEaGK1HDwrLSXs1jpR/wdo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R0/Hz8rUoGwtLnHK+HB/dupco0FRUKIRCthc0+LOy2H0uRwa5BcTpqDDHt05ptyCcbACr/OnVDt5+/kEjaRj5i++8QxHMMuavYKO7LaJQ/0LaUQciSfXmEi+hiBjCc9feL6Hyfpapj4ctqejlAQUaJha/9ZsKSIWsmefPc3ByRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pjtjdk18; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pjtjdk18"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DEBC433C7;
	Sat,  6 Apr 2024 00:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712363502;
	bh=EhAOSrNTSmsNJdzqLVpdmsEaGK1HDwrLSXs1jpR/wdo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=pjtjdk187IW0iZfeLZDCXCRr78XeP5V0m4gmffTU2F5ei8yGss/mz9s07aladvHjw
	 EHMHapFujT3o6LVJUYeqksR79mV6DomC0d7u/NYjUvJaFAu30NbnB3lPgjas/8o+ZG
	 FEW/w/21noX7uyFLvRsT57jblp58iLNLLxGCyO8FMPPWUlHs6iJVZZRk1+QcXDPxE7
	 g0fMf4o4a5wZFsHnHoadIoZM9BigdaBp7jxcw8HeAu9xfxHhb6WZHcp3RRQFCvnKOy
	 bgqNTuC6LPmIsCwo3IjQHd69mbb6e1MNxVl6P2DPMQTUXY9QEwQH0LvtEdcMK9eO6j
	 CnEG5DGaxNc0w==
Date: Fri, 5 Apr 2024 17:31:41 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v6 5/8] selftests/bpf: Add MPTCP_BASE_TEST
 macro
In-Reply-To: <30f9ba0f3b08b5be92653a9328007a16bbff8720.1712042529.git.tanggeliang@kylinos.cn>
Message-ID: <f9daffc3-c1a6-0ec3-f821-107ab97f551c@kernel.org>
References: <cover.1712042529.git.tanggeliang@kylinos.cn> <30f9ba0f3b08b5be92653a9328007a16bbff8720.1712042529.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 2 Apr 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> This patch adds a macro MPTCP_BASE_TEST to unify all MPTCP tests.
> test_mptcp_sock() can be replaced by MPTCP_BASE_TEST(mptcp_sock),
> and test_mptcpify() can be replaced by MPTCP_BASE_TEST(mptcpify).
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> .../testing/selftests/bpf/prog_tests/mptcp.c  | 98 +++++++------------
> 1 file changed, 35 insertions(+), 63 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 50a932e3ad23..6043947f178c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -224,37 +224,6 @@ static void run_mptcp_sock(int cgroup_fd, struct mptcp_sock *skel)
> 	close(server_fd);
> }
>
> -static void test_mptcp_sock(void)
> -{
> -	struct nstoken *nstoken = NULL;
> -	struct mptcp_sock *sock_skel;
> -	int cgroup_fd, err;
> -
> -	cgroup_fd = test__join_cgroup("/mptcp");
> -	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
> -		return;
> -
> -	sock_skel = mptcp_sock__open_and_load();
> -	if (!ASSERT_OK_PTR(sock_skel, "skel_open_load"))
> -		goto out;
> -
> -	err = mptcp_sock__attach(sock_skel);
> -	if (!ASSERT_OK(err, "skel_attach"))
> -		goto out;
> -
> -	nstoken = create_netns();
> -	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
> -		goto fail;
> -
> -	run_mptcp_sock(cgroup_fd, sock_skel);
> -
> -fail:
> -	cleanup_netns(nstoken);
> -	mptcp_sock__destroy(sock_skel);
> -out:
> -	close(cgroup_fd);
> -}
> -
> static int verify_mptcpify(int server_fd, int client_fd)
> {
> 	struct __mptcp_info info;
> @@ -310,43 +279,46 @@ static void run_mptcpify(int cgroup_fd, struct mptcpify *skel)
> 	close(server_fd);
> }
>
> -static void test_mptcpify(void)
> -{
> -	struct nstoken *nstoken = NULL;
> -	struct mptcpify *mptcpify_skel;
> -	int cgroup_fd;
> -	int err;
> -
> -	cgroup_fd = test__join_cgroup("/mptcpify");
> -	if (!ASSERT_GE(cgroup_fd, 0, "test__join_cgroup"))
> -		return;
> -
> -	mptcpify_skel = mptcpify__open_and_load();
> -	if (!ASSERT_OK_PTR(mptcpify_skel, "skel_open_load"))
> -		goto out;
> -
> -	err = mptcpify__attach(mptcpify_skel);
> -	if (!ASSERT_OK(err, "skel_attach"))
> -		goto out;
> -
> -	nstoken = create_netns();
> -	if (!ASSERT_OK_PTR(nstoken, "create_netns"))
> -		goto fail;
> -
> -	run_mptcpify(cgroup_fd, mptcpify_skel);
> -
> -fail:
> -	cleanup_netns(nstoken);
> -	mptcpify__destroy(mptcpify_skel);
> -out:
> -	close(cgroup_fd);
> -}
> -
> static const unsigned int total_bytes = 10 * 1024 * 1024;
> #define ADDR_1	"10.0.1.1"
> #define ADDR_2	"10.0.1.2"
> #define PORT_1	10001
>
> +#define MPTCP_BASE_TEST(name)					\

Hi Geliang -

I see why you're using a macro here, it's important to have the ASSERT 
macros report the right __func__ name. However I prefer to avoid a macro 
this complicated, since navigating multiple layers of macros when trying 
to debug a failure gets confusing. The boilerplate code is tempting to 
factor out, but for the test code here I don't think it's worth it.

If there are other discussion threads about this refactoring that I missed 
please give me a lore URL so I can better understand the rationale.

Thanks,
Mat

> +static void test_##name(void)					\
> +{								\
> +	struct nstoken *nstoken;				\
> +	int cgroup_fd, err;					\
> +	struct name *skel;					\
> +								\
> +	cgroup_fd = test__join_cgroup("/" #name);		\
> +	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup " #name))	\
> +		return;						\
> +								\
> +	skel = name##__open_and_load();				\
> +	if (!ASSERT_OK_PTR(skel, "skel_open_load " #name))	\
> +		goto close_cgroup;				\
> +								\
> +	err = name##__attach(skel);				\
> +	if (!ASSERT_OK(err, "skel_attach " #name))		\
> +		goto skel_destroy;				\
> +								\
> +	nstoken = create_netns();				\
> +	if (!ASSERT_OK_PTR(nstoken, "create_netns " #name))	\
> +		goto skel_destroy;				\
> +								\
> +	run_##name(cgroup_fd, skel);				\
> +								\
> +	cleanup_netns(nstoken);					\
> +skel_destroy:							\
> +	name##__destroy(skel);					\
> +close_cgroup:							\
> +	close(cgroup_fd);					\
> +}
> +
> +MPTCP_BASE_TEST(mptcp_sock);
> +MPTCP_BASE_TEST(mptcpify);
> +
> static struct nstoken *sched_init(char *flags, char *sched)
> {
> 	struct nstoken *nstoken;
> -- 
> 2.40.1
>
>
>
