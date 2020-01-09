Content-Type: multipart/mixed; boundary="===============5021706746284258815=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 0/7] fallback to TCP on ulp clone failure
Date: Thu, 09 Jan 2020 09:30:36 +0100
Message-ID: <d998dabc54a73bfda984d3f5ecccf78b56cf409d.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.2001081642200.27921@fepiepan-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3306

--===============5021706746284258815==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-01-08 at 16:46 -0800, Mat Martineau wrote:
> On Wed, 8 Jan 2020, Paolo Abeni wrote:
> =

> > This series do real TCP fallback for passive MPTCP connection when ULP =
clone
> > fails: clear the 'is_mptcp' flag, reset overridden callback, icsk ops a=
nd
> > clear the ULP ctx.
> > =

> > Additionally uses the 'is_mptcp' flag to check for fallback in more pla=
ces,
> > as suggested by Mat (patches 2, 4), cope with NULL ctx in
> > subflow_syn_recv_sock() (patches 3, 7), and restore TCP callback on
> > later fallback, too (patch 6) for consistency.
> > =

> > This still uses function pointers to store all the overriden TCP callba=
cks,
> > is simpler then other alternatives but waste some space inside the subf=
low
> > struct.
> > =

> > The rebased tree is available at:
> > =

> > https://github.com/pabeni/mptcp/tree/mptcp_net-next_export_v6.2
> > =

> > options.c  |    6 -----
> > protocol.c |   16 ++++++--------
> > protocol.h |   15 ++++++++++++-
> > subflow.c  |   67 ++++++++++++++++++++++++++++++++++++++++-------------=
--------
> > 4 files changed, 67 insertions(+), 37 deletions(-)
> =

> I have one overall question about the series: do you want to use the =

> sk_is_mptcp() helper throughout? The added is_mptcp checks mostly do so =

> directly (tcp_sk(sk)->is_mptcp).

Agreed, will do in the next iteration.

Thanks,

Paolo


--===============5021706746284258815==--
