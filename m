Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E58238176
	for <mptcp@lists.linux.dev>; Tue, 14 Oct 2025 06:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760424406; cv=none; b=Pqc2z0bcCqQ8oxu8tCzlEjUehxPsz4B1gN+dES60jYf/JmvUyfPVyiTMscvg53AQmkLofGdPnaAiSAxTtaFPMGu81caSnBJKzlCd8FTlrpjKX5/KefaOrZCAUzvGyXBaWjmq7N8xKIXmd4k/N78h7hJP5YayHaPwgaWEZgNNdCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760424406; c=relaxed/simple;
	bh=K1ug6mOlFXgnt5ys9pVt+45z4M2t+Nqqkfyjd0E1HkI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qWPD9RvG6VHocB0v/mmm9Todny+BUeL3sSEFn4ZUPqV00darU1aFuja5e/sjKZv8Om4fE338Cmj2lEf3IcH/1ZmcBnwnGrg6VdSB4oRaF7VI1SzSYJjUI4bhG9SfYyiFK6lX480ks9RcJK9gcgb+KZ5q+jnwJk3HS5YmVc2pryA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUSybTHy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUSybTHy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDD5C4CEE7;
	Tue, 14 Oct 2025 06:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760424406;
	bh=K1ug6mOlFXgnt5ys9pVt+45z4M2t+Nqqkfyjd0E1HkI=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=iUSybTHyJueoUKI3dn6C1GHhPmlHE5KLb5aJ3xItbAFyGwQAl6uqpB13CNqLvtOsr
	 kJUZ5BrzNnhKhHctuDMvzWqFJpfg5FIO5C/K7VyKFXz2LZZM0H/4qkEaBVEdrOnkIu
	 Ay0hx80eKwlpYiYHae5qOvakQNmBoTDm1UBxkxJ6oYh3sDiw5+N5kguxzybg16EtIF
	 LYPtoMxq3ElkjY5+3yFvEDl0SgtqlSzK1+rLN2N7AnOh3N4GQyrDbzpCXvGoBWOVv3
	 2SimIBg47sd9R63WCgto23m3cG0MYQdKzUc4UUZ1YkC6NvUx8SzjlucAnkfm+FZ3YX
	 ES28H5YsFH9DA==
Message-ID: <6efea80680213decf83313995a7afd9e4ce4fafd.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 2/2] selftests: mptcp: join: validate extra
 bind cases
From: Geliang Tang <geliang@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, MPTCP Upstream
	 <mptcp@lists.linux.dev>
Date: Tue, 14 Oct 2025 14:46:42 +0800
In-Reply-To: <20251009-bind-extra-listen-v1-2-5ad2077d77a9@kernel.org>
References: <20251009-bind-extra-listen-v1-0-5ad2077d77a9@kernel.org>
	 <20251009-bind-extra-listen-v1-2-5ad2077d77a9@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

It took me some time to understand this test.

