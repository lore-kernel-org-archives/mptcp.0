Content-Type: multipart/mixed; boundary="===============0110179479395452891=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next 1/3] mptcp: create listening
 socket for new port
Date: Tue, 17 Nov 2020 10:22:24 +0100
Message-ID: <dfbdd6e25224365ab1bec2b5aceb9a0ba91668e4.camel@redhat.com>
In-Reply-To: eb235288-c45a-878f-333-de72e59dc4bd@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 6760

--===============0110179479395452891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-11-16 at 15:55 -0800, Mat Martineau wrote:
> On Mon, 16 Nov 2020, Paolo Abeni wrote:
> =

> > On Mon, 2020-11-16 at 12:30 +0800, Geliang Tang wrote:
> > > This patch created the listening socket from the kernel side, binded =
the
> > > new port to the listening socket, then listened.
> > > =

> > > Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> > > ---
> > > mptcp_subflow_create_socket will fail here since the sk->sk_socket is
> > > null. I simply dropped this null checking which was been added by Pao=
lo
> > > in the commit "adf7341064982 (mptcp: be careful on subflow creation)".
> > > ---
> > >  net/mptcp/pm_netlink.c |  3 +++
> > >  net/mptcp/protocol.h   |  1 +
> > >  net/mptcp/subflow.c    | 55 +++++++++++++++++++++++++++++++++++-----=
--
> > >  3 files changed, 50 insertions(+), 9 deletions(-)
> > > =

> =

> ...
> =

> > When we hit the !sk->sk_socket scenario, ownership for the newly
> > created socket will be uncorrect.
> > =

> > Possibly a more important point: does the above ensure proper isolation
> > between processes and sockets ?
> > =

> > If I follow the code correctly, once that additional listening socket
> > is created, any join request landing there will be able to attach to
> > any msk - even outside the current netns with the current token infra.
> > =

> =

> Does the per-msk port number checking in patch 9/13 (ADD_ADDR ports v4 =

> series) address part of this?
> =

> https://patchwork.ozlabs.org/project/mptcp/patch/c32afb7d145744ba936bf370=
97c4120bd51c6c1a.1604984546.git.geliangtang(a)gmail.com/

Ooops, I missed that piece. Yes, looks safe to me. It should applies
nicely also to alternative schema using a single listening socket per
netns.

Cheers,

Paolo

--===============0110179479395452891==--
