Content-Type: multipart/mixed; boundary="===============8208676631943769997=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] Revert tcp_skb_cb to its original size
Date: Mon, 13 Nov 2017 09:10:56 -0800
Message-ID: <7715e961-b537-18df-7aa5-0309b16409a0@oracle.com>
In-Reply-To: e7486d99-701f-428d-0406-8b4fd14a580e@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 174

--===============8208676631943769997==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 11/09/2017 06:55 AM, Rao Shoaib wrote:
>
>
> On 11/08/2017 06:32 PM, Christoph Paasch wrote:
>> Hello Rao,
>>
>> On 08/11/17 - 13:19:49, Shoaib Rao wrote:
>>> Christoph,
>>>
>>> Following is a patch based on branch mptcp_v0.91.
>>> I have looked into the issue that you pointed out. It is same as the =

>>> partial ACK issue. If there is no partial ack everything will work =

>>> and this patch covers all the non partial ack cases.
>>>
>>> For the partial ACK case the fix is very simple. We can send the =

>>> packet out without any mapping and the previous mapping should cover =

>>> it. We can also update the mapping i.e. care a sub mapping.
>> Indeed, you can omit the DSS-option in these segments.
>>
>> One other case is when you get SACK'd bytes. In that case the size of =

>> the
>> segment also gets reduced and the DSS-mapping length will be wrong.
>>
>> Basically, all you need to store in this skb is the original =

>> data_length of
>> the segment. Are there 16 bytes somewhere that we could use?
>>
>>
>> Christoph
> No, all we need is a bit in the skb to mark the skb to not send out =

> the mapping.=C2=A0 I am looking at other options too.
>
> Shoaib

FYI. The issue has been resolved and tested including SACK. A simple way =

to resolve the issue would have been for the receiver to consider the =

data-seq as a hint for the mapping to be applied. Such a mapping would =

have had to exist and cover the sub-flow sequence numbers.


 =C2=A0 360=C2=A0 IP 192.168.1.32.34274 > 192.168.1.3.ssh: Flags [P.], seq =

468:504, ack 15441, win 551, options [nop,nop,TS val 56864061 ecr =

3089143032,mptcp dss ack 518271459 seq 1105958085 subseq 3310 len 36 =

csum 0xda75], length 36
 =C2=A0 361=C2=A0 IP 192.168.1.3.ssh > 192.168.1.32.34274: Flags [.], ack 5=
04, win =

291, options [nop,nop,TS val 3091810840 ecr 56864061,mptcp dss ack =

1105958121], length 0
 =C2=A0 362=C2=A0 IP 192.168.1.3.ssh > 192.168.1.32.34274: Flags [P.], seq =

15441:15477, ack 504, win 291, options [nop,nop,TS val 3091810898 ecr =

56864061,mptcp dss ack 1105958121 seq 518271459 subseq 20366 len 36 csum =

0x71cc], length 36
 =C2=A0 363=C2=A0 IP 192.168.1.32.34274 > 192.168.1.3.ssh: Flags [.], ack 1=
5462, =

win 551, options [nop,nop,TS val 56864075 ecr 3091810898,mptcp dss ack =

518271459], length 0
 =C2=A0 364=C2=A0 IP 192.168.1.32.34274 > 192.168.1.3.ssh: Flags [P.], seq =

504:540, ack 15462, win 551, options [nop,nop,TS val 56864083 ecr =

3091810898,mptcp dss ack 518271459 seq 1105958121 subseq 3346 len 36 =

csum 0xf34f], length 36
 =C2=A0 365=C2=A0 IP 192.168.1.3.ssh > 192.168.1.32.34274: Flags [.], ack 5=
40, win =

291, options [nop,nop,TS val 3091810960 ecr 56864083,mptcp dss ack =

1105958157], length 0
 =C2=A0 366=C2=A0 IP 192.168.1.3.ssh > 192.168.1.32.34274: Flags [P.], seq =

15477:15513, ack 540, win 291, options [nop,nop,TS val 3091810995 ecr =

56864083,mptcp dss ack 1105958157 seq 518271495 subseq 20402 len 36 csum =

0x7184], length 36
 =C2=A0 367=C2=A0 IP 192.168.1.32.34274 > 192.168.1.3.ssh: Flags [.], ack 1=
5462, =

