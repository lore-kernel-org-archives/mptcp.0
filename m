Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE8312E48
	for <mptcp@lists.linux.dev>; Mon,  9 Sep 2024 01:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725847171; cv=none; b=cpdRYR2ZZ41iqagtihNkQUEsGpZZn1CNRMyY3cGFq4YGyl6b3X1jBf5Pmh50XCLXCW8NP6YgteO5mk3OnaLyXYQuDUxmHL3X/B/MjAeJ1JhLHKmDF7JQDSISlQxsLEhn891M9Z0qn2W9TceZbEAdNEXy4iMu6UO6oMfH3GcuFmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725847171; c=relaxed/simple;
	bh=uC3Q03+dYgbwdHKYvoXmL/EcdltHi4FJ2sGwK+Wv4rA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k8HJENpiPcf1KRoGZZFRQAzg3/EPsGjY+Wp9+TvYOGK/6OS3PAVr/rjsRYm5iExVOLeaIBiukAWs9HZhLq796eIMSoidQJrG6a74VFJ1GzacCALgBN3e3rhktGZJxYjoZX3Q7Xr+BsiiD1dP25HTX9ZqCofMxgpi8n7lh63PB1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HgRgBlzp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HgRgBlzp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FDBC4CEC3;
	Mon,  9 Sep 2024 01:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725847171;
	bh=uC3Q03+dYgbwdHKYvoXmL/EcdltHi4FJ2sGwK+Wv4rA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=HgRgBlzpmpSIZWGE9apXYDu0WBpmXVHgPlmq6NRYK8Uj0/4oVnAbkTqrnaNL2hhYK
	 hWwmBc6ExJ32Y1Dkthdseg979vx5juSxJktZVx5eGXyvyJGoM1gjuXI6dvW3mPy5Sc
	 8mYcm8Wr+SdiTRA27NUjdjc8jd9hvHiEd+fOTkRxo0W0uG8ardEuNYLAbQ5tLFKAg4
	 XsREp/1OPlGJ5FvdiMzFhLFdYitT6bf2sPu1lObeuqzNTIgsh58FDSX2CMupuWd6n1
	 HSMvsGecd82EkYjq2WZicdKSrXMIouUYcAlJeP5xPbADZQ39nUT5ME3QqiWzM2+vba
	 DUyUQsrX0VWtA==
Message-ID: <2a5f12511ca3f8a2952b661a10e52c939beb2686.camel@kernel.org>
Subject: Re: [PATCH mptcp-next] Squash to "selftests/bpf: Add mptcp subflow
 subtest"
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Mon, 09 Sep 2024 09:59:25 +0800
In-Reply-To: <d5598209aecfc8fe58f9a93dc802817b041785a9.1725680751.git.tanggeliang@kylinos.cn>
References: 
	<d5598209aecfc8fe58f9a93dc802817b041785a9.1725680751.git.tanggeliang@kylinos.cn>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Superseded. Move into "cleanups for bpf schedulers" set v2.

Thanks,
-Geliang

On Sat, 2024-09-07 at 11:45 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Should use dedicated ASSERT_OK_FD() to check the fds.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/bpf/prog_tests/mptcp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 93869c873cad..987692863fde 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -394,11 +394,11 @@ static void run_subflow(void)
>  	socklen_t len;
>  
>  	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
> -	if (!ASSERT_GE(server_fd, 0, "start_mptcp_server"))
> +	if (!ASSERT_OK_FD(server_fd, "start_mptcp_server"))
>  		return;
>  
>  	client_fd = connect_to_fd(server_fd, 0);
> -	if (!ASSERT_GE(client_fd, 0, "connect to fd"))
> +	if (!ASSERT_OK_FD(client_fd, "connect_to_fd"))
>  		goto close_server;
>  
>  	send_byte(client_fd);
> @@ -429,7 +429,7 @@ static void test_subflow(void)
>  	struct bpf_link *link;
>  
>  	cgroup_fd = test__join_cgroup("/mptcp_subflow");
> -	if (!ASSERT_GE(cgroup_fd, 0, "join_cgroup: mptcp_subflow"))
> +	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup: mptcp_subflow"))
>  		return;
>  
>  	skel = mptcp_subflow__open_and_load();

