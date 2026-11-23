Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428926;
	b=h3swaf+qso846rEWeaK4SgP2p9mjh4UqWdaYuBpjusYATMfEcV99pX8ASnCNdqXK7S0/
	 MsjfKLngI+Fgm057/2OFYFMc+ckRbBPRDk6mjBXp2tSW7c0ecwlLw6HB+0QLgiyVzcjeP
	 QjrsT2rPco8SXua0pihIWIy+r1c+ifUzEZKoCTjfY28r/QiFRZ7hv8QFtfwh/iPyhtjog
	 1UvyPR1eiXTJDcilR2YRLxqRXoyIGDJO/hbZBQTydXYlQLzLh4mfRoNtnqsoHV+QwALp/
	 skdAJ+D/EOnXFTI4sSKO+omdqxWPyFFLCH7sGC51yrcid8BtZlczE0lNN8GsthYQejQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428926;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SCJyN/2jjMarYv4Uq/IUmxF1WsMp7nGnirw+EdgZ81U=;
	b=QDhUlzW15WGqtU8GG/4XiMWK2vICWuqpSfu99C35vsgjERl6ApH0qwNSqBPJjc620h12
	 IGiTBUvJ/GMtu2XzmQn5gF2UxTLu1dTw5OHkhwrmSBxDeciB+6m1Ym6f3sIuMi7TqDyp/
	 yGc1dUc+HSNSJLY88fgWwr2xy8vdn6VGVIXXHnd8PUNsRokekcFaLv9TiOTE7zEHyrHe1
	 FLkCnxtxA1ACWJRm0dGddiFxl0RP9PgtVB9rhfeGEeluUnrp4Z2VR/VN1VCEcn/gHDIul
	 8uknsh6mOmaikkyMiq4CXyeKlsf4yFlQX0YOCrPBaFw0oSuZKe7nABMTjF4x/tPpPQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DER9XG+8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2904606A32D;
	Mon, 23 Nov 2026 10:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DER9XG+8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB971F000CA;
	Mon, 23 Nov 2026 10:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795428926;
	bh=SCJyN/2jjMarYv4Uq/IUmxF1WsMp7nGnirw+EdgZ81U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DER9XG+83FB6ZXEAmbi1nY0mvpjy+JE2U7gdyiWjA14SZ85JgjZEH51GndrmttwSw
	 AHn63p5QMqR1QomytvtOAbV9xn3RI7I2SghroGtyZiVwr555MgDYneGHUiMzBkuB40
	 e+ZfhapLhB3UUhBKzn7Z0YkXe2VE6/A85NYENfkUTzg7U6mTSjGANV/jzF29Eb0dw5
	 GByYmzICBKd2ZXqUkSMfG8N9uDEDf35buczPYyLUkzKgzySDL/Bf/5X7M/GCdelY5k
	 u9O47ofB1HAQNAHMmly7N3jOdmFh82l01LHxxsTKWQ2U7JieBPy6E+aPigSQaNNZro
	 m8/df/LzOaw9A==
Date: Mon, 23 Nov 2026 11:15:20 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Yingjie Wang <x-professor@outlook.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"mptcp@lists.linux.dev" <mptcp@lists.linux.dev>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"corbet@lwn.net" <corbet@lwn.net>, "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, 
	"rdunlap@infradead.org" <rdunlap@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"edumazet@kernel.org" <edumazet@kernel.org>, "ncardwell@google.com" <ncardwell@google.com>, 
	"gang.yan@linux.dev" <gang.yan@linux.dev>, "kuniyu@google.com" <kuniyu@google.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, 
	"matttbe@kernel.org" <matttbe@kernel.org>, "martineau@kernel.org" <martineau@kernel.org>, 
	"geliang@kernel.org" <geliang@kernel.org>, "ycheng@google.com" <ycheng@google.com>, 
	"weiwan@google.com" <weiwan@google.com>
Subject: Re: [PATCH net-next v4 0/2] tcp/mptcp: prevent blackhole timeout
 arithmetic wraparound
Message-ID: <awQQ_9hlOQuOZlV3@hobbes>
References: <cover.1795424546.git.x-professor@outlook.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nvwv6tlythhjs2jv"
Content-Disposition: inline
In-Reply-To: <cover.1795424546.git.x-professor@outlook.com>


--nvwv6tlythhjs2jv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH net-next v4 0/2] tcp/mptcp: prevent blackhole timeout
 arithmetic wraparound
MIME-Version: 1.0

