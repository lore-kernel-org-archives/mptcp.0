Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793655495;
	b=3EgM8BvaML+iu1Hj76IRoicbO7ycHID11YmbkcZQ1Yz4VtfjCgD/+oo5fL5aR0fxApnJ
	 Lr/kXZn1GGa1lAuAnbeuKuwzEoWe3F0lR8313tD+gmU5OeS3c3zUMcXx7DVlTAI4/GcXm
	 hSPqMcB2hmjFrxz3jRmV8pYjsy7kU3s8vZVHI3SURR/LSbvIOfRxA5BH2eefg+JKO3hj3
	 ziuYFii514/9xVyHFVUaliicwJ1C49vdAV0Il5AJoZexh5Pgp8Zmyd0ZW8Cmv6nVTxsxS
	 6JTiDSP1wXjoma11gypRDAP5Ridx5D1RDhX3drVq6kEQywHGCkHsWbyMJ57hF29xfEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793655495;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=v5MYJG5Dp3x5MMNzuAsgImVDlzSR0rO/l9oQh8GUFqw=;
	b=0TRK+ClKQSKh4Nl2kQgf9VaMNYgmhZovPSaghCDHwmYFnaGdA9JBxawA3M8sZ2IPQx4K
	 OegGNvGMOUkg5boZmv8dtQg2RysftG5ypg/Zr2eEOQ5+24cU/M/j6GEORsrl0/tOz0iBZ
	 /7izAK65UzzKdE4kO/uE6D/iLir+JKp2mP0VNDyZea8p+yG4w0VnviOy7caLYNbuHKVri
	 pNpIHG+LzwqTRQOo9RymeGq0qKoNgp56trkCifGoIY8ASLxHYcn8G48/9GvFZ0qzNsDi6
	 gJNPia0/o4g0d/vVyRu9HH/Qe6riTw5IFVu1fsRy8Ke8WBFLM1skUG9IHXLaBII1b3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DDzDDwZ/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB510606A324
	for <mptcp@lists.linux.dev>; Mon,  2 Nov 2026 21:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDzDDwZ/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4CC1F00A17;
	Mon,  2 Nov 2026 21:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793655494;
	bh=v5MYJG5Dp3x5MMNzuAsgImVDlzSR0rO/l9oQh8GUFqw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DDzDDwZ/G7B8OLEb/8CQtptgekn91WcfrPLSR7JYbsX7F3kIVjoF1slNTdwKW6KwP
	 LtFj0oOzX8guLnqRn6yEvhMJDdPANMzZNUKKQHPvZYEwYUaDHqgVTy4H16cVpod3Hj
	 moPIZZUPZ9XEqr8SfoSmk3FqXGjtPDJlRIrPL5EdndsYMIVNHSUDQNFln6kJEEA8H2
	 PzmE14HEMeynC4Yhhcakkae9+KsnZ2NnIeO+vMmcTf+o9JzPR225DupN1nzVcmXYtB
	 g9CabHv6BvTqSpcMNGryITlD5kQ/gGIo0Qo1Y4X2PQITyAuw4UaQKkfL/7r+TIG+Fu
	 smjBJcTOzOfOg==
Subject: Re: [PATCH mptcp-next v14 6/6] selftests: mptcp: join: validate
 subflow retry after link failure
From: netdev-bot+sashiko@kernel.org
To: anilkaushikwireless@gmail.com
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 02 Nov 2026 21:38:13 +0000
Message-ID: <179365549394.3128.324852138483087912@kernel.org>
In-Reply-To: <20261101072051.3853492-7-anilkaushikwireless@gmail.com>
References: <20261101072051.3853492-7-anilkaushikwireless@gmail.com>
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

- [Medium] The first new test, "subflow retry after link failure" in
  link_failure_tests()…

--

selftests: mptcp: join: validate subflow retry after link failure

This adds four mptcp_join.sh tests for the subflow-retries limit. Each one
uses netfilter rules in ns2 to drop a path's packets without taking the
link down, until the subflow times out and is re-created. The tests cover:

  - re-creating the additional subflow, then the initial one
  - closing the connection while a subflow is being re-created
  - not re-creating the only subflow
  - falling back to the next endpoint when bind() fails

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index c3ccce96b45b1..b95a96f975cdb 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

[ ... ]

> +sf_retry_after_block()
> +{
> +	local before ack_rx syn_tx
> +

[ ... ]

> +	# read before the block: the subflow can be re-created right after it
> +	syn_tx=$(mptcp_lib_get_counter $ns2 "MPTcpExtMPJoinSynTx")
> +	# a short timeout only while the path is blocked: the other one must
> +	# not time out on losses
> +	ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=3
> +	if ! nft_drop_from "${1}"; then
> +		fail_test "unable to drop the packets from ${1}"
> +		return
> +	fi
> +	if ! wait_counter_ge "${timeout_poll}" $ns2 "MPTcpExtMPJoinSynTx" \
> +	     $((syn_tx + 1)); then
> +		ip netns exec $ns2 nft flush chain ip filter OUTPUT
> +		fail_test "subflow from ${1} not re-created"
> +		return
> +	fi
> +	ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=15

[Severity: Medium]
Does the first test actually keep the short timeout to the block window,
as this comment and the v14 note ("tcp_retries2 is only lowered while a
path is blocked in the first test") say?

sf_retry_init() already sets it for the whole ns2 netns, before run_tests
starts in the background:

sf_retry_init()
    ...
	ip netns exec $ns2 sysctl -q net.ipv4.tcp_retries2=3

The "subflow retry after link failure" test in link_failure_tests() then
goes straight to the first block. Nothing resets the value to 15 in
between:

		sf_retry_init
		{ timeout_test=600 test_linkfail=131072 \
			run_tests $ns1 $ns2 10.0.1.1 & } 2>/dev/null
		...
			sf_retry_after_block 10.0.3.2
			sf_retry_after_block 10.0.1.2

So both paths run with tcp_retries2=3 from connection setup until the
first block. They do this on 4mbit netem links with "limit 30", which
drop packets by design. The "close while connecting" and "creation error"
tests set tcp_retries2=15 explicitly, but the first test does not.

Also, tcp_retries2 is a per-netns sysctl. During the block window, won't
the unblocked path, which carries all the data and reinjections, use
retries2=3 as well?

The two early returns above ("unable to drop the packets from ..." and
"subflow from ... not re-created") also skip the restore to 15. Because
sf_retry_after_block() returns no status, the second call for 10.0.1.2
still runs with the short timeout.

If an RTO timeout hits an unblocked subflow in one of these windows, the
PM would re-create it. That adds an extra MP_JOIN and an extra SUB_CLOSED
event. Could that make these fixed expectations fail on a correct kernel?

		join_syn_tx=3 chk_join_nr 3 3 3
		...
		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_ESTABLISHED 3
		chk_evt_nr ns2 MPTCP_LIB_EVENT_SUB_CLOSED 2 error 2

Would it match the intent to set tcp_retries2=15 right after
sf_retry_init() in the first test, as the other tests do, and to restore
it on the early return paths? If not, the comment and the changelog note
may need updating.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261101072051.3853492-1-anilkaushikwireless%40gmail.com
