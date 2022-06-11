Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508137C
	for <mptcp@lists.linux.dev>; Sat, 11 Jun 2022 00:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654906132; x=1686442132;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=z48NZOhmBw9P8Lu6HLkc8vPTaxa4zW1WH2CRSIwmlxk=;
  b=aL2N3v49S6fuuFt9IzWhsNcx/SFbcfzENqAqZbnuTKKNnmffLa7GVNs/
   fnikm9iZzMFeOkhYRMXLhtFP9Ff8qEimdsJSexbfx3/1TMlp6Hfc51+6k
   QbOdAvUvayugBLwCccwMV/tBTTCVwPvciW8U3d9sJtaqK9NLMxIZMQ9pJ
   Tup1PLie5d5GE2gjh/Bfpl3WIOaCQHCSYF0KbxKeR+sSWa27MqycG5l8X
   825XCbNaAqp6Ql5yXi7Eqgn8KGnMvICabTirt4GThoYgrJDYFd/5Lr/ux
   VWjrY46sgeYQzGYnbMW4V8JrJYbUQd+PHyIC/FXrmqwGU6x9a3IkjNR1G
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="364115218"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="364115218"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 17:08:51 -0700
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="567054084"
Received: from efbarbud-mobl1.amr.corp.intel.com (HELO csouzax-mobl2.amr.corp.intel.com) ([10.212.104.59])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 17:08:51 -0700
Date: Fri, 10 Jun 2022 17:08:50 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] selftests: mptcp: userspace pm add_addr
 test
In-Reply-To: <ba3d782f8fd64867c37a64202dce2565067c9740.1654839195.git.geliang.tang@suse.com>
Message-ID: <2d3b462-e4a4-d033-c2b2-3c8bd1fd8d7f@linux.intel.com>
References: <ba3d782f8fd64867c37a64202dce2565067c9740.1654839195.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 10 Jun 2022, Geliang Tang wrote:

> This patch adds userspace pm tests support for mptcp_join.sh script. Add a
> userpace pm add_addr test case in userspace_tests().
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Thanks for adding this test case.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> ---
> .../testing/selftests/net/mptcp/mptcp_join.sh | 42 ++++++++++++++++++-
> 1 file changed, 41 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index a4406b7a8064..21fa79384c9c 100755
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
> @@ -755,9 +772,16 @@ do_transfer()
> 			else
> 				addr="10.0.$counter.1"
> 			fi
> -			pm_nl_add_endpoint $ns1 $addr flags signal
> +			if [ $userspace_pm -eq 0 ]; then
> +				pm_nl_add_endpoint $ns1 $addr flags signal
> +			else
> +				tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns1")
> +				ip netns exec ${listener_ns} ./pm_nl_ctl ann $addr token $tk id $id
> +			fi
> +
> 			counter=$((counter + 1))
> 			add_nr_ns1=$((add_nr_ns1 - 1))
> +			id=$((id + 1))
> 		done
> 	elif [ $addr_nr_ns1 -lt 0 ]; then
> 		local rm_nr_ns1=$((-addr_nr_ns1))
> @@ -890,6 +914,12 @@ do_transfer()
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
> @@ -2810,6 +2840,16 @@ userspace_tests()
> 		chk_join_nr 0 0 0
> 		chk_rm_nr 0 0
> 	fi
> +
> +	# userspace pm add_addr
> +	if reset "userspace pm add_addr"; then
> +		set_userspace_pm $ns1
> +		pm_nl_set_limits $ns1 2 2
> +		pm_nl_set_limits $ns2 2 2
> +		run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
> +		chk_join_nr 1 1 1
> +		chk_add_nr 1 1
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
