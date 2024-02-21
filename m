Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C753B794
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 12:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708517786; cv=none; b=Ga++QsfmFgjucYI/uD+0oeiMkXH8Y5PeM2yL0AlJJoXJz9qMocwiZDPMyi3d2XvRD8ag7kx0JG0EycXrEN05YKn5XCntCQilzUNPFykCPqJkWiFjra9ciB3gGefkQsmmJg5JT8jmllGsqhN4H4vdbi7eo+9cTTTfQ59q+sDZ7LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708517786; c=relaxed/simple;
	bh=dDhsPtA+VlQK0BE2/Gm1VTKZA8CQRp9RC6Bjp36jdsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RD7AFKdlb9HTOrZ1Yg8OJ6mNURWBMNLxkfifLtknT8H0BY9MYKy3+1UWPguXDBZEaOkE1+8S6GcBV2LJvfja38MDNoz398MrLrP87pG02KjJmwZe66XN6uJ0yctMy2A/wU5wGe75565SQ9F5vbW5F52ENOzs0RCFShGEzLO7WPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNk31sQY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNk31sQY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BBEC433F1;
	Wed, 21 Feb 2024 12:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708517786;
	bh=dDhsPtA+VlQK0BE2/Gm1VTKZA8CQRp9RC6Bjp36jdsQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pNk31sQYOAwje89lc97qhJ6h+5WOn9yNzybrR5b4NUP6kvlOO7Pa5oX4sK5GQ4YFg
	 VbV+bgYM1tuoIoLQDMopzm9UwoJnO/fqyiqv91UI4I06aFD+axfPRydiwdGKCvISeg
	 aZytbuXg1jTfEDe5j9Je/nE4/x3Yxn1Ld7iuPZJTr7H14JfFaxyXeMJKZ4seMjj8bT
	 lLDU5Cy2HDTOdBV0tbomvlhqMVMSO7pBvH/7EFgXPE/GcW6TR9cICIxj8a03gObM2o
	 hCpu+WFR3NqrEVbb2EI0q1skBpMvl9hnf29Rkhe2ySYldgoMHh2iNYhOw1TpZp+zZ3
	 LAiNKuqmFeJ4A==
Message-ID: <03676f8b-341a-4185-9fd2-46dcd0da21d0@kernel.org>
Date: Wed, 21 Feb 2024 13:16:24 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 2/3] selftests: mptcp: add mptcp_lib_ns_*
 helpers
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1708499011.git.tanggeliang@kylinos.cn>
 <fef66a388379bd499df11a08a9492bb583210f47.1708499011.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <fef66a388379bd499df11a08a9492bb583210f47.1708499011.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 21/02/2024 8:06 am, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Add helpers mptcp_lib_ns_init() and mptcp_lib_ns_exit() in mptcp_lib.sh to
> initialize and delete the given namespaces. Then every test script can
> invoke these helpers and use all namespaces.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/diag.sh     |  9 +++----
>  .../selftests/net/mptcp/mptcp_connect.sh      | 24 +++++++------------
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 11 ++-------
>  .../testing/selftests/net/mptcp/mptcp_lib.sh  | 23 ++++++++++++++++++
>  .../selftests/net/mptcp/mptcp_sockopt.sh      | 16 ++++---------
>  .../testing/selftests/net/mptcp/pm_netlink.sh |  9 +++----
>  .../selftests/net/mptcp/simult_flows.sh       | 16 ++++---------
>  .../selftests/net/mptcp/userspace_pm.sh       | 14 ++++-------
>  8 files changed, 54 insertions(+), 68 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
> index 60a7009ce1b5..162d7b90c3f5 100755
> --- a/tools/testing/selftests/net/mptcp/diag.sh
> +++ b/tools/testing/selftests/net/mptcp/diag.sh
> @@ -3,9 +3,8 @@
>  
>  . "$(dirname "${0}")/mptcp_lib.sh"
>  
> -sec=$(date +%s)
> -rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
> -ns="ns1-$rndh"
> +ns=""
> +mptcp_lib_ns_init ns

Please keep the init where the netns was created before: typically after
having declared the trap. Otherwise, the netns could be created, but not
cleaned in case of issues in between.

>  ksft_skip=4
>  test_cnt=1
>  timeout_poll=30

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> index b609649311f6..6900f7f4d88d 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> @@ -121,12 +121,11 @@ while getopts "$optstring" option;do
>  	esac
>  done
>  
> -sec=$(date +%s)
> -rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
> -ns1="ns1-$rndh"
> -ns2="ns2-$rndh"
> -ns3="ns3-$rndh"
> -ns4="ns4-$rndh"
> +ns1=""
> +ns2=""
> +ns3=""
> +ns4=""
> +mptcp_lib_ns_init ns1 ns2 ns3 ns4

