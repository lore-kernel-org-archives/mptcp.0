Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532134F21
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 23:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645228214; x=1676764214;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=lezd8vVNxQkIGQgwlbqgYGlAyIKRZHFZ6Qa48K++zw4=;
  b=Xc9FGznFACVt2IJJjknYKZjkMVwCNYw6o6eYtL2pIxIxYPWRkJ7s1dza
   FmWUKL7831sWCRzAFYgJ43tAMc2zF1MTSM63TT0q8KIiu9OxkYVPLkXPn
   FK4xf4yve9SPddEn/jX0ZdiUiXs57iNpRgmYTMOcTrsZ4GgRnULpWyyrS
   JQvZyMtaHNQ7yMpXLaWt9DsOHhjeEexnS92OOYuTD4yBkg+QDEkMPrJGF
   SewmW56DHy7fVKiIlXSKFqB0IClsg0PHbBHjPhb07NcmXhwBzs0gmtIJI
   1SKUhFk51o5tjjjTd1bosbQUX0NwBl/jKQhJH+tvBABohvYE2LqLHPG4n
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10262"; a="231868653"
X-IronPort-AV: E=Sophos;i="5.88,380,1635231600"; 
   d="scan'208";a="231868653"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 15:50:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,380,1635231600"; 
   d="scan'208";a="705571896"
Received: from yungjihy-mobl1.amr.corp.intel.com ([10.209.64.253])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 15:50:13 -0800
Date: Fri, 18 Feb 2022 15:50:13 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "selftests: mptcp: add extra_args
 in do_transfer v3"
In-Reply-To: <0ecb29a09e1b2768ef1166a33dc089e1fa3ae339.1645180743.git.geliang.tang@suse.com>
Message-ID: <75cfed93-7aa6-3dd5-621b-1caec5df6586@linux.intel.com>
References: <0ecb29a09e1b2768ef1166a33dc089e1fa3ae339.1645180743.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 18 Feb 2022, Geliang Tang wrote:

> Please update the commit log:
>
> '''
> Instead of using a global variable mptcp_connect, this patch added
> a new local variable extra_args in do_transfer() to store the extra
> argments passing to the mptcp_connect commands.
>
> This patch also renamed the speed level 'least' to 'speed_*'. This
> more flexible way can avoid the need to add new speed levels in the
> future.
> '''
>

Looks ok to squash, thanks.

-Mat

> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 8597b4a52f4d..ccb11eeea723 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -458,8 +458,8 @@ do_transfer()
> 		extra_args="-j"
> 	elif [ $speed = "slow" ]; then
> 		extra_args="-r 50"
> -	elif [ $speed = "least" ]; then
> -		extra_args="-r 10"
> +	elif [[ $speed = "speed_"* ]]; then
> +		extra_args="-r ${speed:6}"
> 	fi
>
> 	local local_addr
> @@ -1551,7 +1551,7 @@ add_addr_timeout_tests()
> 	pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> 	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> 	pm_nl_set_limits $ns2 2 2
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
> +	run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10
> 	chk_join_nr "signal addresses, ADD_ADDR timeout" 2 2 2
> 	chk_add_nr 8 0
>
> @@ -1561,7 +1561,7 @@ add_addr_timeout_tests()
> 	pm_nl_add_endpoint $ns1 10.0.12.1 flags signal
> 	pm_nl_add_endpoint $ns1 10.0.3.1 flags signal
> 	pm_nl_set_limits $ns2 2 2
> -	run_tests $ns1 $ns2 10.0.1.1 0 0 0 least
> +	run_tests $ns1 $ns2 10.0.1.1 0 0 0 speed_10
> 	chk_join_nr "invalid address, ADD_ADDR timeout" 1 1 1
> 	chk_add_nr 8 0
> }
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
