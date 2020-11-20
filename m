Content-Type: multipart/mixed; boundary="===============7642904499193580399=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 1/2] mptcp: drop
 rm_addr_signal flag
Date: Fri, 20 Nov 2020 17:47:03 +0800
Message-ID: <CA+WQbwvOFBgmFEC8w-=EdF-kjLw7qsuMxKyDVpfn3Dkj6R8Ebg@mail.gmail.com>
In-Reply-To: CA+WQbwu2neN3Btd4izJ+oP_w5-VLT2oQX3Aerner8OG9GAHkbA@mail.gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6872

--===============7642904499193580399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Geliang Tang <geliangtang(a)gmail.com> =E4=BA=8E2020=E5=B9=B411=E6=9C=8820=
=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=885:39=E5=86=99=E9=81=93=EF=BC=
=9A
>
> Hi Paolo,
>
> Paolo Abeni <pabeni(a)redhat.com> =E4=BA=8E2020=E5=B9=B411=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=885:17=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, 2020-11-19 at 17:12 -0800, Mat Martineau wrote:
> > > On Thu, 19 Nov 2020, Geliang Tang wrote:
> > >
> > > > This patch reused add_addr_signal for the RM_ADDR announce signal, =
by
> > > > defining a new add_addr status named MPTCP_RM_ADDR_SIGNAL. Then the=
 flag
> > > > rm_addr_signal in PM could be dropped.
> > > >
> > > > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > > > ---
> > > > net/mptcp/pm.c       | 22 +++++++++++++++++-----
> > > > net/mptcp/protocol.h |  4 ++--
> > > > 2 files changed, 19 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> > > > index e63e14f4cf2a..cc424222894b 100644
> > > > --- a/net/mptcp/pm.c
> > > > +++ b/net/mptcp/pm.c
> > > > @@ -18,7 +18,12 @@ int mptcp_pm_announce_addr(struct mptcp_sock *ms=
k,
> > > > {
> > > >     u8 add_addr =3D READ_ONCE(msk->pm.add_addr_signal);
> > > >
> > > > -   pr_debug("msk=3D%p, local_id=3D%d", msk, addr->id);
> > > > +   pr_debug("msk=3D%p, local_id=3D%d, add_addr=3D%d", msk, addr->i=
d, add_addr);
> > > > +
> > > > +   if (add_addr) {
> > > > +           pr_err("addr_signal error.");
> > >
> > > Hi Geliang,
> > >
> > > One minor thing, pr_err() indicates a more serious problem that a user
> > > might need to do something about. These seem like pr_warn() at most. =
There
> > > is only one pr_err() in the rest of the MPTCP code.
> >
> > Looks like the condition checked there could happen just due to some
> > bugs in the pm code, right?
> >
> > If so we could conside a WARN_ON_ONCE instead.
> >
>
> Yes, it happens just due to some bugs. I used WARN_ON_ONCE in v1, but
> WARN_ON_ONCE can trigger a kernel panic. I think we should avoid using it.
>
> > Otherwise, if is expected to enter that code path on some unusual
> > situation a pr_debug would be enough.
> >
> > You can also add the current add_addr value.

Yes, I agree with you, add the current add_addr value is much better. I'll
update it in v4.

Thanks.

-Geliang

>
> I didn't add the current add_addr value since it is printed out in the pr=
_debug
> a little bit ahead.
>
> I have sent out v3 of this patch, it use pr_warm instead of pr_err.
>
> Thanks.
>
> -Geliang
>
> >
> > /P
> >
> >
> >
--===============7642904499193580399==--
