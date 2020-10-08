Content-Type: multipart/mixed; boundary="===============0144072285786638630=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [mptcp-dev] mptcp code in kernel 5.8
Date: Thu, 08 Oct 2020 11:28:24 -0700
Message-ID: <20201008182824.GB34635@MacBook-Pro.local>
In-Reply-To: CAO=PVE8JUAg8An96p0VVjL0GdVEd97hH27mpBGjUbq95j317HA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6250

--===============0144072285786638630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

+MPTCP upstreaming list

Hello Yoshi,

On 10/08/20 - 01:44, yoshi nishida wrote:
> Hello,
> =

> It's really great to see mptcp codes in main stream.  So, I've tried
> to use it with kernel 5.8 in ubuntu20.10.
> However, as far as I've checked, the mptcp in the kernel seems to be
> different from the one in the repo.

The repo, you mean the repo of multipath-tcp.org kernel? Yes, they are
entirely different. The MPTCP implementation in upstream Linux (5.6+) is a
complete rewrite.

> I am not sure how to set scheduler
> or path manager with this.

It is currently not possible to select different schedulers on the upstream
implementation.

For path-management there is an ip-mptcp interface that allows you to add
subflows and addresses: https://man7.org/linux/man-pages/man8/ip-mptcp.8.ht=
ml


Christoph

> Does anyone know about the differences?
> Sorry if I overlooked something.
> =

> Thanks,
> --
> Yoshi

> MPTCP-developpers Mailing-List
> Visit http://multipath-tcp.org to access the source-code of MPTCP in the =
Linux Kernel
> =

> To Unsubscribe, visit https://listes-2.sipr.ucl.ac.be/sympa/info/mptcp-dev
>=20

--===============0144072285786638630==--
