Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901D36FB1
	for <mptcp@lists.linux.dev>; Tue,  6 Feb 2024 01:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707183601; cv=none; b=gZ/oh0hEzboNTmRxDhLb/yp//8YExRRtl59h35kMlBSLcesbxrpiFDM5ZJVF1uF6KfNY+BOtkfILALq7jGIv6OBeu+ZQQWeVHkC25jWYyje2uek93mUvTAFcxOBEAn64aKs3VGjWDAyQffRNZGM1D804DOCL3TJIP2EdGniHYFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707183601; c=relaxed/simple;
	bh=YFREZ6iCP3Yvk2kiprVrsiZuWMYuTCVm9gGu9yoVGH4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZIGYT2ivuFZrH7C8q97iVuuxxETjqM3Lz6gjtu8NOdbc2EvgE1+An9JKfQP8kDDP5c9xb++TZ7Cg8T1Up3hhSbfekTFIu4uiKyKsHhAFWN3d2/x545F9p4E33yi3E0H+0nKc8KhNbQKQUSIhgb3bSE9uwaRoAMFrSkp91KKyCsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcYi/Qmq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcYi/Qmq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFDBC433F1;
	Tue,  6 Feb 2024 01:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707183601;
	bh=YFREZ6iCP3Yvk2kiprVrsiZuWMYuTCVm9gGu9yoVGH4=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=WcYi/Qmqu52cslNyoJW1E7Lv2OO0ytiNvtIfa/FNHdsGZvHkhsjelpeM/tDCkzhi6
	 yw6aSQ3IYDGpihRpevIecT00p/Bg0nGaX4k/OvoM576G9k214piyQb6qJM4AV3rFzx
	 Ik7OgWkGcQJIOOYb1oZOUPwubH11E6iHSHTPmfuJVFM5hKOdj0tP3OvzHv2msgZHq9
	 GnwJ8FjwWXh0lFvPHoiKnMXzC9gHjbMbVy1nNxJPw5C62zhePRf2KbOG49yvKolD5V
	 36/3MiS7zJsUO4v8b/r7GvllIapHjMlfBUpIbG9uwQ4FyYzGL1Y2Saz3D/rQ1+ZuxV
	 TzFwHQL5ANC7g==
Date: Mon, 5 Feb 2024 17:40:00 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang@kernel.org>
cc: mptcp@lists.linux.dev, Geliang Tang <tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-net 4/4] selftests: mptcp: rm subflow with v4/v4mapped
 addr
In-Reply-To: <192be0c3c28b3fb8ab56ca0ac6b02c40d9153f8e.1706759413.git.tanggeliang@kylinos.cn>
Message-ID: <1cd4fa8d-4de6-8803-5a39-c5088f909c9e@kernel.org>
References: <cover.1706759413.git.tanggeliang@kylinos.cn> <192be0c3c28b3fb8ab56ca0ac6b02c40d9153f8e.1706759413.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 1 Feb 2024, Geliang Tang wrote:

> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> Now both a v4 address and a v4-mapped address are supported when
> destroying a userspace pm subflow, this patch adds random tests for both
> addresses.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/387
> Fixes: 48d73f609dcc ("selftests: mptcp: update userspace pm addr tests")
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 11 ++++++++---
> 1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index c07386e21e0a..a3bdbc896c6f 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -3333,12 +3333,13 @@ userspace_pm_rm_sf()
> {
> 	local evts=$evts_ns1
> 	local t=${3:-1}
> -	local ip=4
> +	local ip
> 	local tk da dp sp
> 	local cnt
>
> 	[ "$1" == "$ns2" ] && evts=$evts_ns2
> -	if mptcp_lib_is_v6 $2; then ip=6; fi
> +	[ -n "$(mptcp_lib_evts_get_info "saddr4" "$evts" $t)" ] && ip=4
> +	[ -n "$(mptcp_lib_evts_get_info "saddr6" "$evts" $t)" ] && ip=6
> 	tk=$(mptcp_lib_evts_get_info token "$evts")
> 	da=$(mptcp_lib_evts_get_info "daddr$ip" "$evts" $t)
> 	dp=$(mptcp_lib_evts_get_info dport "$evts" $t)
> @@ -3441,7 +3442,11 @@ userspace_tests()
> 		chk_subflows_total 2 2
> 		chk_mptcp_info add_addr_signal 1 add_addr_accepted 1
> 		userspace_pm_rm_addr $ns1 10
> -		userspace_pm_rm_sf $ns1 "::ffff:10.0.2.1" $SUB_ESTABLISHED
> +		if [ $((RANDOM%2)) -eq 0 ]; then
> +			userspace_pm_rm_sf $ns1 ::ffff:10.0.2.1 $SUB_ESTABLISHED
> +		else
> +			userspace_pm_rm_sf $ns1 10.0.2.1 $SUB_ESTABLISHED
> +		fi

Instead of randomizing this test, does it work to add a second subflow to 
this test case?

Then the two subflows could be removed two different ways (one with the 
v4mapped and one with v4)? That should avoid adding too much test time.

- Mat


> 		chk_rm_nr 1 1 invert
> 		chk_mptcp_info subflows 0 subflows 0
> 		chk_subflows_total 1 1
> -- 
> 2.40.1
>
>
>
