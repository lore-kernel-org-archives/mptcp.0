Content-Type: multipart/mixed; boundary="===============4517181412954922602=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] mptcp: Protect subflow socket options before
 connection completes
Date: Mon, 10 Feb 2020 14:43:32 +0100
Message-ID: <1d1027e176351e99937a2d9089d213a5b60c38d8.camel@redhat.com>
In-Reply-To: 20200210115221.GG2991@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 3609

--===============4517181412954922602==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-02-10 at 12:52 +0100, Florian Westphal wrote:
> Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
> > Userspace should not be able to directly manipulate subflow socket
> > options before a connection is established since it is not yet known if
> > it will be an MPTCP subflow or a TCP fallback subflow. TCP fallback
> > subflows can be more directly controlled by userspace because they are
> > regular TCP connections, while MPTCP subflow sockets need to be
> > configured for the specific needs of MPTCP. Use the same logic as
> > sendmsg/recvmsg to ensure that socket option calls are only passed
> > through to known TCP fallback subflows.
> > =

> > Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> > ---
> > =

> > One other question: is it racy to have __mptcp_tcp_fallback() return an
> > unlocked msk, then do the sock_hold(ssk) from an unlocked state?
> =

> Yes.
> =

> > It seems like if holding the ssk reference count is necessary at all it
> > should be done while the msk is still locked. I'm considering a change
> > to __mptcp_tcp_fallback() to have it not release the msk lock and
> > instead have all the callers do that.
> =

> Yes, that seems like the right thing to do.

Agreed.

I think that a separate patch for the above would be nicer.

Cheers,

Paolo

--===============4517181412954922602==--
