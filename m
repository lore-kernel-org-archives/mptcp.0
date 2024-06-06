Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBE6440C
	for <mptcp@lists.linux.dev>; Thu,  6 Jun 2024 02:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717640158; cv=none; b=jO96kCIoip+L+Pd7ZVPzGOJIXXCjY0ymMblOQD6EqsaQt1H4yi8BUaWZeD+a2/wHU/CLqV830hsumzD8KsJ9ttzraOnBa9w50l8vFqqwmcQijGLjEU3a8W551thbPT0RYwxWpI9ossgjjrq3xf+DPzdwcTpxX34/iafBIodvne4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717640158; c=relaxed/simple;
	bh=6YiCaeGRIRC6Mza9FWAyFiww/A1swV00WkMpYxit8Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEDTyJ717u1yYs1oG3JuJUmJybXUZ/XP62OGm3LCRcMDkSZUc3vBm7aIn1iXzzdV81ybYNypmcVQR22Bqvsga8frCj9o18rwzXNQwx35iLnrUny9HSiDxH/GlQWM0kai5JrOfE6Wg8i4veXSqlOJgqqlpU6hsGfYR2Ipip8c39A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLvor1b7; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLvor1b7"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-24ca03ad307so226664fac.3
        for <mptcp@lists.linux.dev>; Wed, 05 Jun 2024 19:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717640156; x=1718244956; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmL6mA1X24mzn6/BlM9GrDNbWk2sLMyybrXWqmNiVrg=;
        b=nLvor1b7TG09qvoEXjr0NB3VuMIHTcUyYhuJFtIEk7DVCcxCy6hc8ecD8e8AEyWrfS
         cj8ZueSiBKdYdUvxAlYyHpYgL9e4wIQHN0Z++3HImfUOux05RusaorOGPpFU6T+ARfMn
         uvqIe8O8kL0aZwyRJg6KeCpQRWDXEt8mG+eF8H7FDaCYJ8qoKhYUgmq8TfZbs/cbSLkn
         O0rnCFRGXR1sgpdo3oOlefRoB45bdxhWRyZgwpFTusT4O/+1Yjx5Ih2GhK4xdQ0FArvc
         9Rtvn0XHwmD5LpKHPZ+jteiMeOuIXXYz6K4nAei9eGPGpyiyZu/JBMizICSFb4mKv6M0
         M20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717640156; x=1718244956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmL6mA1X24mzn6/BlM9GrDNbWk2sLMyybrXWqmNiVrg=;
        b=AA0mivt9vZcSOxErFx6SPc9/OByT9+4oHt8yJsQyhu3HTCNxS4CeQP0Qed/9IYDI0a
         SxS2hl2oMNs5vNsTOZDbCOBYp9GfCuZrpD88lGXCH+gEfMAZJ32lba7WmF8ODynZAVVK
         ehYSO25BWPKiPu3dgkLNOZIbgGE/g03bctarZZ++CQYouKutewOUBFmrIdFTVOftfxW3
         kXALiTlKRECpkk4T9uDgQhHN+9F2iAP3PZGQ7MPoODbsE6XRugqJsYwFUi8jcPBUsyNd
         uUNun+7LJ9Y66ovGGXUc1R6MXmqeSgONAuQQWafBeXT/qs8tYM60U38SMM6xx7nnkwg4
         cR2Q==
X-Gm-Message-State: AOJu0YySx15N/0MXi4nv6R74Qvh+mvZKxBj6txQuUyKYmXEvACh1Ngad
	FmLBcqsHgYvcNbBgTh+luWP7IJDhOpAevrrAJ4dmOrKeJa6rUBSS2z3VpFDwryc=
X-Google-Smtp-Source: AGHT+IGRRDe4RyIMQgWMV2KX+qTPdrx8+5e3bTbCxproVRCUXYs8LDSdfxXHHE5esmuVCbKLoHpKCQ==
X-Received: by 2002:a05:6870:1711:b0:24f:d5fa:615e with SMTP id 586e51a60fabf-251227360b0mr4746485fac.27.1717640156084;
        Wed, 05 Jun 2024 19:15:56 -0700 (PDT)
Received: from Laptop-X1 ([2409:8a02:782b:80e0:aaca:87fa:f402:cc0f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd494fc0sm166701b3a.127.2024.06.05.19.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 19:15:55 -0700 (PDT)
Date: Thu, 6 Jun 2024 10:15:50 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: Re: [PATCH net 2/3] selftests: net: lib: avoid error removing empty
 netns name
Message-ID: <ZmEb1q_gCHvKhzib@Laptop-X1>
References: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-0-b3afadd368c9@kernel.org>
 <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-2-b3afadd368c9@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605-upstream-net-20240605-selftests-net-lib-fixes-v1-2-b3afadd368c9@kernel.org>

On Wed, Jun 05, 2024 at 11:21:17AM +0200, Matthieu Baerts (NGI0) wrote:
> If there is an error to create the first netns with 'setup_ns()',
> 'cleanup_ns()' will be called with an empty string as first parameter.
> 
> The consequences is that 'cleanup_ns()' will try to delete an invalid
> netns, and wait 20 seconds if the netns list is empty.
> 
> Instead of just checking if the name is not empty, convert the string
> separated by spaces to an array. Manipulating the array is cleaner, and
> calling 'cleanup_ns()' with an empty array will be a no-op.
> 
> Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
> Cc: stable@vger.kernel.org
> Acked-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/lib.sh | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> index a422e10d3d3a..e2f51102d7e1 100644
> --- a/tools/testing/selftests/net/lib.sh
> +++ b/tools/testing/selftests/net/lib.sh
> @@ -15,7 +15,7 @@ ksft_xfail=2
>  ksft_skip=4
>  
>  # namespace list created by setup_ns
> -NS_LIST=""
> +NS_LIST=()
>  
>  ##############################################################################
>  # Helpers
> @@ -137,6 +137,7 @@ cleanup_ns()
>  	fi
>  
>  	for ns in "$@"; do
> +		[ -z "${ns}" ] && continue
>  		ip netns delete "${ns}" &> /dev/null
>  		if ! busywait $BUSYWAIT_TIMEOUT ip netns list \| grep -vq "^$ns$" &> /dev/null; then
>  			echo "Warn: Failed to remove namespace $ns"
> @@ -150,7 +151,7 @@ cleanup_ns()
>  
>  cleanup_all_ns()
>  {
> -	cleanup_ns $NS_LIST
> +	cleanup_ns "${NS_LIST[@]}"
>  }
>  
>  # setup netns with given names as prefix. e.g
> @@ -159,7 +160,7 @@ setup_ns()
>  {
>  	local ns=""
>  	local ns_name=""
> -	local ns_list=""
> +	local ns_list=()
>  	local ns_exist=
>  	for ns_name in "$@"; do
>  		# Some test may setup/remove same netns multi times
> @@ -175,13 +176,13 @@ setup_ns()
>  
>  		if ! ip netns add "$ns"; then
>  			echo "Failed to create namespace $ns_name"
> -			cleanup_ns "$ns_list"
> +			cleanup_ns "${ns_list[@]}"
>  			return $ksft_skip
>  		fi
>  		ip -n "$ns" link set lo up
> -		! $ns_exist && ns_list="$ns_list $ns"
> +		! $ns_exist && ns_list+=("$ns")
>  	done
> -	NS_LIST="$NS_LIST $ns_list"
> +	NS_LIST+=("${ns_list[@]}")
>  }
>  
>  tc_rule_stats_get()
> 
> -- 
> 2.43.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
