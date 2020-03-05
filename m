Content-Type: multipart/mixed; boundary="===============7816147139088211486=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 4/0004] Squash-to: "mptcp: Add handling of
 outgoing MP_JOIN requests"
Date: Thu, 05 Mar 2020 13:40:52 +0100
Message-ID: <e41af595d1b451a01ebebd1736835ca1563d1bb8.camel@redhat.com>
In-Reply-To: alpine.OSX.2.22.394.2003041501400.33439@mlee22-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3867

--===============7816147139088211486==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for the detailed review!

On Wed, 2020-03-04 at 16:14 -0800, Mat Martineau wrote:
> On Wed, 4 Mar 2020, Paolo Abeni wrote:
> =

> > Schedule 3rd ack retransmission via delack timer, and clear
> > it on fully established event
> =

> It seems ok to me to borrow the delack timer. Is it enough to only =

> retransmit the 3rd ack one time?

The delack timer is fired every time we transmit the 3rd ack, so
possibly more then once/as many time as needed - modulo bugs ;)

[...]
> > static bool mptcp_established_options_mp(struct sock *sk, struct sk_buf=
f *skb,
> > 					 unsigned int *size,
> > 					 unsigned int remaining,
> > @@ -350,12 +382,20 @@ static bool mptcp_established_options_mp(struct s=
ock *sk, struct sk_buff *skb,
> > 	struct mptcp_ext *mpext;
> > 	unsigned int data_len;
> > =

> > -	pr_debug("subflow=3D%p fully established=3D%d seq=3D%x:%x remaining=
=3D%d",
> > -		 subflow, subflow->fully_established, subflow->snd_isn,
> > -		 skb ? TCP_SKB_CB(skb)->seq : 0, remaining);
> > +	/* When skb is not available, we better over-estimate the emitted
> > +	 * options len. A full DSS option (28 bytes) is longer than
> > +	 * TCPOLEN_MPTCP_MPC_ACK_DATA(22) or TCPOLEN_MPTCP_MPJ_ACK(24), so
> > +	 * let's the caller try to fit that.
> =

> Since *size is not set within this function, I suggest replacing this las=
t =

> line with "tell the caller to defer the estimate to =

> mptcp_established_options_dss(), which will reserve enough space".

Ok, will do in the next iteration.

> > +	 */
> > +	if (!skb)
> > +		return false;
> > +
> > +	/* MPC/MPJ needed only on 3rd ack packet */
> > +	if (subflow->snd_isn !=3D TCP_SKB_CB(skb)->seq ||
> > +	    subflow->fully_established)
> =

> snd_isn is going to match sometimes when the sequence numbers wrap around=
, =

> I think it would be good to check subflow->fully_established first to =

> clarify that snd_isn is only meaningful in the !subflow_fully_established =

> case.

Agreed, will do in the next iteration.

> > +		return false;
> > =

> > -	if (subflow->mp_capable && !subflow->fully_established && skb &&
> > -	    subflow->snd_isn =3D=3D TCP_SKB_CB(skb)->seq) {
> > +	if (subflow->mp_capable) {
> > 		/* When skb is not available, we better over-estimate the
> > 		 * emitted options len. A full DSS option is longer than
> > 		 * TCPOLEN_MPTCP_MPC_ACK_DATA, so let's the caller try to fit
> =

> Looks like this comment was left in when copy/pasting

Indeed. I'll drop it in the next iteration.

Cheers,

Paolo

--===============7816147139088211486==--
