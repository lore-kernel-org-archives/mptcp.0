Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACF31F875A;
	Thu,  3 Sep 2026 01:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788398353; cv=none; b=TeXuyKgviXGVzMV2pu8Fu64wp5W1zF7GmrIsnlmDBO/2CZ5jdE3r3nzJXX76L3N/c6q7rJCRMHxhS6JVY7PduDji1f4keUJlpvfWzHCUDIL0mVfjoqEaW/7WbXlp60aC8cJXUmMJ98Rvao5lFuGirL0ntjCgDVHGqvPHjtmjWDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788398353; c=relaxed/simple;
	bh=3Kue941zqBNWV1RXYcfXE7gyM+uvxiEgZ8INhXjF49A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hzxQGkZaMctOuzIxD+p85bTKp/7pQea9tIpDw9rBVaqROYPwB7w6yU4N5KnHzUhHFAxpWIkHRck7KhRHpJT5imdxVfuYFkHRKIaGZNdFm0r67xd6yGNBs2WtnBu4ewVF525uUHA9gjsAyjSVaEcfI7+HLhQFxdHobRrvAHEficw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A2Zs0GtU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A2Zs0GtU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2E61F000E9;
	Thu,  3 Sep 2026 01:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788398352;
	bh=7RuKVxgbwsSHIL7qGiLi65fLP/i76v6V8IQiW5C26lM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A2Zs0GtU7+vyXEI9V54jHguw6AzuxxZUhPOUfYDmvTa1Y22AfjiAPelHFfqBIRrvd
	 xh6cIFt4XctL5KsLULmEQU6FJH0i4toCoqQ42qaoSObmAMMVzy6+JKfvnqjuBR53Sg
	 4bYQhRdpke7MGKaun5DOo+AwXnJ1LyJNMo18zRt3jSmWlhLr1fjX68R2hvdSlutSxn
	 YK2zHBVbHuRR9iHoHPDYaTCr4HaoA5qGsP7Ylpg0SnmnfblvxWnrKVCUp6jOW6UD9O
	 Q2ZT+rGMAwHPbt0rz5KdBYcNo8SdO/TbiTUstVJCJgcZV8jkWzyKMDAEOwNVgWkua8
	 Ok4IZoCvE7KIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v2 1/2] selftests: mptcp: convert iptables to
 nftables for mptcp_sockopt.sh
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hangbin Liu" <hangbin.liu@linux.dev>
Cc: mptcp@lists.linux.dev, bpf@vger.kernel.org
In-Reply-To: <20260903-mptcp_nft-v2-1-66283e4b9c3b@kylinos.cn>
References: <20260903-mptcp_nft-v2-0-66283e4b9c3b@kylinos.cn>
 <20260903-mptcp_nft-v2-1-66283e4b9c3b@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 01:19:11 +0000
Message-Id: <20260903011911.EC2E61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The debug rule for SYN packets lacks a counter in the nftables c=
onversion, rendering it completely dead code and defeating its stated purpo=
se.
--

commit 10b242a411677a92a0a291c8ae35773ac1ef8e56
Author: Hangbin Liu <liuhangbin@kylinos.cn>

selftests: mptcp: convert iptables to nftables for mptcp_sockopt.sh
   =20
During the conversion, we retain the same filter and chain names previously
used by iptables/ip6tables. Counters are not added to accept rules because
the test does not inspect them. After conversion, the generated output
matches the original iptables/ip6tables behavior.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/t=
esting/selftests/net/mptcp/mptcp_sockopt.sh
> index e850a87429b61..a2c20483986dc 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> @@ -50,15 +48,25 @@ add_mark_rules()
>  	local m=3D$2
> =20
>  	local t
> -	for t in ${iptables} ${ip6tables}; do
> +	for t in ip ip6; do
> +		ip netns exec "$ns" nft add table "$t" filter
> +		ip netns exec "$ns" nft add chain "$t" filter OUTPUT \
> +			'{ type filter hook output priority 0; policy accept; }'
> +
>  		# just to debug: check we have multiple subflows connection requests
> -		ip netns exec $ns $t -A OUTPUT -p tcp --syn -m mark --mark $m -j ACCEPT
> +		ip netns exec "$ns" nft add rule "$t" filter OUTPUT \
> +			tcp flags \& \(fin \| syn \| rst \| ack\) =3D=3D syn \
> +			meta mark "$m" accept

[Severity: Medium]
Since this rule doesn't have a counter statement, does it become entirely
dead code?

Because the SYN packets it matches are accepted anyway by the broader rule
below (`meta l4proto tcp meta mark "$m" accept`), omitting the counter seems
to eliminate the debugging capability mentioned in the comment. Should a
counter be included here so the rule can still provide packet counts for
manual inspection?

> =20
>  		# RST packets might be handled by a internal dummy socket
> -		ip netns exec $ns $t -A OUTPUT -p tcp --tcp-flags RST RST -m mark --ma=
rk 0 -j ACCEPT
> +		ip netns exec "$ns" nft add rule "$t" filter OUTPUT \
> +			tcp flags \& rst =3D=3D rst meta mark 0x0 accept
> +
> +		ip netns exec "$ns" nft add rule "$t" filter OUTPUT \
> +			meta l4proto tcp meta mark "$m" accept
> +		ip netns exec "$ns" nft add rule "$t" filter OUTPUT \
> +			meta l4proto tcp meta mark 0 counter drop
> =20
> -		ip netns exec $ns $t -A OUTPUT -p tcp -m mark --mark $m -j ACCEPT
> -		ip netns exec $ns $t -A OUTPUT -p tcp -m mark --mark 0 -j DROP
>  	done
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903-mptcp_nft-=
v2-0-66283e4b9c3b@kylinos.cn?part=3D1
