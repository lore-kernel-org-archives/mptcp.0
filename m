Content-Type: multipart/mixed; boundary="===============6112022076805155994=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 mptcp-next 2/4] mptcp: re-enable sndbuf autotune
Date: Tue, 12 Jan 2021 11:27:42 +0100
Message-ID: <2ee5933200c5fad4ea7f50a8e678f0d6d70befe9.camel@redhat.com>
In-Reply-To: 29c696a-c2a5-23d4-de1d-f559d61fcf0@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 7321

--===============6112022076805155994==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2021-01-11 at 17:01 -0800, Mat Martineau wrote:
> On Mon, 11 Jan 2021, Paolo Abeni wrote:
> =

> > After commit 6e628cd3a8f7 ("mptcp: use mptcp release_cb for
> > delayed tasks"), MPTCP never sets the flag bit SOCK_NOSPACE
> > on its subflow. As a side effect, autotune never takes place,
> > as it happens inside tcp_new_space(), which in turn is called
> > only when the mentioned bit is set.
> > =

> > Let's sendmsg() set the subflows NOSPACE bit when looking for
> > more memory. Additionally, cleanup the sndbuf propagation from
> > subflow into the msk, leveraging the subflow write space callback
> > and dropping a bunch of duplicate code.
> > =

> > This also makes the SNDBUF_LIMITED chrono relevant again
> > for MPTCP subflows.
> > =

> > Fixes: 6e628cd3a8f7 ("mptcp: use mptcp release_cb for delayed tasks")
> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > ---
> > v1 -> v2:
> > - leverage the previous commit, so we can always simply set the nospace
> >   bit on the msk/parent socket
> > ---
> > net/mptcp/protocol.c | 57 +++++++++++++++++++-------------------------
> > net/mptcp/protocol.h | 20 ++++++++++++++++
> > net/mptcp/subflow.c  | 10 +++++++-
> > 3 files changed, 53 insertions(+), 34 deletions(-)
> > =

> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index ada69495a51b..a64b2f6fb17b 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -1421,7 +1410,8 @@ static struct sock *mptcp_subflow_get_send(struct=
 mptcp_sock *msk,
> > 		 send_info[1].ssk, send_info[1].ratio);
> > =

> > 	/* pick the best backup if no other subflow is active */
> > -	if (!nr_active)
> > +	msk->use_backup =3D !nr_active;
> > +	if (msk->use_backup)
> =

> This is the only place msk->use_backup is read. Is this a leftover from =

> v1?

Indeed! thanks for noticing! I will drop that in the next iteration.

Paolo

--===============6112022076805155994==--
