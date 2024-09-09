Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9254D134AB
	for <mptcp@lists.linux.dev>; Mon,  9 Sep 2024 02:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725847294; cv=none; b=SuePz3YWXwZGljgNeOJtkC1biFdGHGBZwfBc1H90k43o6LHFwoUZKHPQDfpHFfhtZKdJ7MVYRIMD/C8Zt6JLYGXJAI7O2f1Hp4IZZtr3UXv7JznZNx6KayycyZSuKtes2UP907syScL8/f0DCttpHdQoVrq8IRchI9FraKLJldU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725847294; c=relaxed/simple;
	bh=wFgN82aDs7fBbgm+vwQPgpwRab7P/zrD4FMDHluWbsA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KszlkdFpx/FbLeYh2LVOH8LFujzviHMF3lCtZ+kbRbV+TS2aLVhOZ6jlf2rQwkb3Ss/CLlEQ5TaqZdCQGEktn9O3L6dhrUwqK8LbfkHk+kdp2KxCckFt23s5k3z2YnN2HUr+cvW6+OzwvcLxutdy3J3Yfbi96sMz8F6uSyoBdtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWjf04wG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWjf04wG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53877C4CEC3;
	Mon,  9 Sep 2024 02:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725847294;
	bh=wFgN82aDs7fBbgm+vwQPgpwRab7P/zrD4FMDHluWbsA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pWjf04wGHt9ZH4FPHzmskv1QEjS9sk03ufJme2J/IDOAVm1cCIhXfbXzqwRK7ziOs
	 G9AaKR4LPpUDxHFeDOgdUR7U1oEdYVLDXj3eqB9B0aLkOWtqUPIy1FGWvk0maO/+qV
	 B1Tx5YlTFu5SjRZLF8zDncM7p1elYcPg2mw7FKhL5/PBWdBwiiwq4F557WaEDquC+o
	 wFSfnqCDYKrP0y2RY707Ysn4Zp8kwe//wWusFU1aMcQcsYlr6msdd1YMrDyp/mW6h0
	 eloXYsYMWlbxx5tIiFVsquOVvtcFiBiEIVJIpuBBrquDL8984ZDNGA/9n+QHRUSZY1
	 Vl0ScQhb3/+Rg==
Message-ID: <32fef373600d8d96c90819d7fd8731ed91fc4c25.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v2 3/4] Squash to "selftests/bpf: Add bpf
 scheduler test"
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Mon, 09 Sep 2024 10:01:30 +0800
In-Reply-To: <bc0240881dcbd9400e128cd9e4024a12b86aec9e.1725846806.git.tanggeliang@kylinos.cn>
References: <cover.1725846806.git.tanggeliang@kylinos.cn>
	 <bc0240881dcbd9400e128cd9e4024a12b86aec9e.1725846806.git.tanggeliang@kylinos.cn>
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

On Mon, 2024-09-09 at 09:55 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>

Should use dedicated ASSERT_OK_FD() to check the fds.

> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/bpf/prog_tests/mptcp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> index 987692863fde..2476f0a083bc 100644
> --- a/tools/testing/selftests/bpf/prog_tests/mptcp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/mptcp.c
> @@ -507,11 +507,11 @@ static void send_data_and_verify(char *sched,
> bool addr1, bool addr2)
>  	unsigned int delta_ms;
>  
>  	server_fd = start_mptcp_server(AF_INET, ADDR_1, PORT_1, 0);
> -	if (CHECK(server_fd < 0, sched, "start_mptcp_server: %d\n",
> errno))
> +	if (!ASSERT_OK_FD(server_fd, "start_mptcp_server"))
>  		return;
>  
>  	client_fd = connect_to_fd(server_fd, 0);
> -	if (CHECK(client_fd < 0, sched, "connect_to_fd: %d\n",
> errno))
> +	if (!ASSERT_OK_FD(client_fd, "connect_to_fd"))
>  		goto fail;
>  
>  	if (clock_gettime(CLOCK_MONOTONIC, &start) < 0)

