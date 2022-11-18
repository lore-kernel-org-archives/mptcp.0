Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877B817C2
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 01:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668735959; x=1700271959;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uPls/EIf4k+YeU5zBjtZfog7VWOKdQKT6ZzXi+QsFcs=;
  b=Q/lWJW6c6/8Y9//Nqo0FvYq0H3UYWiJGnDEMAkiQnngFw1xEVVWuEpJI
   bIyvTF6eKRvQ7D1i0srUiF/U27kNt1AMLHaFv7tAZBWkGZYKoJ4pGCRMk
   aMZWE9QA+JB2ieq3H9XVR9KMVlif/f1P8RLmCcXoCoOKubupup6mZcyuO
   TFBlPsG/42u7yUqVIUIIaK5hCRqDFCXnH/rvhJG4ihQSbWZWcm5Y3xlIG
   mihhzGBXR5sQnGLRrI3p7izMwufttyShyq01QMqUHWU4x1c2MsnkUrCvW
   b565tMw3awum2TzYceVJWxtjstvxGSc/T5Da7GCi4Cd4gQ8+n2CP54P7S
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="377296090"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="377296090"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 17:45:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="782467585"
X-IronPort-AV: E=Sophos;i="5.96,172,1665471600"; 
   d="scan'208";a="782467585"
Received: from racevedo-mobl1.amr.corp.intel.com ([10.209.34.116])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 17:45:58 -0800
Date: Thu, 17 Nov 2022 17:45:57 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v5 3/4] selftests: mptcp: listener test for
 userspace PM
In-Reply-To: <25f1826e79124415086fe3d6ceb139e2ec80a756.1668662624.git.geliang.tang@suse.com>
Message-ID: <5bc1f374-8df8-43d5-749a-617548b6fabc@linux.intel.com>
References: <cover.1668662624.git.geliang.tang@suse.com> <25f1826e79124415086fe3d6ceb139e2ec80a756.1668662624.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 17 Nov 2022, Geliang Tang wrote:

> This patch adds test coverage for listening sockets created by the
> userspace path manager in userspace_pm.sh.

I suggest changing this sentence to: "This patch adds test coverage for 
listening sockets created by userspace processes."

(the events are created for any MPTCP listener socket, not only the ones 
created by a path manager daemon)

- Mat

>
> It adds a new test named test_listener() and a new verifying helper
> verify_listener_events(). The new output looks like this:
>
> CREATE_SUBFLOW 10.0.2.2 (ns2) => 10.0.2.1 (ns1)              [OK]
> DESTROY_SUBFLOW 10.0.2.2 (ns2) => 10.0.2.1 (ns1)             [OK]
> MP_PRIO TX                                                   [OK]
> MP_PRIO RX                                                   [OK]
> CREATE_LISTENER 10.0.2.2:37106				      [OK]
> CLOSE_LISTENER 10.0.2.2:37106				      [OK]
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> .../selftests/net/mptcp/userspace_pm.sh       | 82 +++++++++++++++++++
> 1 file changed, 82 insertions(+)
>
> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> index 08a88ea47a29..40801279ebdf 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -11,6 +11,8 @@ ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
> REMOVED=7          # MPTCP_EVENT_REMOVED
> SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
> SUB_CLOSED=11      # MPTCP_EVENT_SUB_CLOSED
> +LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
> +LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
>
> AF_INET=2
> AF_INET6=10
> @@ -808,11 +810,91 @@ test_prio()
> 	fi
> }
>
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
> +		stdbuf -o0 -e0 printf "CREATE_LISTENER %s:%s\t\t\t\t\t"\
> +			$e_saddr $e_sport
> +	elif [ $e_type = $LISTENER_CLOSED ]; then
> +		stdbuf -o0 -e0 printf "CLOSE_LISTENER %s:%s\t\t\t\t\t"\
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
> +		stdbuf -o0 -e0 printf "[OK]\n"
> +		return 0
> +	fi
> +	stdbuf -o0 -e0 printf "[FAIL]\n"
> +	exit 1
> +}
> +
> +test_listener()
> +{
> +	local evts
> +	evts=$(mktemp)
> +	# Capture events on the network namespace running the server
> +	:>$evts
> +	ip netns exec $ns2 ./pm_nl_ctl events >> $evts 2>&1 &
> +	evts_pid=$!
> +	sleep 0.5
> +
> +	# Attempt to add a listener at 10.0.2.2:<subflow-port>
> +	ip netns exec $ns2 ./pm_nl_ctl listen 10.0.2.2\
> +		$client4_port > /dev/null 2>&1 &
> +	local listener_pid=$!
> +
> +	verify_listener_events $evts 15 $AF_INET 10.0.2.2 $client4_port
> +
> +	# ADD_ADDR from client to server machine reusing the subflow port
> +	ip netns exec $ns2 ./pm_nl_ctl ann 10.0.2.2 token $client4_token id\
> +		$client_addr_id > /dev/null 2>&1
> +	sleep 0.5
> +
> +	# CREATE_SUBFLOW from server to client machine
> +	ip netns exec $ns1 ./pm_nl_ctl csf lip 10.0.2.1 lid 23 rip 10.0.2.2\
> +		rport $client4_port token $server4_token > /dev/null 2>&1
> +	sleep 0.5
> +
> +	# Delete the listener from the client ns, if one was created
> +	kill_wait $listener_pid
> +
> +	verify_listener_events $evts 16 $AF_INET 10.0.2.2 $client4_port
> +
> +	kill_wait $evts_pid
> +	rm -f $evts
> +}
> +
> make_connection
> make_connection "v6"
> test_announce
> test_remove
> test_subflows
> test_prio
> +test_listener
>
> exit 0
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
