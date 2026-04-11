Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04596288D0
	for <mptcp@lists.linux.dev>; Sat, 11 Apr 2026 00:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775868317; cv=none; b=grsXa9dbE+LNkd7UzpAb7IU7VpzEaqd/YEm7r4dv7emH9H0eyNlj6E1zZLzGcYs7sYgQ3TElGAL1g9/AQ30y6bKgknT5wXXxeb80HM1AfNCWEATkhyTuWbPYYDPaTsRdlhR5B3q0bmDCgQUBAyJYC7jTKD1WQYRI7frDCgkIRS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775868317; c=relaxed/simple;
	bh=dxlM76rJLQBS/y4D3Tz7G69KvWvXRxj/d+3Mu0ntXlc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VNCyaoe8spoyCS3bO1UJfGAfOxpkieEkXY5zsUZsVxGcITwXIiJou7QtvdiSbEefZffFISzWTagkAI+sQ0xSUjH+G55MI6ZtIl+4u9Wzp2or4WtGIlt800NIUEtrF6A1KRmpyjxcvrBPpUFS8aPKeKRzmnbO6C3mI29tGOR2wBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUJKlwqJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUJKlwqJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96040C19421;
	Sat, 11 Apr 2026 00:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775868316;
	bh=dxlM76rJLQBS/y4D3Tz7G69KvWvXRxj/d+3Mu0ntXlc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=AUJKlwqJCyrKLRmWl4qT7x6oW23rAUZ+/ocb7mHI37rjCtRcmjk9Mhn1AizLYw+dm
	 Tlpyr+tcfXlwJF3keUNcJzV0NRV8HSRL3d0qGy568BhAIrDDyjOJyUs0n/DWDS/1Xu
	 ctTY167IXqbOvZc03Uv5gGANT3hHv0rLLcnQXy2CwzGqAlaion2SfgW7/M17Lme1bj
	 oTS8qr1n4m+8Vo+KxprLUh/2rDnv/2o5ryltawZu4R4Wb+CeSN7hnhV6uSGPrUIR84
	 XuL/OfHiXJTIsm1+zUSr+ucoXeEAfJRpUjhsF5Vf0QZWdBHufrfUXzn6oRDXnqh52S
	 IcHxwTbJNbCSA==
Date: Fri, 10 Apr 2026 17:45:16 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v3 2/2] selftests/bpf: Update sockmap tests
 for MPTCP
In-Reply-To: <6ea1d998b51cf6cf68e08e6ae87c2e93888464ed.1773826662.git.tanggeliang@kylinos.cn>
Message-ID: <3000bb69-0df0-f0d9-1add-0d58c880faeb@kernel.org>
References: <cover.1773826662.git.tanggeliang@kylinos.cn> <6ea1d998b51cf6cf68e08e6ae87c2e93888464ed.1773826662.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 18 Mar 2026, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Update sockmap tests to reflect new MPTCP support. MPTCP sockets are now
> allowed in sockmap, so test expectations are adjusted accordingly.
>
> Use a different key (1) for MPTCP client sockets to validate sockmap.
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> tools/testing/selftests/bpf/prog_tests/mptcp.c | 16 ++++++++--------
> 1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 7f48fd9e94e1..4806ccb6b502 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -545,11 +545,11 @@ static void test_sockmap_with_mptcp_fallback(struct mptcp_sockmap *skel)
> 	close(listen_fd);
> }
>
> -/* Test sockmap rejection of MPTCP sockets - both server and client sides. */
> -static void test_sockmap_reject_mptcp(struct mptcp_sockmap *skel)
> +/* Test sockmap of MPTCP sockets - both server and client sides. */
> +static void test_sockmap_mptcp_support(struct mptcp_sockmap *skel)

Hi Geliang -

Beyond the very simple tests of checking the error values for MPTCP 
non-fallback sockets, is there other basic functionality that should now 
be working? Are any of the tests from test_sockmap_with_mptcp_fallback() 
now expected to work?

Thanks,
Mat


> {
> 	int listen_fd = -1, server_fd = -1, client_fd1 = -1;
> -	int err, zero = 0;
> +	int err, zero = 0, one = 1;
>
> 	/* start server with MPTCP enabled */
> 	listen_fd = start_mptcp_server(AF_INET, NULL, 0, 0);
> @@ -570,13 +570,13 @@ static void test_sockmap_reject_mptcp(struct mptcp_sockmap *skel)
> 	server_fd = accept(listen_fd, NULL, 0);
> 	err = bpf_map_update_elem(bpf_map__fd(skel->maps.sock_map),
> 				  &zero, &server_fd, BPF_NOEXIST);
> -	if (!ASSERT_EQ(err, -EOPNOTSUPP, "server should be disallowed"))
> +	if (!ASSERT_EQ(err, 0, "server should be allowed"))
> 		goto end;
>
> -	/* MPTCP client should also be disallowed */
> +	/* MPTCP client should also be allowed */
> 	err = bpf_map_update_elem(bpf_map__fd(skel->maps.sock_map),
> -				  &zero, &client_fd1, BPF_NOEXIST);
> -	if (!ASSERT_EQ(err, -EOPNOTSUPP, "client should be disallowed"))
> +				  &one, &client_fd1, BPF_NOEXIST);
> +	if (!ASSERT_EQ(err, 0, "client should be allowed"))
> 		goto end;
> end:
> 	if (client_fd1 >= 0)
> @@ -619,7 +619,7 @@ static void test_mptcp_sockmap(void)
> 		goto close_netns;
>
> 	test_sockmap_with_mptcp_fallback(skel);
> -	test_sockmap_reject_mptcp(skel);
> +	test_sockmap_mptcp_support(skel);
>
> close_netns:
> 	netns_free(netns);
> -- 
> 2.51.0
>
>
>
