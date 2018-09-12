Content-Type: multipart/mixed; boundary="===============2705324116059171148=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 0/2] Forward-ports from mptcp_trunk
Date: Wed, 12 Sep 2018 15:18:32 -0700
Message-ID: <alpine.OSX.2.21.1809121517580.87152@sarafals-mobl4.amr.corp.intel.com>
In-Reply-To: 20180912181640.6663-1-cpaasch@apple.com
X-Status: 
X-Keywords:                  
X-UID: 719

--===============2705324116059171148==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 12 Sep 2018, Christoph Paasch wrote:

> Christoph Paasch (1):
>  mptcp: Iterate over subflow-list while holding the lock in
>    tcp_splice_read
>
> Patrick Havelange (1):
>  mptcp: avoid removing useful skbs from the reinject queue.
>
> net/ipv4/tcp.c           | 15 ++++++++-------
> net/mptcp/mptcp_output.c |  3 +++
> 2 files changed, 11 insertions(+), 7 deletions(-)
>

Thanks Christoph, I've applied these and pushed to mptcp_net-next/master.

--
Mat Martineau
Intel OTC

--===============2705324116059171148==--
