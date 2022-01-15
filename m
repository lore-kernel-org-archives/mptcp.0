Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8559729CA
	for <mptcp@lists.linux.dev>; Sat, 15 Jan 2022 00:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642208127; x=1673744127;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uJU42//GprZp2Pb7ZmwtMyFdZwgWVt6DtS1QY0joRLE=;
  b=OoTQ8yZdWvmAUqPQdfPuuNUTuVW+Xz2ICbFQqKA5Xn7A879bTLbff7B4
   qBtPfLsm402L0eJaLgXiGIxUNJm5wc6fYxnA0r35a2Cz1Nmeexd0Od+S+
   kSGGcYH4kgsKoiHbaLxqxlS4H7LwuQiSSJs/bbBN4pVeiUMdXaGweNWyi
   iNoCFbv/xr7DM7a/WQozvlcffAQlYV2OgLFMpindM/yCAmvVRjOaOjmJq
   rFOtIpdBrrRZqmuWTdsm5dXL67RjOqxpqb9uHOfYrlf8E+YwWyLT2ldKV
   MduDs0L+YzJF7YOWHeZSOs55S4Wxe9OReNZtiVe3L6JlfzIgQl5CzO6gk
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10227"; a="241922764"
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="241922764"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 16:55:26 -0800
X-IronPort-AV: E=Sophos;i="5.88,290,1635231600"; 
   d="scan'208";a="475971291"
Received: from shajisur-mobl.amr.corp.intel.com ([10.209.76.214])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2022 16:55:26 -0800
Date: Fri, 14 Jan 2022 16:55:26 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 10/11] selftests: mptcp: add wrapper for
 setting flags
In-Reply-To: <5fdfe3efa18f141a43ec07a9b01d5b679d1a4a4b.1642154579.git.geliang.tang@suse.com>
Message-ID: <1116635-2b63-9d78-54b3-18c97890b88@linux.intel.com>
References: <cover.1642154579.git.geliang.tang@suse.com> <5fdfe3efa18f141a43ec07a9b01d5b679d1a4a4b.1642154579.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 14 Jan 2022, Geliang Tang wrote:

> This patch implemented a new function named pm_nl_set_endpoint(), wraped
> the PM netlink commands 'ip mptcp' and 'pm_nl_ctl' in it, and used a new
> argument 'ip_mptcp' to choose which one to use to set the flags of the PM
> endpoint.
>
> 'ip mptcp' used the ID number argument to find out the address to change
> flags, while 'pm_nl_ctl' used the address and port number arguments. So
> we need to parse the address ID from the PM dump output as well as the
> address and port number.
>
> Used this wrapper in do_transfer() instead of using the pm_nl_ctl command
> directly.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> .../testing/selftests/net/mptcp/mptcp_join.sh | 24 ++++++++++++++++---
> 1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 24cabed18f58..4df7417013d3 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -377,6 +377,22 @@ pm_nl_show_endpoints()
> 	fi
> }
>
> +pm_nl_change_endpoint()
> +{
> +	local ns=$1
> +	local flags=$2
> +	local id=$3
> +	local addr=$4
> +	local port=""
> +
> +	if [ $ip_mptcp -eq 1 ]; then
> +		ip -n $ns mptcp endpoint change id $id ${flags//","/" "}
> +	else
> +		[ ! -z $5 ]; port="port $5"
> +		ip netns exec $ns ./pm_nl_ctl set $addr flags $flags $port
> +	fi
> +}
> +
> do_transfer()
> {
> 	listener_ns="$1"
> @@ -578,7 +594,7 @@ do_transfer()
> 				local arr=($line)
> 				local addr
> 				local port=0
> -				local _port=""
> +				local id
>
> 				for i in ${arr[@]}; do
> 					if is_addr $i; then
> @@ -587,11 +603,13 @@ do_transfer()
> 						# The minimum expected port number is 10000
> 						if [ $i -gt 10000 ]; then
> 							port=$i
> +						# The maximum id number is 255
> +						elif [ $i -lt 255 ]; then
> +							id=$i

Hi Geliang -

Given that we control pm_nl_ctl (the default tool creating the output to 
parse here), this seems ok to me.

There's a risk that a future version of 'ip mptcp' could have a new number 
field in the output of 'ip mptcp endpoint show' that would confuse this 
script, but since the '-i' flag needs to be used it should be obvious that 
the output of 'ip mptcp' needs to be examined and the comments explain 
what's going on. (So, the 'ip mptcp' parsing is a little fragile here but 
in a way that's not too harmful)

-Mat

> 						fi
> 					fi
> 				done
> -				[ ! -z $port ]; _port="port $port"
> -				ip netns exec $netns ./pm_nl_ctl set $addr flags $sflags $_port
> +				pm_nl_change_endpoint $netns $sflags $id $addr $port
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
