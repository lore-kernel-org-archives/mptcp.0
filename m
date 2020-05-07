Content-Type: multipart/mixed; boundary="===============1899291653432072272=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: SYN/ACK+MP_JOIN keeps getting retransmitted
Date: Thu, 07 May 2020 09:50:38 -0700
Message-ID: <20200507165038.GG38702@MacBook-Pro-64.local>
In-Reply-To: 90bf76988ec6677dc11b64054f65bb60b8698064.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4344

--===============1899291653432072272==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 06/05/20 - 19:08:24, Paolo Abeni wrote:
> On Tue, 2020-05-05 at 11:31 -0700, Christoph Paasch wrote:
> > On 05/05/20 - 12:42:16, Paolo Abeni wrote:
> > > On Mon, 2020-05-04 at 09:36 -0700, Christoph Paasch wrote:
> > > > On 02/05/20 - 09:30:43, Paolo Abeni wrote:
> > > > > On Fri, 2020-05-01 at 11:09 -0700, Christoph Paasch wrote:
> > > [...]
> > > > > > Thoughts?
> > > > > > =

> > > > > > This is not going to trigger a RST from the server (see comment=
 in
> > > > > > subflow_init_req, because we are not passing up a return-value =
from init_req
> > > > > > to tcp_conn_request - but that should be easy to change).
> > > > > =

> > > > > Thank you for the detailed analisys! LGTM, with a couple of notes:
> > > > > =

> > > > > - I think it would be nicer if we additionally decreases the subf=
lows
> > > > > if the mp_join request sk 'fails'/fallback before completing the =
3WHS
> > > > =

> > > > regarding decrease - I saw that and actually was surprised that we =
*never*
> > > > decrease the subflow-counter (at least, I couldn't find where it is=
 being
> > > > decremented).
> > > > =

> > > > Was that intended? =

> > > =

> > > So far, yes. The idea is that we currently increment the subflows
> > > counter only after the peer is completely validated and we close the
> > > subflow only at msk shutdown. Even if the peer closes the subflow, we=
 -
> > > currently - still keep the 'struct sock' around. So the subflow count
> > > never decreases. =

> > > =

> > > I plan to revisit the above within the scope of:
> > > =

> > > https://github.com/multipath-tcp/mptcp_net-next/issues/19
> > > =

> > > =

> > > > Because, that means if I set max_subflows to 3 and even if
> > > > I only ever have 2 subflows in parallel, after the third subflow I =
am blocked.
> > > =

> > > Which is expected, right ?!? Can you please re-phrase?!? =

> > =

> > The scenario I have in mind is this:
> > =

> > One configures the server-side with X subflows (with X being a reasonab=
le
> > number, like 8) to prevent an attacker from creating an endless list of
> > subflows which makes the kernel iterate over that list for a long time.
> > =

> > Now, the client is walking from one WiFi access-point to another, switc=
hing
> > from WiFi, back to cell, back to WiFi,... each time with a new subflow
> > (e.g., because it's a different WiFi AP). So, at any time the number of
> > "parallel" subflows should never be higher than 2, but the total number=
 of
> > subflows this connection has seen can be very large.
> > =

> > It seems like this is being addressed with Issue #19 (I would add to it=
 that
> > subflows should also be closed if they receive a TCP-RST).
> =

> Yep, that was the idea...
> =

> Follow-up question: the above scenario will finally clash with the 8
> bit limit for address id, right?

I think it is fine to wrap-around the 8-bit counter then and use the
address-IDs that are currently unused.


Christoph

> > Could we change the syn_recv_sock callback to return an int which indic=
ates to
> > tcp_check_req whether or not it should dispose of the request-sock?
> =

> Ok, that would work, I think.
> My *personal* taste would be to try to avoid additional modification to
> TCP.
> =

> I *think* we can cope with this scenario in the following way:
> =

> * if MP_JOIN checks fail, subflow_syn_recv_sock() instead of freeing
> the child will call:
>         tcp_set_state(ssk, TCP_CLOSE);
>         tcp_send_active_reset(ssk, GFP_ATOMIC);
>         sock_put(ssk); // ssk ref cnt should be 2 before this call
>   and return the subflow socket.
> * the TCP stack will call tcp_child_process() on the child process,
> which will release the last reference to subflow.
> =

> Let me try to cook this one.
> =

> /P
>=20
--===============1899291653432072272==--
