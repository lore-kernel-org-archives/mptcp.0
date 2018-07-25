Content-Type: multipart/mixed; boundary="===============6102521973163776148=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 0/2] Forward-ports from mptcp_trunk
Date: Wed, 25 Jul 2018 15:56:37 -0700
Message-ID: <alpine.OSX.2.21.1807251555450.39875@asadovni-mobl3.amr.corp.intel.com>
In-Reply-To: 20180724234940.62909-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 688

--===============6102521973163776148==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 24 Jul 2018, Christoph Paasch wrote:

> Two of the recent additions to mptcp_trunk.
>
> Christoph Paasch (2):
>  mptcp: Fix: Correct version-negotiation when SYN-cookies are set
>  mptcp: Disable MPTCP when interface is non-MPTCP
>
> include/net/mptcp.h    |  6 +++---
> net/mptcp/mptcp_ctrl.c | 29 +++++++++++++++++++++--------
> 2 files changed, 24 insertions(+), 11 deletions(-)

Both applied.


Thanks,

--
Mat Martineau
Intel OTC

--===============6102521973163776148==--
