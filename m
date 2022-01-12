Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B75C2C9C
	for <mptcp@lists.linux.dev>; Wed, 12 Jan 2022 01:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641950145; x=1673486145;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0WNdDtrr2+grwhz/d543V0MWleAtSjepjy6a9x5amdw=;
  b=A+Zkp8981M3hBWJl8x8mQOGcVeAt34QzvWtcBTskhJcKPIHt1DeFN78q
   iv5Jxo4Kn9DlkaccjcH2SuTIC23bFvCsZ1dMQ6n2QjQhsXAce9v+wnzgP
   ABXnD1nzD18CdQMUweuyZb2pJn34FSWOMFr46q5rX8xFeTf7ilG7vj8Bx
   WPqjWxcZiR5JZIquT+iefkHqS1Tzdrght/pj7kvy7rJWptsgjV9cgkT/b
   ZHomSj4LZrMsBtloSpTA5vCS2iCZ2H1a0PiARdpBtANzUX29JxoAKRe6r
   t+QnqJtN1kBg1U/VHtbrY8g5QAxHD5ZKwKQWmI0BxqkJgn2aT8Zlo9RDj
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="306985823"
X-IronPort-AV: E=Sophos;i="5.88,281,1635231600"; 
   d="scan'208";a="306985823"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 17:15:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,281,1635231600"; 
   d="scan'208";a="592861483"
Received: from tcastee-mobl.amr.corp.intel.com ([10.209.73.84])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 17:15:43 -0800
Date: Tue, 11 Jan 2022 17:15:43 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH RESEND mptcp-next v2 7/9] selftests: mptcp: implement
 pm_nl_show_endpoint
In-Reply-To: <47e4e94eda65b9e68ec469fb3e7309405167ec73.1641535880.git.geliang.tang@suse.com>
Message-ID: <2a75529-5ec1-9532-24-50425f67770@linux.intel.com>
References: <cover.1641535880.git.geliang.tang@suse.com> <47e4e94eda65b9e68ec469fb3e7309405167ec73.1641535880.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Fri, 7 Jan 2022, Geliang Tang wrote:

> This patch implemented a new function named pm_nl_show_endpoint(), wraped
> the PM netlink commands 'ip mptcp' and 'pm_nl_ctl' in it, and used a new
> argument 'ip_mptcp' to choose which one to use to show all the PM
> endpoints.
>
> Used this wrapper in all the selftests in mptcp_join.sh instead of using
> the pm_nl_ctl commands directly.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> .../testing/selftests/net/mptcp/mptcp_join.sh | 21 ++++++++++++++++---
> 1 file changed, 18 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 475867a01b83..1a92f0526a4a 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -363,6 +363,17 @@ pm_nl_flush_endpoint()
> 	fi
> }
>
> +pm_nl_show_endpoint()
> +{
> +	local ns=$1
> +
> +	if [ $ip_mptcp -eq 1 ]; then
> +		ip -n $ns mptcp endpoint show
> +	else
> +		ip netns exec $ns ./pm_nl_ctl dump
> +	fi
> +}
> +
> do_transfer()
> {
> 	listener_ns="$1"
> @@ -471,7 +482,7 @@ do_transfer()
> 		let rm_nr_ns1=-addr_nr_ns1
> 		if [ $rm_nr_ns1 -lt 8 ]; then
> 			counter=0
> -			ip netns exec ${listener_ns} ./pm_nl_ctl dump | while read line; do
> +			pm_nl_show_endpoint ${listener_ns} | while read line; do
> 				local arr=($line)
> 				local nr=0
>
> @@ -524,7 +535,7 @@ do_transfer()
> 		let rm_nr_ns2=-addr_nr_ns2
> 		if [ $rm_nr_ns2 -lt 8 ]; then
> 			counter=0
> -			ip netns exec ${connector_ns} ./pm_nl_ctl dump | while read line; do
> +			pm_nl_show_endpoint ${connector_ns} | while read line; do
> 				local arr=($line)
> 				local nr=0
>
> @@ -560,11 +571,15 @@ do_transfer()
> 	if [ ! -z $bkup ]; then
> 		sleep 1
> 		for netns in "$ns1" "$ns2"; do
> -			ip netns exec $netns ./pm_nl_ctl dump | while read line; do
> +			pm_nl_show_endpoint $netns | while read line; do
> 				local arr=($line)
> 				# 'pm_nl_ctl' shows the address at the end
> 				let pos=${#arr[@]}-1
>
> +				# 'ip mptcp' shows the address at the front
> +				if [ $ip_mptcp -eq 1 ]; then
> +					pos=0
> +				fi

Hi Geliang,

What do you think about modifying pm_nl_ctl to have the address in the 
same position as 'ip mptcp' to avoid this special case?

Other than that, the series looks good and I was able to run the tests 
with both 'pm_nl_ctl' and 'ip mptcp'.

There are some other selftest changes pending in patchwork, are there any 
conflicts with this series? If there are conflicts, which series would you 
prefer to merge first?

Thanks,
Mat

> 				addr=${arr[$pos]}
> 				ip netns exec $netns ./pm_nl_ctl set $addr flags $bkup
> 			done
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
