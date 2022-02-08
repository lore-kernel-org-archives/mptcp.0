Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43072F23
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 01:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644282125; x=1675818125;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NkPEa7+SPaYBY8aSALx435LuHAfy8UcVZhyGA62GXjQ=;
  b=Wm3nC8aQx8pl3RyIEEnl9bwS56vKssoXsFZFhX3AmClsxD9oh38nrs9F
   rK8l2UDVId6ZBOr9+FvvPHxFj7/UjGacBCTVISLGopJhCe66hvKFHS9tC
   ERE/MWEsTQ4+w5r1PDxKBHlzE6kWD5C96EIb8+7+GjMbJ1GKOLxJKRAhI
   nnUxqtvyvfUDsTfnRw/SRkh0+a/M1nqEnWzFIWtDxlTb74K9hhu+PsiDI
   VlZ84uSEwosdiNWYaOuvSWx8qOm/N3FswsGJhifPyurs7HdihlMAbCh7C
   BGqlz5obNapllTYhV40+6euvohdV4wHSO037bTRKYlZibGHmfiTjRXX4u
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="248792024"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="248792024"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 17:02:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="540365687"
Received: from ngoyal-mobl1.amr.corp.intel.com ([10.251.4.190])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 17:02:04 -0800
Date: Mon, 7 Feb 2022 17:02:04 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] selftests: mptcp: simplify
 pm_nl_change_endpoint
In-Reply-To: <3172f829eeb966f7265e4740a6e3f9bdca2fe44c.1644215857.git.geliang.tang@suse.com>
Message-ID: <a6fee4e0-482d-5993-98a6-b6b511102c22@linux.intel.com>
References: <3172f829eeb966f7265e4740a6e3f9bdca2fe44c.1644215857.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 7 Feb 2022, Geliang Tang wrote:

> This patch simplified pm_nl_change_endpoint(), using id-based address
> lookups only. And dropped the fragile way of parsing 'addr' and 'id'
> from the output of pm_nl_show_endpoints().
>

I agree, this should be less fragile. Thank you Geliang!

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> .../testing/selftests/net/mptcp/mptcp_join.sh | 37 ++++---------------
> 1 file changed, 8 insertions(+), 29 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 2ddb373b7c1d..90a6adc36490 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -251,16 +251,6 @@ is_v6()
> 	[ -z "${1##*:*}" ]
> }
>
> -is_addr()
> -{
> -	[ -z "${1##*[.:]*}" ]
> -}
> -
> -is_number()
> -{
> -	[[ $1 == ?(-)+([0-9]) ]]
> -}
> -
> # $1: ns, $2: port
> wait_local_port_listen()
> {
> @@ -390,16 +380,13 @@ pm_nl_show_endpoints()
> pm_nl_change_endpoint()
> {
> 	local ns=$1
> -	local flags=$2
> -	local id=$3
> -	local addr=$4
> -	local port=""
> +	local id=$2
> +	local flags=$3
>
> 	if [ $ip_mptcp -eq 1 ]; then
> 		ip -n $ns mptcp endpoint change id $id ${flags//","/" "}
> 	else
> -		if [ $5 -ne 0 ]; then port="port $5"; fi
> -		ip netns exec $ns ./pm_nl_ctl set $addr flags $flags $port
> +		ip netns exec $ns ./pm_nl_ctl set id $id flags $flags
> 	fi
> }
>
> @@ -602,24 +589,16 @@ do_transfer()
> 		for netns in "$ns1" "$ns2"; do
> 			pm_nl_show_endpoints $netns | while read line; do
> 				local arr=($line)
> -				local addr
> -				local port=0
> +				local nr=0
> 				local id
>
> 				for i in ${arr[@]}; do
> -					if is_addr $i; then
> -						addr=$i
> -					elif is_number $i; then
> -						# The minimum expected port number is 10000
> -						if [ $i -gt 10000 ]; then
> -							port=$i
> -						# The maximum id number is 255
> -						elif [ $i -lt 255 ]; then
> -							id=$i
> -						fi
> +					if [ $i = "id" ]; then
> +						id=${arr[$nr+1]}
> 					fi
> +					let nr+=1
> 				done
> -				pm_nl_change_endpoint $netns $sflags $id $addr $port
> +				pm_nl_change_endpoint $netns $id $sflags
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
