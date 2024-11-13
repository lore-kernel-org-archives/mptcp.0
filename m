Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D4670812
	for <mptcp@lists.linux.dev>; Wed, 13 Nov 2024 02:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731463671; cv=none; b=tlNz6mKpvEbgGB0yi+QZfNmIDtbx/mPIFaYoqQimYkI2EbSLfUVuf77bLi1bEHDKjyraDFMi6AxwgxyOEZCPP29u18qki5nL2mqwcvx33ei0CfxMeohfvQIcLXoafkLg1RaL1xEJV1hXZ5yvPZYLB1tqEmYu0xaMGJYfIUB9nWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731463671; c=relaxed/simple;
	bh=fTp/uGpc0yMepKwBIGNgzdJ9WKrqd2uMcnbj870ELcw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Bjztk3KuuH53G9X+lVO5eR9xI413Wk8O/ZRjDD+5esw6sCBK9AH4xTG3O7SlPMWx6wC7ezSojJn9vyztwhUAS6IEEjyngzEb1fDYxAvPMNmAFk8OGM/9K3m07yRyOr4oJpMUhBVfcsI/zBlXPMXD43L+myhg2MznDCjAgxdxTdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUF3gBQo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUF3gBQo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E86C4CECD;
	Wed, 13 Nov 2024 02:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731463671;
	bh=fTp/uGpc0yMepKwBIGNgzdJ9WKrqd2uMcnbj870ELcw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=oUF3gBQoI84lBknXucrpcrNNH7nbzuswa9cadl+dTkS22xy5Nv+TQ69XvLNnUzbfH
	 E//tMxlb5chL4UxQ5S+L+3zdHdlDTNxXxJ7caZQSPoJiMDXitTqdYKbt5Uqdm5JuJM
	 f1Ex6SkngjQ6xcW90kKOg7AwuEXozTxmK4Vouk8BzSNp1oeLV91BnGO18p3NLySxRU
	 8kv37+K0369uJjNBWLxB1NISE+WckgI6ZgzF7XwtP7BNCnLebS4T2uePMIsWXAwE80
	 ecnhT/gO877jCLrgTA8p5kTwN1ygylQM2D4dSZPaMcNyvfJr9s47iZEDMGCXC112JI
	 Ze8XDZwT0kACQ==
Date: Tue, 12 Nov 2024 18:07:50 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v9 06/13] Squash to "selftests/bpf: Add
 bpf_first scheduler & test"
In-Reply-To: <f3155bd767936df549ff0aaa094b44f9e70323ba.1730268415.git.tanggeliang@kylinos.cn>
Message-ID: <aad320b2-aeb4-12b1-5621-2e803827ec77@kernel.org>
References: <cover.1730268415.git.tanggeliang@kylinos.cn> <f3155bd767936df549ff0aaa094b44f9e70323ba.1730268415.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 30 Oct 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> 1. Update sched_init.
>
> 2. For drop bpf_object__find_map_by_name in test_bpf_sched(), change the
> first parameter of it as bpf_map.
>
> 3. Implement mptcp_subflow_set_scheduled in BPF.
>
> 4. Drop bpf_mptcp_subflow_ctx_by_pos.
>
> 5. Use the newly added bpf_for_each() helper to walk the conn_list.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> tools/testing/selftests/bpf/prog_tests/mptcp.c    | 15 +++++++++------
> tools/testing/selftests/bpf/progs/mptcp_bpf.h     | 14 ++++++++------
> .../testing/selftests/bpf/progs/mptcp_bpf_first.c |  4 ++--
> 3 files changed, 19 insertions(+), 14 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index b00af99c5c9d..a6574a537679 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -645,27 +645,30 @@ static void test_default(void)
> 	netns_free(netns);
> }
>
> -static void test_bpf_sched(struct bpf_object *obj, char *sched,
> +static void test_bpf_sched(struct bpf_map *map, char *sched,
> 			   bool addr1, bool addr2)
> {
> 	char bpf_sched[MPTCP_SCHED_NAME_MAX] = "bpf_";
> 	struct netns_obj *netns;
> 	struct bpf_link *link;
> -	struct bpf_map *map;
> +	int err;
>
> 	if (!ASSERT_LT(strlen(bpf_sched) + strlen(sched),
> 		       MPTCP_SCHED_NAME_MAX, "Scheduler name too long"))
> 		return;
>
> -	map = bpf_object__find_map_by_name(obj, sched);
> 	link = bpf_map__attach_struct_ops(map);
> -	if (CHECK(!link, sched, "attach_struct_ops: %d\n", errno))
> +	if (!ASSERT_OK_PTR(link, "attach_struct_ops"))
> 		return;
>
> -	netns = sched_init("subflow", strcat(bpf_sched, sched));
> +	netns = netns_new(NS_TEST, true);
> 	if (!netns)
> 		goto fail;
>
> +	err = sched_init("subflow", strcat(bpf_sched, sched));
> +	if (!ASSERT_OK(err, "sched_init"))
> +		goto fail;
> +
> 	send_data_and_verify(sched, addr1, addr2);
>
> fail:
> @@ -681,7 +684,7 @@ static void test_first(void)
> 	if (!ASSERT_OK_PTR(skel, "open_and_load: first"))
> 		return;
>
> -	test_bpf_sched(skel->obj, "first", WITH_DATA, WITHOUT_DATA);
> +	test_bpf_sched(skel->maps.first, "first", WITH_DATA, WITHOUT_DATA);
> 	mptcp_bpf_first__destroy(skel);
> }
>
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> index 3b20cfd44505..f8c917dc2c1c 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> @@ -42,6 +42,14 @@ mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
> 	return subflow->tcp_sock;
> }
>

