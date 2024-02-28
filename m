Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893B622F1C
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 08:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709107787; cv=none; b=DpaLDhFhlcduSwb7zGAdkhGWo3oFHcNG+peRip4Sg/bUvrGwxu1dLgE08jaowPdd1La+MzB8dRzQarDuIXF2A6Vd6JtNj+OxRIEW0JUUD4hVUyJodt041qL9u5zjOI/1PG3V2hik3QpHxQXWCThmS0H5SBsUWI2Ar1/7ycVdD1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709107787; c=relaxed/simple;
	bh=0gY7zebUtTXv5su0K+LjXW1gKrGtq1AOODIH8ZwHiKw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a5zE3ciV8VHerxmwrD3jSwaPbOlmIZK97dCrXrzLNogcutpcnxI2m8oxMbgraCD//uWCPXpM+qmcHRHHBFj6EcZjdK+5zP8zP4JeGgF1hmj2zsoH2S79Mm4CbPfu4MGs3VKEtCmSTRd0hKYC5hOizduCeeAN7vX/Lus8mKkbGVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpjpfUZl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpjpfUZl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2497C433C7;
	Wed, 28 Feb 2024 08:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709107787;
	bh=0gY7zebUtTXv5su0K+LjXW1gKrGtq1AOODIH8ZwHiKw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cpjpfUZlZncZ6SRoWFxRf6xJUmVwnbs0YV4H1mawzYS+/3aHMWKyfU+K/FVtt7kgF
	 oF8DO3KRZ8NAMc2w4brSWjZ1bd10RuDubxavcVyGasy4rMaOnxvwuJx5qWZ41PwaOR
	 pelJB7yvByb6IuBOEd4UgFJzCTSBFzUz31I3vWqXw4+S4WURSeyf3csjIPVJZQbl8A
	 fFVcXPP+oZqgPsz9kZOjK9jhFgqywO8ntX4Dbytg2en2e7jOMIKhz8T1MqKIUb1Q59
	 ii3PmeY1M8ZxLr3Na7AkfUM8PAkff832WIp0OpWqqqyWMF7ScGaZxNP8LAwdnxFG4S
	 59Xx9cQYuNDaw==
