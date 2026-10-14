Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE6E41DDF0;
	Wed, 14 Oct 2026 20:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792011412; cv=none; b=u1EnURHPknJ4plp+6B3iwy2jCFK6iA1qYTMQHO6pEkkCjXxMPTgdl8DXZtyrrNrbNqle+6sXg/+cG9X4dsEu9PbOrIG/9hoL0yga5VzRuDx7prGc64iKRoXyt+oKTEmV0r1W1lpFMsDTZu3Jcgkk8NRYn5S6sI9GyAu0jq83lso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792011412; c=relaxed/simple;
	bh=6hqYPJ6/xAsJgWntVG80XsH3EXmRejAXLJ/fskhKgjg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XmTt/uUnXP/T/ElcCZOsKErm+8wgFyctHoJnxf5b9koqdtgicj3Wd/ACN2NPwYhV++D1HHZypAYiGMfVSuYeA849Ze+/Dq8C0vXdZ+NHgaE1dVusmxhbcXWUqXLfy5ZE+BCjCjBjVHoy35sg8jPeNQxFqaW96N02RPIrO5HYcNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmJY9Oz5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmJY9Oz5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7A71F000C5;
	Wed, 14 Oct 2026 20:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792011411;
	bh=oYmMLeNpHr3M9c+dYZAHyUCaqhInsdxFPD8shQdQogo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LmJY9Oz55ES4iMAozXDfVZ0E4Yq1MWHh5o0VGSVY7MxD6P7QVFtJwQn1x0ng1ZJPr
	 Gv+okYHtdQEt2UseP9heBww39iurITYhiu7kl70ZLgaY7VlJqGjHMc0O7J3titBgef
	 HSNTTZCTSlGRVeHNskfHr6mya6eS+51vhBXFBwCEDihQMfGf4nF+gc9oIRsGJENsYv
	 EXRPdxOvV+WPxKp4HNCvcVlGh+6QlxuBah47aWj2lG6Zt28/e9TWtuIXfwry1uEt9P
	 yRkhAPaBZ8+WXW8nZLbt+4Z9xao1ZnS+JULNNol3vCMZKp2k6c8M0yCo581VEozB6r
	 sdXlftxFyfL5g==
Subject: Re: [PATCH net-next 4/4] selftests: mptcp: convert iptables to
 nftables for mptcp_join.sh
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 cpaasch@openai.com, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, liuhangbin@kylinos.cn, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
Date: Wed, 14 Oct 2026 20:56:49 +0000
Message-ID: <179201140983.434549.4591346402914779226@kernel.org>
In-Reply-To:
 <20261013-net-next-mptcp-misc-feat-7-4-part2-v1-4-1181e5d2fda4@kernel.org>
References:
 <20261013-net-next-mptcp-misc-feat-7-4-part2-v1-4-1181e5d2fda4@kernel.org>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] mptcp_join.sh init() now calls `mptcp_lib_check_tools ip tc ss
  nft` (mptcp_join.sh:192).

--

selftests: mptcp: convert iptables to nftables for mptcp_join.sh

This converts the iptables/ip6tables rules in mptcp_join.sh to nftables.
The cBPF bytecode matches are replaced with native nft matching, and
hard-coded offsets are used for RM_ADDR. The config file is updated to
match, and the iptables/ip6tables tool check is removed from
mptcp_lib.sh.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index 18ce7136a2b0e..f4d8afaeda4f3 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh

[ ... ]

> @@ -196,7 +189,7 @@ init() {
>  
>  	mptcp_lib_check_mptcp
>  	mptcp_lib_check_kallsyms
> -	mptcp_lib_check_tools ip tc ss "${iptables}" "${ip6tables}"
> +	mptcp_lib_check_tools ip tc ss nft

[Severity: Medium]
Will this skip the whole mptcp_join.sh suite when nft has no JSON
support?

The shared "nft" case in mptcp_lib_check_tools() in mptcp_lib.sh also
requires JSON output:

tools/testing/selftests/net/mptcp/mptcp_lib.sh:mptcp_lib_check_tools() {
    ...
		"nft")
			if ! nft --version &> /dev/null || \
			   ! nft -j list ruleset &> /dev/null; then
				mptcp_lib_pr_skip "Could not run all tests without nft -j"
				exit ${KSFT_SKIP}
			fi
			;;
    ...
}

As far as I can tell, that JSON requirement is there for
mptcp_sockopt.sh, which pipes "nft -j list table ... filter" into jq.

mptcp_join.sh never uses JSON output. It only runs "nft -f -" from
init_nftables(), plus "nft add rule", "nft insert rule" and "nft flush
chain".

If nft was built without JSON support, init() would exit with
KSFT_SKIP. Every join, PM, endpoint and userspace subtest would then be
skipped, including the many that do not use nft at all. The skip
message would also point at "nft -j", which this script does not need.

Before this patch, mptcp_join.sh only checked for iptables/ip6tables, so
nft JSON support did not matter here.

Would it make sense to check only for plain nft in mptcp_join.sh, for
example with a separate non-JSON case in mptcp_lib_check_tools()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013-net-next-mptcp-misc-feat-7-4-part2-v1-0-1181e5d2fda4%40kernel.org
