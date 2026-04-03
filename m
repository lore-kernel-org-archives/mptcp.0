Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD70620B810
	for <mptcp@lists.linux.dev>; Fri,  3 Apr 2026 01:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775179083; cv=none; b=OKAL9lMgCih4o3v/NKvzmIwe0dY4jUXMERzUdutSSNirtELCf2N9u9GKUwRdaYC4hFtI4FBxyeCJpWYfyK6BVwZGG/DW+L85Nga1tVyvyqSUBNzmWBzWrLTuVEFNptO/0OQwQA/X1opNynL8xn9keJx+kl91nEVIygctYYiTyTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775179083; c=relaxed/simple;
	bh=/UDBfI48+Od4KC4c5HOPxaQ/6Z8FKiZlomnou5bgozw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c1ZJatGjq5mm4RQjNdtJWN5UsbdmwzLL7DEIvfUkufbEAb32yiFnnLuYZDl3T5+blKlFVf7XIPVTF7p2kD5TDq2gaPo4h+a6C4cHkFak2obX9VVhsgfJFYKid662Z0fjDnTPdj6e17At85svT3VVtSRz6MSoXp2e5EEBaSdcNVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncSRWDEA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncSRWDEA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3987DC116C6;
	Fri,  3 Apr 2026 01:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775179083;
	bh=/UDBfI48+Od4KC4c5HOPxaQ/6Z8FKiZlomnou5bgozw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ncSRWDEAgY8kWhN87mrUhfpnmL/Q/UAduNYZRUjBebixFw3GH4CRP8K3stcmqfGj+
	 0xog2Sr5+C5ifnltjQi1YTC5w3Fkrt3uBGU5PLpeXVxR9IkCklf+oHf0+Ky6X7jUyH
	 0hssSW5bck4w5Aq9tNzXewpBnEECvYkXBazgPU+ECesVZValhwelq2xoB8DYZle9HB
	 ROCx386Ab8NrOHpyGHRVhgWOdsrCxejMXRkfESyyBGpES0wwoIzeUYMdyNWtHE15FJ
	 8hVxQ/x2U6l+Dm0TXoypiv8EDCzhv0vuRwRBi5iRGKxFB8ETTel4wA4BWZiaAXf56T
	 6Oq31eKR3T40A==
Message-ID: <bceb10c076ca92276779b177150b282f62a0917b.camel@kernel.org>
Subject: Re: [PATCH mptcp-net v5 5/5] selftests: mptcp: test transmission
 with small rcvbuf
From: Geliang Tang <geliang@kernel.org>
To: Gang Yan <gang.yan@linux.dev>, mptcp@lists.linux.dev
Cc: pabeni@redhat.com, Gang Yan <yangang@kylinos.cn>
Date: Fri, 03 Apr 2026 09:17:52 +0800
In-Reply-To: <ee3b64c8f16734f94cb19d2615563c47e688b784.1775033340.git.yangang@kylinos.cn>
References: <cover.1775033340.git.yangang@kylinos.cn>
	 <ee3b64c8f16734f94cb19d2615563c47e688b784.1775033340.git.yangang@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-4 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Gang,

On Wed, 2026-04-01 at 16:54 +0800, Gang Yan wrote:
> From: Gang Yan <yangang@kylinos.cn>
> 
> This patch adds a test for transmission with a limited receive
> buffer.
> 
> Without the fixes in this set, this test fails with errors:
> 
>  # 001 4 subflows with reduced rcvbuf
>  # net.ipv4.tcp_rmem = 4096 4096 4096
>  #       Info: Test file (size 1024 KB) for client
>  #       Info: Test file (size 1024 KB) for server
>  # copyfd_io_poll: poll timed out (events: POLLIN 1, POLLOUT 0)
>  # copyfd_io_poll: poll timed out (events: POLLIN 0, POLLOUT 4)
>  # [FAIL] client exit code 2, server 2
>  # Server ns stats (ns2-qg1Hqo)
> 
> Co-developed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
> Notes:
> 
> Changelog:
> v5:
>   - Drop the unnecessary tcp_rmem restore.
> 
> ---
>  tools/testing/selftests/net/mptcp/mptcp_join.sh | 17
> +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index beec41f6662a..a21333424085 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -4417,6 +4417,22 @@ endpoint_tests()
>  	fi
>  }
>  
> +rcvbuf_tests()
> +{
> +	if reset "4 subflows with reduced rcvbuf"; then
> +		ip netns exec $ns2 sysctl -w net.ipv4.tcp_rmem="4096
> 4096 4096"

Instead of using reset() here, it's better to set this sysctl in a new
helper - for example, reset_with_tcp_rmem() - as is done in other
tests.

Thanks,
-Geliang

> +
> +		pm_nl_set_limits $ns1 0 4
> +		pm_nl_set_limits $ns2 0 4
> +		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
> +		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
> +		speed=fast test_linkfail=1024 \
> +			run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr 3 3 3
> +	fi
> +}
> +
>  # [$1: error message]
>  usage()
>  {
> @@ -4467,6 +4483,7 @@ all_tests_sorted=(
>  	F@fail_tests
>  	u@userspace_tests
>  	I@endpoint_tests
> +	R@rcvbuf_tests
>  )
>  
>  all_tests_args=""
