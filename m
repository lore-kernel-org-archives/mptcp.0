Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CF34C84
	for <mptcp@lists.linux.dev>; Fri, 17 Jun 2022 22:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655503833; x=1687039833;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JeH9lMqkAOXI5wr9qcsBT1/r2yNXwRkm3ds7lP4QBi8=;
  b=RnXa/AW1qALiYqNpIoIYHC1sJyDD5ZjnVuOTdM/7rlOQ/MJ3gcM9yEGF
   03U+TXdfER70jP9W/iSoMxQKUc5zE9PORC/R4DVfH8IUEe2qNwg/MRfVi
   Yr4UtzKjVtjO7oI81tN/Hfi6a9tN4LF+JXve9c0FQ0rIJwaAKCEKW8bIf
   BpB5Ua1pJo/85XoxO3T1nnPkhl/GdflzS00DOiGBxwv+zDGoTQ9W1gDvE
   fMpxFeL1Ft10RlNkek1rWAsZgvYlpeakmQW+YLhUaZ4TaU9r+aegB3rJR
   4ZeT/NlZqmqoo0DIJ1kSj53+sF9M3wDvgTIc4ndtOVi5XSnpna9DHHOEu
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="365920642"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="365920642"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 15:10:32 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="536970499"
Received: from theiders-mobl.amr.corp.intel.com ([10.209.81.3])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 15:10:32 -0700
Date: Fri, 17 Jun 2022 15:10:32 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v3 3/5] selftests: mptcp: userspace pm subflow
 tests
In-Reply-To: <3fe28e031020b282b23e906b1095f1cce16af111.1655355422.git.geliang.tang@suse.com>
Message-ID: <655c24a-a36-d7af-5b1d-925191d17c43@linux.intel.com>
References: <cover.1655355422.git.geliang.tang@suse.com> <3fe28e031020b282b23e906b1095f1cce16af111.1655355422.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 16 Jun 2022, Geliang Tang wrote:

> This patch adds userspace pm subflow tests support for mptcp_join.sh
> script. Add userpace pm create subflow and destroy test cases in
> userspace_tests().
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> .../testing/selftests/net/mptcp/mptcp_join.sh | 40 ++++++++++++++++++-
> 1 file changed, 38 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 977c59c540b2..bec22fa38415 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -657,6 +657,8 @@ do_transfer()
> 	local userspace_pm=0
> 	local evts_ns1
> 	local evts_ns1_pid
> +	local evts_ns2
> +	local evts_ns2_pid
>
> 	:> "$cout"
> 	:> "$sout"
> @@ -702,13 +704,20 @@ do_transfer()
> 		# disconnect
> 		extra_args="$extra_args -I ${addr_nr_ns2:10}"
> 		addr_nr_ns2=0
> +	elif [[ "${addr_nr_ns2}" = "userspace_"* ]]; then
> +		userspace_pm=1
> +		addr_nr_ns2=${addr_nr_ns2:10}
> 	fi
>
> 	if [ $userspace_pm -eq 1 ]; then
> 		evts_ns1=$(mktemp)
> +		evts_ns2=$(mktemp)
> 		:> "$evts_ns1"
> +		:> "$evts_ns2"
> 		ip netns exec ${listener_ns} ./pm_nl_ctl events >> "$evts_ns1" 2>&1 &
> 		evts_ns1_pid=$!
> +		ip netns exec ${connector_ns} ./pm_nl_ctl events >> "$evts_ns2" 2>&1 &
> +		evts_ns2_pid=$!
> 	fi
>
> 	local local_addr
> @@ -830,6 +839,8 @@ do_transfer()
> 	if [ $addr_nr_ns2 -gt 0 ]; then
> 		local add_nr_ns2=${addr_nr_ns2}
> 		local counter=3
> +		local id=20
> +		local tk da dp sp
> 		while [ $add_nr_ns2 -gt 0 ]; do
> 			local addr
> 			if is_v6 "${connect_addr}"; then
> @@ -837,9 +848,23 @@ do_transfer()
> 			else
> 				addr="10.0.$counter.2"
> 			fi
> -			pm_nl_add_endpoint $ns2 $addr flags $flags
> +			if [ $userspace_pm -eq 0 ]; then
> +				pm_nl_add_endpoint $ns2 $addr flags $flags
> +			else
> +				tk=$(sed -n 's/.*\(token:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
> +				da=$(sed -n 's/.*\(daddr4:\)\([0-9.]*\).*$/\2/p;q' "$evts_ns2")
> +				dp=$(sed -n 's/.*\(dport:\)\([[:digit:]]*\).*$/\2/p;q' "$evts_ns2")
> +				ip netns exec ${connector_ns} ./pm_nl_ctl csf lip $addr lid $id \
> +									rip $da rport $dp token $tk
> +				sleep 1
> +				sp=$(grep "type:10" "$evts_ns2" |
> +				     sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
> +				ip netns exec ${connector_ns} ./pm_nl_ctl dsf lip $addr lport $sp \
> +									rip $da rport $dp token $tk
> +			fi
> 			counter=$((counter + 1))
> 			add_nr_ns2=$((add_nr_ns2 - 1))
> +			id=$((id + 1))
> 		done
> 	elif [ $addr_nr_ns2 -lt 0 ]; then
> 		local rm_nr_ns2=$((-addr_nr_ns2))
> @@ -919,7 +944,9 @@ do_transfer()
> 	if [ $userspace_pm -eq 1 ]; then
> 		kill $evts_ns1_pid
> 		wait $evts_ns1_pid 2>/dev/null
> -		rm -rf $evts_ns1
> +		kill $evts_ns2_pid
> +		wait $evts_ns2_pid 2>/dev/null

Would be nice to use the kill_wait function from "selftests: mptcp: avoid
Terminated messages in userspace_pm" here. Can you send a squash-to for
that "avoid Terminated messages..." commit that uses kill_wait?

> +		rm -rf $evts_ns1 $evts_ns2
> 	fi
>
> 	NSTAT_HISTORY=/tmp/${listener_ns}.nstat ip netns exec ${listener_ns} \
> @@ -2852,6 +2879,15 @@ userspace_tests()
> 		chk_add_nr 1 1
> 		chk_rm_nr 1 1 invert
> 	fi
> +
> +	# userspace pm create destroy subflow
> +	if reset "userspace pm create destroy subflow"; then
> +		set_userspace_pm $ns2
> +		pm_nl_set_limits $ns1 0 1
> +		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
> +		chk_join_nr 1 1 1
> +		chk_rm_nr 0 1
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
