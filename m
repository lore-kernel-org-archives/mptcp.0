Content-Type: multipart/mixed; boundary="===============2432025363850265326=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/3] mptcp: parse and emit MP_CAPABLE option
 according to v1 spec.
Date: Tue, 03 Dec 2019 12:05:10 +0100
Message-ID: <e5970ab9eb7d27408787242b2a3d4199a6d8a0e6.camel@redhat.com>
In-Reply-To: 69a42c6f-2e4d-9cd0-014c-9b1c8a7d241f@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2765

--===============2432025363850265326==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-12-03 at 11:39 +0100, Matthieu Baerts wrote:
> Hi Christoph,
> =

> Thank you for the new version of the patch!
> =

> I have mostly a few questions, maybe no need to modify the code ;-)
> =

> I also added Paolo in cc. Because you supported Christoph for this task, =

> don't hesitate to share some answers if you already have them (not to =

> wait for West US coast to be up :-) )
> =

> On 02/12/2019 18:15, Christoph Paasch wrote:
> > This implements MP_CAPABLE options parsing and writing according
> > the the RFC 6824 bis - MPTCP v1.
> =

> (detail: according "to" the =E2=86=92 I can fix that when applying it)

Thank you!

> > Local key is sent on syn/ack, and both keys are sent on 3rd ack.
> > MP_CAPABLE messages len are updated accordingly.
> > We need the skbuff to emit correctly the above, so we push the skbuff
> > struct as an argument all the way from tcp code to the relevant mptcp
> > callbacks.
> > =

> > When processing incoming MP_CAPABLE + data, build a full blown DSS-like
> > map info, to simplify later processing.
> > On child socket creation, we need to record the remote key, if availabl=
e.
> > =

> > RFC -> v1:
> >   - rebase on top of "mptcp: Add IPv6 support"
> >   - explicitly assumes TCP option space is not exhausted
> =

> I guess I can remove these 3 lines when applying it, right?

I guess so, too.

> > Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> =

> [...]
> =

> > @@ -29,12 +29,24 @@ void mptcp_parse_option(const unsigned char *ptr, i=
nt opsize,
> >   	 * 10-17: Receiver key (optional)
> >   	 */
> >   	case MPTCPOPT_MP_CAPABLE:
> > -		if (opsize !=3D TCPOLEN_MPTCP_MPC_SYN &&
> > -		    opsize !=3D TCPOLEN_MPTCP_MPC_SYNACK)
> > +		/* strict size checking */
> =

> Good idea, even for a v0 (but no need to change the patches v0 of course)
> =

> > +		if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN)) {
> > +			if (skb->len > tcp_hdr(skb)->doff << 2)
> > +				expected_opsize =3D TCPOLEN_MPTCP_MPC_ACK_DATA;
> > +			else
> > +				expected_opsize =3D TCPOLEN_MPTCP_MPC_ACK;
> > +		} else {
> > +			if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK)
> > +				expected_opsize =3D TCPOLEN_MPTCP_MPC_SYNACK;
> > +			else
> > +				expected_opsize =3D TCPOLEN_MPTCP_MPC_SYN;
> > +		}
> > +		if (opsize !=3D expected_opsize)
> >   			break;
> >   =

> > +		/* only support V1 of the protocol */
> >   		mp_opt->version =3D *ptr++ & MPTCP_VERSION_MASK;
> > -		if (mp_opt->version !=3D 0)
> > +		if (mp_opt->version !=3D 1)
> =

> I don't know if you saw my previous comment but if we are parsing a SYN =

> here, should we not accept all versions > 0 and reply that the highest =

> version we support is v1? =


Yep, sorry for the missing answer, so far. I think we can add easily
that later, if/when newer/experimental version will surface. This code
preserve the behaviour we already have with v0, I think we can keep as-
is.

