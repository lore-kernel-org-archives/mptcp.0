Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767528;
	b=s2WaHF4t00Sg/nfrqiBeEj3DYoU9TZfeFdlDZzIBYZ/DOISKWMip6dKM419Nmfu72MX5
	 F9gsEtPLrfdca2J3xe/BMu5IMob0S/EADAAjxGBkF7dYVJIZqyt7xobUr+OXTqX4xl4/j
	 pk9E1E0eZG79WrqKLAnG/gzzaf6bIaH596IJx5ovTrqzEcRZzL8J1E4MJDN1VkpnbPoZl
	 s3Yku3IRijGKzr3gFQJeqLDFv1svHOaL/ZYOoxhBoh6lh4RtPtXj11nflNwYTH/vfm+Of
	 4J7g6kBkH++4Gf5hCsiL0iktbg3KcfcUNWGWlr161TQGHOODsuFng+RlPsAxn/v78zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767528;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4aSC4nwK7g2pLGWzuRLpb9CnEAR/9NBNqZuZ9p0snec=;
	b=5nUUM7qptaW0iz2VX8aL7fuKVDOk36wkceWj1KErfqzq4A/LOyc1RUvI5U2W0VxyaOcT
	 N3as8xM1NDV0VKml8md1k/SOyGRNVrrKOICpoDmpQFQI6UbRU9AB5kn429Ji/ewB/B9c9
	 otNnSdc8KlUiSWhoKUlxQl9CWRqaxtLOKcC7hXXRysCtp3IC+mC+GfoZ5FIkBusuhH/3q
	 XOpGlzaDeJpzaJ4sdBIR8gK3WXtmQqnR3Quf78rJh4kLQrXrbwwfVZHUzQE+4s9N082OH
	 ixLYGJEPJqfcntwZgXB2t7fvTQKIOGaX1MpALD0iw6MJ5Cz49JCx/CiNM1nLKbxFGOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b0rfVZu+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D642606A31B
	for <mptcp@lists.linux.dev>; Fri, 23 Oct 2026 14:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b0rfVZu+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC9C1F01825;
	Fri, 23 Oct 2026 14:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792767526;
	bh=4aSC4nwK7g2pLGWzuRLpb9CnEAR/9NBNqZuZ9p0snec=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=b0rfVZu+RLLxdxilmVIf9V2/0aMWhag+Zakk/5S5CSCx/sKmaq58HwP1Uba6eLvBS
	 FK8dQCrtwAl2bUb9nilgQ45VOCb58xRHhBXjydjBWlAYJfZlav+mvy8eUPPhjB+9DA
	 AA0hcynqekEng1bVUKYPqAzEwmHJLMK8zCEktPn744XtgowGIukBAVT3oZwfeW5UiV
	 qjnrnsjy2oRHPFbV4s2g4zHcBg2bp7klxr2dn0U5b2gpQznyQh9C7zGV36PXOR1xk4
	 j9m4aaGp5wKlmEimtvWxWKVRZt5x+JZrp9GDP/pPu2829A62d2zB6qcUiD05doCDjj
	 rXc3alafQyWIA==
Message-ID: <sashiko-outbox-182882@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v2] selftests: mptcp: sockopt: echo until EOF
 on partial reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Quanye Yang" <quanyeyang@proton.me>, "MPTCP Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261023-fix-mptcp-issue-639-v2-1-14a3d3746d2d@proton.me>
References: <20261023-fix-mptcp-issue-639-v2-1-14a3d3746d2d@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 14:58:46 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests: mptcp: connect_one_server() passes chunk size to do_g=
etsockopts()
- [Low] selftests: mptcp: process_one_client() passes size_t to PRIu64 in x=
error()
--

commit 22c1d412b84bbca0005369450144b95d047ed072
Author: Quanye Yang <quanyeyang@proton.me>

selftests: mptcp: sockopt: echo until EOF on partial reads