Message-ID: <fd3bc956eef757de45d8ed11d0075b2f7c755c31.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v5 05/12] selftests: mptcp: connect: add
 dedicated port counter
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Wed, 28 Feb 2024 16:09:42 +0800
In-Reply-To: <edc6f735-b8fe-491b-99f6-73c465ab3dfa@kernel.org>
References: <cover.1708939962.git.tanggeliang@kylinos.cn>
	 <932e4723bdbe01f37eb0f65e04f01a40ec7dd780.1708939962.git.tanggeliang@kylinos.cn>
	 <edc6f735-b8fe-491b-99f6-73c465ab3dfa@kernel.org>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBGWKTg4BEAC/Subk93zbjSYPahLCGMgjylhY/s/R2ebALGJFp13MPZ9qWlbVC8O+XlU/4reZtYKQ715MWe5CwJGPyTACILENuXY0FyVyjp/jl2u6XYnpuhw1ugHMLNJ5vbuwkc1I29nNe8wwjyafN5RQV0AXhKdvofSIryqm0GIHIH/+4bTSh5aB6mvsrjUusB5MnNYU4oDv2L8MBJStqPAQRLlP9BWcKKA7T9SrlgAr0VsFLIOkKOQPVTCnYxn7gfKogH52nkPAFqNofVB6AVWBpr0RTY7OnXRBMInMHcjVG4I/NFn8Cc7oaGaWHqX/yHAufJKUsldieQVFd7C/SI8jCUXdkZxR0Tkp0EUzkRc/TS1VwWHav0x3oLSy/LGHfRaIC/MqdGVqgCnm6wapUt7f/JHloyIyKJBGBuHCLMpN6n/kNkSCzyZKV7h6Vw1OL518p0U3Optyakoh95KiJsKzcd3At/eftQGlNn5WDflHV1+oMdW2sRgfVDPrYeEcYI5IkTc3LRO6ucpVCm9/+poZSHSXMI/oJ6iXMJE8k3/aQz+EEjvc2z0p9aASJPzx0XTTC4lciTvGj62z62rGUlmEIvU23wWH37K2EBNoq+4Y0AZsSvMzM+CcTo25hgPaju1/A8ErZsLhP7IyFT17ARj/Et0G46JRsbdlVJ/PvX+XIOc2mpqx/QARAQABtCVHZWxpYW5nIFRhbmcgPGdlbGlhbmcudGFuZ0BsaW51eC5kZXY+iQJUBBMBCgA+FiEEZiKd+VhdGdcosBcafnvtNTGKqCkFAmWKTg4CGwMFCRLMAwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQfnvtNTGKqCmS+A/9Fec0xGLcrHlpCooiCnNH0RsXOVPsXRp2xQiaOV4vMsvhG5AHaQLb3v0cUr5JpfzMzNpEkaBQ/Y8Oj5hFOORhTyCZD8tY1aROs8WvbxqvbGXHnyVwqy7Ad
	WelP+0lC0DZW0kPQLeel8XvLnm9Wm3syZgRGxiM/J7PqVcjujUb6SlwfcE3b2opvsHW9AkBNK7v8wGIcmBA3pS1O0/anP/xD5s5L7LIMADVB9MqQdeLdFU+FFdafmKSmcP9A2qKHAvPBUuQo3xoBOZR3DMqXIPkNCBfQGkAx5tm1XYli1u3r5tp5QCRbY5LSkntMNJJh0eWLU8I+zF6NWhqNhHYRD3zc1tiXlG5E0obpX02Dy25SE2zB3abCRdAK30nCI4lMyMCcyaeFqvf6uhiugLiuEPRRRdJDWICOLw6KOFmxWmue1F71k08nj5PQMWQUX3X2K6jiOuoodYwnie/9NsH3DBHIVzVPWASFd6JkZ21i9Ng4ie+iQAveRTCeCCF6VRORJR0R8d7mI9+1eqhNeKzs21gQPVf/KBEIpwPFDjOdTwS/AEQQyhB+5ALeYpNgfKl2p30C20VRfJGBaTc4ReUXh9xbUx5OliV69iq9nIVIyculTUsbrZX81Gz6UlbuSzWc4JclWtXf8/QcOK31wputde7Fl1BTSR4eWJcbE5Iz2yzgQu0IUdlbGlhbmcgVGFuZyA8Z2VsaWFuZ0BrZXJuZWwub3JnPokCVAQTAQoAPhYhBGYinflYXRnXKLAXGn577TUxiqgpBQJlqclXAhsDBQkSzAMABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH577TUxiqgpaGkP/3+VDnbu3HhZvQJYw9a5Ob/+z7WfX4lCMjUvVz6AAiM2atDyyUoDIv0fkDDUKvqoU9BLU93oiPjVzaR48a1/LZ+RBE2mzPhZF201267XLMFBylb4dyQZxqbAsEhVc9VdjXd4pHYiRTSAUqKqyamh/geIIpJz/cCcDLvX4sM/Zjwt/iQdvCJ2eBzunMfouzryFwLGcOXzxOwZRMOBgVuXrjGVB52kYu1+K90DtclewEgvzWmS9d057CJztJZMXzvHfFAQMgJC7DX4pa
	Yt49pNvhcqLKMGNLPsX06OR4G+4ai0JTTzIlwVJXuo+uZRFQyuOaSmlSjEsiQ/WsGdhILldV35RiFKe/ojQNd4B4zREBe3xT+Sf5keyAmO/TG14tIOCoGJarkGImGgYltTTTM6rIk/wwo9FWshgKAmQyEEiSzHTSnXcGbalD3Do89YRmdG+5eP7HQfsG+VWdn8IH6qgIvSt8GOw6RfSP7omMXvXji1VrbWG4LOFYcsKTN+dGDhl8LmU0y44HejkCzYj/b28MvNTiRVfucrmZMGgI8L5A4ZwQ3Inv7jY13GZSvTb7PQIbqMcb1P3SqWJFodSwBg9oSw21b+T3aYG3z3MRCDXDlZAJONELx32rPMdBva8k+8L+K8gc7uNVH4jkMPkP9jPnVPx+2P2cKc7LXXedb/qQ3MuQINBGWKTg4BEADJxiOtR4SC7EHrUDVkp/pJCQC2wxNVEiJOas/q7H62BTSjXnXDc8yamb+HDO+Sncg9SrSRaXIh+bw9G3rvOiC2aQKB6EyIWKMcuDlD7GbkLJGRoPCA5nSfHSzht2PdNvbDizODhtBy8BOQA6Vb21XOb1k/hfD8Wy6OnvkA4Er61cf66BzXeTEFrvAIW+eUeoYTBAeOOc2m4Y0J28lXhoQftpNGV5DxH9HSQilQZxEyWkNj8oomVJ6Db7gSHre0odlt5ZdB7eCJik12aPIdK5W97adXrUDAclipsyYmZoC1oRkfUrHZ3aYVgabfC+EfoHnC3KhvekmEfxAPHydGcp80iqQJPjqneDJBOrk6Y51HDMNKg4HJfPV0kujgbF3Oie2MVTuJawiidafsAjP4r7oZTkP0N+jqRmf/wkPe4xkGQRu+L2GTknKtzLAOMAPSh38JqlReQ59G4JpCqLPr00sA9YN+XP+9vOHT9s4iOu2RKy2v4eVOAfEFLXq2JejUQfXZtzSrS/31ThMbfUmZsRi8CY3HRBAENX224Wcn6IsXj3K6lfYxImRKWGa
	/4KviLias917DT/pjLw/hE8CYubEDpm6cYpHdeAEmsrt/9dMe6flzcNQZlCBgl9zuErP8Cwq8YNO4jN78vRlLLZ5sqgDTWtGWygi/SUj8AUQHyF677QARAQABiQI7BBgBCgAmFiEEZiKd+VhdGdcosBcafnvtNTGKqCkFAmWKTg4CGwwFCRLMAwAACgkQfnvtNTGKqCkpsw/2MuS0PVhl2iXs+MleEhnN1KjeSYaw+nLbRwd2SdXoVXBquPP9Bgb92T2XilcWObNwfVtD2eDz8eKf3e9aaWIzZRQ3E5BxiQSHXl6bDDNaWJB6I8dd5TW+QnBPLzvqxgLIoYn+2FQ0AtL0wpMOdcFg3Av8MEmMJk6s/AHkL8HselA3+4h8mgoK7yMSh601WGrQAFkrWabtynWxHrq4xGfyIPpq56e5ZFPEPd4Ou8wsagn+XEdjDof/QSSjJiIaenCdDiUYrx1jltLmSlN4gRxnlCBp6JYr/7GlJ9Gf26wk25pb9RD6xgMemYQHFgkUsqDulxoBit8g9e0Jlo0gwxvWWSKBJ83f22kKiMdtWIieq94KN8kqErjSXcpI8Etu8EZsuF7LArAPch/5yjltOR5NgbcZ1UBPIPzyPgcAmZlAQgpy5c2UBMmPzxco/A/JVp4pKX8elTc0pS8W7ne8mrFtG7JL0VQfdwNNn2R45VRf3Ag+0pLSLS7WOVQcB8UjwxqDC2t3tJymKmFUfIq8N1DsNrHkBxjs9m3r82qt64u5rBUH3GIO0MGxaI033P+Pq3BXyi1Ur7p0ufsjEj7QCbEAnCPBTSfFEQIBW4YLVPk76tBXdh9HsCwwsrGC2XBmi8ymA05tMAFVq7a2W+TO0tfEdfAX7IENcV87h2yAFBZkaA==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0-1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Mon, 2024-02-26 at 13:41 +0100, Matthieu Baerts wrote:
