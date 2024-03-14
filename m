Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816A87FD
	for <mptcp@lists.linux.dev>; Thu, 14 Mar 2024 00:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710377195; cv=none; b=uRyG2ut6I0WbI2j8Iw09Hk2rrlF5CKt7xgeZ7wYYT8sc8kMjeF0q5X8fMyDtY8jW0bjXUmOtrjjqsod9uUg2rmYyNyJzEZ2mrsJdEx3JzRDMGzYyKpxQBFxacvJdHJLtrK2DUY3AIp3u2CSkgu2RManhVIjGrTo7IpT52gddL4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710377195; c=relaxed/simple;
	bh=H9U/EBSRpomR/ezOQBWQvMMvAy351Iw81rcMJqVQ48c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qMPBY5+RU2hlrAH7y2K/e+8nJ0ng9Ah68UwRTOwllu2RcTiZmXYdSgPR6RrdGgKvay5FRlpsaQnKKgdo0yukRVk3a4tsEzADuIj94KYAavYHV+CR3+lkOhrNhi9kWWLNrkyBa1q/pd3QsTyeB++MU3Ouwx6DyUMPSZHEJxQrOc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbhqvHND; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbhqvHND"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E823BC433C7;
	Thu, 14 Mar 2024 00:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710377195;
	bh=H9U/EBSRpomR/ezOQBWQvMMvAy351Iw81rcMJqVQ48c=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=FbhqvHND2UdN1woT3njimT2To+iAnAMtdC3EmXm4W1RyTa9Kq6QBSWgo7ojIKa/oQ
	 GxCRuoee8vtOcEB55QpOzAEMzl8EWKvMf9/XHHDBzPQm4uQ7LBsAuYFaVkpT1PlfD4
	 hifcQkpg8Ol1v9s0Kt7jiYr4kPLFo/+MjOz3zTM6Eu39agFwvR7vvQ556DlyahjFRD
	 DDfiLdPaReOCHlGijrxJq4SESrAXZcmjGoL4d2nXniPWNhCC+GJPem9vk/DcCEhMIm
	 hDNjcy/5TEE5hzbYFTvBmFTTg/y4r6l28mnW3cjZ8qJ3nMFQp6JC7QdBMsRbX90V4F
	 ne6aSWXWCHX/g==
Date: Wed, 13 Mar 2024 17:46:34 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Davide Caratti <dcaratti@redhat.com>
cc: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v3] mptcp: don't account accept() of non-MPC
 client as fallback to TCP
In-Reply-To: <a5f63fbcf13323d8cf293f42849673093d1bf45b.1710179839.git.dcaratti@redhat.com>
Message-ID: <145aa063-d762-8933-7c1e-b611dcc9525e@kernel.org>
References: <a5f63fbcf13323d8cf293f42849673093d1bf45b.1710179839.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 11 Mar 2024, Davide Caratti wrote:

> Current MPTCP servers increment MPTcpExtMPCapableFallbackACK when they
> accept non-MPC connections. As reported by Christoph, this is "surprising"
> because the counter might become greater than MPTcpExtMPCapableSYNRX.
>
> MPTcpExtMPCapableFallbackACK counter's name suggests it should only be
> incremented when a connection was seen using MPTCP options, then a
> fallback to TCP has been done. Let's do that by incrementing it when
> the subflow context of an inbound MPC connection attempt is dropped.
> Also, update mptcp_connect.sh kselftest, to ensure that the
> above MIB does not increment in case a pure TCP client connects to a
> MPTCP server.
>
> Fixes: fc518953bc9c ("mptcp: add and use MIB counter infrastructure")
> Reported-by: Christoph Paasch <cpaasch@apple.com>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/449
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
>
> --
> v3:
> - fix typo in the if() conditional (thanks Matthieu)
> - rephrase commit message to target "-net" tree (thanks Matthieu)
> - add kselftest (thanks Matthieu)
> v2:
> - fix reporter's name
> ---
> net/mptcp/protocol.c                               |  2 --
> net/mptcp/subflow.c                                |  2 ++
> tools/testing/selftests/net/mptcp/mptcp_connect.sh | 12 ++++++++++++
> 3 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index cdf9ec67795e..556b3b95c537 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -3937,8 +3937,6 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
> 				mptcp_set_state(newsk, TCP_CLOSE);
> 		}
> 	} else {
> -		MPTCP_INC_STATS(sock_net(ssk),
> -				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
> tcpfallback:
> 		newsk->sk_kern_sock = kern;
> 		lock_sock(newsk);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 1626dd20c68f..6042a47da61b 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -905,6 +905,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
> 	return child;
>
> fallback:
> +	if (fallback)
> +		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);

Hi Davide -

Changes to the C code LGTM. See below regarding the self test.

> 	mptcp_subflow_drop_ctx(child);
> 	return child;
> }
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index 4c4248554826..f05af523361a 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -383,12 +383,14 @@ do_transfer()
> 	local stat_cookierx_last
> 	local stat_csum_err_s
> 	local stat_csum_err_c
> +	local stat_tcpfb_last_l
> 	stat_synrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
> 	stat_ackrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
> 	stat_cookietx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
> 	stat_cookierx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
> 	stat_csum_err_s=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtDataCsumErr")
> 	stat_csum_err_c=$(mptcp_lib_get_counter "${connector_ns}" "MPTcpExtDataCsumErr")
> +	stat_tcpfb_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableFallbackACK")
>
> 	timeout ${timeout_test} \
> 		ip netns exec ${listener_ns} \
> @@ -457,11 +459,13 @@ do_transfer()
> 	local stat_cookietx_now
> 	local stat_cookierx_now
> 	local stat_ooo_now
> +	local stat_tcpfb_now_l
> 	stat_synrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
> 	stat_ackrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
> 	stat_cookietx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
> 	stat_cookierx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
> 	stat_ooo_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtTCPOFOQueue")
> +	stat_tcpfb_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableFallbackACK")
>
> 	expect_synrx=$((stat_synrx_last_l))
> 	expect_ackrx=$((stat_ackrx_last_l))
> @@ -508,6 +512,14 @@ do_transfer()
> 		fi
> 	fi
>
> +	if [ ${cl_proto} = "TCP" ] && [ ${srv_proto} = "MPTCP" ]; then
> +		if [ $stat_tcpfb_last_l -ne $stat_tcpfb_now_l ]; then
> +			mptcp_lib_pr_fail "pure TCP counted as fallback (expect:%d, got:%d)" \
> +					   $stat_tcpfb_last_l $stat_tcpfb_now_l 1>&2

This prints:

[FAIL] pure TCP counted as fallback (expect:%d, got:%d) 0 1

which I don't think is what you intended


I confirmed the test does fail on a Fedora 6.7.9 kernel (as it should, it 
caught the old behavior).

- Mat

> +			rets=1
> +		fi
> +	fi
> +
> 	if [ $cookies -eq 2 ];then
> 		if [ $stat_cookietx_last -ge $stat_cookietx_now ] ;then
> 			extra+=" WARN: CookieSent: did not advance"
> -- 
> 2.44.0
>
>
>
