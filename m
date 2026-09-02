Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9B33BB669;
	Wed,  2 Sep 2026 07:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332554; cv=none; b=fT9Wznr3Nyhz+acF5GkegvoJtohX308IVem72Bq1g0n+n1K295MlLvZacU7gD2SfY7llCb0PE0E2lZvk95csLj8qLhNG1+SRz+vZYI3DDwog37nTL7t43nSN+43+5T76xusl06aK4It33WSY4wHxBPXL7xTipXWWx1+wqCbM2N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332554; c=relaxed/simple;
	bh=bLE/NMQ+GjLSdimzfiXusGyJdbaLYy2NuH8+gnU22vw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kLGk8uk/W2TearOQsy8S9Hbdlu8ghU8A4zigRNbyDfSXonGHhLW2z+V+8yVj2HMZHvzLrTTIZI5FUvwp0dThLyh8fmNeH55OOcdwRIJIGvNyMZ16BeYIonk8osL/Luqk8orl6YbPqMrkMWAMQDJFZif9V8jKQFj17a8HLM6pXiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqsJsIIa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqsJsIIa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4851F000E9;
	Wed,  2 Sep 2026 07:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788332552;
	bh=KI8KRWZe1A7+OEsjyc7wh5M8d0WkG2au2+MpQE5DFF0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VqsJsIIaBXVed2cjgbHI7vEOJdZIprkf0Eovk8KtCv3BiWb0StPBYOAtSVzu5hc/d
	 oQhua+1SZir4MWld0Le+evCmq92+R6F7jj1OKEf1PJ4K15B6lLD5dVAyXabwLUM5tJ
	 G5Tc2BhDx4+pkFNy/hI4G/i+3XCY7Q88Vdrrc+dwodyprPE0N1aNh64YPBHjgjE4LN
	 qaROI6kbJPXHyHemC790S4sVotBxggrPo7IZ+K4s6Dl3yMYpf6Ffh1/UUgmFR8tOBQ
	 Hr/0z8sJmnpaArDnL3+VwC22KYu38CamaJjQNL5zCMInJIjok4WOY03WrqpNbtZtDr
	 4dJmVdC0ZaBZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next 1/2] selftests: mptcp: convert iptables to
 nftables for mptcp_sockopt.sh
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hangbin Liu" <hangbin.liu@linux.dev>
Cc: bpf@vger.kernel.org, mptcp@lists.linux.dev
In-Reply-To: <20260902-mptcp_nft-v1-1-559caa16f410@kylinos.cn>
References: <20260902-mptcp_nft-v1-0-559caa16f410@kylinos.cn>
 <20260902-mptcp_nft-v1-1-559caa16f410@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 07:02:31 +0000
Message-Id: <20260902070232.4F4851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Replacing iptables TCP flag matching with nftables exact matchin=
g (`tcp flags rst` and `tcp flags syn`) fails to match packets with multipl=
e flags set, causing spurious test failures.
- [Medium] An empty `$drop` variable causes a Bash syntax error during nume=
ric evaluation, which evaluates to false and silently masks test failures.
- [Low] Typo in string interpolation for the error message (`IPv{$af}` inst=
ead of `IPv${af}`).
--

commit af165781f3fb777bc40bc4de19c7d79cd01f51cc
Author: Hangbin Liu <liuhangbin@kylinos.cn>

selftests: mptcp: convert iptables to nftables for mptcp_sockopt.sh

This patch converts the mptcp_sockopt.sh selftest to use nftables instead of
iptables. It replaces per-address-family iptables mark rules with an inet
table containing drop counting rules for IPv4 and IPv6.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/t=
esting/selftests/net/mptcp/mptcp_sockopt.sh
> index e850a87429b61..4d0af2bf94840 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh

[ ... ]

> @@ -49,17 +47,23 @@ add_mark_rules()
>  	local ns=3D$1
>  	local m=3D$2
> =20
> -	local t
> -	for t in ${iptables} ${ip6tables}; do
> -		# just to debug: check we have multiple subflows connection requests
> -		ip netns exec $ns $t -A OUTPUT -p tcp --syn -m mark --mark $m -j ACCEPT
> -
> -		# RST packets might be handled by a internal dummy socket
> -		ip netns exec $ns $t -A OUTPUT -p tcp --tcp-flags RST RST -m mark --ma=
rk 0 -j ACCEPT

[ ... ]

> +	# just to debug: check we have multiple subflows connection requests
> +	ip netns exec "$ns" nft add rule inet msock_table output \
> +		 meta mark "$m" tcp flags syn accept
> +	# RST packets might be handled by a internal dummy socket
> +	ip netns exec "$ns" nft add rule inet msock_table output \
> +		meta mark 0 tcp flags rst accept

[Severity: Medium]
In add_mark_rules(), the original iptables rules --tcp-flags RST RST and
--syn used bitmasks to allow additional flags like ACK for RST or ECN for
SYN. The new nftables rules tcp flags rst and tcp flags syn enforce an
exact match on the entire TCP flags byte.

Will these exact matches reject packets with multiple flags set, such as
RST+ACK or SYN+ECN, causing them to fall through to the drop rule and fail =
the
test?

[ ... ]

> @@ -105,33 +109,23 @@ cleanup()
> =20
>  mptcp_lib_check_mptcp
>  mptcp_lib_check_kallsyms
> -mptcp_lib_check_tools ip "${iptables}" "${ip6tables}"
> +mptcp_lib_check_tools ip nft
> =20
>  check_mark()
>  {
>  	local ns=3D$1
>  	local af=3D$2
> =20
> -	local tables=3D${iptables}
> +	drop=3D$(ip netns exec "$ns" nft list table inet msock_table | \
> +		grep "ipv$af.*packets.*drop" | awk '{print $(NF-3)}')
> =20
> -	if [ $af -eq 6 ];then
> -		tables=3D${ip6tables}
> +	if [ "$drop" -ne 0 ]; then

[Severity: Medium]
If the command extraction for drop fails, or if grep finds no matches,
the $drop variable will be empty.

When bash evaluates [ "$drop" -ne 0 ] with an empty string, it triggers a
syntax error. This error evaluates to false and skips the failure block.

Does this risk silently masking test failures if the extraction logic ever
fails to produce a number?

> +		mptcp_lib_pr_fail "got $drop pkt drops in ns $ns IPv{$af} tables," \

[Severity: Low]
Is the string interpolation IPv{$af} a typo?

Bash interpolates the $af variable but leaves the literal braces, printing
IPv{4} instead of IPv4. Should this be IPv${af} or IPv$af instead?

> +				  "not 0 - not all expected packets marked"
> +		ret=3D${KSFT_FAIL}
> +		return 1
>  	fi

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902-mptcp_nft-=
v1-0-559caa16f410@kylinos.cn?part=3D1
