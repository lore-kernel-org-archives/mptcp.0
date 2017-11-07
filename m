Content-Type: multipart/mixed; boundary="===============2836628303612152844=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Retransmission test
Date: Tue, 07 Nov 2017 09:52:40 -0800
Message-ID: <e3558591-92ff-97e4-6087-16848d14b422@oracle.com>
In-Reply-To: 59ef1dcf-d100-c9b9-5e03-4af82a8eee8b@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 155

--===============2836628303612152844==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here we go.

Host .32 running stock MPTCP. I issued following command to randomly =

drop 30% of incoming packets

sudo iptables -A INPUT -m statistic --mode random --probability 0.3 -j DROP

Host .3 is running net-next with my changes (There are a lots of changes =

beside the DSS mapping change)

* First two packets are retransmission as the Receiver dropped the packets

09:25:35.861774 IP 192.168.1.3.45056 > 192.168.1.32.ssh: Flags [P.], seq =

3994:4066, ack 40726, win 1029, options [nop,nop,TS val 3951313247 ecr =

19355434,mptcp dss ack 3605941855 seq 3439198343 subseq 3994 len 72 csum =

0x5107], length 72
09:25:35.935765 IP 192.168.1.3.45056 > 192.168.1.32.ssh: Flags [P.], seq =

3994:4066, ack 40726, win 1029, options [nop,nop,TS val 3951313321 ecr =

19355434,mptcp dss ack 3605941891 seq 3439198343 subseq 3994 len 72 csum =

0x5107], length 72
09:25:35.940562 IP 192.168.1.32.ssh > 192.168.1.3.45056: Flags [P.], seq =

40726:40762, ack 4066, win 272, options [nop,nop,TS val 19356053 ecr =

3951313321,mptcp dss ack 3439198415 seq 3605941891 subseq 40726 len 36 =

csum 0x2a7d], length 36

* First 3 packets go through normally. Than we see re-transmissions.

09:27:18.919496 IP 192.168.1.3.45056 > 192.168.1.32.ssh: Flags [P.], seq =

4422:4458, ack 41262, win 1029, options [nop,nop,TS val 3951416306 ecr =

19381477,mptcp dss ack 3605942427 seq 3439198771 subseq 4422 len 36 csum =

0x4dd3], length 36
09:27:18.920295 IP 192.168.1.32.ssh > 192.168.1.3.45056: Flags [P.], seq =

41262:41298, ack 4458, win 272, options [nop,nop,TS val 19381799 ecr =

3951416306,mptcp dss ack 3439198807 seq 3605942427 subseq 41262 len 36 =

csum 0x48fa], length 36
09:27:18.942893 IP 192.168.1.3.45056 > 192.168.1.32.ssh: Flags [.], ack =

41298, win 1029, options [nop,nop,TS val 3951416330 ecr 19381477,mptcp =

dss ack 3605942463], length 0

09:27:18.967541 IP 192.168.1.3.45056 > 192.168.1.32.ssh: Flags [P.], seq =

4458:4494, ack 41298, win 1029, options [nop,nop,TS val 3951416354 ecr =

19381477,mptcp dss ack 3605942463 seq 3439198807 subseq 4458 len 36 csum =

0x4d8b], length 36
09:27:19.047757 IP 192.168.1.3.45056 > 192.168.1.32.ssh: Flags [P.], seq =

4458:4494, ack 41298, win 1029, options [nop,nop,TS val 3951416435 ecr =

19381477,mptcp dss ack 3605942463 seq 3439198807 subseq 4458 len 36 csum =

0x4d8b], length 36
09:27:19.284083 IP 192.168.1.3.45056 > 192.168.1.32.ssh: Flags [P.], seq =

4458:4494, ack 41298, win 1029, options [nop,nop,TS val 3951416671 ecr =

19381477,mptcp dss ack 3605942463 seq 3439198807 subseq 4458 len 36 csum =

0x4d8b], length 36
09:27:19.284852 IP 192.168.1.32.ssh > 192.168.1.3.45056: Flags [P.], seq =

