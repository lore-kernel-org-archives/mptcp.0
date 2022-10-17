Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F9F137C
	for <mptcp@lists.linux.dev>; Mon, 17 Oct 2022 13:36:01 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id n12so18466925wrp.10
        for <mptcp@lists.linux.dev>; Mon, 17 Oct 2022 06:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8J7tSBrtDpk58aEdFYgF1cWVEjR9abVO7xiylNdfs0U=;
        b=KiBUaShpepdCp3fpTbA/dQ3VthzFTVe8vqMYDwbMEm95j5idlnVKtVGtnrr2J5IUg0
         Txn6CtYsVdCPS/fcq5xE3FJniqfv8rHfg0TOrqxyRO2UArslLc/QVezHbLPj0LWJiZ1n
         /cGwS9sOByOZ68/jAEEGNX8O+Ndx50aLoBGz3SNpG0rWVxmSRVNWpbE8cbtLgCvve2dl
         gPwObpJCtJCMELs2nzXmy9tE3rGyb2Uq92uMtss6EEOW2/vKAA3Mu7qSy7+FHj66D2G8
         JwPd07gTZbYaKRVTaNI+EApmgmz7L7Jw1cd258OX6DfNxMgDOYZO9fpytbL7YlJMZ8Xv
         jiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8J7tSBrtDpk58aEdFYgF1cWVEjR9abVO7xiylNdfs0U=;
        b=48zVKPsyUHcmfulqXtll/4CJGWVfOM4QH1A91MFkRCcAbwhfat3FhBbfV/+T99v7+3
         5E2H0hJGjehnHxJ06o2j4SMhvK8CUO/c+y3dPROGaBbby8ySC0TvQXj1YBcUhWQ3elkz
         FiBgEneYdGX8OeCaHn4IaMjMZaypjudnik2GajanCCGXogteD6XvYWR2AyJJVyA3WifJ
         CYHpWRGxUSdctVhcfTtaKKroN42MIUyja+9uKZRuM9yG5Ez33zIDjdyZV4oUntEsaK7S
         KV57QhGkrvnfZAm00nSS+5XIRLCnHmu3LtE+LL3lnzFVXU+Z8hq3scjbWVWMKUTxMi2D
         iSBA==
X-Gm-Message-State: ACrzQf0YkuOXw2ge3rJXXQKQ8jUjxlSBTv7E9jprTJkyI/gSdvpQSsW8
	uRfzO0g1TPZi7ZyxYoxY/ZSJZ/4al7eGfg==
X-Google-Smtp-Source: AMsMyM4FqkX6NIGTquIYFWlND9kQRxJO/BO4JyqM8Tt8zIod3ZCVkphMcXZ6S8sT4HNVmxk3pizYKA==
X-Received: by 2002:a5d:5689:0:b0:231:bcaa:3125 with SMTP id f9-20020a5d5689000000b00231bcaa3125mr6607048wrv.431.1666013759568;
        Mon, 17 Oct 2022 06:35:59 -0700 (PDT)
Received: from [10.44.2.26] (84-199-106-91.ifiber.telenet-ops.be. [84.199.106.91])
        by smtp.gmail.com with ESMTPSA id r12-20020adff10c000000b00225239d9265sm8592271wro.74.2022.10.17.06.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 06:35:58 -0700 (PDT)
Message-ID: <3d92e0ca-46dc-816f-87b2-17c32cd8993f@tessares.net>
Date: Mon, 17 Oct 2022 15:35:57 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC PATCH] selftests: mptcp: set test-case parameters
 consistently
Content-Language: en-GB
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
References: <2abed554f2050c7626dede74c92a181506a92682.1665779933.git.pabeni@redhat.com>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <2abed554f2050c7626dede74c92a181506a92682.1665779933.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 14/10/2022 22:39, Paolo Abeni wrote:
> The mptcp_join test-cases depend on several parameters. The caller
> provide most of them as command line arguments for the main test
> function. That makes the test-cases are do read.
> 
> Additionally we sometimes need to add more parameters, which currently
> is currently error prone and makes the test-cases even more hard to
> follow.
> 
> Refactor the infrastructure to pass test-case parameters as enviromental
> variables, and update all the existing tests accordingly.

