Content-Type: multipart/mixed; boundary="===============0819152089830399302=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 3/3] mptcp: process MP_CAPABLE data option.
Date: Thu, 05 Dec 2019 11:32:05 +0100
Message-ID: <c7f6c602d23f78c9bdb6aa459a187aedd8f86b4c.camel@redhat.com>
In-Reply-To: 3e1d01ddcc7c9f499fdcca012698d8282761e03c.camel@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2792

--===============0819152089830399302==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2019-12-04 at 18:06 -0800, Peter Krystad wrote:
> @@ -188,17 +189,28 @@ static struct sock *subflow_syn_recv_sock(const str=
uct sock *sk,
> >  =

> >  	pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, listene=
r->conn);
> >  =

> > -	/* if the sk is MP_CAPABLE, we need to fetch the client key */
> > +	/* if the sk is MP_CAPABLE, we try to fetch the client key */
> =

> Maybe this comment should be moved down to where the code fetching the
> remote key is now that more code has been added here.
> =

> >  	subflow_req =3D mptcp_subflow_rsk(req);
> >  	if (subflow_req->mp_capable) {
> > +		if (TCP_SKB_CB(skb)->seq !=3D subflow_req->ssn_offset + 1) {
> > +			/* here we can receive and accept an in-window,
> > +			 * out-of-order pkt, which will not carry the MP_CAPABLE
> > +			 * opt even on mptcp enabled paths
> > +			 */
> > +			goto create_child;
> > +		}
> =

> So this means we will create the child socket even without receiving the
> MP_CAPABLE ACK? Will there be side-effects of there are a lot of such pac=
kets?

The RFC says we must always create such sockets (if e.g. middle-boxes
drop the 3rd MP_CAPABLE opt) so we can't escape this scenario.

The worst effect I can think of is:

- a new socket being created server side with mp_capable =3D 1, =

- user-space calls recvmsg()/sendmsg() and blocks
- the 3rd ack is received without the MP_CAPABLE opt, and the socket
fallback to plain tcp.
- will ever the kernel wake the user-space on the fallback socket?

AFAICS, with the last patches from Florian both recvmsg() and sendmsg()
will be woken-up correctly - but than we have to explicitly check for
fallback.

Anyhow I think we need some pktdrill to test this in a reliable way, I
would not overlookup too much at it now.

Thanks,

Paolo



--===============0819152089830399302==--
