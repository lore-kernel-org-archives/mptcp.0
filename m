Content-Type: multipart/mixed; boundary="===============1532871993895217362=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: SYN/ACK+MP_JOIN keeps getting retransmitted
Date: Tue, 05 May 2020 13:13:29 +0200
Message-ID: <fdfa1132bb902cb21ebaf5dbc50372baf43c92ae.camel@redhat.com>
In-Reply-To: 20200504163630.GA33923@MacBook-Pro-64.local
X-Status: 
X-Keywords:                  
X-UID: 4313

--===============1532871993895217362==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-05-04 at 09:36 -0700, Christoph Paasch wrote:
> On 02/05/20 - 09:30:43, Paolo Abeni wrote:
> > On Fri, 2020-05-01 at 11:09 -0700, Christoph Paasch wrote:
[...]
> > > Thoughts?
> > > =

> > > This is not going to trigger a RST from the server (see comment in
> > > subflow_init_req, because we are not passing up a return-value from i=
nit_req
> > > to tcp_conn_request - but that should be easy to change).
> > =

> > Thank you for the detailed analisys! LGTM, with a couple of notes:
> > =

> > - I think it would be nicer if we additionally decreases the subflows
> > if the mp_join request sk 'fails'/fallback before completing the 3WHS
> =

> regarding decrease - I saw that and actually was surprised that we *never*
> decrease the subflow-counter (at least, I couldn't find where it is being
> decremented).
> =

> Was that intended? =


So far, yes. The idea is that we currently increment the subflows
counter only after the peer is completely validated and we close the
subflow only at msk shutdown. Even if the peer closes the subflow, we -
currently - still keep the 'struct sock' around. So the subflow count
never decreases. =


I plan to revisit the above within the scope of:

https://github.com/multipath-tcp/mptcp_net-next/issues/19


> Because, that means if I set max_subflows to 3 and even if
> I only ever have 2 subflows in parallel, after the third subflow I am blo=
cked.

Which is expected, right ?!? Can you please re-phrase?!? =


> > - we should cope better with failures when processing incoming mp_join
> > syn-ack - e.g. dropping the req socket. =

> =

> These failures should be fairly easy to repro with packetdrill.
> E.g., the state-check in finish_join.

uhm... a pity we don't have mp_join support yet for the pktdrill
version in use with the export-branch :(

> But, looking at removing the request-sock upon failure in
> subflow_syn_recv_sock(). That looks tricky to me because we would need to
> somehow tell tcp_check_req() whether or not to continue processing.

Just return NULL (as we currently do) and properly get rid of the req
socket (as we currently _don't_ do) !?!

The req is disposed by tcp_check_req() iff 'tcp_abort_on_overflow' !=3D
0, which is not the default.

Additionally we currently account syn-ack join checks as listener
overflow.

> Looking at DCCP, which seems to have some kind of activation of features
> requested during the handshake - it also just seems to return NULL without
> killing the request-sock.
> =

> Would it make sense to rather do the validity-checks (e.g., correctness of
> hmac) in tcp_check_req where it is easy to fail the request-sock ?

uhm... more hooks in tcp_check_req :(, see:

https://github.com/multipath-tcp/mptcp_net-next/issues/16

I'd like to avoid them if possible - but I can't find how :(

Cheers,

Paolo


--===============1532871993895217362==--