On Mon, Nov 23, 2026 at 09:04:32AM +0000, Yingjie Wang wrote:
> The TCP Fast Open and MPTCP blackhole timeout calculations can wrap in
> 32-bit unsigned arithmetic, even on 64-bit kernels. With HZ=3D1000 and a
> 64-fold backoff, 67109 seconds becomes 8.7 seconds instead of about
> 50 days.
>=20
> Compute both delays in u64, cap them at MAX_JIFFY_OFFSET, and limit both
> initial timeout sysctls to one day. The new input limits reject values
> that were previously accepted, so this series remains for net-next and
> is not intended for stable.
>=20
> Changes since v3:
>=20
> - Drop the Fixes tags from both patches.
> - Leave the existing comments unchanged, as requested by Matthieu.
> - Combine the MPTCP arithmetic fix and input limit into one patch.
> - Name the MPTCP limit one_day_secs, as in TCP.
> - Drop Gang Yan's Reviewed-by from the combined MPTCP patch because the
>   added input limit was outside the patch he reviewed. Keep Eric's
>   Suggested-by for the MPTCP input limit.
> - Add Kuniyuki's Suggested-by for requesting a limit on the TCP sysctl.
> - Move the test notes out of the commit messages, as requested by Eric.
> - Rebase on net-next eb6d6c80d354.
>=20
> v3: https://lore.kernel.org/r/cover.1794847474.git.x-professor@outlook.com
> v2: https://lore.kernel.org/r/cover.1794672619.git.x-professor@outlook.com
> v1: https://lore.kernel.org/r/cover.1794325665.git.x-professor@outlook.com
>=20
> Testing on v4 and its unmodified base, x86-64, HZ=3D1000:
>=20
> - Loopback reproducers induced 12 blackholes with a 67109 second timeout
>   and opened another connection 10 seconds later. The base kernel
>   retried active TFO and MP_CAPABLE; v4 kept both disabled. Both probes
>   completed using TCP on v4.
> - Both sysctls accepted 0, 1, 3600, 86399 and 86400, and rejected negative
>   and above-limit values with EINVAL without changing the stored value.
>   These checks passed in the initial and a new network namespace, with
>   unchanged defaults and independent namespace values.
> - The affected objects built at each commit on x86-64 and i386 with
>   W=3D1 and KCFLAGS=3D-Werror.
>=20
> The 32-bit cap was checked by compilation and arithmetic, not at runtime.
> The TCP and MPTCP selftests were not run locally.
>=20
> Yingjie Wang (2):
>   tcp: avoid wrapping Fast Open blackhole timeout
>   mptcp: avoid wrapping blackhole timeout
>=20
>  Documentation/networking/ip-sysctl.rst    | 1 +
>  Documentation/networking/mptcp-sysctl.rst | 1 +
>  net/ipv4/sysctl_net_ipv4.c                | 1 +
>  net/ipv4/tcp_fastopen.c                   | 4 +++-
>  net/mptcp/ctrl.c                          | 6 +++++-
>  5 files changed, 11 insertions(+), 2 deletions(-)
>=20
>=20
> base-commit: eb6d6c80d35449c27471b1874f13066c09a8964d
> --=20
> 2.43.0
>=20

FYI: there is a fix for the conversion between jiffies and ms for sysctl
entries that just got merged [1] & [2]. It seems like what you are doing
here is orthogonal to that patch. I'm flagging it in case I have
misread.

Best


[1] https://lore.kernel.org/all/179531116414.1248683.10418563467755811748.p=
r-tracker-bot@kernel.org
[2] https://lore.kernel.org/all/20261118-lklm-sysctl-jiffie-ms-conv-v1-1-bb=
60e5101418@kernel.org

--nvwv6tlythhjs2jv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmsEEi8ACgkQupfNUreW
QU/ZRwv/Rk4eIcWA8V+uaZQwkww2UpSZ+dkTzNRytyEMs5tQ2KSdY8sSDtL5qhnF
BH6GGMd2HESF/O2jEWIBWOWcUk0gMJ7QXfCakE6diUQZCYCpZxnNAUe9f3G12kBI
YEPkAL1daxPu3650QorNg+HEnIaFbn5WM2l0566/xfIYJX9Powz689wobQE9GDJo
gjt0hhRBYVVwdV+G1rkiujkV/1VHeVw8ErDlcYiFOz9S0dNFFLqxcy51IyFy6VFd
MNVxC6u0MSV45gS5uI4/D7JpVahWCR/ap0tidK9jXHXxAiEV1Xph0zlv1FC5aId/
Ehv+PT4FDGyGLDzhtadCzJ6wfqwD3O8UM02BMvld3/Q2BusouUpYz3mY76wv90hG
z0HFYdO0hEGjl6lvnfRS/zIWTOBfUT1CekRpoXfBvAdLnnZvFyT7p5O+82/2yKlT
+6ql/qKRQfAChnUVfR2fRWw2MwMvQV+LLNWSyoGnpRRnTVgE86Z9lQylDob7gS0p
Ka7UWH3j
=WcIq
-----END PGP SIGNATURE-----

--nvwv6tlythhjs2jv--
