Content-Type: multipart/mixed; boundary="===============3001415361573078037=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: SYN/ACK+MP_JOIN keeps getting retransmitted
Date: Tue, 05 May 2020 11:31:01 -0700
Message-ID: <20200505183101.GA99784@MacBook-Pro-64.local>
In-Reply-To: 422f8a74d7b0aa46780a93a80102cf3ef41d19f3.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4317

--===============3001415361573078037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 05/05/20 - 12:42:16, Paolo Abeni wrote:
> On Mon, 2020-05-04 at 09:36 -0700, Christoph Paasch wrote:
> > On 02/05/20 - 09:30:43, Paolo Abeni wrote:
> > > On Fri, 2020-05-01 at 11:09 -0700, Christoph Paasch wrote:
> [...]
> > > > Thoughts?
> > > > =

> > > > This is not going to trigger a RST from the server (see comment in
> > > > subflow_init_req, because we are not passing up a return-value from=
 init_req
> > > > to tcp_conn_request - but that should be easy to change).
> > > =

> > > Thank you for the detailed analisys! LGTM, with a couple of notes:
> > > =

> > > - I think it would be nicer if we additionally decreases the subflows
> > > if the mp_join request sk 'fails'/fallback before completing the 3WHS
> > =

> > regarding decrease - I saw that and actually was surprised that we *nev=
er*
> > decrease the subflow-counter (at least, I couldn't find where it is bei=
ng
> > decremented).
> > =

> > Was that intended? =

> =

> So far, yes. The idea is that we currently increment the subflows
> counter only after the peer is completely validated and we close the
> subflow only at msk shutdown. Even if the peer closes the subflow, we -
> currently - still keep the 'struct sock' around. So the subflow count
> never decreases. =

> =

> I plan to revisit the above within the scope of:
> =

> https://github.com/multipath-tcp/mptcp_net-next/issues/19
> =

> =

> > Because, that means if I set max_subflows to 3 and even if
> > I only ever have 2 subflows in parallel, after the third subflow I am b=
locked.
> =

> Which is expected, right ?!? Can you please re-phrase?!? =


The scenario I have in mind is this:

One configures the server-side with X subflows (with X being a reasonable
number, like 8) to prevent an attacker from creating an endless list of
subflows which makes the kernel iterate over that list for a long time.

Now, the client is walking from one WiFi access-point to another, switching
from WiFi, back to cell, back to WiFi,... each time with a new subflow
(e.g., because it's a different WiFi AP). So, at any time the number of
"parallel" subflows should never be higher than 2, but the total number of
subflows this connection has seen can be very large.

It seems like this is being addressed with Issue #19 (I would add to it that
subflows should also be closed if they receive a TCP-RST).

> =

> > > - we should cope better with failures when processing incoming mp_join
> > > syn-ack - e.g. dropping the req socket. =

> > =

> > These failures should be fairly easy to repro with packetdrill.
> > E.g., the state-check in finish_join.
> =

> uhm... a pity we don't have mp_join support yet for the pktdrill
> version in use with the export-branch :(

Ah, I see.

> > But, looking at removing the request-sock upon failure in
> > subflow_syn_recv_sock(). That looks tricky to me because we would need =
to
> > somehow tell tcp_check_req() whether or not to continue processing.
> =

> Just return NULL (as we currently do) and properly get rid of the req
> socket (as we currently _don't_ do) !?!
> =

> The req is disposed by tcp_check_req() iff 'tcp_abort_on_overflow' !=3D
> 0, which is not the default.

Yes, so the problem is to pass back the indication to tcp_check_req to
dispose the req. (trying to avoid the hooks in tcp_check_req ;-) )

Could we change the syn_recv_sock callback to return an int which indicates=
 to
tcp_check_req whether or not it should dispose of the request-sock?

Looking at quite a few of the possible failures in those
callbacks, I don't see any (besides maybe DCCP and MPTCP) that would make s=
ense to
destroy the request-socket. All the other failures are ENOMEM-related.


What about something like this:
@@ -769,12 +769,16 @@ struct sock *tcp_check_req(struct sock *sk, struct sk=
_buff *skb,
         * ESTABLISHED STATE. If it will be dropped after
         * socket is created, wait for troubles.
         */
-       child =3D inet_csk(sk)->icsk_af_ops->syn_recv_sock(sk, skb, req, NU=
LL,
-                                                        req, &own_req);
-       if (!child)
+       ret =3D inet_csk(sk)->icsk_af_ops->syn_recv_sock(sk, skb, req, NULL,
+                                                      req, &own_req, &chil=
d);
+       if (ret < 0) {
+               if (ret !=3D -ENOMEM) {
+                       goto embryonic_reset;
+               }
                goto listen_overflow;
+       }

-       if (own_req && sk_is_mptcp(child) && mptcp_sk_is_subflow(child)) {
+       if (ret > 0)
                reqsk_queue_removed(&inet_csk(sk)->icsk_accept_queue, req);
                inet_csk_reqsk_queue_drop_and_put(sk, req);
                return child;


Yes, it does not get rid of the branching in tcp_check_req, but at least it
makes it less MPTCP-specific.

We then just need to make sure that MPTCP returns 1 in syn_recv_sock if it
is a subflow.

Thoughts?


Christoph

> Additionally we currently account syn-ack join checks as listener
> overflow.
> =

> =

> > Looking at DCCP, which seems to have some kind of activation of features
> > requested during the handshake - it also just seems to return NULL with=
out
> > killing the request-sock.
> > =

> > Would it make sense to rather do the validity-checks (e.g., correctness=
 of
> > hmac) in tcp_check_req where it is easy to fail the request-sock ?
> =

> uhm... more hooks in tcp_check_req :(, see:
> =

> https://github.com/multipath-tcp/mptcp_net-next/issues/16
> =

> I'd like to avoid them if possible - but I can't find how :(
> =

> Cheers,
> =

> Paolo
>=20
--===============3001415361573078037==--
