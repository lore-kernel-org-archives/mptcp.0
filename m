Content-Type: multipart/mixed; boundary="===============1704275301377994938=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 24th of October 2019
Date: Sat, 26 Oct 2019 11:59:00 +0200
Message-ID: <8f862de7f6e61bbc5239c041fcc9777312bba2cf.camel@redhat.com>
In-Reply-To: a5596c73-8153-cc96-ed4e-c997201b2b20@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2337

--===============1704275301377994938==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-10-25 at 17:20 +0200, Matthieu Baerts wrote:
> Hi Paolo,
> =

> On 25/10/2019 09:53, Matthieu Baerts wrote:
> >      - MPTCP v1 support =E2=86=92 part 2:
> >          - Paolo started to look at the RFC to support Christoph
> >          - Christoph will be the submitter of the patch
> >          - *Matth*: publish a branch with mptcp.org + MPTCPv1
> =

> I didn't have a lot of time to look at it but you can find mptcp.org =

> kernel with Christoph patches (and a small fix) to support MPTCPv1 on my =

> Github account:
> =

>      https://github.com/matttbe/mptcp_net-next/tree/mptcp_v0.95_mptcp_v1
>      https://github.com/matttbe/mptcp_net-next/tree/mptcp_trunk_mptcp_v1
> =

> I would recommend to use the branch based on mptcp_v0.95 (last upstream =

> LTS, v4.19.55).
> =

> Before testing, don't forget to set:
> =

>      sysctl net.mptcp.mptcp_version=3D1
>      sysctl net.mptcp.mptcp_enabled=3D1

Thank you very much, the above will help!

> So far, I *think* the establishment of the connection is OK (SYN, =

> SYN+ACK, ACK) but not after: it seems the first data packet has bad =

> options. I would need to look more to understand why.

Do you see connection/test failures, or is just the wireshark dissector
output? Note that wireshark can't currently correctly dissect mptcp v1
MP_CAPABLE ACK option with data_len and/or checksum - it's a wireshark
bug/missing feature

Cheers,

Paolo

--===============1704275301377994938==--
