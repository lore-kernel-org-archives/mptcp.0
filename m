Content-Type: multipart/mixed; boundary="===============3866718454900185205=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 1/2] skbuff: Add shared control buffer
Date: Tue, 07 Nov 2017 09:13:21 -0800
Message-ID: <59ef1dcf-d100-c9b9-5e03-4af82a8eee8b@oracle.com>
In-Reply-To: 20171107040913.GE5226@Chimay.local
X-Status: 
X-Keywords:                  
X-UID: 154

--===============3866718454900185205==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 11/06/2017 08:09 PM, Christoph Paasch wrote:
>
> Maybe to clarify, I meant TCP-level retransmissions (e.g., due to 3
> duplicate acks). Not MPTCP-level retransmissions that are triggered throu=
gh
> the meta-level retransmission timer.
>
> TCP-level retransmissions don't go through mptcp_skb_entail().
Actually they do. When TCP timeout occurs tcp_write_timer_handler() is =

called

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ICSK_TIME_RETRANS:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 icsk->icsk_pending =3D 0;
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 tcp_sk(sk)->ops->retransmit_timer(sk);
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 break;

retransmit_timer() for sub sockets is initialized to =

mptcp_sub_retransmit_timer() which will call mptcp_reinject() except in =

the fast open case (something that I need to look at). From what I have =

seen there is no case where a packet is [re]transmitted without going=C2=A0 =

through mptcp_skb_entail() or else dss will not be updated and the =

current code will also not work. Anyways, I will try to find some time =

and test with some packet loss.

If we do find any corner cases I prefer fixing them without exploding =

the size of skb.

Shoaib
>
>> Perhaps I should provide you a patch that you can apply and play with. If
>> there are any corner case issues,=C2=A0 I think they can be resolved in =
the
>> retransmission code etc without requiring any change to the size of skb.=
 Is
>> providing a patch for the latest and greatest MPTCP good enough ?
> Yes, patch would be great! Based on either mptcp_trunk or mptcp_v0.93.
>
> I actually, would love to see mptcp_trunk no more bump up sk_buff->cb to =
80
> bytes. So, you can post it also on the mptcp-dev mailing-list if you think
> it is all fine. Make sure to test it with packet-loss, because that's whe=
re
> I feel is the culprit here.
>
>
> Christoph
>
>> Shoaib
>>
>>> Christoph
>>>
>>>> 15c16
>>>> < =C2=A0=C2=A0=C2=A0 if (skb->mptcp_flags & MPTCPHDR_INF)
>>>> ---
>>>>>   =C2=A0=C2=A0=C2=A0 if (tcb->mptcp_flags & MPTCPHDR_INF)
>>>> 17c18
>>>> < =C2=A0=C2=A0=C2=A0 else {
>>>> ---
>>>>>   =C2=A0=C2=A0=C2=A0 else
>>>> 19,22d19
>>>> < =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /* mptcp_entail_skb adds one f=
or FIN */
>>>> < =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (tcb->tcp_flags & TCPHDR_FI=
N)
>>>> < =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data_len -=
=3D 1;
>>>> < =C2=A0=C2=A0=C2=A0 }
>>>> 41c38
>>>> < =C2=A0=C2=A0=C2=A0 return mptcp_dss_len/sizeof(*ptr);
>>>> ---
>>>>>   =C2=A0=C2=A0=C2=A0 return ptr - start;
>>>> 44,45c41,42
>>>> < static int mptcp_write_dss_data_ack(const struct tcp_sock *tp,
>>>> <=C2=A0=C2=A0=C2=A0=C2=A0 const struct sk_buff *skb, __be32 *ptr)
>>>> ---
>>>>> static int mptcp_write_dss_data_ack(const struct tcp_sock *tp, const
>>>> struct sk_buff *skb,
>>>>>   =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 __be32 *ptr)
>>>> 62d58
>>>> < =C2=A0=C2=A0=C2=A0 /* data_ack */
>>>>
>>>> And mptcp_options_write() is now:
>>>>
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (OPTION_DATA_ACK & opt=
s->mptcp_options) {
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ptr +=3D mptcp_write_dss_data_ack(tp, skb, ptr);
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (mptcp_is_data_seq(skb)) {
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pt=
r +=3D mptcp_write_dss_mapping(tp, skb, ptr);
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 skb->dev =3D NULL;
>>>>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>
>>>>


--===============3866718454900185205==--
