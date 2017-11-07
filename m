Content-Type: multipart/mixed; boundary="===============0755748018222041290=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 1/2] skbuff: Add shared control buffer
Date: Tue, 07 Nov 2017 13:09:13 +0900
Message-ID: <20171107040913.GE5226@Chimay.local>
In-Reply-To: 15364fbe-35dd-370e-48f5-a05652c0d5dc@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 153

--===============0755748018222041290==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 06/11/17 - 18:46:12, Rao Shoaib wrote:
> =

> =

> On 11/06/2017 02:24 PM, Christoph Paasch wrote:
> > Hello Rao,
> > =

> > On 05/11/17 - 18:45:35, Rao Shoaib wrote:
> > > On 10/27/2017 12:57 PM, Christoph Paasch wrote:
> > > > I would love to see the rest of the patch. Especially wrt to writin=
g the
> > > > mapping to the header.
> > > > =

> > > > How do you handle segments that are being split while sitting in the
> > > > subflow's send-queue and later on need to be retransmitted. Will the
> > > > retransmitted segment have the same DSS-mapping as the original
> > > > transmission?
> > > > =

> > > > =

> > > > Thanks,
> > > > Christoph
> > > > =

> > > I waited to make sure that my change works for net-next and I have ju=
st been
> > > able to ssh into and out of a system running netdev + MPTCP using the=
 same
> > > layout. Following are the relevant changes. The main observation is t=
hat we
> > > have all the information to build the DSS header, except for the
> > > data-sequence. Which is saved and passed on and requires only a 32bit=
 field.
> > > =

> > > Let me know if anyone sees any issues.
> > thanks for sharing, please find inline:
> > =

> > > Shoaib
> > > =

> > > I have already provided the SKB changing, I am also using the dev fie=
ld in
> > > skb for the other values.
> > > Note the above mapping is based on a dated version of the code, It do=
es not
> > > work for net-next for which I am using different mapping, but the ide=
a is
> > > the same and it does not require any additional information.
> > > =

> > > Changes to mptcp_skb_entail()
> > > =

