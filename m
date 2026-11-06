Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793994803;
	b=uyZSVeIF2fsPfu6NOJCN4xNIh4oG4GYx9JcE7FyEGi6KBVzrTRgFyZqbBzkNE8yNg665
	 Axns/lSFO91hY/A6py05CetSNyYYGAM9eInI/lW5W/BNcuWOi/7UUIkjSUUCqh+VoUzXD
	 A54ZNlIcD49JoNk5gbuul6shh/1UUh7DCxZIAece5CdxrVH5M/8kPrtU963DVI3Fx1rRp
	 Bcw+F9/czNZp3QUpAmtRN7Id2362Q/N6ayYxOThJ+UJ6h5ysMmbGSkDXO4DOTXiq1gWQs
	 pFWK1JKHl9V3gHYGVJCvLNH5MHlb02TsNCT4EjVbFo2GIuXvy0+szKKjkfaN2aqWmSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793994803;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=tfqAs3oirMakvODy6zg0CYmPSd8i5SVaZVv5PyEr8ds=;
	b=tM8pZnTYpFAys8cbFWEnr1dRbTvagESCXChKbH3Ac2lQFlACbRDIOucFQZ4wj3cyZEPF
	 8ywOrX9iHLHhgfH2A8VdpDD5HlS+7Vx6z0FQlToAFkBPsTydU34HOSRS46/udMdJcu4bR
	 HogsrPijakezZjGX8kz6ydnIDpysgIkEMIBRyNcFTBXriov242Gtc0/bJEwa3xKJnlLfl
	 hL76m/9wxDX1lDTS3nRhjFcujlw6k+brt8Ud3tXcv1+LriCxSX3+Vp6qkHis88wz0k5Wr
	 qMC3CrxQCwNCJsoa1jo3eV7RRyWPBmX49Aa1T8WTn7E481jm45OVSsvEtDFWlYASY5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jEcv1vwX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84F2606A330
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jEcv1vwX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752BD1F0089F;
	Fri,  6 Nov 2026 19:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793994802;
	bh=tfqAs3oirMakvODy6zg0CYmPSd8i5SVaZVv5PyEr8ds=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jEcv1vwXRu3zfv92If5OlcVxut0Rn9qS1joy4mJwVwnu96xS8HbUPaZ95jZGUsnhA
	 /4ZDPoviQp24xGp127A8BQc5aDR3zU9cOJ3WDXPiyjjvd2aw/TSNsLbdNtMosF/Vn+
	 II3o8vVmI6ExCzh5UsdTkKvedZxQaH4O6MFMQREJa9EBFyxI0xFuG8odtDnV6Ajnr0
	 r8f6vjSMpKLjd41pIqifNynpWuCxB3joUIXvvC7oUiGc1SbzI/cWocQtntTzcYD2b5
	 cOaps7y3i4mgtSm71wwn2BHGMAEj4izKoDLdY8XkUaO0bF0mRxFfmravGl6BlPADF/
	 5tRg5zNYAc8IA==
Subject:
 Re: [PATCH mptcp-next v6 7/7] selftests: mptcp: sockopt: check app_limited
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Fri, 06 Nov 2026 19:53:22 +0000
Message-ID: <179399480205.488855.10733118283121837992@kernel.org>
In-Reply-To: <30807971ab2ce40b1c8d9a73e96e7472e1329910.1793860134.git.tanggeliang@kylinos.cn>
References: <30807971ab2ce40b1c8d9a73e96e7472e1329910.1793860134.git.tanggeliang@kylinos.cn>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message says the new check "guards against regressions
  in subflow app-limited accounting", but the test covers only half of…

--

selftests: mptcp: sockopt: check app_limited

This commit adds an assertion to connect_one_server() in the mptcp_sockopt
selftest. After a small data exchange, it checks that
tcpi_delivery_rate_app_limited == 1. The check only runs when
expect_all_features() returns true.

> This guards against regressions in subflow app-limited accounting.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> index b8158a1198eba..9517c530ba214 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> @@ -635,6 +635,11 @@ static void connect_one_server(int fd, int pipefd)
>  	do_getsockopts(&s, fd, total, total);
>  
>  	assert(s.mptcpi_rcv_delta == (uint64_t)total);
> +
> +	/* app-limited accounting only checked under EXPECT_ALL_FEATURES */
> +	if (expect_all_features())
> +		assert(s.tcp_info.tcpi_delivery_rate_app_limited == 1);

[Severity: Low]
This isn't a bug, but is the claim in the commit message broader than what
this assertion covers?

In connect_one_server(), the client does one write() of 128 to 4095 bytes,
with nothing else pending at the MPTCP level. That only exercises the path
in mptcp_rate_check_app_limited() where every subflow gets marked
app-limited. The early return is never exercised:

net/mptcp/protocol.c:mptcp_rate_check_app_limited() {
    ...
	if (msk->write_seq != msk->snd_nxt || mptcp_send_head(sk) ||
	    test_bit(MPTCP_WORK_RTX, &flags) ||
	    test_bit(MPTCP_RETRANSMIT, &cb_flags))
		return;
    ...
}

The parent commit, "mptcp: track app-limited state in mptcp_sendmsg", says
this bail-out is needed so congestion controllers are not misled.

Suppose a later change weakened those conditions so subflows were always
marked app-limited. tcp_init_sock() sets rate_app_limited to 1, and
app-limited samples keep it at 1. The assertion would still pass, so that
regression would go unnoticed.

The test does catch the opposite case, where subflows are never marked
app-limited. Without the parent commit, rate_app_limited drops to 0 here.

The check is also gated on SELFTESTS_MPTCP_LIB_EXPECT_ALL_FEATURES=1.
mptcp_lib.sh reads that variable but never sets it, so a default kselftest
run doesn't check anything new. The code comment mentions this gate, but
the commit message doesn't.

Could the commit message describe the narrower coverage and the opt-in
gate? Alternatively, could a case with data still pending be added, so
the early return in mptcp_rate_check_app_limited() gets tested too?

> +
>  	close(fd);
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793860134.git.tanggeliang%40kylinos.cn
