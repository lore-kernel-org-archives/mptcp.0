Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B174E37E5E0;
	Mon, 28 Sep 2026 08:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582426; cv=none; b=j8sQRNg4miKmmEXiSWUI3YoEZLXDSol2Q8CVgUX8LqMMdol6uOrqlY6EOG1T2/W4bfTienZroYKnvxhhhnWOOAJI525QA53T65KrovWA4VYxZLk3jW+KUXz+lnu4VF1F7DC3Rgqh/ePDu2ZskgZ5rWdoRE/uDGMiqcQ2wD2GQV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582426; c=relaxed/simple;
	bh=l81R9WM8DbHwJewLmAs9hgH/CkQjZFifExB+Lz9BM8c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YqHTZxUIzA+d5lGi0bbctXVJunRON6U85A9izr+V6q/RfDwZEPLnln55uirk/mHNNu0HBT6EpXIHHKTJA1RIM/bHk+H3YmptcHntbI5KNH9I91aPM1WezuQch21K7qmvRvhzD56J/beo26YFRUuvgWrB5PjkDIKJfM92i9u03Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTYqcT1U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTYqcT1U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB92F1F000FF;
	Mon, 28 Sep 2026 08:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790582424;
	bh=ur90cJ6ifeUP3pY3In1pURIlIV16eVbuGZv1wN4zN8g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FTYqcT1UePh9NGYFJ6EEBOC2Mtrnw+TGYJWhLBVD5FQmZ98qJbE0aR25rv/5o2Wmb
	 CKAcl623fnb9UB1R08UCm9Qssr0Cz9kvmf4AfTZ+i2NGC0TVp5nDsYC7yoVns9XBt8
	 9FwEr4gdXCh+GdzvGHxvce4MTci6PLM35Om8bPy4b2gea/hr337jhjaa2R+E2oSFhD
	 hqprh/27U8F9Oqm6y8LaeWcrIxdNDi1D+zshUuOZxgdU4wP/CQRHbezVy1GMRm5Rae
	 uITr1ckORE7G8czke6ObVsbopuChMJj9RXyEnALrMQJ2Ui/etAiWgxRMBJ5JWDnf2i
	 W+e0lPHOTyJaw==
Subject: Re: [PATCH net-next 4/5] selftests: mptcp: convert iptables to
 nftables for mptcp_sockopt.sh
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 quanyeyang@proton.me
Date: Mon, 28 Sep 2026 08:00:23 +0000
Message-ID: <179058242329.3145.13094983040753478975@kernel.org>
In-Reply-To:
 <20260926-net-next-mptcp-misc-feat-7-4-v1-4-67af4ab37406@kernel.org>
References:
 <20260926-net-next-mptcp-misc-feat-7-4-v1-4-67af4ab37406@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The nft/jq tool check added to mptcp_lib_check_tools()
  (tools/testing/selftests/net/mptcp/mptcp_lib.sh:531-532) only runs…
- [Low] In add_mark_rules()
  (tools/testing/selftests/net/mptcp/mptcp_sockopt.sh:57-60), the…

--

selftests: mptcp: convert iptables to nftables for mptcp_sockopt.sh

This commit makes mptcp_sockopt.sh use nftables instead of
iptables/ip6tables. It creates ip/ip6 filter tables with an OUTPUT chain,
and check_mark() now reads the drop counter through nft -j and jq. It also
extends mptcp_lib_check_tools() to probe for nft and jq.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index b9d14647f4019..e65b4ebee06a6 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -528,7 +528,7 @@ mptcp_lib_check_tools() {
>  				exit ${KSFT_SKIP}
>  			fi
>  			;;
> -		"iptables"* | "ip6tables"*)
> +		"iptables"* | "ip6tables"* | "nft" | "jq")
>  			if ! "${tool}" -V &> /dev/null; then

[Severity: Medium]
Is nft -V the right probe for nft here?