win 553, options [nop,nop,TS val 56864099 ecr 3091810898,nop,nop,sack 1 =

{15477:15498},mptcp dss ack 518271459], length 0
 =C2=A0 368=C2=A0 IP 192.168.1.32.34274 > 192.168.1.3.ssh: Flags [P.], seq =

540:576, ack 15462, win 553, options [nop,nop,TS val 56864117 ecr =

3091810898,mptcp dss ack 518271459 seq 1105958157 subseq 3382 len 36 =

csum 0x38c], length 36
 =C2=A0 369=C2=A0 IP 192.168.1.3.ssh > 192.168.1.32.34274: Flags [P.], seq =

15477:15513, ack 576, win 291, options [nop,nop,TS val 3091811085 ecr =

56864117,mptcp dss ack 1105958157 seq 518271495 subseq 20402 len 36 csum =

0x7184], length 36
 =C2=A0 370=C2=A0 IP 192.168.1.32.34274 > 192.168.1.3.ssh: Flags [.], ack 1=
5462, =

win 553, options [nop,nop,TS val 56864122 ecr 3091810898,nop,nop,sack 2 =

{15477:15498}{15477:15498},mptcp dss ack 518271459], length 0
 =C2=A0 371=C2=A0 IP 192.168.1.3.ssh > 192.168.1.32.34274: Flags [P.], seq =

15462:15513, ack 576, win 291, options [nop,nop,TS val 3091811321 ecr =

56864122,mptcp dss ack 1105958193 seq 518271480 subseq 20387 len 51 csum =

0x7193], length 51
 =C2=A0 372=C2=A0 IP 192.168.1.32.34274 > 192.168.1.3.ssh: Flags [.], ack 1=
5498, =

win 553, options [nop,nop,TS val 56864181 ecr 3091811321,nop,nop,sack 1 =

{15477:15498},mptcp dss ack 518271531], length 0
 =C2=A0 373=C2=A0 IP 192.168.1.3.ssh > 192.168.1.32.34274: Flags [P.], seq =

15498:15513, ack 576, win 291, options [nop,nop,TS val 3091811809 ecr =

56864181,mptcp dss ack 1105958193 seq 518271516 subseq 20423 len 15 csum =

0x716f], length 15
 =C2=A0 374=C2=A0 IP 192.168.1.32.34274 > 192.168.1.3.ssh: Flags [.], ack 1=
5513, =

win 553, options [nop,nop,TS val 56864303 ecr 3091811809,mptcp dss ack =

518271531], length 0

Shoaib

>>
>>> The Receiver code (detect mapping()) is very implementation based. I =

>>> will change it to accept two more mapping, sub mapping that does not =

>>> violate an existing mapping and a super mapping.
>>>
>>> I will provide that patch later. Also note that the fields used in =

>>> this patch are specific to this release.
>>>
>>> Shoaib
>>>
>>> ---
>>> =C2=A0 include/linux/skbuff.h=C2=A0=C2=A0 |=C2=A0 2 +-
>>> =C2=A0 include/net/tcp.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 32=
 +++++++++-------
>>> =C2=A0 net/mptcp/mptcp_output.c | 97 =

