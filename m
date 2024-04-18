Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D41376
	for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 00:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713399828; cv=none; b=TG5FjNlpR1cYjm7MlpUp8vMBJ6ewhTd4AgJLEgT2j9fumTm946pXtxII2Ha4Usd9+qmHpN3s5k87ry5pVFOtB/qNiGCdeGjK8GPCYa7FoMhVuIe5xs4y9E8RpHG5qKu/pM13xBnQXcvu1QqVqxSe5eszhRu+XlIz0XuOLrmuqy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713399828; c=relaxed/simple;
	bh=gcMhJgmTNx/GzxMv3+aBsKGm8AvgUkkArRrRU6i7fbk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mDdnc0GrlkCINTJHH4Yxn9Xg7vR3uS2M5yppUPo5CRGlUVNp191PltcI3oizOXA7lxneTmDr+ZHU4MGhUAlldcBM7DbTZ8bvTvQJjBy00aWA+cAkURrzrv6ZVtYs5C7eZt4VIoshJdSPhvyyJS5Zab0sIRWaZTzbiniAmtlgQsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEOokiQG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEOokiQG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD96CC072AA;
	Thu, 18 Apr 2024 00:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713399827;
	bh=gcMhJgmTNx/GzxMv3+aBsKGm8AvgUkkArRrRU6i7fbk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=GEOokiQG/ULUKHmcPnTV/X5LzuMvd3lX89TO40TOdSYTjOp5C6e9e8CaqTPoKSw27
	 zTm0S7v6rN7b8OOP0QPJxLu+K6yL90fEppyo9xxEYX+ekGfdEJ11yqJDqUIsdq0lyp
	 rMt9Ov6neW88bcrRNjXdJ2VXPFXrREBn6p/J6MO+pzVBowUHe2E7DY20PQ3uDo4w3H
	 ukGTjVqVeOHmWmK+d/nu8NSbCOIQO+wWjpFTVNleu6xsmhR0zlVzomRBN5NCRlTfMu
	 7DMFcHRkaBOewbUUc+wbwaHQPL3gvTognglTEkt7s2M9KYByH5EetIl6XZHrbycuAE
	 c5L1FO2PSjKow==
Date: Wed, 17 Apr 2024 17:23:46 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v9 4/8] Squash to "selftests/bpf: Add bpf_first
 scheduler & test"
In-Reply-To: <24d27a057abce37a93d3c43c02665f3399dc13bb.1713321357.git.tanggeliang@kylinos.cn>
Message-ID: <7191340c-51e9-47b9-c7c8-c3ec71a5a000@kernel.org>
References: <cover.1713321357.git.tanggeliang@kylinos.cn> <24d27a057abce37a93d3c43c02665f3399dc13bb.1713321357.git.tanggeliang@kylinos.cn>
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
> After squashing into this change, the patch "selftests/bpf: Add bpf_first
> test" can be merged into the patch "selftests/bpf: Add bpf_first scheduler"
> appending the following lines into commit log:
>
> '''
> This patch defines MPTCP_SCHED_TEST macro, a template for all scheduler
> tests. Every scheduler is identified by argument name, and use sysctl
> to set net.mptcp.scheduler as "bpf_name" to use this sched. Add two
> veth net devices to simulate the multiple addresses case. Use 'ip mptcp
> endpoint' command to add the new endpoint ADDR2 to PM netlink. Arguments
> addr1/add2 means whether the data has been sent on the first/second subflow
> or not. Send data and check bytes_sent of 'ss' output after it using
> send_data_and_verify().
>
> Using MPTCP_SCHED_TEST macro to add a new test for this bpf_first
> scheduler, the arguments "1 0" means data has been only sent on the
> first subflow ADDR1. Run this test by RUN_MPTCP_TEST macro.
> '''
>
> And update the subject to "selftests/bpf: Add bpf_first scheduler & test".
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> .../testing/selftests/bpf/prog_tests/mptcp.c  | 50 ++++++++++---------
> 1 file changed, 27 insertions(+), 23 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 1979c685ee24..504e00faf9e0 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -39,6 +39,7 @@
> #ifndef TCP_CA_NAME_MAX
> #define TCP_CA_NAME_MAX	16
> #endif
> +#define MPTCP_SCHED_NAME_MAX	16
>
> struct __mptcp_info {
> 	__u8	mptcpi_subflows;
> @@ -500,41 +501,45 @@ static void test_default(void)
> 	cleanup_netns(nstoken);
> }
>
> -static void test_first(void)
> +static void test_bpf_sched(struct bpf_object *obj, char *sched,
> +			   bool addr1, bool addr2)
> {
> -	struct mptcp_bpf_first *first_skel;
> -	int server_fd, client_fd;
> +	char bpf_sched[MPTCP_SCHED_NAME_MAX] = "bpf_";
> 	struct nstoken *nstoken;
> 	struct bpf_link *link;
> +	struct bpf_map *map;
>
> -	first_skel = mptcp_bpf_first__open_and_load();
> -	if (!ASSERT_OK_PTR(first_skel, "bpf_first__open_and_load"))
> +	map = bpf_object__find_map_by_name(obj, sched);
> +	link = bpf_map__attach_struct_ops(map);
> +	if (CHECK(!link, sched, "attach_struct_ops: %d\n", errno))
> 		return;
>
> -	link = bpf_map__attach_struct_ops(first_skel->maps.first);
> -	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops")) {
> -		mptcp_bpf_first__destroy(first_skel);
> -		return;
> -	}
> -
> -	nstoken = sched_init("subflow", "bpf_first");
> -	if (!ASSERT_OK_PTR(nstoken, "sched_init:bpf_first"))
> +	nstoken = sched_init("subflow", strcat(bpf_sched, sched));

