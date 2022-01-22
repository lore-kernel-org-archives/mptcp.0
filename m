Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED5F173
	for <mptcp@lists.linux.dev>; Sat, 22 Jan 2022 00:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642812576; x=1674348576;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Bye/zZnQYzK4l1743YVt9e2oZLfmwuH4K25AZVt0Et4=;
  b=WFscAC843DVItWCP+Tt7VjbErJuYgWb/ZV/z6+zONKjK4BcKgC6vC4Rv
   DF19HIV2LH0UkJZa1rEfCJmqk5OVoWj/e6nFY8kdnXk04y8BFsT1cy4hl
   dVJpz7rWuVn0QH7qmdwAEEGkPyH7yBE/HukIUkS7jqADJOtdnGNSiQvy6
   3i0sXVcLDLESGesp1WFOheplzRmQJalPTLjZBHtG7QhlDZ2a0Xgng8BOa
   NJ+2pwL++jUks5afjK7xBZSdcFIeLVAUiHAUCUQ4KNZ7GUQtPGHH8QhyP
   KNFXCeKVQaIXBwbnUBdhZCwiHpA47gj9Mj6U8MJTYM5od+udmUayMPJjG
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="332125912"
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="332125912"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 16:49:35 -0800
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="626911670"
Received: from hma4-mobl2.amr.corp.intel.com ([10.212.239.251])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 16:49:35 -0800
Date: Fri, 21 Jan 2022 16:49:35 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 2/2] Squash to "selftests: mptcp: add wrapper
 for setting flags"
In-Reply-To: <f7696ad95afc97a4c78443ff700c588b600cc822.1642749049.git.geliang.tang@suse.com>
Message-ID: <b6d78b7-4c76-eb81-9d60-c9c121803368@linux.intel.com>
References: <cover.1642749049.git.geliang.tang@suse.com> <f7696ad95afc97a4c78443ff700c588b600cc822.1642749049.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 21 Jan 2022, Geliang Tang wrote:

> Please update the commit message:
>
> '''
> This patch implemented a new function named pm_nl_set_endpoint(), wrap
> the PM netlink commands 'ip mptcp endpoint change flags' and 'pm_nl_ctl
> set flags' in it, use a new argument 'ip_mptcp' to choose which one to
> use to set the flags of the PM endpoint. Randomly choose the 'addr' or
> 'id' as arguments for each command.
>
> Parse the address ID from the PM dump output as well as the address and
> port number, pass them to this wrapper in do_transfer() instead of using
> the pm_nl_ctl command directly.
> '''
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh | 16 +++++++++++++---
> 1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index cd45b854ff6e..ff82ce6bf81f 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -457,12 +457,22 @@ pm_nl_change_endpoint()
> 	local id=$3
> 	local addr=$4
> 	local port=""
> +	local use_id=$((RANDOM%2))

I know the full set of mptcp_join.sh test cases takes a long time to run 
and I'm guessing this randomization is added to cover both id- and 
addr-based lookup without increasing the number of test cases. Other uses 
of RANDOM are mostly for sizes, but it seems like using it here would 
unnecessarily make the tests less repeatable.

In this script, both $addr and $id are available in 
pm_nl_change_endpoint() - my suggestion is to pick one of them to use.

pm_netlink.sh might be a better place to add test cases to get code 
coverage for both addr-based and id-based lookups.


-Mat

> +
> +	if [ $5 -ne 0 ]; then port="port $5"; fi
>
> 	if [ $ip_mptcp -eq 1 ]; then
> -		ip -n $ns mptcp endpoint change id $id ${flags//","/" "}
> +		if [ $use_id -eq 1 ]; then
> +			ip -n $ns mptcp endpoint change id $id ${flags//","/" "}
> +		else
> +			ip -n $ns mptcp endpoint change $addr ${flags//","/" "} $port
> +		fi
> 	else
> -		if [ $5 -ne 0 ]; then port="port $5"; fi
> -		ip netns exec $ns ./pm_nl_ctl set $addr flags $flags $port
> +		if [ $use_id -eq 1 ]; then
> +			ip netns exec $ns ./pm_nl_ctl set id $id flags $flags
> +		else
> +			ip netns exec $ns ./pm_nl_ctl set $addr flags $flags $port
> +		fi
> 	fi
> }
>
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
