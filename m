Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2286534EF07;
	Wed, 14 Oct 2026 20:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792011411; cv=none; b=F1BR1k1J5WOv1YzWycg7ru1uN9s+8Ez/GaIY/6oq8Ip9ptITplNe8Oss+Hhd1/M/Wzsz0PJzu7OPNMFKnU2Rm+/dFHP2xZRWthX8mlLuSteMhWX/HszcNsR3uEWmGenCANUwBE1tZZSd9X5GQw4OX28sP2ZrTxQ5mh5vc/tJAcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792011411; c=relaxed/simple;
	bh=KDOUJs0C3uYitpaFWMJOypNbAlgV3q5tkqutP2G8roo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lIJM17yPPtKN6WVQbu45ObNNZBiHBaT6xkUyuuUUgw1mixhAwOjR1S2yL/1lKlBKogAqpSAaFUQaNLaQn67MStrgaMt6i2OTaO4ExepiNETiuipPx9ktPie5g19OIacrq0D+0YUpuOYPUUkzqceD1U2aWeBFjTZJG8daAfxcQfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/h1eecC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/h1eecC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8BF1F000C4;
	Wed, 14 Oct 2026 20:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792011409;
	bh=9iR4CHLMGZ4aDi692nqAlwhqkY/qmfz7HVjcsaRcdM0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=K/h1eecCBXuvC4BXFKFa6jCsLZW+LYl//n+sdLGytWj3rxut7nECfCUjC7x3f6cHg
	 gdn2h2WY05ux6cFRxQHRtDMrci2417utQXAqy7xCxV0QSMzEeMrFFMVagcJc2vq87u
	 I3x9DG3mWsGZnKPw1aFEpbI2ZUuqTZUYLjqtBDNsmy6h2kfcGI8qGsVsuJKCufuLWY
	 cJgasS6IdSkYYrjVZ/cfUyBff8sFgA7V2Y+AEXGflobU/m/fHp737RK+BafzTNdJip
	 tnKo6QICRv37sgsHHsN0mcvjkgz3A5KbqbqYdeEl/FmXzIZRxcBo6OHnVWuHy67Fy2
	 thj2SW31pOzyg==
Subject: Re: [PATCH net-next 3/4] selftests: mptcp: convert iptables to
 nftables for mptcp_sockopt.sh
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 cpaasch@openai.com, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, liuhangbin@kylinos.cn, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
Date: Wed, 14 Oct 2026 20:56:48 +0000
Message-ID: <179201140828.434549.10971881913720826839@kernel.org>
In-Reply-To:
 <20261013-net-next-mptcp-misc-feat-7-4-part2-v1-3-1181e5d2fda4@kernel.org>
References:
 <20261013-net-next-mptcp-misc-feat-7-4-part2-v1-3-1181e5d2fda4@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message does not mention two new runtime requirements
  added by this patch.

--

selftests: mptcp: convert iptables to nftables for mptcp_sockopt.sh

This patch moves the mark rules in mptcp_sockopt.sh from iptables/ip6tables
to nftables and keeps the same table and chain names. check_mark() now reads
the drop counter from nft JSON output and parses it with jq.
mptcp_lib_check_tools() gets new checks for nft and jq.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> index b9d14647f4019..20853d0198ffc 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
> @@ -528,7 +528,14 @@ mptcp_lib_check_tools() {
>  				exit ${KSFT_SKIP}
>  			fi
>  			;;
> -		"iptables"* | "ip6tables"*)
> +		"nft")
> +			if ! nft --version &> /dev/null || \
> +			   ! nft -j list ruleset &> /dev/null; then
> +				mptcp_lib_pr_skip "Could not run all tests without nft -j"
> +				exit ${KSFT_SKIP}
> +			fi
> +			;;
> +		"iptables"* | "ip6tables"* | "jq")
>  			if ! "${tool}" -V &> /dev/null; then
>  				mptcp_lib_pr_skip "Could not run all tests without ${tool}"
>  				exit ${KSFT_SKIP}
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> index e850a87429b61..ef2738720e249 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh

[ ... ]

> @@ -105,32 +109,31 @@ cleanup()
>  
>  mptcp_lib_check_mptcp
>  mptcp_lib_check_kallsyms
> -mptcp_lib_check_tools ip "${iptables}" "${ip6tables}"
> +mptcp_lib_check_tools ip nft jq

[Severity: Low]
This isn't a bug, but should the commit message list the new runtime
requirements? The script now needs jq and an nft built with JSON support
(nft -j list ruleset). The shared mptcp_lib_check_tools() helper in
mptcp_lib.sh also gets new "nft" and "jq" cases.

The commit message only says:

    After conversion, the generated output matches the original
    iptables/ip6tables behavior.

The reason for using JSON and jq appears only in the v2 notes below the
--- line, and those notes are dropped when the patch is applied.

This check runs at top level, before any subtest. So a system that has
iptables but no jq, or an nft without JSON support, now skips the whole
script. That includes do_mptcp_sockopt_tests and do_tcpinq_tests, which
don't use netfilter.

Could the commit message mention the jq and nft JSON dependencies and the
mptcp_lib.sh change?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261013-net-next-mptcp-misc-feat-7-4-part2-v1-0-1181e5d2fda4%40kernel.org