For nft, -V prints extended build information, and only newer nftables
releases have it. The portable version flag is -v or --version, which is
what the other selftests use. For example, the netfilter/*.sh scripts call
nft --version.

If an older nft rejects -V, would mptcp_lib_check_tools() exit with
KSFT_SKIP from the top-level call in mptcp_sockopt.sh?

    mptcp_lib_check_tools ip nft jq

That would also skip the transfer, sockopt and TCP_INQ subtests, which
don't use nft at all.

The opposite case is also a concern. check_mark() needs an nft that was
built with JSON support:

    drops=$(ip netns exec "$ns" nft -j list table "$tables" filter | \
    ...
    if [ -z "$drops" ] || [ "$drops" -ne 0 ]; then
            mptcp_lib_pr_fail "got $tables $drops in ns $ns," \
                              "not 0 - not all expected packets marked"
            ret=${KSFT_FAIL}

On an nftables build without libjansson, nft -V still exits 0 and just
reports json: no. add_mark_rules() works, because it only uses nft -f.

nft -j then fails with "JSON support not compiled-in", so drops is empty.
The test then reports "not all expected packets marked" and sets
KSFT_FAIL. Should a missing userspace feature give a skip here instead?

The later patch in the series, "selftests: mptcp: convert iptables to
nftables for mptcp_join.sh", keeps the same "nft" | "jq" case with the -V
probe. So it looks like this is still present at the end of the series.

Would a separate nft check match the real dependency better? For example,
nft --version plus a JSON check such as nft -j list ruleset.

>  				mptcp_lib_pr_skip "Could not run all tests without ${tool}"
>  				exit ${KSFT_SKIP}
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> index e850a87429b61..b4e3eddc9cf21 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh

[ ... ]

> @@ -49,16 +47,27 @@ add_mark_rules()
>  	local ns=$1
>  	local m=$2
>  
> -	local t
> -	for t in ${iptables} ${ip6tables}; do
> -		# just to debug: check we have multiple subflows connection requests
> -		ip netns exec $ns $t -A OUTPUT -p tcp --syn -m mark --mark $m -j ACCEPT
> -
> -		# RST packets might be handled by a internal dummy socket
> -		ip netns exec $ns $t -A OUTPUT -p tcp --tcp-flags RST RST -m mark --mark 0 -j ACCEPT
> -
> -		ip netns exec $ns $t -A OUTPUT -p tcp -m mark --mark $m -j ACCEPT
> -		ip netns exec $ns $t -A OUTPUT -p tcp -m mark --mark 0 -j DROP
> +	local table
> +	for table in ip ip6; do
> +		ip netns exec "$ns" nft -f - <<-EOF
> +			add table $table filter
> +			add chain $table filter OUTPUT \
> +				{ type filter hook output priority 0; policy accept; }
> +
> +			# just to debug: check we have multiple subflows connection requests
> +			add rule $table filter OUTPUT \
> +				tcp flags & (fin | syn | rst | ack) == syn \
> +				meta mark $m accept

[Severity: Low]
This isn't a bug, but is this comment still accurate after the conversion?

With iptables every rule had implicit counters, so iptables -v -L could
show how many subflow SYNs were sent. In nftables a rule only counts
packets if it has an explicit counter statement, and this rule has none.

Every packet this rule matches is also accepted by the later "meta
l4proto tcp meta mark $m accept" rule, so the rule now does nothing.

The commit message says:

  "Counters are not added to accept rules because the test does not
  inspect them."

However, this rule was meant for manual debugging rather than for the test
itself. Should it get a counter, or should the rule and its comment be
removed?

> +
> +			# RST packets might be handled by a internal dummy socket
> +			add rule $table filter OUTPUT \
> +				tcp flags & rst == rst meta mark 0x0 accept

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260926-net-next-mptcp-misc-feat-7-4-v1-0-67af4ab37406%40kernel.org
