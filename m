Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793153673;
	b=apRYB+6PDThGINohJ/4N65fsCVIIgpFIcPxjk7MX5nY80p2/IgwOQXB2LJFF3+ApXm25
	 xiTxDWSwV/PmOjEcKHvEbnvL8gpEl+wHMPJuArriCCKeMl1tPkbMgifz21f2Qr5TJPlhW
	 BumngVTibFmyGc/THK+5c0zkb8QEn9gA5r+zD2/7PssvZF02m4cfJKT5jwIYQg3UojUwl
	 27+U1yjjKNADbY9lQbdXxHZF5+Rh95CrFOTWBFww0RevqCpRc0x3Pe6gFBgxQXvWfdso4
	 Knyn+f6BGu7sHW9OSITJDVYrFHxcwqt7o+1JllG0tN8D2A6k7HTnqeIpDNr2PsGjT3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793153673;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=KUT6lEdVNZiJEGnBru0QrMt1V5pyg/Z8Vw+pR5c9frY=;
	b=qOUsvUWz26SFzspywmn3fZsikXaft1W/Psg6lDVEP56Zeh9YXXrdJo7Zqg9kXM4Aph3g
	 LYDuAu/V1JnfTLKCO70lNdsYAoLh8nfiOqsJwUYWrshOtnD2pmCdnUHxhtW2zoeNObpUp
	 uGOJMdCiP390ESVT1fnejb1Og6Y/UIvuhfP4H8fPFSwe/11AsRnIFQYRFZPkuhelfFHL/
	 uWeQJpGIpXQ9ACxV0kkCUspa/BcDDQifpPFLyz3mFSbAgYCzYm31NXF8JK6SqrY/AFC1g
	 9xQCrfs5YU4l/DeMpicmd3yY+/N/s7IImnnGhsbTAZSoq/yfTR6IBpGzu3CxL/ldiVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FAza6sWw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B481606A320
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 02:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FAza6sWw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61211F01825;
	Wed, 28 Oct 2026 02:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793153672;
	bh=KUT6lEdVNZiJEGnBru0QrMt1V5pyg/Z8Vw+pR5c9frY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FAza6sWwl1dfiRe/Rr7+q3Va6v8H8OAZQTZJqrRMjnKG35woENivU7QBIvhSl1y93
	 QM+ZhPZJtOvWBS5DNfWUz56utWhqiYFz6WYdvHwSDGP+9PBIrXPkvtkj8ldIgJO3MP
	 Cz5roP2NPRXPUa/90FmFv1IDZvI9sjF3HLYxlFoaBO8+o60HBLXQZYE1OTpcGMJ7Lu
	 mznhTJFfXreKLv659oGE/Gpc0w+ovd4UomRv+nS2gXMLWKsQMjrEBu5CpJ5SLYku57
	 NopC8OuPWRYNHIMBhd5QTwZhTY6j6FXtWzf1IGbb6tVSAMH1jhYKVhozTmUeD6CEpe
	 ul27bbP0fZhbA==
Subject: Re: [PATCH mptcp-next v11 6/6] selftests: mptcp: join: validate
 subflow retry after link failure
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Wed, 28 Oct 2026 02:14:32 +0000
Message-ID: <179315367228.3132.6586887428411214670@kernel.org>
In-Reply-To: <20261026125345.3019372-7-anilkaushikwireless@gmail.com>
References: <20261026125345.3019372-7-anilkaushikwireless@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In link_failure_tests(), the comment on the 'subflow retry, no
  other subflow' test says 'the connection is closed after the close…
- [Low] In the first new test, link_failure_tests() calls
  mptcp_lib_kill_group_wait right after sf_retry_after_block 10.0.1.2…

--

selftests: mptcp: join: validate subflow retry after link failure

This adds three mptcp_join.sh tests for the subflow-retries limit. The
first re-creates subflows after their packets are dropped with
netfilter. The second closes the connection while a subflow is being
re-created. The third checks that the only subflow is not re-created.

do_transfer() and run_tests() also get a server_in option, and the
failure input files are regenerated when they have been emptied.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index c3ccce96b45b1..93a42bb06c69e 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

[ ... ]