> @@ -59,19 +71,29 @@ void mptcp_parse_option(const unsigned char *ptr, int=
 opsize,
> >   			break;
> >   =

> >   		mp_opt->mp_capable =3D 1;
> > -		mp_opt->sndr_key =3D get_unaligned_be64(ptr);
> > -		ptr +=3D 8;
> > -
> > -		if (opsize =3D=3D TCPOLEN_MPTCP_MPC_SYNACK) {
> > +		if (opsize >=3D TCPOLEN_MPTCP_MPC_SYNACK) { > +			mp_opt->sndr_key =
=3D get_unaligned_be64(ptr);
> > +			ptr +=3D 8;
> > +		}
> > +		if (opsize >=3D TCPOLEN_MPTCP_MPC_ACK) {
> >   			mp_opt->rcvr_key =3D get_unaligned_be64(ptr);
> >   			ptr +=3D 8;
> > -			pr_debug("MP_CAPABLE flags=3D%x, sndr=3D%llu, rcvr=3D%llu",
> > -				 mp_opt->flags, mp_opt->sndr_key,
> > -				 mp_opt->rcvr_key);
> > -		} else {
> > -			pr_debug("MP_CAPABLE flags=3D%x, sndr=3D%llu",
> > -				 mp_opt->flags, mp_opt->sndr_key);
> >   		}
> > +		if (opsize =3D=3D TCPOLEN_MPTCP_MPC_ACK_DATA) {
> > +			/* Section 3.1.:
> > +			 * "the data parameters in a MP_CAPABLE are semantically
> > +			 * equivalent to those in a DSS option and can be used
> > +			 * interchangeably."
> > +			 */
> > +			mp_opt->dss =3D 1;
> > +			mp_opt->use_map =3D 1;
> > +			mp_opt->mp_capable_map =3D 1;
> > +			mp_opt->data_len =3D get_unaligned_be16(ptr);
> > +			ptr +=3D 2;
> > +		}
> > +		pr_debug("MP_CAPABLE flags=3D%x, optlen=3D%d sndr=3D%llu, rcvr=3D%ll=
u len=3D%d",
> > +			 mp_opt->flags, opsize, mp_opt->sndr_key,
> > +			 mp_opt->rcvr_key, mp_opt->data_len);
> =

> (detail: should we also print the version if we accept that the other =

> supports a newer one but can also be compatible with the older ones?)

yes, if/when we will do that! ;)

> > @@ -433,22 +511,36 @@ void mptcp_write_options(__be32 *ptr, struct mptc=
p_out_options *opts)
> >   			len =3D TCPOLEN_MPTCP_MPC_SYN;
> >   		else if (OPTION_MPTCP_MPC_SYNACK & opts->suboptions)
> >   			len =3D TCPOLEN_MPTCP_MPC_SYNACK;
> > +		else if (opts->ext_copy.data_len)
> > +			len =3D TCPOLEN_MPTCP_MPC_ACK_DATA;
> >   		else
> >   			len =3D TCPOLEN_MPTCP_MPC_ACK;
> >   =

> >   		*ptr++ =3D htonl((TCPOPT_MPTCP << 24) | (len << 16) |
> >   			       (MPTCPOPT_MP_CAPABLE << 12) |
> > -			       ((MPTCP_VERSION_MASK & 0) << 8) |
> > +			       ((MPTCP_VERSION_MASK & 1) << 8) |
> =

> Why do you have to change the bit we need from the mask here?

I guess the above is clearer after rebasing patch "mptcp: Add ADD_ADDR
handling", which introduces the mptcp_option() helper.

The above statement set the version number inside the MP_CAPABLE option
to 1 (the mask is unchanged, the code changes the version value to 1)
> =

> >   			       MPTCP_CAP_HMAC_SHA256);
> > +
> > +		if (!((OPTION_MPTCP_MPC_SYNACK | OPTION_MPTCP_MPC_ACK) &
> > +		    opts->suboptions))
> =

> (a detail but why not checking only for SYN?)

Yep, that would be equivalent. I guess the logic above is checking for
whatever options need to process more data.

> > +			goto mp_capable_done;
> > +
> >   		put_unaligned_be64(opts->sndr_key, ptr);
> >   		ptr +=3D 2;
> > -		if ((OPTION_MPTCP_MPC_SYNACK |
> > -		     OPTION_MPTCP_MPC_ACK) & opts->suboptions) {
> > -			put_unaligned_be64(opts->rcvr_key, ptr);
> > -			ptr +=3D 2;
> > -		}
> > +		if (!((OPTION_MPTCP_MPC_ACK) & opts->suboptions))
> =

> (a detail but here as well, can we not check only for SYNACK?)

I'm sorry I did not get it. Could you please re-phrase?

> > @@ -183,11 +182,22 @@ static struct sock *subflow_syn_recv_sock(const s=
truct sock *sk,
> >   					  bool *own_req)
> >   {
> >   	struct mptcp_subflow_context *listener =3D mptcp_subflow_ctx(sk);
> > +	struct mptcp_subflow_request_sock *subflow_req;
> > +	struct tcp_options_received opt_rx;
> >   	struct sock *child;
> >   =

> >   	pr_debug("listener=3D%p, req=3D%p, conn=3D%p", listener, req, listen=
er->conn);
> >   =

> > -	/* if the sk is MP_CAPABLE, we already received the client key */
> > +	/* if the sk is MP_CAPABLE, we need to fetch the client key */
> > +	subflow_req =3D mptcp_subflow_rsk(req);
> > +	if (subflow_req->mp_capable) {
> > +		opt_rx.mptcp.mp_capable =3D 0;
> > +		mptcp_get_options(skb, &opt_rx);
> > +		if (!opt_rx.mptcp.mp_capable)
> > +			subflow_req->mp_capable =3D 0;
> =

> Does that mean that syn_recv_sock() will do a fallback to TCP?

AFAICS, yes. I guess pktdrill will help testing this code ;)

Thank you for the in-depth review!

Paolo

--===============2432025363850265326==--
