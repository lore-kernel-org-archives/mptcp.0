Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B18B1FB4
	for <mptcp@lists.linux.dev>; Fri,  9 Aug 2024 00:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723163583; cv=none; b=iJf3xDiRpD9AaT+15pC3nsr1EtZr3wnb1AeMZxCQnAj4JAttMsnNMgk6znoVRf8WNGNyQGw19aK3vgei5dNL6/j6vHZm/3j+00IZa7d/V5zLffJYkt4AmOUwaCxOT8upyxMdDzH06csAF3CuARTTJbxf1+nwlpKp9DKQ0rQnTBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723163583; c=relaxed/simple;
	bh=zspNlDV0q73OkyJ8WcC4UeiOcZeo4kdTk8BwEFraf2M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kIligYyEBuSnz5K37OqVcVcPFFqNFsyq3/N1wYD/wJYQ7Ky0NuvKLpn4ZecAhXrUz786bwPbrlF54iYqN22bXLpGAcsh9R33dUyfL45XqT1UsHg/7kR6JIaL8vD7Ohc6LmiLoOWlm2Wqo7wsjxMPiI8iteyW6EYPvGqSrle/3Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J3OfvViQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J3OfvViQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB23AC32782;
	Fri,  9 Aug 2024 00:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723163583;
	bh=zspNlDV0q73OkyJ8WcC4UeiOcZeo4kdTk8BwEFraf2M=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=J3OfvViQEqTSYQkjAdUk0+Gl5mb2Vjrynq7V7GbrQd8ofTYtzA7i+LmX8cE2WDNnu
	 YYL5L9zaBMrKlaofrYPs34B9rtUhgpx2sm8Lv7ihfWj72jM4WGrQV6OeWYIIOeMKcM
	 9bBSn8892vraEQ6U7el9QCOGpkfzwYPN3dQ0qLOKZxA/EOKiv1gFXxtnfd4ih7PLVH
	 BS+nTJ/ksSXAgW23AX4T8+g0H36DJpe4wDnymDhj3+E7XcGVzJBJoMATTSJSabgHK5
	 7Akvu+YRb8BjQmTp8KtPZK7/hPBMjjp2szW6CSQw2CLAzh/sVSsAGZxRmuH/XCmWgv
	 Lnj1X3FFjsA0Q==
Date: Thu, 8 Aug 2024 17:33:02 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v6 10/11] selftests: mptcp: join: cannot rm sf
 if closed
In-Reply-To: <20240802-mptcp-pm-avail-v6-10-964ba9ce279f@kernel.org>
Message-ID: <115783a3-d667-b9a9-3f8c-266023e15069@kernel.org>
References: <20240802-mptcp-pm-avail-v6-0-964ba9ce279f@kernel.org> <20240802-mptcp-pm-avail-v6-10-964ba9ce279f@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 2 Aug 2024, Matthieu Baerts (NGI0) wrote:

> Thanks to the previous commit, the MPTCP subflows are now closed on both
> directions even when only the MPTCP path-manager of one peer asks for
> their closure.
>
> In the two tests modified here -- "userspace pm add & remove address"
> and "userspace pm create destroy subflow" -- one peer is controlled by
> the userspace PM, and the other one by in-kernel PM. When the userspace
> PM sends a RM_ADDR notification, the in-kernel PM will automatically
> react by closing all subflows using this address. Now that the subflows
> are properly closed on both direction, the userspace PM can no longer
> closes the same subflows if they are already closed. In this case, an
> error will be returned to the userspace. So no need to run this command,
> which mean that the linked counters will then not be incremented.
>
> These tests are then no longer sending both a RM_ADDR, then closing the
> linked subflow just after. The test with the userspace PM on the server
> side is now removing one subflow linked to one address, then sending
> a RM_ADDR for another address. The test with the userspace PM on the
> client side is now only removing the subflow that was previously
> created.
>

Hi Matthieu -

How does this selftest behave on older kernels without the fix in the 
previous patch? Would be good to include that information in the commit 
message.

- Mat


> Fixes: 4369c198e599 ("selftests: mptcp: test userspace pm out of transfer")
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 ++++-------
> 1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index ea954ba85969..4129952fd9ec 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -3408,14 +3408,12 @@ userspace_tests()
> 			"signal"
> 		userspace_pm_chk_get_addr "${ns1}" "10" "id 10 flags signal 10.0.2.1"
> 		userspace_pm_chk_get_addr "${ns1}" "20" "id 20 flags signal 10.0.3.1"
> -		userspace_pm_rm_addr $ns1 10
> 		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $MPTCP_LIB_EVENT_SUB_ESTABLISHED
> 		userspace_pm_chk_dump_addr "${ns1}" \
> -			"id 20 flags signal 10.0.3.1" "after rm_addr 10"
> +			"id 20 flags signal 10.0.3.1" "after rm_sf 10"
> 		userspace_pm_rm_addr $ns1 20
> -		userspace_pm_rm_sf $ns1 10.0.3.1 $MPTCP_LIB_EVENT_SUB_ESTABLISHED
> 		userspace_pm_chk_dump_addr "${ns1}" "" "after rm_addr 20"
> -		chk_rm_nr 2 2 invert
> +		chk_rm_nr 1 1 invert
> 		chk_mptcp_info subflows 0 subflows 0
> 		chk_subflows_total 1 1
> 		kill_events_pids
> @@ -3439,12 +3437,11 @@ userspace_tests()
> 			"id 20 flags subflow 10.0.3.2" \
> 			"subflow"
> 		userspace_pm_chk_get_addr "${ns2}" "20" "id 20 flags subflow 10.0.3.2"
> -		userspace_pm_rm_addr $ns2 20
> 		userspace_pm_rm_sf $ns2 10.0.3.2 $MPTCP_LIB_EVENT_SUB_ESTABLISHED
> 		userspace_pm_chk_dump_addr "${ns2}" \
> 			"" \
> -			"after rm_addr 20"
> -		chk_rm_nr 1 1
> +			"after rm_sf 20"
> +		chk_rm_nr 0 1
> 		chk_mptcp_info subflows 0 subflows 0
> 		chk_subflows_total 1 1
> 		kill_events_pids
>
> -- 
> 2.45.2
>
>
