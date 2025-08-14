Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483852FF647
	for <mptcp@lists.linux.dev>; Thu, 14 Aug 2025 00:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755130850; cv=none; b=BwAolVYDHRUc9TJUnPHHD99KNDfgH5gT2dONu0aqi1yO+rXHwAlHsJc8amhcbwUGNxB8NG4R0LmWCzJgKEzm7Sd0xDeJlnY2UYBjW/JdO2E+kVMDOKj36egeUdPf7e5d3mcsVcqs0C08kCP0gB6E3fec2SUaHPHOYquQzL2nOtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755130850; c=relaxed/simple;
	bh=8JiTh81fxvhyGiFX7ENmwFXEZatxZLh52B+MIcP5rY8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=CFTOzzOfRPRwWCBKshD+REqnTPIKUoEu+0dVX/E7R4eBjy62M5OS+IELeop6eVxdNYvbs8/MwWjoHb58X8TuDU3Me13V6qawoJRrvpPPqQjW6RTMyAucmq92LSczhzBnnJHqstg9+O3GDs1Eo6BLVuoh8biAjj+boA1pzNfuRe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f94fO4YT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f94fO4YT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BE8C4CEEB;
	Thu, 14 Aug 2025 00:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755130849;
	bh=8JiTh81fxvhyGiFX7ENmwFXEZatxZLh52B+MIcP5rY8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=f94fO4YTD3CcHvzVHvc0Nryducj2JlgCDavhfKxiGbheRFLuBiotIE/bgfrgjY9zz
	 GTMwx2MFTRJLcdjJn6LM+Bwwl+zZsJex8+yIgQkX+MZOxjBCLZQ2juLM+9dKUu5YUH
	 LKZnfTEnSis+tP48xEHbhpkXKF8d7fwCx3kVTvvqkZxv82xz52aKVonHOLBbvczAoT
	 dkN3G8iy1RnGSxC/+v+vFbXPscRjkV505Qp12a6HMutE1LFcH6eeFBQ/Lykno5vgJR
	 KoUiuCu+2PNtjc1alhVWgoLEN0n0XUl7e5zLeZxy7WESyOBUPp9i1ennDHzrYY7ovR
	 uHQEPrgn2wVVQ==
Date: Wed, 13 Aug 2025 17:20:48 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] mptcp: set ADD_ADDR retrans timeout to 1sec
In-Reply-To: <20250718-mptcp-add_addr_timeout_1-v1-1-58749cbe8b87@kernel.org>
Message-ID: <46d54c22-17b6-ce11-df8f-89add3c607d6@kernel.org>
References: <20250718-mptcp-add_addr_timeout_1-v1-1-58749cbe8b87@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 18 Jul 2025, Matthieu Baerts (NGI0) wrote:

> It doesn't really make sense to wait 2 minutes -- the previous default
> value -- to retransmit the ADD_ADDR if the echo has not been received in
> between: that's way too long to react.
>
> Switching to 1 second by default, which seems like a good default value,
> and can be increased for particular cases.
>
> Later on, we could eventually use a timeout based on the sRTT, with an
> exponential backoff, which would be more reactive [1].
>
> Note: the documentation has been updated accordingly, and the selftests
> are keeping the previous timeout when using a broadcast IP not to have
> retransmissions in this case, which would cause troubles with the
> different counters depending on how fast the test will run.
>
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/576 [1]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Documentation/networking/mptcp-sysctl.rst       | 5 ++---
> net/mptcp/ctrl.c                                | 2 +-
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 3 +++
> 3 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
> index 5bfab01eff5a9db89e1484787953241c16e147cf..14059d2cac1b3467d6a8c9c4362f5a0b427b726d 100644
> --- a/Documentation/networking/mptcp-sysctl.rst
> +++ b/Documentation/networking/mptcp-sysctl.rst
> @@ -12,10 +12,9 @@ add_addr_timeout - INTEGER (seconds)
> 	resent to an MPTCP peer that has not acknowledged a previous
> 	ADD_ADDR message.
>
> -	The default value matches TCP_RTO_MAX. This is a per-namespace
> -	sysctl.
> +	This is a per-namespace sysctl.
>
> -	Default: 120
> +	Default: 1

Hi Matthieu -

I definitely agree that TCP_RTO_MAX is too large. After reading Paolo's 
feedback, I'm thinking 1 second might be a little aggressive. It seems 
like satellite links and heavily loaded mobile networks (plus a little 
buffer bloat) can lead to round trip latencies that can be hundreds of 
milliseconds. With exponential backoff, I think a slightly higher number 
would work. I noticed TCP_TIMEOUT_FALLBACK is 3 seconds, that might be a 
good starting point?

- Mat

>
> allow_join_initial_addr_port - BOOLEAN
> 	Allow peers to send join requests to the IP address and port number used
> diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index fed40dae5583a35914da2cb1c52f37830d72705e..92873457c47ea6b04137cece0200317a94b13e0d 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -97,7 +97,7 @@ const char *mptcp_get_scheduler(const struct net *net)
> static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
> {
> 	pernet->mptcp_enabled = 1;
> -	pernet->add_addr_timeout = TCP_RTO_MAX;
> +	pernet->add_addr_timeout = HZ;	/* 1 second */
> 	pernet->blackhole_timeout = 3600;
> 	pernet->syn_retrans_before_tcp_fallback = 2;
> 	atomic_set(&pernet->active_disable_times, 0);
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index b8af65373b3ada96472347171924ad3a6cf14777..87a9d022d31160a8ff6185b3a117a73841512f9a 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2429,6 +2429,7 @@ remove_tests()
> 		pm_nl_set_limits $ns1 3 3
> 		pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
> 		# broadcast IP: no packet for this address will be received on ns1
> +		ip netns exec ${ns1} sysctl -q net.mptcp.add_addr_timeout=120
> 		pm_nl_add_endpoint $ns1 224.0.0.1 flags signal
> 		pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> 		pm_nl_set_limits $ns2 2 2
> @@ -3846,6 +3847,7 @@ endpoint_tests()
> 		pm_nl_set_limits $ns2 3 3
> 		pm_nl_add_endpoint $ns1 10.0.2.1 id 1 flags signal
> 		# broadcast IP: no packet for this address will be received on ns1
> +		ip netns exec ${ns1} sysctl -q net.mptcp.add_addr_timeout=120
> 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
> 		pm_nl_add_endpoint $ns1 10.0.1.1 id 42 flags signal
> 		{ test_linkfail=4 speed=5 \
> @@ -3919,6 +3921,7 @@ endpoint_tests()
> 		pm_nl_set_limits $ns1 0 2
> 		pm_nl_set_limits $ns2 1 2
> 		# broadcast IP: no packet for this address will be received on ns1
> +		ip netns exec ${ns1} sysctl -q net.mptcp.add_addr_timeout=120
> 		pm_nl_add_endpoint $ns1 224.0.0.1 id 2 flags signal
> 		pm_nl_add_endpoint $ns2 10.0.3.2 id 3 flags subflow
> 		{ test_linkfail=4 speed=20 \
>
> ---
> base-commit: d196b09457190bc11ffca2867d5c12beb5a4759e
> change-id: 20250718-mptcp-add_addr_timeout_1-2b57726cf3cf
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
