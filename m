Content-Type: multipart/mixed; boundary="===============1088034266895688466=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 0/3] mptcp: move MPTCP option bits to internal
 header
Date: Thu, 20 Jun 2019 09:47:30 -0700
Message-ID: <alpine.OSX.2.21.1906200946330.44348@kdmease-mobl.amr.corp.intel.com>
In-Reply-To: 20190620141355.17923-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1435

--===============1088034266895688466==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 20 Jun 2019, Matthieu Baerts wrote:

> All these OPTION_MPTCP_* are only used in files from net/mptcp.
>
> There are 3 commits to ease the squash.
>
> Matthieu Baerts (3):
>  mptcp: move MPTCP option bits to internal header
>  mptcp: move MPTCP option bits to internal header
>  mptcp: move MPTCP option bits to internal header
>
> include/net/mptcp.h  | 11 -----------
> net/mptcp/protocol.h | 12 ++++++++++++
> 2 files changed, 12 insertions(+), 11 deletions(-)
> -- =

> 2.20.1
>

I'm fine with moving all of these.

Thanks,

--
Mat Martineau
Intel

--===============1088034266895688466==--
