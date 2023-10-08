Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD21915C3
	for <mptcp@lists.linux.dev>; Sun,  8 Oct 2023 10:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SixjPn1r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB831C433C8;
	Sun,  8 Oct 2023 10:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696762590;
	bh=R6dxCotY5r0D9vVVCMobC5y+XC9msG13+7cW04Ksylg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=SixjPn1rtydLxbcJ2z5ej6sTjlkpZZtzdiY1XgcMFMdUFiDENdKwtrEQEQhZpPtTL
	 2cUUJH5KDx1/sMCRax1JphjVg9VqqVBc6ZJIbNHAEqH+siyX7y7MHUSIQUZFviICeP
	 J2EThkJPhl/+tBZavQ4amVQ1aCLP4Jyv0JgVsdD++52mGz26u0yVTlUc2lzzLXPRzK
	 XMnbS7K+/uQRkeTFwblCc5cvY+2zT7y7Kh0egkYSnd6fBhs00eIc7/uod2eGDwgOQ7
	 /c4pVxfcMeeg1IBYd5Am1amrJq0v1Yf7iuwwhH0s6p+dR74gWIlztuTxZeTUC86EHN
	 XNCq1y2tqYlXg==
Message-ID: <12f71929-f333-4b30-854a-6d64591f65ba@kernel.org>
Date: Sun, 8 Oct 2023 12:56:29 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mptcp-next v3 24/29] selftests: mptcp: add
 mptcp_lib_verify_listener_events
Content-Language: en-GB, fr-BE
To: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
References: <cover.1695631132.git.geliang.tang@suse.com>
 <fffd509e2993c2058fb6e9207fd29a3a6c0eb09e.1695631132.git.geliang.tang@suse.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 Fe7fduHbABmYz9cefQpO7wDE/Q==
Organization: Tessares
In-Reply-To: <fffd509e2993c2058fb6e9207fd29a3a6c0eb09e.1695631132.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Geliang,

On 25/09/2023 10:42, Geliang Tang wrote:
> verify_listener_events() helper is defined both in mptcp_join.sh and
> userspace_pm.sh, export it into mptcp_lib.sh and rename it with
> mptcp_lib_ prefix. Use this new helper in both scripts.

Good idea but please see below: because there are quite a few small
differences between mptcp_join.sh and userspace_pm.sh in the way we
print stuff, mark subtests as failed, print errors, etc. I think we are
not ready for such helper and it might be easier to drop this patch for
the moment. What do you think?


(if we want to keep this patch, please don't forget to clearly mention
the reason first (copy-paste from my comment on patch 21/29) before
describing what you did)