> @@ -2585,6 +2784,126 @@ link_failure_tests()
>  		chk_stale_nr $ns2 1 -1 2
>  		chk_link_usage $ns2 ns2eth3 $cinsent 50
>  	fi
> +
> +	# subflows closed after a silent link failure, then re-created: the
> +	# additional one, then the initial one
> +	if reset_with_events "subflow retry after link failure" &&
> +	   continue_if has_subflow_retries && init_nft_filter; then
> +		sf_retry_init

[ ... ]

> +		sf_retry_after_block 10.0.3.2
> +		sf_retry_after_block 10.0.1.2
> +		mptcp_lib_kill_group_wait $tests_pid
> +		kill_events_pids
> +
> +		join_syn_tx=3 chk_join_nr 3 3 3
> +		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 3
> +		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2 error 2

[Severity: Low]
Can the SUB_CLOSED count here be off by one if the client is killed before
its re-created subflow is fully established?

sf_retry_after_block() reports success once MPTcpExtMPJoinAckRx goes up in
ns1 and ss shows an established TCP subflow from 10.0.1.2. Nothing checks
that the client-side MP_JOIN subflow has become fully_established before
mptcp_lib_kill_group_wait kills the client.

If the close comes first, __mptcp_close()->mptcp_close_retry_subflows()
emits one more event for that subflow:

net/mptcp/protocol.c:mptcp_close_retry_subflows() {
    ...
		if (!subflow->retry || READ_ONCE(subflow->fully_established))
			continue;

		if (sk->sk_state == TCP_ESTABLISHED &&
		    !subflow->close_event_done) {
			subflow->close_event_done = true;
			mptcp_event(MPTCP_EVENT_SUB_CLOSED, msk, ssk,
    ...
}

In that case "chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2 error 2" would
see 3 events.

In practice the window looks small. When the server's
check_fully_established() gets the 3rd ACK, it sends the 4th ACK right
away, so the client should be fully established a few ms after
MPJoinAckRx goes up. The shell path to the kill takes tens of ms.

The race still only needs that ACK to be lost or handled late, and
nothing in the test stops that. Would it help to wait until the client
side is fully established before killing it?

> +		sf_retry_cleanup
> +	fi

[ ... ]

> +	# the only subflow is not re-created: the connection is closed after the
> +	# close timeout, as before
> +	if reset_with_events "subflow retry, no other subflow" &&
> +	   continue_if has_subflow_retries && init_nft_filter; then

[ ... ]

> +		else
> +			# the worker decides right after TCP closed the subflow
> +			sleep 2
> +			local syn_tx
> +			syn_tx=$(mptcp_lib_get_counter $ns2 \
> +				 "MPTcpExtMPJoinSynTx")
> +			if [ "${syn_tx}" != 0 ]; then
> +				fail_test "subflow re-created"
> +			else
> +				print_ok
> +			fi
> +		fi
> +		mptcp_lib_kill_group_wait $tests_pid
> +		kill_events_pids
> +
> +		join_syn_tx=0 chk_join_nr 0 0 0
> +		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 1 error 1
> +		sf_retry_cleanup
> +	fi
>  }

[Severity: Low]
The comment above this test says the connection is closed after the close
timeout. The commit message says the same:

  A third test checks the only subflow is not re-created: without another
  subflow to send data, the connection is closed after the close timeout,
  as before.

Is the second half of that checked anywhere?

The body only checks that MPTcpExtMPJoinSynTx is still 0 after sleep 2.
Then mptcp_lib_kill_group_wait kills both client and server, long before
net.mptcp.close_timeout (60s by default) can expire. After that, only
chk_join_nr 0 0 0 and one SUB_CLOSED event with an error are checked.

Nothing looks at MPTCP_LIB_EVENT_CLOSED, the msk state, or the close
timeout that mptcp_start_tout_timer() starts in __mptcp_close_ssk().

mptcp_pm_kernel_retry_check() in net/mptcp/pm_kernel.c makes the same
claim:

	/* Only while another subflow can send data: without one, the
	 * connection is closed after the close timeout, as before, see
	 * __mptcp_close_ssk().
	 */

Suppose the msk stopped closing on its own after its last subflow closed,
for example staying established with no subflows. Would this test still
pass, as long as no MP_JOIN SYN goes out?

Could the test check the close as well, for example with a shorter
close_timeout and a wait for the CLOSED event? Or could the comment and the
commit message be reduced to what is actually checked?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261026125345.3019372-1-anilkaushikwireless%40gmail.com
