Content-Type: multipart/mixed; boundary="===============8773876461836944403=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next 0/5] add add_addr_urgent
Date: Fri, 15 Jan 2021 16:49:18 -0800
Message-ID: <11311aac-8b23-e74-832-f315d0bf35e6@linux.intel.com>
In-Reply-To: cover.1609925558.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7402

--===============8773876461836944403==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Jan 2021, Geliang Tang wrote:

> This patchset addresses the ADD_ADDR timeout issue, the failure output
> looks like this:
>
> 12 signal address, ADD_ADDR timeout  syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                     add[fail] got 2 ADD_ADDR[s] expected 4
>  - echo  [ ok ]
> Server ns stats
> MPTcpExtMPCapableSYNRX          1               0.0
> MPTcpExtMPCapableACKRX          1               0.0
> MPTcpExtMPJoinSynRx             1               0.0
> MPTcpExtMPJoinAckRx             1               0.0
> Client ns stats
> MPTcpExtMPJoinSynAckRx          1               0.0
> MPTcpExtAddAddr                 2               0.0
> 13 remove single subflow             syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                      rm [ ok ] - sf    [ ok ]
>
> The tasecase needs to send out 4 ADD_ADDR packets in the test process, it=
's
> about 22 round trips when we use 'slow' argument in the testcase.
>
> If we can't send out all the 4 ADD_ADDR packets, the testcase will fail.
> Here in the failure case, we only sent out 2 ADD_ADDRs.
>
> But the ADD_ADDR packet cannot sent out immediately, we need to find out a
> packet with enough option length space to put in the ADD_ADDR suboption.
> So we need to try several times before we can find a suitable packet to
> sent out a ADD_ADDR suboption.
>
> I added the following test code to count the ADD_ADDR trying times:
>
> ---
> @@ -233,6 +233,7 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bk=
up)
>
>  /* path manager helpers */
>
> +static int times =3D 1;
>  bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remai=
ning,
>                               struct mptcp_addr_info *saddr, bool *echo, =
bool *port)
>  {
> @@ -247,11 +248,14 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *ms=
k, unsigned int remaining,
>         *echo =3D mptcp_pm_should_add_signal_echo(msk);
>         *port =3D mptcp_pm_should_add_signal_port(msk);
>
> -       if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo, *=
port))
> +       if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo, *=
port)) {
> +               pr_debug("%s remaining=3D%u times=3D%d\n", __func__, rema=
ining, times++);
>                 goto out_unlock;
> +       }
>
>         *saddr =3D msk->pm.local;
>         WRITE_ONCE(msk->pm.addr_signal, 0);
> +       times =3D 1;
>         ret =3D true;
>
>  out_unlock:
> ---
>
> Then I found that when the ADD_ADDR timeout testcase failed, it had tried
> about 20 times to send out the ADD_ADDR. And here the test transmit proce=
ss
> ended, so the last two ADD_ADDRs had no chance to be send out.

In your tests, was it clear what other options were taking the space and =

preventing ADD_ADDR from being sent?


> We have three solutions to fix this issue:
>
> 1. Make the test transmit process more slowly.
> 2. Make the transmit data biger.
> 3. Make the ADD_ADDR suboption transmit faster.
>
> The first 2 solutions can partly solve the issue, it makes more round tri=
ps
> in the tranmit process, and all 4 ADD_ADDRs had more chance to be send ou=
t.
> But in some cases, the issue is still there.
>
> So I chose the last sulution to fix the issue. This patchset adds the urg=
ent
> status for ADD_ADDR, to make sure the ADD_ADDR can be sent out immediatel=
y.

ADD_ADDR would mostly be used on longer-lived connections (if I'm mistaken =

about this, please educate me!), especially adding multiple addresses. =

Given that, I don't think the special case code and a new sysctl are the =

way this should be solved to make a quick test work.

What if mptcp_pm_should_add_signal_send_ack() returned true whenever any =

ADD_ADDR was pending - not just when ipv6 addresses or port numbers are =

included?


Mat


>
>
> Geliang Tang (5):
>  mptcp: add mptcp_pm_should_add_signal_send_ack helper
>  mptcp: simplify mptcp_pm_nl_add_addr_send_ack debug log
>  mptcp: add a new sysctl add_addr_urgent
>  mptcp: add urgent status for ADD_ADDR
>  selftests: mptcp: add add_addr_urgent testcases
>
> Documentation/networking/mptcp-sysctl.rst     |  8 ++++++
> net/mptcp/ctrl.c                              | 14 ++++++++++
> net/mptcp/options.c                           |  3 +-
> net/mptcp/pm.c                                |  5 ++--
> net/mptcp/pm_netlink.c                        | 13 ++++++---
> net/mptcp/protocol.h                          | 14 ++++++++++
> .../testing/selftests/net/mptcp/mptcp_join.sh | 28 +++++++++++++++++++
> 7 files changed, 77 insertions(+), 8 deletions(-)
>
> -- =

> 2.29.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============8773876461836944403==--
