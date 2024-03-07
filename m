Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC39B1B94D
	for <mptcp@lists.linux.dev>; Thu,  7 Mar 2024 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709822993; cv=none; b=IJlb7yFR5xXVWs/NUYmqQeLwAHXnzjwhhTN8DanAns7SwBrJwJJyeHhG7rzjs7ck4kPnqjw5xV2SlUvXUKVPNRpN3odtw+pe1KKM+P8Lllo4Hg16jGK2WFnTEvth1wYVwXJvpMS2xLKgWBTOWdLoHj6GKIVhlc2L6w1xZLlIEgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709822993; c=relaxed/simple;
	bh=omuh48NZstp5VK5cFQxp2kpLiDfIv5ZpTyA2x/MfGi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IDEI7XDC+wsBVc9UUwnWgj41rjwxyS7yPyjKnlyh9P3D+TGYUVcTTDBqgjW2hoT1Kr1q5uVnYsVRQ9Cg6s4s0TGSr7h9cNClG+ZlELp4naVjK35lq8pL79JqBHKqDloDJandiZoyRFXsXLXwUFxGCgXxiM43bpjegCGFHX0fFq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+wSukeY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+wSukeY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D644C433F1;
	Thu,  7 Mar 2024 14:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709822993;
	bh=omuh48NZstp5VK5cFQxp2kpLiDfIv5ZpTyA2x/MfGi4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T+wSukeYOwncoQ5nNObxL19isFWtYHAXpkA0nlmfGbqjeLBl/E1kSQduAsxsIYFd2
	 SNy2Bf0fQaK1rtUW3qKf+AY64/tZA17cVxCJCXSDWbxSg1n+ZtdlBNDrOJe791nW4z
	 gEga/Ea/oZUCfjp/miTpU4fthbd7fulUwxdS2ro8W8EwkrZ8ckb6ccu0Z06DzQzZft
	 yTO5ut02eLSgTv8EyZEsPG9EmlfHw/54u5lCGYntMlIUj9UNpbNr/TG7EE8EzXDmXw
	 OUNXkuDfVbFjU/vq/vGZjOSDei5rvffY+1t8jfKcN3bWMb9rK1aHE+ahgdUBi1eR50
	 g1V5s7UCe5xjA==
Message-ID: <c1cabfcb-fccf-4245-a32e-f711c93b0fef@kernel.org>
Date: Thu, 7 Mar 2024 15:49:49 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next 2/5] selftests: mptcp: add
 mptcp_lib_verify_listener_events
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
References: <cover.1709815545.git.tanggeliang@kylinos.cn>
 <85bb025586bf9f9a185e9b1c0ec21fff16626b20.1709815545.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <85bb025586bf9f9a185e9b1c0ec21fff16626b20.1709815545.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 07/03/2024 13:48, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> To avoid duplicated code in different MPTCP selftests, we can add and use
