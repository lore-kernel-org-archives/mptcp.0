Content-Type: multipart/mixed; boundary="===============4977130499285837682=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next 0/5] add add_addr_urgent
Date: Tue, 19 Jan 2021 12:30:43 +0800
Message-ID: <CA+WQbwtbk93bomYkMQX3Voqn5fzZ6ePh1=Pw8T=Y+aXy591VFw@mail.gmail.com>
In-Reply-To: dd1e41b55fe1b19993118f007d84463d39cb417c.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7420

--===============4977130499285837682==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat, Paolo,

Paolo Abeni <pabeni(a)redhat.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=8818=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=884:53=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, 2021-01-15 at 16:49 -0800, Mat Martineau wrote:
> > On Wed, 6 Jan 2021, Geliang Tang wrote:
> >
> > > This patchset addresses the ADD_ADDR timeout issue, the failure output
> > > looks like this:
> > >
> > > 12 signal address, ADD_ADDR timeout  syn[ ok ] - synack[ ok ] - ack[ =
ok ]
> > >                                     add[fail] got 2 ADD_ADDR[s] expec=
ted 4
> > >  - echo  [ ok ]
> > > Server ns stats
> > > MPTcpExtMPCapableSYNRX          1               0.0
> > > MPTcpExtMPCapableACKRX          1               0.0
> > > MPTcpExtMPJoinSynRx             1               0.0
> > > MPTcpExtMPJoinAckRx             1               0.0
> > > Client ns stats
> > > MPTcpExtMPJoinSynAckRx          1               0.0
> > > MPTcpExtAddAddr                 2               0.0
> > > 13 remove single subflow             syn[ ok ] - synack[ ok ] - ack[ =
ok ]
> > >                                      rm [ ok ] - sf    [ ok ]
> > >
> > > The tasecase needs to send out 4 ADD_ADDR packets in the test process=
, it's
> > > about 22 round trips when we use 'slow' argument in the testcase.
> > >
> > > If we can't send out all the 4 ADD_ADDR packets, the testcase will fa=
il.
> > > Here in the failure case, we only sent out 2 ADD_ADDRs.
> > >
> > > But the ADD_ADDR packet cannot sent out immediately, we need to find =
out a
> > > packet with enough option length space to put in the ADD_ADDR subopti=
on.
> > > So we need to try several times before we can find a suitable packet =
to
> > > sent out a ADD_ADDR suboption.
> > >
> > > I added the following test code to count the ADD_ADDR trying times:
> > >
> > > ---
> > > @@ -233,6 +233,7 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u=
8 bkup)
> > >
> > >  /* path manager helpers */
> > >
> > > +static int times =3D 1;
> > >  bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int r=
emaining,
> > >                               struct mptcp_addr_info *saddr, bool *ec=
ho, bool *port)
> > >  {
> > > @@ -247,11 +248,14 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock=
 *msk, unsigned int remaining,
> > >         *echo =3D mptcp_pm_should_add_signal_echo(msk);
> > >         *port =3D mptcp_pm_should_add_signal_port(msk);
> > >
> > > -       if (remaining < mptcp_add_addr_len(msk->pm.local.family, *ech=
o, *port))
> > > +       if (remaining < mptcp_add_addr_len(msk->pm.local.family, *ech=
o, *port)) {
> > > +               pr_debug("%s remaining=3D%u times=3D%d\n", __func__, =
remaining, times++);
> > >                 goto out_unlock;
> > > +       }
> > >
> > >         *saddr =3D msk->pm.local;
> > >         WRITE_ONCE(msk->pm.addr_signal, 0);
> > > +       times =3D 1;
> > >         ret =3D true;
> > >
> > >  out_unlock:
> > > ---
> > >
> > > Then I found that when the ADD_ADDR timeout testcase failed, it had t=
ried
> > > about 20 times to send out the ADD_ADDR. And here the test transmit p=
rocess
> > > ended, so the last two ADD_ADDRs had no chance to be send out.
> >
> > In your tests, was it clear what other options were taking the space and
> > preventing ADD_ADDR from being sent?
> >

In my test, DSS is taking the space and preventing ADD_ADDR from being sent.

> >
> > > We have three solutions to fix this issue:
> > >
> > > 1. Make the test transmit process more slowly.
> > > 2. Make the transmit data biger.
> > > 3. Make the ADD_ADDR suboption transmit faster.
> > >
> > > The first 2 solutions can partly solve the issue, it makes more round=
 trips
> > > in the tranmit process, and all 4 ADD_ADDRs had more chance to be sen=
d out.
> > > But in some cases, the issue is still there.
> > >
> > > So I chose the last sulution to fix the issue. This patchset adds the=
 urgent
> > > status for ADD_ADDR, to make sure the ADD_ADDR can be sent out immedi=
ately.
> >
> > ADD_ADDR would mostly be used on longer-lived connections (if I'm mista=
ken
> > about this, please educate me!), especially adding multiple addresses.
> > Given that, I don't think the special case code and a new sysctl are the
> > way this should be solved to make a quick test work.
> >
> > What if mptcp_pm_should_add_signal_send_ack() returned true whenever any
> > ADD_ADDR was pending - not just when ipv6 addresses or port numbers are
> > included?
>
> I'm sorry for late feedback.
>
> I agree with Mat: I think it would be better avoding adding any special
> code here. I think dup acks would be acceptable, as ADD_ADDR will be
> not so frequent events.
>
> So let mptcp_pm_should_add_signal_send_ack() return true looks a
> suitable solution to me. Since mptcp_pm_should_add_signal_send_ack() is
> invoked only with ADD_ADDR pending, the code could additional
> simplified even dropping such function call -> always go ahead and send
> the ack.
>

Thanks for your advice, I'll improve this patchset this week.

-Geliang

> Cheers,
>
> Paolo
>
--===============4977130499285837682==--
