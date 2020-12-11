Content-Type: multipart/mixed; boundary="===============7987678062079863289=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v4 mptcp-next 0/2] mptcp: add the address
 ID assignment bitmap and testcases
Date: Thu, 10 Dec 2020 16:28:07 -0800
Message-ID: <b8e6fe97-54ce-cd81-904d-898e503222b@linux.intel.com>
In-Reply-To: cover.1607500712.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7139

--===============7987678062079863289==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 9 Dec 2020, Geliang Tang wrote:

> v4:
> - update the find_next code

v4 looks good for the export branch based on code review and running =

tests. Thanks Geliang!

Mat


>
> v3:
> - call find_next_zero_bit() again for the invalid id.
> - use "for (i =3D id; ..." in mptcp_nl_cmd_dump_addrs.
> - add a wrap around testcase.
>
> v2:
> - use BITS_PER_LONG macro.
> - add back the callback argument in cmd_dump_addrs.
> - add a testcase.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/117
>
> Geliang Tang (2):
>  mptcp: add the address ID assignment bitmap
>  selftests: mptcp: add testcases for setting the address ID
>
> net/mptcp/pm_netlink.c                        | 71 ++++++++++++++-----
> .../testing/selftests/net/mptcp/pm_netlink.sh | 41 ++++++++++-
> 2 files changed, 92 insertions(+), 20 deletions(-)
>
> -- =

> 2.26.2

--
Mat Martineau
Intel
--===============7987678062079863289==--