> helpers defined in mptcp_lib.sh.
> 
> The helper verify_listener_events() is defined both in mptcp_join.sh and
> userspace_pm.sh, export it into mptcp_lib.sh and rename it with mptcp_lib_
> prefix. Use this new helper in both scripts.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 23 +++-----------
>  .../testing/selftests/net/mptcp/mptcp_lib.sh  | 26 ++++++++++++++++
>  .../selftests/net/mptcp/userspace_pm.sh       | 31 +++++--------------
>  3 files changed, 38 insertions(+), 42 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index cecf09d14f46..f28b10a61268 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2792,16 +2792,12 @@ AF_INET6=10
>  
>  verify_listener_events()
>  {
> -	local evt=$1
>  	local e_type=$2
>  	local e_family=$3
>  	local e_saddr=$4
>  	local e_sport=$5
> -	local type
> -	local family
> -	local saddr
> -	local sport
>  	local name
> +	local rc=0
>  
>  	if [ $e_type = $LISTENER_CREATED ]; then
>  		name="LISTENER_CREATED"
> @@ -2818,23 +2814,12 @@ verify_listener_events()
>  		return
>  	fi
>  
> -	type=$(mptcp_lib_evts_get_info type "$evt" "$e_type")
> -	family=$(mptcp_lib_evts_get_info family "$evt" "$e_type")
> -	sport=$(mptcp_lib_evts_get_info sport "$evt" "$e_type")
> -	if [ $family ] && [ $family = $AF_INET6 ]; then
> -		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" "$e_type")
> -	else
> -		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" "$e_type")
> -	fi
> -
> -	if [ $type ] && [ $type = $e_type ] &&
> -	   [ $family ] && [ $family = $e_family ] &&
> -	   [ $saddr ] && [ $saddr = $e_saddr ] &&
> -	   [ $sport ] && [ $sport = $e_sport ]; then
> +	mptcp_lib_verify_listener_events "${@}" || rc="${?}"
> +	if [ "${rc}" -eq 0 ]; then

Same here, you don't need 'rc':

  if mptcp_lib_verify_listener_events "${@}"; then
     (...)

>  		print_ok
>  		return 0
>  	fi
> -	fail_test "$e_type:$type $e_family:$family $e_saddr:$saddr $e_sport:$sport"
> +	fail_test "$e_type $e_family $e_saddr $e_sport"

Mmh, this will call "mptcp_lib_pr_fail" again, with info that have
already been displayed, no?

What about calling "fail_test" without argument, and adapt this helper
not to call "print_fail" in this case, no?

  if [ ${#} -gt 0 ]; then
      print_fail "${@}"
  fi

>  }
>  
>  add_addr_ports_tests()
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 44491f18ed17..aefe4db47656 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -468,3 +468,29 @@ mptcp_lib_check_expected() {
>  
>  	return "${rc}"
>  }
> +
> +# shellcheck disable=SC2034

Please *always* document why you need to disable a check

  # shellcheck disable=(...) # <why> (or above it is a long description)


> +mptcp_lib_verify_listener_events() {
> +	local evt=$1
> +	local e_type=$2
> +	local e_family=$3
> +	local e_saddr=$4
> +	local e_sport=$5

Please use {} around the variable name in mptcp_lib.sh: same style as
the rest of the code in this file.

> +	local type
> +	local family
> +	local saddr
> +	local sport
> +	local rc=0
> +
> +	type=$(mptcp_lib_evts_get_info type "$evt" "$e_type")
> +	family=$(mptcp_lib_evts_get_info family "$evt" "$e_type")
> +	if [ "$family" ] && [ "$family" = "$AF_INET6" ]; then
> +		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" "$e_type")
> +	else
> +		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" "$e_type")
> +	fi
> +	sport=$(mptcp_lib_evts_get_info sport "$evt" "$e_type")

Same here above for the whole block for the {}.

> +
> +	mptcp_lib_check_expected "type" "family" "saddr" "sport" || rc="${?}"
> +	return "${rc}"
> +}
> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> index 6ab9efda8627..28669e49de80 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -836,32 +836,15 @@ test_prio()
>  
>  verify_listener_events()
>  {
> -	local evt=$1
> -	local e_type=$2
> -	local e_family=$3
> -	local e_saddr=$4
> -	local e_sport=$5
> -	local type
> -	local family
> -	local saddr
> -	local sport
> -
> -	if [ $e_type = $LISTENER_CREATED ]; then
> -		print_test "CREATE_LISTENER $e_saddr:$e_sport"
> -	elif [ $e_type = $LISTENER_CLOSED ]; then
> -		print_test "CLOSE_LISTENER $e_saddr:$e_sport"
> -	fi
> +	local rc=0
>  
> -	type=$(mptcp_lib_evts_get_info type $evt $e_type)
> -	family=$(mptcp_lib_evts_get_info family $evt $e_type)
> -	sport=$(mptcp_lib_evts_get_info sport $evt $e_type)
> -	if [ $family ] && [ $family = $AF_INET6 ]; then
> -		saddr=$(mptcp_lib_evts_get_info saddr6 $evt $e_type)
> +	mptcp_lib_verify_listener_events "${@}" || rc="${?}"
> +	if [ "${rc}" -eq 0 ]; then

Same here for 'rc': not needed

> +		test_pass
>  	else
> -		saddr=$(mptcp_lib_evts_get_info saddr4 $evt $e_type)
> +		ret=1
> +		mptcp_lib_result_fail "${test_name}"

Same here for ret=1: don't do that, use test_fail without parameters

>  	fi
> -
> -	check_expected "type" "family" "saddr" "sport"
>  }
>  
>  test_listener()
> @@ -877,6 +860,7 @@ test_listener()
>  	# Capture events on the network namespace running the client
>  	:>$client_evts
>  
> +	print_test "Listener event LISTENER_CREATED 10.0.2.2:$client4_port"

Please don't change the name, it is used in the TAP output.

>  	# Attempt to add a listener at 10.0.2.2:<subflow-port>
>  	ip netns exec $ns2 ./pm_nl_ctl listen 10.0.2.2\
>  		$client4_port &
> @@ -895,6 +879,7 @@ test_listener()
>  		rport $client4_port token $server4_token
>  	sleep 0.5
>  
> +	print_test "Listener event LISTENER_CLOSED 10.0.2.2:$client4_port"

Same here, keep the same name.

>  	# Delete the listener from the client ns, if one was created
>  	mptcp_lib_kill_wait $listener_pid
>  

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.