(...)

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 8c708b92a942..e59867eed5c2 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -2803,59 +2803,6 @@ backup_tests()
>  	fi
>  }
>  
> -LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
> -LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
> -
> -AF_INET=2
> -AF_INET6=10
> -
> -verify_listener_events()
> -{
> -	local evt=$1
> -	local e_type=$2
> -	local e_family=$3
> -	local e_saddr=$4
> -	local e_sport=$5
> -	local type
> -	local family
> -	local saddr
> -	local sport
> -	local name
> -
> -	if [ $e_type = $LISTENER_CREATED ]; then
> -		name="LISTENER_CREATED"
> -	elif [ $e_type = $LISTENER_CLOSED ]; then
> -		name="LISTENER_CLOSED "
> -	else
> -		name="$e_type"
> -	fi
> -
> -	print_check "$name $e_saddr:$e_sport"
> -
> -	if ! mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
> -		print_skip "event not supported"
> -		return
> -	fi
> -
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
> -		print_ok
> -		return 0
> -	fi
> -	fail_test "$e_type:$type $e_family:$family $e_saddr:$saddr $e_sport:$sport"

It is important to call fail_test() because that's what is going to mark
the subtest (and the whole test) as failed.

> -}
> -
>  add_addr_ports_tests()
>  {
>  	# signal address with port
> @@ -2891,8 +2838,10 @@ add_addr_ports_tests()
>  		chk_add_nr 1 1 1
>  		chk_rm_nr 1 1 invert
>  
> -		verify_listener_events $server_evts $LISTENER_CREATED $AF_INET 10.0.2.1 10100
> -		verify_listener_events $server_evts $LISTENER_CLOSED $AF_INET 10.0.2.1 10100
> +		mptcp_lib_verify_listener_events $server_evts $LISTENER_CREATED \
> +			$AF_INET 10.0.2.1 10100
> +		mptcp_lib_verify_listener_events $server_evts $LISTENER_CLOSED \
> +			$AF_INET 10.0.2.1 10100
>  		mptcp_lib_evts_kill
>  	fi
>  
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index 899c21ced5a3..1301af71ad2c 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -9,6 +9,11 @@ readonly KSFT_SKIP=4
>  readonly KSFT_TEST=$(basename "${0}" | sed 's/\.sh$//g')
>  
>  SUB_ESTABLISHED=10 # MPTCP_EVENT_SUB_ESTABLISHED
> +LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
> +LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED

Same as SUB_ESTABLISHED, it would be better to prefix that with
MPTCP_LIB_ if it is declared here or keep it declared elsewhere.

> +
> +AF_INET=2
> +AF_INET6=10

For these two, I think it is fine without MPTCP_LIB_ but we should add
'readonly' keyword.

>  
>  MPTCP_LIB_SUBTESTS=()
>  
> @@ -267,3 +272,54 @@ mptcp_lib_evts_kill() {
>  mptcp_lib_evts_remove() {
>  	rm -rf $server_evts $client_evts
>  }
> +
> +mptcp_lib_verify_listener_events() {
> +	local evt=$1
> +	local e_type=$2
> +	local e_family=$3
> +	local e_saddr=$4
> +	local e_sport=$5
> +	local type
> +	local family
> +	local saddr
> +	local sport
> +	local name
> +
> +	if [ $e_type = $LISTENER_CREATED ]; then
> +		name="LISTENER_CREATED"
> +	elif [ $e_type = $LISTENER_CLOSED ]; then
> +		name="LISTENER_CLOSED "
> +	else
> +		name="$e_type"
> +	fi
> +
> +	if [ "$(basename "$0")" == "mptcp_join.sh" ]; then
> +		printf "%-6s%-36s" " " "$name $e_saddr:$e_sport"
> +	elif [ "$(basename "$0")" == "userspace_pm.sh" ]; then
> +		printf "%-63s" "$name $e_saddr:$e_sport"
> +	fi

I think we should avoid such a thing in the lib. Instead, we can pass
information in a parameter.

> +
> +	if ! mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
> +		mptcp_lib_print_warn "[skip] event not supported"
> +		return
> +	fi
> +
> +	type=$(mptcp_lib_evts_get_info type "$evt" "$e_type")
> +	family=$(mptcp_lib_evts_get_info family "$evt" "$e_type")
> +	sport=$(mptcp_lib_evts_get_info sport "$evt" "$e_type")
> +	if [ $family ] && [ $family = $AF_INET6 ]; then
> +		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" "$e_type")
> +	else
> +		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" "$e_type")
> +	fi
> +
> +	if [ $type ] && [ $type = $e_type ] &&
> +	   [ $family ] && [ $family = $e_family ] &&
> +	   [ $saddr ] && [ $saddr = $e_saddr ] &&
> +	   [ $sport ] && [ $sport = $e_sport ]; then
> +		mptcp_lib_print_ok "[ ok ]"
> +		return 0
> +	fi
> +	mptcp_lib_print_err "[fail] $e_type:$type $e_family:$family \
> +		$e_saddr:$saddr $e_sport:$sport"

That's not enough to just print a WARN, OK or ERR, some extra actions
needs to be taken, e.g. marking the subtest as failed, same for the
whole selftest.

> +}
> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> index 84a77ee3b633..98189b3f73dc 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -26,11 +26,6 @@ fi
>  ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
>  REMOVED=7          # MPTCP_EVENT_REMOVED
>  SUB_CLOSED=11      # MPTCP_EVENT_SUB_CLOSED
> -LISTENER_CREATED=15 #MPTCP_EVENT_LISTENER_CREATED
> -LISTENER_CLOSED=16  #MPTCP_EVENT_LISTENER_CLOSED
> -
> -AF_INET=2
> -AF_INET6=10
>  
>  file=""
>  client4_pid=0
> @@ -878,36 +873,6 @@ test_prio()
>  	fi
>  }
>  
> -verify_listener_events()
> -{
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
> -
> -	type=$(mptcp_lib_evts_get_info type $evt $e_type)
> -	family=$(mptcp_lib_evts_get_info family $evt $e_type)
> -	sport=$(mptcp_lib_evts_get_info sport $evt $e_type)
> -	if [ $family ] && [ $family = $AF_INET6 ]; then
> -		saddr=$(mptcp_lib_evts_get_info saddr6 $evt $e_type)
> -	else
> -		saddr=$(mptcp_lib_evts_get_info saddr4 $evt $e_type)
> -	fi
> -
> -	check_expected "type" "family" "saddr" "sport"

This a good function to call because it will tell you which parameter is
wrong. In the new helper, we will need to do the comparison ourselves
(and the subtest will not be marked as failed).

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
