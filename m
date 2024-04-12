Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7A114C584
	for <mptcp@lists.linux.dev>; Fri, 12 Apr 2024 23:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712964621; cv=none; b=tt3w0QRTkOXqBN3+19L5J9+hZI08dWvbr4uJbbLBLN9wmtOTzGobjpKdjRBsSbzcPC72KNhQ+MTXLogOhtY3xYNcVlk3G4WsLo9/BIuYYAF845lCPDV+bo8EWSYZoZvnyLa43lyDGMBC3z4H68BeuEdCrd8vARvCK1tarzcvGoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712964621; c=relaxed/simple;
	bh=2xXhO2wCP4wITuzWvWjSp8Ykp2S2DixSfGl1h9p5Q80=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HYs1lic3TjYCGX1ntGcHbPp/MgiwiTc3CwVqQ8zp+QyatwmpaZXE1eW1b16NXCvwYWI6VVfanKm8O4ILOQkIMZ9LBcwP3eubYlOqOsyaCLfMzYc2/EQFRCHsFSC7nqr7uNQGEQKYaDSwdPvPLdgzyrnNRt36vUge/H4uP++0rjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cF6AJPQW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cF6AJPQW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A28C113CC;
	Fri, 12 Apr 2024 23:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712964621;
	bh=2xXhO2wCP4wITuzWvWjSp8Ykp2S2DixSfGl1h9p5Q80=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=cF6AJPQWXlFXznze2PygbRhMXofZ4isoFCnPAJdm+4Zxq0rsWSlo9nQNqlKOwXr/k
	 nkeHVodE0fboe3MuDmV1Mr3mQ1uGvIBe0H5NSisAs43FmGDjI60UJSOi090yjDCLdp
	 quFNV5RrphGayw9aFq22ussg/Efo4xZUDT8NZBhCBU6TS41gODZ1leFuEiogfwp4VV
	 NdunYt66i+/Ivotb4b6PgWRPY8i6H6n8Pu+OjLIi+rsFUBq6ljvw4qg2lrboxLIpH4
	 NsSDlfdWM8PlpgMI/vektNaWNK2ukK0QrM3iuBmiHl3ftJXUvSrMHD6rAe6FJL4otu
	 H/IMIF8LXMMrQ==
Date: Fri, 12 Apr 2024 16:30:20 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v8 4/9] Squash to "selftests/bpf: Add bpf
 scheduler test" 3 MPTCP_SCHED_TEST
In-Reply-To: <ad3d2ce4863dc542d754471d8e566c084a0bc52c.1712714407.git.tanggeliang@kylinos.cn>
Message-ID: <320f4eef-a941-a4ba-64a3-608bbc9982eb@kernel.org>
References: <cover.1712714407.git.tanggeliang@kylinos.cn> <ad3d2ce4863dc542d754471d8e566c084a0bc52c.1712714407.git.tanggeliang@kylinos.cn>
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
> Please append this into commit log:
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
> '''
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> .../testing/selftests/bpf/prog_tests/mptcp.c  | 30 +++++++++++++++++++
> 1 file changed, 30 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index e8df18c28961..0144db1425ed 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -500,6 +500,36 @@ static void test_default(void)
> 	cleanup_netns(nstoken);
> }
>
> +#define MPTCP_SCHED_TEST(sched, addr1, addr2)			\
Hi Geliang -

I saw Matthieu's question on v6 about the use of this large macro. 
(https://lore.kernel.org/mptcp/f44d5960-8aa3-4914-bae3-4f0c072e07b4@kernel.org/)

I agree with him that some common code could be factored out without 
needing the big macro.

> +static void test_##sched(void)					\
> +{								\
> +	struct mptcp_bpf_##sched *skel;				\

This struct is specific to each scheduler's skeleton header

> +	struct nstoken *nstoken;				\
> +	struct bpf_link *link;					\
> +	struct bpf_map *map;					\
> +								\
> +	skel = mptcp_bpf_##sched##__open_and_load();		\
> +	if (!ASSERT_OK_PTR(skel, "open_and_load:" #sched))	\
> +		return;						\

and so is this __open_and_load() function call. However, only skel->obj is 
used after this point (except for the final line) and it is generic. So 
the code below here can be refactored as regular code to reduce the 
boilerplate.

> +								\
> +	map = bpf_object__find_map_by_name(skel->obj, #sched);	\
> +	link = bpf_map__attach_struct_ops(map);			\
> +	if (!ASSERT_OK_PTR(link, "attach_struct_ops:" #sched))	\
> +		goto skel_destroy;				\
> +								\
> +	nstoken = sched_init("subflow", "bpf_" #sched);		\
> +	if (!ASSERT_OK_PTR(nstoken, "sched_init:" #sched))	\
> +		goto link_destroy;				\
> +								\
> +	send_data_and_verify(#sched, addr1, addr2);		\
> +								\
> +	cleanup_netns(nstoken);					\
> +link_destroy:							\
> +	bpf_link__destroy(link);				\

Boilerplate ends here.

> +skel_destroy:							\
> +	mptcp_bpf_##sched##__destroy(skel);			\
> +}
> +

I think non-macro refactoring would also help in creating future 
scheduler-specific tests.


- Mat
