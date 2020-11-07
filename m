Content-Type: multipart/mixed; boundary="===============8609912572276250530=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 12/12] selftests: mptcp: add
 testcases for ADD_ADDR with port
Date: Fri, 06 Nov 2020 16:58:14 -0800
Message-ID: <3df41c98-f229-ff85-8f8-6e3b71c2dab3@linux.intel.com>
In-Reply-To: c100d95a344b1d7afd49a1de6089d303c0ddc02a.1604562475.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6579

--===============8609912572276250530==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 5 Nov 2020, Geliang Tang wrote:

> This patch added a new argument for run_tests. When an address with a port
> number has been added, the new port number will be passed to this with_po=
rt
> argument, and then passed to do_transfer.
>
> In do_transfer, if the with_port argument is set, we need to establish a
> new connection to listen for the new port. To make sure the peer can
> connect with it using the new port.
>
> It checked the MPTcpExtPortAdd MIB counter in chk_add_nr, and added the
> testcases for ADD_ADDR with port.
>
> The output looks like this:
>
> 24 signal address with port           syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                       add[ ok ] - echo  [ ok ] - pt [ ok ]
> 25 subflow and signal with port       syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                       add[ ok ] - echo  [ ok ] - pt [ ok ]
> 26 remove single address with port    syn[ ok ] - synack[ ok ] - ack[ ok ]
>                                       add[ ok ] - echo  [ ok ] - pt [ ok ]
>                                       rm [ ok ] - sf    [ ok ]
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> .../testing/selftests/net/mptcp/mptcp_join.sh | 61 ++++++++++++++++++-
> 1 file changed, 60 insertions(+), 1 deletion(-)

I don't have any other comments on patches 4-12, thanks again for the =

series.

--
Mat Martineau
Intel
--===============8609912572276250530==--
