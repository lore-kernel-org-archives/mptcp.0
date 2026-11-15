Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794739991;
	b=gPFogDwTuSIuFV31KAgH1oQ+4DjX13yUvH/JQJL4ZA6yMr8+qORm2AsRTRhShZFG47UY
	 OId0/ZYtf+242xXMd446IlqAI+EJvdHUJyYvhxszb49W6ziFDnU5MaQmZ2/gE/+UvFjdi
	 caIFau9/DxzEiepwsLKaPjS7JAgqCjWW848KR5EvGEhVh6asTzuk9D8x7dZKnJ2HqZABE
	 8MpqHLI2SRe1aEHmVUuIvykJ2T0Lm3zU10ziIpaw+VJDsvlBw+ciho4ZKA7TeSnQcS+R6
	 4+WmhWQnhRlYRg/HtJ+ZdnCQJYOnlxeFLlK9CO2cmYgA+nSVCRDHS1GCVYO2wQ+7Urg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794739991;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=aTgAFbgNcoTZUOssvyWmIQvvdezPe1WCP+dX0WOCuIY=;
	b=xxKOHJuV+Wvm4WydeNekXn+wI/NZqIHrIFBXKYkgfvRt9hvespLLOWiz1V57+RuOhZeF
	 iynFOWc6D2NGEStJsIPLB4rKSEro0/no0fk4NaiKbjYahMTAa+hCym4/Sd/7BidPk8JjE
	 QFfnTGb5RJyNLlR5ejcOB4MZ0ZIgCqXJ3Br/HsIpQFZB96Sv9baVR8NY1PHNZpKGVMHq8
	 ihsyLSsiVgqNWHB1gIN9w0O2tQOwZzGhPDEbNiG3cHi711y4qTneNTJ+DLDMb712X7D3e
	 hYJTI630flCBQirZXeUO7PRNPwmFTlTk2W/D6HnzPNn1SU5tMUViE+zmw65ZCKH+29A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RxHj7RtZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636A3606A31E
	for <mptcp@lists.linux.dev>; Sun, 15 Nov 2026 10:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RxHj7RtZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20541F000CD;
	Sun, 15 Nov 2026 10:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794739991;
	bh=aTgAFbgNcoTZUOssvyWmIQvvdezPe1WCP+dX0WOCuIY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RxHj7RtZZGogKO1D/QiJUOoXJO+SwYsRPZ+WCnA59CF5lwaBBsJBMyAD9waAshvhW
	 d4cMTe3jPNW1rsONPcVfkg+T4aMaREHOG2Ny7kKleIOO0hb04zMa9XF4pkRU2HSeGY
	 9tVMldJjUpnbBkl/w1SrEUvyJzfVKbybyS764Vkvv/HhpeBNRPupHHvizA3r8Ow7AR
	 5owOPiKm3WQLhjEhK8A7sBBAJb7hx00T7YCOMLHUv+0Ty3ArQIkW4gKN2L/HAOuF24
	 EiUtzEeW5ih51AiVlP6x2gd6A/X5mUwUY/iL5PhDOZk9LnXdbW/uPDxbmVKGT0fcDE
	 4BVDGhbk+D8Ew==
Subject: Re: [PATCH mptcp-net 22/34] selftests: mptcp: join: check re-adding
 signal+subflow ID 0 endp
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc:
 mptcp@lists.linux.dev, mason@kernel.org, pabeni@redhat.com, kuba@kernel.org
Date: Sun, 15 Nov 2026 10:53:10 +0000
Message-ID: <179473999054.488855.10003144087751831988@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-22-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-22-9205b77e9a2f@kernel.org>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In tools/testing/selftests/net/mptcp/mptcp_join.sh,
  endpoint_tests(), "delete and re-add" subtest: the patch adds an nft…

--

selftests: mptcp: join: check re-adding signal+subflow ID 0 endp

This extends the "delete and re-add" subtest in endpoint_tests(). From the
second round, the ID 0 endpoint is re-added with both the signal and
subflow flags, which validates the fix for that endpoint being counted as
used on every re-add. To keep the counters stable, add_addr_timeout is set
to 0 on ns2 and a new nft rule drops the ADD_ADDR sent in those rounds.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index c3ccce96b45b1..6cd1875774795 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -4387,17 +4387,23 @@ endpoint_tests()
>  		ip netns exec "${ns2}" nft insert rule ip filter OUTPUT \
>  			ip saddr 10.0.1.2 meta l4proto tcp \
>  			"${RM_ADDR_OFFSETS}" drop || nft=0
> -		local i
> +		# No ADD_ADDR to ns1: it could try to connect back to ns2's port
> +		ip netns exec "${ns2}" sysctl -q net.mptcp.add_addr_timeout=0
> +		ip netns exec "${ns2}" nft insert rule ip filter OUTPUT \
> +			meta l4proto tcp \
> +			tcp option mptcp subtype add-addr drop || nft=0

[Severity: Medium]
What happens if the add-addr rule can't be installed? The || nft=0 hides
the error, and the subtest keeps running.

>From the second round, the endpoint is re-added with "signal,subflow", so
ns2 sends ADD_ADDR and nothing drops it. On ns1,
mptcp_pm_add_addr_received() emits the event before any PM checks:

net/mptcp/pm.c:mptcp_pm_add_addr_received() {
    ...
	mptcp_event_addr_announced(ssk, addr);

	spin_lock_bh(&pm->lock);
    ...
}

That means this hard-coded check later in endpoint_tests() would fail:

	chk_evt_nr ns1 MPTCP_LIB_EVENT_ANNOUNCED 0

The commit message also says ns1 could try to connect back to ns2's
address and port. That would change the join and subflow counters too.

reset_with_add_addr_timeout() in the same file already treats this nft
match as optional and skips the test when it fails:

	if ! ip netns exec "$ns2" nft add rule \
			ip"$ip" filter OUTPUT meta l4proto tcp \
			tcp option mptcp subtype add-addr \
			drop; then
		mark_as_skipped "unable to set the 'add addr' rule"
		return 1
	fi

Should this subtest skip the same way instead of reporting a failure?

There is also a side effect: both rules now share the nft variable. If
only the add-addr insert fails, the flush after the loop is skipped:

	[ "${nft}" = 1 ] && ip netns exec "${ns2}" nft flush chain ip filter OUTPUT

Would that leave the RM_ADDR drop rule in place for the rest of the
subtest? Before this patch it was flushed.

> +		local i flags="subflow"
>  		for i in $(seq 3); do

[ ... ]

> -			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags subflow
> +			pm_nl_add_endpoint $ns2 10.0.1.2 id 1 dev ns2eth1 flags "${flags}"
>  			wait_mpj $((3 + i))
>  			chk_subflow_nr "after re-add id 0 ($i)" 3
>  			chk_mptcp_info subflows 3 subflows 3
> +			flags="signal,subflow" # ID 0 not counted as used either
>  		done
>  		[ "${nft}" = 1 ] && ip netns exec "${ns2}" nft flush chain ip filter OUTPUT

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f%40kernel.org
