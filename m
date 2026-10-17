Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1111C270552
	for <mptcp@lists.linux.dev>; Sat, 17 Oct 2026 11:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792236585; cv=none; b=SzzGwJ/h3nY3tnTU6p/eYkgukKdYusM/itbgfEZInwIGIjztH5v58rvyRE8NwrZYQRwFr2WV+c31FY8XOxNRAE9ksB/SxwoP18XwHFn0AsMgz0ZyWbYh0Vemczf1In+ZSia38Fz1DdhuADP8br3aKM+eIUwcvbgWiHrxOtBxYUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792236585; c=relaxed/simple;
	bh=UW8vBxmTQfA8eSQe+RLp678Cvbf4Ctunb6m+G0LCuZQ=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=IJtzkrSWN1GFGv4sVQhryxbbDHoRNcVeBnoX6T61Ta0yXmR4GNkQGn5XUnTOzMy3cPNqI9gseQxSJzHPsuC0IQiSR7cGLuflQOlndkx+6+Yw7tvKWwHnM5gYowfh3VRuOJZP0xrCs8T7F9a51tvVdSjSAm47TOUjQzhUz5ZZJ2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIvTmffJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIvTmffJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A831F000C4;
	Sat, 17 Oct 2026 11:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792236583;
	bh=Yhatq3UAEnorUrFddmBcFIY1HhO1CKrfOOrKRzml4LM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=CIvTmffJBV2+PWI7ZMAsL/4NIt5GQSo7Va0zOahIvDp1Yh4iYrJeFtI4rQwbl3H9y
	 Q0LemTD5y3gSlnCGKJxx94BrU8cXvGyXWzsN5LsE9o8M/GaEZlzQkfkMZwjW7obKlf
	 Ik+dmXi6EYsyGINlB6RN7+TfJ1mJlDEaIGYeCUujm2CaKSiRzsESfypRVl4/5ur5NL
	 TxBn5p587hBslFjUc9y9FoO2vZH6QYOQvL3AVoVwR8jLc8as+sfG9vEt7UDxhmADf0
	 xywXVkirs9+xU4R29SxBEVgyQxnHQbp1YGkQBUeZ60tjvBZo7pd9VNn51JvSWhft4v
	 euZaYVaKih0Zg==
Message-ID: <sashiko-outbox-175497@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net] selftests: mptcp: sockopt: echo until EOF on
 partial reads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Quanye Yang" <quanyeyang@proton.me>, "MPTCP Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261017-fix-mptcp-issue-639-v1-1-0554d07ab8f8@proton.me>
References: <20261017-fix-mptcp-issue-639-v1-1-0554d07ab8f8@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 11:29:43 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests: mptcp: connect_one_server() passes partial ret to do_=
getsockopts()
--

commit 522b0ff16267ee948ab4943b8089644ce3f33c32
Author: Quanye Yang <quanyeyang@proton.me>

selftests: mptcp: sockopt: echo until EOF on partial reads

This commit updates process_one_client() in mptcp_sockopt.c to loop over
read() and write() until EOF, preventing a hang when payload segmentation
causes a short read on the server.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/te=
sting/selftests/net/mptcp/mptcp_sockopt.c
> index b6e58d936ebe5..5e1ec33368590 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
> @@ -638,7 +638,7 @@ static void connect_one_server(int fd, int pipefd)
> =20
>  static void process_one_client(int fd, int pipefd)
>  {
> -	ssize_t ret, ret2, ret3;
> +	ssize_t ret, ret2, n, w;
>  	struct so_state s;
>  	char buf[4096];
> =20
> @@ -648,23 +648,27 @@ static void process_one_client(int fd, int pipefd)
>  	ret =3D write(pipefd, "xmit", 4);
>  	assert(ret =3D=3D 4);
> =20
> -	ret =3D read(fd, buf, sizeof(buf));
> -	if (ret < 0)
> -		die_perror("read");
> +	ret =3D 0;
> +	ret2 =3D 0;
> +	while ((n =3D read(fd, buf, sizeof(buf))) > 0) {
> +		if (!ret) {
> +			assert(s.mptcpi_rcv_delta <=3D (uint64_t)n);
> =20
> -	assert(s.mptcpi_rcv_delta <=3D (uint64_t)ret);
> -
> -	if (s.tcpi_rcv_delta)
> -		assert(s.tcpi_rcv_delta =3D=3D (uint64_t)ret);
> +			if (s.tcpi_rcv_delta)
> +				assert(s.tcpi_rcv_delta <=3D (uint64_t)n);
> +		}
> =20
> -	ret2 =3D write(fd, buf, ret);
> -	if (ret2 < 0)
> -		die_perror("write");
> +		w =3D write(fd, buf, n);
> +		if (w < 0)
> +			die_perror("write");
> +		if (w !=3D n)
> +			xerror("short write");
> =20
> -	/* wait for hangup */
> -	ret3 =3D read(fd, buf, 1);
> -	if (ret3 !=3D 0)
> -		xerror("expected EOF, got %lu", ret3);
> +		ret +=3D n;
> +		ret2 +=3D w;
> +	}

[Severity: Medium]
When a partial read occurs in process_one_client(), it immediately echoes
the partial chunk n back to the client before reading and echoing the rest
of the payload in subsequent loop iterations.

If the client in connect_one_server() reads the echoed data across more
than one read() call, ret only holds the byte count of the final chunk
while total accumulates the full length:

tools/testing/selftests/net/mptcp/mptcp_sockopt.c:connect_one_server() {
	...
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
}

Because connect_one_server() passes ret instead of total to
do_getsockopts(), won't connect_one_server() -> do_getsockopts() ->
do_getsockopt_mptcp_info() fail on:

	assert(s->mi.mptcpi_write_seq + w =3D=3D i.mptcpi_write_seq);

and do_getsockopt_tcp_info() fail when checking tcpi_bytes_sent and
tcpi_bytes_received against r and w whenever the echoed response is read in
multiple chunks? Should connect_one_server() pass total to do_getsockopts()
as well?

> +	if (n < 0)
> +		die_perror("read");
> =20
>  	do_getsockopts(&s, fd, ret, ret2);
>  	if (s.mptcpi_rcv_delta !=3D (uint64_t)ret + 1)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017-fix-mptcp-=
issue-639-v1-1-0554d07ab8f8@proton.me?part=3D1
