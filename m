Content-Type: multipart/mixed; boundary="===============6442810680303962894=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 0/12] pm netlink: followup and fixes
Date: Thu, 05 Mar 2020 13:47:19 +0100
Message-ID: <5023231f785153b60e4c3660caa818ac85660281.camel@redhat.com>
In-Reply-To: alpine.OSX.2.22.394.2003041632410.33439@mlee22-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3868

--===============6442810680303962894==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-03-04 at 17:02 -0800, Mat Martineau wrote:
> On Wed, 4 Mar 2020, Paolo Abeni wrote:
> =

> > On Wed, 2020-03-04 at 16:01 +0100, Paolo Abeni wrote:
> > > Note: mp join self tests are still unstable, e.g. can fail randomly, =
due to an
> > > old race between mptcp_token_update_accept() and mptcp_token_get_sock=
(): e.g.
> > > a client may legitly try to create a subflow after that the first one=
 is fully
> > > established but before the server has accepted the initial socket:
> > > mptcp_token_get_sock() will fail and MP_JOIN will fail too, increment=
ing
> > > MPTCP_MIB_JOINNOTOKEN.
> > =

> > I'm looking at the above issue.
> > =

> > I think we can address it allocating earlier the msk socket in
> > subflow_syn_recv_sock(), so that we can always insert the 'token ->
> > msk' association into the radix tree before entering the fully
> > established status.
> > =

> > As a nice side effect mptcp_connect() will be simpler and faster.

typo here!!! s/mptcp_connect()/mptcp_accept()/, sorry.

> > =

> > The flip side is more memory allocated for the child socket backlog (I
> > think it should not be that bad, as the child backlog is limited).
> > =

> > I hope to share some early code soon. (will be a separate series
> > anyway)
> > =

> > Any comments/opinion/warns ?!?
> > =

> =

> Would it work to do the allocation in mptcp_stream_accept() instead of =

> subflow_syn_recv_sock() to avoid the backlog issue? =


That is more or less what we are doing now (allocation happens in
mptcp_accept()), so it would not help.

As per the addittional memory usage, I think that should be fine
because we are limited by the 'backlog' argument in the listen()
syscall, and very large backlog values will use a lot of memory no
matter what.

> Also - I did look through the full patch set and just had the comments on =

> patch 4.

Thank you!

/Paolo

--===============6442810680303962894==--