Hi Geliang -

Thanks for the revision, I think the smaller macro containing a call to 
test_bpf_sched works well.

One last thing to ask: since the line above uses strcat() and 
MPTCP_SCHED_NAME_MAX==16 is fairly small (especially with the automatic 
"bpf_" prefix), please add an assert to check the length of the sched 
string. Otherwise it's pretty easy to accidentally create a buffer 
overflow with the MPTCP_SCHED_TEST() macro just by using a string over 11 
characters.


- Mat


> +	if (CHECK(!nstoken, sched, "sched_init: %d\n", errno))
> 		goto fail;
> -	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
> -	client_fd = connect_to_fd(server_fd, 0);
>
> -	send_data(server_fd, client_fd, "bpf_first");
> -	ASSERT_OK(has_bytes_sent(ADDR_1), "has_bytes_sent addr_1");
> -	ASSERT_GT(has_bytes_sent(ADDR_2), 0, "has_bytes_sent addr_2");
> +	send_data_and_verify(sched, addr1, addr2);
>
> -	close(client_fd);
> -	close(server_fd);
> fail:
> 	cleanup_netns(nstoken);
> 	bpf_link__destroy(link);
> -	mptcp_bpf_first__destroy(first_skel);
> }
>
> +#define MPTCP_SCHED_TEST(sched, addr1, addr2)			\
> +static void test_##sched(void)					\
> +{								\
> +	struct mptcp_bpf_##sched *skel;				\
> +								\
> +	skel = mptcp_bpf_##sched##__open_and_load();		\
> +	if (!ASSERT_OK_PTR(skel, "open_and_load:" #sched))	\
> +		return;						\
> +								\
> +	test_bpf_sched(skel->obj, #sched, addr1, addr2);	\
> +	mptcp_bpf_##sched##__destroy(skel);			\
> +}
> +
> +MPTCP_SCHED_TEST(first, WITH_DATA, WITHOUT_DATA);
> +
> static void test_bkup(void)
> {
> 	struct mptcp_bpf_bkup *bkup_skel;
> @@ -686,8 +691,7 @@ void test_mptcp(void)
> 	RUN_MPTCP_TEST(base);
> 	RUN_MPTCP_TEST(mptcpify);
> 	RUN_MPTCP_TEST(default);
> -	if (test__start_subtest("first"))
> -		test_first();
> +	RUN_MPTCP_TEST(first);
> 	if (test__start_subtest("bkup"))
> 		test_bkup();
> 	if (test__start_subtest("rr"))
> -- 
> 2.40.1
>
>
>