Thank you for this refactoring!

I have a few questions, please see below:

> Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
>  .../testing/selftests/net/mptcp/mptcp_join.sh | 342 +++++++++++-------
>  1 file changed, 215 insertions(+), 127 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index f3dd5f2a0272..4d1af42cb749 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -35,8 +35,6 @@ TEST_COUNT=0
>  TEST_NAME=""
>  nr_blank=40
>  
> -export FAILING_LINKS=""
> -
>  # generated using "nfbpf_compile '(ip && (ip[54] & 0xf0) == 0x30) ||
>  #				  (ip6 && (ip6[74] & 0xf0) == 0x30)'"
>  CBPF_MPTCP_SUBOPTION_ADD_ADDR="14,
> @@ -80,7 +78,6 @@ init_partial()
>  
>  	check_invert=0
>  	validate_checksum=$checksum
> -	FAILING_LINKS=""
>  
>  	#  ns1         ns2
>  	# ns1eth1    ns2eth1
> @@ -393,13 +390,13 @@ link_failure()
>  {
>  	local ns="$1"
>  
> -	if [ -z "$FAILING_LINKS" ]; then
> +	if [ -z "$failing_links" ]; then
>  		l=$((RANDOM%4))

Not related to your modification but 'l' should be local here. Or we
remove 'l':

  failing_links=$((RANDOM % 4 + 1))

> -		FAILING_LINKS=$((l+1))
> +		failing_links=$((l+1))
>  	fi
>  
>  	local l
> -	for l in $FAILING_LINKS; do
> +	for l in $failing_links; do
>  		local veth="ns1eth$l"
>  		ip -net "$ns" link set "$veth" down
>  	done
> @@ -663,11 +660,6 @@ do_transfer()
>  	local cl_proto="$3"
>  	local srv_proto="$4"
>  	local connect_addr="$5"
> -	local test_link_fail="$6"
> -	local addr_nr_ns1="$7"
> -	local addr_nr_ns2="$8"
> -	local speed="$9"
> -	local sflags="${10}"
>  
>  	local port=$((10000 + TEST_COUNT - 1))
>  	local cappid
> @@ -677,6 +669,12 @@ do_transfer()
>  	local evts_ns2
>  	local evts_ns2_pid
>  
> +	link_fail="${link_fail:-0}"
> +	file_size="${file_size:-0}"
> +	addr_nr_ns1="${addr_nr_ns1:-0}"
> +	addr_nr_ns2="${addr_nr_ns2:-0}"
> +	speed="${speed:-fast}"

It is not needed to have the rest working as it is now but may you
declare them as "local" please?

Without this keyword, it is a bit confusing to me: I initially thought
that if a test was setting one of them (e.g. link_fail=42), all the next
tests would inherit this value. But no because if you declare a variable
just for one function (link_fail=42 run_test (...)), the scope is
limited to the execution of this function. The variables here that are
not set will be defined with a global scope to their default value (e.g.
link_fail=0) but that's fine because it is the default value (but it is
confusing you have different scopes :) )

Still, if other functions use the same variable names, we might have
some clashes. Safer to declare them as "local" I think.