> > > rshoaib(a)caduceus5:~/independent_mptcp$ diff /tmp/modified /tmp/orig=
inal
> > > 10c10
> > > < =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 TCP_SKB_CB(skb)->mptcp_flags =
|=3D (mpcb->snd_hiseq_index ?
> > > ---
> > > >  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 skb->mptcp_flags |=3D (mpcb-=
>snd_hiseq_index ?
> > > 23c23
> > > < =C2=A0=C2=A0=C2=A0 TCP_SKB_CB(skb)->path_mask |=3D mptcp_pi_to_flag=
(tp->mptcp->path_index);
> > > ---
> > > >  =C2=A0=C2=A0=C2=A0 TCP_SKB_CB(skb)->mptcp_path_mask |=3D
> > > mptcp_pi_to_flag(tp->mptcp->path_index);
> > > 39c39
> > > < =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 tcb->mptcp_flags |=3D MPTCPHD=
R_INF;
> > > ---
> > > >  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 skb->mptcp_flags |=3D MPTCPH=
DR_INF;
> > > 45c45,46
> > > < =C2=A0=C2=A0=C2=A0 mptcp_save_dss_data_seq(tp, subskb);
> > > ---
> > > >  =C2=A0=C2=A0=C2=A0 subskb->mptcp_flags |=3D MPTCPHDR_SEQ;
> > > >  =C2=A0=C2=A0=C2=A0 tcb->mptcp_data_seq =3D tcb->seq;
> > > =

> > > Changes to mptcp_write_dss_mapping which is now called when the optio=
ns are
> > > written.
> > > =

> > > rshoaib(a)caduceus5:~/independent_mptcp$ diff /tmp/modified /tmp/orig=
inal
> > > 1,2c1,2
> > > < static int mptcp_write_dss_mapping(const struct tcp_sock *tp,
> > > <=C2=A0=C2=A0=C2=A0=C2=A0 const struct sk_buff *skb, __be32 *ptr)
> > > ---
> > > > static int mptcp_write_dss_mapping(const struct tcp_sock *tp, const=
 struct
> > > sk_buff *skb,
> > > >  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0 __be32 *ptr)
> > > 4a5
> > > >  =C2=A0=C2=A0=C2=A0 __be32 *start =3D ptr;
> > > 7c8
> > > < =C2=A0=C2=A0=C2=A0 *ptr++ =3D htonl(tcb->mptcp_data_seq); /* data_s=
eq */
> > > ---
> > > >  =C2=A0=C2=A0=C2=A0 *ptr++ =3D htonl(tcb->seq); /* data_seq */
> > mptcp_write_dss_mapping is now being called from tcp_options_write, thr=
ough
> > mptcp_options_write, right?
> > =

> > At this point, tcb->seq will be the TCP-subflow's sequence number.
> > =

> > So, I'm not sure how you are able to get the data-sequence number here.
> Look at the code it is stashed in skb.
> > =

> > > 13c14
> > > < =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 *ptr++ =3D htonl(tcb->seq - t=
p->mptcp->snt_isn); /* subseq */
> > > ---
> > > >  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 *ptr++ =3D htonl(tp->write_s=
eq - tp->mptcp->snt_isn); /* subseq */
> > this here is what I was worried about. When we are retransmitting a seg=
ment,
> > tp->write_seq won't match anymore with the segment's sequence number.
> > =

> > You would need to pick tcb->seq here.
> Nope everything will just work because nothing is different than what is
> being done now. I guess example is worth a lot. So here is a tcpdump. Host
> .3 is running net-next while host .32 is running stock MPTCP kernel. I am
> ssh'ed from .3 to .32
> =

> =

> 17:45:02.174393 IP 192.168.1.3.57222 > 192.168.1.32.ssh: Flags [.], ack
> 8534, win 290, options [nop,nop,TS val 2104717628 ecr 5246410,mptcp dss a=
ck
> 846209813], length 0
> 17:45:02.174420 IP 192.168.1.3.57222 > 192.168.1.32.ssh: Flags [.], ack
> 8626, win 290, options [nop,nop,TS val 2104717628 ecr 5246410,mptcp dss a=
ck
> 846209849], length 0
> 17:45:02.636920 IP 192.168.1.32.ssh > 192.168.1.3.57222: Flags [P.], seq
> 8626:8718, ack 3670, win 263, options [nop,nop,TS val 5247726 ecr
> 2104717628,mptcp dss ack 2862106049 seq 846209849 subseq 8626 len 92 csum
> 0x658], length 92
> 17:45:02.636982 IP 192.168.1.3.57222 > 192.168.1.32.ssh: Flags [.], ack
> 8718, win 290, options [nop,nop,TS val 2104718091 ecr 5246410,mptcp dss a=
ck
> 846209941], length 0
> 17:45:22.920549 IP 192.168.1.32.netbios-ns > 192.168.1.255.netbios-ns: NBT
> UDP PACKET(137): QUERY; REQUEST; BROADCAST
> =

> <Bring Down the Interface on .32 >
> =

> 17:45:37.953517 IP 192.168.1.3.57222 > 192.168.1.32.ssh: Flags [P.], seq
> 3670:3706, ack 8718, win 290, options [nop,nop,TS val 2104753408 ecr
> 5246410,mptcp dss ack 846209941 seq 2862106049 subseq 3670 len 36 csum
> 0xe2fa], length 36
> 17:45:38.021963 IP 192.168.1.3.57222 > 192.168.1.32.ssh: Flags [P.], seq
> 3670:3706, ack 8718, win 290, options [nop,nop,TS val 2104753476 ecr
> 5246410,mptcp dss ack 846209941 seq 2862106049 subseq 3670 len 36 csum
> 0xe2fa], length 36
> =

> When I bring the interface back the connection continues on.
> =

> Now let's do the reverse
> =

> 17:57:33.441698 IP 192.168.1.3.ssh > 192.168.1.32.60024: Flags [P.], seq
> 4190:4274, ack 2626, win 291, options [nop,nop,TS val 2105468922 ecr
> 5435422,mptcp dss ack 1290518463 seq 2562035193 subseq 4190 len 84 csum
> 0x6c5], length 84
> 17:57:33.441804 IP 192.168.1.32.60024 > 192.168.1.3.ssh: Flags [.], ack
> 4274, win 271, options [nop,nop,TS val 5435430 ecr 2105468922,mptcp dss a=
ck
> 2562035277], length 0
> 17:57:33.576747 IP 192.168.1.32.60024 > 192.168.1.3.ssh: Flags [P.], seq
> 2626:2662, ack 4274, win 271, options [nop,nop,TS val 5435464 ecr
> 2105468922,mptcp dss ack 2562035277 seq 1290518463 subseq 2626 len 36 csum
> 0xc5b9], length 36
> 17:57:33.577426 IP 192.168.1.3.ssh > 192.168.1.32.60024: Flags [P.], seq
> 4274:4310, ack 2662, win 291, options [nop,nop,TS val 2105469058 ecr
> 5435464,mptcp dss ack 1290518499 seq 2562035277 subseq 4274 len 36 csum
> 0x64d], length 36
> 17:57:33.577603 IP 192.168.1.32.60024 > 192.168.1.3.ssh: Flags [.], ack
> 4310, win 271, options [nop,nop,TS val 5435464 ecr 2105469058,mptcp dss a=
ck
> 2562035313], length 0
> 17:57:33.609786 IP 192.168.1.3.ssh > 192.168.1.32.60024: Flags [P.], seq
> 4310:4394, ack 2662, win 291, options [nop,nop,TS val 2105469090 ecr
> 5435464,mptcp dss ack 1290518499 seq 2562035313 subseq 4310 len 84 csum
> 0x5d5], length 84
> 17:57:33.609930 IP 192.168.1.32.60024 > 192.168.1.3.ssh: Flags [.], ack
> 4394, win 271, options [nop,nop,TS val 5435472 ecr 2105469090,mptcp dss a=
ck
> 2562035397], length 0
> =

> =

> Interface on .3 is down
> =

> =

> 17:58:04.455423 IP 192.168.1.32.59734 > 192.168.1.3.ssh: Flags [.], ack
> 705070687, win 272, options [nop,nop,TS val 5443184 ecr 3451436041,mptcp =
dss
> ack 426484590], length 0
> 17:58:05.321012 IP 192.168.1.32.60024 > 192.168.1.3.ssh: Flags [P.], seq
> 2662:2698, ack 4394, win 271, options [nop,nop,TS val 5443400 ecr
> 2105469090,mptcp dss ack 2562035397 seq 1290518499 subseq 2662 len 36 csum
> 0xd5ad], length 36
> 17:58:05.513018 IP 192.168.1.32.60024 > 192.168.1.3.ssh: Flags [P.], seq
> 2698:2734, ack 4394, win 271, options [nop,nop,TS val 5443448 ecr
> 2105469090,mptcp dss ack 2562035397 seq 1290518535 subseq 2698 len 36 csum
> 0x7da8], length 36
> 17:58:05.527395 IP 192.168.1.32.60024 > 192.168.1.3.ssh: Flags [P.], seq
> 2698:2734, ack 4394, win 271, options [nop,nop,TS val 5443452 ecr
> 2105469090,mptcp dss ack 2562035397 seq 1290518535 subseq 2698 len 36 csum
> 0x7da8], length 36
> 17:58:05.696935 IP 192.168.1.32.60024 > 192.168.1.3.ssh: Flags [P.], seq
> 2734:2770, ack 4394, win 271, options [nop,nop,TS val 5443494 ecr
> 2105469090,mptcp dss ack 2562035397 seq 1290518571 subseq 2734 len 36 csum
> 0xebf2], length 36
> =

> interface is up and the tcp session continues
> =

> 17:58:31.975712 IP 192.168.1.32.60024 > 192.168.1.3.ssh: Flags [P.], seq
> 2662:2698, ack 4394, win 271, options [nop,nop,TS val 5450064 ecr
> 2105469090,mptcp dss ack 2562035397 seq 1290518499 subseq 2662 len 36 csum
> 0xd5ad], length 36
> 17:58:31.976255 IP 192.168.1.3.ssh > 192.168.1.32.60024: Flags [P.], seq
> 4394:4430, ack 2698, win 291, options [nop,nop,TS val 2105527458 ecr
> 5450064,mptcp dss ack 1290518535 seq 2562035397 subseq 4394 len 36 csum
> 0x55d], length 36
> 17:58:31.976307 IP 192.168.1.32.60024 > 192.168.1.3.ssh: Flags [P.], seq
> 2698:2734, ack 4394, win 271, options [nop,nop,TS val 5450064 ecr
> 2105527458,mptcp dss ack 2562035397 seq 1290518535 subseq 2698 len 36 csum
> 0x7da8], length 36
> 17:58:31.976352 IP 192.168.1.32.60024 > 192.168.1.3.ssh: Flags [.], ack
> 4430, win 271, options [nop,nop,TS val 5450064 ecr 2105527458,mptcp dss a=
ck
> 2562035433], length 0
> 17:58:32.008769 IP 192.168.1.3.ssh > 192.168.1.32.60024: Flags [P.], seq
> 4430:4514, ack 2734, win 291, options [nop,nop,TS val 2105527490 ecr
> 5450064,mptcp dss ack 1290518571 seq 2562035433 subseq 4430 len 84 csum
> 0x4e5], length 84
> =

> > However even then, if the segment that is being retransmitted is due to=
 a
> > partial ack (e.g., the original transmission was 100 bytes, and we rece=
ived
> > an ack for only 50 bytes). We will then only retransmit the remaining 50
> > bytes and thus the relative sequence number won't be the same anymore a=
s in
> > the original transmission.
> The code will do what happens in the current code. Any [re]transmission g=
oes
> through mptcp_skb_entail(), there the mapping will be updated.

Maybe to clarify, I meant TCP-level retransmissions (e.g., due to 3
duplicate acks). Not MPTCP-level retransmissions that are triggered through
the meta-level retransmission timer.

TCP-level retransmissions don't go through mptcp_skb_entail().

> Perhaps I should provide you a patch that you can apply and play with. If
> there are any corner case issues,=C2=A0 I think they can be resolved in t=
he
> retransmission code etc without requiring any change to the size of skb. =
Is
> providing a patch for the latest and greatest MPTCP good enough ?

Yes, patch would be great! Based on either mptcp_trunk or mptcp_v0.93.

I actually, would love to see mptcp_trunk no more bump up sk_buff->cb to 80
bytes. So, you can post it also on the mptcp-dev mailing-list if you think
it is all fine. Make sure to test it with packet-loss, because that's where
I feel is the culprit here.


Christoph

> =

> Shoaib
> =

> > =

> > Christoph
> > =

> > > 15c16
> > > < =C2=A0=C2=A0=C2=A0 if (skb->mptcp_flags & MPTCPHDR_INF)
> > > ---
> > > >  =C2=A0=C2=A0=C2=A0 if (tcb->mptcp_flags & MPTCPHDR_INF)
> > > 17c18
> > > < =C2=A0=C2=A0=C2=A0 else {
> > > ---
> > > >  =C2=A0=C2=A0=C2=A0 else
> > > 19,22d19
> > > < =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /* mptcp_entail_skb adds one =
for FIN */
> > > < =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (tcb->tcp_flags & TCPHDR_F=
IN)
> > > < =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data_len -=
=3D 1;
> > > < =C2=A0=C2=A0=C2=A0 }
> > > 41c38
> > > < =C2=A0=C2=A0=C2=A0 return mptcp_dss_len/sizeof(*ptr);
> > > ---
> > > >  =C2=A0=C2=A0=C2=A0 return ptr - start;
> > > 44,45c41,42
> > > < static int mptcp_write_dss_data_ack(const struct tcp_sock *tp,
> > > <=C2=A0=C2=A0=C2=A0=C2=A0 const struct sk_buff *skb, __be32 *ptr)
> > > ---
> > > > static int mptcp_write_dss_data_ack(const struct tcp_sock *tp, const
> > > struct sk_buff *skb,
> > > >  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 __be32 *ptr)
> > > 62d58
> > > < =C2=A0=C2=A0=C2=A0 /* data_ack */
> > > =

> > > And mptcp_options_write() is now:
> > > =

> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (OPTION_DATA_ACK & opt=
s->mptcp_options) {
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ptr +=3D mptcp_write_dss_data_ack(tp, skb, ptr);
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (mptcp_is_data_seq(skb)) {
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pt=
r +=3D mptcp_write_dss_mapping(tp, skb, ptr);
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 skb->dev =3D NULL;
> > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > =

> > > =

>=20

--===============0755748018222041290==--
