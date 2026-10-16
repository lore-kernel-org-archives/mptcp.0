Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C394428B4FD
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 05:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792130287; cv=none; b=t6RSjj8tRRF0+iODUtWrinRpkuqwlLNStRV7vS2ph50qcr1EqusFroMYmQq+R1RTaW+AJyu9Q2GayydPc2XSJXsFPIKvYcVqWSpNIUP0+ZsflT/Ono4WCZcFORoAKj4BZEa0ms6X2QnMz4wbQrfhtr2njjad0X6b+sQyeTBcLWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792130287; c=relaxed/simple;
	bh=G8VxrRFv4EMsWquy/CvI30huXFZAYm927AvYObm4CSE=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=DV8E2SpOEiWClktaRxbctpB5O2l/2TrNI/PA56sdD9ZGW/ZAKFiVylj3NoSLUf+v/VwVAuHoFZhcB+ZWL6xcfat5P7N6+4zY4Rd7Aot17OLKpAPFfF3kxUeqVTTxcuRL8VF9SLJR+IS4DgULxu8LxYGLepixI+g905fZ2Nb5KfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIWMQgfP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIWMQgfP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA0B1F000C4;
	Fri, 16 Oct 2026 05:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792130286;
	bh=L84luRrEdUGozn+IILNwKTkInWJzhn3QiNWpcMUGJGY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=RIWMQgfPtS/m0EQX5IHVenhwCvgfuyXotjQPKhK0x8qY/fspRaXeRVcGm51Q0wG85
	 07KbxUZ7n/0vfLF2EfoUY/REdSxpdm5e993Gu24fzXEZbYWrNnccEc0SlVUYKFB1Ii
	 6N7B9zQO/gaPTskz9Xsdmuy402bmbOYvacz8X2RNPEzIH4KGdJyzBlSskIsUnTllYf
	 Vx8MRJOhD6B3JiUy+x1zqxXeLIHXJTphPGd0F4EpZ/iOIbEJlWETUEHBMdx2ES06Oi
	 kD6+9906TQENuSz0eZO/9SGKrkZ6uh5270G8xMVudukThwvdQOG/tVaVPUc3DgMaUG
	 fONLFChegx+jg==
Message-ID: <sashiko-outbox-173845@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v4 1/3] selftests: mptcp: connect: retry
 write() on EAGAIN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anil Kaushik" <anilkaushikwireless@gmail.com>, mptcp@lists.linux.dev
In-Reply-To: <20261016055010.980819-2-anilkaushikwireless@gmail.com>
References: <20261016055010.980819-1-anilkaushikwireless@gmail.com>
 <20261016055010.980819-2-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 05:58:05 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests/mptcp: OOB stack read via unsigned len underflow
--

commit 2c05e206fd91fc4ebb90da18cf7072e457266159
Author: Anil Kaushik <anilkaushikwireless@gmail.com>

selftests: mptcp: connect: retry write() on EAGAIN

mptcp_connect treats any write() error as fatal. But write() can fail
with EAGAIN even after poll() said the socket was writable: the MPTCP
send buffer shrinks when a subflow is closed.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/te=
sting/selftests/net/mptcp/mptcp_connect.c
> index 178d98d91fea2..b9fd0bdab7486 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
[ ... ]
> @@ -711,6 +712,21 @@ static int copyfd_io_poll(int infd, int peerfd, int =
outfd,
> =20
>  				bw =3D do_rnd_write(peerfd, winfo->buf + winfo->off, winfo->len);
[Severity: Medium]
Does this sequence allow an out-of-bounds stack read if the preceding read
call encounters an error?

In copyfd_io_poll(), winfo->len is assigned the result of read(). If read()
fails and returns -1, the signed value is assigned to the unsigned int
winfo->len, wrapping to its maximum value.

The condition checking if winfo->len > 0 then evaluates to true and bypasses
the error handling. This massive length is passed here to do_rnd_write(),
which computes a random write length up to 65535:

do_rnd_write() {
    ...
    do_w =3D rand() & 0xffff;
    if (do_w =3D=3D 0 || do_w > len)
        do_w =3D len;

    bw =3D write(fd, buf, do_w);
}

Since the winfo->buf size is only 8192 bytes, could write() read uninitiali=
zed
data beyond the stack buffer boundary?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016055010.9808=
19-1-anilkaushikwireless@gmail.com?part=3D1