> Hi Geliang,
>=20
> On 26/02/2024 10:43, Geliang Tang wrote:
> > From: Geliang Tang <tanggeliang@kylinos.cn>
> >=20
> > This patch adds a new dedicated counter 'PORT' instead of
> > TEST_COUNT to
> > increase port numbers in mptcp_connect.sh.
> >=20
> > This can avoid outputting discontinuous test counters.
> >=20
> > Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> > ---
> > =C2=A0tools/testing/selftests/net/mptcp/mptcp_connect.sh | 5 +++--
> > =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > index c7483902026b..68073b255983 100755
> > --- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
> > @@ -33,6 +33,7 @@ do_tcp=3D0
> > =C2=A0checksum=3Dfalse
> > =C2=A0filesize=3D0
> > =C2=A0connect_per_transfer=3D1
> > +PORT=3D0
>=20
> Can you not initialise it her at '10000'...
>=20
> > =C2=A0
> > =C2=A0if [ $tc_loss -eq 100 ];then
> > =C2=A0	tc_loss=3D1%
> > @@ -317,7 +318,7 @@ do_transfer()
> > =C2=A0	local extra_args=3D"$7"
> > =C2=A0
> > =C2=A0	local port
> > -	port=3D$((10000+TEST_COUNT))
> > +	port=3D$((10000+PORT++))
>=20
> ... and here, have:
>=20
> =C2=A0 port=3D$((PORT + TEST_COUNT))
>=20
> (or PORT++ if TEST_COUNT is removed later)
>=20
> > =C2=A0	TEST_COUNT=3D$((TEST_COUNT+1))
> > =C2=A0
> > =C2=A0	if [ "$rcvbuf" -gt 0 ]; then
> > @@ -712,7 +713,7 @@ EOF
> > =C2=A0
> > =C2=A0	mptcp_lib_print_info "INFO: test $msg"
> > =C2=A0
> > -	TEST_COUNT=3D10000
> > +	PORT=3D10000
>=20
> So here you don't need to override the value, no?

This doesn't work, the value of port is changed. Keep this patch
unchanged.

>=20
> > =C2=A0	local extra_args=3D"-o TRANSPARENT"
> > =C2=A0	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP \
> > =C2=A0		=C2=A0=C2=A0=C2=A0 ${connect_addr} ${local_addr} "${extra_args}=
"
>=20
> While at it, maybe use ${PORT} in check_mptcp_disabled()?
>=20
> Cheers,
> Matt

