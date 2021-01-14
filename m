Content-Type: multipart/mixed; boundary="===============2169116494178359796=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [MPTCP][PATCH v2 mptcp-next 0/5] add add_addr_urgent
Date: Thu, 14 Jan 2021 13:40:18 +0800
Message-ID: <cover.1610602400.git.geliangtang@gmail.com>
X-Status: 
X-Keywords:                  
X-UID: 7368

--===============2169116494178359796==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

v2:
 - rebase on export/20210113T185637
 - please apply this patchset after the following patchsets:
    add IPv4-mapped address support (v5)
    mptcp: create subflow for newly added address and testcases (v5)
    ADD_ADDR: ports support (v10)
    selftests: mptcp: add command line arguments for mptcp_join.sh (v2)
 =

v1:

This patchset addresses the ADD_ADDR timeout issue, the failure output
looks like this:

 12 signal address, ADD_ADDR timeout  syn[ ok ] - synack[ ok ] - ack[ ok ]
                                     add[fail] got 2 ADD_ADDR[s] expected 4
  - echo  [ ok ]
 Server ns stats
 MPTcpExtMPCapableSYNRX          1               0.0
 MPTcpExtMPCapableACKRX          1               0.0
 MPTcpExtMPJoinSynRx             1               0.0
 MPTcpExtMPJoinAckRx             1               0.0
 Client ns stats
 MPTcpExtMPJoinSynAckRx          1               0.0
 MPTcpExtAddAddr                 2               0.0
 13 remove single subflow             syn[ ok ] - synack[ ok ] - ack[ ok ]
                                      rm [ ok ] - sf    [ ok ]

The tasecase needs to send out 4 ADD_ADDR packets in the test process, it's
about 22 round trips when we use 'slow' argument in the testcase.

If we can't send out all the 4 ADD_ADDR packets, the testcase will fail.
Here in the failure case, we only sent out 2 ADD_ADDRs.

But the ADD_ADDR packet cannot sent out immediately, we need to find out a
packet with enough option length space to put in the ADD_ADDR suboption.
So we need to try several times before we can find a suitable packet to
sent out a ADD_ADDR suboption.

I added the following test code to count the ADD_ADDR trying times:

---
 @@ -233,6 +233,7 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bku=
p)

  /* path manager helpers */

 +static int times =3D 1;
  bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int remain=
ing,
                               struct mptcp_addr_info *saddr, bool *echo, b=
ool *port)
  {
 @@ -247,11 +248,14 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk=
, unsigned int remaining,
         *echo =3D mptcp_pm_should_add_signal_echo(msk);
         *port =3D mptcp_pm_should_add_signal_port(msk);

 -       if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo, *p=
ort))
 +       if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo, *p=
ort)) {
 +               pr_debug("%s remaining=3D%u times=3D%d\n", __func__, remai=
ning, times++);
                 goto out_unlock;
 +       }

         *saddr =3D msk->pm.local;
         WRITE_ONCE(msk->pm.addr_signal, 0);
 +       times =3D 1;
         ret =3D true;

  out_unlock:
---

Then I found that when the ADD_ADDR timeout testcase failed, it had tried
about 20 times to send out the ADD_ADDR. And here the test transmit process
ended, so the last two ADD_ADDRs had no chance to be send out.

We have three solutions to fix this issue:

1. Make the test transmit process more slowly.
2. Make the transmit data biger.
3. Make the ADD_ADDR suboption transmit faster.

The first 2 solutions can partly solve the issue, it makes more round trips
in the tranmit process, and all 4 ADD_ADDRs had more chance to be send out.
But in some cases, the issue is still there.

So I chose the last solution to fix the issue. This patchset adds the urgent
status for ADD_ADDR, to make sure the ADD_ADDR can be sent out immediately.


Geliang Tang (5):
  mptcp: add mptcp_pm_should_add_signal_send_ack helper
  mptcp: simplify mptcp_pm_nl_add_addr_send_ack debug log
  mptcp: add a new sysctl add_addr_urgent
  mptcp: add urgent status for ADD_ADDR
  selftests: mptcp: add add_addr_urgent testcases

 Documentation/networking/mptcp-sysctl.rst     |  8 ++++++
 net/mptcp/ctrl.c                              | 14 ++++++++++
 net/mptcp/options.c                           |  3 +-
 net/mptcp/pm.c                                |  5 ++--
 net/mptcp/pm_netlink.c                        | 13 ++++++---
 net/mptcp/protocol.h                          | 14 ++++++++++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 28 +++++++++++++++++++
 7 files changed, 77 insertions(+), 8 deletions(-)

-- =

2.29.2

--===============2169116494178359796==--
