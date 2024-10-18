Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DBD201276
	for <mptcp@lists.linux.dev>; Fri, 18 Oct 2024 11:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729249574; cv=none; b=sI1nAsDqOy5X5Bt9vjncx1zBTii458VuvCVAjgMDGMs0TzwDvYnLopbYsxMVHIXGDRFJtt+QliyI6ytSVsvjbUYNHYK6+oPdoCfA3J9+XoLqpHHfNYFcNRgPTmvmtsGMu/a49j1D5m72z75zu9ko/L6fzT2WR+NU2DIsY8pdAJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729249574; c=relaxed/simple;
	bh=WfiXmP88vUQUf+uFTpMhwA62CjJxaxRCVnmGE4NKaq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OOgfci7mmX3awRJlltLWcP47N/cp6x+XOquFtUViTw2ZEsgyqXjgRfFWTwpqi80LzIHOgwmW8A7cZwFsd5tP8Wc6s2FZxUKDvDhlQlOv9HXwVKJ39tSHD7Xu5G+w4mLHcQmghZ6DFrDADY35iBDQHs0ezRxtyMTPml5uFIQvfIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkknqbkq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkknqbkq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E75C4CEC3;
	Fri, 18 Oct 2024 11:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729249573;
	bh=WfiXmP88vUQUf+uFTpMhwA62CjJxaxRCVnmGE4NKaq4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hkknqbkq4CFkjQfsdZQmQt+iP2JobRXAmXJBKEyBfH1zt29QvJ0N8vOqPk3fYj+IE
	 AH277gyiFbWxGHH5M3doM9217D+a7Cse8kFjVnPdmF5cLl+4iEqUeFvlvBlOw7sltD
	 tJrqofp48myRFdEDuQMyJImxhE3ILMwa26SK2kd5HGKSa1/E+d0kM1AYscrhV0YHbK
	 vaSKqHVkRTGgrXpbto1RMFgBTFR0wOG1mvRoCEelWppby0hE+gZgB1uRUDxRtcmvK+
	 J3ULy3Hn4LJOzBydNS5yfvTMNxj2SHx4292JIxxC0Zv33kmSV4f2SJv1nTyxxBJvOb
	 JXJjDsAlL9CFQ==
Message-ID: <4f585c3f-a7d5-45f1-8360-c260161903b3@kernel.org>
Date: Fri, 18 Oct 2024 13:06:11 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH mptcp-next v11 6/9] selftests/bpf: Add mptcp_subflow
 bpf_iter subtest
Content-Language: en-GB
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1729242644.git.tanggeliang@kylinos.cn>
 <67cbbd7ff515dcc421605b24c14c734fd3263e42.1729242644.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <67cbbd7ff515dcc421605b24c14c734fd3263e42.1729242644.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

Thank you for the new version.

On 18/10/2024 11:18, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds a subtest named test_iters_subflow to load and verify the
> newly added mptcp_subflow type bpf_iter example in test_mptcp. Use the
> helper endpoint_init() to add 3 new subflow endpoints. Send a byte of
> message to start the mptcp connection, and wait for new subflows to be
> added. getsockopt() is invoked to trigger the "cgroup/getsockopt" test
> program "iters_subflow". Check if skel->bss->ids equals 10 to verify
> whether this mptcp_subflow bpf_iter loops correctly as expected.

Can we squash this commit into "selftests/bpf: Add mptcp_subflow
bpf_iter test prog"?

These two commits don't make sense alone, and it might be easier for the
reviewers to see in the same patch what is being done in kernelspace via
BPF, and in userspace, instead of going from one to another. No?

> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 02fdff87df2d..0f00eef7aef5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c

(...)

> @@ -509,6 +510,72 @@ static void test_subflow(void)
>  	close(cgroup_fd);
>  }
>  
> +static void run_iters_subflow(void)
> +{
> +	int server_fd, client_fd;
> +	char cc[TCP_CA_NAME_MAX];
> +	socklen_t len;
> +	int err;
> +
> +	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
> +	if (!ASSERT_OK_FD(server_fd, "start_mptcp_server"))
> +		return;
> +
> +	client_fd = connect_to_fd(server_fd, 0);
> +	if (!ASSERT_OK_FD(client_fd, "connect_to_fd"))
> +		goto close_server;
> +
> +	send_byte(client_fd);
> +	wait_for_new_subflows(client_fd);
> +
> +	len = sizeof(cc);
> +	err = getsockopt(client_fd, SOL_TCP, TCP_CONGESTION, cc, &len);
> +	if (ASSERT_OK(err, "getsockopt(client_fd, TCP_CONGESTION)"))
> +		ASSERT_STREQ(cc, "cubic", "cc");

You cannot assume "cubic" is the expected CC: it can be changed via
kernel config we don't fully control here.

Also, it might be confusing to get the CC, people might ask why while I
guess you are fine with any socket option, all you want is a trigger for
the BPF program I suppose. In this case, why not using TCP_IS_MPTCP (or
MPTCP_INFO)?

  /* mainly to trigger the BPF program */
  err = getsockopt(client_fd, SOL_TCP, TCP_IS_MPTCP, &mptcp, &len);

> +
> +	close(client_fd);
> +close_server:
> +	close(server_fd);
> +}
> +
> +static void test_iters_subflow(void)
> +{
> +	struct mptcp_bpf_iters *skel;
> +	struct nstoken *nstoken;
> +	int cgroup_fd;
> +
> +	cgroup_fd = test__join_cgroup("/iters_subflow");
> +	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup: iters_subflow"))
> +		return;
> +
> +	skel = mptcp_bpf_iters__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_load: iters_subflow"))
> +		goto close_cgroup;
> +
> +	skel->links.iters_subflow = bpf_program__attach_cgroup(skel->progs.iters_subflow,
> +							       cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links.iters_subflow, "attach getsockopt"))
> +		goto skel_destroy;
> +
> +	nstoken = create_netns();
> +	if (!ASSERT_OK_PTR(nstoken, "create_netns: iters_subflow"))
> +		goto skel_destroy;
> +
> +	if (endpoint_init("subflow", 4) < 0)
> +		goto close_netns;
> +
> +	run_iters_subflow();
> +
> +	ASSERT_EQ(skel->bss->ids, 10, "subflow ids");

Can you add a comment just above to explain why 10? Simply:

  /* 1 + 2 + 3 + 4 = 10 */

That will help reviewers and devs later.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

