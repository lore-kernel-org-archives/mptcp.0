Content-Type: multipart/mixed; boundary="===============7777987763923636746=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC 3/3] mptcp: Add handling of incoming MP_JOIN requests
Date: Thu, 23 May 2019 08:46:09 -0700
Message-ID: <e1c9974ea73a1362151246f1b61db30db6a04321.camel@linux.intel.com>
In-Reply-To: d128b17f0b507dca875f510eb257ee101422178a.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1232

--===============7777987763923636746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Thnaks for your comments Paolo.

On Thu, 2019-05-23 at 11:34 +0200, Paolo Abeni wrote:
> Hi,
> =

> On Wed, 2019-05-22 at 14:38 -0700, Peter Krystad wrote:
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index 6437434a7bd7..dc4ba418c963 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -45,24 +45,55 @@ void mptcp_parse_option(const unsigned char *ptr, i=
nt opsize,
> >  		break;
> >  =

> >  	/* MPTCPOPT_MP_JOIN
> > -	 *
> >  	 * Initial SYN
> >  	 * 0: 4MSB=3Dsubtype, 000, 1LSB=3DBackup
> >  	 * 1: Address ID
> >  	 * 2-5: Receiver token
> >  	 * 6-9: Sender random number
> > -	 *
> >  	 * SYN/ACK response
> >  	 * 0: 4MSB=3Dsubtype, 000, 1LSB=3DBackup
> >  	 * 1: Address ID
> >  	 * 2-9: Sender truncated HMAC
> >  	 * 10-13: Sender random number
> > -	 *
> >  	 * Third ACK
> >  	 * 0: 4MSB=3Dsubtype, 0000
> >  	 * 1: 0 (Reserved)
> >  	 * 2-21: Sender HMAC
> >  	 */
> > +	case MPTCPOPT_MP_JOIN:
> > +		pr_debug("MP_JOIN");
> > +		opt_rx->mptcp.mp_join =3D 1;
> > +		if (opsize =3D=3D TCPOLEN_MPTCP_MPJ_SYN) {
> > +			opt_rx->mptcp.backup =3D *ptr++ & MPTCPOPT_BACKUP;
> > +			pr_debug("backup=3D%u", opt_rx->mptcp.backup);
> > +			opt_rx->mptcp.address_id =3D *ptr++;
> > +			pr_debug("address_id=3D%u", opt_rx->mptcp.address_id);
> > +			opt_rx->mptcp.token =3D get_unaligned_be32(ptr);
> > +			pr_debug("token=3D%u", opt_rx->mptcp.token);
> > +			ptr +=3D 4;
> > +			opt_rx->mptcp.nonce =3D get_unaligned_be32(ptr);
> > +			pr_debug("nonce=3D%u", opt_rx->mptcp.nonce);
> > +			ptr +=3D 4;
> =

> Very minor note here: when I enable debugging on MPTCP, I'm flooded
> with possibly too many messages and it's sometime difficult for me to
> find the useful information.
> =

> I think using a single pr_debug() with all the relevant info (nonce,
> token, address, backup) would help.
> =

> The same applies to others places below, too.

I've been meaning to do this for some time, I'll submit a separate patch to
remove a lot of these messages from early debugging days.

> =

> [...]
> > @@ -151,6 +171,18 @@ static struct sock *subflow_syn_recv_sock(const st=
ruct sock *sk,
> >  			child =3D NULL;
> >  		} else if (ctx->mp_capable) {
> >  			token_new_accept(child);
> > +		} else if (ctx->mp_join) {
> > +			if (token_new_join(child)) {
> > +				inet_sk_set_state(child, TCP_CLOSE);
> > +				sock_set_flag(child, SOCK_DEAD);
> > +				inet_csk_destroy_sock(child);
> > +				child =3D NULL;
> =

> There is a very similar block of code a few lines above. I think we can
> unify them in an error path reached via a 'goto' statement.
> =

> > +			} else {
> > +				mptcp_finish_join(ctx->conn, child);
> > +			}
> > +		} else {
> > +			ctx->mp_capable =3D 0;
> > +			ctx->mp_join =3D 0;
> =

> Why do we need to clear mp_capable and mp_join here ?

This is a remnant of a previous approach, I'll remove.
 =

> =

> [...]
> > diff --git a/net/mptcp/token.c b/net/mptcp/token.c
> > index 7f1cec957fa8..d4957deabcfd 100644
> > --- a/net/mptcp/token.c
> > +++ b/net/mptcp/token.c
> > @@ -55,6 +55,15 @@ static bool find_token(u32 token)
> >  	return (used !=3D NULL);
> >  }
> >  =

> > +static struct sock *lookup_token(u32 token)
> > +{
> > +	void *conn;
> > +
> > +	pr_debug("token=3D%u", token);
> > +	conn =3D radix_tree_lookup(&token_tree, token);
> > +	return (struct sock *) conn;
> > +}
> > +
> =

> Possibly out of the scope for this patch, but don't we need to take in
> account the netns, too, while doing the token lookup?

No, you're right, this does need to be taken into account. I'll investigate.

Peter.

> =

> Thanks,
> =

> Paolo
> =



--===============7777987763923636746==--
