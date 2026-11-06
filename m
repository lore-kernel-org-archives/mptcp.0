Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965901;
	b=o9WIE7TwKihxW2tnHVuM0PIWTWRQO1yov6kiQErvhsRHotP5bYjN6m5hJtOa8z7+5vXC
	 OMBjULYjvLWVOrs39rSL6Vqg050Ewdn2KlncGDsdtuW486R4MVUyka+glA4/3ZrhJYYu/
	 hzif8TYKX8DPY3dei562XwV/yOYSg5dPNFFRLnw5mmIpbWKgkzj/kzodFvZosqyISqVmI
	 RdaZW4XTANcJJ4SDlxKaJ75laZg3p1L19TiPRyUaBXHZeBQ4BcsRsx4Amvx+FDXQsuDzP
	 /mSbbH3/nScJyhrACMikOXx6JKZ3NEoFiciTR5gZZ0nO4pp+3IGZeoBSgAUgbOmbbIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965901;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jNLoI6tUaDiQqX/B9uwX+x/mQD0Fp7Oqk1/Nnz4be5g=;
	b=JCwb1A+sokspcM+QqiZ4RRbuoS84BQyj9qfVIo6owd9kKl53cb2PBTVK8JHgLh53PAFt
	 m1RzoRTmB2wGa69nSnf/eAdR9PI7J2DfQuUIT0VflTN3WlVjEmvsXh0xucEmZWeLAD5cP
	 UNoFXxBkr9YYuuMQXXAPnFYLTz85z4Fu1oNaiqO7puxwwhWbhVnBk3OtaWRgcnvXTGEyL
	 MFEllMhtfORd7k3iBlrg5K/yCG68HhPG6L1fe+t8aaDzfqr49ybXGlmsz4ndvVINq4xVo
	 4/xkgLMm5UEQKf3YyrUNpuNGpBrSAqHmGpUUCHZkdjNFCHlz21XeQRHvpYWrnx9vG9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Hsi/dJYD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0AE606A326
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hsi/dJYD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF001F0089F;
	Fri,  6 Nov 2026 11:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965900;
	bh=jNLoI6tUaDiQqX/B9uwX+x/mQD0Fp7Oqk1/Nnz4be5g=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Hsi/dJYDNuq1u/gMJXdq08Z2mKG61QA0FAu/wO3hlwoddr47GgxyoF+h3VA/j5wiD
	 +nDYf1XqXIsZDD5F7SZvqNWvnN1jwsl1VpzQ4NmVxvEFKJpHWpRXVDkahjMUKckKV5
	 aoBcGyLw8hv1lnWszmnb04WlaJmwFLLSuibnju6YRPcwk9K7BKjVnOaXx5/ZUnA/Zb
	 WQkmJkfLknNRTkczjdXrpllGBty3tZ8EJY4FWQiIuSkTfcx5KNvwux9FhdXk4n7phr
	 m2vW97YsyhcwywN1DzmshesNLLksmMwpUeEieGbpBXwlZWyxhRh1C7g9dkj3+WTuwG
	 /gqgzDKbD8eFQ==
Message-ID: <sashiko-outbox-201363@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v22 2/8] selftests: mptcp: connect: check TFO
 SIOCINQ overflow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>, mptcp@lists.linux.dev
In-Reply-To: <db502fd327a473221aef9a5bf2995cf627ec187f.1793964796.git.tanggeliang@kylinos.cn>
References: <cover.1793964796.git.tanggeliang@kylinos.cn>
 <db502fd327a473221aef9a5bf2995cf627ec187f.1793964796.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 11:51:39 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] selftests: mptcp: wait_for_remote_key() fails on TCP and
  fallback sockets
- [Low] selftests: mptcp: missing SOL_MPTCP fallback macro in
  mptcp_connect.c
--

commit 4c8b1264330b7ada03e819d1d1820de00d3fda02
Author: Geliang Tang <geliang@kernel.org>

selftests: mptcp: connect: check TFO SIOCINQ overflow

This commit adds a check in mptcp_connect's server loop to wait for the
remote key on MPTFO connections and verify that SIOCINQ does not return
INT_MAX.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/te=
sting/selftests/net/mptcp/mptcp_connect.c
> index 178d98d91fea2..41eff818e950e 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c

[ ... ]

> @@ -1176,6 +1177,24 @@ static void maybe_close(int fd)
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
> +		if (getsockopt(fd, SOL_MPTCP, MPTCP_INFO, &info, &olen) < 0)

[Severity: Low]
Does SOL_MPTCP need a fallback definition in mptcp_connect.c?  SOL_MPTCP is
not defined in the UAPI headers, so building against older libc headers
(prior to glibc 2.34) will fail with an undeclared identifier error unless
it is guarded with #ifndef SOL_MPTCP like IPPROTO_MPTCP and TCP_ULP at the
top of this file (and SOL_MPTCP in mptcp_inq.c and mptcp_sockopt.c).

> +			return false;
> +		if (info.mptcpi_flags & MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED)
> +			return true;
> +		usleep(10000);
> +		retries--;
> +	}
> +	return false;
> +}
> +
>  int main_loop_s(int listensock)
>  {
>  	struct sockaddr_storage ss;
> @@ -1207,6 +1226,24 @@ int main_loop_s(int listensock)
>  		check_sockaddr(pf, &ss, salen);
>  		check_getpeername(remotesock, &ss, salen);
> =20
> +		if (cfg_sockopt_types.mptfo) {
> +			int avail;
> +
> +			if (!wait_for_remote_key(remotesock)) {
> +				fprintf(stderr,
> +					"TFO: timeout waiting for third ACK\n");
> +				close(remotesock);
> +				return 1;
> +			}

[Severity: Low]
Will wait_for_remote_key() fail when remotesock is a plain TCP socket or an
MPTCP socket that fell back to TCP?

In mptcp_connect.sh, run_tests_mptfo() passes "-o MPTFO" to run_tests_lo(),
which also runs MPTCP->TCP, TCP->MPTCP, and TCP->TCP transfers when invoked
with -t:

tools/testing/selftests/net/mptcp/mptcp_connect.sh:run_tests_lo() {
    ...
	do_transfer ${listener_ns} ${connector_ns} MPTCP TCP \
		    ${connect_addr} ${local_addr} "${extra_args}"
    ...
	do_transfer ${listener_ns} ${connector_ns} TCP MPTCP \
		    ${connect_addr} ${local_addr} "${extra_args}"
    ...
}

On a TCP listener (-s TCP) or an MPTCP listener accepting a connection from
a TCP client, getsockopt(fd, SOL_MPTCP, MPTCP_INFO, ...) fails immediately
with ENOPROTOOPT, causing wait_for_remote_key() to return false and abort
the test with "TFO: timeout waiting for third ACK".

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793964796.gi=
t.tanggeliang@kylinos.cn?part=3D2
