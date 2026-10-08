Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA103793DC
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791458383; cv=none; b=Pa8VcLnhUTmXODUUXM2ZpHdyhTiWEWWiBPaxl85JrHDvs4LDamBVQrnY6PfIIReqhCQIL0LEiz9crDBa5+8O07/co3IwrWwkQw5iDpAt7OnLOxIoqRy+H7sE4OspIzCGXpEbZ0lwoGecOlhOaWRThT02tt2JyaDgomZlLdw63ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791458383; c=relaxed/simple;
	bh=6tZ/Z7lyZWhf+p05ZFgBj1DUO81s+i2D7Hk0RC+Pbjo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Pfcj/bPLazUsSglxFk2FL83AvCvzBK32/UDdnKnFpLpB2TdztXBN5UIGhrBu6oAfrgDA+QObJNlBBgTu1uOx+T6x+7Au1jeRFviWKAHoMKszi62rF2IRuWCUL8Yy6wHcZIS2RHZKz1CODoRmdxJu9yfYYnJvPAZwPzU1wmGQ7qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+U8Dwp+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+U8Dwp+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39581F000FF;
	Thu,  8 Oct 2026 11:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791458381;
	bh=sl5BbxP3jsLQ1YELesd5iOejyarH0x8fDDx2BZzGKC8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L+U8Dwp+phZgHddzvu4iVcx/Dydos3JlLu68pj95rrCeWJrd1T7W1No7+I1syhSFP
	 SCYJ2g2NWHc5P+SDQQF7vOO4bNZDDYxabVjO6fg2W3C21j0XPKKM5V8sIMqQMzxvna
	 u2M8AxeS1J8EsGPw/Jw3HUnFu8Js8MzJttk3xxQSxr96/e78viDbbjfLMV830w2g8S
	 IGEu6qeyh0E6kuwWxDAQYoTj/dWd6yvQU3mCZZnkTWDnTtUwAwFe/TapwwcOgC8KRL
	 gl1QxliSx5G1yCELwG+Aa8gJPPxMShxtsOIsv7ZHVmKzbR0ffH4udTMrDqanEsJXBI
	 bCm0pRZvAbm5Q==
Message-ID: <sashiko-outbox-164084@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next] selftests: mptcp: sockopt: test passive Fast
 Open early write push
Reply-To: sashiko-reviews@lists.linux.dev
To: "T S Rameshkumar" <rameshsv06@gmail.com>
Cc: mptcp@lists.linux.dev
In-Reply-To: <20261008111003.136143-1-rameshkumar.t@phytecembedded.in>
References: <20261008111003.136143-1-rameshkumar.t@phytecembedded.in>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 11:19:41 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests: mptcp: Fast Open test falls back to 3WHS due to missi=
ng TFO cookie
- [Medium] selftests/mptcp: Fast Open tests fail CI on older kernels missin=
g support
--

commit b13d72847e34610069932e37b3730c9df5c74745
Author: T S Rameshkumar <rameshsv06@gmail.com>

selftests: mptcp: sockopt: test passive Fast Open early write push

This commit adds automated test coverage for passive Fast Open early write
data push in MPTCP. The server enables TCP_FASTOPEN on an MPTCP listening
socket, and the client connects using TCP_FASTOPEN_CONNECT.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/te=
sting/selftests/net/mptcp/mptcp_sockopt.c
> index d68515b7903b8..861de909abbd8 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c

[ ... ]

> @@ -254,6 +255,14 @@ static int sock_connect_mptcp(const char * const rem=
oteaddr,
>  		if (sock < 0)
>  			continue;
> =20
> +		if (do_tfo) {
> +			int one =3D 1;
> +
> +			if (setsockopt(sock, IPPROTO_TCP, TCP_FASTOPEN_CONNECT,
> +				       &one, sizeof(one)) < 0)
> +				die_perror("setsockopt TCP_FASTOPEN_CONNECT");
> +		}
> +

[Severity: Medium]
Since MPTCP Fast Open was introduced in Linux 6.1+, will unconditionally
calling setsockopt() cause CI failures on older LTS kernels?

On older kernels, setsockopt() returns -EOPNOTSUPP. By using die_perror(),
the test terminates with a hard failure instead of gracefully skipping.

Could this be updated to catch EOPNOTSUPP and exit with a designated SKIP
code?

>  		if (connect(sock, a->ai_addr, a->ai_addrlen) =3D=3D 0)
>  			break; /* success */
> =20

[ ... ]

> @@ -726,13 +738,36 @@ static int server(int pipefd)
>  		break;
>  	}
> =20
> +	if (do_tfo) {
> +		int qlen =3D 5;
> +
> +		if (setsockopt(fd, IPPROTO_TCP, TCP_FASTOPEN, &qlen, sizeof(qlen)) < 0)
> +			die_perror("setsockopt TCP_FASTOPEN");
> +	}
> +

[Severity: Medium]
Similarly, will this cause CI failures on older kernels without MPTCP
Fast Open support?

A failure here returns -EOPNOTSUPP, but die_perror() will cause a hard
failure instead of gracefully bypassing the test.

>  	r =3D write(pipefd, "conn", 4);
>  	assert(r =3D=3D 4);
> =20

[ ... ]

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/t=
esting/selftests/net/mptcp/mptcp_sockopt.sh
> index b4e3eddc9cf21..e88a8bbeb6e36 100755
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh

[ ... ]

> @@ -359,6 +359,39 @@ do_tcpinq_tests()
>  	return $?
>  }
> =20
> +do_fastopen_tests()
> +{
> +	local lret=3D0
> +
> +	ip netns exec "$ns_sbox" sysctl -q net.ipv4.tcp_fastopen=3D3
> +
> +	ip netns exec "$ns_sbox" ./mptcp_sockopt -f
> +	lret=3D$?
> +

[Severity: Medium]
Will this sequence actually exercise the Fast Open early write feature?

Configuring net.ipv4.tcp_fastopen=3D3 requires a valid TFO cookie to accept
data within the initial SYN packet. Because the script executes
./mptcp_sockopt -f exactly once per address family, the client has an empty
cookie cache.

When connect() is called with TCP_FASTOPEN_CONNECT without a cookie, the
kernel falls back to a normal blocking 3-way handshake that requests a
cookie but sends no data in the SYN packet. The server's accept() will
block until the 3-way handshake finishes, bypassing the TFO early write
(TCP_SYN_RECV) state entirely.

Could the test be executed twice (first to get the cookie, second to use it)
or should tcp_fastopen be configured to allow cookieless Fast Open (e.g.,
adding TFO_SERVER_COOKIE_NOT_REQD)?

> +	print_title "Fast Open early write v4"
> +	if [ $lret -ne 0 ]; then
> +		mptcp_lib_pr_fail
> +		mptcp_lib_result_fail "Fast Open early write v4"
> +		ret=3D$lret
> +		return
> +	fi
> +	mptcp_lib_pr_ok
> +	mptcp_lib_result_pass "Fast Open early write v4"
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008111003.1361=
43-1-rameshkumar.t@phytecembedded.in?part=3D1