This commit updates process_one_client() to loop and echo chunks until EOF
rather than issuing a single read() and write(), avoiding a hang when the
client payload arrives in multiple segments.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/te=
sting/selftests/net/mptcp/mptcp_sockopt.c
> index b6e58d936ebe5..deb239058e796 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> @@ -638,7 +638,8 @@ static void connect_one_server(int fd, int pipefd)
> =20
>  static void process_one_client(int fd, int pipefd)
>  {
> -	ssize_t ret, ret2, ret3;
> +	size_t nread =3D 0, nwritten =3D 0;
> +	ssize_t ret, n, w, off;
>  	struct so_state s;
>  	char buf[4096];
> =20
> @@ -648,46 +649,53 @@ static void process_one_client(int fd, int pipefd)
>  	ret =3D write(pipefd, "xmit", 4);
>  	assert(ret =3D=3D 4);
> =20
> -	ret =3D read(fd, buf, sizeof(buf));
> -	if (ret < 0)
> +read_more:
> +	n =3D read(fd, buf, sizeof(buf));
> +	if (n < 0)
>  		die_perror("read");
> +	if (n =3D=3D 0)
> +		goto hangup;
> +
> +	for (off =3D 0; off < n; off +=3D w) {
> +		w =3D write(fd, buf + off, n - off);
> +		if (w < 0)
> +			die_perror("write");
> +		if (w =3D=3D 0)
> +			xerror("write returned 0");
> +	}
> +	nread +=3D n;
> +	nwritten +=3D n;
> +	goto read_more;

[Severity: Medium]
When read() in process_one_client() returns a partial chunk n < len, the
server immediately echoes that partial chunk in a separate write() before
looping back to read_more for the remaining bytes.

When the client receives those echoed chunks across multiple read()
iterations in connect_one_server(), won't connect_one_server() then fail in
do_getsockopts()?

Looking at connect_one_server():

	total =3D 0;
	do {
		ret =3D read(fd, buf2 + total, sizeof(buf2) - total);
		if (ret < 0)
			die_perror("read");
		if (ret =3D=3D 0) {
			eof =3D true;
			break;
		}

		total +=3D ret;
	} while (total < len);
	...
	do_getsockopts(&s, fd, ret, ret);

When the loop takes more than one iteration, ret only holds the byte count
from the final read() call rather than the accumulated total. Passing ret to
do_getsockopts() causes do_getsockopt_mptcp_info() to abort on:

	assert(s->mi.mptcpi_write_seq + w =3D=3D i.mptcpi_write_seq);

and causes do_getsockopt_tcp_info() to check tcpi_bytes_sent and
tcpi_bytes_received against the last chunk size ret instead of total. Should
connect_one_server() pass total instead of ret to do_getsockopts()?

> -
> -	assert(s.mptcpi_rcv_delta <=3D (uint64_t)ret);
> +hangup:
> +	assert(s.mptcpi_rcv_delta <=3D nread);
> =20
>  	if (s.tcpi_rcv_delta)
> -		assert(s.tcpi_rcv_delta =3D=3D (uint64_t)ret);
> -
> -	ret2 =3D write(fd, buf, ret);
> -	if (ret2 < 0)
> -		die_perror("write");
> -
> -	/* wait for hangup */
> -	ret3 =3D read(fd, buf, 1);
> -	if (ret3 !=3D 0)
> -		xerror("expected EOF, got %lu", ret3);
> +		assert(s.tcpi_rcv_delta <=3D nread);
> =20
> -	do_getsockopts(&s, fd, ret, ret2);
> -	if (s.mptcpi_rcv_delta !=3D (uint64_t)ret + 1)
> +	do_getsockopts(&s, fd, nread, nwritten);
> +	if (s.mptcpi_rcv_delta !=3D (uint64_t)nread + 1)
>  		xerror("mptcpi_rcv_delta %" PRIu64 ", expect %" PRIu64 ", diff %" PRId=
64,
> -		       s.mptcpi_rcv_delta, ret + 1, s.mptcpi_rcv_delta - (ret + 1));
> +		       s.mptcpi_rcv_delta, (uint64_t)nread + 1,
> +		       s.mptcpi_rcv_delta - ((uint64_t)nread + 1));
> =20
>  	/* be nice when running on top of older kernel */
>  	if (s.pkt_stats_avail) {
> -		if (s.last_sample.mptcpi_bytes_sent !=3D ret2)
> +		if (s.last_sample.mptcpi_bytes_sent !=3D nwritten)
>  			xerror("mptcpi_bytes_sent %" PRIu64 ", expect %" PRIu64
>  			       ", diff %" PRId64,
> -			       s.last_sample.mptcpi_bytes_sent, ret2,
> -			       s.last_sample.mptcpi_bytes_sent - ret2);
> -		if (s.last_sample.mptcpi_bytes_received !=3D ret)
> +			       s.last_sample.mptcpi_bytes_sent, nwritten,
> +			       s.last_sample.mptcpi_bytes_sent - nwritten);
> +		if (s.last_sample.mptcpi_bytes_received !=3D nread)
>  			xerror("mptcpi_bytes_received %" PRIu64 ", expect %" PRIu64
>  			       ", diff %" PRId64,
> -			       s.last_sample.mptcpi_bytes_received, ret,
> -			       s.last_sample.mptcpi_bytes_received - ret);
> -		if (s.last_sample.mptcpi_bytes_acked !=3D ret)
> +			       s.last_sample.mptcpi_bytes_received, nread,
> +			       s.last_sample.mptcpi_bytes_received - nread);
> +		if (s.last_sample.mptcpi_bytes_acked !=3D nread)
>  			xerror("mptcpi_bytes_acked %" PRIu64 ", expect %" PRIu64
>  			       ", diff %" PRId64,
> -			       s.last_sample.mptcpi_bytes_acked, ret,
> -			       s.last_sample.mptcpi_bytes_acked - ret);
> +			       s.last_sample.mptcpi_bytes_acked, nread,
> +			       s.last_sample.mptcpi_bytes_acked - nread);
>  	}

[Severity: Low]
In process_one_client(), nread and nwritten are declared as size_t, which is
32 bits wide on 32-bit architectures, but they are passed directly without a
cast to xerror() for the PRIu64 format specifier before the 64-bit diff
argument.

Could these format strings use %zu for nwritten and nread (or cast them to
uint64_t as done above for mptcpi_rcv_delta) so vfprintf() does not read a
mismatched argument size on 32-bit targets?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-fix-mptcp-=
issue-639-v2-1-14a3d3746d2d@proton.me?part=3D1
