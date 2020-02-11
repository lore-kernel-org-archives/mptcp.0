Content-Type: multipart/mixed; boundary="===============2218362928921505543=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Protect subflow socket options before
 connection completes
Date: Tue, 11 Feb 2020 18:42:47 +0100
Message-ID: <d762e4800137fb8ae4b3368edc34573e293d072e.camel@redhat.com>
In-Reply-To: alpine.OSX.2.22.394.2002101636290.9189@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 3611

--===============2218362928921505543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-02-10 at 16:44 -0800, Mat Martineau wrote:
> On Mon, 10 Feb 2020, Paolo Abeni wrote:
> =

> > On Mon, 2020-02-10 at 12:52 +0100, Florian Westphal wrote:
> > > Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> > > > Userspace should not be able to directly manipulate subflow socket
> > > > options before a connection is established since it is not yet know=
n if
> > > > it will be an MPTCP subflow or a TCP fallback subflow. TCP fallback
> > > > subflows can be more directly controlled by userspace because they =
are
> > > > regular TCP connections, while MPTCP subflow sockets need to be
> > > > configured for the specific needs of MPTCP. Use the same logic as
> > > > sendmsg/recvmsg to ensure that socket option calls are only passed
> > > > through to known TCP fallback subflows.
> > > > =

> > > > Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> > > > ---
> > > > =

> > > > One other question: is it racy to have __mptcp_tcp_fallback() retur=
n an
> > > > unlocked msk, then do the sock_hold(ssk) from an unlocked state?
> > > =

> > > Yes.
> > > =

> > > > It seems like if holding the ssk reference count is necessary at al=
l it
> > > > should be done while the msk is still locked. I'm considering a cha=
nge
> > > > to __mptcp_tcp_fallback() to have it not release the msk lock and
> > > > instead have all the callers do that.
> > > =

> > > Yes, that seems like the right thing to do.
> > =

> > Agreed.
> > =

> > I think that a separate patch for the above would be nicer.
> > =

> =

> Thanks Florian and Paolo. It's clear what to do when handling struct sock =

> reference counts, but we are also using struct socket in two different =

> ways:

>  * Calling ssock->ops->poll. The msk lock is held, but mptcp_close is =

> closing subflow sockets without the msk lock, and since we're reaching th=
e =

> subflow without using conn_list it looks like it's possible to have the =

> subflow struct socket unexpectedly freed.

[Note: I reorder the points, as the reply are simpler this way ;)]

I think you are right. Likely it's enough to clear the msk->subflow
pointer in mptcp_close() before releasing the lock. That will also
reduce greatly the race window for the next point...

>   * Calling sock_{send,recv}msg() without the msk lock (because we don't =

> want to keep it locked while the subflow call blocks).

uhm... this is quite nasty. AFAICS the possible race with the above
mentioned change is:

On CPU0 __mptcp_tcp_fallback() releases msk lock and returns the
subflow ref

On CPU1 mptcp_close() acquires the msk lock, release it, acquires the
ssk lock, release it, free the ssk

On CPU0 sock_{send,recv}msg() accesses the subflow ptr and we get UAF.

So the race looks extremely unlikely, would be possible at all? =


Perhaps we can mark the subflows as DEAD under the msk socket lock, and
check that on fallback? if the fallback subflow is dead we will not use
it.

BTW I'm wondering if we are behaving correctly WRT TCP fallback for
passive sockets (msk->subflow =3D NULL): __mptcp_tcp_fallback() currently
returns NULL, even if the subflow has fallback to TCP. I think/fear
recvmsg should hang in that scenario?!? (as the server still does a
full bloat mptcp_recvmsg(), while the client does not provide the DSS
options).

@Davide: do we have a packetdrill to test the above? e.g. the packet
socket is the client, it initiates an MP_CAPABLE handshake, causes
fallback on the 3rd ack, then sends some data and (kernel) server try
to read it with recvmsg() (possibly hanging on top of current net-next)

Should we resurrect the more convoluted idea of 'atomically' replacing
struct socket->sk with msk->first delaing the deallocation of  the
'old' struct socket and struct sock to the ULP destroy callback?

Cheers,

Paolo

--===============2218362928921505543==--
