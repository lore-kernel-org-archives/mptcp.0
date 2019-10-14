Content-Type: multipart/mixed; boundary="===============2374774258665445808=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 0/3] mptcp: just another recvmsg refactor
Date: Mon, 14 Oct 2019 16:42:39 -0700
Message-ID: <alpine.OSX.2.21.1910141640110.18802@ntadesse-mobl.amr.corp.intel.com>
In-Reply-To: cover.1570834035.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2131

--===============2374774258665445808==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, 13 Oct 2019, Paolo Abeni wrote:

> This start constructing the instrucutre to support pulling data from
> multiple subflow. At the current stage uses a very simply approach, dropp=
ing
> any out-of-order data and reading from any subflow with valid data.
>
> The above should work quite nicely in active backup scenario and possibly
> even with multiple subflows sending data concurrently - with a low bwidth=
 and
> a huge number of retransmissions.
>
> This is a not_so_early draft, shared as it may pave some ground and/or
> partially overlap with DATA_FIN support effort
>

It definitely overlaps with the DATA_FIN changes, but please keep moving =

ahead. I will rebase my DATA_FIN work on your refactored code.

Mat


> Note that this rewrite completely the recvmsg() main loop to mirror more =
closely
> the TCP recvmsg() main loop, likely fixing some bug in respect to signal =
and
> error condition handling.
>
> Paolo Abeni (3):
>  mptcp: move some helper into the header file
>  mptcp: flush duplicate data at data_ready() time
>  mptcp: recvmsg() can drain data from multiple subflows
>
> net/mptcp/protocol.c | 360 +++++++++++++------------------------------
> net/mptcp/protocol.h |  31 +++-
> net/mptcp/subflow.c  | 270 +++++++++++++++++++++++++++++++-
> 3 files changed, 403 insertions(+), 258 deletions(-)
>
> -- =

> 2.21.0
>
>

--
Mat Martineau
Intel
--===============2374774258665445808==--