>>> ++++++++++++++++++++++++++++++------------------
>>> =C2=A0 3 files changed, 80 insertions(+), 51 deletions(-)
>>>
>>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>>> index f66cd5e..ca2e26a 100644
>>> --- a/include/linux/skbuff.h
>>> +++ b/include/linux/skbuff.h
>>> @@ -540,7 +540,7 @@ struct sk_buff {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * want to keep them across layers =
you have to do a skb_clone()
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * first. This is owned by whoever =
has the skb queued ATM.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> -=C2=A0=C2=A0=C2=A0 char=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 cb[56] __aligned(8);
>>> +=C2=A0=C2=A0=C2=A0 char=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 cb[48] __aligned(8);
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 _skb_refdst;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (*destructor)(struct sk_buff *skb);
>>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>>> index 655ecd4..b476e86 100644
>>> --- a/include/net/tcp.h
>>> +++ b/include/net/tcp.h
>>> @@ -842,14 +842,18 @@ struct tcp_skb_cb {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcp_gso_segs;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> =C2=A0 -#ifdef CONFIG_MPTCP
>>> -=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptc=
p_flags;=C2=A0=C2=A0=C2=A0 /* flags for the MPTCP layer=C2=A0=C2=A0=C2=A0 */
>>> -=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dss_=
off;=C2=A0=C2=A0=C2=A0 /* Number of 4-byte words until
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * seq-number */
>>> -#endif
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 tcp_flags;=C2=A0=C2=A0=C2=A0 /* TCP header flags. (tcp[13])=C2=A0=C2=
=A0=C2=A0 */
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 sacked;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* State flags for SA=
CK/FACK.=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 /* Below union is fine as the skb will use one or t=
he other
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * The SKB in the rtx queue will set sacked an=
d does not care
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * about dss_off.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Eventually dss_off will not be needed.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +
>>> +=C2=A0=C2=A0=C2=A0 union {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 sacked;=C2=A0=C2=A0=C2=A0 /* State flags for SACK/FAC=
K.=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dss_off;
>>> +=C2=A0=C2=A0=C2=A0 };
>>> =C2=A0 #define TCPCB_SACKED_ACKED=C2=A0=C2=A0=C2=A0 0x01=C2=A0=C2=A0=C2=
=A0 /* SKB ACK'd by a SACK =

>>> block=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0 #define TCPCB_SACKED_RETRANS=C2=A0=C2=A0=C2=A0 0x02=C2=A0=C2=A0=
=C2=A0 /* SKB =

>>> retransmitted=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> =C2=A0 #define TCPCB_LOST=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x0=
4=C2=A0=C2=A0=C2=A0 /* SKB is lost */
>>> @@ -860,8 +864,14 @@ struct tcp_skb_cb {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TCPCB_REPAIRED)
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ip_dsfield;=C2=A0=C2=A0=C2=A0 /* IPv4 tos or IPv6 dsfield=
=C2=A0=C2=A0=C2=A0 */
>>> -=C2=A0=C2=A0=C2=A0 /* 1 byte hole */
>>> -=C2=A0=C2=A0=C2=A0 __u32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ack=
_seq;=C2=A0=C2=A0=C2=A0 /* Sequence number ACK'd=C2=A0=C2=A0=C2=A0 */
>>> +
>>> +=C2=A0=C2=A0=C2=A0 __u8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptc=
p_flags;
>>> +=C2=A0=C2=A0=C2=A0 union {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ack_seq; /* Sequence number ACK'd=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mptcp_data_seq;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u32=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 path_mask;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 };
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 union {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 union {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct inet_skb_parm=C2=A0=C2=A0=C2=A0 h4;
>>> @@ -869,12 +879,6 @@ struct tcp_skb_cb {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct inet6_skb_parm=C2=A0=C2=A0=C2=A0 h6;
>>> =C2=A0 #endif
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } header;=C2=A0=
=C2=A0=C2=A0 /* For incoming frames=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 */
>>> -#ifdef CONFIG_MPTCP
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 union {=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* For MPTCP outgoing fram=
es */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u=
32 path_mask; /* paths that tried to send this skb */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u=
32 dss[6];=C2=A0=C2=A0=C2=A0 /* DSS options */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> -#endif
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>> =C2=A0 };
>>> =C2=A0 diff --git a/net/mptcp/mptcp_output.c b/net/mptcp/mptcp_output.c
>>> index 691ef6f..5318459 100644
>>> --- a/net/mptcp/mptcp_output.c
>>> +++ b/net/mptcp/mptcp_output.c
>>> @@ -57,34 +57,13 @@ EXPORT_SYMBOL(mptcp_sub_len_remove_addr_align);
>>> =C2=A0 /* get the data-seq and end-data-seq and store them again in the
>>> =C2=A0=C2=A0 * tcp_skb_cb
>>> =C2=A0=C2=A0 */
>>> +/* Rao: May need work */
>>> =C2=A0 static bool mptcp_reconstruct_mapping(struct sk_buff *skb)
>>> =C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0 const struct mp_dss *mpdss =3D (struct mp_dss =

>>> *)TCP_SKB_CB(skb)->dss;
>>> -=C2=A0=C2=A0=C2=A0 u32 *p32;
>>> -=C2=A0=C2=A0=C2=A0 u16 *p16;
>>> -
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!mptcp_is_data_seq(skb))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (!mpdss->M)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>> -
>>> -=C2=A0=C2=A0=C2=A0 /* Move the pointer to the data-seq */
>>> -=C2=A0=C2=A0=C2=A0 p32 =3D (u32 *)mpdss;
>>> -=C2=A0=C2=A0=C2=A0 p32++;
>>> -=C2=A0=C2=A0=C2=A0 if (mpdss->A) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p32++;
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mpdss->a)
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p32=
++;
>>> -=C2=A0=C2=A0=C2=A0 }
>>> -
>>> -=C2=A0=C2=A0=C2=A0 TCP_SKB_CB(skb)->seq =3D ntohl(*p32);
>>> -
>>> -=C2=A0=C2=A0=C2=A0 /* Get the data_len to calculate the end_data_seq */
>>> -=C2=A0=C2=A0=C2=A0 p32++;
>>> -=C2=A0=C2=A0=C2=A0 p32++;
>>> -=C2=A0=C2=A0=C2=A0 p16 =3D (u16 *)p32;
>>> -=C2=A0=C2=A0=C2=A0 TCP_SKB_CB(skb)->end_seq =3D ntohs(*p16) + TCP_SKB_=
CB(skb)->seq;
>>> +=C2=A0=C2=A0=C2=A0 TCP_SKB_CB(skb)->seq =3D TCP_SKB_CB(skb)->mptcp_dat=
a_seq;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>>> =C2=A0 }
>>> @@ -182,7 +161,7 @@ static void __mptcp_reinject_data(struct sk_buff =

>>> *orig_skb, struct sock *meta_sk
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Segment goes back to the MPTCP-layer.=
 So, we need to zero the
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * path_mask/dss.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> -=C2=A0=C2=A0=C2=A0 memset(TCP_SKB_CB(skb)->dss, 0 , mptcp_dss_len);
>>> +=C2=A0=C2=A0=C2=A0 TCP_SKB_CB(skb)->path_mask =3D 0;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* We need to find out the path-m=
ask from the meta-write-queue
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * to properly select a subflow.
>>> @@ -319,25 +298,30 @@ combine:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 }
>>> =C2=A0 -static int mptcp_write_dss_mapping(const struct tcp_sock *tp, =

>>> const struct sk_buff *skb,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __be32 *ptr)
>>> +
>>> +static int mptcp_write_dss_mapping(const struct tcp_sock *tp,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct sk_buff *skb, __be32 *=
ptr)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct tcp_skb_cb *tcb =3D TCP_SKB=
_CB(skb);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __be32 *start =3D ptr;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __u16 data_len;
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 *ptr++ =3D htonl(tcb->seq); /* data_seq */
>>> +=C2=A0=C2=A0=C2=A0 *ptr++ =3D htonl(tcb->mptcp_data_seq); /* data_seq =
*/
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If it's a non-data DATA_FIN, w=
e set subseq to 0 (draft =

>>> v7) */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mptcp_is_data_fin(skb) && skb->len =
=3D=3D 0)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *ptr++ =3D 0; /*=
 subseq */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *ptr++ =3D htonl(tp->write_=
seq - tp->mptcp->snt_isn); /* =

>>> subseq */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *ptr++ =3D htonl(tcb->seq -=
 tp->mptcp->snt_isn); /* subseq */
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (tcb->mptcp_flags & MPTCPHDR_INF)
>>> +=C2=A0=C2=A0=C2=A0 if (tcb->mptcp_flags & MPTCPHDR_INF) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data_len =3D 0;
>>> -=C2=A0=C2=A0=C2=A0 else
>>> +=C2=A0=C2=A0=C2=A0 } else {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data_len =3D tcb=
->end_seq - tcb->seq;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* mptcp_entail_skb adds on=
e for FIN */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (tcb->tcp_flags & TCPHDR=
_FIN)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dat=
a_len -=3D 1;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (tp->mpcb->dss_csum && data_le=
n) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __be16 *p16 =3D =
(__be16 *)ptr;
>>> @@ -395,6 +379,47 @@ static int mptcp_write_dss_data_ack(const =

>>> struct tcp_sock *tp, const struct sk_b
>>> =C2=A0=C2=A0 * To avoid this we save the initial DSS mapping which allo=
ws us to
>>> =C2=A0=C2=A0 * send the same DSS mapping even for fragmented retransmit=
s.
>>> =C2=A0=C2=A0 */
>>> +#if 0
>>> +static int mptcp_write_dss_mapping(const struct tcp_sock *tp, const =

>>> struct sk_buff *skb,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __be32 *ptr)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 const struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
>>> +=C2=A0=C2=A0=C2=A0 __be32 *start =3D ptr;
>>> +=C2=A0=C2=A0=C2=A0 __u16 data_len;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 *ptr++ =3D htonl(tcb->seq); /* data_seq */
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* If it's a non-data DATA_FIN, we set subseq to 0 =
(draft v7) */
>>> +=C2=A0=C2=A0=C2=A0 if (mptcp_is_data_fin(skb) && skb->len =3D=3D 0)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *ptr++ =3D 0; /* subseq */
>>> +=C2=A0=C2=A0=C2=A0 else
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *ptr++ =3D htonl(tp->write_=
seq - tp->mptcp->snt_isn); /* =

>>> subseq */
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (tcb->mptcp_flags & MPTCPHDR_INF)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data_len =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 else
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 data_len =3D tcb->end_seq -=
 tcb->seq;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (tp->mpcb->dss_csum && data_len) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __be16 *p16 =3D (__be16 *)p=
tr;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __be32 hdseq =3D mptcp_get_=
highorder_sndbits(skb, tp->mpcb);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __wsum csum;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *ptr =3D htonl(((data_len) =
<< 16) |
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 (TCPOPT_EOL << 8) |
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 (TCPOPT_EOL));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 csum =3D csum_partial(ptr -=
 2, 12, skb->csum);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p16++;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *p16++ =3D csum_fold(csum_p=
artial(&hdseq, sizeof(hdseq), csum));
>>> +=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *ptr++ =3D htonl(((data_len=
) << 16) |
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (TCPOPT_NOP << 8) |
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (TCPOPT_NOP));
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return ptr - start;
>>> +}
>>> +
>>> =C2=A0 static void mptcp_save_dss_data_seq(const struct tcp_sock *tp, =

>>> struct sk_buff *skb)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tcp_skb_cb *tcb =3D TCP_SKB_CB(sk=
b);
>>> @@ -424,6 +449,7 @@ static int mptcp_write_dss_data_seq(const struct =

>>> tcp_sock *tp, struct sk_buff *s
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return mptcp_dss_len/sizeof(*ptr);
>>> =C2=A0 }
>>> +#endif
>>> =C2=A0 =C2=A0 static bool mptcp_skb_entail(struct sock *sk, struct sk_b=
uff =

>>> *skb, int reinject)
>>> =C2=A0 {
>>> @@ -469,8 +495,8 @@ static bool mptcp_skb_entail(struct sock *sk, =

>>> struct sk_buff *skb, int reinject)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mptcp_is_data_fin(subskb))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mptcp_combine_df=
in(subskb, meta_sk, sk);
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 mptcp_save_dss_data_seq(tp, subskb);
>>> -
>>> +=C2=A0=C2=A0=C2=A0 TCP_SKB_CB(subskb)->mptcp_flags |=3D MPTCPHDR_SEQ;
>>> +=C2=A0=C2=A0=C2=A0 tcb->mptcp_data_seq =3D tcb->seq;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcb->seq =3D tp->write_seq;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Take into account seg len */
>>> @@ -1197,10 +1223,9 @@ void mptcp_options_write(__be32 *ptr, struct =

>>> tcp_sock *tp,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (OPTION_DATA_ACK & opts->mptcp=
_options) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!mptcp_is_data_seq(skb))
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptr=
 +=3D mptcp_write_dss_data_ack(tp, skb, ptr);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptr=
 +=3D mptcp_write_dss_data_seq(tp, skb, ptr);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptr +=3D mptcp_write_dss_da=
ta_ack(tp, skb, ptr);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mptcp_is_data_seq(skb))
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ptr=
 +=3D mptcp_write_dss_mapping(tp, skb, ptr);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(OPTION_MP_PRIO & opts->mptc=
p_options)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mp_prio *=
mpprio =3D (struct mp_prio *)ptr;
>>> -- =

>>> 2.7.4
>>>
>>> _______________________________________________
>>> mptcp mailing list
>>> mptcp(a)lists.01.org
>>> https://lists.01.org/mailman/listinfo/mptcp
>
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp


--===============8208676631943769997==--
