Content-Type: multipart/mixed; boundary="===============7033027923257195156=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 1/2] skbuff: Add shared control buffer
Date: Tue, 07 Nov 2017 07:24:43 +0900
Message-ID: <20171106222443.GB5226@Chimay.local>
In-Reply-To: 9fe625a4-d0d8-ea22-c58d-cc43eb6a1737@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 150

--===============7033027923257195156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Rao,

On 05/11/17 - 18:45:35, Rao Shoaib wrote:
> =

> On 10/27/2017 12:57 PM, Christoph Paasch wrote:
> > =

> > I would love to see the rest of the patch. Especially wrt to writing the
> > mapping to the header.
> > =

> > How do you handle segments that are being split while sitting in the
> > subflow's send-queue and later on need to be retransmitted. Will the
> > retransmitted segment have the same DSS-mapping as the original
> > transmission?
> > =

> > =

> > Thanks,
> > Christoph
> > =

> I waited to make sure that my change works for net-next and I have just b=
een
> able to ssh into and out of a system running netdev + MPTCP using the same
> layout. Following are the relevant changes. The main observation is that =
we
> have all the information to build the DSS header, except for the
> data-sequence. Which is saved and passed on and requires only a 32bit fie=
ld.
> =

> Let me know if anyone sees any issues.

thanks for sharing, please find inline:

> =

> Shoaib
> =

> I have already provided the SKB changing, I am also using the dev field in
> skb for the other values.
> Note the above mapping is based on a dated version of the code, It does n=
ot
> work for net-next for which I am using different mapping, but the idea is
> the same and it does not require any additional information.
> =

> Changes to mptcp_skb_entail()
> =

> rshoaib(a)caduceus5:~/independent_mptcp$ diff /tmp/modified /tmp/original
> 10c10
> < =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 TCP_SKB_CB(skb)->mptcp_flags |=3D=
 (mpcb->snd_hiseq_index ?
> ---
> > =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 skb->mptcp_flags |=3D (mpcb->snd_=
hiseq_index ?
> 23c23
> < =C2=A0=C2=A0=C2=A0 TCP_SKB_CB(skb)->path_mask |=3D mptcp_pi_to_flag(tp-=
>mptcp->path_index);
> ---
> > =C2=A0=C2=A0=C2=A0 TCP_SKB_CB(skb)->mptcp_path_mask |=3D
> mptcp_pi_to_flag(tp->mptcp->path_index);
> 39c39
> < =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tcb->mptcp_flags |=3D MPTCPHDR_IN=
F;
> ---
> > =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 skb->mptcp_flags |=3D MPTCPHDR_IN=
F;
> 45c45,46
> < =C2=A0=C2=A0=C2=A0 mptcp_save_dss_data_seq(tp, subskb);
> ---
> > =C2=A0=C2=A0=C2=A0 subskb->mptcp_flags |=3D MPTCPHDR_SEQ;
> > =C2=A0=C2=A0=C2=A0 tcb->mptcp_data_seq =3D tcb->seq;
> =

> =

> Changes to mptcp_write_dss_mapping which is now called when the options a=
re
> written.
> =

> rshoaib(a)caduceus5:~/independent_mptcp$ diff /tmp/modified /tmp/original
> 1,2c1,2
> < static int mptcp_write_dss_mapping(const struct tcp_sock *tp,
> <=C2=A0=C2=A0=C2=A0=C2=A0 const struct sk_buff *skb, __be32 *ptr)
> ---
> > static int mptcp_write_dss_mapping(const struct tcp_sock *tp, const str=
uct
> sk_buff *skb,
> > =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0 __be32 *ptr)
> 4a5
> > =C2=A0=C2=A0=C2=A0 __be32 *start =3D ptr;
> 7c8
> < =C2=A0=C2=A0=C2=A0 *ptr++ =3D htonl(tcb->mptcp_data_seq); /* data_seq */
> ---
> > =C2=A0=C2=A0=C2=A0 *ptr++ =3D htonl(tcb->seq); /* data_seq */

mptcp_write_dss_mapping is now being called from tcp_options_write, through
mptcp_options_write, right?

At this point, tcb->seq will be the TCP-subflow's sequence number.

So, I'm not sure how you are able to get the data-sequence number here.

> 13c14
> < =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 *ptr++ =3D htonl(tcb->seq - tp->m=
ptcp->snt_isn); /* subseq */
> ---
> > =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 *ptr++ =3D htonl(tp->write_seq - =
tp->mptcp->snt_isn); /* subseq */

this here is what I was worried about. When we are retransmitting a segment,
tp->write_seq won't match anymore with the segment's sequence number.

You would need to pick tcb->seq here.

However even then, if the segment that is being retransmitted is due to a
partial ack (e.g., the original transmission was 100 bytes, and we received
an ack for only 50 bytes). We will then only retransmit the remaining 50
bytes and thus the relative sequence number won't be the same anymore as in
the original transmission.


Christoph

> 15c16
> < =C2=A0=C2=A0=C2=A0 if (skb->mptcp_flags & MPTCPHDR_INF)
> ---
> > =C2=A0=C2=A0=C2=A0 if (tcb->mptcp_flags & MPTCPHDR_INF)
> 17c18
> < =C2=A0=C2=A0=C2=A0 else {
> ---
> > =C2=A0=C2=A0=C2=A0 else
> 19,22d19
> < =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /* mptcp_entail_skb adds one for =
FIN */
> < =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (tcb->tcp_flags & TCPHDR_FIN)
> < =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data_len -=3D =
1;
> < =C2=A0=C2=A0=C2=A0 }
> 41c38
> < =C2=A0=C2=A0=C2=A0 return mptcp_dss_len/sizeof(*ptr);
> ---
> > =C2=A0=C2=A0=C2=A0 return ptr - start;
> 44,45c41,42
> < static int mptcp_write_dss_data_ack(const struct tcp_sock *tp,
> <=C2=A0=C2=A0=C2=A0=C2=A0 const struct sk_buff *skb, __be32 *ptr)
> ---
> > static int mptcp_write_dss_data_ack(const struct tcp_sock *tp, const
> struct sk_buff *skb,
> > =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 __be32 *ptr)
> 62d58
> < =C2=A0=C2=A0=C2=A0 /* data_ack */
> =

> And mptcp_options_write() is now:
> =

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (OPTION_DATA_ACK & opts->mp=
tcp_options) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ptr +=3D mptcp_write_dss_data_ack(tp, skb, ptr);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (mptcp_is_data_seq(skb)) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptr +=3D=
 mptcp_write_dss_mapping(tp, skb, ptr);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 skb->dev =3D NULL;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =

>=20

--===============7033027923257195156==--
