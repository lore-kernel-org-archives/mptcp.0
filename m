Content-Type: multipart/mixed; boundary="===============5655104588033626792=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 0/7] fallback to TCP on ulp clone failure
Date: Wed, 08 Jan 2020 16:46:38 -0800
Message-ID: <alpine.OSX.2.21.2001081642200.27921@fepiepan-mobl.amr.corp.intel.com>
In-Reply-To: cover.1578487811.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3302

--===============5655104588033626792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 8 Jan 2020, Paolo Abeni wrote:

> This series do real TCP fallback for passive MPTCP connection when ULP cl=
one
> fails: clear the 'is_mptcp' flag, reset overridden callback, icsk ops and
> clear the ULP ctx.
>
> Additionally uses the 'is_mptcp' flag to check for fallback in more place=
s,
> as suggested by Mat (patches 2, 4), cope with NULL ctx in
> subflow_syn_recv_sock() (patches 3, 7), and restore TCP callback on
> later fallback, too (patch 6) for consistency.
>
> This still uses function pointers to store all the overriden TCP callback=
s,
> is simpler then other alternatives but waste some space inside the subflow
> struct.
>
> The rebased tree is available at:
>
> https://github.com/pabeni/mptcp/tree/mptcp_net-next_export_v6.2
>
> options.c  |    6 -----
> protocol.c |   16 ++++++--------
> protocol.h |   15 ++++++++++++-
> subflow.c  |   67 ++++++++++++++++++++++++++++++++++++++++---------------=
------
> 4 files changed, 67 insertions(+), 37 deletions(-)

I have one overall question about the series: do you want to use the =

sk_is_mptcp() helper throughout? The added is_mptcp checks mostly do so =

directly (tcp_sk(sk)->is_mptcp).

I sent some feedback for patches 4 & 5, the others looked ok other than =

the sk_is_mptcp() question.

--
Mat Martineau
Intel
--===============5655104588033626792==--