Same here: move it after the trap.

>  
>  TEST_COUNT=0
>  TEST_GROUP=""
> @@ -140,9 +139,9 @@ cleanup()
>  
>  	local netns
>  	for netns in "$ns1" "$ns2" "$ns3" "$ns4";do
> -		ip netns del $netns
>  		rm -f /tmp/$netns.{nstat,out}

My previous comment was maybe not clear enough, sorry: for me, it is
fine to move this to 'mptcp_lib_ns_exit', just please clearly mention it
in the commit message as it is a behaviour change, e.g.

  Note that 'mptcp_lib_ns_exit' now also try to remove temp netns files
  used for the stats even for selftests not using them. That's fine to
  do that because these files have a unique name.

>  	done
> +	mptcp_lib_ns_exit "${ns1}" "${ns2}" "${ns3}" "${ns4}"
>  }
>  
>  mptcp_lib_check_mptcp

(...)

> @@ -251,8 +245,8 @@ fi
>  
>  check_mptcp_disabled()
>  {
> -	local disabled_ns="ns_disabled-$rndh"
> -	ip netns add ${disabled_ns} || exit $ksft_skip
> +	local disabled_ns=""

(note that you don't need '=""', 'local disabled_ns' is enough ; but I'm
fine either ways, the result is the same)

> +	mptcp_lib_ns_init disabled_ns
>  
>  	# net.mptcp.enabled should be enabled by default
>  	if [ "$(ip netns exec ${disabled_ns} sysctl net.mptcp.enabled | awk '{ print $3 }')" -ne 1 ]; then

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 9f1476f0e2ae..bea7627c7313 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -86,17 +86,10 @@ init_partial()
>  {
>  	capout=$(mktemp)
>  
> -	local sec rndh
> -	sec=$(date +%s)
> -	rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
> -
> -	ns1="ns1-$rndh"
> -	ns2="ns2-$rndh"
> +	mptcp_lib_ns_init ns1 ns2
>  
>  	local netns
>  	for netns in "$ns1" "$ns2"; do
> -		ip netns add $netns || exit $ksft_skip
> -		ip -net $netns link set lo up
>  		ip netns exec $netns sysctl -q net.mptcp.enabled=1
>  		ip netns exec $netns sysctl -q net.mptcp.pm_type=0 2>/dev/null || true
>  		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0

Same here, I'm fine to move this in 'mptcp_lib_ns_init' as long as it is
documented in the commit message to explain that "it is fine to do that
everywhere, because (...)".

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 556a7d9784d7..14c0b97a153e 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -373,3 +373,26 @@ mptcp_lib_check_output() {
>  		return 1
>  	fi
>  }
> +
> +mptcp_lib_ns_init() {
> +	local sec
> +	local rndh=""

(detail: same here, it is enough to have 'local rndh' without '=""')

> +
> +	sec=$(date +%s)
> +	rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
> +
> +	local netns
> +	for netns in "${@}"; do
> +		eval "${netns}=${netns}-${rndh}"
> +
> +		ip netns add "${!netns}" || exit ${KSFT_SKIP}
> +		ip -net "${!netns}" link set lo up
> +	done
> +}
> +
> +mptcp_lib_ns_exit() {
> +	local netns
> +	for netns in "${@}"; do
> +		ip netns del "$netns"
> +	done
> +}
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> index fd7de1b3dc55..58bf83d4e7fa 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> @@ -14,11 +14,10 @@ timeout_test=$((timeout_poll * 2 + 1))
>  iptables="iptables"
>  ip6tables="ip6tables"
>  
> -sec=$(date +%s)
> -rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
> -ns1="ns1-$rndh"
> -ns2="ns2-$rndh"
> -ns_sbox="ns_sbox-$rndh"
> +ns1=""
> +ns2=""
> +ns_sbox=""
> +mptcp_lib_ns_init ns1 ns2 ns_sbox

Same here: move it to the 'init()' function, where it was done

>  add_mark_rules()
>  {
> @@ -42,8 +41,6 @@ init()
>  {
>  	local netns
>  	for netns in "$ns1" "$ns2" "$ns_sbox";do
> -		ip netns add $netns || exit $ksft_skip
> -		ip -net $netns link set lo up
>  		ip netns exec $netns sysctl -q net.mptcp.enabled=1
>  		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
>  		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
> @@ -79,10 +76,7 @@ init()
>  
>  cleanup()
>  {
> -	local netns
> -	for netns in "$ns1" "$ns2" "$ns_sbox"; do
> -		ip netns del $netns
> -	done
> +	mptcp_lib_ns_exit "${ns1}" "${ns2}" "${ns_sbox}"
>  	rm -f "$cin" "$cout"
>  	rm -f "$sin" "$sout"
>  }
> diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> index 1ec9d8622fc9..c117eea92b6a 100755
> --- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
> +++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> @@ -24,15 +24,14 @@ while getopts "$optstring" option;do
>  	esac
>  done
>  
> -sec=$(date +%s)
> -rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
> -ns1="ns1-$rndh"
> +ns1=""
> +mptcp_lib_ns_init ns1

Same here: move it after the trap.

>  err=$(mktemp)
>  
>  cleanup()
>  {
>  	rm -f $err
> -	ip netns del $ns1
> +	mptcp_lib_ns_exit "${ns1}"
>  }
>  
>  mptcp_lib_check_mptcp
> @@ -40,8 +39,6 @@ mptcp_lib_check_tools ip
>  
>  trap cleanup EXIT
>  
> -ip netns add $ns1 || exit $ksft_skip
> -ip -net $ns1 link set lo up
>  ip netns exec $ns1 sysctl -q net.mptcp.enabled=1
>  
>  check()
> diff --git a/tools/testing/selftests/net/mptcp/simult_flows.sh b/tools/testing/selftests/net/mptcp/simult_flows.sh
> index 7d8388ecc966..67cddd40f211 100755
> --- a/tools/testing/selftests/net/mptcp/simult_flows.sh
> +++ b/tools/testing/selftests/net/mptcp/simult_flows.sh
> @@ -3,11 +3,10 @@
>  
>  . "$(dirname "${0}")/mptcp_lib.sh"
>  
> -sec=$(date +%s)
> -rndh=$(printf %x $sec)-$(mktemp -u XXXXXX)
> -ns1="ns1-$rndh"
> -ns2="ns2-$rndh"
> -ns3="ns3-$rndh"
> +ns1=""
> +ns2=""
> +ns3=""
> +mptcp_lib_ns_init ns1 ns2 ns3

Same here: move it after the trap.

>  capture=false
>  ksft_skip=4
>  timeout_poll=30
> @@ -36,10 +35,7 @@ cleanup()
>  	rm -f "$large" "$small"
>  	rm -f "$capout"
>  
> -	local netns
> -	for netns in "$ns1" "$ns2" "$ns3";do
> -		ip netns del $netns
> -	done
> +	mptcp_lib_ns_exit "${ns1}" "${ns2}" "${ns3}"
>  }
>  
>  mptcp_lib_check_mptcp
> @@ -66,8 +62,6 @@ setup()
>  	trap cleanup EXIT
>  
>  	for i in "$ns1" "$ns2" "$ns3";do
> -		ip netns add $i || exit $ksft_skip
> -		ip -net $i link set lo up
>  		ip netns exec $i sysctl -q net.ipv4.conf.all.rp_filter=0
>  		ip netns exec $i sysctl -q net.ipv4.conf.default.rp_filter=0
>  	done
> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> index 629fc5d0ecc5..10074709420a 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -50,10 +50,9 @@ app6_port=50004
>  client_addr_id=${RANDOM:0:2}
>  server_addr_id=${RANDOM:0:2}
>  
> -sec=$(date +%s)
> -rndh=$(printf %x "$sec")-$(mktemp -u XXXXXX)
> -ns1="ns1-$rndh"
> -ns2="ns2-$rndh"
> +ns1=""
> +ns2=""
> +mptcp_lib_ns_init ns1 ns2

Same here: move it after the trap.

>  ret=0
>  test_name=""
>  
> @@ -118,10 +117,7 @@ cleanup()
>  		mptcp_lib_kill_wait $pid
>  	done
>  
> -	local netns
> -	for netns in "$ns1" "$ns2" ;do
> -		ip netns del "$netns"
> -	done
> +	mptcp_lib_ns_exit "${ns1}" "${ns2}"
>  
>  	rm -rf $file $client_evts $server_evts
>  
> @@ -132,8 +128,6 @@ trap cleanup EXIT
>  
>  # Create and configure network namespaces for testing
>  for i in "$ns1" "$ns2" ;do
> -	ip netns add "$i" || exit 1
> -	ip -net "$i" link set lo up
>  	ip netns exec "$i" sysctl -q net.mptcp.enabled=1
>  	ip netns exec "$i" sysctl -q net.mptcp.pm_type=1
>  done

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
