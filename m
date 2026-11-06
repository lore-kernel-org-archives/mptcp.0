Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CE6606A32C
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 13:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J+kaW6mS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254901F0089F;
	Fri,  6 Nov 2026 13:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793970901;
	bh=sY+EbUaTDFHrmhYNLOVJU0Frlyv2U/zT5UeNmPw3uEQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=J+kaW6mS+yCgqgHabKL2dz6y6ZAGWLmmyIAKe3KkqmezHuW+VSIdXMtsGmXsBUOX/
	 Tz0eR0Br+ZPNhWpjQlisDBD6FBUo1kWjkCDxwHnu4V+IlFOKn0jXj5lpjWV84UCtwR
	 6B+VHuKmSJXutQX06etGj4k14/QO8E/IDAg4hi3H8N1jvabHe3MAR6VAuke+XFYtlH
	 xcXzJiG9VkeWRxwwNbk9/4zWv05bi4qccl0u8ScOY4iCCq80O01Xktc6HY2ebxTTli
	 jrk+27WMq1bKFQjOPRS+RDztqZy0Azi9YuqT4QybxteCYoGaIelvX9DtTVBLBVyksc
	 OpEvk+jAXxvpg==
Message-ID: <sashiko-outbox-201449@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v23 2/8] selftests: mptcp: connect: check TFO
 SIOCINQ overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <9705c8c5686aca72e8bbaea893587f92bdd3306d.1793969127.git.tanggeliang@kylinos.cn>
References: <cover.1793969127.git.tanggeliang@kylinos.cn>
 <9705c8c5686aca72e8bbaea893587f92bdd3306d.1793969127.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 13:15:00 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] selftests: mptcp: unhandled EOPNOTSUPP in
  wait_for_remote_key() for IPv4 TCP
--

commit 058a45159cca4e12fb9271f3ed25cdefa12d46b9
Author: Geliang Tang <geliang@kernel.org>

selftests: mptcp: connect: check TFO SIOCINQ overflow

This commit adds a SIOCINQ check in mptcp_connect's server mode when the
MPTFO socket option is enabled to detect TFO SIOCINQ overflow regressions.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/te=
sting/selftests/net/mptcp/mptcp_connect.c
> index 178d98d91fea2..3a72bae43b906 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c

[ ... ]

> @@ -1176,6 +1180,28 @@ static void maybe_close(int fd)
>  		close(fd);
>  }
> =20
> +static bool wait_for_remote_key(int fd)
> +{
> +	struct mptcp_info info;
> +	int retries =3D 10;
> +	socklen_t olen;
> +
> +	while (retries > 0) {
> +		olen =3D sizeof(info);
> +		if (getsockopt(fd, SOL_MPTCP, MPTCP_INFO, &info, &olen) < 0) {
> +			/* Not an MPTCP socket (TCP or fallback), skip wait */
> +			if (errno =3D=3D ENOPROTOOPT)
> +				return true;
> +			return false;
> +		}

[Severity: Medium]
Should wait_for_remote_key() also check for EOPNOTSUPP here?

For AF_INET TCP sockets (and MPTCP sockets that fell back to TCP),
tcp_getsockopt() delegates non-SOL_TCP levels to ip_getsockopt() ->
do_ip_getsockopt(), which returns -EOPNOTSUPP instead of -ENOPROTOOPT
when level !=3D SOL_IP.  As a result, IPv4 TCP and TCP-fallback test cases
with -o MPTFO return false from wait_for_remote_key() and fail in
main_loop_s() with "TFO: timeout waiting for third ACK".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793969127.gi=
t.tanggeliang@kylinos.cn?part=3D2
