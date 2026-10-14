Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BB249AA30
	for <mptcp@lists.linux.dev>; Wed, 14 Oct 2026 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988972; cv=none; b=q1a/yECKuaTNrwzdjqp0HMaNpxEelEQtcJcyumkLGmhGJtKur7fn/9CUCb/XW0uMGgYkuO1S6p55HF34LSXFXmVC6B6xBHc0FoVbbx+aKEQD2mkyEtkXIU1Owgag4FqAl2RDIfRO6tVA9he2l0VPwK/UDNg7JERrarg9tI5KHMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988972; c=relaxed/simple;
	bh=71d2AKis7JCx/6HoFo0tlub7peURDeRvypnPjfx+BqA=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=REAnp7SHz+Jd86HLAqtsFF9HzPltfPLeFvRspPM16Kq5+c3TUvojITA6O7A3SVj/J7zHBsDApKvLfPsiGQPl2pu+Ryo9AqKZLtmz8GCTHBNpz5+4MmntskSnmVWE++KAH95q7JfWe7bIM0zMgM69kkTF86iX4s6sX50KCzFIbqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkBG8gHP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkBG8gHP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D061F000C5;
	Wed, 14 Oct 2026 14:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791988969;
	bh=A3im49CDnoc9xp/vAu5H5MYocPSMLiaxQIaDGWhlQJA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=NkBG8gHPUwmYHY5vRgo/s0il6ye68iysLWwZ7NU7f/6Pwn1ZhfotE8cnLkq63galb
	 vFxVAaBRjqNxZZBLIEHhu4hRikJCthK2JbSI2pKD5NqTv7qoeezQLYbw8zWzSS2MNa
	 WLYwkbUxfQHgEiOdpbUBuPFZ+iLgaIrh64xai0yR1neT/Ru8gXFJf+QjXcvjTJNXJ0
	 TaSr4ruv/zKlmcbY29yuNRkdnChc1wBUdlZ7X5+I8lr6wBkqWVogLeJayiqULYiBmv
	 YrHOblVn/ATfjleRs+ilhdl3GLoxn4jeO0WPy7qlAcY7k0pFyF9JceIB8/US+9cOB7
	 U+sZ3XMvnH4IQ==
Message-ID: <sashiko-outbox-171440@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH mptcp-next v3 1/3] selftests: mptcp: connect: retry
 write() on EAGAIN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anil Kaushik" <anilkaushikwireless@gmail.com>, mptcp@lists.linux.dev
In-Reply-To: <20261014143349.768138-2-anilkaushikwireless@gmail.com>
References: <20261014143349.768138-1-anilkaushikwireless@gmail.com>
 <20261014143349.768138-2-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 14:42:48 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests: mptcp_connect fails on EAGAIN when poll_timeout is in=
finite
--

commit c4cb29705a0b8f55f650eb00f7f218f1708de879
Author: Anil Kaushik <anilkaushikwireless@gmail.com>

selftests: mptcp: connect: retry write() on EAGAIN

mptcp_connect treats any write() error as fatal. But write() can fail
with EAGAIN even after poll() said the socket was writable: the MPTCP
send buffer shrinks when a subflow is closed.

> diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/te=
sting/selftests/net/mptcp/mptcp_connect.c
> index 178d98d91fea2..03fff859e4d1d 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
[ ... ]
> @@ -711,6 +712,20 @@ static int copyfd_io_poll(int infd, int peerfd, int =
outfd,
> =20
>  				bw =3D do_rnd_write(peerfd, winfo->buf + winfo->off, winfo->len);
>  				if (bw < 0) {
> +					/* POLLOUT does not guarantee that
> +					 * the next write will not block:
> +					 * the MPTCP send buffer can shrink
> +					 * in between, e.g. when a subflow
> +					 * is closed. Wait for more space,
> +					 * but not forever: poll() does not
> +					 * check every cause of EAGAIN.
> +					 */
> +					if (errno =3D=3D EAGAIN &&
> +					    ++eagain_ms <=3D poll_timeout) {
                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^
[Severity: Medium]
Will this condition incorrectly abort the test immediately if poll_timeout
is set to -1 (infinite timeout)?

If the tool is invoked with a timeout of 0 or less (e.g., -t 0), poll_timeo=
ut
is set to -1. When write() returns EAGAIN, the new condition evaluates to
1 <=3D -1, which is false. This bypasses the intended retry logic, immediat=
ely
failing the transfer instead of waiting.

I noticed a similar issue in the preexisting code in xdisconnect():

tools/testing/selftests/net/mptcp/mptcp_connect.c:xdisconnect() {
	...
	for (i =3D 0; ; i +=3D msec_sleep) {
		/* closed socket are not listed by 'ss' */
		if (system(cmd) !=3D 0)
			break;

		if (i > poll_timeout)
			xerror("timeout while waiting for spool to complete");
		usleep(msec_sleep * 1000);
	}
	...
}

Does this code also incorrectly assume poll_timeout is positive, causing an
immediate crash if poll_timeout is -1?

> +						usleep(1000);
> +						continue;
> +					}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014143349.7681=
38-1-anilkaushikwireless@gmail.com?part=3D1
