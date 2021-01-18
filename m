Content-Type: multipart/mixed; boundary="===============4370211259643038622=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next 0/5] add add_addr_urgent
Date: Mon, 18 Jan 2021 09:53:28 +0100
Message-ID: <dd1e41b55fe1b19993118f007d84463d39cb417c.camel@redhat.com>
In-Reply-To: 11311aac-8b23-e74-832-f315d0bf35e6@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7416

--===============4370211259643038622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-01-15 at 16:49 -0800, Mat Martineau wrote:
> On Wed, 6 Jan 2021, Geliang Tang wrote:
> =

> > This patchset addresses the ADD_ADDR timeout issue, the failure output
> > looks like this:
> > =

> > 12 signal address, ADD_ADDR timeout  syn[ ok ] - synack[ ok ] - ack[ ok=
 ]
> >                                     add[fail] got 2 ADD_ADDR[s] expecte=
d 4
> >  - echo  [ ok ]
> > Server ns stats
> > MPTcpExtMPCapableSYNRX          1               0.0
> > MPTcpExtMPCapableACKRX          1               0.0
> > MPTcpExtMPJoinSynRx             1               0.0
> > MPTcpExtMPJoinAckRx             1               0.0
> > Client ns stats
> > MPTcpExtMPJoinSynAckRx          1               0.0
> > MPTcpExtAddAddr                 2               0.0
> > 13 remove single subflow             syn[ ok ] - synack[ ok ] - ack[ ok=
 ]
> >                                      rm [ ok ] - sf    [ ok ]
> > =

> > The tasecase needs to send out 4 ADD_ADDR packets in the test process, =
it's
> > about 22 round trips when we use 'slow' argument in the testcase.
> > =

> > If we can't send out all the 4 ADD_ADDR packets, the testcase will fail.
> > Here in the failure case, we only sent out 2 ADD_ADDRs.
> > =

> > But the ADD_ADDR packet cannot sent out immediately, we need to find ou=
t a
> > packet with enough option length space to put in the ADD_ADDR suboption.
> > So we need to try several times before we can find a suitable packet to
> > sent out a ADD_ADDR suboption.
> > =

> > I added the following test code to count the ADD_ADDR trying times:
> > =

> > ---
> > @@ -233,6 +233,7 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 =
bkup)
> > =

> >  /* path manager helpers */
> > =

> > +static int times =3D 1;
> >  bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int rem=
aining,
> >                               struct mptcp_addr_info *saddr, bool *echo=
, bool *port)
> >  {
> > @@ -247,11 +248,14 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *=
msk, unsigned int remaining,
> >         *echo =3D mptcp_pm_should_add_signal_echo(msk);
> >         *port =3D mptcp_pm_should_add_signal_port(msk);
> > =

> > -       if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo,=
 *port))
> > +       if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo,=
 *port)) {
> > +               pr_debug("%s remaining=3D%u times=3D%d\n", __func__, re=
maining, times++);
> >                 goto out_unlock;
> > +       }
> > =

> >         *saddr =3D msk->pm.local;
> >         WRITE_ONCE(msk->pm.addr_signal, 0);
> > +       times =3D 1;
> >         ret =3D true;
> > =

> >  out_unlock:
> > ---
> > =

> > Then I found that when the ADD_ADDR timeout testcase failed, it had tri=
ed
> > about 20 times to send out the ADD_ADDR. And here the test transmit pro=
cess
> > ended, so the last two ADD_ADDRs had no chance to be send out.
> =

> In your tests, was it clear what other options were taking the space and =

> preventing ADD_ADDR from being sent?
> =

> =

> > We have three solutions to fix this issue:
> > =

> > 1. Make the test transmit process more slowly.
> > 2. Make the transmit data biger.
> > 3. Make the ADD_ADDR suboption transmit faster.
> > =

> > The first 2 solutions can partly solve the issue, it makes more round t=
rips
> > in the tranmit process, and all 4 ADD_ADDRs had more chance to be send =
out.
> > But in some cases, the issue is still there.
> > =

> > So I chose the last sulution to fix the issue. This patchset adds the u=
rgent
> > status for ADD_ADDR, to make sure the ADD_ADDR can be sent out immediat=
ely.
> =

> ADD_ADDR would mostly be used on longer-lived connections (if I'm mistake=
n =

> about this, please educate me!), especially adding multiple addresses. =

> Given that, I don't think the special case code and a new sysctl are the =

> way this should be solved to make a quick test work.
> =

> What if mptcp_pm_should_add_signal_send_ack() returned true whenever any =

> ADD_ADDR was pending - not just when ipv6 addresses or port numbers are =

> included?

I'm sorry for late feedback.

I agree with Mat: I think it would be better avoding adding any special
code here. I think dup acks would be acceptable, as ADD_ADDR will be
not so frequent events.

So let mptcp_pm_should_add_signal_send_ack() return true looks a
suitable solution to me. Since mptcp_pm_should_add_signal_send_ack() is
invoked only with ADD_ADDR pending, the code could additional
simplified even dropping such function call -> always go ahead and send
the ack.

Cheers,

Paolo

--===============4370211259643038622==--
