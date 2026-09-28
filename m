Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD22463B66;
	Mon, 28 Sep 2026 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582427; cv=none; b=QsjHU+JBEOKxfeAj60yXmXwgUFuUWOMmG0fTchKZ/R2ofU+w8HIF6WZ49Xx+uGSynIjXrQdqUx7gfmKdcwII2R16DPc+oBT/aRv8NRYKISMpBllj/AGUEs/QMHpq+zerE6QCC1yrDNEoodFuA5M2XNJzMyD7+oVVIY55OAUE4CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582427; c=relaxed/simple;
	bh=az3bMfr5G5sT3btF+qpknqCJ/1kpF4BiKYvJoy0muHg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I+nsfyb5E7FFOnkmPTPgvYZjCpRFqLmygLY59eScDFfW4aoEhccA7mwT1nMdPqTDFqnuDe0ycjCmD0MFbnOpF+TN4GKYLFbX3DZERx1Be1rJ5vZj4rQpIcZKx8UVOWFUXVd3H0h9lt4cmFksc1gbknCiAw69q1PC5xcMQyFvApg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbvV1mvC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbvV1mvC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA731F00893;
	Mon, 28 Sep 2026 08:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790582425;
	bh=j74msU6MmZ0h9fJHwbp7sZYGlIw0sWzkQW5TCKFT3rg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AbvV1mvCinLB3oAXFO88qRAAG1khO6xtWzD992O/6SxQ4SdCAGSBhYc/Ya+dqpeN9
	 h6B3TzkAHd0pClYk356zbMa3TlcWngKn37z5BINZMWDVYNg1M5QmxeNX5fUge2lyxA
	 KHlb/qWXxOXyeXkkMUDzie5DymjhidcKSJpMe1jKfwiIM+HpylEDSAJYZv2h4r4Qpw
	 1aVVYaGX6xaEWAHtuABU0RW4ZLqMBTNRAFvC5591C9tP4xPD1VBiy1q9Nax9QRypoT
	 3TAQKdkBkG4UM/dER8+Zxvjk44993ZqD5JLCEcS4o/v/aeoqv6llZQ8b5hNDPHodPw
	 cQVnj8YLBQBbQ==
Subject: Re: [PATCH net-next 5/5] selftests: mptcp: convert iptables to
 nftables for mptcp_join.sh
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 quanyeyang@proton.me
Date: Mon, 28 Sep 2026 08:00:24 +0000
Message-ID: <179058242453.3145.1450534124183352369@kernel.org>
In-Reply-To:
 <20260926-net-next-mptcp-misc-feat-7-4-v1-5-67af4ab37406@kernel.org>
References:
 <20260926-net-next-mptcp-misc-feat-7-4-v1-5-67af4ab37406@kernel.org>
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

