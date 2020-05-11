Content-Type: multipart/mixed; boundary="===============6233384904783389767=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC net] mptcp: Initialize map_seq upon subflow
 establishment
Date: Mon, 11 May 2020 08:40:08 -0700
Message-ID: <20200511154008.GW38702@MacBook-Pro-64.local>
In-Reply-To: f1ee39d4cb0ce1390fd3e6047c216cd96cfde89b.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4369

--===============6233384904783389767==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 11/05/20 - 10:30:51, Paolo Abeni wrote:
> On Sat, 2020-05-09 at 16:39 -0700, Christoph Paasch wrote:
> > When the other MPTCP-peer uses 32-bit data-sequence numbers, we rely on
> > map_seq to indicate how to expand to a 64-bit data-sequence number in
> > expand_seq() when receiving data.
> > =

> > For new subflows, this field is not initialized, thus results in an
> > "invalid" mapping being discarded.
> > =

> > Fix this by initializing map_seq upon subflow establishment time.
> > =

> > Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
> > Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> > ---
> >  net/mptcp/protocol.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > =

> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index e1f23016ed3f..86ed1e55a59b 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -1635,6 +1635,8 @@ bool mptcp_finish_join(struct sock *sk)
> >  			list_add_tail(&subflow->node, &msk->join_list);
> >  		spin_unlock_bh(&msk->join_list_lock);
> >  	}
> > +
> > +	subflow->map_seq =3D msk->ack_seq;
> >  	return ret;
> >  }
> >  =

> =

> The patch LGTM, thanks! =

> =

> Perhaps we can move the assignment under the 'if (ret) {' conditional,
> just for clarity?

Yes, I can move it there.

> May I guess the above is the root cause for the retransmissions we get
> while interopertating with mptcp.org? Is that all, or there are still
> retransmissions?

Yes, that was all there is. Because data didn't get acknowledged on the
other subflows, thus MPTCP retransmitted until it tried the initial subflow=
, where
it finally was being acknowledged.

My next problem now is ADD_ADDR-format that is incorrect in out-of-tree.



On a different note - while digging through the code I found the naming a
bit surprising. msk->ack_seq is basically a "TCP rcv_nxt" variable. Same for
the subflow's map_seq is the subflow's view of "MPTCP-level rcv_nxt". Right?

Would the code be easier to understand if it would be called
msk->rcv_nxt and subflow->rcv_nxt_dsn ?

Not really important or urgent - just wondering if it makes sense to make
MPTCP's data-processing more look TCP-like to make it easier to follow as t=
he
concepts of Sequence-numbers and ACK-numbers are the same in MPTCP and TCP.


Christoph

--===============6233384904783389767==--
