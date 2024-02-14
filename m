Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3DD171A2
	for <mptcp@lists.linux.dev>; Wed, 14 Feb 2024 19:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937781; cv=none; b=LxHrsfah16uQCuppABcfEaaD228GudKqLq72exz15Qu4FFw4YE7X1dr4UVQ9k1x5GAq/NiQ5pKeDN1SEbHRKvJT5YJ5IV5+w+MET3DyscEeAUSuUUNk+i/Dx8WtuvVMPWC14dSmIQnXJ+Gzc+nPvO6s9xsfwoXt42QHz1sOsz5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937781; c=relaxed/simple;
	bh=da95XTl7Ju5XNjXeQUi6X+Xq/uJ22o9F1mfto1ekm8Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ehO4Xt5gjPTijkSRkP9HsaF1t/slj11vUMvDvoWXbKctBF2GDRXdjSVQsrry37N5dy72zx5WOd06KLN/3JSBDgjUZ4ZhnC7qWkakuGYPQPz6hGCsuAGov9Oy4x9TcPFp1Tsfr7T4aaYVg1/S2XAcSn+8GQ8pbpAsskiQGbTONLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6Zd5Rah; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6Zd5Rah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E45C433F1;
	Wed, 14 Feb 2024 19:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707937780;
	bh=da95XTl7Ju5XNjXeQUi6X+Xq/uJ22o9F1mfto1ekm8Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=u6Zd5Rah7e7ofwHy39WV6VhrbdplGwvLcRfMptt38DB+o4JKRBGFsSyGYOUclmd79
	 QsKEFPP0+clylu4KJBgNQUIsgH7LMW9iOO+N7UKAHuMk+kmNnbiUGvK/In1ientH1n
	 JdsvXDxR4CW3+V5bZ8wBZda2VDVW6XOptiQsDt+i3hgDhP9XDqrPO7lGDbri2x99ZK
	 BEWnzIohJt+umAMuXGImJ0DwphcDnWIb/1ftLv6cJlAsbMc1E3KKeUXNXTQHNUFkWp
	 4t06sjJsWaQoPB4C86/n3UigQyAa5S5v1omfLLQbKF9Sxq65KZPMI3crHOvK0ttnJY
	 E5s71pnxJPnRg==
Date: Wed, 14 Feb 2024 11:09:40 -0800 (PST)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] selftests: mptcp: stop forcing
 iptables-legacy
In-Reply-To: <20240207-selftests-mptcp-iptables-nft-v1-1-108de489316e@kernel.org>
Message-ID: <513aac1d-35e2-6505-5cf9-b2920fe0e361@kernel.org>
References: <20240207-selftests-mptcp-iptables-nft-v1-1-108de489316e@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 7 Feb 2024, Matthieu Baerts (NGI0) wrote:

> Commit 0c4cd3f86a40 ("selftests: mptcp: join: use 'iptables-legacy' if
> available") and a5a5990c099d ("selftests: mptcp: sockopt: use

Hi Matthieu -

You can add the word "commit" right before "a5a5990c099d" in the commit 
message and that will satisfy checkpatch. Fine to do that when applying 
this to the topgit tree, everything else LGTM:

Reviewed-by: Mat Martineau <martineau@kernel.org>


> 'iptables-legacy' if available") forced using iptables-legacy if
> available.
>
> This was needed because of some issues that were visible when testing
> the kselftests on a v5.15.x with iptables-nft as default backend. It
> looks like these errors are no longer present. As mentioned by Pablo [1],
> the errors were maybe due to missing kernel config. We can then use
> iptables-nft if it is the default one, instead of using a legacy tool.
>
> We can then check the variables iptables and ip6tables are valid. We can
> keep the variables to easily change it later or add options.
>
> Link: https://lore.kernel.org/netdev/ZbFiixyMFpQnxzCH@calendula/ [1]
> Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> tools/testing/selftests/net/mptcp/mptcp_join.sh    | 12 ++++--------
> tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 12 ++++--------
> 2 files changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> index c07386e21e0a..20140ee4de2e 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
> @@ -161,15 +161,11 @@ check_tools()
> 		exit $ksft_skip
> 	fi
>
> -	# Use the legacy version if available to support old kernel versions
> -	if iptables-legacy -V &> /dev/null; then
> -		iptables="iptables-legacy"
> -		ip6tables="ip6tables-legacy"
> -	elif ! iptables -V &> /dev/null; then
> -		echo "SKIP: Could not run all tests without iptables tool"
> +	if ! "${iptables}" -V &> /dev/null; then
> +		echo "SKIP: Could not run all tests without ${iptables} tool"
> 		exit $ksft_skip
> -	elif ! ip6tables -V &> /dev/null; then
> -		echo "SKIP: Could not run all tests without ip6tables tool"
> +	elif ! "${ip6tables}" -V &> /dev/null; then
> +		echo "SKIP: Could not run all tests without ${ip6tables} tool"
> 		exit $ksft_skip
> 	fi
> }
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> index c643872ddf47..dac8e1fc7143 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> @@ -96,15 +96,11 @@ if [ $? -ne 0 ];then
> 	exit $ksft_skip
> fi
>
> -# Use the legacy version if available to support old kernel versions
> -if iptables-legacy -V &> /dev/null; then
> -	iptables="iptables-legacy"
> -	ip6tables="ip6tables-legacy"
> -elif ! iptables -V &> /dev/null; then
> -	echo "SKIP: Could not run all tests without iptables tool"
> +if ! "${iptables}" -V &> /dev/null; then
> +	echo "SKIP: Could not run all tests without ${iptables} tool"
> 	exit $ksft_skip
> -elif ! ip6tables -V &> /dev/null; then
> -	echo "SKIP: Could not run all tests without ip6tables tool"
> +elif ! "${ip6tables}" -V &> /dev/null; then
> +	echo "SKIP: Could not run all tests without ${ip6tables} tool"
> 	exit $ksft_skip
> fi
>
>
> ---
> base-commit: c2469b38e369c3f2b9577beeb9470cc757abc1b9
> change-id: 20240207-selftests-mptcp-iptables-nft-2bfd4a4cfb81
>
> Best regards,
> -- 
> Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
>
>