Hi Geliang -

Thanks for the updates to this series. The change to a BPF-based helper 
does work around the pointer-handling issue, but it's important to be sure 
WRITE_ONCE() is being handled correctly.

> +#define WRITE_ONCE(x, val) ((*(volatile typeof(x) *) &(x)) = (val))

We initially added the C version of the mptcp_subflow_set_scheduled() 
helper because it wasn't clear how to handle WRITE_ONCE() in BPF. The only 
other implementation I found is in the cilium code (also GPLv2):

https://github.com/cilium/cilium/blob/main/bpf/include/bpf/compiler.h

It's a lot more complex than the macro added above (using an asm statement 
to set up the memory barrier). I don't know enough about low-level BPF and 
BPF toolchains to know that the cilium WRITE_ONCE() technique works 
everywhere - anyone else have a comment on this?

Another concern I have is that a lot of boilerplate BPF code is needed to 
set the scheduled bit in every BPF scheduler, and it's easy for a 
scheduler author to just skip the WRITE_ONCE() stuff and possibly 
introduce subtle write-ordering bugs. The C helper was easy to use 
correctly.

I'm not sure what the correct solution is yet. Geliang, do you have any 
ideas for an approach that works around the kfunc pointer limitations and 
also prevents WRITE_ONCE() bugs?

- Mat


> +
> +static __always_inline void
> +mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow, bool scheduled)
> +{
> +	WRITE_ONCE(subflow->scheduled, scheduled);
> +}
> +
> /* ksym */
> extern struct mptcp_sock *bpf_mptcp_sock_acquire(struct mptcp_sock *msk) __ksym;
> extern void bpf_mptcp_sock_release(struct mptcp_sock *msk) __ksym;
> @@ -52,10 +60,4 @@ bpf_mptcp_subflow_ctx(const struct sock *sk) __ksym;
> extern struct sock *
> bpf_mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow) __ksym;
>
> -extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context *subflow,
> -					bool scheduled) __ksym;
> -
> -extern struct mptcp_subflow_context *
> -bpf_mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos) __ksym;
> -
> #endif
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> index d57399b407a7..5d0f89c636f0 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> @@ -20,11 +20,11 @@ SEC("struct_ops")
> int BPF_PROG(bpf_first_get_subflow, struct mptcp_sock *msk,
> 	     struct mptcp_sched_data *data)
> {
> -	mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx_by_pos(data, 0), true);
> +	mptcp_subflow_set_scheduled(bpf_mptcp_subflow_ctx(msk->first), true);
> 	return 0;
> }
>
> -SEC(".struct_ops")
> +SEC(".struct_ops.link")
> struct mptcp_sched_ops first = {
> 	.init		= (void *)mptcp_sched_first_init,
> 	.release	= (void *)mptcp_sched_first_release,
> -- 
> 2.45.2
>
>
>
