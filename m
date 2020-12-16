Content-Type: multipart/mixed; boundary="===============5655726617442493047=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v4 mptcp-next 0/2] mptcp: add the address
 ID assignment bitmap and testcases
Date: Wed, 16 Dec 2020 22:47:34 +0100
Message-ID: <c7630e6c-e9bf-fc8d-9887-49cac22e0328@tessares.net>
In-Reply-To: cover.1607500712.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7196

--===============5655726617442493047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Mat,

On 09/12/2020 09:04, Geliang Tang wrote:
> v4:
>   - update the find_next code
> =

> v3:
>   - call find_next_zero_bit() again for the invalid id.
>   - use "for (i =3D id; ..." in mptcp_nl_cmd_dump_addrs.
>   - add a wrap around testcase.
> =

> v2:
>   - use BITS_PER_LONG macro.
>   - add back the callback argument in cmd_dump_addrs.
>   - add a testcase.

Thank you for the patches and the reviews!

Just added in our tree, with Mat's Reviewed-by tags!

- f4b03aa16214: mptcp: add the address ID assignment bitmap
- 6636ac3e5e80: selftests: mptcp: add testcases for setting the address ID
- edac8433efa9: "squashed" in "mptcp: add the address ID assignment bitmap"

Tests + export are going to be started soon

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/117

Thanks for the link!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============5655726617442493047==--
