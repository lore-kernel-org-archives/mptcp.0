Content-Type: multipart/mixed; boundary="===============3726355811550917591=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 0/3] remove id 0 address
Date: Fri, 26 Feb 2021 17:32:31 -0800
Message-ID: <7384f8ee-5096-9611-7262-97e948e4f8a0@linux.intel.com>
In-Reply-To: cover.1614068181.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7966

--===============3726355811550917591==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 23 Feb 2021, Geliang Tang wrote:

> The RM_ADDR selftests will fail when the removing address id is 0:
>
> copyfd_io_poll: poll timed out (events: POLLIN 1, POLLOUT 0)
> copyfd_io_poll: poll timed out (events: POLLIN 1, POLLOUT 0)
> client exit code 2, server 2
>
> netns ns1-0-7z6ol9 socket stat for 10009:
> State                      Recv-Q                       Send-Q           =
                                  Local Address:Port                       =
                      Peer Address:Port                      Process
>
> netns ns2-0-7z6ol9 socket stat for 10009:
> State                       Recv-Q                   Send-Q              =
                        Local Address:Port                                 =
       Peer Address:Port                    Process
> TIME-WAIT                   0                        0                   =
                             10.0.2.2:33225                                =
           10.0.2.1:10009                    timer:(timewait,26sec,0)
>
> TIME-WAIT                   0                        0                   =
                             10.0.4.2:44309                                =
           10.0.4.1:10009                    timer:(timewait,26sec,0)
>
> TIME-WAIT                   0                        0                   =
                             10.0.3.2:53671                                =
           10.0.3.1:10009                    timer:(timewait,26sec,0)
>
> 10 flush addresses                      syn[ ok ] - synack[ ok ] - ack[ o=
k ]
>                                        add[ ok ] - echo  [ ok ]
>                                        rm [ ok ] - sf    [ ok ]
>
> This patchset fixed this bug.
>
> v2:
> - drop __mptcp_wr_shutdown in v1.
>
> apply: export/20210222T184014
>       move to next addr and testcases
>       move to next addr when timeout
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/140
>
> Geliang Tang (3):
>  mptcp: unify RM_ADDR and RM_SUBFLOW receiving
>  mptcp: skip closing the initial subsocket
>  DO-NOT-MERGE: mptcp: remove id 0 test
>
> net/mptcp/pm_netlink.c                        | 94 +++++++++----------
> .../testing/selftests/net/mptcp/mptcp_join.sh |  8 +-
> 2 files changed, 47 insertions(+), 55 deletions(-)
>
> -- =

> 2.29.2

Hi Geliang -

I ran mp_join.sh and looked at the pcap files, but didn't see that the =

initial subflow was getting closed. I uploaded an example pcap at
https://github.com/multipath-tcp/mptcp_net-next/issues/140

Is the goal of this fix only to prevent the poll timeout? What behavior =

should we see in the pcap when RM_ADDR 0 is sent & received?

--
Mat Martineau
Intel
--===============3726355811550917591==--