On Thu, 2025-10-09 at 19:33 +0200, Matthieu Baerts (NGI0) wrote:
> By design, an MPTCP connection will not accept extra subflows where
> no
> MPTCP listening sockets can accept such requests.
> 
> In other words, it means that if the 'server' listens on a specific
> address / device, it cannot accept MP_JOIN sent to a different
> address /
> device. Except if there is another MPTCP listening socket accepting
> them.
> 
> This is what the new tests are validating:
> 
>  - Forcing a bind on the main v4/v6 address, and checking that
> MP_JOIN
>    to announced addresses are not accepted.
> 
>  - Also forcing a bind on the main v4/v6 address, but before, another
>    listening socket is created to accept additional subflows. Note
> that
>    'mptcpize run nc -l' -- or something else only doing:
> socket(MPTCP),
>    bind(<IP>), listen(0) -- would be enough, but here mptcp_connect
> is
>    reused not to depend on another tool just for that.
> 
>  - Same as the previous one, but using v6 link-local addresses: this
> is
>    a bit particular because it is required to specify the outgoing
>    network interface when connecting to a link-local address
> announced
>    by the other peer. When using the routing rules, this doesn't work
>    (the outgoing interface is not known) ; but it does work with a
>    'laminar' endpoint having a specified interface.
> 
> Note that extra small modifications are needed for these tests to
> work:
> 
>  - mptcp_connect's check_getpeername_connect() check should strip the
>    specified interface when comparing addresses.
> 
>  - With IPv6 link-local addresses, it is required to wait for them to
>    be ready (no longer in 'tentative' mode) before using them,
> otherwise
>    the bind() will not be allowed.
> 
> Link: https://github.com/multipath-tcp/mptcp_net-next/issues/591
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_connect.c |  10 +-
>  tools/testing/selftests/net/mptcp/mptcp_join.sh   | 153
> +++++++++++++++++++++-
>  2 files changed, 161 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> index b148cadb96d0..c030b08a7195 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
> @@ -1064,6 +1064,8 @@ static void check_getpeername_connect(int fd)
>  	socklen_t salen = sizeof(ss);
>  	char a[INET6_ADDRSTRLEN];
>  	char b[INET6_ADDRSTRLEN];
> +	const char *iface;
> +	size_t len;
>  
>  	if (getpeername(fd, (struct sockaddr *)&ss, &salen) < 0) {
>  		perror("getpeername");
> @@ -1073,7 +1075,13 @@ static void check_getpeername_connect(int fd)
>  	xgetnameinfo((struct sockaddr *)&ss, salen,
>  		     a, sizeof(a), b, sizeof(b));
>  
> -	if (strcmp(cfg_host, a) || strcmp(cfg_port, b))
> +	iface = strchr(cfg_host, '%');
> +	if (iface)
> +		len = iface - cfg_host;
> +	else
> +		len = strlen(cfg_host) + 1;

Why do we need to add 1 here? I tested it and it works without adding
1.

Other than this minor comment, everything looks good to me. No need for
a v2; it can be modified when applying if needed.

Reviewed-by: Geliang Tang <geliang@kernel.org>

Thanks,
-Geliang

> +
> +	if (strncmp(cfg_host, a, len) || strcmp(cfg_port, b))
>  		fprintf(stderr, "%s: %s vs %s, %s vs %s\n",
> __func__,
>  			cfg_host, a, cfg_port, b);
>  }
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index c5169020a515..e323f81cdc02 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -62,6 +62,7 @@ unset sflags
>  unset fastclose
>  unset fullmesh
>  unset speed
> +unset bind_addr
>  unset join_syn_rej
>  unset join_csum_ns1
>  unset join_csum_ns2
> @@ -645,6 +646,27 @@ wait_mpj()
>  	done
>  }
>  
> +wait_ll_ready()
> +{
> +	local ns="${1}"
> +
> +	local i
> +	for i in $(seq 50); do
> +		ip -n "${ns}" -6 addr show scope link | grep "inet6
> fe80" |
> +			grep -qw "tentative" || break
> +		sleep 0.1
> +	done
> +}
> +
> +get_ll_addr()
> +{
> +	local ns="${1}"
> +	local iface="${2}"
> +
> +	ip -n "${ns}" -6 addr show dev "${iface}" scope link |
> +		grep "inet6 fe80" | sed 's#.*\(fe80::.*\)/.*#\1#'
> +}
> +
>  kill_events_pids()
>  {
>  	mptcp_lib_kill_wait $evts_ns1_pid
> @@ -952,6 +974,7 @@ do_transfer()
>  	local fastclose=${fastclose:-""}
>  	local speed=${speed:-"fast"}
>  	local in="${sin}"
> +	local bind_addr=${bind_addr:-"::"}
>  	port=$(get_port)
>  
>  	:> "$cout"
> @@ -1005,7 +1028,7 @@ do_transfer()
>  	timeout ${timeout_test} \
>  		ip netns exec ${listener_ns} \
>  			./mptcp_connect -t ${timeout_poll} -l -p
> ${port} -s ${srv_proto} \
> -				${extra_srv_args} "::" < "${in}" >
> "${sout}" &
> +				${extra_srv_args} "${bind_addr}" <
> "${in}" > "${sout}" &
>  	local spid=$!
>  
>  	mptcp_lib_wait_local_port_listen "${listener_ns}" "${port}"
> @@ -3230,6 +3253,133 @@ add_addr_ports_tests()
>  	fi
>  }
>  
> +bind_tests()
> +{
> +	# bind to one address should not allow extra subflows to
> other addresses
> +	if reset "bind main address v4, no join v4"; then
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 2 2
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +		bind_addr="10.0.1.1" \
> +			run_tests $ns1 $ns2 10.0.1.1
> +		join_syn_tx=1 \
> +			chk_join_nr 0 0 0
> +		chk_add_nr 1 1
> +	fi
> +
> +	# bind to one address should not allow extra subflows to
> other addresses
> +	if reset "bind main address v6, no join v6"; then
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 2 2
> +		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
> +		bind_addr="dead:beef:1::1" \
> +			run_tests $ns1 $ns2 dead:beef:1::1
> +		join_syn_tx=1 \
> +			chk_join_nr 0 0 0
> +		chk_add_nr 1 1
> +	fi
> +
> +	# multiple binds to allow extra subflows to other addresses
> +	if reset "multiple bind to allow joins v4"; then
> +		local extra_bind
> +
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 2 2
> +		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
> +
> +		# Launching another app listening on a different
> address
> +		# Note: it could be a totally different app, e.g.
> nc, socat, ...
> +		ip netns exec ${ns1} ./mptcp_connect -l -p
> "$(get_port)" \
> +			-s MPTCP 10.0.2.1 &
> +		extra_bind=$!
> +
> +		bind_addr="10.0.1.1" \
> +			run_tests $ns1 $ns2 10.0.1.1
> +		chk_join_nr 1 1 1
> +		chk_add_nr 1 1
> +
> +		kill ${extra_bind}
> +	fi
> +
> +	# multiple binds to allow extra subflows to other addresses
> +	if reset "multiple bind to allow joins v6"; then
> +		local extra_bind
> +
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 2 2
> +		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
> +
> +		# Launching another app listening on a different
> address
> +		# Note: it could be a totally different app, e.g.
> nc, socat, ...
> +		ip netns exec ${ns1} ./mptcp_connect -l -p
> "$(get_port)" \
> +			-s MPTCP dead:beef:2::1 &
> +		extra_bind=$!
> +
> +		bind_addr="dead:beef:1::1" \
> +			run_tests $ns1 $ns2 dead:beef:1::1
> +		chk_join_nr 1 1 1
> +		chk_add_nr 1 1
> +
> +		kill ${extra_bind}
> +	fi
> +
> +	# multiple binds to allow extra subflows to other addresses:
> v6 LL case
> +	if reset "multiple bind to allow joins v6 link-local
> routing"; then
> +		local extra_bind ns1ll1 ns1ll2
> +
> +		ns1ll1="$(get_ll_addr $ns1 ns1eth1)"
> +		ns1ll2="$(get_ll_addr $ns1 ns1eth2)"
> +
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 2 2
> +		pm_nl_add_endpoint $ns1 "${ns1ll2}" flags signal
> +
> +		wait_ll_ready $ns1 # to be able to bind
> +		wait_ll_ready $ns2 # also needed to bind on the
> client side
> +		ip netns exec ${ns1} ./mptcp_connect -l -p
> "$(get_port)" \
> +			-s MPTCP "${ns1ll2}%ns1eth2" &
> +		extra_bind=$!
> +
> +		bind_addr="${ns1ll1}%ns1eth1" \
> +			run_tests $ns1 $ns2 "${ns1ll1}%ns2eth1"
> +		# it is not possible to connect to the announced LL
> addr without
> +		# specifying the outgoing interface.
> +		join_connect_err=1 \
> +			chk_join_nr 0 0 0
> +		chk_add_nr 1 1
> +
> +		kill ${extra_bind}
> +	fi
> +
> +	# multiple binds to allow extra subflows to v6 LL addresses:
> laminar
> +	if reset "multiple bind to allow joins v6 link-local
> laminar" &&
> +	   continue_if mptcp_lib_kallsyms_has
> "mptcp_pm_get_endp_laminar_max$"; then
> +		local extra_bind ns1ll1 ns1ll2 ns2ll2
> +
> +		ns1ll1="$(get_ll_addr $ns1 ns1eth1)"
> +		ns1ll2="$(get_ll_addr $ns1 ns1eth2)"
> +		ns2ll2="$(get_ll_addr $ns2 ns2eth2)"
> +
> +		pm_nl_set_limits $ns1 0 2
> +		pm_nl_set_limits $ns2 2 2
> +		pm_nl_add_endpoint $ns1 "${ns1ll2}" flags signal
> +		pm_nl_add_endpoint $ns2 "${ns2ll2}" flags laminar
> dev ns2eth2
> +
> +		wait_ll_ready $ns1 # to be able to bind
> +		wait_ll_ready $ns2 # also needed to bind on the
> client side
> +		ip netns exec ${ns1} ./mptcp_connect -l -p
> "$(get_port)" \
> +			-s MPTCP "${ns1ll2}%ns1eth2" &
> +		extra_bind=$!
> +
> +		bind_addr="${ns1ll1}%ns1eth1" \
> +			run_tests $ns1 $ns2 "${ns1ll1}%ns2eth1"
> +		chk_join_nr 1 1 1
> +		chk_add_nr 1 1
> +
> +		kill ${extra_bind}
> +	fi
> +}
> +
>  syncookies_tests()
>  {
>  	# single subflow, syncookies
> @@ -4184,6 +4334,7 @@ all_tests_sorted=(
>  	M@mixed_tests
>  	b@backup_tests
>  	p@add_addr_ports_tests
> +	B@bind_tests
>  	k@syncookies_tests
>  	S@checksum_tests
>  	d@deny_join_id0_tests
> 

