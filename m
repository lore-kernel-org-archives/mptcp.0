Content-Type: multipart/mixed; boundary="===============3704181833984626075=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next v2] mptcp: track window announced to
 peer
Date: Thu, 22 Oct 2020 22:52:41 +0200
Message-ID: <20201022205241.GI16895@breakpoint.cc>
In-Reply-To: d6c955dacd0fd80adc1e09845ed3f8e6fb11cb0b.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6408

--===============3704181833984626075==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> On Thu, 2020-10-22 at 12:32 +0200, Florian Westphal wrote:
> > OoO handling attemtps to detect when packet is out-of-window by testing
> > current ack sequence and remaining space vs. sequence number.
> > =

> > This doesn't work reliably.  Store the highest allowed sequence number
> > that we've announced and use it to detect oow packets.
> > =

> > Do this when mptcp options get written to the packet (wire format).
> > For this to work we need to move the write_options call until after sta=
ck
> > selected a new tcp window.
> > =

> > Signed-off-by: Florian Westphal <fw(a)strlen.de>
> =

> I've only a couple of minor comments, see below...
> =

> > @@ -445,11 +445,11 @@ struct tcp_out_options {
> >  	struct mptcp_out_options mptcp;
> >  };
> >  =

> > -static void mptcp_options_write(__be32 *ptr, struct tcp_out_options *o=
pts)
> > +static void mptcp_options_write(__be32 *ptr, const struct tcp_sock *tp=
, struct tcp_out_options *opts)
> =

> Nit picking: this looks above the 80 char limits ;)

Ok, i will break the line.

> > @@ -1147,5 +1163,7 @@ void mptcp_write_options(__be32 *ptr, struct mptc=
p_out_options *opts)
> >  			put_unaligned_be32(mpext->data_len << 16 |
> >  					   TCPOPT_NOP << 8 | TCPOPT_NOP, ptr);
> >  		}
> > +
> > +		mptcp_set_rwin(tp);
> =

> If I read correctly, we will not update the receive window for pure ack
> carrying ipv6 add addr option (and nothing else). Likely not
> particulary relevant, but perhaps we could call the above helper for
> all egress packet?

rx side only updates end of window if MPTCP_DSS_HAS_ACK flag is set.

I'll move it outside of the conditional, perhaps its less confusing that
way.
--===============3704181833984626075==--
