Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE80192
	for <mptcp@lists.linux.dev>; Thu, 17 Nov 2022 00:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668646576; x=1700182576;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gQj96y71blX25MwqUjc3jn5N2R2Im00Kq8tYhXzw+pw=;
  b=HkV9MLXThLDoqTCFVQFT9Ah7dxDI4M2G+pfvDIiXwNAWQVVjOgfbk4eL
   P26U+lZRRLe2FEuE+jfiRBkSjpHqU42kEDo/bVOVU/5GVDgxhB1HfDA8w
   jBlinEdw3Wl6FiJAojomWeI412mOzwOfdwjjMjV+kAEc0EafqXAFL5KwU
   joBcHUpPYXVLiSFVFtKYy14B/3TQx1Wo71xupIbgThExTfG08Ckr7zw03
   K/FH//mca50aMbTMcPA8Y6KIx+P4o4B/zY3ET+FgV4hbcmpIQxva2Nx9s
   +dxUCwtJ1IHaL6R5skZogRpv/QhMPXLNV+INgYvnrKCOscQoXknL0e3WO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="310344396"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="310344396"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 16:56:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="672603227"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="672603227"
Received: from sanhitag-mobl.amr.corp.intel.com ([10.209.75.217])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 16:56:15 -0800
Date: Wed, 16 Nov 2022 16:56:15 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 4/4] selftests: mptcp: pm_listener tests
 for mptcp_join
In-Reply-To: <9962e346177f1f5b00f418a6b965a025050aa960.1668599064.git.geliang.tang@suse.com>
Message-ID: <8d7334b3-4742-b136-21f5-6eae17b949c9@linux.intel.com>
References: <cover.1668599064.git.geliang.tang@suse.com> <9962e346177f1f5b00f418a6b965a025050aa960.1668599064.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 16 Nov 2022, Geliang Tang wrote:

> Add pm_listener selftests for mptcp_join.sh.

Hi Geliang -

Also mention in the commit message that this adds test coverage for 
listening sockets created by the in-kernel path manager.

>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> .../testing/selftests/net/mptcp/mptcp_join.sh | 72 +++++++++++++++++++
> 1 file changed, 72 insertions(+)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index f10ef65a7009..0810e9c12fd5 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2509,6 +2509,54 @@ backup_tests()
> 	fi
> }
>
> +LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
> +LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
> +
> +AF_INET=2
> +AF_INET6=10
> +
> +verify_listener_events()
> +{
> +	local evt=$1
> +	local e_type=$2
> +	local e_family=$3
> +	local e_saddr=$4
> +	local e_sport=$5
> +	local type
> +	local family
> +	local saddr
> +	local sport
> +
> +	if [ $e_type = $LISTENER_CREATED ]; then
> +		stdbuf -o0 -e0 printf "\t\t\t\t\t CREATE_LISTENER %s:%s"\
> +			$e_saddr $e_sport
> +	elif [ $e_type = $LISTENER_CLOSED ]; then
> +		stdbuf -o0 -e0 printf "\t\t\t\t\t CLOSE_LISTENER %s:%s "\
> +			$e_saddr $e_sport
> +	fi
> +
> +	type=$(grep "type:$e_type," $evt |
> +	       sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
> +	family=$(grep "type:$e_type," $evt |
> +		 sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
> +	sport=$(grep "type:$e_type," $evt |
> +		sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
> +	if [ $family = $AF_INET6 ]; then
> +		saddr=$(grep "type:$e_type," $evt |
> +			sed --unbuffered -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
> +	else
> +		saddr=$(grep "type:$e_type," $evt |
> +			sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
> +	fi
> +
> +	if [ $type = $e_type ] && [ $family = $e_family ] &&
> +	   [ $saddr = $e_saddr ] && [ $sport = $e_sport ]; then
> +		stdbuf -o0 -e0 printf "[ ok ]\n"
> +		return 0
> +	fi
> +	stdbuf -o0 -e0 printf "[fail]\n"
> +}
> +
> add_addr_ports_tests()
> {
> 	# signal address with port
> @@ -2589,6 +2637,30 @@ add_addr_ports_tests()
> 		chk_join_nr 2 2 2
> 		chk_add_nr 2 2 2
> 	fi
> +
> +	# pm listener events
> +	if reset "pm listener events"; then
> +		local evts
> +		local pid
> +
> +		evts=$(mktemp)
> +		:> $evts
> +		ip netns exec $ns1 ./pm_nl_ctl events >> $evts 2>&1 &
> +		pid=$!
> +
> +		pm_nl_set_limits $ns1 0 1
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
> +		pm_nl_set_limits $ns2 1 1
> +		run_tests $ns1 $ns2 10.0.1.1 0 -1 0 slow
> +		chk_join_nr 1 1 1
> +		chk_add_nr 1 1 1
> +		chk_rm_nr 1 1 invert
> +
> +		verify_listener_events $evts 15 $AF_INET 10.0.2.1 10100
> +		verify_listener_events $evts 16 $AF_INET 10.0.2.1 10100
> +		kill_wait $pid
> +		rm -rf $evts
> +	fi

This duplicates the "remove single address with port" test. I think it's 
better to modify that existing test to add the listener event checking 
instead of increasing the execution time for mptcp_join.sh


> }
>
> syncookies_tests()
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
