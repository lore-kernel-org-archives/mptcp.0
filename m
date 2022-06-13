Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B497633E8
	for <mptcp@lists.linux.dev>; Mon, 13 Jun 2022 22:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655161177; x=1686697177;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9NwId3sJv0cUfzi9mxU4vQuo6miCypld39WSKclvNW4=;
  b=fMP8X7MHT+4BS1mmGbpcEX4oTMRDmtVhA9NGn8HG8VkvSSUO+1tgy8St
   OIpkoP3fK7sSUUamzjGEEbigdZ47TqGCJrfUz+ycTEKEWFmmXFw7WPJXC
   Pz38CHkmr2e4urDxxF08ba0JzIRIRoXnWyG9pKfX++uflXUNYESop97Eo
   vUGDm1M493F1dV7WKT1uvJCxplOpvgoUAgF2LGqbNbFuB53zuN/9QQFG1
   u2rMEJ+bxnYS4RIa5Jj+5HsBl5E67oznYXbBUUcp53WcsFjIewm2ur779
   SQSjTOcmnG9MSRbXkmWISMnGtqp+q8jmQNNfCHKDtb7YBk91hv5ULfmLq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="277211977"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="277211977"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 15:59:37 -0700
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="611977850"
Received: from jfgiesbe-mobl.amr.corp.intel.com ([10.209.95.28])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 15:59:36 -0700
Date: Mon, 13 Jun 2022 15:59:36 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 2/5] selftests: mptcp: userspace pm address
 tests
In-Reply-To: <11ccaad770f4e51f211665639d4fa2daac975ee1.1654958401.git.geliang.tang@suse.com>
Message-ID: <c5777ad0-a9f1-545d-b07-e6df3cf6f8c@linux.intel.com>
References: <cover.1654958401.git.geliang.tang@suse.com> <11ccaad770f4e51f211665639d4fa2daac975ee1.1654958401.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sat, 11 Jun 2022, Geliang Tang wrote:

> This patch adds userspace pm tests support for mptcp_join.sh script. Add
> userpace pm add_addr and rm_addr test cases in userspace_tests().
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> .../testing/selftests/net/mptcp/mptcp_join.sh | 45 ++++++++++++++++++-
> 1 file changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index a4406b7a8064..c3cea1d0d245 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -654,6 +654,9 @@ do_transfer()
>
> 	local port=$((10000 + TEST_COUNT - 1))
> 	local cappid
> +	local userspace_pm=0
> +	local evts_ns1
> +	local evts_ns1_pid
>
> 	:> "$cout"
> 	:> "$sout"
> @@ -690,12 +693,24 @@ do_transfer()
> 		extra_args="-r ${speed:6}"
> 	fi
>
> +	if [[ "${addr_nr_ns1}" = "userspace_"* ]]; then
> +		userspace_pm=1
> +		addr_nr_ns1=${addr_nr_ns1:10}
> +	fi
> +
> 	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
> 		# disconnect
> 		extra_args="$extra_args -I ${addr_nr_ns2:10}"
> 		addr_nr_ns2=0
> 	fi
>
> +	if [ $userspace_pm -eq 1 ]; then
> +		evts_ns1=$(mktemp)
> +		:> "$evts_ns1"
> +		ip netns exec ${listener_ns} ./pm_nl_ctl events >> "$evts_ns1" 2>&1 &
> +		evts_ns1_pid=$!
> +	fi
> +
> 	local local_addr
> 	if is_v6 "${connect_addr}"; then
> 		local_addr="::"
> @@ -748,6 +763,8 @@ do_transfer()
> 	if [ $addr_nr_ns1 -gt 0 ]; then
> 		local counter=2
> 		local add_nr_ns1=${addr_nr_ns1}
> +		local id=10
> +		local tk
> 		while [ $add_nr_ns1 -gt 0 ]; do
> 			local addr
> 			if is_v6 "${connect_addr}"; then
> @@ -755,9 +772,18 @@ do_transfer()
> 			else
> 				addr="10.0.$counter.1"
> 			fi
> -			pm_nl_add_endpoint $ns1 $addr flags signal
> +			if [ $userspace_pm -eq 0 ]; then
> +				pm_nl_add_endpoint $ns1 $addr flags signal
> +			else
> +				tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns1")
> +				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
> +				sleep 1
> +				ip netns exec ${listener_ns} ./pm_nl_ctl rem token $tk id $id
> +			fi
> +
> 			counter=$((counter + 1))
> 			add_nr_ns1=$((add_nr_ns1 - 1))
> +			id=$((id + 1))
> 		done
> 	elif [ $addr_nr_ns1 -lt 0 ]; then
> 		local rm_nr_ns1=$((-addr_nr_ns1))
> @@ -890,6 +916,12 @@ do_transfer()
> 	    kill $cappid
> 	fi
>
> +	if [ $userspace_pm -eq 1 ]; then
> +		kill $evts_ns1_pid
> +		wait $evts_ns1_pid 2>/dev/null
> +		rm -rf $evts_ns1
> +	fi
> +
> 	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
> 		nstat | grep Tcp > /tmp/${listener_ns}.out
> 	NSTAT_HISTORY=/tmp/${connector_ns}.nstat ip netns exec ${connector_ns} \
> @@ -2810,6 +2842,17 @@ userspace_tests()
> 		chk_join_nr 0 0 0
> 		chk_rm_nr 0 0
> 	fi
> +
> +	# userspace pm add & remove address
> +	if reset "userspace pm add & remove address"; then
> +		set_userspace_pm $ns1
> +		pm_nl_set_limits $ns1 2 2

These limits are ignored with the userspace PM, it should be ok to delete 
this line.

(comment also applies to the next patch in the series)

> +		pm_nl_set_limits $ns2 2 2
> +		run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
> +		chk_join_nr 1 1 1
> +		chk_add_nr 1 1
> +		chk_rm_nr 1 1 invert
> +	fi
> }
>
> endpoint_tests()
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
