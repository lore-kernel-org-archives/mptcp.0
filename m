Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC9E29CA
	for <mptcp@lists.linux.dev>; Fri, 14 Jan 2022 01:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642123373; x=1673659373;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FE0Uq16iyqmD/OXA8WAI20zNQirlH3NzRE7CAOjXnuQ=;
  b=JwuorZYarmaUjlLnFu+duR8ARbYLEIDzrNjserJx0jeHI07XsZD7e3ua
   Yl3rq0cFh1PcytRCSiYHC8PKZKlrNp2Dy+giSND5kZoNDmnWFVJ8PtCuT
   ZQzdLY9/wHpdkg2xOUyZekUgyqJy48qiUS9NtNo+yfLn97u8iaUiuWvvA
   QdQ8oB7AcNxl9GBlrT36z27cig/7If5NqL2voSl6znt/GrJQ3wOF5gLaz
   VWspB82m5whwAtf49OzQO2qCgHWJzVC5mM+s2gVdvYdY+VW/YzuNLsFk/
   r470czLsJ/ow8RB1jBHm53tk/Zk7N8vmJ5DZFKplLmQI8v6PuETvJsIAe
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="307502168"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="307502168"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 17:22:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="491329512"
Received: from pialybar-mobl.amr.corp.intel.com ([10.212.252.249])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 17:22:53 -0800
Date: Thu, 13 Jan 2022 17:22:52 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v5 4/5] selftests: mptcp: add wrapper for
 setting flags
In-Reply-To: <8a2d91283f44b89e855aa838ed9ea4985370aaa1.1642086296.git.geliang.tang@suse.com>
Message-ID: <69b3a45-6214-194f-ce6f-4cb9b58568a@linux.intel.com>
References: <cover.1642086296.git.geliang.tang@suse.com> <8a2d91283f44b89e855aa838ed9ea4985370aaa1.1642086296.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 13 Jan 2022, Geliang Tang wrote:

> This patch implemented a new function named pm_nl_set_endpoint(), wraped
> the PM netlink commands 'ip mptcp' and 'pm_nl_ctl' in it, and used a new
> argument 'ip_mptcp' to choose which one to use to set the flags of the PM
> endpoint.
>
> Used this wrapper in do_transfer() instead of using the pm_nl_ctl command
> directly.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> .../testing/selftests/net/mptcp/mptcp_join.sh | 31 ++++++++++++++++---
> 1 file changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 06b1a3823bb4..529765f3ab5e 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -376,6 +376,25 @@ pm_nl_show_endpoints()
> 	fi
> }
>
> +pm_nl_change_endpoint()
> +{
> +	local ns=$1
> +	local addr=$2
> +	local id=$3
> +	local flags=$4
> +	local port=$5
> +	local _port=""
> +
> +	if [ $ip_mptcp -eq 1 ]; then
> +		ip -n $ns mptcp endpoint change id $id $flags
> +	else
> +		if [ $port -gt 0 ]; then
> +			_port="port $port"
> +		fi
> +		ip netns exec $ns ./pm_nl_ctl set $addr flags $flags $_port
> +	fi
> +}
> +
> do_transfer()
> {
> 	listener_ns="$1"
> @@ -577,7 +596,8 @@ do_transfer()
> 				local arr=($line)
> 				local addr
> 				local port=0
> -				local _port=""
> +				local nr=0
> +				local id
>
> 				for i in ${arr[@]}; do
> 					if is_addr $i; then
> @@ -588,11 +608,12 @@ do_transfer()
> 							port=$i
> 						fi
> 					fi
> +					if [ $i = "id" ]; then
> +						id=${arr[$nr+1]}
> +					fi

Is the port > 10000 check just above this (commented on in "selftests: 
mptcp: set ip_mptcp in command line") to help reject id numbers?

If so, it would help in future maintenance of this code to either make it 
clear that the number after "id" has been consumed, or at least add a 
comment explaining what's being parsed and why.

-Mat

> +					let nr+=1
> 				done
> -				if [ $port -gt 0 ]; then
> -					_port="port $port"
> -				fi
> -				ip netns exec $netns ./pm_nl_ctl set $addr flags $sflags $_port
> +				pm_nl_change_endpoint $netns $addr $id $sflags $port
> 			done
> 		done
> 	fi
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