> +
>  	:> "$cout"
>  	:> "$sout"
>  	:> "$capout"
> @@ -721,30 +719,30 @@ do_transfer()
>  	local extra_cl_args=""
>  	local extra_srv_args=""
>  	local trunc_size=""
> -	if [[ "${addr_nr_ns2}" = "fastclose_"* ]]; then
> -		if [ ${test_link_fail} -le 1 ]; then
> -			echo "fastclose tests need test_link_fail argument"
> +	if [[ -n "${fastclose}" ]]; then
> +		if [ ${file_size} -eq 0 ]; then
> +			echo "fastclose tests need file_size argument"
>  			fail_test
>  			return 1
>  		fi
>  
>  		# disconnect
> -		trunc_size=${test_link_fail}
> -		local side=${addr_nr_ns2:10}
> +		trunc_size=${file_size}
>  
> -		if [ ${side} = "client" ]; then
> -			extra_cl_args="-f ${test_link_fail}"
> +		if [ ${fastclose} = "client" ]; then
> +			extra_cl_args="-f ${file_size}"
>  			extra_srv_args="-f -1"
> -		elif [ ${side} = "server" ]; then
> -			extra_srv_args="-f ${test_link_fail}"
> +		elif [ ${fastclose} = "server" ]; then
> +			extra_srv_args="-f ${file_size}"
>  			extra_cl_args="-f -1"
>  		else
> -			echo "wrong/unknown fastclose spec ${side}"
> +			echo "wrong/unknown fastclose spec ${fastclose}"
>  			fail_test
>  			return 1
>  		fi
> -		addr_nr_ns2=0
> -	elif [[ "${addr_nr_ns2}" = "userspace_"* ]]; then
> +	fi
> +
> +	if [[ "${addr_nr_ns2}" = "userspace_"* ]]; then

Should this be re-factored as well?

    userspace=1    \
    addr_nr_ns2=1  \
        run_tests (...)

Same for fullmesh below? And when arguments are negatives?
This is maybe quite a bit of work and maybe not needed (at least not to
reduce the number of parameters). That can also be done later (or never
:) ).

>  		userspace_pm=1
>  		addr_nr_ns2=${addr_nr_ns2:10}
>  	elif [[ "${addr_nr_ns2}" = "fullmesh_"* ]]; then
> @@ -770,8 +768,10 @@ do_transfer()
>  		local_addr="0.0.0.0"
>  	fi
>  
> +	local used_sin=$sin
>  	extra_srv_args="$extra_args $extra_srv_args"
> -	if [ "$test_link_fail" -gt 1 ];then
> +	if [ "$link_fail" -eq 2 -o "$file_size" -gt 0 ];then
> +		used_sin=$sinfail
>  		timeout ${timeout_test} \
>  			ip netns exec ${listener_ns} \
>  				./mptcp_connect -t ${timeout_poll} -l -p $port -s ${srv_proto} \
> @@ -787,12 +787,14 @@ do_transfer()
>  	wait_local_port_listen "${listener_ns}" "${port}"
>  
>  	extra_cl_args="$extra_args $extra_cl_args"
> -	if [ "$test_link_fail" -eq 0 ];then
> +	local used_cin=$cinsent
> +	if [ "$link_fail" -eq 0 -a "$file_size" -eq 0 ];then
> +		used_cin=$cin
>  		timeout ${timeout_test} \
>  			ip netns exec ${connector_ns} \
>  				./mptcp_connect -t ${timeout_poll} -p $port -s ${cl_proto} \
>  					$extra_cl_args $connect_addr < "$cin" > "$cout" &
> -	elif [ "$test_link_fail" -eq 1 ] || [ "$test_link_fail" -eq 2 ];then
> +	elif [ "$link_fail" -eq 1 ] || [ "$link_fail" -eq 2 ];then
>  		( cat "$cinfail" ; sleep 2; link_failure $listener_ns ; cat "$cinfail" ) | \
>  			tee "$cinsent" | \
>  			timeout ${timeout_test} \
> @@ -1005,17 +1007,9 @@ do_transfer()
>  		return 1
>  	fi
>  
> -	if [ "$test_link_fail" -gt 1 ];then
> -		check_transfer $sinfail $cout "file received by client" $trunc_size
> -	else
> -		check_transfer $sin $cout "file received by client" $trunc_size
> -	fi
> +	check_transfer $used_sin $cout "file received by client" $trunc_size
>  	retc=$?
> -	if [ "$test_link_fail" -eq 0 ];then
> -		check_transfer $cin $sout "file received by server" $trunc_size
> -	else
> -		check_transfer $cinsent $sout "file received by server" $trunc_size
> -	fi
> +	check_transfer $used_cin $sout "file received by server" $trunc_size
>  	rets=$?
>  
>  	if [ $retc -eq 0 ] && [ $rets -eq 0 ];then
> @@ -1024,6 +1018,7 @@ do_transfer()
>  	fi
>  
>  	cat "$capout"
> +	fail_test

