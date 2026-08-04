Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC06416846
	for <mptcp@lists.linux.dev>; Tue,  4 Aug 2026 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868670; cv=none; b=d7z0f3dk5AVByQUeR3Cx9RPb27QRRxYtcLAD7NZmy7AbkMkcRytZ+WgWKLEG2dpH0EPy8dHT8YTxn+ZHRTLEt12PiKk7oigOXf20u8D7V0ukQiB6maYuzbciQHSL5PRvHj8hzPrDO9xTrhAdLImDWCsc6KyGufI5Ov7f7BvZ4Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868670; c=relaxed/simple;
	bh=QJz7HRKyZ+iWKF7zjV1oZ+apFjV53zXBb7vXadWBZLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q7mxbUiqCFAsqcp1GWI5fWaTszpk4tQPfe6SAncqVikJQPjUtNr17UCKorLvQ+0Qmtu5cSagY4NYXMzVQwcAL2+HX9RzNu+3Lj8xitVYve7ak1otPkAcb8sYDRj/AtGPwYmOPxSsTiF+oGqowzbzz4SUVcRS/50Deh8qcFnq3JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPj2MqJ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPj2MqJ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842B31F000E9;
	Tue,  4 Aug 2026 18:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785868668;
	bh=kg2kw2WtiAWPsrD6qceSohIzETG5m73r56oLy7MYP84=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PPj2MqJ55PE04ci9qY9lEtOUMdWEz/9s9kd7HNlzMHPb/uBYDXYwkfxS8ZsKHNbS2
	 hU9XIj7vDMSQtHgjFg6JRQM4b+1JQsydzvIeh7nRv7tcGEpzTVVPDSPoYG29SdTRG5
	 xsq5ouYhuovxHq4V5yuq37CzcWv4wPtpXOqpdezR7BEyMDMhvkFISExTBt3EpKO54w
	 fodt7HCvnWECcmXYmMlpHjwbD5FnoTyI/UVkp7VXP8iFermBn7wnRa47SPUaocjtMa
	 eGaRTlGic8R4cfMylVinlbUDqKOhnGFPmNGxr5qz6B2GjM8QerZFZUnWu48CcX37oJ
	 bZ/qhnhIisWng==
Message-ID: <71a95e5f-957b-4783-be1e-375cb36f94a3@kernel.org>
Date: Tue, 4 Aug 2026 20:37:45 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH MPTCH-next] selftests: add test for userspace PM address
 ID overflow
Content-Language: fr
To: luoqing <l1138897701@163.com>
Cc: mptcp@lists.linux.dev
References: <20260714080356.805839-1-l1138897701@163.com>
 <20260804022350.181323-1-l1138897701@163.com>
 <20260804022350.181323-2-l1138897701@163.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260804022350.181323-2-l1138897701@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi luoqing,

On 04/08/2026 04:23, luoqing wrote:
> From: Qing Luo <luoqing@kylinos.cn>
> 
> Add a test that verifies the userspace PM correctly returns an error
> when all address IDs (1-255) are exhausted, instead of overflowing.
> 
> The test first announces 255 unique addresses (IDs 1-255) to fill the
> ID bitmap. It then attempts to create a subflow (CSF) without specifying
> a local ID, which triggers auto-allocation via
> mptcp_userspace_pm_get_local_id(). With all IDs in use, the allocation
> should fail with -ENOSPC.
> 
> Also modify pm_nl_ctl to make the 'lid' parameter optional for the CSF
> command. When omitted, the kernel auto-allocates a local ID.

Same as for the other patch: should be in a different patch, but can
certainly be dropped.

