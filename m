Content-Type: multipart/mixed; boundary="===============2451242650831289637=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next] mptcp: add
 mptcp_pm_should_add_signal_echo helper
Date: Fri, 30 Oct 2020 11:31:07 +0800
Message-ID: <CA+WQbwsf_xtkomfVvGdEsGrvHPWfdMkYbkTp0m+WNt4EUSsHzw@mail.gmail.com>
In-Reply-To: acdace46-c5d0-614d-566-4e0d4f2cf7a@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6484

--===============2451242650831289637==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2020=E5=B9=B4=
10=E6=9C=8830=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=888:03=E5=86=99=E9=
=81=93=EF=BC=9A
>
>
> On Thu, 29 Oct 2020, Geliang Tang wrote:
>
> > This patch added a new helper mptcp_pm_should_add_signal_echo.
> >
> > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > ---
> > net/mptcp/pm.c       | 2 +-
> > net/mptcp/protocol.h | 5 +++++
> > 2 files changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > index 83f59a428560..75c5040e8d5d 100644
> > --- a/net/mptcp/pm.c
> > +++ b/net/mptcp/pm.c
> > @@ -198,7 +198,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *ms=
k, unsigned int remaining,
> >       if (!mptcp_pm_should_add_signal(msk))
> >               goto out_unlock;
> >
> > -     *echo =3D READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR=
_ECHO);
> > +     *echo =3D mptcp_pm_should_add_signal_echo(msk);
> >
> >       if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo))
> >               goto out_unlock;
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 7a5c16f176c0..d29c6a4749eb 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -529,6 +529,11 @@ static inline bool mptcp_pm_should_add_signal(stru=
ct mptcp_sock *msk)
> >       return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_SI=
GNAL);
> > }
> >
> > +static inline bool mptcp_pm_should_add_signal_echo(struct mptcp_sock *=
msk)
> > +{
> > +     return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_EC=
HO);
> > +}
> > +
> > static inline bool mptcp_pm_should_add_signal_ipv6(struct mptcp_sock *m=
sk)
> > {
> >       return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_IP=
V6);
> > --
> > 2.26.2
>
> Thanks for the cleanup
>
> Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

Thanks for your review.

I think it is better to squash this patch to the original commit
"mptcp: change add_addr_signal type". So I just sent out a new
version of it to ML as:

[PATCH v2 mptcp-next] Squash to "mptcp: change add_addr_signal type"

-Geliang

>
> --
> Mat Martineau
> Intel
--===============2451242650831289637==--