41298:41334, ack 4494, win 272, options [nop,nop,TS val 19381890 ecr =

3951416671,mptcp dss ack 3439198843 seq 3605942463 subseq 41298 len 36 =

csum 0x9e7e], length 36


09:27:19.289617 IP 192.168.1.3.45056 > 192.168.1.32.ssh: Flags [P.], seq =

4494:4530, ack 41334, win 1029, options [nop,nop,TS val 3951416676 ecr =

19381477,mptcp dss ack 3605942463 seq 3439198843 subseq 4494 len 36 csum =

0x4d43], length 36
09:27:19.363753 IP 192.168.1.3.45056 > 192.168.1.32.ssh: Flags [P.], seq =

4494:4530, ack 41334, win 1029, options [nop,nop,TS val 3951416751 ecr =

19381477,mptcp dss ack 3605942499 seq 3439198843 subseq 4494 len 36 csum =

0x4d43], length 36
09:27:19.368469 IP 192.168.1.32.ssh > 192.168.1.3.45056: Flags [P.], seq =

41334:41370, ack 4530, win 272, options [nop,nop,TS val 19381910 ecr =

3951416751,mptcp dss ack 3439198879 seq 3605942499 subseq 41334 len 36 =

csum 0xafd7], length 36

09:27:19.411741 IP 192.168.1.3.45056 > 192.168.1.32.ssh: Flags [.], ack =

41370, win 1029, options [nop,nop,TS val 3951416755 ecr 19381477,mptcp =

dss ack 3605942535], length 0
09:27:20.375482 IP 192.168.1.3.45056 > 192.168.1.32.ssh: Flags [P.], seq =

4530:4566, ack 41370, win 1029, options [nop,nop,TS val 3951417762 ecr =

19381477,mptcp dss ack 3605942535 seq 3439198879 subseq 4530 len 36 csum =

0x4cfb], length 36
09:27:20.459886 IP 192.168.1.3.45056 > 192.168.1.32.ssh: Flags [P.], seq =

4530:4566, ack 41370, win 1029, options [nop,nop,TS val 3951417847 ecr =

19381477,mptcp dss ack 3605942535 seq 3439198879 subseq 4530 len 36 csum =

0x4cfb], length 36
09:27:21.392076 IP 192.168.1.3.45056 > 192.168.1.32.ssh: Flags [P.], seq =

4530:4566, ack 41370, win 1029, options [nop,nop,TS val 3951418779 ecr =

19381477,mptcp dss ack 3605942535 seq 3439198879 subseq 4530 len 36 csum =

0x4cfb], length 36
09:27:23.248063 IP 192.168.1.3.45056 > 192.168.1.32.ssh: Flags [P.], seq =

4530:4566, ack 41370, win 1029, options [nop,nop,TS val 3951420635 ecr =

19381477,mptcp dss ack 3605942535 seq 3439198879 subseq 4530 len 36 csum =

0x4cfb], length 36
09:27:26.992046 IP 192.168.1.3.45056 > 192.168.1.32.ssh: Flags [P.], seq =

4530:4566, ack 41370, win 1029, options [nop,nop,TS val 3951424379 ecr =

19381477,mptcp dss ack 3605942535 seq 3439198879 subseq 4530 len 36 csum =

0x4cfb], length 36
09:27:31.925768 IP 192.168.1.32.netbios-ns > 192.168.1.255.netbios-ns: =

NBT UDP PACKET(137): QUERY; REQUEST; BROADCAST
09:27:34.416075 IP 192.168.1.3.45056 > 192.168.1.32.ssh: Flags [P.], seq =

4530:4566, ack 41370, win 1029, options [nop,nop,TS val 3951431803 ecr =

19381477,mptcp dss ack 3605942535 seq 3439198879 subseq 4530 len 36 csum =

0x4cfb], length 36
09:27:49.264080 IP 192.168.1.3.45056 > 192.168.1.32.ssh: Flags [P.], seq =

4530:4566, ack 41370, win 1029, options [nop,nop,TS val 3951446651 ecr =

19381477,mptcp dss ack 3605942535 seq 3439198879 subseq 4530 len 36 csum =

0x4cfb], length 36

It took a while to recover from this one but it finally did, =

unfortunately I had quit out of tcpdump.

