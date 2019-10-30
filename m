Content-Type: multipart/mixed; boundary="===============8796469030611067610=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [Weekly meetings] MoM - 24th of October 2019
Date: Wed, 30 Oct 2019 15:18:50 +0100
Message-ID: <ae52d435a4f266c6eb458dfdeac511db4af9073e.camel@redhat.com>
In-Reply-To: a5596c73-8153-cc96-ed4e-c997201b2b20@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2355

--===============8796469030611067610==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-10-25 at 17:20 +0200, Matthieu Baerts wrote:
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

Looking at the code, it seams to me the abve does not implement/use
sha256, but it still relies on sha1 hmac.

Is the above expected? or are some patches missing?

Thanks,

Paolo=20

--===============8796469030611067610==--
