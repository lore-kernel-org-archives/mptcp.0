Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFD62FAD
	for <mptcp@lists.linux.dev>; Tue,  8 Jun 2021 01:08:44 +0000 (UTC)
IronPort-SDR: D/wTe35P35lpFY5L010+EbUZIiDC1RSWTEbeEZIBDYWq9Rz0Dl1stmXYjul2AQScOlobjNf1eH
 4oG4MOkGt70w==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="185121784"
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="185121784"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 18:08:43 -0700
IronPort-SDR: agTJ8dc2JRwIFP7kkm8wYDus+NNg8+wKV86uSVVPkccTwuQx+NzCI/BxzzMqcASMvl5LP2pRjh
 c449Y1M0XB/Q==
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="401876853"
Received: from sravikum-mobl1.amr.corp.intel.com ([10.212.171.223])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 18:08:43 -0700
Date: Mon, 7 Jun 2021 18:08:43 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] selftests: mptcp: display proper reason to
 abort tests
In-Reply-To: <20210605085155.3548173-1-matthieu.baerts@tessares.net>
Message-ID: <724782b9-bcf2-889-ca8e-e9d4a91fa693@linux.intel.com>
References: <20210605085155.3548173-1-matthieu.baerts@tessares.net>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Sat, 5 Jun 2021, Matthieu Baerts wrote:

> Without this modification, we were often displaying this error messages:
>
>  FAIL: Could not even run loopback test
>
> But $ret could have been set to a non 0 value in many different cases:
>
> - net.mptcp.enabled=0 is not working as expected
> - setsockopt(..., TCP_ULP, "mptcp", ...) is allowed
> - ping between each netns are failing
> - tests between ns1 as a receiver and ns>1 are failing
> - other tests not involving ns1 as a receiver are failing
>
> So not only for the loopback test.
>
> Now a clearer message, including the time it took to run all tests, is
> displayed.
>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>
> Notes:
>    Do we want this in -net?
>
>    Because it seems also valid to add:
>
>      Fixes: 048d19d444be ("mptcp: add basic kselftest for mptcp")
>

I think net-next is the right place. Thanks for the change to show more 
helpful information on failure! Patch applied to my local repo cleanly and 
tests ran as expected.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> .../selftests/net/mptcp/mptcp_connect.sh      | 52 +++++++++++++------
> 1 file changed, 36 insertions(+), 16 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index 2484fb6a9a8d..559173a8e387 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -680,6 +680,25 @@ run_tests_peekmode()
> 	run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1 "-P ${peekmode}"
> }
>
> +display_time()
> +{
> +	time_end=$(date +%s)
> +	time_run=$((time_end-time_start))
> +
> +	echo "Time: ${time_run} seconds"
> +}
> +
> +stop_if_error()
> +{
> +	local msg="$1"
> +
> +	if [ ${ret} -ne 0 ]; then
> +		echo "FAIL: ${msg}" 1>&2
> +		display_time
> +		exit ${ret}
> +	fi
> +}
> +
> make_file "$cin" "client"
> make_file "$sin" "server"
>
> @@ -687,6 +706,8 @@ check_mptcp_disabled
>
> check_mptcp_ulp_setsockopt
>
> +stop_if_error "The kernel configuration is not valid for MPTCP"
> +
> echo "INFO: validating network environment with pings"
> for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
> 	do_ping "$ns1" $sender 10.0.1.1
> @@ -706,6 +727,8 @@ for sender in "$ns1" "$ns2" "$ns3" "$ns4";do
> 	do_ping "$ns4" $sender dead:beef:3::1
> done
>
> +stop_if_error "Could not even run ping tests"
> +
> [ -n "$tc_loss" ] && tc -net "$ns2" qdisc add dev ns2eth3 root netem loss random $tc_loss delay ${tc_delay}ms
> echo -n "INFO: Using loss of $tc_loss "
> test "$tc_delay" -gt 0 && echo -n "delay $tc_delay ms "
> @@ -733,18 +756,13 @@ echo "on ns3eth4"
>
> tc -net "$ns3" qdisc add dev ns3eth4 root netem delay ${reorder_delay}ms $tc_reorder
>
> -for sender in $ns1 $ns2 $ns3 $ns4;do
> -	run_tests_lo "$ns1" "$sender" 10.0.1.1 1
> -	if [ $ret -ne 0 ] ;then
> -		echo "FAIL: Could not even run loopback test" 1>&2
> -		exit $ret
> -	fi
> -	run_tests_lo "$ns1" $sender dead:beef:1::1 1
> -	if [ $ret -ne 0 ] ;then
> -		echo "FAIL: Could not even run loopback v6 test" 2>&1
> -		exit $ret
> -	fi
> +run_tests_lo "$ns1" "$ns1" 10.0.1.1 1
> +stop_if_error "Could not even run loopback test"
> +
> +run_tests_lo "$ns1" "$ns1" dead:beef:1::1 1
> +stop_if_error "Could not even run loopback v6 test"
>
> +for sender in $ns1 $ns2 $ns3 $ns4;do
> 	# ns1<->ns2 is not subject to reordering/tc delays. Use it to test
> 	# mptcp syncookie support.
> 	if [ $sender = $ns1 ]; then
> @@ -753,6 +771,9 @@ for sender in $ns1 $ns2 $ns3 $ns4;do
> 		ip netns exec "$ns2" sysctl -q net.ipv4.tcp_syncookies=1
> 	fi
>
> +	run_tests "$ns1" $sender 10.0.1.1
> +	run_tests "$ns1" $sender dead:beef:1::1
> +
> 	run_tests "$ns2" $sender 10.0.1.2
> 	run_tests "$ns2" $sender dead:beef:1::2
> 	run_tests "$ns2" $sender 10.0.2.1
> @@ -765,14 +786,13 @@ for sender in $ns1 $ns2 $ns3 $ns4;do
>
> 	run_tests "$ns4" $sender 10.0.3.1
> 	run_tests "$ns4" $sender dead:beef:3::1
> +
> +	stop_if_error "Tests with $sender as a sender have failed"
> done
>
> run_tests_peekmode "saveWithPeek"
> run_tests_peekmode "saveAfterPeek"
> +stop_if_error "Tests with peek mode have failed"
>
> -time_end=$(date +%s)
> -time_run=$((time_end-time_start))
> -
> -echo "Time: ${time_run} seconds"
> -
> +display_time
> exit $ret
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