The only other test left is partial ACK. I will have to hack the kernel =

to simulate than so it will take time.

Shoaib


On 11/07/2017 09:13 AM, Rao Shoaib wrote:
>
>
> On 11/06/2017 08:09 PM, Christoph Paasch wrote:
>>
>> Maybe to clarify, I meant TCP-level retransmissions (e.g., due to 3
>> duplicate acks). Not MPTCP-level retransmissions that are triggered =

>> through
>> the meta-level retransmission timer.
>>
>> TCP-level retransmissions don't go through mptcp_skb_entail().
> Actually they do. When TCP timeout occurs tcp_write_timer_handler() is =

> called
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case ICSK_TIME_RETRANS:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 icsk->icsk_pending =3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 tcp_sk(sk)->ops->retransmit_timer(sk);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 break;
>
> retransmit_timer() for sub sockets is initialized to =

> mptcp_sub_retransmit_timer() which will call mptcp_reinject() except =

> in the fast open case (something that I need to look at). From what I =

> have seen there is no case where a packet is [re]transmitted without =

> going=C2=A0 through mptcp_skb_entail() or else dss will not be updated an=
d =

> the current code will also not work. Anyways, I will try to find some =

> time and test with some packet loss.
>
> If we do find any corner cases I prefer fixing them without exploding =

> the size of skb.
>
> Shoaib
>>
>>> Perhaps I should provide you a patch that you can apply and play =

>>> with. If
>>> there are any corner case issues,=C2=A0 I think they can be resolved in=
 the
>>> retransmission code etc without requiring any change to the size of =

>>> skb. Is
>>> providing a patch for the latest and greatest MPTCP good enough ?
>> Yes, patch would be great! Based on either mptcp_trunk or mptcp_v0.93.
>>
>> I actually, would love to see mptcp_trunk no more bump up sk_buff->cb =

>> to 80
>> bytes. So, you can post it also on the mptcp-dev mailing-list if you =

>> think
>> it is all fine. Make sure to test it with packet-loss, because that's =

>> where
>> I feel is the culprit here.
>>
>>
>> Christoph
>>
>>> Shoaib
>>>
>>>> Christoph
>>>>
>>>>> 15c16
>>>>> < =C2=A0=C2=A0=C2=A0 if (skb->mptcp_flags & MPTCPHDR_INF)
>>>>> ---
>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0 if (tcb->mptcp_flags & MPTCPHDR_INF)
>>>>> 17c18
>>>>> < =C2=A0=C2=A0=C2=A0 else {
>>>>> ---
>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0 else
>>>>> 19,22d19
>>>>> < =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /* mptcp_entail_skb adds one =
for FIN */
>>>>> < =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (tcb->tcp_flags & TCPHDR_F=
IN)
>>>>> < =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data_len -=
=3D 1;
>>>>> < =C2=A0=C2=A0=C2=A0 }
>>>>> 41c38
>>>>> < =C2=A0=C2=A0=C2=A0 return mptcp_dss_len/sizeof(*ptr);
>>>>> ---
>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0 return ptr - start;
>>>>> 44,45c41,42
>>>>> < static int mptcp_write_dss_data_ack(const struct tcp_sock *tp,
>>>>> <=C2=A0=C2=A0=C2=A0=C2=A0 const struct sk_buff *skb, __be32 *ptr)
>>>>> ---
>>>>>> static int mptcp_write_dss_data_ack(const struct tcp_sock *tp, const
>>>>> struct sk_buff *skb,
>>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 __be32 *ptr)
>>>>> 62d58
>>>>> < =C2=A0=C2=A0=C2=A0 /* data_ack */
>>>>>
>>>>> And mptcp_options_write() is now:
>>>>>
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (OPTION_DATA_ACK=
 & opts->mptcp_options) {
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptr +=3D mptcp_write_dss_data_ack(tp, skb, p=
tr);
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mptcp_is_data_seq(skb)) {
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ptr +=3D mptcp_write_dss_mapping(tp, skb, =

>>>>> ptr);
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 skb->dev =3D NULL;
>>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>
>>>>>
>
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp


--===============2836628303612152844==--
