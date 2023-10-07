Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FAD328BE
	for <mptcp@lists.linux.dev>; Sat,  7 Oct 2023 21:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rH7jNPg8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9ADC433C8;
	Sat,  7 Oct 2023 21:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696712801;
	bh=67rl04ioU6kmfAz99hfS2PfxQwpYwjjbuc3PuvUaDgo=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=rH7jNPg8G0Fr5UIMV0+Cp6ZxmvOJv0OwRMaN7J8vShtaNRnWddLq/GAmNInXY/7Bn
	 sVLsXmq6khaBnacwlfFmQg0FAQ/dauirgRWn1yEA36/VuyJIyR0JdTTOktc962Inb4
	 iUYUv096ZK2sfuufrUrnNaUjhE/AwD9IPiZkYr2+pdkjPivxmHE8N9FVJgPBQsCuKQ
	 qhodm4s3pm6aBPx3NXgu/Ic/kCwWJ0YVzh2iVgNsWHvVQ49gmQMso1bCCtMGkA1CSN
	 ZgHIw7qBsAbAsMR4xYpRg/gPGp/jjbBwWvciaUZotTOQPKDEpjrmUNX0uA1wKl16k7
	 UDyGcx7yb8pow==
Message-ID: <9e517f3d-29db-4910-aafe-d09874fe3a65@kernel.org>
Date: Sat, 7 Oct 2023 23:06:40 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 20/29] selftests: mptcp: add userspace pm
 fullmesh tests
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1695631132.git.geliang.tang@suse.com>
 <212f56895715a7e17577076cbe3a7dff9e3ea360.1695631132.git.geliang.tang@suse.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 Fe7fduHbABmYz9cefQpO7wDE/Q==
Organization: Tessares
In-Reply-To: <212f56895715a7e17577076cbe3a7dff9e3ea360.1695631132.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 25/09/2023 10:41, Geliang Tang wrote:
> This patch adds fullmesh selftests for userspace pm both on server side
> and on client side. For the server side test, add two endpoints with
> fullmesh flag on ns2, then signal an address on ns1 by userspace PM to
> trigger the fullmesh connections. For the client side test, just use
> userspace PM to create multiple subflows to do the fullmesh connections.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index aac50ef86785..d883c6c2426b 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -3532,6 +3532,46 @@ userspace_tests()
>  		kill_events_pids
>  		wait $tests_pid
>  	fi
> +
> +	# userspace pm server fullmesh
> +	if reset_with_events "userspace pm server fullmesh" &&
> +	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
> +		set_userspace_pm $ns1
> +		pm_nl_set_limits $ns2 5 5
> +		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,fullmesh
> +		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,fullmesh
> +		speed=10 \
> +			run_tests $ns1 $ns2 10.0.1.1 &
> +		local tests_pid=$!
> +		wait_mpj $ns1
> +		userspace_pm_add_addr $ns1 10.0.2.1 10
> +		chk_join_nr 4 4 4
> +		chk_add_nr 1 1
> +		chk_mptcp_info subflows 4 subflows 4
> +		chk_subflows_total 5 5

It is strange to me to see 5 subflows. Is it because not all endpoints
are marked as fullmesh?

Would it not be clearer to do a typical fullmesh cases using 2 endpoints
(A, B) on each side? So we would have 4 subflows: A-A, A-B, B-B, B-A.

> +		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
> +		mptcp_lib_evts_kill
> +		wait $tests_pid
> +	fi
> +
> +	# userspace pm client fullmesh
> +	if reset_with_events "userspace pm client fullmesh" &&
> +	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
> +		pm_nl_set_limits $ns1 5 5
> +		set_userspace_pm $ns2
> +		speed=10 \
> +			run_tests $ns1 $ns2 10.0.1.1 &
> +		local tests_pid=$!
> +		wait_mpj $ns1
> +		userspace_pm_add_sf $ns2 10.0.2.2 20
> +		userspace_pm_add_sf $ns2 10.0.3.2 30
> +		userspace_pm_add_sf $ns2 10.0.4.2 40

Same here, we should mix endpoints: here it looks like you create 4
subflows from 4 different IPs, that's not really a "fullmesh": the same
endpoint should be re-used multiple times to really validate the
"fullmesh" case, e.g.

 - Client has 2 endpoints: 1.1.1.1 and 2.2.2.2
 - Server has 2 endpoints: 8.8.8.8 and 9.9.9.9

We should have 2x2 subflows:

 - 1.1.1.1 <-> 8.8.8.8
 - 1.1.1.1 <-> 9.9.9.9
 - 2.2.2.2 <-> 8.8.8.8
 - 2.2.2.2 <-> 9.9.9.9

> +		chk_join_nr 3 3 3
> +		chk_mptcp_info subflows 3 subflows 3
> +		chk_subflows_total 4 4
> +		mptcp_lib_evts_kill
> +		wait $tests_pid
> +	fi
>  }
>  
>  endpoint_tests()

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
