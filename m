Content-Type: multipart/mixed; boundary="===============0055675881290859415=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: Question about running mPTCP in kernel 5.0
Date: Fri, 19 Jun 2020 17:18:28 +0200
Message-ID: <b2199e49-d711-8fbd-fcc2-e357f08aafb3@tessares.net>
In-Reply-To: CAD3NH5WtOhWb7oK=jMuwi_ZmAfFGx0VeOm+cCWOXLpjx+WbJ_Q@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 4752

--===============0055675881290859415==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On 19/06/2020 15:42, Dani Camps wrote:
> Dear all,
> =

> Apologies if this is not the appropriate forum for this question.

There are currently two implementations of MPTCP in the Linux kernel:

  - An out-of-tree kernel described in https://www.multipath-tcp.org
    Mailing list: mptcp-dev(a)listes.uclouvain.be

  - An upstream version, the work is in progress since v5.6:
    Info: https://github.com/multipath-tcp/mptcp_net-next/wiki
    Mailing list: mptcp(a)lists.01.org

I guess you are interested here in the out-of-tree kernel. Better to ask =

the question on the other list.

> I have a machine running Kernel=C2=A05.0.0-23-generic. I am interested in =

> running=C2=A0MPTCP on it. I have seen the implementation in =

> https://www.multipath-tcp.org/, but I understand=C2=A0this is a full kern=
el =

> 4.1 modified for MPTCP.

This out-of-tree kernel only supports LTS versions of the kernel, =

typically the two last ones. So the v5.0.0 kernel is not supported. But =

packages are available for other kernel versions.

> Is there any implementation available that can be compiled into a module =

> for kernel 5.0?

I don't think so. Probably the best is to switch to another kernel: v5.7 =

(upstream) or 4.19 (out-of-tree)

If you are interested by the out-of-tree kernel, please continue the =

discussion on the other list.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0055675881290859415==--
