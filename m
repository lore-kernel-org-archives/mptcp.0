Content-Type: multipart/mixed; boundary="===============5581761859327472770=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: sendmsg: fix stream corrution
Date: Mon, 23 Sep 2019 09:46:52 +0200
Message-ID: <8d138cb8c6bc48942ec2238f145a10227e7850e2.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1909201543300.79505@tvtrimel-mobl5.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1902

--===============5581761859327472770==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-09-20 at 15:45 -0700, Mat Martineau wrote:
> On Fri, 20 Sep 2019, Paolo Abeni wrote:
> =

> > Currently we can hit a stream's corruption with the following sequence:
> > - sendmsg_frag is invoked while the write_queue tail skb's len is equal=
 to
> >  the current size_goal.
> >  sendmsg_frag sets can_collapse to false, even if mptcp data are in seq=
uence.
> >  Anyway it does not set eor in the write_queue skb.
> > - sendmsg_frag invokes do_tcp_sendmsg(), which tries to allocate a new =
skb -
> >  as the 'size_goal - skb->len <=3D 0' condition is true.
> >  But it hits memory limit and/or such allocation fails, so do_tcp_sendm=
sg()
> >  jumps to the 'wait_for_memory:' label and invokes tcp_push()
> > - tcp_push() tries to transmit the write queue tail skb, but due to win=
dow size
> >  limit, split it, send the first half and leave in the write queue a sm=
aller
> >  skb - without any ext attached
> > - do_tcp_sendmsg() invokes sk_stream_wait_memory and than checks again =
for skb
> >  allocation, this time skb->len is less than size_goal and do_tcp_sendm=
sg()
> >  collapse the data on the existing skb
> > - sendmsg_frag adds a new ext to the tail skb in write queue, but due t=
o the above
> >  it is associated with a wrong/unexpected subflow sequence number: it m=
aps
> >  a future ssn -> stream corruption
> > =

> > This change addresses the above issue explicitly setting the 'eor' when=
 hitting
> > the initial condition so that tcp will not collapse the data after tcp_=
push().
> =

> Thanks for the detailed description. Code looks good to me and tested fin=
e =

> (although failures remain, but I don't think this was intended to fix =

> everything).

I haven't seen any failure on top of this patch (plus recvmsg
refactor), could you share debug enabled dmsg and/or pcap trace for
failure you see?

There is still at least a possible known bad scenario: it's quite alike
the above, but additionally the window size shrinks at
sk_stream_wait_memory() invocation time so that on next iterations
do_tcp_sendpages() ends-up creating multiple skbs. All except the last
one are sent without any DSS attached and that will corrupt the stream.

AFAICS there is no way of fixing the above, except replacing
do_tcp_sendpages() call with a chunk of almost duplicate code in mptcp,
that handles such corner case explicitly.

Thanks,

Paolo


--===============5581761859327472770==--
