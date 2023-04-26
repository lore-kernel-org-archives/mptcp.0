Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EE84C8D
	for <mptcp@lists.linux.dev>; Wed, 26 Apr 2023 14:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E87C433EF;
	Wed, 26 Apr 2023 14:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682519761;
	bh=I09K1AZAMfSIDHLw+pj/BWi4YndvCziNO79VEd2vO6w=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=OGB2BmTX9sl0Bg98hLJANDPZOj/bbolukfos8hk9DnssmjSDMml0+hPB09nUT/cQC
	 oSB/ejsoMqv2OGw+y/8EdZBcqUurAGKlQ7lkNwNZUJNpDGTMq1wgJ4g2cYNNnCXftX
	 TCrvKzejbkCx8HBDTMO0Vq4zBXXiXKM1ly/gYokAH45XpN7tpbkIsdvZzVIdFK40ED
	 QhwO7t0VkUvWtET4Ko5Ru3nfwPkEz2DJm8BYNZzMVOIcRAsi/LxXPl0k6LqiiZre0y
	 yoQEcmZ8dJQ10r2ZVdanCNdp9Jmb6RQtwsaeo8y/on/QAfTdohRMwaYUSgxvnMFKSb
	 LVM5u9TwX72hw==
Date: Wed, 26 Apr 2023 07:36:00 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-net v3 1/2] selftests: mptcp: join: avoid using
 'cmp --bytes'
In-Reply-To: <20230404-mptcp-selftests-join-busybox-shellcheck-v3-1-eab5dd7bc996@tessares.net>
Message-ID: <75508308-c622-654b-94b0-e08d923934cc@kernel.org>
References: <20230404-mptcp-selftests-join-busybox-shellcheck-v3-0-eab5dd7bc996@tessares.net> <20230404-mptcp-selftests-join-busybox-shellcheck-v3-1-eab5dd7bc996@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 12 Apr 2023, Matthieu Baerts wrote:

> BusyBox's 'cmp' command doesn't support the '--bytes' parameter.
>
> Some CIs -- i.e. LKFT -- use BusyBox and have the mptcp_join.sh test
> failing [1] because their 'cmp' command doesn't support this '--bytes'
> option:
>
>    cmp: unrecognized option '--bytes=1024'
>    BusyBox v1.35.0 () multi-call binary.
>
>    Usage: cmp [-ls] [-n NUM] FILE1 [FILE2]
>
> Instead, 'head --bytes' can be used as this option is supported by
> BusyBox. A temporary file is needed for this operation.
>
> Because it is apparently quite common to use BusyBox, it is certainly
> better to backport this fix to impacted kernels.
>
> Fixes: 6bf41020b72b ("selftests: mptcp: update and extend fastclose test-cases")
> Link: https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v6.3-rc5-5-g148341f0a2f5/testrun/16088933/suite/kselftest-net-mptcp/test/net_mptcp_userspace_pm_sh/log [1]
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
> v3:
> - use a temp file and remove it in the cleanup phase (if we are really
>   unlucky), from Paolo.

Thanks Matthieu, looks good to me:

Reviewed-by: Mat Martineau <martineau@kernel.org>

> v2:
> - limit the input file, not the output of cmp...
>   (strange that on my side, I didn't reproduce the issue but the CI did)
> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 +++++++++++--
> 1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index fafd19ec7e1f..555781826289 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -13,6 +13,7 @@ sout=""
> cin=""
> cinfail=""
> cinsent=""
> +tmpfile=""
> cout=""
> capout=""
> ns1=""
> @@ -171,6 +172,7 @@ cleanup()
> {
> 	rm -f "$cin" "$cout" "$sinfail"
> 	rm -f "$sin" "$sout" "$cinsent" "$cinfail"
> +	rm -f "$tmpfile"
> 	rm -rf $evts_ns1 $evts_ns2
> 	cleanup_partial
> }
> @@ -378,9 +380,16 @@ check_transfer()
> 			fail_test
> 			return 1
> 		fi
> -		bytes="--bytes=${bytes}"
> +
> +		# note: BusyBox's "cmp" command doesn't support --bytes
> +		tmpfile=$(mktemp)
> +		head --bytes="$bytes" "$in" > "$tmpfile"
> +		mv "$tmpfile" "$in"
> +		head --bytes="$bytes" "$out" > "$tmpfile"
> +		mv "$tmpfile" "$out"
> +		tmpfile=""
> 	fi
> -	cmp -l "$in" "$out" ${bytes} | while read -r i a b; do
> +	cmp -l "$in" "$out" | while read -r i a b; do
> 		local sum=$((0${a} + 0${b}))
> 		if [ $check_invert -eq 0 ] || [ $sum -ne $((0xff)) ]; then
> 			echo "[ FAIL ] $what does not match (in, out):"
>
> -- 
> 2.39.2
>
>
>