Does it mean some tests were maybe failing before and we didn't catch
that? Or did you add it just in case? (it makes sense but just to know
if there is a real fix here)

>  	return 1
>  }
>  
> @@ -1044,26 +1039,27 @@ run_tests()
>  	local listener_ns="$1"
>  	local connector_ns="$2"
>  	local connect_addr="$3"
> -	local test_linkfail="${4:-0}"
> -	local addr_nr_ns1="${5:-0}"
> -	local addr_nr_ns2="${6:-0}"
> -	local speed="${7:-fast}"
> -	local sflags="${8:-""}"
>  
>  	local size
>  
> -	# The values above 2 are reused to make test files
> -	# with the given sizes (KB)
> -	if [ "$test_linkfail" -gt 2 ]; then
> -		size=$test_linkfail
> +	file_size="${file_size:-0}"
> +	link_fail="${link_fail:-0}"

Can you mark these variables as "local" too please?

>  
> +	# create the input file for the failure test when
> +	# the first failure test run
> +	if [ "$file_size" -gt 0 ]; then
>  		if [ -z "$cinfail" ]; then
>  			cinfail=$(mktemp)
>  		fi
> -		make_file "$cinfail" "client" $size
> -	# create the input file for the failure test when
> -	# the first failure test run
> -	elif [ "$test_linkfail" -ne 0 ] && [ -z "$cinfail" ]; then
> +		make_file "$cinfail" "client" $file_size
> +
> +		if [ -z "$sinfail" ]; then
> +			sinfail=$(mktemp)
> +		fi
> +		make_file "$sinfail" "server" $file_size
> +	fi
> +
> +	if [ "$link_fail" -ne 0 ] && [ -z "$cinfail" ]; then
>  		# the client file must be considerably larger
>  		# of the maximum expected cwin value, or the
>  		# link utilization will be not predicable
> @@ -1076,14 +1072,7 @@ run_tests()
>  		make_file "$cinfail" "client" $size
>  	fi
>  
> -	if [ "$test_linkfail" -gt 2 ]; then
> -		size=$test_linkfail
> -
> -		if [ -z "$sinfail" ]; then
> -			sinfail=$(mktemp)
> -		fi
> -		make_file "$sinfail" "server" $size
> -	elif [ "$test_linkfail" -eq 2 ] && [ -z "$sinfail" ]; then
> +	if [ "$link_fail" -eq 2 ] && [ -z "$sinfail" ]; then
>  		size=$((RANDOM%16))
>  		size=$((size+1))
>  		size=$((size*2048))
> @@ -1092,8 +1081,7 @@ run_tests()
>  		make_file "$sinfail" "server" $size
>  	fi
>  
> -	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr} \
> -		${test_linkfail} ${addr_nr_ns1} ${addr_nr_ns2} ${speed} ${sflags}
> +	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP ${connect_addr}
>  }
>  
>  dump_stats()
> @@ -1828,7 +1816,7 @@ subflows_error_tests()
>  		pm_nl_set_limits $ns1 0 1
>  		pm_nl_set_limits $ns2 0 1
>  		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
> -		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
> +		speed=slow run_tests $ns1 $ns2 10.0.1.1

detail: should we always move "run_tests" to the next line to make it
clear it is run_tests which is executed? (I don't know if it would be
better, just an idea :) )

    speed=slow    \
        run_tests (...)

The rest looks good to me: it seems you kept the same behaviour as
before from what I saw.

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