> MPTCP_PM_MAX_ADDR_ID has been 255 since the userspace PM was introduced,
> so no version-dependent limit adjustment is needed (unlike pm_netlink.sh).
> 
> Assisted-by: LLM # code
> Signed-off-by: Qing Luo <luoqing@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  8 +--
>  .../selftests/net/mptcp/userspace_pm.sh       | 63 +++++++++++++++++++
>  2 files changed, 67 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> index 78180da1efcc..a9dd650805a9 100644
> --- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> +++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> @@ -32,7 +32,7 @@ static void syntax(char *argv[])
>  	fprintf(stderr, "\tadd [flags signal|subflow|backup|fullmesh] [id <nr>] [dev <name>] <ip>\n");
>  	fprintf(stderr, "\tann <local-ip> id <local-id> token <token> [port <local-port>] [dev <name>]\n");
>  	fprintf(stderr, "\trem id <local-id> token <token>\n");
> -	fprintf(stderr, "\tcsf lip <local-ip> lid <local-id> rip <remote-ip> rport <remote-port> token <token>\n");
> +	fprintf(stderr, "\tcsf lip <local-ip> [lid <local-id>] rip <remote-ip> rport <remote-port> token <token>\n");
>  	fprintf(stderr, "\tdsf lip <local-ip> lport <local-port> rip <remote-ip> rport <remote-port> token <token>\n");
>  	fprintf(stderr, "\tdel <id> [<ip>]\n");
>  	fprintf(stderr, "\tget <id>\n");
> @@ -481,7 +481,7 @@ int csf(int fd, int pm_family, int argc, char *argv[])
>  	off = init_genl_req(data, pm_family, MPTCP_PM_CMD_SUBFLOW_CREATE,
>  			    MPTCP_PM_VER);
>  
> -	if (argc < 12)
> +	if (argc < 10)
>  		syntax(argv);
>  
>  	/* Params recorded in this order:
> @@ -557,9 +557,9 @@ int csf(int fd, int pm_family, int argc, char *argv[])
>  			off += NLMSG_ALIGN(rta->rta_len);
>  		}
>  
> -		if (arg == 0) {
> +		if (arg == 0 && params[1]) {
>  			/* id */
> -			id = atoi(params[arg + 1]);
> +			id = atoi(params[1]);
>  			rta = (void *)(data + off);
>  			rta->rta_type = MPTCP_PM_ADDR_ATTR_ID;
>  			rta->rta_len = RTA_LENGTH(1);
> diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> index 30a809752d1b..45b040a8c0e5 100755
> --- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
> +++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
> @@ -847,6 +847,68 @@ test_subflows_v4_v6_mix()
>  	sleep 0.5
>  }
>  
> +test_addr_id_overflow()
> +{
> +	print_title "Address ID overflow tests"
> +
> +	local i announced=0
> +
> +	:>"$server_evts"
> +
> +	# Clear leftover addresses from previous tests
> +	for i in $(seq 0 255); do
> +		ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id "$i" > /dev/null 2>&1
> +	done

Is this really needed?

> +
> +	# Announce 255 addresses (IDs 1-255) to exhaust all available IDs
> +	for i in $(seq 1 255); do
> +		if ip netns exec "$ns2" ./pm_nl_ctl ann 10.0.3."${i}" token "$client4_token" id \
> +			"$i" dev ns2eth1 > /dev/null 2>&1; then

Why hiding errors? (OK to hide if it is just to use all bits, then try
one extra to check the error)

> +			announced=$((announced + 1))

Set but not used?

> +		fi
> +	done

Mmh, all of this is very slow: 19 seconds on the CI with a "normal"
kconfig, 52 seconds with a "debug" one...

That's a lot... Any ideas on how to reduce this time? (maybe not possible?)

> +
> +	print_test "ADD_ADDR with all IDs 1-255 exhausted"
> +	sleep 1

Why this "sleep 1"?

> +	if [ -s "$server_evts" ]; then
> +		test_pass
> +	else
> +		test_fail "No events generated"
> +		return
> +	fi
> +
> +	# Start listener to ensure subflow creation doesn't fail on connectivity

Really needed?

> +	ip netns exec "$ns1" ./pm_nl_ctl listen 10.0.1.1 "$app4_port" >/dev/null 2>&1 &
> +	local listener_pid=$!
> +	sleep 0.5
> +
> +	# Try to create a subflow without specifying a local ID.
> +	# With all IDs exhausted, this should fail with -ENOSPC.
> +	print_test "CSF without local ID after all IDs exhausted - expect failure"
> +	local out
> +	if out=$(ip netns exec "$ns2" ./pm_nl_ctl csf lip 10.0.1.2 \
> +		rip 10.0.1.1 rport "$app4_port" token "$client4_token" 2>&1); then

I guess you cannot have an overflow with csf, because an ID is required.

> +		test_fail "Expected failure but CSF succeeded"
> +	else
> +		# pm_nl_ctl prints the kernel error as "netlink error -28 (No space
> +		# left on device)" for -ENOSPC. Match either form.

Really needed? The pm_nl_ctl should fail.

> +		if echo "$out" | grep -qE "netlink error -?28|No space left on device"; then
> +			test_pass
> +		else
> +			test_fail "CSF failed, but not with the expected ENOSPC: ${out}"
> +		fi
> +	fi
> +
> +	# Delete the listener from the server ns, if one was created
> +	mptcp_lib_kill_wait $listener_pid
> +
> +	# Cleanup: remove all announced addresses
> +	for i in $(seq 1 255); do
> +		ip netns exec "$ns2" ./pm_nl_ctl rem token "$client4_token" id "$i" > /dev/null 2>&1
> +	done

Maybe not needed?

> +	sleep 1

Clearly not needed.

> +}
> +
>  test_prio()
>  {
>  	print_title "Prio tests"
> @@ -940,6 +1002,7 @@ test_subflows
>  test_subflows_v4_v6_mix
>  test_prio
>  test_listener
> +test_addr_id_overflow
>  
>  mptcp_lib_result_print_all_tap
>  exit ${ret}

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