- [Medium] In endpoint_tests()
  (tools/testing/selftests/net/mptcp/mptcp_join.sh), the new rule `tcp…
- [Low] The patch removes CONFIG_NFT_COMPAT from
  tools/testing/selftests/net/mptcp/config, "since we don't need it now".

--

selftests: mptcp: convert iptables to nftables for mptcp_join.sh

This converts the iptables/ip6tables rules in mptcp_join.sh to nftables.
It keeps the same table and chain names and adds init_nftables() to set
up the tables only when a test needs them. The cBPF bytecode that matched
the ADD_ADDR and RM_ADDR suboptions is replaced with "tcp option mptcp
subtype" matching. In the config fragment, CONFIG_NFT_COMPAT is swapped
for the nft modules that are now needed.

> diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
> index bb9c4c97c6206..61057a0667192 100644
> --- a/tools/testing/selftests/net/mptcp/config
> +++ b/tools/testing/selftests/net/mptcp/config
> @@ -29,7 +29,9 @@ CONFIG_NET_SCH_INGRESS=m
>  CONFIG_NET_SCH_NETEM=m
>  CONFIG_NF_TABLES=m
>  CONFIG_NF_TABLES_INET=y
> -CONFIG_NFT_COMPAT=m
> +CONFIG_NFT_NUMGEN=m
> +CONFIG_NFT_REJECT=m
> +CONFIG_NFT_REJECT_INET=m

[Severity: Low]
This isn't a bug, but CONFIG_NFT_COMPAT is removed here "since we don't
need it now". Should the other xtables-only options in this fragment be
removed too?

After this patch the config still has:

CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_NETFILTER_XTABLES=m
CONFIG_NETFILTER_XTABLES_LEGACY=y
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_TARGET_MARK=m

Only the removed -m bpf, -m length, -m statistic, -j MARK and REJECT
rules needed these. Nothing under tools/testing/selftests/net/mptcp/
uses iptables or ip6tables anymore.

>  CONFIG_NFT_SOCKET=m
>  CONFIG_NFT_TPROXY=m
>  CONFIG_SYN_COOKIES=y
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 18ce7136a2b0e..b16e24418e737 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

[ ... ]

> @@ -4402,12 +4372,10 @@ endpoint_tests()
>  
>  		# To make sure RM_ADDR are sent over a different subflow, but
>  		# allow the rest to quickly and cleanly close the subflow
> -		local ipt=1
> -		ip netns exec "${ns2}" ${iptables} -I OUTPUT -s "10.0.1.2" \
> -			-p tcp -m tcp --tcp-option 30 \
> -			-m bpf --bytecode \
> -			"$CBPF_MPTCP_SUBOPTION_RM_ADDR" \
> -			-j DROP || ipt=0
> +		local nft=1
> +		ip netns exec "${ns2}" nft insert rule ip filter OUTPUT \
> +			ip saddr 10.0.1.2 meta l4proto tcp \
> +			tcp option mptcp subtype remove-addr drop || nft=0

[Severity: Medium]
Can this rule ever match an RM_ADDR packet on an established connection?

nft_exthdr_tcp_eval() stops at the first TCP option whose kind matches
(30 for MPTCP). The subtype check therefore only ever sees the first
MPTCP suboption:

net/netfilter/nft_exthdr.c:nft_exthdr_tcp_eval() {
    ...
	for (i = sizeof(*tcph); i < tcphdr_len - 1; i += optl) {
		optl = optlen(opt, i);

		if (priv->type != opt[i])
			continue;
		...
		return;
	}
    ...
}

Once can_ack is set, mptcp_established_options_dss() always selects a
DSS ack:

net/mptcp/options.c:mptcp_established_options_dss() {
    ...
	opts->ext_copy.use_ack = 1;
	opts->suboptions = OPTION_MPTCP_DSS;
    ...
}

mptcp_established_options_rm_addr() then ORs OPTION_MPTCP_RM_ADDR into
suboptions, so the DSS is kept. mptcp_write_options() writes the DSS
first and writes RM_ADDR later, after the mp_capable_done label:

net/mptcp/options.c:mptcp_write_options() {
    ...
	if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
    ...
mp_capable_done:
	if (OPTION_MPTCP_RM_ADDR & opts->suboptions) {
    ...
}

On these packets the first kind 30 option is the DSS (subtype 0x2), so
wouldn't "subtype remove-addr" (0x4) always fail to match?

The removed CBPF_MPTCP_SUBOPTION_RM_ADDR bytecode was written for this
layout. Its comment said "a first suboption of 12B (DACK8), the RM_ADDR
suboption". It checked ip[53] == 0x0c for the length of the first
suboption and (ip[66] & 0xf0) == 0x40 for the subtype of the second one.

The same problem affects the ns1 rule on 10.0.1.1 later in
endpoint_tests(), which is installed right before
"pm_nl_del_endpoint $ns1 42 10.0.1.1".

In both places the rule installs without error, so the "|| nft=0"
fallback never triggers. The tests keep passing, but RM_ADDR is no
longer forced onto a different subflow.

The commit message says the bytecode "is replaced with native nft
matching using "tcp option mptcp subtype"". That is true for ADD_ADDR,
because mptcp_write_options() emits ADD_ADDR in an else-if branch with
the DSS. Is it also true for RM_ADDR?

Would a raw payload match on the second MPTCP option (for example with
@th,...) be needed here instead?

>  		local i
>  		for i in $(seq 3); do
>  			pm_nl_del_endpoint $ns2 1 10.0.1.2

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260926-net-next-mptcp-misc-feat-7-4-v1-0-67af4ab37406%40kernel.org
