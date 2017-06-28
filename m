Content-Type: multipart/mixed; boundary="===============3012727451203247186=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] Revert tcp_skb_cb to it's original size and
 cleanup main TCP Rx code from MPTCP specific code.
Date: Wed, 28 Jun 2017 13:13:13 -0700
Message-ID: <a64db09f-6e2d-d96a-9653-f3f3ef36fea8@oracle.com>
In-Reply-To: alpine.OSX.2.21.1706271459160.10721@jvshah-mobl3.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 64

--===============3012727451203247186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mat,

Please see my response inline


On 06/27/2017 04:22 PM, Mat Martineau wrote:
>
> Hi Rao,
>
> On Mon, 26 Jun 2017, Rao Shoaib wrote:
>
>> This patch returns tcp_skb_cb to it's original size. It also =

>> refactors MPTCP code so that there are no MPTCP checks in the main Rx =

>> pathi, no performance overheads such as cpu prodiction issues. =

>> tcp_v4_rcv() and tcp_v4_do_rcv() do not have any MPTCP specific =

>> checks any more, niether does tcp_ack(). On the Rx path MPTCP options =

>> are not parsed till the data is being pushed up to the meta socket =

>> (mptcp_data_ready). on the Tx side there is one check to add MPTCP =

>> specific options but that's it, that should not be that bad as for =

>> regular TCP it is a simple check, but it would be good to remove it..
>>
>> I have tested the changes with ndiffports set to 2, so join works. I =

>> have also tested accessing multipath-tcp.org and downloading files =

>> from there and also ran the speed test.
>>
>> The Bad:
>>
>> The error cases still have MPTCP checks but that should be OK as they =

>> are error cases. I had to use a special marker 0xFEE1DEAD for =

>> indicate a special case. I had to introdue a new socket specfic =

>> function. IPv6 has not been changed yet. I am sure I have missed some =

>> corner cases and more testing will reveal more issues but we just =

>> have to fix them.
>>
>> I would like to hear comments from the list and if this direction =

>> seems reasonable we can take this as the starting point, port it to =

>> latest Linux and share the design with the mainstream folks.
>
> I've read the earlier messages in this thread, so I've seen =

> Christoph's concern about zero-length packets and your comment that =

> more work is needed.
>
> The TCP option handling patch I posted earlier (I'm testing an updated =

> version of that before sending it out again) might help us avoid =

> passing unexpected zero-length packets up the stack.
Christoph has elaborated his concerns. His concern is not about zero =

length packets going up the stack (there is no issue with that), instead =

he is concerned about some packets not making up the stack and onto =

MPTCP,  for that there are solutions.

>
> My coworkers and I have some ideas for other upstream-friendly =

> architecture changes, but I still need to type those up for mailing =

> list discussion. We've done some work building up from the current =

> net-next kernel and will get some patches in shape for this list.
>
> I have some comments below:
>
>
>>
>>
>
> I think the maintainers will oppose placement of protocol-specific =

> fields in struct sk_buff.

I don't see this as an issue at all. As you point out below, UDP is =

already using it. There is a reason why they named it dev_scratch.

union {
                 struct net_device       *dev;
                 /* Some protocols might use this space to store =

information,
                  * while device pointer would be NULL.
                  * UDP receive path is one user.
                  */
                 unsigned long           dev_scratch;
         };

In the patch the field is being used when dev is null. It would have =

been legal to overload this field even if the change had not been made =

upstream, we missed the chance to be the first one :-(.

> Recent kernels have changed this to a union between the dev pointer =

> and a dev_scratch integer. So far dev_scratch is only used by UDP.

>
>
>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>> index 655ecd4..cbe8ef2 100644
>> --- a/include/net/tcp.h
>> +++ b/include/net/tcp.h
>> @@ -47,6 +47,9 @@
>> #include <linux/seq_file.h>
>> #include <linux/memcontrol.h>
>>
>> +typedef int (* process_unclaimed)(struct sock *sk, struct sk_buff =

>> *skb);
>> +extern process_unclaimed tcp_process_unclaimed;
>> +
>> extern struct inet_hashinfo tcp_hashinfo;
>>
>> extern struct percpu_counter tcp_orphan_count;
>> @@ -581,6 +584,7 @@ struct sock *tcp_v4_syn_recv_sock(struct sock =

>> *sk, struct sk_buff *skb,
>>                   struct request_sock *req,
>>                   struct dst_entry *dst);
>> int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb);
>> +
>> int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int =

>> addr_len);
>> int tcp_connect(struct sock *sk);
>> struct sk_buff *tcp_make_synack(struct sock *sk, struct dst_entry *dst,
>> @@ -842,11 +846,6 @@ struct tcp_skb_cb {
>>         __u32        tcp_gso_segs;
>>     };
>>
>> -#ifdef CONFIG_MPTCP
>> -    __u8        mptcp_flags;    /* flags for the MPTCP layer */
>> -    __u8        dss_off;    /* Number of 4-byte words until
>> -                     * seq-number */
>> -#endif
>>     __u8        tcp_flags;    /* TCP header flags. (tcp[13]) */
>>
>>     __u8        sacked;        /* State flags for SACK/FACK. */
>> @@ -859,9 +858,13 @@ struct tcp_skb_cb {
>> #define TCPCB_RETRANS (TCPCB_SACKED_RETRANS|TCPCB_EVER_RETRANS| \
>>                 TCPCB_REPAIRED)
>>
>> -    __u8        ip_dsfield;    /* IPv4 tos or IPv6 dsfield */
>> +    __u8        ip_dsfield;    /* IPv4 tos or IPv6 dsfield */
>>     /* 1 byte hole */
>> -    __u32        ack_seq;    /* Sequence number ACK'd    */
>> +    union {
>> +        __u32        ack_seq;    /* Sequence number ACK'd */
>> +        __u32         mptcp_data_seq;
>
> ack_seq is only used on incoming packets, and mptcp_data_seq only on =

> outgoing?
Yup, there are three members of this union and none of them are used at =

the same time.
>
>> +        __u32        mptcp_path_mask;
>> +    };
>
> One architectural change we're considering is not sharing sk_buffs =

> between subflows, which would make mptcp_path_mask unnecessary. It =

> would still be necessary to track that information, just not as part =

> of sk_buff.
Any change that reduces the usage of sk_buff is very good. However this =

is not a big issue any more. I prefer we rather look at reducing mptcp =

checks in the main tcp code.

The patch that I have sent should apply cleanly to the net-next as well.

I am looking forward to your patch.

Rao

--===============3012727451203247186==--
