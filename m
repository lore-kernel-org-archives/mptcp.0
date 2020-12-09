Content-Type: multipart/mixed; boundary="===============5851292513843633768=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v6 mptcp-next 2/9] mptcp: set the listening
 socket's subflow
Date: Wed, 09 Dec 2020 17:11:48 +0800
Message-ID: <CA+WQbwt-ottGvA-33XVAtFMjj21OUd1yzZZKgeX8awuK2=K-eA@mail.gmail.com>
In-Reply-To: 9dc3368e-783-9d41-3ad8-b36041e6a7e4@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7093

--===============5851292513843633768==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Mat Martineau <mathew.j.martineau(a)linux.intel.com> =E4=BA=8E2020=E5=B9=B4=
12=E6=9C=884=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=889:40=E5=86=99=E9=
=81=93=EF=BC=9A
>
> On Wed, 25 Nov 2020, Paolo Abeni wrote:
>
> > On Wed, 2020-11-25 at 11:01 +0800, Geliang Tang wrote:
> >> This patch set the subflow context of the listening socket.
> >>
> >> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> >> ---
> >>  net/mptcp/pm_netlink.c |  5 +++++
> >>  net/mptcp/protocol.h   |  1 +
> >>  net/mptcp/subflow.c    | 37 +++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 43 insertions(+)
> >>
> >> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> >> index d4c136f1e754..6053a88c176f 100644
> >> --- a/net/mptcp/subflow.c
> >> +++ b/net/mptcp/subflow.c
> >> @@ -1208,6 +1208,43 @@ int mptcp_subflow_create_socket(struct sock *sk=
, struct socket **new_sock)
> >>      return 0;
> >>  }
> >>
> >> +int mptcp_pm_set_listen_socket_subflow(struct sock *sk, struct socket=
 *sf)
> >> +{
> >> +    struct mptcp_subflow_context *subflow;
> >> +    struct net *net =3D sock_net(sk);
> >> +    int err;
> >> +
> >> +    if (!sf)
> >> +            return -EINVAL;
> >> +
> >> +    lock_sock(sf->sk);
> >> +
> >> +    mptcp_attach_cgroup(sk, sf->sk);
> >
> > This will likely not work if there are multiple MPTCP sockets using
> > this endpoint.
> >
> > Possibly the cgroup attaching should be done at subflow_syn_recv_sock()
> > time, for the child socket, with some custom code - because it must
> > override the existing cgroup inherited from the listener.
> >
>
> Geliang -
>
> I didn't see the cgroup issue addressed in v7, was it not necessary or is
> there more to figure out to get the child socket attached to the right
> cgroup?

This patch is dropped in v7 since a MPTCP socket is used in v7, instead of
the TCP socket in v6. So no need to deal with the cgroup attaching now.

-Geliang

>
> --
> Mat Martineau
> Intel
--===============5851292513843633768==--
