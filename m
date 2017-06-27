Content-Type: multipart/mixed; boundary="===============7618826272802434091=="
MIME-Version: 1.0
From: Rao Shoaib <rao.shoaib at oracle.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] Revert tcp_skb_cb to it's original size and
 cleanup main TCP Rx code from MPTCP specific code.
Date: Tue, 27 Jun 2017 11:51:21 -0700
Message-ID: <613f420f-a82e-2a7e-38bc-143578a9305a@oracle.com>
In-Reply-To: 36D29114-D74E-4650-8445-4DC0CA6C2487@apple.com
X-Status: 
X-Keywords:                  
X-UID: 54

--===============7618826272802434091==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 06/27/2017 10:37 AM, Christoph Paasch wrote:
> Hello Rao,
>
>> On Jun 27, 2017, at 10:22 AM, Rao Shoaib <rao.shoaib(a)oracle.com =

>> <mailto:rao.shoaib(a)oracle.com>> wrote:
>>
>> Hi Christoph,
>>
>>
>> On 06/26/2017 11:27 PM, Christoph Paasch wrote:
>>> Hello Rao,
>>>
>>> can you try to give some more details on how the datapath looks like =

>>> with
>>> this patch?
>>>
>>> For example, I wonder how data-acks are being processed. Because, I =

>>> see in
>>> mptcp_data_ready, that you now expects skbs with len 0, upon which =

>>> you end
>>> up calling mptcp_process_ack().
>>>
>>> I don't see how such zero-length skbs could end up in the =

>>> receive-queue of
>>> the subflows.
>>>
>>>
>>> Thanks,
>>
>> I send every packet that is coming on an MPTCP based socket down and =

>> let MPTCP deal with it. In tcp data_queue(). I also removed the =

>> directive to go to the slow_path in tcp_rcv_established().
>>
>> static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
>> {
>>        struct tcp_sock *tp =3D tcp_sk(sk);
>>        int eaten =3D -1;
>>        bool fragstolen =3D false;
>>
>>        /*
>>         * send every packet to MPTCP
>>         */
>>        if (!mptcp(tp) && (TCP_SKB_CB(skb)->seq =3D=3D =

>> TCP_SKB_CB(skb)->end_seq)) {
>>                goto drop;
>>        }
>>
>> There is only one case that I need investigate more is the following. =

>>  In that the he only interesting case is (len =3D=3D tcp_header_len) but =

>> in my unidirectional bulk data transfer tests I did not hit that =

>> case. So I need to investigate more later. The last resort would be =

>> to just directly go to the slow path.
>>
>> if (len <=3D tcp_header_len) { /* Bulk data transfer: sender */
>>
>>                         if (len =3D=3D tcp_header_len) {
>
> The problem is, how are these zero-len packets being queued in the =

> receive-queue of the socket ? I am pretty sure that TCP won't like =

> having such packets in the receive-queue, which means there will be =

> quite some changes needed to support this.
I don't understand why there are any changes needed to TCP, these packet =

will be handled in mptcp_data_ready() and discarded, just like TCP  does =

with a pure ack. Please note that we only do this for MPTCP sockets not =

just any TCP socket.
>
> I might be missing something here. A high-level description with some =

> call-stacks of how the data-path looks like with your patch would be good.
It's actually very straight forward, normally in tcp_data_queue() a pure =

ack is simply dropped as TCP state has been updated and the packet is of =

no use. In case of MPTCP we force the packet to be delivered to the meta =

socket queue (See the mptcp check in the if statement). When =

mptcp_data_ready()  processes the packet it, updates MPTCP state, frees =

packets that have been acked and than throws away the packet.

If you wanted for some reason to do this with regular TCP, you could =

very well as long as the socket Rx function knows how to deal these =

packets.

Can you be more specific about what TCP queue will have issues because =

at this point the packet is headed to the socket queue.

If you prefer a stack trace, I can instrument the kernel with WARN_ON =

directive and get you one, that is the only way I know to get one in =

Linux. In Solaris it would be a 2 min operation on a running system. If =

there is a better way than please educate me.

> Or maybe try to split the patch in separate pieces.
That would be difficult because everything is tied together. If you =

prefer I can provide you with a tar ball of the source, you can look at =

it, compile and run it.

I am actually wondering how folks do code review on Linux based on the =

patch that is submitted. There is no context diff or anything else, I am =

used to very sophisticated tools.
>
>>
>> If there are other issues than let me know and I will work on =

>> resolving them. We obviously need to run extensive tests, that brings =

>> me to the question of, how does the MPTCP development team test =

>> changes. We need the same tests to validate the changes.
>
> packetdrill is the best tool to reproduce specific scenarios: =

> https://github.com/cpaasch/packetdrill_mptcp (tests are in there in =

> example/mptcp/).
>
> And, a testing-script is at =

> https://github.com/multipath-tcp/mptcp-scripts/tree/master/testing.
> It does a bunch of stress-testing (iperf, haproxy, =

> apache-benchmark,...) on three machines that need to be =

> inter-connected in a specific way. It's a bit tricky to setup. I have =

> KVMs that I boot that have two links between each other. One is the =

> client, one the router (sometimes acting as a haproxy), one is the =

> server. They need tools like ab, apache, haproxy, iperf,...
Well I do not have 3 machines and my system will die if I started 3 =

KVM's. Let me see what I can get.

Thanks,

Rao.
>
>
> Christoph
>
>>
>> Rao.
>>
>>> Christoph
>>>
>>>
>>> On 26/06/17 - 15:34:09, Rao Shoaib wrote:
>>>> I forgot to mention two things
>>>>
>>>> 1) Connection setup still has checks for MPTCP, Ideally these should be
>>>> removed but at least we need to run some benchmarks and fix any =

>>>> issues. The
>>>> mainstream folks will not accept any performance degradation in =

>>>> TCP. I can
>>>> look into this next.
>>>>
>>>> 2) The code overloads dev field of skb, when it is not being used. IIRC
>>>> there is precedence for this already. I will try to find it.
>>>>
>>>> Rao
>>>>
>>>>
>>>> On 06/26/2017 02:13 PM, Rao Shoaib wrote:
>>>>> This patch returns tcp_skb_cb to it's original size. It also =

>>>>> refactors MPTCP code so that there are no MPTCP checks in the main =

>>>>> Rx pathi, no performance overheads such as cpu prodiction issues. =

>>>>> tcp_v4_rcv() and tcp_v4_do_rcv() do not have any MPTCP specific =

>>>>> checks any more, niether does tcp_ack(). On the Rx path MPTCP =

>>>>> options are not parsed till the data is being pushed up to the =

>>>>> meta socket (mptcp_data_ready). on the Tx side there is one check =

>>>>> to add MPTCP specific options but that's it, that should not be =

>>>>> that bad as for regular TCP it is a simple check, but it would be =

>>>>> good to remove it..
>>>>>
>>>>> I have tested the changes with ndiffports set to 2, so join works. =

>>>>> I have also tested accessing multipath-tcp.org =

>>>>> <http://multipath-tcp.org> and downloading files from there and =

>>>>> also ran the speed test.
>>>>>
>>>>> The Bad:
>>>>>
>>>>> The error cases still have MPTCP checks but that should be OK as =

>>>>> they are error cases. I had to use a special marker 0xFEE1DEAD for =

>>>>> indicate a special case. I had to introdue a new socket specfic =

>>>>> function. IPv6 has not been changed yet. I am sure I have missed =

>>>>> some corner cases and more testing will reveal more issues but we =

>>>>> just have to fix them.
>>>>>
>>>>> I would like to hear comments from the list and if this direction =

>>>>> seems reasonable we can take this as the starting point, port it =

>>>>> to latest Linux and share the design with the mainstream folks.
>>>>>
>>>>> Signed-off-by: Rao Shoaib <rao.shoaib(a)oracle.com =

>>>>> <mailto:rao.shoaib(a)oracle.com>>
>>>>> ---
>>>>>   include/linux/skbuff.h      |   8 ++-
>>>>>   include/net/mptcp.h         |  21 +++---
>>>>>   include/net/mptcp_v4.h      |   1 +
>>>>>   include/net/sock.h          |  12 +++-
>>>>>   include/net/tcp.h           |  23 +++----
>>>>>   net/ipv4/af_inet.c          |   4 ++
>>>>>   net/ipv4/tcp_input.c        |  37 ++--------
>>>>>   net/ipv4/tcp_ipv4.c         | 135 =

>>>>> +++++++++++++++++++++++--------------
>>>>>   net/ipv4/tcp_output.c       |   1 +
>>>>>   net/ipv6/af_inet6.c         |   4 ++
>>>>>   net/ipv6/tcp_ipv6.c         |   4 --
>>>>>   net/mptcp/mptcp_ctrl.c      |  21 ++++++
>>>>>   net/mptcp/mptcp_input.c     | 131 =

>>>>> ++++++++++++++++++++++++++++--------
>>>>>   net/mptcp/mptcp_ipv4.c      |  35 +---------
>>>>>   net/mptcp/mptcp_ipv6.c      |   4 +-
>>>>>   net/mptcp/mptcp_output.c    | 160 =

>>>>> +++++++++++++++++---------------------------
>>>>>   net/mptcp/mptcp_redundant.c |   6 +-
>>>>>   net/mptcp/mptcp_rr.c        |   4 +-
>>>>>   net/mptcp/mptcp_sched.c     |  10 +--
>>>>>   19 files changed, 335 insertions(+), 286 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
>>>>> index f66cd5e..348cbc1 100644
>>>>> --- a/include/linux/skbuff.h
>>>>> +++ b/include/linux/skbuff.h
>>>>> @@ -532,7 +532,13 @@ struct sk_buff {
>>>>> struct rb_noderbnode; /* used in netem & tcp stack */
>>>>> };
>>>>> struct sock*sk;
>>>>> -struct net_device*dev;
>>>>> +union {
>>>>> +struct net_device*dev;
>>>>> +struct {
>>>>> +__u8 mptcp_flags;
>>>>> +__u8 mptcp_dss_off;
>>>>> +};
>>>>> +};
>>>>> /*
>>>>> * This is the control buffer. It is free to use for every
>>>>> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
>>>>> index 876f1e6..d087cb4 100644
>>>>> --- a/include/net/mptcp.h
>>>>> +++ b/include/net/mptcp.h
>>>>> @@ -807,7 +807,7 @@ void tcp_parse_mptcp_options(const struct =

>>>>> sk_buff *skb,
>>>>>     struct mptcp_options_received *mopt);
>>>>>   void mptcp_parse_options(const uint8_t *ptr, int opsize,
>>>>> struct mptcp_options_received *mopt,
>>>>> -const struct sk_buff *skb,
>>>>> +struct sk_buff *skb,
>>>>> struct tcp_sock *tp);
>>>>>   void mptcp_syn_options(const struct sock *sk, struct =

>>>>> tcp_out_options *opts,
>>>>>       unsigned *remaining);
>>>>> @@ -998,14 +998,15 @@ static inline void =

>>>>> mptcp_sub_force_close_all(struct mptcp_cb *mpcb,
>>>>> }
>>>>>   }
>>>>> +/* currently tp is being used for Rx packets */
>>>>>   static inline bool mptcp_is_data_seq(const struct sk_buff *skb)
>>>>>   {
>>>>> -return TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_SEQ;
>>>>> +return skb->mptcp_flags & MPTCPHDR_SEQ;
>>>>>   }
>>>>>   static inline bool mptcp_is_data_fin(const struct sk_buff *skb)
>>>>>   {
>>>>> -return TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_FIN;
>>>>> +return skb->mptcp_flags & MPTCPHDR_FIN;
>>>>>   }
>>>>>   /* Is it a data-fin while in infinite mapping mode?
>>>>> @@ -1034,17 +1035,17 @@ static inline u8 mptcp_get_64_bit(u64 =

>>>>> data_seq, struct mptcp_cb *mpcb)
>>>>>   /* Sets the data_seq and returns pointer to the in-skb field of =

>>>>> the data_seq.
>>>>>    * If the packet has a 64-bit dseq, the pointer points to the =

>>>>> last 32 bits.
>>>>>    */
>>>>> -static inline __u32 *mptcp_skb_set_data_seq(const struct sk_buff =

>>>>> *skb,
>>>>> +static inline __u32 *mptcp_skb_set_data_seq(struct sk_buff *skb,
>>>>>    u32 *data_seq,
>>>>>    struct mptcp_cb *mpcb)
>>>>>   {
>>>>> -__u32 *ptr =3D (__u32 *)(skb_transport_header(skb) + =

>>>>> TCP_SKB_CB(skb)->dss_off);
>>>>> +__u32 *ptr =3D (__u32 *)(skb_transport_header(skb) + =

>>>>> skb->mptcp_dss_off);
>>>>> -if (TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_SEQ64_SET) {
>>>>> +if (skb->mptcp_flags & MPTCPHDR_SEQ64_SET) {
>>>>> u64 data_seq64 =3D get_unaligned_be64(ptr);
>>>>> if (mpcb)
>>>>> -TCP_SKB_CB(skb)->mptcp_flags |=3D mptcp_get_64_bit(data_seq64, mpcb);
>>>>> +skb->mptcp_flags |=3D mptcp_get_64_bit(data_seq64, mpcb);
>>>>> *data_seq =3D (u32)data_seq64;
>>>>> ptr++;
>>>>> @@ -1142,7 +1143,7 @@ static inline void mptcp_reset_mopt(struct =

>>>>> tcp_sock *tp)
>>>>>   static inline __be32 mptcp_get_highorder_sndbits(const struct =

>>>>> sk_buff *skb,
>>>>> const struct mptcp_cb *mpcb)
>>>>>   {
>>>>> -return htonl(mpcb->snd_high_order[(TCP_SKB_CB(skb)->mptcp_flags &
>>>>> +return htonl(mpcb->snd_high_order[(skb->mptcp_flags &
>>>>> MPTCPHDR_SEQ64_INDEX) ? 1 : 0]);
>>>>>   }
>>>>> @@ -1404,8 +1405,8 @@ static inline void mptcp_set_rto(const =

>>>>> struct sock *sk) {}
>>>>>   static inline void mptcp_send_fin(const struct sock *meta_sk) {}
>>>>>   static inline void mptcp_parse_options(const uint8_t *ptr, const =

>>>>> int opsize,
>>>>>       struct mptcp_options_received *mopt,
>>>>> -      const struct sk_buff *skb,
>>>>> -      const struct tcp_sock *tp) {}
>>>>> +      struct sk_buff *skb,
>>>>> +      struct tcp_sock *tp) {}
>>>>>   static inline void mptcp_syn_options(const struct sock *sk,
>>>>>     struct tcp_out_options *opts,
>>>>>     unsigned *remaining) {}
>>>>> diff --git a/include/net/mptcp_v4.h b/include/net/mptcp_v4.h
>>>>> index c83dca0..46394a4 100644
>>>>> --- a/include/net/mptcp_v4.h
>>>>> +++ b/include/net/mptcp_v4.h
>>>>> @@ -45,6 +45,7 @@ extern struct tcp_request_sock_ops =

>>>>> mptcp_join_request_sock_ipv4_ops;
>>>>>   #ifdef CONFIG_MPTCP
>>>>>   int mptcp_v4_do_rcv(struct sock *meta_sk, struct sk_buff *skb);
>>>>> +int mptcp_v4_process_join_req(struct sock *meta_sk, struct =

>>>>> sk_buff *skb);
>>>>>   struct sock *mptcp_v4_search_req(const __be16 rport, const =

>>>>> __be32 raddr,
>>>>> const __be32 laddr, const struct net *net);
>>>>>   int mptcp_init4_subsockets(struct sock *meta_sk, const struct =

>>>>> mptcp_loc4 *loc,
>>>>> diff --git a/include/net/sock.h b/include/net/sock.h
>>>>> index 0f12593..0d1bda5 100644
>>>>> --- a/include/net/sock.h
>>>>> +++ b/include/net/sock.h
>>>>> @@ -296,6 +296,7 @@ struct cg_proto;
>>>>>     *@sk_write_space: callback to indicate there is bf sending =

>>>>> space available
>>>>>     *@sk_error_report: callback to indicate errors (e.g. =

>>>>> %MSG_ERRQUEUE)
>>>>>     *@sk_backlog_rcv: callback to process the backlog
>>>>> +  *@sk_prequeue: callback to prequeue
>>>>>     *@sk_destruct: called at sock freeing time, i.e. when all =

>>>>> refcnt =3D=3D 0
>>>>>    */
>>>>>   struct sock {
>>>>> @@ -437,7 +438,9 @@ struct sock {
>>>>> void(*sk_write_space)(struct sock *sk);
>>>>> void(*sk_error_report)(struct sock *sk);
>>>>> int(*sk_backlog_rcv)(struct sock *sk,
>>>>> - struct sk_buff *skb);
>>>>> +struct sk_buff *skb);
>>>>> +bool(*sk_prequeue)(struct sock *sk,
>>>>> +struct sk_buff *skb);
>>>>> void                    (*sk_destruct)(struct sock *sk);
>>>>>   };
>>>>> @@ -853,6 +856,11 @@ static inline int sk_backlog_rcv(struct sock =

>>>>> *sk, struct sk_buff *skb)
>>>>> return sk->sk_backlog_rcv(sk, skb);
>>>>>   }
>>>>> +static inline bool sk_prequeue(struct sock *sk, struct sk_buff *skb)
>>>>> +{
>>>>> +return (false);
>>>>> +}
>>>>> +
>>>>>   static inline void sk_incoming_cpu_update(struct sock *sk)
>>>>>   {
>>>>> sk->sk_incoming_cpu =3D raw_smp_processor_id();
>>>>> @@ -993,6 +1001,8 @@ struct proto {
>>>>> int(*backlog_rcv) (struct sock *sk,
>>>>> struct sk_buff *skb);
>>>>> +bool(*prequeue) (struct sock *sk,
>>>>> +struct sk_buff *skb);
>>>>> void(*release_cb)(struct sock *sk);
>>>>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>>>>> index 655ecd4..cbe8ef2 100644
>>>>> --- a/include/net/tcp.h
>>>>> +++ b/include/net/tcp.h
>>>>> @@ -47,6 +47,9 @@
>>>>>   #include <linux/seq_file.h>
>>>>>   #include <linux/memcontrol.h>
>>>>> +typedef int (* process_unclaimed)(struct sock *sk, struct sk_buff =

>>>>> *skb);
>>>>> +extern process_unclaimed tcp_process_unclaimed;
>>>>> +
>>>>>   extern struct inet_hashinfo tcp_hashinfo;
>>>>>   extern struct percpu_counter tcp_orphan_count;
>>>>> @@ -581,6 +584,7 @@ struct sock *tcp_v4_syn_recv_sock(struct sock =

>>>>> *sk, struct sk_buff *skb,
>>>>>  struct request_sock *req,
>>>>>  struct dst_entry *dst);
>>>>>   int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb);
>>>>> +
>>>>>   int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int =

>>>>> addr_len);
>>>>>   int tcp_connect(struct sock *sk);
>>>>>   struct sk_buff *tcp_make_synack(struct sock *sk, struct =

>>>>> dst_entry *dst,
>>>>> @@ -842,11 +846,6 @@ struct tcp_skb_cb {
>>>>> __u32tcp_gso_segs;
>>>>> };
>>>>> -#ifdef CONFIG_MPTCP
>>>>> -__u8mptcp_flags;/* flags for the MPTCP layer    */
>>>>> -__u8dss_off;/* Number of 4-byte words until
>>>>> -* seq-number */
>>>>> -#endif
>>>>> __u8tcp_flags;/* TCP header flags. (tcp[13])*/
>>>>> __u8sacked;/* State flags for SACK/FACK.*/
>>>>> @@ -859,9 +858,13 @@ struct tcp_skb_cb {
>>>>>   #define TCPCB_RETRANS(TCPCB_SACKED_RETRANS|TCPCB_EVER_RETRANS| \
>>>>> TCPCB_REPAIRED)
>>>>> -__u8ip_dsfield;/* IPv4 tos or IPv6 dsfield*/
>>>>> +__u8ip_dsfield;/* IPv4 tos or IPv6 dsfield */
>>>>> /* 1 byte hole */
>>>>> -__u32ack_seq;/* Sequence number ACK'd*/
>>>>> +union {
>>>>> +__u32ack_seq;/* Sequence number ACK'd */
>>>>> +__u32 mptcp_data_seq;
>>>>> +__u32mptcp_path_mask;
>>>>> +};
>>>>> union {
>>>>> union {
>>>>> struct inet_skb_parmh4;
>>>>> @@ -869,12 +872,6 @@ struct tcp_skb_cb {
>>>>> struct inet6_skb_parmh6;
>>>>>   #endif
>>>>> } header;/* For incoming frames*/
>>>>> -#ifdef CONFIG_MPTCP
>>>>> -union {/* For MPTCP outgoing frames */
>>>>> -__u32 path_mask; /* paths that tried to send this skb */
>>>>> -__u32 dss[6];/* DSS options */
>>>>> -};
>>>>> -#endif
>>>>> };
>>>>>   };
>>>>> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
>>>>> index 73480b9..1e7827f 100644
>>>>> --- a/net/ipv4/af_inet.c
>>>>> +++ b/net/ipv4/af_inet.c
>>>>> @@ -356,6 +356,10 @@ lookup_protocol:
>>>>> sk->sk_destruct  =3D inet_sock_destruct;
>>>>> sk->sk_protocol  =3D protocol;
>>>>> sk->sk_backlog_rcv =3D sk->sk_prot->backlog_rcv;
>>>>> +sk->sk_prequeue =3D sk->sk_prot->prequeue;
>>>>> +if (sk->sk_prequeue =3D=3D NULL) {
>>>>> +sk->sk_prequeue =3D sk_prequeue;
>>>>> +}
>>>>> inet->uc_ttl=3D -1;
>>>>> inet->mc_loop=3D 1;
>>>>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>>>>> index 16a7256..cb6bbf9 100644
>>>>> --- a/net/ipv4/tcp_input.c
>>>>> +++ b/net/ipv4/tcp_input.c
>>>>> @@ -3133,8 +3133,6 @@ static int tcp_clean_rtx_queue(struct sock =

>>>>> *sk, int prior_fackets,
>>>>> */
>>>>> if (likely(!(scb->tcp_flags & TCPHDR_SYN))) {
>>>>> flag |=3D FLAG_DATA_ACKED;
>>>>> -if (mptcp(tp) && mptcp_is_data_seq(skb))
>>>>> -flag |=3D MPTCP_FLAG_DATA_ACKED;
>>>>> } else {
>>>>> flag |=3D FLAG_SYN_ACKED;
>>>>> tp->retrans_stamp =3D 0;
>>>>> @@ -3582,16 +3580,6 @@ static int tcp_ack(struct sock *sk, struct =

>>>>> sk_buff *skb, int flag)
>>>>>    sack_rtt_us);
>>>>> acked -=3D tp->packets_out;
>>>>> -if (mptcp(tp)) {
>>>>> -if (mptcp_fallback_infinite(sk, flag)) {
>>>>> -pr_err("%s resetting flow\n", __func__);
>>>>> -mptcp_send_reset(sk);
>>>>> -goto invalid_ack;
>>>>> -}
>>>>> -
>>>>> -mptcp_clean_rtx_infinite(skb, sk);
>>>>> -}
>>>>> -
>>>>> /* Advance cwnd if state allows */
>>>>> if (tcp_may_raise_cwnd(sk, flag))
>>>>> tcp_cong_avoid(sk, ack, acked);
>>>>> @@ -3824,8 +3812,7 @@ static bool tcp_fast_parse_options(const =

>>>>> struct sk_buff *skb,
>>>>> if (tcp_parse_aligned_timestamp(tp, th))
>>>>> return true;
>>>>> }
>>>>> -tcp_parse_options(skb, &tp->rx_opt,
>>>>> - mptcp(tp) ? &tp->mptcp->rx_opt : NULL, 1, NULL, tp);
>>>>> +tcp_parse_options(skb, &tp->rx_opt, NULL, 1, NULL, tp);
>>>>> if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr)
>>>>> tp->rx_opt.rcv_tsecr -=3D tp->tsoffset;
>>>>> @@ -4550,11 +4537,12 @@ static void tcp_data_queue(struct sock =

>>>>> *sk, struct sk_buff *skb)
>>>>> int eaten =3D -1;
>>>>> bool fragstolen =3D false;
>>>>> -/* If no data is present, but a data_fin is in the options, we still
>>>>> -* have to call mptcp_queue_skb later on. */
>>>>> -if (TCP_SKB_CB(skb)->seq =3D=3D TCP_SKB_CB(skb)->end_seq &&
>>>>> -   !(mptcp(tp) && mptcp_is_data_fin(skb)))
>>>>> +/*
>>>>> +* send every packet to MPTCP
>>>>> +*/
>>>>> +if (!mptcp(tp) && (TCP_SKB_CB(skb)->seq =3D=3D =

>>>>> TCP_SKB_CB(skb)->end_seq)) {
>>>>> goto drop;
>>>>> +}
>>>>> skb_dst_drop(skb);
>>>>> __skb_pull(skb, tcp_hdr(skb)->doff * 4);
>>>>> @@ -5242,15 +5230,9 @@ syn_challenge:
>>>>> goto discard;
>>>>> }
>>>>> -/* If valid: post process the received MPTCP options. */
>>>>> -if (mptcp(tp) && mptcp_handle_options(sk, th, skb))
>>>>> -goto discard;
>>>>> -
>>>>> return true;
>>>>>   discard:
>>>>> -if (mptcp(tp))
>>>>> -mptcp_reset_mopt(tp);
>>>>> __kfree_skb(skb);
>>>>> return false;
>>>>>   }
>>>>> @@ -5302,10 +5284,6 @@ void tcp_rcv_established(struct sock *sk, =

>>>>> struct sk_buff *skb,
>>>>> tp->rx_opt.saw_tstamp =3D 0;
>>>>> -/* MPTCP: force slowpath. */
>>>>> -if (mptcp(tp))
>>>>> -goto slow_path;
>>>>> -
>>>>> /*pred_flags is 0xS?10 << 16 + snd_wnd
>>>>> *if header_prediction is to be made
>>>>> *'S' will always be tp->tcp_header_len >> 2
>>>>> @@ -5585,8 +5563,7 @@ static int =

>>>>> tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
>>>>> struct mptcp_options_received mopt;
>>>>> mptcp_init_mp_opt(&mopt);
>>>>> -tcp_parse_options(skb, &tp->rx_opt,
>>>>> - mptcp(tp) ? &tp->mptcp->rx_opt : &mopt, 0, &foc, tp);
>>>>> +tcp_parse_options(skb, &tp->rx_opt, &mopt, 0, &foc, tp);
>>>>> if (tp->rx_opt.saw_tstamp && tp->rx_opt.rcv_tsecr)
>>>>> tp->rx_opt.rcv_tsecr -=3D tp->tsoffset;
>>>>> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
>>>>> index 6967a86..3329679 100644
>>>>> --- a/net/ipv4/tcp_ipv4.c
>>>>> +++ b/net/ipv4/tcp_ipv4.c
>>>>> @@ -1420,6 +1420,71 @@ struct sock *tcp_v4_hnd_req(struct sock =

>>>>> *sk, struct sk_buff *skb)
>>>>> return sk;
>>>>>   }
>>>>> +int mptcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
>>>>> +{
>>>>> +struct net *net =3D dev_net(skb->dev);
>>>>> +const struct tcphdr *th =3D tcp_hdr(skb);
>>>>> +int ret;
>>>>> +struct sock *meta_sk;
>>>>> +
>>>>> +if (sk =3D=3D NULL) {
>>>>> +if (th->syn && !th->ack) {
>>>>> +int ret =3D mptcp_lookup_join(skb, NULL);
>>>>> +
>>>>> +if (ret < 0) {
>>>>> +tcp_v4_send_reset(NULL, skb);
>>>>> +kfree_skb(skb);
>>>>> +return (1);
>>>>> +} else if (ret > 0) {
>>>>> +return (1);
>>>>> +}
>>>>> +}
>>>>> +/* Is there a pending request sock for this segment ? */
>>>>> +if (mptcp_check_req(skb, net)) {
>>>>> +return(1);
>>>>> +}
>>>>> +return (0);
>>>>> +}
>>>>> +
>>>>> +/* The socket passed in should never be the meta socket */
>>>>> +
>>>>> +BUG_ON(is_meta_sk(sk));
>>>>> +
>>>>> +        /* Is there a pending request sock for this segment ? */
>>>>> +if (sk->sk_state =3D=3D TCP_LISTEN && mptcp_check_req(skb, net)) {
>>>>> +return 0;
>>>>> +}
>>>>> +
>>>>> +skb->dev =3D NULL;
>>>>> +meta_sk =3D mptcp_meta_sk(sk);
>>>>> +
>>>>> +ret =3D 0;
>>>>> +skb->sk =3D sk;
>>>>> +bh_lock_sock_nested(meta_sk);
>>>>> +if (sock_owned_by_user(meta_sk)) {
>>>>> +if (unlikely(sk_add_backlog(meta_sk, skb,
>>>>> +   meta_sk->sk_rcvbuf + meta_sk->sk_sndbuf))) {
>>>>> +
>>>>> +NET_INC_STATS_BH(net, LINUX_MIB_TCPBACKLOGDROP);
>>>>> +kfree_skb(skb);
>>>>> +}
>>>>> +} else {
>>>>> +
>>>>> +if (is_meta_sk(sk)) {
>>>>> +ret =3D mptcp_v4_process_join_req(sk, skb);
>>>>> +goto done;
>>>>> +}
>>>>> +if (!meta_sk->sk_prequeue(meta_sk, skb)) {
>>>>> +skb->sk =3D NULL;
>>>>> +ret =3D tcp_v4_do_rcv(sk, skb);
>>>>> +}
>>>>> +
>>>>> +}
>>>>> +done:
>>>>> +bh_unlock_sock(meta_sk);
>>>>> +return (ret);
>>>>> +}
>>>>> +
>>>>>   /* The socket must have it's spinlock held when we get
>>>>>    * here.
>>>>>    *
>>>>> @@ -1432,8 +1497,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct =

>>>>> sk_buff *skb)
>>>>>   {
>>>>> struct sock *rsk;
>>>>> -if (is_meta_sk(sk))
>>>>> -return mptcp_v4_do_rcv(sk, skb);
>>>>> +BUG_ON(is_meta_sk(sk));
>>>>> if (sk->sk_state =3D=3D TCP_ESTABLISHED) { /* Fast path */
>>>>> struct dst_entry *dst =3D sk->sk_rx_dst;
>>>>> @@ -1587,6 +1651,8 @@ bool tcp_prequeue(struct sock *sk, struct =

>>>>> sk_buff *skb)
>>>>>   }
>>>>>   EXPORT_SYMBOL(tcp_prequeue);
>>>>> +process_unclaimed tcp_process_unclaimed =3D NULL;
>>>>> +
>>>>>   /*
>>>>>    *From tcp_input.c
>>>>>    */
>>>>> @@ -1595,7 +1661,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
>>>>>   {
>>>>> const struct iphdr *iph;
>>>>> const struct tcphdr *th;
>>>>> -struct sock *sk, *meta_sk =3D NULL;
>>>>> +struct sock *sk =3D NULL;
>>>>> int ret;
>>>>> struct net *net =3D dev_net(skb->dev);
>>>>> @@ -1636,10 +1702,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
>>>>> TCP_SKB_CB(skb)->end_seq =3D (TCP_SKB_CB(skb)->seq + th->syn + th->fi=
n +
>>>>>    skb->len - th->doff * 4);
>>>>> TCP_SKB_CB(skb)->ack_seq =3D ntohl(th->ack_seq);
>>>>> -#ifdef CONFIG_MPTCP
>>>>> -TCP_SKB_CB(skb)->mptcp_flags =3D 0;
>>>>> -TCP_SKB_CB(skb)->dss_off =3D 0;
>>>>> -#endif
>>>>> +
>>>>> TCP_SKB_CB(skb)->tcp_flags =3D tcp_flag_byte(th);
>>>>> TCP_SKB_CB(skb)->tcp_tw_isn =3D 0;
>>>>> TCP_SKB_CB(skb)->ip_dsfield =3D ipv4_get_dsfield(iph);
>>>>> @@ -1662,15 +1725,6 @@ process:
>>>>> if (!xfrm4_policy_check(sk, XFRM_POLICY_IN, skb))
>>>>> goto discard_and_relse;
>>>>> -#ifdef CONFIG_MPTCP
>>>>> -/* Is there a pending request sock for this segment ? */
>>>>> -if (sk->sk_state =3D=3D TCP_LISTEN && mptcp_check_req(skb, net)) {
>>>>> -if (sk)
>>>>> -sock_put(sk);
>>>>> -return 0;
>>>>> -}
>>>>> -#endif
>>>>> -
>>>>>   #ifdef CONFIG_TCP_MD5SIG
>>>>> /*
>>>>> * We really want to reject the packet as early as possible
>>>>> @@ -1688,30 +1742,21 @@ process:
>>>>> goto discard_and_relse;
>>>>> sk_incoming_cpu_update(sk);
>>>>> -skb->dev =3D NULL;
>>>>> -if (mptcp(tcp_sk(sk))) {
>>>>> -meta_sk =3D mptcp_meta_sk(sk);
>>>>> -
>>>>> -bh_lock_sock_nested(meta_sk);
>>>>> -if (sock_owned_by_user(meta_sk))
>>>>> -skb->sk =3D sk;
>>>>> -} else {
>>>>> -meta_sk =3D sk;
>>>>> -bh_lock_sock_nested(sk);
>>>>> -}
>>>>> +/* Do I have to set skb->dev to null ? */
>>>>> +bh_lock_sock_nested(sk);
>>>>> ret =3D 0;
>>>>> -if (!sock_owned_by_user(meta_sk)) {
>>>>> -if (!tcp_prequeue(meta_sk, skb))
>>>>> -ret =3D tcp_v4_do_rcv(sk, skb);
>>>>> -} else if (unlikely(sk_add_backlog(meta_sk, skb,
>>>>> -  meta_sk->sk_rcvbuf + meta_sk->sk_sndbuf))) {
>>>>> -bh_unlock_sock(meta_sk);
>>>>> +if (!sock_owned_by_user(sk)) {
>>>>> +if (!sk->sk_prequeue(sk, skb))
>>>>> +ret =3D sk->sk_backlog_rcv(sk, skb);
>>>>> +} else if (unlikely(sk_add_backlog(sk, skb,
>>>>> +   sk->sk_rcvbuf + sk->sk_sndbuf))) {
>>>>> +bh_unlock_sock(sk);
>>>>> NET_INC_STATS_BH(net, LINUX_MIB_TCPBACKLOGDROP);
>>>>> goto discard_and_relse;
>>>>> }
>>>>> -bh_unlock_sock(meta_sk);
>>>>> +bh_unlock_sock(sk);
>>>>> sock_put(sk);
>>>>> @@ -1721,26 +1766,11 @@ no_tcp_socket:
>>>>> if (!xfrm4_policy_check(NULL, XFRM_POLICY_IN, skb))
>>>>> goto discard_it;
>>>>> -#ifdef CONFIG_MPTCP
>>>>> -if (!sk && th->syn && !th->ack) {
>>>>> -int ret =3D mptcp_lookup_join(skb, NULL);
>>>>> -
>>>>> -if (ret < 0) {
>>>>> -tcp_v4_send_reset(NULL, skb);
>>>>> -goto discard_it;
>>>>> -} else if (ret > 0) {
>>>>> -return 0;
>>>>> -}
>>>>> +if (unlikely (tcp_process_unclaimed !=3D NULL)) {
>>>>> +if ((tcp_process_unclaimed)(NULL, skb))
>>>>> +return (0);
>>>>> }
>>>>> -/* Is there a pending request sock for this segment ? */
>>>>> -if (!sk && mptcp_check_req(skb, net)) {
>>>>> -if (sk)
>>>>> -sock_put(sk);
>>>>> -return 0;
>>>>> -}
>>>>> -#endif
>>>>> -
>>>>> if (skb->len < (th->doff << 2) || tcp_checksum_complete(skb)) {
>>>>>   csum_error:
>>>>> TCP_INC_STATS_BH(net, TCP_MIB_CSUMERRORS);
>>>>> @@ -2506,6 +2536,7 @@ struct proto tcp_prot =3D {
>>>>> .sendmsg=3D tcp_sendmsg,
>>>>> .sendpage=3D tcp_sendpage,
>>>>> .backlog_rcv=3D tcp_v4_do_rcv,
>>>>> +.prequeue=3D tcp_prequeue,
>>>>> .release_cb=3D tcp_release_cb,
>>>>> .hash=3D inet_hash,
>>>>> .unhash=3D inet_unhash,
>>>>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>>>>> index a635483..41b8be8 100644
>>>>> --- a/net/ipv4/tcp_output.c
>>>>> +++ b/net/ipv4/tcp_output.c
>>>>> @@ -3413,6 +3413,7 @@ void tcp_send_delayed_ack(struct sock *sk)
>>>>>   void tcp_send_ack(struct sock *sk)
>>>>>   {
>>>>> struct sk_buff *buff;
>>>>> +struct tcp_sock *tp =3D tcp_sk(sk);
>>>>> /* If we have been reset, we may not send again. */
>>>>> if (sk->sk_state =3D=3D TCP_CLOSE)
>>>>> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
>>>>> index 8c4dd4a..1554217 100644
>>>>> --- a/net/ipv6/af_inet6.c
>>>>> +++ b/net/ipv6/af_inet6.c
>>>>> @@ -193,6 +193,10 @@ lookup_protocol:
>>>>> sk->sk_protocol=3D protocol;
>>>>> sk->sk_backlog_rcv=3D answer->prot->backlog_rcv;
>>>>> +sk->sk_prequeue=3D answer->prot->prequeue;
>>>>> +if (sk->sk_prequeue =3D=3D NULL) {
>>>>> +sk->sk_prequeue =3D sk_prequeue;
>>>>> +}
>>>>> inet_sk(sk)->pinet6 =3D np =3D inet6_sk_generic(sk);
>>>>> np->hop_limit=3D -1;
>>>>> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
>>>>> index eba2436..d360128 100644
>>>>> --- a/net/ipv6/tcp_ipv6.c
>>>>> +++ b/net/ipv6/tcp_ipv6.c
>>>>> @@ -1412,10 +1412,6 @@ static void tcp_v6_fill_cb(struct sk_buff =

>>>>> *skb, const struct ipv6hdr *hdr,
>>>>> TCP_SKB_CB(skb)->end_seq =3D (TCP_SKB_CB(skb)->seq + th->syn + th->fi=
n +
>>>>>    skb->len - th->doff*4);
>>>>> TCP_SKB_CB(skb)->ack_seq =3D ntohl(th->ack_seq);
>>>>> -#ifdef CONFIG_MPTCP
>>>>> -TCP_SKB_CB(skb)->mptcp_flags =3D 0;
>>>>> -TCP_SKB_CB(skb)->dss_off =3D 0;
>>>>> -#endif
>>>>> TCP_SKB_CB(skb)->tcp_flags =3D tcp_flag_byte(th);
>>>>> TCP_SKB_CB(skb)->tcp_tw_isn =3D 0;
>>>>> TCP_SKB_CB(skb)->ip_dsfield =3D ipv6_get_dsfield(hdr);
>>>>> diff --git a/net/mptcp/mptcp_ctrl.c b/net/mptcp/mptcp_ctrl.c
>>>>> index 28f348f..b1e780a 100644
>>>>> --- a/net/mptcp/mptcp_ctrl.c
>>>>> +++ b/net/mptcp/mptcp_ctrl.c
>>>>> @@ -976,6 +976,20 @@ int mptcp_backlog_rcv(struct sock *meta_sk, =

>>>>> struct sk_buff *skb)
>>>>> struct sock *sk =3D skb->sk ? skb->sk : meta_sk;
>>>>> int ret =3D 0;
>>>>> +/* socket was owned by the user in mptcp_check_req()
>>>>> + */
>>>>> +if (sk =3D=3D (struct sock *)0xFEE1DEAD) {
>>>>> +bh_lock_sock_nested(meta_sk);
>>>>> +if (skb->protocol =3D=3D htons(ETH_P_IP))
>>>>> +mptcp_v4_process_join_req(meta_sk, skb);
>>>>> +#if IS_ENABLED(CONFIG_IPV6)
>>>>> +else
>>>>> +//mptcp_v6_process_join_req(meta_sk, skb);
>>>>> +#endif /* CONFIG_IPV6 */
>>>>> +bh_unlock_sock(meta_sk);
>>>>> +return(0);
>>>>> +}
>>>>> +
>>>>> skb->sk =3D NULL;
>>>>> if (unlikely(!atomic_inc_not_zero(&sk->sk_refcnt))) {
>>>>> @@ -1297,6 +1311,10 @@ int mptcp_add_sock(struct sock *meta_sk, =

>>>>> struct sock *sk, u8 loc_id, u8 rem_id,
>>>>> sk->sk_write_space =3D mptcp_write_space;
>>>>> sk->sk_state_change =3D mptcp_set_state;
>>>>> sk->sk_destruct =3D mptcp_sock_destruct;
>>>>> +/* MPTCP takes a different path in tcp_v4_rcv
>>>>> + * thus not impacting main tcp code */
>>>>> +sk->sk_backlog_rcv =3D mptcp_v4_do_rcv;
>>>>> +sk->sk_prequeue =3D sk_prequeue;
>>>>> if (sk->sk_family =3D=3D AF_INET)
>>>>> mptcp_debug("%s: token %#x pi %d, src_addr:%pI4:%d =

>>>>> dst_addr:%pI4:%d, cnt_subflows now %d\n",
>>>>> @@ -2658,6 +2676,9 @@ void __init mptcp_init(void)
>>>>> if (mptcp_pm_v4_init())
>>>>> goto mptcp_pm_v4_failed;
>>>>> +if ((cmpxchg(&tcp_process_unclaimed, NULL, mptcp_v4_do_rcv)) !=3D NU=
LL)
>>>>> +printk("tcp_process_unclaimed not NULL \n");
>>>>> +
>>>>> mptcp_sysctl =3D register_net_sysctl(&init_net, "net/mptcp", =

>>>>> mptcp_table);
>>>>> if (!mptcp_sysctl)
>>>>> goto register_sysctl_failed;
>>>>> diff --git a/net/mptcp/mptcp_input.c b/net/mptcp/mptcp_input.c
>>>>> index 51cbb06..0e09ddf 100644
>>>>> --- a/net/mptcp/mptcp_input.c
>>>>> +++ b/net/mptcp/mptcp_input.c
>>>>> @@ -323,9 +323,8 @@ static int mptcp_verif_dss_csum(struct sock *sk)
>>>>> * by 4 bytes, as the high-order 64-bits will be added
>>>>> * in the final csum_partial-call.
>>>>> */
>>>>> -u32 offset =3D skb_transport_offset(tmp) +
>>>>> -    TCP_SKB_CB(tmp)->dss_off;
>>>>> -if (TCP_SKB_CB(tmp)->mptcp_flags & MPTCPHDR_SEQ64_SET)
>>>>> +u32 offset =3D skb_transport_offset(tmp) + tmp->mptcp_dss_off;
>>>>> +if (tmp->mptcp_flags & MPTCPHDR_SEQ64_SET)
>>>>> offset +=3D 4;
>>>>> csum_tcp =3D skb_checksum(tmp, offset,
>>>>> @@ -758,7 +757,7 @@ static int mptcp_detect_mapping(struct sock =

>>>>> *sk, struct sk_buff *skb)
>>>>> }
>>>>> /* Does the DSS had 64-bit seqnum's ? */
>>>>> -if (!(tcb->mptcp_flags & MPTCPHDR_SEQ64_SET)) {
>>>>> +if (!(skb->mptcp_flags & MPTCPHDR_SEQ64_SET)) {
>>>>> /* Wrapped around? */
>>>>> if (unlikely(after(data_seq, meta_tp->rcv_nxt) && data_seq < =

>>>>> meta_tp->rcv_nxt)) {
>>>>> tp->mptcp->map_data_seq =3D mptcp_get_data_seq_64(mpcb, =

>>>>> !mpcb->rcv_hiseq_index, data_seq);
>>>>> @@ -767,9 +766,9 @@ static int mptcp_detect_mapping(struct sock =

>>>>> *sk, struct sk_buff *skb)
>>>>> tp->mptcp->map_data_seq =3D mptcp_get_data_seq_64(mpcb, =

>>>>> mpcb->rcv_hiseq_index, data_seq);
>>>>> }
>>>>> } else {
>>>>> -tp->mptcp->map_data_seq =3D mptcp_get_data_seq_64(mpcb, =

>>>>> (tcb->mptcp_flags & MPTCPHDR_SEQ64_INDEX) ? 1 : 0, data_seq);
>>>>> +tp->mptcp->map_data_seq =3D mptcp_get_data_seq_64(mpcb, =

>>>>> (skb->mptcp_flags & MPTCPHDR_SEQ64_INDEX) ? 1 : 0, data_seq);
>>>>> -if (unlikely(tcb->mptcp_flags & MPTCPHDR_SEQ64_OFO)) {
>>>>> +if (unlikely(skb->mptcp_flags & MPTCPHDR_SEQ64_OFO)) {
>>>>> /* We make sure that the data_seq is invalid.
>>>>> * It will be dropped later.
>>>>> */
>>>>> @@ -1020,6 +1019,67 @@ next:
>>>>> return data_queued ? -1 : -2;
>>>>>   }
>>>>> +static struct sk_buff *
>>>>> +mptcp_process_ack(struct sock *sk, struct sk_buff *skb)
>>>>> +{
>>>>> +struct tcp_sock *tp =3D tcp_sk(sk);
>>>>> +int flag =3D 0;
>>>>> +
>>>>> +/*
>>>>> +* TCP takes care of invalid ack's
>>>>> +* they will never show up here.
>>>>> +*/
>>>>> +
>>>>> +/* Is this skb acknowleding anything data */
>>>>> +
>>>>> +if (tp->mptcp->snt_isn + 1 !=3D TCP_SKB_CB(skb)->ack_seq) {
>>>>> +flag =3D MPTCP_FLAG_DATA_ACKED;
>>>>> +}
>>>>> +
>>>>> +if (mptcp_fallback_infinite(sk, flag)) {
>>>>> +pr_err("%s resetting flow\n", __func__);
>>>>> +mptcp_send_reset(sk);
>>>>> +goto invalid_ack;
>>>>> +}
>>>>> +
>>>>> +mptcp_clean_rtx_infinite(skb, sk);
>>>>> +
>>>>> +return (skb);
>>>>> +invalid_ack:
>>>>> +__skb_unlink(skb, &sk->sk_receive_queue);
>>>>> +__kfree_skb(skb);
>>>>> +return (NULL);
>>>>> +
>>>>> +}
>>>>> +
>>>>> +static struct sk_buff *
>>>>> +mptcp_process_options_ack(struct sock *sk, struct sk_buff *skb)
>>>>> +{
>>>>> +struct tcp_sock *tp =3D tcp_sk(sk);
>>>>> +const struct tcphdr *th =3D tcp_hdr(skb);
>>>>> +
>>>>> +skb->mptcp_flags =3D 0;
>>>>> +skb->mptcp_dss_off =3D 0;
>>>>> +
>>>>> +tcp_parse_mptcp_options(skb, &tp->mptcp->rx_opt);
>>>>> +if (mptcp_handle_options(sk, th, skb)) {
>>>>> +mptcp_reset_mopt(tp);
>>>>> +__skb_unlink(skb, &sk->sk_receive_queue);
>>>>> +__kfree_skb(skb);
>>>>> +skb =3D NULL;
>>>>> +}
>>>>> +if ((skb !=3D NULL) && skb->len =3D=3D 0) {
>>>>> +skb =3D mptcp_process_ack(sk, skb);
>>>>> +if (skb !=3D NULL && skb->len =3D=3D 0) {
>>>>> +/* Pure ack */
>>>>> +__skb_unlink(skb, &sk->sk_receive_queue);
>>>>> +__kfree_skb(skb);
>>>>> +skb =3D NULL;
>>>>> +}
>>>>> +}
>>>>> +return (skb);
>>>>> +}
>>>>> +
>>>>>   void mptcp_data_ready(struct sock *sk)
>>>>>   {
>>>>> struct sock *meta_sk =3D mptcp_meta_sk(sk);
>>>>> @@ -1045,6 +1105,10 @@ restart:
>>>>> */
>>>>> skb_queue_walk_safe(&sk->sk_receive_queue, skb, tmp) {
>>>>> int ret;
>>>>> +
>>>>> +skb =3D mptcp_process_options_ack(sk, skb);
>>>>> +if (skb =3D=3D NULL)
>>>>> +continue;
>>>>> /* Pre-validation - e.g., early fallback */
>>>>> ret =3D mptcp_prevalidate_skb(sk, skb);
>>>>> if (ret < 0)
>>>>> @@ -1108,13 +1172,11 @@ int mptcp_check_req(struct sk_buff *skb, =

>>>>> struct net *net)
>>>>> if (!meta_sk)
>>>>> return 0;
>>>>> -TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_JOIN;
>>>>> -
>>>>> bh_lock_sock_nested(meta_sk);
>>>>> if (sock_owned_by_user(meta_sk)) {
>>>>> -skb->sk =3D meta_sk;
>>>>> +skb->sk =3D (struct sock *)0xFEE1DEAD;
>>>>> if (unlikely(sk_add_backlog(meta_sk, skb,
>>>>> -   meta_sk->sk_rcvbuf + meta_sk->sk_sndbuf))) {
>>>>> +meta_sk->sk_rcvbuf + meta_sk->sk_sndbuf))) {
>>>>> bh_unlock_sock(meta_sk);
>>>>> NET_INC_STATS_BH(net, LINUX_MIB_TCPBACKLOGDROP);
>>>>> sock_put(meta_sk); /* Taken by mptcp_search_req */
>>>>> @@ -1122,10 +1184,14 @@ int mptcp_check_req(struct sk_buff *skb, =

>>>>> struct net *net)
>>>>> return 1;
>>>>> }
>>>>> } else if (skb->protocol =3D=3D htons(ETH_P_IP)) {
>>>>> -tcp_v4_do_rcv(meta_sk, skb);
>>>>> +/*
>>>>> +* call old mptcp_v4_do_rcv
>>>>> +*/
>>>>> +mptcp_v4_process_join_req(meta_sk, skb);
>>>>>   #if IS_ENABLED(CONFIG_IPV6)
>>>>> } else { /* IPv6 */
>>>>> -tcp_v6_do_rcv(meta_sk, skb);
>>>>> +WARN_ON(1);
>>>>> +//mptcp_v6_handle_join_req(meta_sk, skb);
>>>>>   #endif /* CONFIG_IPV6 */
>>>>> }
>>>>> bh_unlock_sock(meta_sk);
>>>>> @@ -1222,7 +1288,7 @@ int mptcp_lookup_join(struct sk_buff *skb, =

>>>>> struct inet_timewait_sock *tw)
>>>>> inet_twsk_put(tw);
>>>>> }
>>>>> -TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_JOIN;
>>>>> +skb->mptcp_flags |=3D MPTCPHDR_JOIN;
>>>>> /* OK, this is a new syn/join, let's create a new open request and
>>>>> * send syn+ack
>>>>> */
>>>>> @@ -1279,7 +1345,7 @@ int mptcp_do_join_short(struct sk_buff *skb,
>>>>> return -1;
>>>>> }
>>>>> -TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_JOIN;
>>>>> +//TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_JOIN;
>>>>> /* OK, this is a new syn/join, let's create a new open request and
>>>>> * send syn+ack
>>>>> @@ -1303,7 +1369,7 @@ int mptcp_do_join_short(struct sk_buff *skb,
>>>>> }
>>>>> if (sock_owned_by_user(meta_sk)) {
>>>>> -skb->sk =3D meta_sk;
>>>>> +skb->sk =3D (struct sock *)0xFEE1DEAD; //skb->sk =3D meta_sk;
>>>>> if (unlikely(sk_add_backlog(meta_sk, skb,
>>>>>    meta_sk->sk_rcvbuf + meta_sk->sk_sndbuf)))
>>>>> NET_INC_STATS_BH(net, LINUX_MIB_TCPBACKLOGDROP);
>>>>> @@ -1319,10 +1385,12 @@ int mptcp_do_join_short(struct sk_buff *skb,
>>>>> */
>>>>> skb_get(skb);
>>>>> if (skb->protocol =3D=3D htons(ETH_P_IP)) {
>>>>> -tcp_v4_do_rcv(meta_sk, skb);
>>>>> +//tcp_v4_do_rcv(meta_sk, skb);
>>>>> +mptcp_v4_process_join_req(meta_sk, skb);
>>>>>   #if IS_ENABLED(CONFIG_IPV6)
>>>>> } else { /* IPv6 */
>>>>> -tcp_v6_do_rcv(meta_sk, skb);
>>>>> +//mptcp_v6_process_join_req(meta_sk, skb);
>>>>> +//tcp_v6_do_rcv(meta_sk, skb);
>>>>>   #endif /* CONFIG_IPV6 */
>>>>> }
>>>>> }
>>>>> @@ -1461,7 +1529,6 @@ static void mptcp_data_ack(struct sock *sk, =

>>>>> const struct sk_buff *skb)
>>>>>   {
>>>>> struct sock *meta_sk =3D mptcp_meta_sk(sk);
>>>>> struct tcp_sock *meta_tp =3D tcp_sk(meta_sk), *tp =3D tcp_sk(sk);
>>>>> -struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
>>>>> u32 prior_snd_una =3D meta_tp->snd_una;
>>>>> int prior_packets;
>>>>> u32 nwin, data_ack, data_seq;
>>>>> @@ -1481,7 +1548,7 @@ static void mptcp_data_ack(struct sock *sk, =

>>>>> const struct sk_buff *skb)
>>>>> /* If we are in infinite mapping mode, rx_opt.data_ack has been
>>>>> * set by mptcp_clean_rtx_infinite.
>>>>> */
>>>>> -if (!(tcb->mptcp_flags & MPTCPHDR_ACK) && =

>>>>> !tp->mpcb->infinite_mapping_snd)
>>>>> +if (!(skb->mptcp_flags & MPTCPHDR_ACK) && =

>>>>> !tp->mpcb->infinite_mapping_snd)
>>>>> goto exit;
>>>>> data_ack =3D tp->mptcp->rx_opt.data_ack;
>>>>> @@ -1647,10 +1714,11 @@ static inline bool =

>>>>> is_valid_addropt_opsize(u8 mptcp_ver,
>>>>>   void mptcp_parse_options(const uint8_t *ptr, int opsize,
>>>>> struct mptcp_options_received *mopt,
>>>>> -const struct sk_buff *skb,
>>>>> +struct sk_buff *skb,
>>>>> struct tcp_sock *tp)
>>>>>   {
>>>>> const struct mptcp_option *mp_opt =3D (struct mptcp_option *)ptr;
>>>>> +struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
>>>>> /* If the socket is mp-capable we would have a mopt. */
>>>>> if (!mopt)
>>>>> @@ -1757,7 +1825,7 @@ void mptcp_parse_options(const uint8_t *ptr, =

>>>>> int opsize,
>>>>> ptr +=3D 4;
>>>>> if (mdss->A) {
>>>>> -tcb->mptcp_flags |=3D MPTCPHDR_ACK;
>>>>> +skb->mptcp_flags |=3D MPTCPHDR_ACK;
>>>>> if (mdss->a) {
>>>>> mopt->data_ack =3D (u32) get_unaligned_be64(ptr);
>>>>> @@ -1768,13 +1836,13 @@ void mptcp_parse_options(const uint8_t =

>>>>> *ptr, int opsize,
>>>>> }
>>>>> }
>>>>> -tcb->dss_off =3D (ptr - skb_transport_header(skb));
>>>>> +skb->mptcp_dss_off =3D (ptr - skb_transport_header(skb));
>>>>> if (mdss->M) {
>>>>> if (mdss->m) {
>>>>> u64 data_seq64 =3D get_unaligned_be64(ptr);
>>>>> -tcb->mptcp_flags |=3D MPTCPHDR_SEQ64_SET;
>>>>> +skb->mptcp_flags |=3D MPTCPHDR_SEQ64_SET;
>>>>> mopt->data_seq =3D (u32) data_seq64;
>>>>> ptr +=3D 12; /* 64-bit dseq + subseq */
>>>>> @@ -1784,15 +1852,16 @@ void mptcp_parse_options(const uint8_t =

>>>>> *ptr, int opsize,
>>>>> }
>>>>> mopt->data_len =3D get_unaligned_be16(ptr);
>>>>> -tcb->mptcp_flags |=3D MPTCPHDR_SEQ;
>>>>> +skb->mptcp_flags |=3D MPTCPHDR_SEQ;
>>>>> /* Is a check-sum present? */
>>>>> -if (opsize =3D=3D mptcp_sub_len_dss(mdss, 1))
>>>>> -tcb->mptcp_flags |=3D MPTCPHDR_DSS_CSUM;
>>>>> +if (opsize =3D=3D mptcp_sub_len_dss(mdss, 1)) {
>>>>> +skb->mptcp_flags |=3D MPTCPHDR_DSS_CSUM;
>>>>> +}
>>>>> /* DATA_FIN only possible with DSS-mapping */
>>>>> if (mdss->F)
>>>>> -tcb->mptcp_flags |=3D MPTCPHDR_FIN;
>>>>> +skb->mptcp_flags |=3D MPTCPHDR_FIN;
>>>>> }
>>>>> break;
>>>>> @@ -1907,8 +1976,9 @@ void tcp_parse_mptcp_options(const struct =

>>>>> sk_buff *skb,
>>>>> return;
>>>>> if (opsize > length)
>>>>> return;/* don't parse partial options */
>>>>> -if (opcode =3D=3D TCPOPT_MPTCP)
>>>>> +if (opcode =3D=3D TCPOPT_MPTCP) {
>>>>> mptcp_parse_options(ptr - 2, opsize, mopt, skb, NULL);
>>>>> +}
>>>>> }
>>>>> ptr +=3D opsize - 2;
>>>>> length -=3D opsize;
>>>>> @@ -2168,6 +2238,8 @@ bool mptcp_handle_options(struct sock *sk, =

>>>>> const struct tcphdr *th,
>>>>> struct tcp_sock *tp =3D tcp_sk(sk);
>>>>> struct mptcp_options_received *mopt =3D &tp->mptcp->rx_opt;
>>>>> +BUG_ON(sk =3D=3D mptcp_meta_sk(sk));
>>>>> +
>>>>> if (tp->mpcb->infinite_mapping_rcv || tp->mpcb->infinite_mapping_snd)
>>>>> return false;
>>>>> @@ -2185,7 +2257,7 @@ bool mptcp_handle_options(struct sock *sk, =

>>>>> const struct tcphdr *th,
>>>>> * receiver MUST close the subflow with a RST as it is considered =

>>>>> broken.
>>>>> */
>>>>> if (mptcp_is_data_seq(skb) && tp->mpcb->dss_csum &&
>>>>> -   !(TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_DSS_CSUM)) {
>>>>> +   !(skb->mptcp_flags & MPTCPHDR_DSS_CSUM)) {
>>>>> mptcp_send_reset(sk);
>>>>> return true;
>>>>> }
>>>>> @@ -2330,6 +2402,7 @@ int mptcp_rcv_synsent_state_process(struct =

>>>>> sock *sk, struct sock **skptr,
>>>>> /* Set this flag in order to postpone data sending
>>>>> * until the 4th ack arrives.
>>>>> */
>>>>> +printk("mptcp_rcv_synsent_state_process  pre_established set \n");
>>>>> tp->mptcp->pre_established =3D 1;
>>>>> tp->mptcp->rcv_low_prio =3D tp->mptcp->rx_opt.low_prio;
>>>>> diff --git a/net/mptcp/mptcp_ipv4.c b/net/mptcp/mptcp_ipv4.c
>>>>> index a147b20..3e60ab5 100644
>>>>> --- a/net/mptcp/mptcp_ipv4.c
>>>>> +++ b/net/mptcp/mptcp_ipv4.c
>>>>> @@ -180,45 +180,12 @@ static int mptcp_v4_join_request(struct sock =

>>>>> *meta_sk, struct sk_buff *skb)
>>>>>   }
>>>>>   /* We only process join requests here. (either the SYN or the =

>>>>> final ACK) */
>>>>> -int mptcp_v4_do_rcv(struct sock *meta_sk, struct sk_buff *skb)
>>>>> +int mptcp_v4_process_join_req(struct sock *meta_sk, struct =

>>>>> sk_buff *skb)
>>>>>   {
>>>>> const struct mptcp_cb *mpcb =3D tcp_sk(meta_sk)->mpcb;
>>>>> struct sock *child, *rsk =3D NULL;
>>>>> int ret;
>>>>> -if (!(TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_JOIN)) {
>>>>> -struct tcphdr *th =3D tcp_hdr(skb);
>>>>> -const struct iphdr *iph =3D ip_hdr(skb);
>>>>> -struct sock *sk;
>>>>> -
>>>>> -sk =3D inet_lookup_established(sock_net(meta_sk), &tcp_hashinfo,
>>>>> -    iph->saddr, th->source, iph->daddr,
>>>>> -    th->dest, inet_iif(skb));
>>>>> -
>>>>> -if (!sk) {
>>>>> -kfree_skb(skb);
>>>>> -return 0;
>>>>> -}
>>>>> -if (is_meta_sk(sk)) {
>>>>> -WARN("%s Did not find a sub-sk - did found the meta!\n", __func__);
>>>>> -kfree_skb(skb);
>>>>> -sock_put(sk);
>>>>> -return 0;
>>>>> -}
>>>>> -
>>>>> -if (sk->sk_state =3D=3D TCP_TIME_WAIT) {
>>>>> -inet_twsk_put(inet_twsk(sk));
>>>>> -kfree_skb(skb);
>>>>> -return 0;
>>>>> -}
>>>>> -
>>>>> -ret =3D tcp_v4_do_rcv(sk, skb);
>>>>> -sock_put(sk);
>>>>> -
>>>>> -return ret;
>>>>> -}
>>>>> -TCP_SKB_CB(skb)->mptcp_flags =3D 0;
>>>>> -
>>>>> /* Has been removed from the tk-table. Thus, no new subflows.
>>>>> *
>>>>> * Check for close-state is necessary, because we may have been closed
>>>>> diff --git a/net/mptcp/mptcp_ipv6.c b/net/mptcp/mptcp_ipv6.c
>>>>> index 0de953d..1959d01 100644
>>>>> --- a/net/mptcp/mptcp_ipv6.c
>>>>> +++ b/net/mptcp/mptcp_ipv6.c
>>>>> @@ -199,7 +199,7 @@ int mptcp_v6_do_rcv(struct sock *meta_sk, =

>>>>> struct sk_buff *skb)
>>>>> struct sock *child, *rsk =3D NULL;
>>>>> int ret;
>>>>> -if (!(TCP_SKB_CB(skb)->mptcp_flags & MPTCPHDR_JOIN)) {
>>>>> +if (!(skb->mptcp_flags & MPTCPHDR_JOIN)) {
>>>>> struct tcphdr *th =3D tcp_hdr(skb);
>>>>> const struct ipv6hdr *ip6h =3D ipv6_hdr(skb);
>>>>> struct sock *sk;
>>>>> @@ -232,7 +232,7 @@ int mptcp_v6_do_rcv(struct sock *meta_sk, =

>>>>> struct sk_buff *skb)
>>>>> return ret;
>>>>> }
>>>>> -TCP_SKB_CB(skb)->mptcp_flags =3D 0;
>>>>> +skb->mptcp_flags =3D 0;
>>>>> /* Has been removed from the tk-table. Thus, no new subflows.
>>>>> *
>>>>> diff --git a/net/mptcp/mptcp_output.c b/net/mptcp/mptcp_output.c
>>>>> index 691ef6f..e7d340d 100644
>>>>> --- a/net/mptcp/mptcp_output.c
>>>>> +++ b/net/mptcp/mptcp_output.c
>>>>> @@ -59,39 +59,17 @@ EXPORT_SYMBOL(mptcp_sub_len_remove_addr_align);
>>>>>    */
>>>>>   static bool mptcp_reconstruct_mapping(struct sk_buff *skb)
>>>>>   {
>>>>> -const struct mp_dss *mpdss =3D (struct mp_dss *)TCP_SKB_CB(skb)->dss;
>>>>> -u32 *p32;
>>>>> -u16 *p16;
>>>>> -
>>>>> if (!mptcp_is_data_seq(skb))
>>>>> return false;
>>>>> -if (!mpdss->M)
>>>>> -return false;
>>>>> -
>>>>> -/* Move the pointer to the data-seq */
>>>>> -p32 =3D (u32 *)mpdss;
>>>>> -p32++;
>>>>> -if (mpdss->A) {
>>>>> -p32++;
>>>>> -if (mpdss->a)
>>>>> -p32++;
>>>>> -}
>>>>> -
>>>>> -TCP_SKB_CB(skb)->seq =3D ntohl(*p32);
>>>>> -
>>>>> -/* Get the data_len to calculate the end_data_seq */
>>>>> -p32++;
>>>>> -p32++;
>>>>> -p16 =3D (u16 *)p32;
>>>>> -TCP_SKB_CB(skb)->end_seq =3D ntohs(*p16) + TCP_SKB_CB(skb)->seq;
>>>>> +TCP_SKB_CB(skb)->seq =3D TCP_SKB_CB(skb)->mptcp_data_seq;
>>>>> return true;
>>>>>   }
>>>>>   static bool mptcp_is_reinjected(const struct sk_buff *skb)
>>>>>   {
>>>>> -return TCP_SKB_CB(skb)->mptcp_flags & MPTCP_REINJECT;
>>>>> +return skb->mptcp_flags & MPTCP_REINJECT;
>>>>>   }
>>>>>   static void mptcp_find_and_set_pathmask(const struct sock =

>>>>> *meta_sk, struct sk_buff *skb)
>>>>> @@ -105,7 +83,7 @@ static void mptcp_find_and_set_pathmask(const =

>>>>> struct sock *meta_sk, struct sk_bu
>>>>> break;
>>>>> if (TCP_SKB_CB(skb_it)->seq =3D=3D TCP_SKB_CB(skb)->seq) {
>>>>> -TCP_SKB_CB(skb)->path_mask =3D TCP_SKB_CB(skb_it)->path_mask;
>>>>> +TCP_SKB_CB(skb)->mptcp_path_mask =3D =

>>>>> TCP_SKB_CB(skb_it)->mptcp_path_mask;
>>>>> break;
>>>>> }
>>>>> }
>>>>> @@ -180,9 +158,9 @@ static void __mptcp_reinject_data(struct =

>>>>> sk_buff *orig_skb, struct sock *meta_sk
>>>>> }
>>>>> /* Segment goes back to the MPTCP-layer. So, we need to zero the
>>>>> -* path_mask/dss.
>>>>> +* path_mask.
>>>>> */
>>>>> -memset(TCP_SKB_CB(skb)->dss, 0 , mptcp_dss_len);
>>>>> +TCP_SKB_CB(skb)->mptcp_path_mask =3D 0;
>>>>> /* We need to find out the path-mask from the meta-write-queue
>>>>> * to properly select a subflow.
>>>>> @@ -272,14 +250,14 @@ void mptcp_reinject_data(struct sock *sk, =

>>>>> int clone_it)
>>>>> if (mptcp_is_reinjected(skb_it))
>>>>> continue;
>>>>> -tcb->mptcp_flags |=3D MPTCP_REINJECT;
>>>>> +skb_it->mptcp_flags |=3D MPTCP_REINJECT;
>>>>> __mptcp_reinject_data(skb_it, meta_sk, sk, clone_it);
>>>>> }
>>>>> skb_it =3D tcp_write_queue_tail(meta_sk);
>>>>> /* If sk has sent the empty data-fin, we have to reinject it too. */
>>>>> if (skb_it && mptcp_is_data_fin(skb_it) && skb_it->len =3D=3D 0 &&
>>>>> -   TCP_SKB_CB(skb_it)->path_mask & =

>>>>> mptcp_pi_to_flag(tp->mptcp->path_index)) {
>>>>> +   TCP_SKB_CB(skb_it)->mptcp_path_mask & =

>>>>> mptcp_pi_to_flag(tp->mptcp->path_index)) {
>>>>> __mptcp_reinject_data(skb_it, meta_sk, NULL, 1);
>>>>> }
>>>>> @@ -319,25 +297,43 @@ combine:
>>>>> }
>>>>>   }
>>>>> -static int mptcp_write_dss_mapping(const struct tcp_sock *tp, =

>>>>> const struct sk_buff *skb,
>>>>> -  __be32 *ptr)
>>>>> +/*
>>>>> + * RFC6824 states that once a particular subflow mapping has been =

>>>>> sent
>>>>> + * out it must never be changed. However, packets may be split while
>>>>> + * they are in the retransmission queue (due to SACK or ACKs) and =

>>>>> that
>>>>> + * arguably means that we would change the mapping (e.g. it =

>>>>> splits it,
>>>>> + * our sends out a subset of the initial mapping).
>>>>> + *
>>>>> + * Furthermore, the skb checksum is not always preserved across =

>>>>> splits
>>>>> + * (e.g. mptcp_fragment) which would mean that we need to recompute
>>>>> + * the DSS checksum in this case.
>>>>> + *
>>>>> + * To avoid this we save the initial DSS mapping which allows us to
>>>>> + * send the same DSS mapping even for fragmented retransmits.
>>>>> + */
>>>>> +
>>>>> +static int mptcp_write_dss_mapping(const struct tcp_sock *tp,
>>>>> +    const struct sk_buff *skb, __be32 *ptr)
>>>>>   {
>>>>> const struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
>>>>> -__be32 *start =3D ptr;
>>>>> __u16 data_len;
>>>>> -*ptr++ =3D htonl(tcb->seq); /* data_seq */
>>>>> +*ptr++ =3D htonl(tcb->mptcp_data_seq); /* data_seq */
>>>>> /* If it's a non-data DATA_FIN, we set subseq to 0 (draft v7) */
>>>>> if (mptcp_is_data_fin(skb) && skb->len =3D=3D 0)
>>>>> *ptr++ =3D 0; /* subseq */
>>>>> else
>>>>> -*ptr++ =3D htonl(tp->write_seq - tp->mptcp->snt_isn); /* subseq */
>>>>> +*ptr++ =3D htonl(tcb->seq - tp->mptcp->snt_isn); /* subseq */
>>>>> -if (tcb->mptcp_flags & MPTCPHDR_INF)
>>>>> +if (skb->mptcp_flags & MPTCPHDR_INF)
>>>>> data_len =3D 0;
>>>>> -else
>>>>> +else {
>>>>> data_len =3D tcb->end_seq - tcb->seq;
>>>>> +/* mptcp_entail_skb adds one for FIN */
>>>>> +if (tcb->tcp_flags & TCPHDR_FIN)
>>>>> +data_len -=3D 1;
>>>>> +}
>>>>> if (tp->mpcb->dss_csum && data_len) {
>>>>> __be16 *p16 =3D (__be16 *)ptr;
>>>>> @@ -356,11 +352,11 @@ static int mptcp_write_dss_mapping(const =

>>>>> struct tcp_sock *tp, const struct sk_bu
>>>>>       (TCPOPT_NOP));
>>>>> }
>>>>> -return ptr - start;
>>>>> +return mptcp_dss_len/sizeof(*ptr);
>>>>>   }
>>>>> -static int mptcp_write_dss_data_ack(const struct tcp_sock *tp, =

>>>>> const struct sk_buff *skb,
>>>>> -   __be32 *ptr)
>>>>> +static int mptcp_write_dss_data_ack(const struct tcp_sock *tp,
>>>>> +    const struct sk_buff *skb, __be32 *ptr)
>>>>>   {
>>>>> struct mp_dss *mdss =3D (struct mp_dss *)ptr;
>>>>> __be32 *start =3D ptr;
>>>>> @@ -377,54 +373,12 @@ static int mptcp_write_dss_data_ack(const =

>>>>> struct tcp_sock *tp, const struct sk_b
>>>>> mdss->len =3D mptcp_sub_len_dss(mdss, tp->mpcb->dss_csum);
>>>>> ptr++;
>>>>> +/* data_ack */
>>>>> *ptr++ =3D htonl(mptcp_meta_tp(tp)->rcv_nxt);
>>>>> return ptr - start;
>>>>>   }
>>>>> -/* RFC6824 states that once a particular subflow mapping has been =

>>>>> sent
>>>>> - * out it must never be changed. However, packets may be split while
>>>>> - * they are in the retransmission queue (due to SACK or ACKs) and =

>>>>> that
>>>>> - * arguably means that we would change the mapping (e.g. it =

>>>>> splits it,
>>>>> - * our sends out a subset of the initial mapping).
>>>>> - *
>>>>> - * Furthermore, the skb checksum is not always preserved across =

>>>>> splits
>>>>> - * (e.g. mptcp_fragment) which would mean that we need to recompute
>>>>> - * the DSS checksum in this case.
>>>>> - *
>>>>> - * To avoid this we save the initial DSS mapping which allows us to
>>>>> - * send the same DSS mapping even for fragmented retransmits.
>>>>> - */
>>>>> -static void mptcp_save_dss_data_seq(const struct tcp_sock *tp, =

>>>>> struct sk_buff *skb)
>>>>> -{
>>>>> -struct tcp_skb_cb *tcb =3D TCP_SKB_CB(skb);
>>>>> -__be32 *ptr =3D (__be32 *)tcb->dss;
>>>>> -
>>>>> -tcb->mptcp_flags |=3D MPTCPHDR_SEQ;
>>>>> -
>>>>> -ptr +=3D mptcp_write_dss_data_ack(tp, skb, ptr);
>>>>> -ptr +=3D mptcp_write_dss_mapping(tp, skb, ptr);
>>>>> -}
>>>>> -
>>>>> -/* Write the saved DSS mapping to the header */
>>>>> -static int mptcp_write_dss_data_seq(const struct tcp_sock *tp, =

>>>>> struct sk_buff *skb,
>>>>> -   __be32 *ptr)
>>>>> -{
>>>>> -__be32 *start =3D ptr;
>>>>> -
>>>>> -memcpy(ptr, TCP_SKB_CB(skb)->dss, mptcp_dss_len);
>>>>> -
>>>>> -/* update the data_ack */
>>>>> -start[1] =3D htonl(mptcp_meta_tp(tp)->rcv_nxt);
>>>>> -
>>>>> -/* dss is in a union with inet_skb_parm and
>>>>> -* the IP layer expects zeroed IPCB fields.
>>>>> -*/
>>>>> -memset(TCP_SKB_CB(skb)->dss, 0 , mptcp_dss_len);
>>>>> -
>>>>> -return mptcp_dss_len/sizeof(*ptr);
>>>>> -}
>>>>> -
>>>>>   static bool mptcp_skb_entail(struct sock *sk, struct sk_buff =

>>>>> *skb, int reinject)
>>>>>   {
>>>>> struct tcp_sock *tp =3D tcp_sk(sk);
>>>>> @@ -434,7 +388,7 @@ static bool mptcp_skb_entail(struct sock *sk, =

>>>>> struct sk_buff *skb, int reinject)
>>>>> struct sk_buff *subskb =3D NULL;
>>>>> if (!reinject)
>>>>> -TCP_SKB_CB(skb)->mptcp_flags |=3D (mpcb->snd_hiseq_index ?
>>>>> +skb->mptcp_flags |=3D (mpcb->snd_hiseq_index ?
>>>>>  MPTCPHDR_SEQ64_INDEX : 0);
>>>>> subskb =3D pskb_copy_for_clone(skb, GFP_ATOMIC);
>>>>> @@ -447,7 +401,7 @@ static bool mptcp_skb_entail(struct sock *sk, =

>>>>> struct sk_buff *skb, int reinject)
>>>>> */
>>>>> tcp_skb_pcount_set(subskb, 0);
>>>>> -TCP_SKB_CB(skb)->path_mask |=3D =

>>>>> mptcp_pi_to_flag(tp->mptcp->path_index);
>>>>> +TCP_SKB_CB(skb)->mptcp_path_mask |=3D =

>>>>> mptcp_pi_to_flag(tp->mptcp->path_index);
>>>>> if (!(sk->sk_route_caps & NETIF_F_ALL_CSUM) &&
>>>>>    skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
>>>>> @@ -463,13 +417,14 @@ static bool mptcp_skb_entail(struct sock =

>>>>> *sk, struct sk_buff *skb, int reinject)
>>>>> tp->mptcp->fully_established =3D 1;
>>>>> tp->mpcb->infinite_mapping_snd =3D 1;
>>>>> tp->mptcp->infinite_cutoff_seq =3D tp->write_seq;
>>>>> -tcb->mptcp_flags |=3D MPTCPHDR_INF;
>>>>> +skb->mptcp_flags |=3D MPTCPHDR_INF;
>>>>> }
>>>>> if (mptcp_is_data_fin(subskb))
>>>>> mptcp_combine_dfin(subskb, meta_sk, sk);
>>>>> -mptcp_save_dss_data_seq(tp, subskb);
>>>>> +subskb->mptcp_flags |=3D MPTCPHDR_SEQ;
>>>>> +tcb->mptcp_data_seq =3D tcb->seq;
>>>>> tcb->seq =3D tp->write_seq;
>>>>> @@ -536,10 +491,10 @@ static int mptcp_fragment(struct sock =

>>>>> *meta_sk, struct sk_buff *skb, u32 len,
>>>>> buff =3D skb->next;
>>>>> -flags =3D TCP_SKB_CB(skb)->mptcp_flags;
>>>>> -TCP_SKB_CB(skb)->mptcp_flags =3D flags & ~(MPTCPHDR_FIN);
>>>>> -TCP_SKB_CB(buff)->mptcp_flags =3D flags;
>>>>> -TCP_SKB_CB(buff)->path_mask =3D TCP_SKB_CB(skb)->path_mask;
>>>>> +flags =3D skb->mptcp_flags;
>>>>> +skb->mptcp_flags =3D flags & ~(MPTCPHDR_FIN);
>>>>> +buff->mptcp_flags =3D flags;
>>>>> +TCP_SKB_CB(buff)->mptcp_path_mask =3D TCP_SKB_CB(skb)->mptcp_path_ma=
sk;
>>>>> /* If reinject =3D=3D 1, the buff will be added to the reinject
>>>>> * queue, which is currently not part of memory accounting. So
>>>>> @@ -927,8 +882,9 @@ void mptcp_established_options(struct sock =

>>>>> *sk, struct sk_buff *skb,
>>>>> * It does not make sense to check for the options, because when the
>>>>> * segment gets sent, another subflow will be chosen.
>>>>> */
>>>>> -if (!skb && is_meta_sk(sk))
>>>>> +if (!skb && is_meta_sk(sk)) {
>>>>> return;
>>>>> +}
>>>>> /* In fallback mp_fail-mode, we have to repeat it until the fallback
>>>>> * has been done by the sender
>>>>> @@ -967,10 +923,11 @@ void mptcp_established_options(struct sock =

>>>>> *sk, struct sk_buff *skb,
>>>>> if (unlikely(mpcb->infinite_mapping_snd) &&
>>>>>    ((mpcb->send_infinite_mapping && tcb &&
>>>>>      mptcp_is_data_seq(skb) &&
>>>>> -     !(tcb->mptcp_flags & MPTCPHDR_INF) &&
>>>>> +     !(skb->mptcp_flags & MPTCPHDR_INF) &&
>>>>>      !before(tcb->seq, tp->mptcp->infinite_cutoff_seq)) ||
>>>>> -    !mpcb->send_infinite_mapping))
>>>>> +    !mpcb->send_infinite_mapping)) {
>>>>> return;
>>>>> +}
>>>>> if (unlikely(tp->mptcp->include_mpc)) {
>>>>> opts->options |=3D OPTION_MPTCP;
>>>>> @@ -995,9 +952,11 @@ void mptcp_established_options(struct sock =

>>>>> *sk, struct sk_buff *skb,
>>>>>    mpcb->mptcp_ver >=3D MPTCP_VERSION_1 && skb && =

>>>>> !mptcp_is_data_seq(skb)) {
>>>>> mpcb->pm_ops->addr_signal(sk, size, opts, skb);
>>>>> -if (opts->add_addr_v6)
>>>>> +if (opts->add_addr_v6) {
>>>>> +
>>>>> /* Skip subsequent options */
>>>>> return;
>>>>> +}
>>>>> }
>>>>> if (!tp->mptcp->include_mpc && !tp->mptcp->pre_established) {
>>>>> @@ -1197,10 +1156,11 @@ void mptcp_options_write(__be32 *ptr, =

>>>>> struct tcp_sock *tp,
>>>>> }
>>>>> if (OPTION_DATA_ACK & opts->mptcp_options) {
>>>>> -if (!mptcp_is_data_seq(skb))
>>>>> -ptr +=3D mptcp_write_dss_data_ack(tp, skb, ptr);
>>>>> -else
>>>>> -ptr +=3D mptcp_write_dss_data_seq(tp, skb, ptr);
>>>>> +ptr +=3D mptcp_write_dss_data_ack(tp, skb, ptr);
>>>>> +if (mptcp_is_data_seq(skb)) {
>>>>> +ptr +=3D mptcp_write_dss_mapping(tp, skb, ptr);
>>>>> +}
>>>>> +skb->dev =3D NULL;
>>>>> }
>>>>> if (unlikely(OPTION_MP_PRIO & opts->mptcp_options)) {
>>>>> struct mp_prio *mpprio =3D (struct mp_prio *)ptr;
>>>>> @@ -1233,7 +1193,7 @@ void mptcp_send_fin(struct sock *meta_sk)
>>>>> mss_now =3D mptcp_current_mss(meta_sk);
>>>>> if (tcp_send_head(meta_sk) !=3D NULL) {
>>>>> -TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_FIN;
>>>>> +skb->mptcp_flags |=3D MPTCPHDR_FIN;
>>>>> TCP_SKB_CB(skb)->end_seq++;
>>>>> meta_tp->write_seq++;
>>>>> } else {
>>>>> @@ -1250,7 +1210,7 @@ void mptcp_send_fin(struct sock *meta_sk)
>>>>> tcp_init_nondata_skb(skb, meta_tp->write_seq, TCPHDR_ACK);
>>>>> TCP_SKB_CB(skb)->end_seq++;
>>>>> -TCP_SKB_CB(skb)->mptcp_flags |=3D MPTCPHDR_FIN;
>>>>> +skb->mptcp_flags |=3D MPTCPHDR_FIN;
>>>>> tcp_queue_skb(meta_sk, skb);
>>>>> }
>>>>> __tcp_push_pending_frames(meta_sk, mss_now, TCP_NAGLE_OFF);
>>>>> diff --git a/net/mptcp/mptcp_redundant.c b/net/mptcp/mptcp_redundant.c
>>>>> index 8fa2dba..37a13f4 100644
>>>>> --- a/net/mptcp/mptcp_redundant.c
>>>>> +++ b/net/mptcp/mptcp_redundant.c
>>>>> @@ -72,10 +72,10 @@ static bool redsched_use_subflow(struct sock =

>>>>> *meta_sk,
>>>>> if (!skb || !mptcp_is_available((struct sock *)tp, skb, false))
>>>>> return false;
>>>>> -if (TCP_SKB_CB(skb)->path_mask !=3D 0)
>>>>> +if (TCP_SKB_CB(skb)->mptcp_path_mask !=3D 0)
>>>>> return subflow_is_active(tp);
>>>>> -if (TCP_SKB_CB(skb)->path_mask =3D=3D 0) {
>>>>> +if (TCP_SKB_CB(skb)->mptcp_path_mask =3D=3D 0) {
>>>>> if (active_valid_sks =3D=3D -1)
>>>>> active_valid_sks =3D redsched_get_active_valid_sks(meta_sk);
>>>>> @@ -209,7 +209,7 @@ static struct sk_buff =

>>>>> *redundant_next_segment(struct sock *meta_sk,
>>>>> cb_data->next_subflow =3D tp->mptcp->next;
>>>>> *subsk =3D (struct sock *)tp;
>>>>> -if (TCP_SKB_CB(skb)->path_mask)
>>>>> +if (TCP_SKB_CB(skb)->mptcp_path_mask)
>>>>> *reinject =3D -1;
>>>>> return skb;
>>>>> }
>>>>> diff --git a/net/mptcp/mptcp_rr.c b/net/mptcp/mptcp_rr.c
>>>>> index 8910ba9..83837f2 100644
>>>>> --- a/net/mptcp/mptcp_rr.c
>>>>> +++ b/net/mptcp/mptcp_rr.c
>>>>> @@ -93,7 +93,7 @@ static int mptcp_rr_dont_reinject_skb(const =

>>>>> struct tcp_sock *tp, const struct sk
>>>>> */
>>>>> return skb &&
>>>>> /* Has the skb already been enqueued into this subsocket? */
>>>>> -mptcp_pi_to_flag(tp->mptcp->path_index) & TCP_SKB_CB(skb)->path_mask;
>>>>> +mptcp_pi_to_flag(tp->mptcp->path_index) & =

>>>>> TCP_SKB_CB(skb)->mptcp_path_mask;
>>>>>   }
>>>>>   /* We just look for any subflow that is available */
>>>>> @@ -136,7 +136,7 @@ static struct sock =

>>>>> *rr_get_available_subflow(struct sock *meta_sk,
>>>>> * chance again by restarting its pathmask.
>>>>> */
>>>>> if (skb)
>>>>> -TCP_SKB_CB(skb)->path_mask =3D 0;
>>>>> +TCP_SKB_CB(skb)->mptcp_path_mask =3D 0;
>>>>> sk =3D backupsk;
>>>>> }
>>>>> diff --git a/net/mptcp/mptcp_sched.c b/net/mptcp/mptcp_sched.c
>>>>> index 54408ff..5cbbf91 100644
>>>>> --- a/net/mptcp/mptcp_sched.c
>>>>> +++ b/net/mptcp/mptcp_sched.c
>>>>> @@ -118,7 +118,7 @@ static int mptcp_dont_reinject_skb(const =

>>>>> struct tcp_sock *tp, const struct sk_bu
>>>>> */
>>>>> return skb &&
>>>>> /* Has the skb already been enqueued into this subsocket? */
>>>>> -mptcp_pi_to_flag(tp->mptcp->path_index) & TCP_SKB_CB(skb)->path_mask;
>>>>> +mptcp_pi_to_flag(tp->mptcp->path_index) & =

>>>>> TCP_SKB_CB(skb)->mptcp_path_mask;
>>>>>   }
>>>>>   bool subflow_is_backup(const struct tcp_sock *tp)
>>>>> @@ -261,7 +261,7 @@ struct sock *get_available_subflow(struct sock =

>>>>> *meta_sk, struct sk_buff *skb,
>>>>> * the skb passed through all the available active and backups
>>>>> * sks, so clean the path mask
>>>>> */
>>>>> -TCP_SKB_CB(skb)->path_mask =3D 0;
>>>>> +TCP_SKB_CB(skb)->mptcp_path_mask =3D 0;
>>>>> return sk;
>>>>>   }
>>>>>   EXPORT_SYMBOL_GPL(get_available_subflow);
>>>>> @@ -298,7 +298,7 @@ static struct sk_buff =

>>>>> *mptcp_rcv_buf_optimization(struct sock *sk, int penal)
>>>>> /* Half the cwnd of the slow flow */
>>>>> mptcp_for_each_tp(tp->mpcb, tp_it) {
>>>>> if (tp_it !=3D tp &&
>>>>> -   TCP_SKB_CB(skb_head)->path_mask & =

>>>>> mptcp_pi_to_flag(tp_it->mptcp->path_index)) {
>>>>> +   TCP_SKB_CB(skb_head)->mptcp_path_mask & =

>>>>> mptcp_pi_to_flag(tp_it->mptcp->path_index)) {
>>>>> if (tp->srtt_us < tp_it->srtt_us && inet_csk((struct sock =

>>>>> *)tp_it)->icsk_ca_state =3D=3D TCP_CA_Open) {
>>>>> u32 prior_cwnd =3D tp_it->snd_cwnd;
>>>>> @@ -317,11 +317,11 @@ static struct sk_buff =

>>>>> *mptcp_rcv_buf_optimization(struct sock *sk, int penal)
>>>>>   retrans:
>>>>> /* Segment not yet injected into this path? Take it!!! */
>>>>> -if (!(TCP_SKB_CB(skb_head)->path_mask & =

>>>>> mptcp_pi_to_flag(tp->mptcp->path_index))) {
>>>>> +if (!(TCP_SKB_CB(skb_head)->mptcp_path_mask & =

>>>>> mptcp_pi_to_flag(tp->mptcp->path_index))) {
>>>>> bool do_retrans =3D false;
>>>>> mptcp_for_each_tp(tp->mpcb, tp_it) {
>>>>> if (tp_it !=3D tp &&
>>>>> -   TCP_SKB_CB(skb_head)->path_mask & =

>>>>> mptcp_pi_to_flag(tp_it->mptcp->path_index)) {
>>>>> +   TCP_SKB_CB(skb_head)->mptcp_path_mask & =

>>>>> mptcp_pi_to_flag(tp_it->mptcp->path_index)) {
>>>>> if (tp_it->snd_cwnd <=3D 4) {
>>>>> do_retrans =3D true;
>>>>> break;
>>>> _______________________________________________
>>>> mptcp mailing list
>>>> mptcp(a)lists.01.org <mailto:mptcp(a)lists.01.org>
>>>> https://lists.01.org/mailman/listinfo/mptcp
>>
>


--===============7618826272802434091==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWw+CiAgPGhlYWQ+CiAgICA8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRl
bnQ9InRleHQvaHRtbDsKICAgICAgY2hhcnNldD13aW5kb3dzLTEyNTIiPgogIDwvaGVhZD4KICA8
Ym9keSB0ZXh0PSIjMDAwMDAwIiBiZ2NvbG9yPSIjRkZGRkZGIj4KICAgIDxwPjxicj4KICAgIDwv
cD4KICAgIDxicj4KICAgIDxkaXYgY2xhc3M9Im1vei1jaXRlLXByZWZpeCI+T24gMDYvMjcvMjAx
NyAxMDozNyBBTSwgQ2hyaXN0b3BoCiAgICAgIFBhYXNjaCB3cm90ZTo8YnI+CiAgICA8L2Rpdj4K
ICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiCiAgICAgIGNpdGU9Im1pZDozNkQyOTExNC1ENzRF
LTQ2NTAtODQ0NS00REMwQ0E2QzI0ODdAYXBwbGUuY29tIj4KICAgICAgPG1ldGEgaHR0cC1lcXVp
dj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7CiAgICAgICAgY2hhcnNldD13aW5k
b3dzLTEyNTIiPgogICAgICBIZWxsbyBSYW8sCiAgICAgIDxkaXYgY2xhc3M9IiI+PGJyIGNsYXNz
PSIiPgogICAgICAgIDxkaXY+CiAgICAgICAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBjbGFz
cz0iIj4KICAgICAgICAgICAgPGRpdiBjbGFzcz0iIj5PbiBKdW4gMjcsIDIwMTcsIGF0IDEwOjIy
IEFNLCBSYW8gU2hvYWliICZsdDs8YQogICAgICAgICAgICAgICAgaHJlZj0ibWFpbHRvOnJhby5z
aG9haWJAb3JhY2xlLmNvbSIgY2xhc3M9IiIKICAgICAgICAgICAgICAgIG1vei1kby1ub3Qtc2Vu
ZD0idHJ1ZSI+cmFvLnNob2FpYkBvcmFjbGUuY29tPC9hPiZndDsKICAgICAgICAgICAgICB3cm90
ZTo8L2Rpdj4KICAgICAgICAgICAgPGJyIGNsYXNzPSJBcHBsZS1pbnRlcmNoYW5nZS1uZXdsaW5l
Ij4KICAgICAgICAgICAgPGRpdiBjbGFzcz0iIj4KICAgICAgICAgICAgICA8ZGl2IGNsYXNzPSIi
PkhpIENocmlzdG9waCw8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICA8YnIgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICA8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICBPbiAwNi8yNi8y
MDE3IDExOjI3IFBNLCBDaHJpc3RvcGggUGFhc2NoIHdyb3RlOjxicgogICAgICAgICAgICAgICAg
ICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNz
PSIiPkhlbGxvIFJhbyw8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgIDxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgY2FuIHlvdSB0cnkgdG8gZ2l2ZSBzb21lIG1vcmUgZGV0YWls
cyBvbiBob3cgdGhlCiAgICAgICAgICAgICAgICAgIGRhdGFwYXRoIGxvb2tzIGxpa2Ugd2l0aDxi
ciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgdGhpcyBwYXRjaD88YnIgY2xhc3M9IiI+CiAg
ICAgICAgICAgICAgICAgIDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgRm9yIGV4YW1w
bGUsIEkgd29uZGVyIGhvdyBkYXRhLWFja3MgYXJlIGJlaW5nCiAgICAgICAgICAgICAgICAgIHBy
b2Nlc3NlZC4gQmVjYXVzZSwgSSBzZWUgaW48YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAg
IG1wdGNwX2RhdGFfcmVhZHksIHRoYXQgeW91IG5vdyBleHBlY3RzIHNrYnMgd2l0aCBsZW4KICAg
ICAgICAgICAgICAgICAgMCwgdXBvbiB3aGljaCB5b3UgZW5kPGJyIGNsYXNzPSIiPgogICAgICAg
ICAgICAgICAgICB1cCBjYWxsaW5nIG1wdGNwX3Byb2Nlc3NfYWNrKCkuPGJyIGNsYXNzPSIiPgog
ICAgICAgICAgICAgICAgICA8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgIEkgZG9uJ3Qg
c2VlIGhvdyBzdWNoIHplcm8tbGVuZ3RoIHNrYnMgY291bGQgZW5kIHVwIGluCiAgICAgICAgICAg
ICAgICAgIHRoZSByZWNlaXZlLXF1ZXVlIG9mPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAg
ICB0aGUgc3ViZmxvd3MuPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICA8YnIgY2xhc3M9
IiI+CiAgICAgICAgICAgICAgICAgIDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgVGhh
bmtzLDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgICAg
ICAgICAgIDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgIEkgc2VuZCBldmVyeSBwYWNrZXQg
dGhhdCBpcyBjb21pbmcgb24gYW4gTVBUQ1AgYmFzZWQKICAgICAgICAgICAgICAgIHNvY2tldCBk
b3duIGFuZCBsZXQgTVBUQ1AgZGVhbCB3aXRoIGl0LiBJbiB0Y3AKICAgICAgICAgICAgICAgIGRh
dGFfcXVldWUoKS4gSSBhbHNvIHJlbW92ZWQgdGhlIGRpcmVjdGl2ZSB0byBnbyB0byB0aGUKICAg
ICAgICAgICAgICAgIHNsb3dfcGF0aCBpbiB0Y3BfcmN2X2VzdGFibGlzaGVkKCkuPGJyIGNsYXNz
PSIiPgogICAgICAgICAgICAgICAgPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgc3RhdGlj
IHZvaWQgdGNwX2RhdGFfcXVldWUoc3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3QKICAgICAgICAgICAg
ICAgIHNrX2J1ZmYgKnNrYik8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICB7PGJyIGNsYXNz
PSIiPgogICAgICAgICAgICAgICAgoKCgoKCgoHN0cnVjdCB0Y3Bfc29jayAqdHAgPSB0Y3Bfc2so
c2spOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgIKCgoKCgoKBpbnQgZWF0ZW4gPSAtMTs8
YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICCgoKCgoKCgYm9vbCBmcmFnc3RvbGVuID0gZmFs
c2U7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgPGJyIGNsYXNzPSIiPgogICAgICAgICAg
ICAgICAgoKCgoKCgoC8qPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgoKCgoKCgoKAqIHNl
bmQgZXZlcnkgcGFja2V0IHRvIE1QVENQPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgoKCg
oKCgoKAqLzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgIKCgoKCgoKBpZiAoIW1wdGNwKHRw
KSAmYW1wOyZhbXA7CiAgICAgICAgICAgICAgICAoVENQX1NLQl9DQihza2IpLSZndDtzZXEgPT0K
ICAgICAgICAgICAgICAgIFRDUF9TS0JfQ0Ioc2tiKS0mZ3Q7ZW5kX3NlcSkpIHs8YnIgY2xhc3M9
IiI+CiAgICAgICAgICAgICAgICCgoKCgoKCgoKCgoKCgoKBnb3RvIGRyb3A7PGJyIGNsYXNzPSIi
PgogICAgICAgICAgICAgICAgoKCgoKCgoH08YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICA8
YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICBUaGVyZSBpcyBvbmx5IG9uZSBjYXNlIHRoYXQg
SSBuZWVkIGludmVzdGlnYXRlIG1vcmUgaXMKICAgICAgICAgICAgICAgIHRoZSBmb2xsb3dpbmcu
IKBJbiB0aGF0IHRoZSBoZSBvbmx5IGludGVyZXN0aW5nIGNhc2UgaXMKICAgICAgICAgICAgICAg
IChsZW4gPT0gdGNwX2hlYWRlcl9sZW4pIGJ1dCBpbiBteSB1bmlkaXJlY3Rpb25hbCBidWxrCiAg
ICAgICAgICAgICAgICBkYXRhIHRyYW5zZmVyIHRlc3RzIEkgZGlkIG5vdCBoaXQgdGhhdCBjYXNl
LiBTbyBJIG5lZWQKICAgICAgICAgICAgICAgIHRvIGludmVzdGlnYXRlIG1vcmUgbGF0ZXIuIFRo
ZSBsYXN0IHJlc29ydCB3b3VsZCBiZSB0bwogICAgICAgICAgICAgICAganVzdCBkaXJlY3RseSBn
byB0byB0aGUgc2xvdyBwYXRoLjxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgIDxiciBjbGFz
cz0iIj4KICAgICAgICAgICAgICAgIGlmIChsZW4gJmx0Oz0gdGNwX2hlYWRlcl9sZW4pIHsgLyog
QnVsayBkYXRhIHRyYW5zZmVyOgogICAgICAgICAgICAgICAgc2VuZGVyICovPGJyIGNsYXNzPSIi
PgogICAgICAgICAgICAgICAgPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgaWYgKGxlbiA9PSB0Y3BfaGVhZGVyX2xlbikgezxicgogICAgICAgICAg
ICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICA8L2Rpdj4KICAgICAgICAgICAgPC9kaXY+
CiAgICAgICAgICA8L2Jsb2NrcXVvdGU+CiAgICAgICAgICA8ZGl2PjxiciBjbGFzcz0iIj4KICAg
ICAgICAgIDwvZGl2PgogICAgICAgICAgPGRpdj5UaGUgcHJvYmxlbSBpcywgaG93IGFyZSB0aGVz
ZSB6ZXJvLWxlbiBwYWNrZXRzIGJlaW5nCiAgICAgICAgICAgIHF1ZXVlZCBpbiB0aGUgcmVjZWl2
ZS1xdWV1ZSBvZiB0aGUgc29ja2V0ID8gSSBhbSBwcmV0dHkgc3VyZQogICAgICAgICAgICB0aGF0
IFRDUCB3b24ndCBsaWtlIGhhdmluZyBzdWNoIHBhY2tldHMgaW4gdGhlCiAgICAgICAgICAgIHJl
Y2VpdmUtcXVldWUsIHdoaWNoIG1lYW5zIHRoZXJlIHdpbGwgYmUgcXVpdGUgc29tZSBjaGFuZ2Vz
CiAgICAgICAgICAgIG5lZWRlZCB0byBzdXBwb3J0IHRoaXMuPC9kaXY+CiAgICAgICAgPC9kaXY+
CiAgICAgIDwvZGl2PgogICAgPC9ibG9ja3F1b3RlPgogICAgSSBkb24ndCB1bmRlcnN0YW5kIHdo
eSB0aGVyZSBhcmUgYW55IGNoYW5nZXMgbmVlZGVkIHRvIFRDUCwgdGhlc2UKICAgIHBhY2tldCB3
aWxsIGJlIGhhbmRsZWQgaW4gbXB0Y3BfZGF0YV9yZWFkeSgpIGFuZCBkaXNjYXJkZWQsIGp1c3QK
ICAgIGxpa2UgVENQoCBkb2VzIHdpdGggYSBwdXJlIGFjay4gUGxlYXNlIG5vdGUgdGhhdCB3ZSBv
bmx5IGRvIHRoaXMgZm9yCiAgICBNUFRDUCBzb2NrZXRzIG5vdCBqdXN0IGFueSBUQ1Agc29ja2V0
Ljxicj4KICAgIDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiCiAgICAgIGNpdGU9Im1pZDozNkQyOTEx
NC1ENzRFLTQ2NTAtODQ0NS00REMwQ0E2QzI0ODdAYXBwbGUuY29tIj4KICAgICAgPGRpdiBjbGFz
cz0iIj4KICAgICAgICA8ZGl2PgogICAgICAgICAgPGRpdj48YnIgY2xhc3M9IiI+CiAgICAgICAg
ICA8L2Rpdj4KICAgICAgICAgIDxkaXY+SSBtaWdodCBiZSBtaXNzaW5nIHNvbWV0aGluZyBoZXJl
LiBBIGhpZ2gtbGV2ZWwKICAgICAgICAgICAgZGVzY3JpcHRpb24gd2l0aCBzb21lIGNhbGwtc3Rh
Y2tzIG9mIGhvdyB0aGUgZGF0YS1wYXRoIGxvb2tzCiAgICAgICAgICAgIGxpa2Ugd2l0aCB5b3Vy
IHBhdGNoIHdvdWxkIGJlIGdvb2QuPC9kaXY+CiAgICAgICAgPC9kaXY+CiAgICAgIDwvZGl2Pgog
ICAgPC9ibG9ja3F1b3RlPgogICAgSXQncyBhY3R1YWxseSB2ZXJ5IHN0cmFpZ2h0IGZvcndhcmQs
IG5vcm1hbGx5IGluIHRjcF9kYXRhX3F1ZXVlKCkgYQogICAgcHVyZSBhY2sgaXMgc2ltcGx5IGRy
b3BwZWQgYXMgVENQIHN0YXRlIGhhcyBiZWVuIHVwZGF0ZWQgYW5kIHRoZQogICAgcGFja2V0IGlz
IG9mIG5vIHVzZS4gSW4gY2FzZSBvZiBNUFRDUCB3ZSBmb3JjZSB0aGUgcGFja2V0IHRvIGJlCiAg
ICBkZWxpdmVyZWQgdG8gdGhlIG1ldGEgc29ja2V0IHF1ZXVlIChTZWUgdGhlIG1wdGNwIGNoZWNr
IGluIHRoZSBpZgogICAgc3RhdGVtZW50KS4gV2hlbiBtcHRjcF9kYXRhX3JlYWR5KCmgIHByb2Nl
c3NlcyB0aGUgcGFja2V0IGl0LAogICAgdXBkYXRlcyBNUFRDUCBzdGF0ZSwgZnJlZXMgcGFja2V0
cyB0aGF0IGhhdmUgYmVlbiBhY2tlZCBhbmQgdGhhbgogICAgdGhyb3dzIGF3YXkgdGhlIHBhY2tl
dC6gIDxicj4KICAgIDxicj4KICAgIElmIHlvdSB3YW50ZWQgZm9yIHNvbWUgcmVhc29uIHRvIGRv
IHRoaXMgd2l0aCByZWd1bGFyIFRDUCwgeW91IGNvdWxkCiAgICB2ZXJ5IHdlbGwgYXMgbG9uZyBh
cyB0aGUgc29ja2V0IFJ4IGZ1bmN0aW9uIGtub3dzIGhvdyB0byBkZWFsIHRoZXNlCiAgICBwYWNr
ZXRzLiA8YnI+CiAgICA8YnI+CiAgICBDYW4geW91IGJlIG1vcmUgc3BlY2lmaWMgYWJvdXQgd2hh
dCBUQ1AgcXVldWUgd2lsbCBoYXZlIGlzc3VlcwogICAgYmVjYXVzZSBhdCB0aGlzIHBvaW50IHRo
ZSBwYWNrZXQgaXMgaGVhZGVkIHRvIHRoZSBzb2NrZXQgcXVldWUuPGJyPgogICAgPGJyPgogICAg
SWYgeW91IHByZWZlciBhIHN0YWNrIHRyYWNlLCBJIGNhbiBpbnN0cnVtZW50IHRoZSBrZXJuZWwg
d2l0aAogICAgV0FSTl9PTiBkaXJlY3RpdmUgYW5kIGdldCB5b3Ugb25lLCB0aGF0IGlzIHRoZSBv
bmx5IHdheSBJIGtub3cgdG8KICAgIGdldCBvbmUgaW4gTGludXguIEluIFNvbGFyaXMgaXQgd291
bGQgYmUgYSAyIG1pbiBvcGVyYXRpb24gb24gYQogICAgcnVubmluZyBzeXN0ZW0uIElmIHRoZXJl
IGlzIGEgYmV0dGVyIHdheSB0aGFuIHBsZWFzZSBlZHVjYXRlIG1lLjxicj4KICAgIDxicj4KICAg
IDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiCiAgICAgIGNpdGU9Im1pZDozNkQyOTExNC1ENzRFLTQ2
NTAtODQ0NS00REMwQ0E2QzI0ODdAYXBwbGUuY29tIj4KICAgICAgPGRpdiBjbGFzcz0iIj4KICAg
ICAgICA8ZGl2PgogICAgICAgICAgPGRpdj4gT3IgbWF5YmUgdHJ5IHRvIHNwbGl0IHRoZSBwYXRj
aCBpbiBzZXBhcmF0ZSBwaWVjZXMuPC9kaXY+CiAgICAgICAgPC9kaXY+CiAgICAgIDwvZGl2Pgog
ICAgPC9ibG9ja3F1b3RlPgogICAgVGhhdCB3b3VsZCBiZSBkaWZmaWN1bHQgYmVjYXVzZSBldmVy
eXRoaW5nIGlzIHRpZWQgdG9nZXRoZXIuIElmIHlvdQogICAgcHJlZmVyIEkgY2FuIHByb3ZpZGUg
eW91IHdpdGggYSB0YXIgYmFsbCBvZiB0aGUgc291cmNlLCB5b3UgY2FuIGxvb2sKICAgIGF0IGl0
LCBjb21waWxlIGFuZCBydW4gaXQuPGJyPgogICAgPGJyPgogICAgSSBhbSBhY3R1YWxseSB3b25k
ZXJpbmcgaG93IGZvbGtzIGRvIGNvZGUgcmV2aWV3IG9uIExpbnV4IGJhc2VkIG9uCiAgICB0aGUg
cGF0Y2ggdGhhdCBpcyBzdWJtaXR0ZWQuIFRoZXJlIGlzIG5vIGNvbnRleHQgZGlmZiBvciBhbnl0
aGluZwogICAgZWxzZSwgSSBhbSB1c2VkIHRvIHZlcnkgc29waGlzdGljYXRlZCB0b29scy48YnI+
CiAgICA8YmxvY2txdW90ZSB0eXBlPSJjaXRlIgogICAgICBjaXRlPSJtaWQ6MzZEMjkxMTQtRDc0
RS00NjUwLTg0NDUtNERDMENBNkMyNDg3QGFwcGxlLmNvbSI+CiAgICAgIDxkaXYgY2xhc3M9IiI+
CiAgICAgICAgPGRpdj48YnIgY2xhc3M9IiI+CiAgICAgICAgICA8YmxvY2txdW90ZSB0eXBlPSJj
aXRlIiBjbGFzcz0iIj4KICAgICAgICAgICAgPGRpdiBjbGFzcz0iIj4KICAgICAgICAgICAgICA8
ZGl2IGNsYXNzPSIiPjxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgIElmIHRoZXJlIGFyZSBv
dGhlciBpc3N1ZXMgdGhhbiBsZXQgbWUga25vdyBhbmQgSSB3aWxsCiAgICAgICAgICAgICAgICB3
b3JrIG9uIHJlc29sdmluZyB0aGVtLiBXZSBvYnZpb3VzbHkgbmVlZCB0byBydW4KICAgICAgICAg
ICAgICAgIGV4dGVuc2l2ZSB0ZXN0cywgdGhhdCBicmluZ3MgbWUgdG8gdGhlIHF1ZXN0aW9uIG9m
LCBob3cKICAgICAgICAgICAgICAgIGRvZXMgdGhlIE1QVENQIGRldmVsb3BtZW50IHRlYW0gdGVz
dCBjaGFuZ2VzLiBXZSBuZWVkCiAgICAgICAgICAgICAgICB0aGUgc2FtZSB0ZXN0cyB0byB2YWxp
ZGF0ZSB0aGUgY2hhbmdlcy48YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgPC9kaXY+CiAgICAg
ICAgICAgIDwvZGl2PgogICAgICAgICAgPC9ibG9ja3F1b3RlPgogICAgICAgICAgPGRpdj48YnIg
Y2xhc3M9IiI+CiAgICAgICAgICA8L2Rpdj4KICAgICAgICAgIDxkaXY+cGFja2V0ZHJpbGwgaXMg
dGhlIGJlc3QgdG9vbCB0byByZXByb2R1Y2Ugc3BlY2lmaWMKICAgICAgICAgICAgc2NlbmFyaW9z
OqA8YQogICAgICAgICAgICAgIGhyZWY9Imh0dHBzOi8vZ2l0aHViLmNvbS9jcGFhc2NoL3BhY2tl
dGRyaWxsX21wdGNwIgogICAgICAgICAgICAgIGNsYXNzPSIiIG1vei1kby1ub3Qtc2VuZD0idHJ1
ZSI+aHR0cHM6Ly9naXRodWIuY29tL2NwYWFzY2gvcGFja2V0ZHJpbGxfbXB0Y3A8L2E+oCh0ZXN0
cwogICAgICAgICAgICBhcmUgaW4gdGhlcmUgaW4gZXhhbXBsZS9tcHRjcC8pLjwvZGl2PgogICAg
ICAgICAgPGRpdj48YnIgY2xhc3M9IiI+CiAgICAgICAgICA8L2Rpdj4KICAgICAgICAgIDxkaXY+
QW5kLCBhIHRlc3Rpbmctc2NyaXB0IGlzIGF0oDxhCmhyZWY9Imh0dHBzOi8vZ2l0aHViLmNvbS9t
dWx0aXBhdGgtdGNwL21wdGNwLXNjcmlwdHMvdHJlZS9tYXN0ZXIvdGVzdGluZyIKICAgICAgICAg
ICAgICBjbGFzcz0iIiBtb3otZG8tbm90LXNlbmQ9InRydWUiPmh0dHBzOi8vZ2l0aHViLmNvbS9t
dWx0aXBhdGgtdGNwL21wdGNwLXNjcmlwdHMvdHJlZS9tYXN0ZXIvdGVzdGluZzwvYT4uPC9kaXY+
CiAgICAgICAgICA8ZGl2Pkl0IGRvZXMgYSBidW5jaCBvZiBzdHJlc3MtdGVzdGluZyAoaXBlcmYs
IGhhcHJveHksCiAgICAgICAgICAgIGFwYWNoZS1iZW5jaG1hcmssLi4uKSBvbiB0aHJlZSBtYWNo
aW5lcyB0aGF0IG5lZWQgdG8gYmUKICAgICAgICAgICAgaW50ZXItY29ubmVjdGVkIGluIGEgc3Bl
Y2lmaWMgd2F5LiBJdCdzIGEgYml0IHRyaWNreSB0bwogICAgICAgICAgICBzZXR1cC4gSSBoYXZl
IEtWTXMgdGhhdCBJIGJvb3QgdGhhdCBoYXZlIHR3byBsaW5rcyBiZXR3ZWVuCiAgICAgICAgICAg
IGVhY2ggb3RoZXIuIE9uZSBpcyB0aGUgY2xpZW50LCBvbmUgdGhlIHJvdXRlciAoc29tZXRpbWVz
CiAgICAgICAgICAgIGFjdGluZyBhcyBhIGhhcHJveHkpLCBvbmUgaXMgdGhlIHNlcnZlci4gVGhl
eSBuZWVkIHRvb2xzCiAgICAgICAgICAgIGxpa2UgYWIsIGFwYWNoZSwgaGFwcm94eSwgaXBlcmYs
Li4uPC9kaXY+CiAgICAgICAgPC9kaXY+CiAgICAgIDwvZGl2PgogICAgPC9ibG9ja3F1b3RlPgog
ICAgV2VsbCBJIGRvIG5vdCBoYXZlIDMgbWFjaGluZXMgYW5kIG15IHN5c3RlbSB3aWxsIGRpZSBp
ZiBJIHN0YXJ0ZWQgMwogICAgS1ZNJ3MuIExldCBtZSBzZWUgd2hhdCBJIGNhbiBnZXQuPGJyPgog
ICAgPGJyPgogICAgVGhhbmtzLDxicj4KICAgIDxicj4KICAgIFJhby48YnI+CiAgICA8YmxvY2tx
dW90ZSB0eXBlPSJjaXRlIgogICAgICBjaXRlPSJtaWQ6MzZEMjkxMTQtRDc0RS00NjUwLTg0NDUt
NERDMENBNkMyNDg3QGFwcGxlLmNvbSI+CiAgICAgIDxkaXYgY2xhc3M9IiI+CiAgICAgICAgPGRp
dj4KICAgICAgICAgIDxkaXY+PGJyIGNsYXNzPSIiPgogICAgICAgICAgPC9kaXY+CiAgICAgICAg
ICA8ZGl2PjxiciBjbGFzcz0iIj4KICAgICAgICAgIDwvZGl2PgogICAgICAgICAgPGRpdj5DaHJp
c3RvcGg8L2Rpdj4KICAgICAgICAgIDxiciBjbGFzcz0iIj4KICAgICAgICAgIDxibG9ja3F1b3Rl
IHR5cGU9ImNpdGUiIGNsYXNzPSIiPgogICAgICAgICAgICA8ZGl2IGNsYXNzPSIiPgogICAgICAg
ICAgICAgIDxkaXYgY2xhc3M9IiI+PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgUmFvLjxi
ciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgIDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAg
IDxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIGNsYXNzPSIiPkNocmlzdG9waDxiciBjbGFzcz0iIj4K
ICAgICAgICAgICAgICAgICAgPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICA8YnIgY2xh
c3M9IiI+CiAgICAgICAgICAgICAgICAgIE9uIDI2LzA2LzE3IC0gMTU6MzQ6MDksIFJhbyBTaG9h
aWIgd3JvdGU6PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICA8YmxvY2txdW90ZSB0eXBl
PSJjaXRlIiBjbGFzcz0iIj5JIGZvcmdvdCB0byBtZW50aW9uCiAgICAgICAgICAgICAgICAgICAg
dHdvIHRoaW5nczxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICA8YnIgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgMSkgQ29ubmVjdGlvbiBzZXR1cCBzdGlsbCBoYXMgY2hlY2tz
IGZvciBNUFRDUCwKICAgICAgICAgICAgICAgICAgICBJZGVhbGx5IHRoZXNlIHNob3VsZCBiZTxi
ciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICByZW1vdmVkIGJ1dCBhdCBsZWFzdCB3ZSBu
ZWVkIHRvIHJ1biBzb21lIGJlbmNobWFya3MKICAgICAgICAgICAgICAgICAgICBhbmQgZml4IGFu
eSBpc3N1ZXMuIFRoZTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICBtYWluc3RyZWFt
IGZvbGtzIHdpbGwgbm90IGFjY2VwdCBhbnkgcGVyZm9ybWFuY2UKICAgICAgICAgICAgICAgICAg
ICBkZWdyYWRhdGlvbiBpbiBUQ1AuIEkgY2FuPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAg
ICAgIGxvb2sgaW50byB0aGlzIG5leHQuPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAg
IDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAyKSBUaGUgY29kZSBvdmVybG9hZHMg
ZGV2IGZpZWxkIG9mIHNrYiwgd2hlbiBpdCBpcwogICAgICAgICAgICAgICAgICAgIG5vdCBiZWlu
ZyB1c2VkLiBJSVJDPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgIHRoZXJlIGlzIHBy
ZWNlZGVuY2UgZm9yIHRoaXMgYWxyZWFkeS4gSSB3aWxsIHRyeSB0bwogICAgICAgICAgICAgICAg
ICAgIGZpbmQgaXQuPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgIDxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICBSYW88YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAg
ICAgPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgIDxiciBjbGFzcz0iIj4KICAgICAg
ICAgICAgICAgICAgICBPbiAwNi8yNi8yMDE3IDAyOjEzIFBNLCBSYW8gU2hvYWliIHdyb3RlOjxi
cgogICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgPGJs
b2NrcXVvdGUgdHlwZT0iY2l0ZSIgY2xhc3M9IiI+VGhpcyBwYXRjaCByZXR1cm5zCiAgICAgICAg
ICAgICAgICAgICAgICB0Y3Bfc2tiX2NiIHRvIGl0J3Mgb3JpZ2luYWwgc2l6ZS4gSXQgYWxzbwog
ICAgICAgICAgICAgICAgICAgICAgcmVmYWN0b3JzIE1QVENQIGNvZGUgc28gdGhhdCB0aGVyZSBh
cmUgbm8gTVBUQ1AKICAgICAgICAgICAgICAgICAgICAgIGNoZWNrcyBpbiB0aGUgbWFpbiBSeCBw
YXRoaSwgbm8gcGVyZm9ybWFuY2UKICAgICAgICAgICAgICAgICAgICAgIG92ZXJoZWFkcyBzdWNo
IGFzIGNwdSBwcm9kaWN0aW9uIGlzc3Vlcy4KICAgICAgICAgICAgICAgICAgICAgIHRjcF92NF9y
Y3YoKSBhbmQgdGNwX3Y0X2RvX3JjdigpIGRvIG5vdCBoYXZlIGFueQogICAgICAgICAgICAgICAg
ICAgICAgTVBUQ1Agc3BlY2lmaWMgY2hlY2tzIGFueSBtb3JlLCBuaWV0aGVyIGRvZXMKICAgICAg
ICAgICAgICAgICAgICAgIHRjcF9hY2soKS4gT24gdGhlIFJ4IHBhdGggTVBUQ1Agb3B0aW9ucyBh
cmUgbm90CiAgICAgICAgICAgICAgICAgICAgICBwYXJzZWQgdGlsbCB0aGUgZGF0YSBpcyBiZWlu
ZyBwdXNoZWQgdXAgdG8gdGhlCiAgICAgICAgICAgICAgICAgICAgICBtZXRhIHNvY2tldCAobXB0
Y3BfZGF0YV9yZWFkeSkuIG9uIHRoZSBUeCBzaWRlCiAgICAgICAgICAgICAgICAgICAgICB0aGVy
ZSBpcyBvbmUgY2hlY2sgdG8gYWRkIE1QVENQIHNwZWNpZmljIG9wdGlvbnMKICAgICAgICAgICAg
ICAgICAgICAgIGJ1dCB0aGF0J3MgaXQsIHRoYXQgc2hvdWxkIG5vdCBiZSB0aGF0IGJhZCBhcyBm
b3IKICAgICAgICAgICAgICAgICAgICAgIHJlZ3VsYXIgVENQIGl0IGlzIGEgc2ltcGxlIGNoZWNr
LCBidXQgaXQgd291bGQgYmUKICAgICAgICAgICAgICAgICAgICAgIGdvb2QgdG8gcmVtb3ZlIGl0
Li48YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICA8YnIgY2xhc3M9IiI+CiAgICAg
ICAgICAgICAgICAgICAgICBJIGhhdmUgdGVzdGVkIHRoZSBjaGFuZ2VzIHdpdGggbmRpZmZwb3J0
cyBzZXQgdG8KICAgICAgICAgICAgICAgICAgICAgIDIsIHNvIGpvaW4gd29ya3MuIEkgaGF2ZSBh
bHNvIHRlc3RlZCBhY2Nlc3NpbmcgPGEKICAgICAgICAgICAgICAgICAgICAgICAgaHJlZj0iaHR0
cDovL211bHRpcGF0aC10Y3Aub3JnIiBjbGFzcz0iIgogICAgICAgICAgICAgICAgICAgICAgICBt
b3otZG8tbm90LXNlbmQ9InRydWUiPm11bHRpcGF0aC10Y3Aub3JnPC9hPiBhbmQKICAgICAgICAg
ICAgICAgICAgICAgIGRvd25sb2FkaW5nIGZpbGVzIGZyb20gdGhlcmUgYW5kIGFsc28gcmFuIHRo
ZQogICAgICAgICAgICAgICAgICAgICAgc3BlZWQgdGVzdC48YnIgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICA8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICBUaGUgQmFk
OjxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIDxiciBjbGFzcz0iIj4KICAgICAg
ICAgICAgICAgICAgICAgIFRoZSBlcnJvciBjYXNlcyBzdGlsbCBoYXZlIE1QVENQIGNoZWNrcyBi
dXQgdGhhdAogICAgICAgICAgICAgICAgICAgICAgc2hvdWxkIGJlIE9LIGFzIHRoZXkgYXJlIGVy
cm9yIGNhc2VzLiBJIGhhZCB0byB1c2UKICAgICAgICAgICAgICAgICAgICAgIGEgc3BlY2lhbCBt
YXJrZXIgMHhGRUUxREVBRCBmb3IgaW5kaWNhdGUgYSBzcGVjaWFsCiAgICAgICAgICAgICAgICAg
ICAgICBjYXNlLiBJIGhhZCB0byBpbnRyb2R1ZSBhIG5ldyBzb2NrZXQgc3BlY2ZpYwogICAgICAg
ICAgICAgICAgICAgICAgZnVuY3Rpb24uIElQdjYgaGFzIG5vdCBiZWVuIGNoYW5nZWQgeWV0LiBJ
IGFtIHN1cmUKICAgICAgICAgICAgICAgICAgICAgIEkgaGF2ZSBtaXNzZWQgc29tZSBjb3JuZXIg
Y2FzZXMgYW5kIG1vcmUgdGVzdGluZwogICAgICAgICAgICAgICAgICAgICAgd2lsbCByZXZlYWwg
bW9yZSBpc3N1ZXMgYnV0IHdlIGp1c3QgaGF2ZSB0byBmaXgKICAgICAgICAgICAgICAgICAgICAg
IHRoZW0uPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgPGJyIGNsYXNzPSIiPgog
ICAgICAgICAgICAgICAgICAgICAgSSB3b3VsZCBsaWtlIHRvIGhlYXIgY29tbWVudHMgZnJvbSB0
aGUgbGlzdCBhbmQgaWYKICAgICAgICAgICAgICAgICAgICAgIHRoaXMgZGlyZWN0aW9uIHNlZW1z
IHJlYXNvbmFibGUgd2UgY2FuIHRha2UgdGhpcwogICAgICAgICAgICAgICAgICAgICAgYXMgdGhl
IHN0YXJ0aW5nIHBvaW50LCBwb3J0IGl0IHRvIGxhdGVzdCBMaW51eCBhbmQKICAgICAgICAgICAg
ICAgICAgICAgIHNoYXJlIHRoZSBkZXNpZ24gd2l0aCB0aGUgbWFpbnN0cmVhbSBmb2xrcy48YnIK
ICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICA8
YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICBTaWduZWQtb2ZmLWJ5OiBSYW8gU2hv
YWliICZsdDs8YQogICAgICAgICAgICAgICAgICAgICAgICBocmVmPSJtYWlsdG86cmFvLnNob2Fp
YkBvcmFjbGUuY29tIiBjbGFzcz0iIgogICAgICAgICAgICAgICAgICAgICAgICBtb3otZG8tbm90
LXNlbmQ9InRydWUiPnJhby5zaG9haWJAb3JhY2xlLmNvbTwvYT4mZ3Q7PGJyCiAgICAgICAgICAg
ICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLS0tPGJyIGNsYXNz
PSIiPgogICAgICAgICAgICAgICAgICAgICAgoKBpbmNsdWRlL2xpbnV4L3NrYnVmZi5oIKCgoKCg
fCCgoDggKystPGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAg
ICAgICAgICAgICAgoKBpbmNsdWRlL25ldC9tcHRjcC5oIKCgoKCgoKCgfCCgMjEgKysrLS0tPGJy
CiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
oKBpbmNsdWRlL25ldC9tcHRjcF92NC5oIKCgoKCgfCCgoDEgKzxiciBjbGFzcz0iIj4KICAgICAg
ICAgICAgICAgICAgICAgIKCgaW5jbHVkZS9uZXQvc29jay5oIKCgoKCgoKCgoHwgoDEyICsrKy08
YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAg
ICCgoGluY2x1ZGUvbmV0L3RjcC5oIKCgoKCgoKCgoKB8IKAyMyArKystLS0tPGJyCiAgICAgICAg
ICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKBuZXQvaXB2
NC9hZl9pbmV0LmMgoKCgoKCgoKCgfCCgoDQgKys8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAg
ICAgICAgICCgoG5ldC9pcHY0L3RjcF9pbnB1dC5jIKCgoKCgoKB8IKAzNyArKy0tLS0tLS0tPGJy
CiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
oKBuZXQvaXB2NC90Y3BfaXB2NC5jIKCgoKCgoKCgfCAxMzUKICAgICAgICAgICAgICAgICAgICAg
ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS08YnIgY2xhc3M9IiI+CiAgICAg
ICAgICAgICAgICAgICAgICCgoG5ldC9pcHY0L3RjcF9vdXRwdXQuYyCgoKCgoKB8IKCgMSArPGJy
IGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKBuZXQvaXB2Ni9hZl9pbmV0Ni5jIKCg
oKCgoKCgfCCgoDQgKys8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoG5ldC9p
cHY2L3RjcF9pcHY2LmMgoKCgoKCgoKB8IKCgNCAtLTxiciBjbGFzcz0iIj4KICAgICAgICAgICAg
ICAgICAgICAgIKCgbmV0L21wdGNwL21wdGNwX2N0cmwuYyCgoKCgoHwgoDIxICsrKysrKzxicgog
ICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCg
bmV0L21wdGNwL21wdGNwX2lucHV0LmMgoKCgoHwgMTMxCiAgICAgICAgICAgICAgICAgICAgICAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS08YnIgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICCgoG5ldC9tcHRjcC9tcHRjcF9pcHY0LmMgoKCgoKB8IKAzNSArLS0tLS0t
LS0tPGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAg
ICAgICAgoKBuZXQvbXB0Y3AvbXB0Y3BfaXB2Ni5jIKCgoKCgfCCgoDQgKy08YnIgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICCgoG5ldC9tcHRjcC9tcHRjcF9vdXRwdXQuYyCgoKB8IDE2
MAogICAgICAgICAgICAgICAgICAgICAgKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS08YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICCgoG5ldC9tcHRjcC9tcHRjcF9yZWR1bmRhbnQuYyB8IKCgNiArLTxiciBj
bGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgbmV0L21wdGNwL21wdGNwX3JyLmMgoKCg
oKCgoHwgoKA0ICstPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKBuZXQvbXB0
Y3AvbXB0Y3Bfc2NoZWQuYyCgoKCgfCCgMTAgKy0tPGJyCiAgICAgICAgICAgICAgICAgICAgICAg
IGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKAxOSBmaWxlcyBjaGFuZ2VkLCAzMzUg
aW5zZXJ0aW9ucygrKSwgMjg2CiAgICAgICAgICAgICAgICAgICAgICBkZWxldGlvbnMoLSk8YnIg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICA8YnIgY2xhc3M9IiI+CiAgICAgICAgICAg
ICAgICAgICAgICBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9za2J1ZmYuaAogICAgICAgICAg
ICAgICAgICAgICAgYi9pbmNsdWRlL2xpbnV4L3NrYnVmZi5oPGJyIGNsYXNzPSIiPgogICAgICAg
ICAgICAgICAgICAgICAgaW5kZXggZjY2Y2Q1ZS4uMzQ4Y2JjMSAxMDA2NDQ8YnIgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICAtLS0gYS9pbmNsdWRlL2xpbnV4L3NrYnVmZi5oPGJyIGNs
YXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKysrIGIvaW5jbHVkZS9saW51eC9za2J1ZmYu
aDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIEBAIC01MzIsNyArNTMyLDEzIEBA
IHN0cnVjdCBza19idWZmIHs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+c3RydWN0CiAgICAgICAgICAgICAgICAgICAgICByYl9ub2RlPHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnJibm9kZTsKICAg
ICAgICAgICAgICAgICAgICAgIC8qIHVzZWQgaW4gbmV0ZW0gJmFtcDsgdGNwIHN0YWNrICovPGJy
IGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+fTs8YnIKICAgICAgICAgICAg
ICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5zdHJ1Y3QK
ICAgICAgICAgICAgICAgICAgICAgIHNvY2s8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPipzazs8YnIKICAgICAgICAgICAgICAg
ICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnN0cnVjdAogICAg
ICAgICAgICAgICAgICAgICAgbmV0X2RldmljZTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4qZGV2OzxicgogICAgICAgICAgICAgICAg
ICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+dW5pb24KICAgICAg
ICAgICAgICAgICAgICAgIHs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj5zdHJ1Y3QKICAgICAgICAgICAgICAgICAgICAgIG5ldF9kZXZpY2U8c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+KmRldjs8YnIK
ICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAr
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj5zdHJ1Y3QKICAgICAgICAgICAgICAgICAgICAgIHs8YnIgY2xhc3M9IiI+CiAgICAg
ICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+X191OAogICAgICAgICAgICAgICAgICAgICAg
bXB0Y3BfZmxhZ3M7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPl9fdTgKICAgICAgICAgICAgICAgICAgICAgIG1wdGNwX2Rzc19vZmY7PGJyIGNsYXNzPSIi
PgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+fTs8YnIKICAgICAgICAgICAgICAgICAg
ICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPn07PGJyCiAgICAgICAg
ICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+Lyo8
YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAg
ICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICAgICogVGhpcyBpcyB0aGUgY29udHJvbCBidWZm
ZXIuIEl0IGlzIGZyZWUgdG8gdXNlCiAgICAgICAgICAgICAgICAgICAgICBmb3IgZXZlcnk8YnIg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9uZXQv
bXB0Y3AuaAogICAgICAgICAgICAgICAgICAgICAgYi9pbmNsdWRlL25ldC9tcHRjcC5oPGJyIGNs
YXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgaW5kZXggODc2ZjFlNi4uZDA4N2NiNCAxMDA2
NDQ8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtLS0gYS9pbmNsdWRlL25ldC9t
cHRjcC5oPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKysrIGIvaW5jbHVkZS9u
ZXQvbXB0Y3AuaDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIEBAIC04MDcsNyAr
ODA3LDcgQEAgdm9pZAogICAgICAgICAgICAgICAgICAgICAgdGNwX3BhcnNlX21wdGNwX29wdGlv
bnMoY29uc3Qgc3RydWN0IHNrX2J1ZmYgKnNrYiw8YnIKICAgICAgICAgICAgICAgICAgICAgICAg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPgogICAgICAgICAg
ICAgICAgICAgICAgoKCgoHN0cnVjdCBtcHRjcF9vcHRpb25zX3JlY2VpdmVkICptb3B0KTs8YnIK
ICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCg
oHZvaWQgbXB0Y3BfcGFyc2Vfb3B0aW9ucyhjb25zdCB1aW50OF90ICpwdHIsIGludAogICAgICAg
ICAgICAgICAgICAgICAgb3BzaXplLDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAg
IKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgbXB0Y3Bfb3B0aW9u
c19yZWNlaXZlZCAqbW9wdCw8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3Qgc2tfYnVmZiAqc2ti
LDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4KICAgICAg
ICAgICAgICAgICAgICAgIHN0cnVjdCBza19idWZmICpza2IsPGJyIGNsYXNzPSIiPgogICAgICAg
ICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICAgIHN0cnVj
dCB0Y3Bfc29jayAqdHApOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgdm9p
ZCBtcHRjcF9zeW5fb3B0aW9ucyhjb25zdCBzdHJ1Y3Qgc29jayAqc2ssCiAgICAgICAgICAgICAg
ICAgICAgICBzdHJ1Y3QgdGNwX291dF9vcHRpb25zICpvcHRzLDxiciBjbGFzcz0iIj4KICAgICAg
ICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICAgIKCgoKCgoHVu
c2lnbmVkICpyZW1haW5pbmcpOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIEBA
IC05OTgsMTQgKzk5OCwxNSBAQCBzdGF0aWMgaW5saW5lIHZvaWQKICAgICAgICAgICAgICAgICAg
ICAgIG1wdGNwX3N1Yl9mb3JjZV9jbG9zZV9hbGwoc3RydWN0IG1wdGNwX2NiICptcGNiLDxicgog
ICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCg
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPn08YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAg
ICAgICAgICCgoH08YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArLyogY3VycmVu
dGx5IHRwIGlzIGJlaW5nIHVzZWQgZm9yIFJ4IHBhY2tldHMgKi88YnIKICAgICAgICAgICAgICAg
ICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoHN0YXRpYyBpbmxpbmUg
Ym9vbCBtcHRjcF9pc19kYXRhX3NlcShjb25zdAogICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IHNrX2J1ZmYgKnNrYik8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoHs8YnIg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnJldHVybgogICAgICAgICAgICAg
ICAgICAgICAgVENQX1NLQl9DQihza2IpLSZndDttcHRjcF9mbGFncyAmYW1wOwogICAgICAgICAg
ICAgICAgICAgICAgTVBUQ1BIRFJfU0VROzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAg
ICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+cmV0dXJuCiAgICAgICAgICAgICAgICAgICAgICBza2ItJmd0O21wdGNwX2ZsYWdz
ICZhbXA7IE1QVENQSERSX1NFUTs8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICCgoH08YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAg
ICAgICCgoHN0YXRpYyBpbmxpbmUgYm9vbCBtcHRjcF9pc19kYXRhX2Zpbihjb25zdAogICAgICAg
ICAgICAgICAgICAgICAgc3RydWN0IHNrX2J1ZmYgKnNrYik8YnIgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICCgoHs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PnJldHVybgogICAgICAgICAgICAgICAgICAgICAgVENQX1NLQl9DQihza2IpLSZndDttcHRjcF9m
bGFncyAmYW1wOwogICAgICAgICAgICAgICAgICAgICAgTVBUQ1BIRFJfRklOOzxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cmV0dXJuCiAgICAgICAgICAgICAgICAgICAg
ICBza2ItJmd0O21wdGNwX2ZsYWdzICZhbXA7IE1QVENQSERSX0ZJTjs8YnIKICAgICAgICAgICAg
ICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoH08YnIgY2xhc3M9
IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoC8qIElzIGl0IGEgZGF0YS1maW4gd2hpbGUgaW4g
aW5maW5pdGUgbWFwcGluZwogICAgICAgICAgICAgICAgICAgICAgbW9kZT88YnIgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICBAQCAtMTAzNCwxNyArMTAzNSwxNyBAQCBzdGF0aWMgaW5s
aW5lIHU4CiAgICAgICAgICAgICAgICAgICAgICBtcHRjcF9nZXRfNjRfYml0KHU2NCBkYXRhX3Nl
cSwgc3RydWN0IG1wdGNwX2NiCiAgICAgICAgICAgICAgICAgICAgICAqbXBjYik8YnIgY2xhc3M9
IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoC8qIFNldHMgdGhlIGRhdGFfc2VxIGFuZCByZXR1
cm5zIHBvaW50ZXIgdG8gdGhlCiAgICAgICAgICAgICAgICAgICAgICBpbi1za2IgZmllbGQgb2Yg
dGhlIGRhdGFfc2VxLjxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgoCogSWYg
dGhlIHBhY2tldCBoYXMgYSA2NC1iaXQgZHNlcSwgdGhlIHBvaW50ZXIKICAgICAgICAgICAgICAg
ICAgICAgIHBvaW50cyB0byB0aGUgbGFzdCAzMiBiaXRzLjxiciBjbGFzcz0iIj4KICAgICAgICAg
ICAgICAgICAgICAgIKCgoCovPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLXN0
YXRpYyBpbmxpbmUgX191MzIgKm1wdGNwX3NrYl9zZXRfZGF0YV9zZXEoY29uc3QKICAgICAgICAg
ICAgICAgICAgICAgIHN0cnVjdCBza19idWZmICpza2IsPGJyIGNsYXNzPSIiPgogICAgICAgICAg
ICAgICAgICAgICAgK3N0YXRpYyBpbmxpbmUgX191MzIKICAgICAgICAgICAgICAgICAgICAgICpt
cHRjcF9za2Jfc2V0X2RhdGFfc2VxKHN0cnVjdCBza19idWZmICpza2IsPGJyCiAgICAgICAgICAg
ICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAgoKCgdTMyICpkYXRhX3NlcSw8YnIgY2xh
c3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+CiAgICAg
ICAgICAgICAgICAgICAgICCgoKBzdHJ1Y3QgbXB0Y3BfY2IgKm1wY2IpPGJyIGNsYXNzPSIiPgog
ICAgICAgICAgICAgICAgICAgICAgoKB7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAg
ICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj5fX3UzMgogICAgICAgICAgICAgICAgICAgICAgKnB0ciA9IChfX3UzMiAqKShza2Jf
dHJhbnNwb3J0X2hlYWRlcihza2IpICsKICAgICAgICAgICAgICAgICAgICAgIFRDUF9TS0JfQ0Io
c2tiKS0mZ3Q7ZHNzX29mZik7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj5fX3UzMgogICAgICAgICAgICAgICAgICAgICAgKnB0ciA9IChfX3UzMiAqKShza2JfdHJhbnNw
b3J0X2hlYWRlcihza2IpICsKICAgICAgICAgICAgICAgICAgICAgIHNrYi0mZ3Q7bXB0Y3BfZHNz
X29mZik7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pZgogICAgICAg
ICAgICAgICAgICAgICAgKFRDUF9TS0JfQ0Ioc2tiKS0mZ3Q7bXB0Y3BfZmxhZ3MgJmFtcDsKICAg
ICAgICAgICAgICAgICAgICAgIE1QVENQSERSX1NFUTY0X1NFVCkgezxiciBjbGFzcz0iIj4KICAg
ICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAgICAgICAgIChza2ItJmd0
O21wdGNwX2ZsYWdzICZhbXA7IE1QVENQSERSX1NFUTY0X1NFVCkgezxicgogICAgICAgICAgICAg
ICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj51NjQK
ICAgICAgICAgICAgICAgICAgICAgIGRhdGFfc2VxNjQgPSBnZXRfdW5hbGlnbmVkX2JlNjQocHRy
KTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAg
ICAgICAgICAgICAgICAgIChtcGNiKTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAg
IC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj5UQ1BfU0tCX0NCKHNrYiktJmd0O21wdGNwX2ZsYWdzCiAgICAgICAgICAg
ICAgICAgICAgICB8PSBtcHRjcF9nZXRfNjRfYml0KGRhdGFfc2VxNjQsIG1wY2IpOzxiciBjbGFz
cz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5za2ItJmd0O21wdGNwX2Zs
YWdzCiAgICAgICAgICAgICAgICAgICAgICB8PSBtcHRjcF9nZXRfNjRfYml0KGRhdGFfc2VxNjQs
IG1wY2IpOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4qZGF0
YV9zZXEKICAgICAgICAgICAgICAgICAgICAgID0gKHUzMilkYXRhX3NlcTY0OzxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5wdHIrKzs8YnIKICAgICAgICAgICAg
ICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICBAQCAtMTE0Miw3ICsx
MTQzLDcgQEAgc3RhdGljIGlubGluZSB2b2lkCiAgICAgICAgICAgICAgICAgICAgICBtcHRjcF9y
ZXNldF9tb3B0KHN0cnVjdCB0Y3Bfc29jayAqdHApPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAg
ICAgICAgICAgoKBzdGF0aWMgaW5saW5lIF9fYmUzMgogICAgICAgICAgICAgICAgICAgICAgbXB0
Y3BfZ2V0X2hpZ2hvcmRlcl9zbmRiaXRzKGNvbnN0IHN0cnVjdCBza19idWZmCiAgICAgICAgICAg
ICAgICAgICAgICAqc2tiLDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3Qg
bXB0Y3BfY2IgKm1wY2IpPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKB7PGJy
IGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5yZXR1cm4KaHRvbmwobXBjYi0m
Z3Q7c25kX2hpZ2hfb3JkZXJbKFRDUF9TS0JfQ0Ioc2tiKS0mZ3Q7bXB0Y3BfZmxhZ3MgJmFtcDs8
YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAg
ICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPnJldHVybgogICAgICAgICAgICAgICAgICAgICAgaHRvbmwobXBjYi0mZ3Q7c25kX2hp
Z2hfb3JkZXJbKHNrYi0mZ3Q7bXB0Y3BfZmxhZ3MKICAgICAgICAgICAgICAgICAgICAgICZhbXA7
PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5NUFRDUEhE
Ul9TRVE2NF9JTkRFWCkKICAgICAgICAgICAgICAgICAgICAgID8gMSA6IDBdKTs8YnIgY2xhc3M9
IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoH08YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAg
ICAgICAgICBAQCAtMTQwNCw4ICsxNDA1LDggQEAgc3RhdGljIGlubGluZSB2b2lkCiAgICAgICAg
ICAgICAgICAgICAgICBtcHRjcF9zZXRfcnRvKGNvbnN0IHN0cnVjdCBzb2NrICpzaykge308YnIK
ICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCg
oHN0YXRpYyBpbmxpbmUgdm9pZCBtcHRjcF9zZW5kX2Zpbihjb25zdCBzdHJ1Y3QKICAgICAgICAg
ICAgICAgICAgICAgIHNvY2sgKm1ldGFfc2spIHt9PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAg
ICAgICAgICAgoKBzdGF0aWMgaW5saW5lIHZvaWQgbXB0Y3BfcGFyc2Vfb3B0aW9ucyhjb25zdAog
ICAgICAgICAgICAgICAgICAgICAgdWludDhfdCAqcHRyLCBjb25zdCBpbnQgb3BzaXplLDxiciBj
bGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPgogICAgICAg
ICAgICAgICAgICAgICAgoKCgoKCgc3RydWN0IG1wdGNwX29wdGlvbnNfcmVjZWl2ZWQgKm1vcHQs
PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAg
ICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICAgIKCgoKCgoGNvbnN0IHN0
cnVjdCBza19idWZmICpza2IsPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICAgIKCgoKCgoGNvbnN0IHN0cnVjdCB0
Y3Bfc29jayAqdHApIHt9PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICAgIKCgoKCgoHN0cnVjdCBza19idWZmICpz
a2IsPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4K
ICAgICAgICAgICAgICAgICAgICAgIKCgoKCgoHN0cnVjdCB0Y3Bfc29jayAqdHApIHt9PGJyIGNs
YXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKBzdGF0aWMgaW5saW5lIHZvaWQgbXB0Y3Bf
c3luX29wdGlvbnMoY29uc3QKICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBzb2NrICpzayw8
YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4KICAg
ICAgICAgICAgICAgICAgICAgIKCgoKBzdHJ1Y3QgdGNwX291dF9vcHRpb25zICpvcHRzLDxiciBj
bGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPgogICAgICAg
ICAgICAgICAgICAgICAgoKCgoHVuc2lnbmVkICpyZW1haW5pbmcpIHt9PGJyIGNsYXNzPSIiPgog
ICAgICAgICAgICAgICAgICAgICAgZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L21wdGNwX3Y0LmgK
ICAgICAgICAgICAgICAgICAgICAgIGIvaW5jbHVkZS9uZXQvbXB0Y3BfdjQuaDxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgIGluZGV4IGM4M2RjYTAuLjQ2Mzk0YTQgMTAwNjQ0PGJy
IGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLS0tIGEvaW5jbHVkZS9uZXQvbXB0Y3Bf
djQuaDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICsrKyBiL2luY2x1ZGUvbmV0
L21wdGNwX3Y0Lmg8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICBAQCAtNDUsNiAr
NDUsNyBAQCBleHRlcm4gc3RydWN0CiAgICAgICAgICAgICAgICAgICAgICB0Y3BfcmVxdWVzdF9z
b2NrX29wcwogICAgICAgICAgICAgICAgICAgICAgbXB0Y3Bfam9pbl9yZXF1ZXN0X3NvY2tfaXB2
NF9vcHM7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKAjaWZkZWYgQ09ORklH
X01QVENQPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKBpbnQgbXB0Y3BfdjRf
ZG9fcmN2KHN0cnVjdCBzb2NrICptZXRhX3NrLCBzdHJ1Y3QKICAgICAgICAgICAgICAgICAgICAg
IHNrX2J1ZmYgKnNrYik7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgK2ludCBt
cHRjcF92NF9wcm9jZXNzX2pvaW5fcmVxKHN0cnVjdCBzb2NrCiAgICAgICAgICAgICAgICAgICAg
ICAqbWV0YV9zaywgc3RydWN0IHNrX2J1ZmYgKnNrYik7PGJyIGNsYXNzPSIiPgogICAgICAgICAg
ICAgICAgICAgICAgoKBzdHJ1Y3Qgc29jayAqbXB0Y3BfdjRfc2VhcmNoX3JlcShjb25zdCBfX2Jl
MTYKICAgICAgICAgICAgICAgICAgICAgIHJwb3J0LCBjb25zdCBfX2JlMzIgcmFkZHIsPGJyIGNs
YXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+CiAgICAgICAg
ICAgICAgICAgICAgICBjb25zdCBfX2JlMzIgbGFkZHIsIGNvbnN0IHN0cnVjdCBuZXQgKm5ldCk7
PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAg
ICAgoKBpbnQgbXB0Y3BfaW5pdDRfc3Vic29ja2V0cyhzdHJ1Y3Qgc29jayAqbWV0YV9zaywKICAg
ICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBtcHRjcF9sb2M0ICpsb2MsPGJyIGNsYXNz
PSIiPgogICAgICAgICAgICAgICAgICAgICAgZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L3NvY2su
aAogICAgICAgICAgICAgICAgICAgICAgYi9pbmNsdWRlL25ldC9zb2NrLmg8YnIgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICBpbmRleCAwZjEyNTkzLi4wZDFiZGE1IDEwMDY0NDxiciBj
bGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC0tLSBhL2luY2x1ZGUvbmV0L3NvY2suaDxi
ciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICsrKyBiL2luY2x1ZGUvbmV0L3NvY2su
aDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIEBAIC0yOTYsNiArMjk2LDcgQEAg
c3RydWN0IGNnX3Byb3RvOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgoKAq
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPkBza193cml0ZV9zcGFjZToKICAgICAgICAgICAgICAgICAgICAgIGNhbGxiYWNrIHRvIGlu
ZGljYXRlIHRoZXJlIGlzIGJmIHNlbmRpbmcgc3BhY2UKICAgICAgICAgICAgICAgICAgICAgIGF2
YWlsYWJsZTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgoKAqPHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPkBza19l
cnJvcl9yZXBvcnQ6CiAgICAgICAgICAgICAgICAgICAgICBjYWxsYmFjayB0byBpbmRpY2F0ZSBl
cnJvcnMgKGUuZy4gJU1TR19FUlJRVUVVRSk8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xh
c3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoKCgKjxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5Ac2tfYmFja2xvZ19yY3Y6CiAg
ICAgICAgICAgICAgICAgICAgICBjYWxsYmFjayB0byBwcm9jZXNzIHRoZSBiYWNrbG9nPGJyIGNs
YXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKyCgKjxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5Ac2tfcHJlcXVldWU6CiAgICAg
ICAgICAgICAgICAgICAgICBjYWxsYmFjayB0byBwcmVxdWV1ZTxiciBjbGFzcz0iIj4KICAgICAg
ICAgICAgICAgICAgICAgIKCgoKAqPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPkBza19kZXN0cnVjdDoKICAgICAgICAgICAgICAgICAg
ICAgIGNhbGxlZCBhdCBzb2NrIGZyZWVpbmcgdGltZSwgaS5lLiB3aGVuIGFsbCByZWZjbnQKICAg
ICAgICAgICAgICAgICAgICAgID09IDA8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAg
ICCgoKAqLzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgc3RydWN0IHNvY2sg
ezxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIEBAIC00MzcsNyArNDM4LDkgQEAg
c3RydWN0IHNvY2sgezxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnZv
aWQ8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj4oKnNrX3dyaXRlX3NwYWNlKShzdHJ1Y3QKICAgICAgICAgICAgICAgICAg
ICAgIHNvY2sgKnNrKTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj52
b2lkPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+KCpza19lcnJvcl9yZXBvcnQpKHN0cnVjdAogICAgICAgICAgICAgICAg
ICAgICAgc29jayAqc2spOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PmludDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPigqc2tfYmFja2xvZ19yY3YpKHN0cnVjdAogICAgICAgICAgICAgICAg
ICAgICAgc29jayAqc2ssPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAgoHN0cnVjdCBza19idWZm
ICpza2IpOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj5zdHJ1Y3QKICAgICAgICAgICAgICAgICAgICAgIHNrX2J1ZmYgKnNrYik7PGJy
IGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5ib29sPHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+KCpz
a19wcmVxdWV1ZSkoc3RydWN0CiAgICAgICAgICAgICAgICAgICAgICBzb2NrICpzayw8YnIgY2xh
c3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c3Ry
dWN0CiAgICAgICAgICAgICAgICAgICAgICBza19idWZmICpza2IpOzxiciBjbGFzcz0iIj4KICAg
ICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnZvaWQKICAgICAgICAgICAgICAgICAgICAgIKCgoKCg
oKCgoKCgoKCgoKCgoKAoKnNrX2Rlc3RydWN0KShzdHJ1Y3Qgc29jawogICAgICAgICAgICAgICAg
ICAgICAgKnNrKTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoH07PGJyIGNs
YXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgQEAgLTg1Myw2ICs4NTYsMTEgQEAgc3RhdGlj
IGlubGluZSBpbnQKICAgICAgICAgICAgICAgICAgICAgIHNrX2JhY2tsb2dfcmN2KHN0cnVjdCBz
b2NrICpzaywgc3RydWN0IHNrX2J1ZmYKICAgICAgICAgICAgICAgICAgICAgICpza2IpPGJyIGNs
YXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cmV0dXJuCiAgICAgICAgICAgICAg
ICAgICAgICBzay0mZ3Q7c2tfYmFja2xvZ19yY3Yoc2ssIHNrYik7PGJyIGNsYXNzPSIiPgogICAg
ICAgICAgICAgICAgICAgICAgoKB9PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
K3N0YXRpYyBpbmxpbmUgYm9vbCBza19wcmVxdWV1ZShzdHJ1Y3Qgc29jayAqc2ssCiAgICAgICAg
ICAgICAgICAgICAgICBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKTxiciBjbGFzcz0iIj4KICAgICAgICAg
ICAgICAgICAgICAgICt7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5y
ZXR1cm4KICAgICAgICAgICAgICAgICAgICAgIChmYWxzZSk7PGJyIGNsYXNzPSIiPgogICAgICAg
ICAgICAgICAgICAgICAgK308YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPGJy
IGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKBzdGF0aWMgaW5saW5lIHZvaWQgc2tf
aW5jb21pbmdfY3B1X3VwZGF0ZShzdHJ1Y3QKICAgICAgICAgICAgICAgICAgICAgIHNvY2sgKnNr
KTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgezxiciBjbGFzcz0iIj4KICAg
ICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnNrLSZndDtza19pbmNvbWluZ19jcHUKICAgICAgICAg
ICAgICAgICAgICAgID0gcmF3X3NtcF9wcm9jZXNzb3JfaWQoKTs8YnIgY2xhc3M9IiI+CiAgICAg
ICAgICAgICAgICAgICAgICBAQCAtOTkzLDYgKzEwMDEsOCBAQCBzdHJ1Y3QgcHJvdG8gezxiciBj
bGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmludDxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPigqYmFj
a2xvZ19yY3YpCiAgICAgICAgICAgICAgICAgICAgICAoc3RydWN0IHNvY2sgKnNrLDxiciBjbGFz
cz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c3Ry
dWN0CiAgICAgICAgICAgICAgICAgICAgICBza19idWZmICpza2IpOzxiciBjbGFzcz0iIj4KICAg
ICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+Ym9vbDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPigqcHJlcXVldWUpCiAgICAg
ICAgICAgICAgICAgICAgICAoc3RydWN0IHNvY2sgKnNrLDxiciBjbGFzcz0iIj4KICAgICAgICAg
ICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5zdHJ1Y3QKICAgICAgICAgICAg
ICAgICAgICAgIHNrX2J1ZmYgKnNrYik7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAg
ICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+dm9pZDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+KCpyZWxlYXNlX2NiKShzdHJ1Y3QKICAgICAgICAgICAgICAg
ICAgICAgIHNvY2sgKnNrKTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9uZXQvdGNwLmggYi9pbmNsdWRlL25ldC90Y3AuaDxicgogICAgICAg
ICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIGluZGV4IDY1
NWVjZDQuLmNiZThlZjIgMTAwNjQ0PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
LS0tIGEvaW5jbHVkZS9uZXQvdGNwLmg8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAg
ICArKysgYi9pbmNsdWRlL25ldC90Y3AuaDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAg
ICAgIEBAIC00Nyw2ICs0Nyw5IEBAPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
oKAjaW5jbHVkZSAmbHQ7bGludXgvc2VxX2ZpbGUuaCZndDs8YnIgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICCgoCNpbmNsdWRlICZsdDtsaW51eC9tZW1jb250cm9sLmgmZ3Q7PGJyIGNs
YXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgK3R5cGVkZWYgaW50ICgqIHByb2Nlc3NfdW5j
bGFpbWVkKShzdHJ1Y3Qgc29jawogICAgICAgICAgICAgICAgICAgICAgKnNrLCBzdHJ1Y3Qgc2tf
YnVmZiAqc2tiKTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArZXh0ZXJuIHBy
b2Nlc3NfdW5jbGFpbWVkIHRjcF9wcm9jZXNzX3VuY2xhaW1lZDs8YnIKICAgICAgICAgICAgICAg
ICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPGJyIGNsYXNzPSIiPgog
ICAgICAgICAgICAgICAgICAgICAgoKBleHRlcm4gc3RydWN0IGluZXRfaGFzaGluZm8gdGNwX2hh
c2hpbmZvOzxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAg
ICAgICAgICAgIKCgZXh0ZXJuIHN0cnVjdCBwZXJjcHVfY291bnRlciB0Y3Bfb3JwaGFuX2NvdW50
OzxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAg
ICAgIEBAIC01ODEsNiArNTg0LDcgQEAgc3RydWN0IHNvY2sKICAgICAgICAgICAgICAgICAgICAg
ICp0Y3BfdjRfc3luX3JlY3Zfc29jayhzdHJ1Y3Qgc29jayAqc2ssIHN0cnVjdAogICAgICAgICAg
ICAgICAgICAgICAgc2tfYnVmZiAqc2tiLDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAg
ICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAgoHN0cnVjdCByZXF1
ZXN0X3NvY2sgKnJlcSw8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICAgIKBzdHJ1Y3QgZHN0X2VudHJ5ICpkc3Qp
OzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgaW50IHRjcF92NF9kb19yY3Yo
c3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3QKICAgICAgICAgICAgICAgICAgICAgIHNrX2J1ZmYgKnNr
Yik7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxiciBjbGFzcz0iIj4KICAg
ICAgICAgICAgICAgICAgICAgIKCgaW50IHRjcF92NF9jb25uZWN0KHN0cnVjdCBzb2NrICpzaywg
c3RydWN0CiAgICAgICAgICAgICAgICAgICAgICBzb2NrYWRkciAqdWFkZHIsIGludCBhZGRyX2xl
bik7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKBpbnQgdGNwX2Nvbm5lY3Qo
c3RydWN0IHNvY2sgKnNrKTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoHN0
cnVjdCBza19idWZmICp0Y3BfbWFrZV9zeW5hY2soc3RydWN0IHNvY2sgKnNrLAogICAgICAgICAg
ICAgICAgICAgICAgc3RydWN0IGRzdF9lbnRyeSAqZHN0LDxiciBjbGFzcz0iIj4KICAgICAgICAg
ICAgICAgICAgICAgIEBAIC04NDIsMTEgKzg0Niw2IEBAIHN0cnVjdCB0Y3Bfc2tiX2NiIHs8YnIK
ICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCg
oDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+X191MzI8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPnRjcF9nc29fc2Vnczs8YnIKICAgICAgICAgICAgICAgICAg
ICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj59OzxicgogICAgICAg
ICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC0jaWZkZWYg
Q09ORklHX01QVENQPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5fX3U4
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj5tcHRjcF9mbGFnczs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+LyoKICAgICAgICAgICAgICAgICAgICAgIGZsYWdzIGZv
ciB0aGUgTVBUQ1AgbGF5ZXIgoKCgKi88YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAg
ICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPl9fdTg8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPmRzc19vZmY7PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPi8qCiAgICAgICAgICAgICAgICAgICAgICBO
dW1iZXIgb2YgNC1ieXRlIHdvcmRzIHVudGlsPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAg
ICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgICAqIHNlcS1u
dW1iZXIgKi88YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtI2VuZGlmPGJyIGNs
YXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+X191ODxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+dGNwX2ZsYWdz
OzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj4vKgogICAgICAgICAgICAgICAgICAgICAgVENQIGhlYWRlciBmbGFncy4gKHRjcFsxM10p
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPiovPGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAg
ICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+X191ODxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c2Fja2VkOzxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+LyoKICAgICAgICAgICAg
ICAgICAgICAgIFN0YXRlIGZsYWdzIGZvciBTQUNLL0ZBQ0suPHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPiovPGJyCiAgICAgICAgICAg
ICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgQEAgLTg1OSw5ICs4
NTgsMTMgQEAgc3RydWN0IHRjcF9za2JfY2IgezxicgogICAgICAgICAgICAgICAgICAgICAgICBj
bGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgI2RlZmluZSBUQ1BDQl9SRVRSQU5TPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj4oVENQQ0JfU0FDS0VEX1JFVFJBTlN8VENQQ0JfRVZFUl9SRVRSQU5TfAogICAgICAgICAg
ICAgICAgICAgICAgXDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPlRDUENCX1JFUEFJUkVEKTxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFz
cz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+X191ODxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aXBfZHNmaWVsZDs8
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+LyoKICAgICAgICAgICAgICAgICAgICAgIElQdjQgdG9zIG9yIElQdjYgZHNmaWVsZDxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4q
LzxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAg
ICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+X191ODxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aXBfZHNmaWVsZDs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+LyoKICAgICAgICAgICAgICAgICAg
ICAgIElQdjQgdG9zIG9yIElQdjYgZHNmaWVsZCAqLzxiciBjbGFzcz0iIj4KICAgICAgICAgICAg
ICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPi8qCiAgICAgICAgICAgICAgICAgICAgICAxIGJ5dGUgaG9sZSAqLzxi
ciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+X191MzI8c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmFja19z
ZXE7PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPi8qCiAgICAgICAgICAgICAgICAgICAgICBTZXF1ZW5jZSBudW1iZXIgQUNLJ2Q8c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
Ki88YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAg
ICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPnVuaW9uCiAgICAgICAgICAgICAgICAgICAgICB7PGJyIGNsYXNzPSIiPgogICAg
ICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+X191MzI8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmFja19zZXE7PHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPi8qCiAg
ICAgICAgICAgICAgICAgICAgICBTZXF1ZW5jZSBudW1iZXIgQUNLJ2QgKi88YnIgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5fX3UzMgogICAgICAgICAgICAgICAgICAg
ICAgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj5tcHRjcF9kYXRhX3NlcTs8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xh
c3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5fX3UzMjxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+bXB0Y3Bf
cGF0aF9tYXNrOzxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAg
ICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+fTs8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj51bmlvbgogICAgICAgICAgICAgICAgICAgICAg
ezxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj51bmlvbgogICAg
ICAgICAgICAgICAgICAgICAgezxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCg
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+c3RydWN0CiAgICAgICAgICAgICAgICAgICAgICBpbmV0X3NrYl9wYXJtPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
Pmg0OzxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAg
ICAgICAgIEBAIC04NjksMTIgKzg3Miw2IEBAIHN0cnVjdCB0Y3Bfc2tiX2NiIHs8YnIKICAgICAg
ICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPnN0cnVjdAogICAgICAgICAgICAgICAgICAgICAgaW5ldDZfc2tiX3Bhcm08c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aDY7
PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAg
ICAgoKAjZW5kaWY8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
fQogICAgICAgICAgICAgICAgICAgICAgaGVhZGVyOzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4vKgogICAgICAgICAgICAgICAgICAg
ICAgRm9yIGluY29taW5nIGZyYW1lczxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+Ki88YnIKICAgICAgICAgICAgICAgICAgICAg
ICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtI2lmZGVmIENPTkZJR19NUFRDUDxi
ciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnVuaW9uCiAgICAgICAg
ICAgICAgICAgICAgICB7PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+LyoKICAgICAgICAgICAgICAgICAgICAgIEZvciBN
UFRDUCBvdXRnb2luZyBmcmFtZXMgKi88YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAg
ICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+X191MzIKICAgICAgICAgICAgICAgICAgICAgIHBhdGhfbWFzazsgLyog
cGF0aHMgdGhhdCB0cmllZCB0byBzZW5kIHRoaXMgc2tiICovPGJyCiAgICAgICAgICAgICAgICAg
ICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPl9fdTMy
CiAgICAgICAgICAgICAgICAgICAgICBkc3NbNl07PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPi8qCiAgICAgICAgICAgICAgICAgICAg
ICBEU1Mgb3B0aW9ucyAqLzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPn07PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAg
ICAgICAgICAgLSNlbmRpZjxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
Pn07PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAg
ICAgICAgoKB9OzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIGRpZmYgLS1naXQg
YS9uZXQvaXB2NC9hZl9pbmV0LmMKICAgICAgICAgICAgICAgICAgICAgIGIvbmV0L2lwdjQvYWZf
aW5ldC5jPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgaW5kZXggNzM0ODBiOS4u
MWU3ODI3ZiAxMDA2NDQ8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtLS0gYS9u
ZXQvaXB2NC9hZl9pbmV0LmM8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArKysg
Yi9uZXQvaXB2NC9hZl9pbmV0LmM8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICBA
QCAtMzU2LDYgKzM1NiwxMCBAQCBsb29rdXBfcHJvdG9jb2w6PGJyIGNsYXNzPSIiPgogICAgICAg
ICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c2stJmd0O3NrX2Rlc3RydWN0PHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPgogICAgICAgICAgICAg
ICAgICAgICAgoKA9IGluZXRfc29ja19kZXN0cnVjdDs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAg
ICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj5zay0mZ3Q7c2tfcHJvdG9jb2w8c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+CiAgICAgICAgICAgICAgICAg
ICAgICCgoD0gcHJvdG9jb2w7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+c2stJmd0O3NrX2JhY2tsb2dfcmN2CiAgICAgICAgICAgICAgICAgICAgICA9IHNrLSZndDtz
a19wcm90LSZndDtiYWNrbG9nX3Jjdjs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAg
ICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPnNrLSZndDtza19wcmVxdWV1ZQogICAgICAgICAgICAgICAgICAgICAgPSBzay0mZ3Q7
c2tfcHJvdC0mZ3Q7cHJlcXVldWU7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj5pZgogICAgICAgICAgICAgICAgICAgICAgKHNrLSZndDtza19wcmVxdWV1ZSA9PSBOVUxM
KSB7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c2stJmd0O3Nr
X3ByZXF1ZXVlCiAgICAgICAgICAgICAgICAgICAgICA9IHNrX3ByZXF1ZXVlOzxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+fTxicgogICAgICAgICAgICAgICAgICAgICAg
ICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmluZXQtJmd0O3VjX3R0bDxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj49CiAgICAgICAgICAgICAgICAgICAgICAtMTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAg
ICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj5pbmV0LSZndDttY19sb29wPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPj0KICAgICAgICAgICAgICAgICAgICAg
IDE7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgZGlmZiAtLWdpdCBhL25ldC9p
cHY0L3RjcF9pbnB1dC5jCiAgICAgICAgICAgICAgICAgICAgICBiL25ldC9pcHY0L3RjcF9pbnB1
dC5jPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgaW5kZXggMTZhNzI1Ni4uY2I2
YmJmOSAxMDA2NDQ8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtLS0gYS9uZXQv
aXB2NC90Y3BfaW5wdXQuYzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICsrKyBi
L25ldC9pcHY0L3RjcF9pbnB1dC5jPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
QEAgLTMxMzMsOCArMzEzMyw2IEBAIHN0YXRpYyBpbnQKICAgICAgICAgICAgICAgICAgICAgIHRj
cF9jbGVhbl9ydHhfcXVldWUoc3RydWN0IHNvY2sgKnNrLCBpbnQKICAgICAgICAgICAgICAgICAg
ICAgIHByaW9yX2ZhY2tldHMsPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAgKi88YnIgY2xhc3M9IiI+CiAgICAgICAgICAg
ICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAgICAgICAgIChsaWtlbHkoIShz
Y2ItJmd0O3RjcF9mbGFncyAmYW1wOyBUQ1BIRFJfU1lOKSkpIHs8YnIKICAgICAgICAgICAgICAg
ICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmZs
YWcKICAgICAgICAgICAgICAgICAgICAgIHw9IEZMQUdfREFUQV9BQ0tFRDs8YnIgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAgICAg
ICAgIChtcHRjcCh0cCkgJmFtcDsmYW1wOyBtcHRjcF9pc19kYXRhX3NlcShza2IpKTxicgogICAg
ICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+ZmxhZwogICAgICAgICAgICAgICAgICAgICAgfD0gTVBUQ1BfRkxBR19EQVRB
X0FDS0VEOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj59CiAg
ICAgICAgICAgICAgICAgICAgICBlbHNlIHs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAg
ICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPmZsYWcKICAgICAgICAgICAgICAgICAgICAgIHw9IEZMQUdfU1lO
X0FDS0VEOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
dHAtJmd0O3JldHJhbnNfc3RhbXAKICAgICAgICAgICAgICAgICAgICAgID0gMDs8YnIgY2xhc3M9
IiI+CiAgICAgICAgICAgICAgICAgICAgICBAQCAtMzU4MiwxNiArMzU4MCw2IEBAIHN0YXRpYyBp
bnQgdGNwX2FjayhzdHJ1Y3QKICAgICAgICAgICAgICAgICAgICAgIHNvY2sgKnNrLCBzdHJ1Y3Qg
c2tfYnVmZiAqc2tiLCBpbnQgZmxhZyk8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9
IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4KICAgICAgICAgICAg
ICAgICAgICAgIKCgoHNhY2tfcnR0X3VzKTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAg
ICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj5hY2tlZAogICAgICAgICAgICAgICAgICAgICAgLT0gdHAtJmd0O3BhY2tldHNf
b3V0OzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAg
ICAgICAgICAgICAgIChtcHRjcCh0cCkpIHs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAg
ICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj5pZgogICAgICAgICAgICAgICAgICAgICAgKG1wdGNwX2ZhbGxiYWNrX2lu
ZmluaXRlKHNrLCBmbGFnKSkgezxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj5wcl9lcnIoIiVzCiAgICAgICAgICAgICAgICAgICAgICByZXNldHRpbmcgZmxv
d1xuIiwgX19mdW5jX18pOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj5tcHRjcF9zZW5kX3Jlc2V0KHNrKTs8YnIKICAgICAgICAgICAgICAgICAgICAgICAg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+Z290bwogICAgICAg
ICAgICAgICAgICAgICAgaW52YWxpZF9hY2s7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAg
ICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+fTxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAg
ICAgICAgICAgICAgICAgICAgIC08YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAt
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj5tcHRjcF9jbGVhbl9ydHhfaW5maW5pdGUoc2tiLAogICAgICAgICAgICAgICAgICAg
ICAgc2spOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+fTxicgogICAg
ICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08YnIg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4vKgogICAgICAgICAgICAgICAg
ICAgICAgQWR2YW5jZSBjd25kIGlmIHN0YXRlIGFsbG93cyAqLzxiciBjbGFzcz0iIj4KICAgICAg
ICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmCiAgICAgICAgICAgICAgICAgICAgICAodGNwX21heV9y
YWlzZV9jd25kKHNrLCBmbGFnKSk8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCg
oDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+dGNwX2NvbmdfYXZvaWQoc2ssCiAgICAgICAgICAgICAgICAgICAgICBhY2ssIGFj
a2VkKTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICBAQCAtMzgyNCw4ICszODEy
LDcgQEAgc3RhdGljIGJvb2wKICAgICAgICAgICAgICAgICAgICAgIHRjcF9mYXN0X3BhcnNlX29w
dGlvbnMoY29uc3Qgc3RydWN0IHNrX2J1ZmYgKnNrYiw8YnIKICAgICAgICAgICAgICAgICAgICAg
ICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAg
ICAgICAgICAgICAgICh0Y3BfcGFyc2VfYWxpZ25lZF90aW1lc3RhbXAodHAsIHRoKSk8YnIgY2xh
c3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnJldHVybgogICAgICAg
ICAgICAgICAgICAgICAgdHJ1ZTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCg
oDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj59PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAg
ICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj50Y3BfcGFyc2Vfb3B0aW9ucyhza2IsCiAgICAgICAgICAgICAgICAgICAg
ICAmYW1wO3RwLSZndDtyeF9vcHQsPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAgoG1wdGNwKHRwKSA/ICZhbXA7dHAt
Jmd0O21wdGNwLSZndDtyeF9vcHQgOiBOVUxMLAogICAgICAgICAgICAgICAgICAgICAgMSwgTlVM
TCwgdHApOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+dGNwX3BhcnNl
X29wdGlvbnMoc2tiLAogICAgICAgICAgICAgICAgICAgICAgJmFtcDt0cC0mZ3Q7cnhfb3B0LCBO
VUxMLCAxLCBOVUxMLCB0cCk7PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgog
ICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAgICAgICAgICh0cC0m
Z3Q7cnhfb3B0LnNhd190c3RhbXAgJmFtcDsmYW1wOwogICAgICAgICAgICAgICAgICAgICAgdHAt
Jmd0O3J4X29wdC5yY3ZfdHNlY3IpPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
oKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPnRwLSZndDtyeF9vcHQucmN2X3RzZWNyCiAgICAgICAgICAgICAgICAgICAgICAt
PSB0cC0mZ3Q7dHNvZmZzZXQ7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgQEAg
LTQ1NTAsMTEgKzQ1MzcsMTIgQEAgc3RhdGljIHZvaWQKICAgICAgICAgICAgICAgICAgICAgIHRj
cF9kYXRhX3F1ZXVlKHN0cnVjdCBzb2NrICpzaywgc3RydWN0IHNrX2J1ZmYKICAgICAgICAgICAg
ICAgICAgICAgICpza2IpPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
aW50CiAgICAgICAgICAgICAgICAgICAgICBlYXRlbiA9IC0xOzxiciBjbGFzcz0iIj4KICAgICAg
ICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPmJvb2wKICAgICAgICAgICAgICAgICAgICAgIGZyYWdzdG9s
ZW4gPSBmYWxzZTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPi8qCiAg
ICAgICAgICAgICAgICAgICAgICBJZiBubyBkYXRhIGlzIHByZXNlbnQsIGJ1dCBhIGRhdGFfZmlu
IGlzIGluIHRoZQogICAgICAgICAgICAgICAgICAgICAgb3B0aW9ucywgd2Ugc3RpbGw8YnIgY2xh
c3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAg
KiBoYXZlIHRvIGNhbGwgbXB0Y3BfcXVldWVfc2tiIGxhdGVyIG9uLiAqLzxicgogICAgICAgICAg
ICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAg
ICAgICAgICAgICAgICAgICAgIChUQ1BfU0tCX0NCKHNrYiktJmd0O3NlcSA9PQogICAgICAgICAg
ICAgICAgICAgICAgVENQX1NLQl9DQihza2IpLSZndDtlbmRfc2VxICZhbXA7JmFtcDs8YnIgY2xh
c3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAg
oKCgIShtcHRjcCh0cCkgJmFtcDsmYW1wOyBtcHRjcF9pc19kYXRhX2Zpbihza2IpKSk8YnIKICAg
ICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
Pi8qPGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAg
ICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICAgICogc2VuZCBldmVyeSBwYWNrZXQgdG8g
TVBUQ1A8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPgogICAgICAgICAg
ICAgICAgICAgICAgKi88YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlm
CiAgICAgICAgICAgICAgICAgICAgICAoIW1wdGNwKHRwKSAmYW1wOyZhbXA7IChUQ1BfU0tCX0NC
KHNrYiktJmd0O3NlcSA9PQogICAgICAgICAgICAgICAgICAgICAgVENQX1NLQl9DQihza2IpLSZn
dDtlbmRfc2VxKSkgezxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj5nb3RvCiAgICAgICAgICAgICAgICAgICAgICBkcm9wOzxiciBjbGFzcz0iIj4KICAgICAgICAg
ICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+fTxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4K
ICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnNrYl9kc3RfZHJvcChza2IpOzxicgogICAgICAg
ICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPl9f
c2tiX3B1bGwoc2tiLAogICAgICAgICAgICAgICAgICAgICAgdGNwX2hkcihza2IpLSZndDtkb2Zm
ICogNCk7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgQEAgLTUyNDIsMTUgKzUy
MzAsOSBAQCBzeW5fY2hhbGxlbmdlOjxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAg
IKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj5nb3RvCiAgICAgICAgICAgICAgICAgICAgICBkaXNjYXJkOzxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPn08YnIKICAgICAgICAgICAgICAgICAgICAg
ICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPi8qCiAgICAgICAgICAgICAg
ICAgICAgICBJZiB2YWxpZDogcG9zdCBwcm9jZXNzIHRoZSByZWNlaXZlZCBNUFRDUCBvcHRpb25z
LgogICAgICAgICAgICAgICAgICAgICAgKi88YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAg
ICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPmlmCiAgICAgICAgICAgICAgICAgICAgICAobXB0Y3AodHApICZhbXA7JmFtcDsg
bXB0Y3BfaGFuZGxlX29wdGlvbnMoc2ssIHRoLAogICAgICAgICAgICAgICAgICAgICAgc2tiKSk8
YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5nb3RvCiAgICAgICAg
ICAgICAgICAgICAgICBkaXNjYXJkOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAg
IC08YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5yZXR1cm4KICAgICAg
ICAgICAgICAgICAgICAgIHRydWU7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
oKBkaXNjYXJkOjxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAg
ICAgICAgICAgICAgICAgICAgIChtcHRjcCh0cCkpPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAg
ICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+bXB0Y3BfcmVzZXRfbW9wdCh0cCk7PGJyCiAgICAgICAgICAgICAg
ICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+X19rZnJlZV9z
a2Ioc2tiKTs8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAg
ICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj5yZXR1cm4KICAgICAgICAgICAgICAgICAgICAgIGZhbHNlOzxiciBj
bGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgfTxiciBjbGFzcz0iIj4KICAgICAgICAg
ICAgICAgICAgICAgIEBAIC01MzAyLDEwICs1Mjg0LDYgQEAgdm9pZAogICAgICAgICAgICAgICAg
ICAgICAgdGNwX3Jjdl9lc3RhYmxpc2hlZChzdHJ1Y3Qgc29jayAqc2ssIHN0cnVjdAogICAgICAg
ICAgICAgICAgICAgICAgc2tfYnVmZiAqc2tiLDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAg
ICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPnRwLSZndDtyeF9vcHQuc2F3X3RzdGFtcAogICAgICAgICAgICAgICAgICAg
ICAgPSAwOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+LyoKICAgICAg
ICAgICAgICAgICAgICAgIE1QVENQOiBmb3JjZSBzbG93cGF0aC4gKi88YnIgY2xhc3M9IiI+CiAg
ICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmCiAgICAgICAgICAgICAgICAgICAgICAobXB0Y3Ao
dHApKTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmdvdG8KICAg
ICAgICAgICAgICAgICAgICAgIHNsb3dfcGF0aDs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAg
ICAgICAgICAtPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+Lyo8c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
cHJlZF9mbGFncwogICAgICAgICAgICAgICAgICAgICAgaXMgMHhTPzEwICZsdDsmbHQ7IDE2ICsg
c25kX3duZDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPgogICAgICAg
ICAgICAgICAgICAgICAgKjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj5pZgogICAgICAgICAgICAgICAgICAgICAgaGVhZGVyX3ByZWRp
Y3Rpb24gaXMgdG8gYmUgbWFkZTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCg
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPgogICAgICAgICAgICAgICAgICAgICAgKjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4nUycKICAgICAgICAgICAgICAgICAgICAg
IHdpbGwgYWx3YXlzIGJlIHRwLSZndDt0Y3BfaGVhZGVyX2xlbiAmZ3Q7Jmd0OyAyPGJyCiAgICAg
ICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgQEAgLTU1
ODUsOCArNTU2Myw3IEBAIHN0YXRpYyBpbnQKICAgICAgICAgICAgICAgICAgICAgIHRjcF9yY3Zf
c3luc2VudF9zdGF0ZV9wcm9jZXNzKHN0cnVjdCBzb2NrICpzaywKICAgICAgICAgICAgICAgICAg
ICAgIHN0cnVjdCBza19idWZmICpza2IsPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAg
ICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+c3RydWN0CiAgICAgICAgICAgICAgICAgICAgICBtcHRjcF9vcHRpb25zX3JlY2Vp
dmVkIG1vcHQ7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+bXB0Y3Bf
aW5pdF9tcF9vcHQoJmFtcDttb3B0KTs8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9
IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnRjcF9wYXJzZV9vcHRpb25zKHNrYiwKICAg
ICAgICAgICAgICAgICAgICAgICZhbXA7dHAtJmd0O3J4X29wdCw8YnIgY2xhc3M9IiI+CiAgICAg
ICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgICCgbXB0
Y3AodHApID8gJmFtcDt0cC0mZ3Q7bXB0Y3AtJmd0O3J4X29wdCA6CiAgICAgICAgICAgICAgICAg
ICAgICAmYW1wO21vcHQsIDAsICZhbXA7Zm9jLCB0cCk7PGJyIGNsYXNzPSIiPgogICAgICAgICAg
ICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj50Y3BfcGFyc2Vfb3B0aW9ucyhza2IsCiAgICAgICAgICAgICAgICAg
ICAgICAmYW1wO3RwLSZndDtyeF9vcHQsICZhbXA7bW9wdCwgMCwgJmFtcDtmb2MsIHRwKTs8YnIK
ICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCg
oDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj5pZgogICAgICAgICAgICAgICAgICAgICAgKHRwLSZndDtyeF9vcHQuc2F3X3RzdGFtcCAm
YW1wOyZhbXA7CiAgICAgICAgICAgICAgICAgICAgICB0cC0mZ3Q7cnhfb3B0LnJjdl90c2Vjcik8
YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+dHAtJmd0O3J4X29w
dC5yY3ZfdHNlY3IKICAgICAgICAgICAgICAgICAgICAgIC09IHRwLSZndDt0c29mZnNldDs8YnIg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICBkaWZmIC0tZ2l0IGEvbmV0L2lwdjQvdGNw
X2lwdjQuYwogICAgICAgICAgICAgICAgICAgICAgYi9uZXQvaXB2NC90Y3BfaXB2NC5jPGJyIGNs
YXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgaW5kZXggNjk2N2E4Ni4uMzMyOTY3OSAxMDA2
NDQ8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtLS0gYS9uZXQvaXB2NC90Y3Bf
aXB2NC5jPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKysrIGIvbmV0L2lwdjQv
dGNwX2lwdjQuYzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIEBAIC0xNDIwLDYg
KzE0MjAsNzEgQEAgc3RydWN0IHNvY2sKICAgICAgICAgICAgICAgICAgICAgICp0Y3BfdjRfaG5k
X3JlcShzdHJ1Y3Qgc29jayAqc2ssIHN0cnVjdCBza19idWZmCiAgICAgICAgICAgICAgICAgICAg
ICAqc2tiKTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnJldHVybgog
ICAgICAgICAgICAgICAgICAgICAgc2s7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAg
ICAgoKB9PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgK2ludCBtcHRjcF92NF9k
b19yY3Yoc3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3QKICAgICAgICAgICAgICAgICAgICAgIHNrX2J1
ZmYgKnNrYik8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArezxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c3RydWN0CiAgICAgICAgICAgICAgICAgICAg
ICBuZXQgKm5ldCA9IGRldl9uZXQoc2tiLSZndDtkZXYpOzxiciBjbGFzcz0iIj4KICAgICAgICAg
ICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+Y29uc3QKICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB0Y3Bo
ZHIgKnRoID0gdGNwX2hkcihza2IpOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAg
ICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+aW50CiAgICAgICAgICAgICAgICAgICAgICByZXQ7PGJyIGNsYXNzPSIiPgogICAgICAg
ICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj5zdHJ1Y3QKICAgICAgICAgICAgICAgICAgICAgIHNvY2sgKm1l
dGFfc2s7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxiciBjbGFzcz0iIj4K
ICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAgICAgICAgIChzayA9
PSBOVUxMKSB7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYK
ICAgICAgICAgICAgICAgICAgICAgICh0aC0mZ3Q7c3luICZhbXA7JmFtcDsgIXRoLSZndDthY2sp
IHs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aW50CiAg
ICAgICAgICAgICAgICAgICAgICByZXQgPSBtcHRjcF9sb29rdXBfam9pbihza2IsIE5VTEwpOzxi
ciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8YnIgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAgICAgICAgIChyZXQg
Jmx0OyAwKSB7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj50Y3BfdjRfc2VuZF9yZXNldChOVUxMLAogICAgICAgICAgICAgICAgICAgICAgc2tiKTs8
YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmtmcmVl
X3NrYihza2IpOzxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAg
ICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cmV0dXJuCiAgICAgICAgICAgICAgICAgICAg
ICAoMSk7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPn0K
ICAgICAgICAgICAgICAgICAgICAgIGVsc2UgaWYgKHJldCAmZ3Q7IDApIHs8YnIgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnJldHVybgogICAgICAgICAg
ICAgICAgICAgICAgKDEpOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj59PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAg
ICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+fTxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPi8qCiAgICAgICAgICAgICAgICAgICAg
ICBJcyB0aGVyZSBhIHBlbmRpbmcgcmVxdWVzdCBzb2NrIGZvciB0aGlzIHNlZ21lbnQgPwogICAg
ICAgICAgICAgICAgICAgICAgKi88YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAr
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj5pZgogICAgICAgICAgICAgICAgICAgICAgKG1wdGNwX2NoZWNrX3JlcShza2IsIG5l
dCkpIHs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cmV0
dXJuKDEpOzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj48YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj59PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNz
PSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cmV0dXJuCiAgICAgICAgICAgICAg
ICAgICAgICAoMCk7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj59PGJy
CiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
KzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+LyoKICAgICAgICAgICAg
ICAgICAgICAgIFRoZSBzb2NrZXQgcGFzc2VkIGluIHNob3VsZCBuZXZlciBiZSB0aGUgbWV0YQog
ICAgICAgICAgICAgICAgICAgICAgc29ja2V0ICovPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAg
ICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj48YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAg
ICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPkJVR19PTihpc19tZXRhX3NrKHNrKSk7PGJyCiAgICAgICAg
ICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxiciBjbGFz
cz0iIj4KICAgICAgICAgICAgICAgICAgICAgICsgoKCgoKCgoC8qIElzIHRoZXJlIGEgcGVuZGlu
ZyByZXF1ZXN0IHNvY2sgZm9yCiAgICAgICAgICAgICAgICAgICAgICB0aGlzIHNlZ21lbnQgPyAq
LzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAg
ICAgICAgICAgIChzay0mZ3Q7c2tfc3RhdGUgPT0gVENQX0xJU1RFTiAmYW1wOyZhbXA7CiAgICAg
ICAgICAgICAgICAgICAgICBtcHRjcF9jaGVja19yZXEoc2tiLCBuZXQpKSB7PGJyIGNsYXNzPSIi
PgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cmV0dXJuCiAgICAgICAgICAgICAgICAg
ICAgICAwOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+fTxicgogICAg
ICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8YnIg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnNrYi0mZ3Q7ZGV2CiAgICAgICAg
ICAgICAgICAgICAgICA9IE5VTEw7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj5tZXRhX3NrCiAgICAgICAgICAgICAgICAgICAgICA9IG1wdGNwX21ldGFfc2soc2spOzxi
ciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8YnIgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPnJldAogICAgICAgICAgICAgICAgICAgICAgPSAwOzxiciBjbGFz
cz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c2tiLSZndDtzawogICAgICAgICAgICAg
ICAgICAgICAgPSBzazs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmJo
X2xvY2tfc29ja19uZXN0ZWQobWV0YV9zayk7PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNs
YXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pZgogICAgICAgICAgICAgICAgICAg
ICAgKHNvY2tfb3duZWRfYnlfdXNlcihtZXRhX3NrKSkgezxiciBjbGFzcz0iIj4KICAgICAgICAg
ICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmCiAgICAgICAgICAgICAgICAgICAgICAodW5saWtlbHko
c2tfYWRkX2JhY2tsb2cobWV0YV9zaywgc2tiLDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAg
ICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAgoKCgbWV0YV9zay0mZ3Q7c2tf
cmN2YnVmICsKICAgICAgICAgICAgICAgICAgICAgIG1ldGFfc2stJmd0O3NrX3NuZGJ1ZikpKSB7
PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxiciBjbGFzcz0iIj4KICAgICAg
ICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5ORVRfSU5DX1NUQVRTX0JIKG5ldCwKICAgICAg
ICAgICAgICAgICAgICAgIExJTlVYX01JQl9UQ1BCQUNLTE9HRFJPUCk7PGJyIGNsYXNzPSIiPgog
ICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmtmcmVlX3NrYihza2IpOzxicgogICAg
ICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPn08YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAg
ICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPn0KICAgICAgICAgICAgICAgICAgICAgIGVsc2UgezxiciBjbGFzcz0iIj4K
ICAgICAgICAgICAgICAgICAgICAgICs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAg
ICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj5pZgogICAgICAgICAgICAgICAgICAgICAgKGlzX21ldGFfc2soc2spKSB7PGJy
IGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnJldAogICAgICAg
ICAgICAgICAgICAgICAgPSBtcHRjcF92NF9wcm9jZXNzX2pvaW5fcmVxKHNrLCBza2IpOzxiciBj
bGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5nb3RvCiAgICAgICAg
ICAgICAgICAgICAgICBkb25lOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPn08YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAg
ICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj5pZgogICAgICAgICAgICAgICAgICAgICAgKCFtZXRhX3NrLSZn
dDtza19wcmVxdWV1ZShtZXRhX3NrLCBza2IpKSB7PGJyCiAgICAgICAgICAgICAgICAgICAgICAg
IGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnNrYi0mZ3Q7c2sK
ICAgICAgICAgICAgICAgICAgICAgID0gTlVMTDs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAg
ICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cmV0CiAgICAgICAgICAgICAgICAgICAgICA9IHRjcF92NF9k
b19yY3Yoc2ssIHNrYik7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+fTxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAg
ICAgICAgICs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPn08YnIKICAg
ICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArZG9u
ZTo8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmJoX3VubG9ja19zb2Nr
KG1ldGFfc2spOzxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAg
ICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+cmV0dXJuCiAgICAgICAgICAgICAgICAgICAgICAocmV0KTs8YnIg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArfTxiciBjbGFzcz0iIj4KICAgICAgICAg
ICAgICAgICAgICAgICs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoC8qIFRo
ZSBzb2NrZXQgbXVzdCBoYXZlIGl0J3Mgc3BpbmxvY2sgaGVsZCB3aGVuCiAgICAgICAgICAgICAg
ICAgICAgICB3ZSBnZXQ8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoKAqIGhl
cmUuPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKCgKjxiciBjbGFzcz0iIj4K
ICAgICAgICAgICAgICAgICAgICAgIEBAIC0xNDMyLDggKzE0OTcsNyBAQCBpbnQgdGNwX3Y0X2Rv
X3JjdihzdHJ1Y3QKICAgICAgICAgICAgICAgICAgICAgIHNvY2sgKnNrLCBzdHJ1Y3Qgc2tfYnVm
ZiAqc2tiKTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgezxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnN0cnVjdAogICAgICAgICAgICAgICAgICAg
ICAgc29jayAqcnNrOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYK
ICAgICAgICAgICAgICAgICAgICAgIChpc19tZXRhX3NrKHNrKSk8YnIgY2xhc3M9IiI+CiAgICAg
ICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5yZXR1cm4KICAgICAgICAgICAgICAgICAgICAgIG1w
dGNwX3Y0X2RvX3Jjdihzaywgc2tiKTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAg
ICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPkJVR19PTihpc19tZXRhX3NrKHNrKSk7PGJyCiAgICAgICAgICAgICAgICAgICAgICAg
IGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAg
ICAgICAgIChzay0mZ3Q7c2tfc3RhdGUgPT0gVENQX0VTVEFCTElTSEVEKSB7IC8qIEZhc3QKICAg
ICAgICAgICAgICAgICAgICAgIHBhdGggKi88YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAg
ICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+c3RydWN0CiAgICAgICAgICAgICAgICAgICAgICBkc3RfZW50cnkgKmRz
dCA9IHNrLSZndDtza19yeF9kc3Q7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
QEAgLTE1ODcsNiArMTY1MSw4IEBAIGJvb2wgdGNwX3ByZXF1ZXVlKHN0cnVjdAogICAgICAgICAg
ICAgICAgICAgICAgc29jayAqc2ssIHN0cnVjdCBza19idWZmICpza2IpPGJyIGNsYXNzPSIiPgog
ICAgICAgICAgICAgICAgICAgICAgoKB9PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAg
ICAgoKBFWFBPUlRfU1lNQk9MKHRjcF9wcmVxdWV1ZSk7PGJyIGNsYXNzPSIiPgogICAgICAgICAg
ICAgICAgICAgICAgK3Byb2Nlc3NfdW5jbGFpbWVkIHRjcF9wcm9jZXNzX3VuY2xhaW1lZCA9IE5V
TEw7PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAg
ICAgICAgKzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgLyo8YnIgY2xhc3M9
IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoKAqPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPkZyb20KICAgICAgICAgICAgICAgICAg
ICAgIHRjcF9pbnB1dC5jPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKCgKi88
YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICBAQCAtMTU5NSw3ICsxNjYxLDcgQEAg
aW50IHRjcF92NF9yY3Yoc3RydWN0CiAgICAgICAgICAgICAgICAgICAgICBza19idWZmICpza2Ip
PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKB7PGJyIGNsYXNzPSIiPgogICAg
ICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+Y29uc3QKICAgICAgICAgICAgICAgICAgICAgIHN0cnVj
dCBpcGhkciAqaXBoOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmNv
bnN0CiAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdGNwaGRyICp0aDs8YnIgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnN0cnVjdAogICAgICAgICAgICAgICAgICAgICAg
c29jayAqc2ssICptZXRhX3NrID0gTlVMTDs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAg
ICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPnN0cnVjdAogICAgICAgICAgICAgICAgICAgICAgc29jayAqc2sgPSBOVUxMOzxi
ciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmludAogICAgICAgICAgICAg
ICAgICAgICAgcmV0OzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnN0
cnVjdAogICAgICAgICAgICAgICAgICAgICAgbmV0ICpuZXQgPSBkZXZfbmV0KHNrYi0mZ3Q7ZGV2
KTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICBAQCAtMTYzNiwxMCArMTcwMiw3
IEBAIGludCB0Y3BfdjRfcmN2KHN0cnVjdAogICAgICAgICAgICAgICAgICAgICAgc2tfYnVmZiAq
c2tiKTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPlRDUF9TS0JfQ0Io
c2tiKS0mZ3Q7ZW5kX3NlcQogICAgICAgICAgICAgICAgICAgICAgPSAoVENQX1NLQl9DQihza2Ip
LSZndDtzZXEgKyB0aC0mZ3Q7c3luICsKICAgICAgICAgICAgICAgICAgICAgIHRoLSZndDtmaW4g
KzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPgog
ICAgICAgICAgICAgICAgICAgICAgoKCgc2tiLSZndDtsZW4gLSB0aC0mZ3Q7ZG9mZiAqIDQpOzxi
ciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPlRDUF9TS0JfQ0Ioc2tiKS0m
Z3Q7YWNrX3NlcQogICAgICAgICAgICAgICAgICAgICAgPSBudG9obCh0aC0mZ3Q7YWNrX3NlcSk7
PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLSNpZmRlZiBDT05GSUdfTVBUQ1A8
YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPlRDUF9TS0JfQ0Ioc2tiKS0m
Z3Q7bXB0Y3BfZmxhZ3MKICAgICAgICAgICAgICAgICAgICAgID0gMDs8YnIgY2xhc3M9IiI+CiAg
ICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPlRDUF9TS0JfQ0Ioc2tiKS0mZ3Q7ZHNzX29mZgogICAg
ICAgICAgICAgICAgICAgICAgPSAwOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAg
IC0jZW5kaWY8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPGJyIGNsYXNzPSIi
PgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+VENQX1NLQl9DQihza2IpLSZndDt0Y3BfZmxh
Z3MKICAgICAgICAgICAgICAgICAgICAgID0gdGNwX2ZsYWdfYnl0ZSh0aCk7PGJyIGNsYXNzPSIi
PgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+VENQX1NLQl9DQihza2IpLSZndDt0Y3BfdHdf
aXNuCiAgICAgICAgICAgICAgICAgICAgICA9IDA7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAg
ICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+VENQX1NLQl9DQihza2IpLSZndDtpcF9kc2ZpZWxkCiAgICAgICAgICAg
ICAgICAgICAgICA9IGlwdjRfZ2V0X2RzZmllbGQoaXBoKTs8YnIgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICBAQCAtMTY2MiwxNSArMTcyNSw2IEBAIHByb2Nlc3M6PGJyIGNsYXNzPSIi
PgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAgICAgICAgICgh
eGZybTRfcG9saWN5X2NoZWNrKHNrLCBYRlJNX1BPTElDWV9JTiwgc2tiKSk8YnIKICAgICAgICAg
ICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
Z290bwogICAgICAgICAgICAgICAgICAgICAgZGlzY2FyZF9hbmRfcmVsc2U7PGJyIGNsYXNzPSIi
PgogICAgICAgICAgICAgICAgICAgICAgLSNpZmRlZiBDT05GSUdfTVBUQ1A8YnIgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPi8qCiAgICAgICAgICAgICAgICAgICAgICBJcyB0
aGVyZSBhIHBlbmRpbmcgcmVxdWVzdCBzb2NrIGZvciB0aGlzIHNlZ21lbnQgPwogICAgICAgICAg
ICAgICAgICAgICAgKi88YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlm
CiAgICAgICAgICAgICAgICAgICAgICAoc2stJmd0O3NrX3N0YXRlID09IFRDUF9MSVNURU4gJmFt
cDsmYW1wOwogICAgICAgICAgICAgICAgICAgICAgbXB0Y3BfY2hlY2tfcmVxKHNrYiwgbmV0KSkg
ezxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmCiAgICAgICAg
ICAgICAgICAgICAgICAoc2spPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPnNvY2tfcHV0KHNrKTs8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9
IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5yZXR1cm4KICAgICAgICAgICAgICAg
ICAgICAgIDA7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj59PGJyCiAg
ICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLSNl
bmRpZjxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08YnIgY2xhc3M9IiI+CiAg
ICAgICAgICAgICAgICAgICAgICCgoCNpZmRlZiBDT05GSUdfVENQX01ENVNJRzxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPi8qPGJyCiAgICAgICAgICAgICAgICAgICAg
ICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+CiAgICAgICAgICAgICAg
ICAgICAgICAqIFdlIHJlYWxseSB3YW50IHRvIHJlamVjdCB0aGUgcGFja2V0IGFzIGVhcmx5IGFz
CiAgICAgICAgICAgICAgICAgICAgICBwb3NzaWJsZTxiciBjbGFzcz0iIj4KICAgICAgICAgICAg
ICAgICAgICAgIEBAIC0xNjg4LDMwICsxNzQyLDIxIEBAIHByb2Nlc3M6PGJyIGNsYXNzPSIiPgog
ICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmdvdG8KICAgICAgICAgICAgICAgICAgICAg
IGRpc2NhcmRfYW5kX3JlbHNlOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCg
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPnNrX2luY29taW5nX2NwdV91cGRhdGUoc2spOzxicgogICAgICAgICAgICAgICAgICAgICAg
ICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c2tiLSZndDtkZXYKICAgICAg
ICAgICAgICAgICAgICAgID0gTlVMTDs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAg
ICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPmlmCiAgICAgICAgICAgICAgICAgICAgICAobXB0Y3AodGNwX3NrKHNrKSkpIHs8YnIg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5tZXRhX3NrCiAgICAgICAg
ICAgICAgICAgICAgICA9IG1wdGNwX21ldGFfc2soc2spOzxiciBjbGFzcz0iIj4KICAgICAgICAg
ICAgICAgICAgICAgIC08YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj5iaF9sb2NrX3NvY2tfbmVzdGVkKG1ldGFfc2spOzxicgogICAgICAgICAgICAgICAgICAgICAg
ICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmCiAgICAgICAgICAg
ICAgICAgICAgICAoc29ja19vd25lZF9ieV91c2VyKG1ldGFfc2spKTxiciBjbGFzcz0iIj4KICAg
ICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5za2ItJmd0O3NrCiAgICAgICAgICAgICAg
ICAgICAgICA9IHNrOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+fQog
ICAgICAgICAgICAgICAgICAgICAgZWxzZSB7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAg
ICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+bWV0YV9zawogICAgICAgICAgICAgICAgICAgICAgPSBzazs8YnIgY2xh
c3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5iaF9sb2NrX3NvY2tfbmVzdGVk
KHNrKTs8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAg
ICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPn08YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAg
ICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPi8qCiAgICAgICAgICAgICAgICAgICAgICBEbyBJIGhhdmUg
dG8gc2V0IHNrYi0mZ3Q7ZGV2IHRvIG51bGwgPyAqLzxicgogICAgICAgICAgICAgICAgICAgICAg
ICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+YmhfbG9ja19zb2NrX25lc3Rl
ZChzayk7PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAg
ICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+cmV0CiAgICAgICAgICAgICAgICAgICAgICA9IDA7PGJyIGNsYXNzPSIi
PgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pZgogICAgICAgICAgICAgICAgICAgICAgKCFz
b2NrX293bmVkX2J5X3VzZXIobWV0YV9zaykpIHs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAg
ICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj5pZgogICAgICAgICAgICAgICAgICAgICAgKCF0Y3BfcHJlcXVldWUo
bWV0YV9zaywgc2tiKSk8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+cmV0CiAgICAgICAgICAgICAgICAgICAgICA9IHRjcF92NF9kb19yY3Yoc2ssIHNrYik7
PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj59CiAgICAgICAgICAgICAg
ICAgICAgICBlbHNlIGlmICh1bmxpa2VseShza19hZGRfYmFja2xvZyhtZXRhX3NrLCBza2IsPGJy
CiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgICCgoG1ldGFfc2stJmd0
O3NrX3JjdmJ1ZiArIG1ldGFfc2stJmd0O3NrX3NuZGJ1ZikpKQogICAgICAgICAgICAgICAgICAg
ICAgezxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmJoX3VubG9j
a19zb2NrKG1ldGFfc2spOzxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAg
ICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAgICAgICAgICghc29ja19v
d25lZF9ieV91c2VyKHNrKSkgezxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPmlmCiAgICAgICAgICAgICAgICAgICAgICAoIXNrLSZndDtza19wcmVxdWV1ZShzaywg
c2tiKSk8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cmV0
CiAgICAgICAgICAgICAgICAgICAgICA9IHNrLSZndDtza19iYWNrbG9nX3Jjdihzaywgc2tiKTs8
YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPn0KICAgICAgICAgICAgICAg
ICAgICAgIGVsc2UgaWYgKHVubGlrZWx5KHNrX2FkZF9iYWNrbG9nKHNrLCBza2IsPGJyCiAgICAg
ICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+CiAgICAgICAgICAgICAgICAgICAgICCgoKBzay0mZ3Q7c2tfcmN2YnVmICsgc2stJmd0O3Nr
X3NuZGJ1ZikpKSB7PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAg
ICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+YmhfdW5sb2NrX3NvY2soc2spOzxicgogICAgICAgICAg
ICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5O
RVRfSU5DX1NUQVRTX0JIKG5ldCwKICAgICAgICAgICAgICAgICAgICAgIExJTlVYX01JQl9UQ1BC
QUNLTE9HRFJPUCk7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PmdvdG8KICAgICAgICAgICAgICAgICAgICAgIGRpc2NhcmRfYW5kX3JlbHNlOzxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPn08YnIKICAgICAgICAgICAgICAgICAgICAg
ICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmJoX3VubG9ja19zb2NrKG1l
dGFfc2spOzxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAg
ICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+YmhfdW5sb2NrX3NvY2soc2spOzxicgogICAgICAgICAgICAgICAgICAg
ICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnNvY2tfcHV0KHNrKTs8
YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAg
ICBAQCAtMTcyMSwyNiArMTc2NiwxMSBAQCBub190Y3Bfc29ja2V0OjxiciBjbGFzcz0iIj4KICAg
ICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmCiAgICAgICAgICAgICAgICAgICAgICAoIXhmcm00
X3BvbGljeV9jaGVjayhOVUxMLCBYRlJNX1BPTElDWV9JTiwgc2tiKSk8YnIKICAgICAgICAgICAg
ICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+Z290
bwogICAgICAgICAgICAgICAgICAgICAgZGlzY2FyZF9pdDs8YnIgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICAtI2lmZGVmIENPTkZJR19NUFRDUDxiciBjbGFzcz0iIj4KICAgICAgICAg
ICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAgICAgICAgICghc2sgJmFtcDsmYW1w
OyB0aC0mZ3Q7c3luICZhbXA7JmFtcDsgIXRoLSZndDthY2spCiAgICAgICAgICAgICAgICAgICAg
ICB7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aW50CiAgICAg
ICAgICAgICAgICAgICAgICByZXQgPSBtcHRjcF9sb29rdXBfam9pbihza2IsIE5VTEwpOzxiciBj
bGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08YnIgY2xhc3M9IiI+CiAgICAgICAgICAg
ICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj5pZgogICAgICAgICAgICAgICAgICAgICAgKHJldCAmbHQ7IDAp
IHs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+dGNwX3Y0
X3NlbmRfcmVzZXQoTlVMTCwKICAgICAgICAgICAgICAgICAgICAgIHNrYik7PGJyIGNsYXNzPSIi
PgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmdvdG8KICAgICAgICAgICAgICAg
ICAgICAgIGRpc2NhcmRfaXQ7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+fQogICAgICAgICAgICAgICAgICAgICAgZWxzZSBpZiAocmV0ICZndDsgMCkgezxiciBj
bGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5yZXR1cm4KICAgICAg
ICAgICAgICAgICAgICAgIDA7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+fTxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAg
ICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAgICAgICAgICh1bmxpa2VseSAodGNwX3By
b2Nlc3NfdW5jbGFpbWVkICE9IE5VTEwpKSB7PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNs
YXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAg
ICAgICAgICgodGNwX3Byb2Nlc3NfdW5jbGFpbWVkKShOVUxMLCBza2IpKTxiciBjbGFzcz0iIj4K
ICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5yZXR1cm4KICAgICAgICAgICAgICAg
ICAgICAgICgwKTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj59PGJy
CiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj4vKgogICAgICAgICAgICAgICAgICAgICAgSXMgdGhlcmUgYSBwZW5kaW5nIHJlcXVlc3Qg
c29jayBmb3IgdGhpcyBzZWdtZW50ID8KICAgICAgICAgICAgICAgICAgICAgICovPGJyIGNsYXNz
PSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pZgogICAgICAgICAgICAgICAgICAgICAg
KCFzayAmYW1wOyZhbXA7IG1wdGNwX2NoZWNrX3JlcShza2IsIG5ldCkpIHs8YnIKICAgICAgICAg
ICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5p
ZgogICAgICAgICAgICAgICAgICAgICAgKHNrKTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAg
ICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj5zb2NrX3B1dChzayk7PGJyCiAgICAgICAgICAgICAgICAgICAg
ICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cmV0dXJuCiAgICAg
ICAgICAgICAgICAgICAgICAwOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+fTxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAg
ICAgICAgIC0jZW5kaWY8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPGJyIGNs
YXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAgICAg
ICAgIChza2ItJmd0O2xlbiAmbHQ7ICh0aC0mZ3Q7ZG9mZiAmbHQ7Jmx0OyAyKSB8fAogICAgICAg
ICAgICAgICAgICAgICAgdGNwX2NoZWNrc3VtX2NvbXBsZXRlKHNrYikpIHs8YnIgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICCgoGNzdW1fZXJyb3I6PGJyIGNsYXNzPSIiPgogICAgICAg
ICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPlRDUF9JTkNfU1RBVFNfQkgobmV0LAogICAgICAgICAg
ICAgICAgICAgICAgVENQX01JQl9DU1VNRVJST1JTKTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAg
ICAgICAgICAgICBAQCAtMjUwNiw2ICsyNTM2LDcgQEAgc3RydWN0IHByb3RvIHRjcF9wcm90ID0g
ezxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAg
ICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPi5zZW5kbXNnPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj49CiAgICAgICAgICAgICAgICAgICAgICB0Y3Bfc2Vu
ZG1zZyw8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4uc2VuZHBhZ2U8
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPj0KICAgICAgICAgICAgICAgICAgICAgIHRjcF9zZW5kcGFnZSw8YnIgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4uYmFja2xvZ19yY3Y8c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPj0KICAgICAg
ICAgICAgICAgICAgICAgIHRjcF92NF9kb19yY3YsPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAg
ICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj4ucHJlcXVldWU8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPj0KICAgICAgICAgICAgICAgICAgICAgIHRj
cF9wcmVxdWV1ZSw8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4ucmVs
ZWFzZV9jYjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+PQogICAgICAgICAgICAgICAgICAgICAgdGNwX3JlbGVhc2VfY2IsPGJy
IGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+Lmhhc2g8c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj49
CiAgICAgICAgICAgICAgICAgICAgICBpbmV0X2hhc2gsPGJyIGNsYXNzPSIiPgogICAgICAgICAg
ICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+LnVuaGFzaDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPj0KICAgICAgICAgICAgICAgICAg
ICAgIGluZXRfdW5oYXNoLDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIGRpZmYg
LS1naXQgYS9uZXQvaXB2NC90Y3Bfb3V0cHV0LmMKICAgICAgICAgICAgICAgICAgICAgIGIvbmV0
L2lwdjQvdGNwX291dHB1dC5jPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgaW5k
ZXggYTYzNTQ4My4uNDFiOGJlOCAxMDA2NDQ8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAg
ICAgICAtLS0gYS9uZXQvaXB2NC90Y3Bfb3V0cHV0LmM8YnIgY2xhc3M9IiI+CiAgICAgICAgICAg
ICAgICAgICAgICArKysgYi9uZXQvaXB2NC90Y3Bfb3V0cHV0LmM8YnIgY2xhc3M9IiI+CiAgICAg
ICAgICAgICAgICAgICAgICBAQCAtMzQxMyw2ICszNDEzLDcgQEAgdm9pZAogICAgICAgICAgICAg
ICAgICAgICAgdGNwX3NlbmRfZGVsYXllZF9hY2soc3RydWN0IHNvY2sgKnNrKTxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgIKCgdm9pZCB0Y3Bfc2VuZF9hY2soc3RydWN0IHNvY2sg
KnNrKTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgezxiciBjbGFzcz0iIj4K
ICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnN0cnVjdAogICAgICAgICAgICAgICAgICAgICAg
c2tfYnVmZiAqYnVmZjs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnN0
cnVjdAogICAgICAgICAgICAgICAgICAgICAgdGNwX3NvY2sgKnRwID0gdGNwX3NrKHNrKTs8YnIg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4vKgogICAgICAgICAgICAgICAg
ICAgICAgSWYgd2UgaGF2ZSBiZWVuIHJlc2V0LCB3ZSBtYXkgbm90IHNlbmQgYWdhaW4uICovPGJy
CiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
oKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+aWYKICAgICAgICAgICAgICAgICAgICAgIChzay0mZ3Q7c2tfc3RhdGUgPT0gVENQX0NM
T1NFKTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIGRpZmYgLS1naXQgYS9uZXQv
aXB2Ni9hZl9pbmV0Ni5jCiAgICAgICAgICAgICAgICAgICAgICBiL25ldC9pcHY2L2FmX2luZXQ2
LmM8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICBpbmRleCA4YzRkZDRhLi4xNTU0
MjE3IDEwMDY0NDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC0tLSBhL25ldC9p
cHY2L2FmX2luZXQ2LmM8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArKysgYi9u
ZXQvaXB2Ni9hZl9pbmV0Ni5jPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgQEAg
LTE5Myw2ICsxOTMsMTAgQEAgbG9va3VwX3Byb3RvY29sOjxiciBjbGFzcz0iIj4KICAgICAgICAg
ICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPnNrLSZndDtza19wcm90b2NvbDxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PQogICAgICAgICAg
ICAgICAgICAgICAgcHJvdG9jb2w7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
oKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+c2stJmd0O3NrX2JhY2tsb2dfcmN2PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPj0KICAgICAgICAgICAgICAgICAgICAgIGFu
c3dlci0mZ3Q7cHJvdC0mZ3Q7YmFja2xvZ19yY3Y7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAg
ICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj5zay0mZ3Q7c2tfcHJlcXVldWU8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPj0KICAgICAgICAgICAgICAg
ICAgICAgIGFuc3dlci0mZ3Q7cHJvdC0mZ3Q7cHJlcXVldWU7PGJyIGNsYXNzPSIiPgogICAgICAg
ICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj5pZgogICAgICAgICAgICAgICAgICAgICAgKHNrLSZndDtza19w
cmVxdWV1ZSA9PSBOVUxMKSB7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+c2stJmd0O3NrX3ByZXF1ZXVlCiAgICAgICAgICAgICAgICAgICAgICA9IHNrX3ByZXF1
ZXVlOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+fTxicgogICAgICAg
ICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlu
ZXRfc2soc2spLSZndDtwaW5ldDYKICAgICAgICAgICAgICAgICAgICAgID0gbnAgPSBpbmV0Nl9z
a19nZW5lcmljKHNrKTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5u
cC0mZ3Q7aG9wX2xpbWl0PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPj0KICAgICAgICAgICAgICAgICAgICAgIC0xOzxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgIGRpZmYgLS1naXQgYS9uZXQvaXB2Ni90Y3BfaXB2Ni5j
CiAgICAgICAgICAgICAgICAgICAgICBiL25ldC9pcHY2L3RjcF9pcHY2LmM8YnIgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICBpbmRleCBlYmEyNDM2Li5kMzYwMTI4IDEwMDY0NDxiciBj
bGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC0tLSBhL25ldC9pcHY2L3RjcF9pcHY2LmM8
YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArKysgYi9uZXQvaXB2Ni90Y3BfaXB2
Ni5jPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgQEAgLTE0MTIsMTAgKzE0MTIs
NiBAQCBzdGF0aWMgdm9pZAogICAgICAgICAgICAgICAgICAgICAgdGNwX3Y2X2ZpbGxfY2Ioc3Ry
dWN0IHNrX2J1ZmYgKnNrYiwgY29uc3Qgc3RydWN0CiAgICAgICAgICAgICAgICAgICAgICBpcHY2
aGRyICpoZHIsPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+VENQX1NL
Ql9DQihza2IpLSZndDtlbmRfc2VxCiAgICAgICAgICAgICAgICAgICAgICA9IChUQ1BfU0tCX0NC
KHNrYiktJmd0O3NlcSArIHRoLSZndDtzeW4gKwogICAgICAgICAgICAgICAgICAgICAgdGgtJmd0
O2ZpbiArPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+CiAgICAgICAgICAgICAgICAgICAgICCgoKBza2ItJmd0O2xlbiAtIHRoLSZndDtkb2ZmKjQp
OzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPlRDUF9TS0JfQ0Ioc2ti
KS0mZ3Q7YWNrX3NlcQogICAgICAgICAgICAgICAgICAgICAgPSBudG9obCh0aC0mZ3Q7YWNrX3Nl
cSk7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLSNpZmRlZiBDT05GSUdfTVBU
Q1A8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPlRDUF9TS0JfQ0Ioc2ti
KS0mZ3Q7bXB0Y3BfZmxhZ3MKICAgICAgICAgICAgICAgICAgICAgID0gMDs8YnIgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPlRDUF9TS0JfQ0Ioc2tiKS0mZ3Q7ZHNzX29mZgog
ICAgICAgICAgICAgICAgICAgICAgPSAwOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAg
ICAgIC0jZW5kaWY8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5UQ1Bf
U0tCX0NCKHNrYiktJmd0O3RjcF9mbGFncwogICAgICAgICAgICAgICAgICAgICAgPSB0Y3BfZmxh
Z19ieXRlKHRoKTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5UQ1Bf
U0tCX0NCKHNrYiktJmd0O3RjcF90d19pc24KICAgICAgICAgICAgICAgICAgICAgID0gMDs8YnIg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5UQ1BfU0tCX0NCKHNrYiktJmd0
O2lwX2RzZmllbGQKICAgICAgICAgICAgICAgICAgICAgID0gaXB2Nl9nZXRfZHNmaWVsZChoZHIp
OzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIGRpZmYgLS1naXQgYS9uZXQvbXB0
Y3AvbXB0Y3BfY3RybC5jCiAgICAgICAgICAgICAgICAgICAgICBiL25ldC9tcHRjcC9tcHRjcF9j
dHJsLmM8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICBpbmRleCAyOGYzNDhmLi5i
MWU3ODBhIDEwMDY0NDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC0tLSBhL25l
dC9tcHRjcC9tcHRjcF9jdHJsLmM8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAr
KysgYi9uZXQvbXB0Y3AvbXB0Y3BfY3RybC5jPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAg
ICAgICAgQEAgLTk3Niw2ICs5NzYsMjAgQEAgaW50IG1wdGNwX2JhY2tsb2dfcmN2KHN0cnVjdAog
ICAgICAgICAgICAgICAgICAgICAgc29jayAqbWV0YV9zaywgc3RydWN0IHNrX2J1ZmYgKnNrYik8
YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5zdHJ1Y3QKICAgICAgICAg
ICAgICAgICAgICAgIHNvY2sgKnNrID0gc2tiLSZndDtzayA/IHNrYi0mZ3Q7c2sgOiBtZXRhX3Nr
OzxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAg
ICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPmludAogICAgICAgICAgICAgICAgICAgICAgcmV0ID0gMDs8YnIgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAgLyogc29j
a2V0IHdhcyBvd25lZCBieSB0aGUgdXNlciBpbgogICAgICAgICAgICAgICAgICAgICAgbXB0Y3Bf
Y2hlY2tfcmVxKCk8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPgogICAg
ICAgICAgICAgICAgICAgICAgoCovPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj5pZgogICAgICAgICAgICAgICAgICAgICAgKHNrID09IChzdHJ1Y3Qgc29jayAqKTB4RkVF
MURFQUQpIHs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5iaF9s
b2NrX3NvY2tfbmVzdGVkKG1ldGFfc2spOzxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFz
cz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmCiAgICAgICAgICAgICAgICAg
ICAgICAoc2tiLSZndDtwcm90b2NvbCA9PSBodG9ucyhFVEhfUF9JUCkpPGJyIGNsYXNzPSIiPgog
ICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPm1wdGNwX3Y0X3Byb2Nlc3Nfam9pbl9y
ZXEobWV0YV9zaywKICAgICAgICAgICAgICAgICAgICAgIHNrYik7PGJyIGNsYXNzPSIiPgogICAg
ICAgICAgICAgICAgICAgICAgKyNpZiBJU19FTkFCTEVEKENPTkZJR19JUFY2KTxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmVsc2U8YnIKICAgICAgICAgICAgICAg
ICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+Ly9t
cHRjcF92Nl9wcm9jZXNzX2pvaW5fcmVxKG1ldGFfc2ssCiAgICAgICAgICAgICAgICAgICAgICBz
a2IpOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICsjZW5kaWYgLyogQ09ORklH
X0lQVjYgKi88YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5iaF91
bmxvY2tfc29jayhtZXRhX3NrKTs8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5yZXR1cm4oMCk7PGJyCiAgICAgICAgICAg
ICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj59PGJyCiAg
ICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxi
ciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnNrYi0mZ3Q7c2sKICAgICAg
ICAgICAgICAgICAgICAgID0gTlVMTDs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAg
ICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj5pZgoodW5saWtlbHkoIWF0b21pY19pbmNfbm90X3plcm8oJmFtcDtzay0mZ3Q7c2tf
cmVmY250KSkpIHs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICBAQCAtMTI5Nyw2
ICsxMzExLDEwIEBAIGludCBtcHRjcF9hZGRfc29jayhzdHJ1Y3QKICAgICAgICAgICAgICAgICAg
ICAgIHNvY2sgKm1ldGFfc2ssIHN0cnVjdCBzb2NrICpzaywgdTggbG9jX2lkLCB1OAogICAgICAg
ICAgICAgICAgICAgICAgcmVtX2lkLDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAg
IKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPnNrLSZndDtza193cml0ZV9zcGFjZQogICAgICAgICAgICAgICAgICAgICAgPSBtcHRj
cF93cml0ZV9zcGFjZTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5z
ay0mZ3Q7c2tfc3RhdGVfY2hhbmdlCiAgICAgICAgICAgICAgICAgICAgICA9IG1wdGNwX3NldF9z
dGF0ZTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5zay0mZ3Q7c2tf
ZGVzdHJ1Y3QKICAgICAgICAgICAgICAgICAgICAgID0gbXB0Y3Bfc29ja19kZXN0cnVjdDs8YnIg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPgogICAgICAgICAgICAgICAgICAg
ICAgLyogTVBUQ1AgdGFrZXMgYSBkaWZmZXJlbnQgcGF0aCBpbiB0Y3BfdjRfcmN2PGJyCiAgICAg
ICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4K
ICAgICAgICAgICAgICAgICAgICAgIKAqIHRodXMgbm90IGltcGFjdGluZyBtYWluIHRjcCBjb2Rl
ICovPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5zay0mZ3Q7c2tfYmFj
a2xvZ19yY3YKICAgICAgICAgICAgICAgICAgICAgID0gbXB0Y3BfdjRfZG9fcmN2OzxiciBjbGFz
cz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c2stJmd0O3NrX3ByZXF1ZXVlCiAgICAg
ICAgICAgICAgICAgICAgICA9IHNrX3ByZXF1ZXVlOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAg
ICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPmlmCiAgICAgICAgICAgICAgICAgICAgICAoc2stJmd0O3NrX2ZhbWls
eSA9PSBBRl9JTkVUKTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj5tcHRjcF9kZWJ1ZygiJXM6CiAgICAgICAgICAgICAgICAgICAgICB0b2tlbiAlI3ggcGkgJWQs
IHNyY19hZGRyOiVwSTQ6JWQKICAgICAgICAgICAgICAgICAgICAgIGRzdF9hZGRyOiVwSTQ6JWQs
IGNudF9zdWJmbG93cyBub3cgJWRcbiIsPGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNz
PSIiPgogICAgICAgICAgICAgICAgICAgICAgQEAgLTI2NTgsNiArMjY3Niw5IEBAIHZvaWQgX19p
bml0IG1wdGNwX2luaXQodm9pZCk8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pZgogICAgICAgICAgICAgICAgICAgICAgKG1w
dGNwX3BtX3Y0X2luaXQoKSk8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+Z290bwogICAgICAgICAgICAgICAgICAgICAgbXB0Y3BfcG1fdjRfZmFpbGVkOzxiciBj
bGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAgICAg
ICAgICgoY21weGNoZygmYW1wO3RjcF9wcm9jZXNzX3VuY2xhaW1lZCwgTlVMTCwKICAgICAgICAg
ICAgICAgICAgICAgIG1wdGNwX3Y0X2RvX3JjdikpICE9IE5VTEwpPGJyIGNsYXNzPSIiPgogICAg
ICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cHJpbnRrKCJ0Y3BfcHJvY2Vzc191bmNsYWltZWQK
ICAgICAgICAgICAgICAgICAgICAgIG5vdCBOVUxMIFxuIik7PGJyIGNsYXNzPSIiPgogICAgICAg
ICAgICAgICAgICAgICAgKzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
Pm1wdGNwX3N5c2N0bAogICAgICAgICAgICAgICAgICAgICAgPSByZWdpc3Rlcl9uZXRfc3lzY3Rs
KCZhbXA7aW5pdF9uZXQsICJuZXQvbXB0Y3AiLAogICAgICAgICAgICAgICAgICAgICAgbXB0Y3Bf
dGFibGUpOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmCiAgICAg
ICAgICAgICAgICAgICAgICAoIW1wdGNwX3N5c2N0bCk8YnIgY2xhc3M9IiI+CiAgICAgICAgICAg
ICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+Z290bwogICAgICAgICAgICAgICAgICAgICAgcmVnaXN0ZXJf
c3lzY3RsX2ZhaWxlZDs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICBkaWZmIC0t
Z2l0IGEvbmV0L21wdGNwL21wdGNwX2lucHV0LmMKICAgICAgICAgICAgICAgICAgICAgIGIvbmV0
L21wdGNwL21wdGNwX2lucHV0LmM8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICBp
bmRleCA1MWNiYjA2Li4wZTA5ZGRmIDEwMDY0NDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAg
ICAgICAgIC0tLSBhL25ldC9tcHRjcC9tcHRjcF9pbnB1dC5jPGJyIGNsYXNzPSIiPgogICAgICAg
ICAgICAgICAgICAgICAgKysrIGIvbmV0L21wdGNwL21wdGNwX2lucHV0LmM8YnIgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICBAQCAtMzIzLDkgKzMyMyw4IEBAIHN0YXRpYyBpbnQKICAg
ICAgICAgICAgICAgICAgICAgIG1wdGNwX3ZlcmlmX2Rzc19jc3VtKHN0cnVjdCBzb2NrICpzayk8
YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPgogICAgICAg
ICAgICAgICAgICAgICAgKiBieSA0IGJ5dGVzLCBhcyB0aGUgaGlnaC1vcmRlciA2NC1iaXRzIHdp
bGwgYmUKICAgICAgICAgICAgICAgICAgICAgIGFkZGVkPGJyIGNsYXNzPSIiPgogICAgICAgICAg
ICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICAgICogaW4gdGhl
IGZpbmFsIGNzdW1fcGFydGlhbC1jYWxsLjxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAg
ICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgICAqLzxiciBjbGFzcz0iIj4K
ICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj51MzIKICAgICAgICAgICAgICAgICAg
ICAgIG9mZnNldCA9IHNrYl90cmFuc3BvcnRfb2Zmc2V0KHRtcCkgKzxiciBjbGFzcz0iIj4KICAg
ICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+CiAgICAgICAgICAgICAgICAgICAg
ICCgoKCgVENQX1NLQl9DQih0bXApLSZndDtkc3Nfb2ZmOzxiciBjbGFzcz0iIj4KICAgICAgICAg
ICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pZgogICAgICAgICAgICAgICAgICAgICAgKFRDUF9T
S0JfQ0IodG1wKS0mZ3Q7bXB0Y3BfZmxhZ3MgJmFtcDsKICAgICAgICAgICAgICAgICAgICAgIE1Q
VENQSERSX1NFUTY0X1NFVCk8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+dTMyCiAgICAgICAgICAgICAgICAgICAgICBvZmZzZXQgPSBza2JfdHJhbnNwb3J0
X29mZnNldCh0bXApICsKICAgICAgICAgICAgICAgICAgICAgIHRtcC0mZ3Q7bXB0Y3BfZHNzX29m
Zjs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAg
ICAgICAgICAgICAgICAgICAgICh0bXAtJmd0O21wdGNwX2ZsYWdzICZhbXA7IE1QVENQSERSX1NF
UTY0X1NFVCk8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAg
ICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5vZmZzZXQKICAgICAgICAgICAgICAgICAgICAg
ICs9IDQ7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5j
c3VtX3RjcAogICAgICAgICAgICAgICAgICAgICAgPSBza2JfY2hlY2tzdW0odG1wLCBvZmZzZXQs
PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgQEAgLTc1OCw3ICs3NTcsNyBAQCBz
dGF0aWMgaW50CiAgICAgICAgICAgICAgICAgICAgICBtcHRjcF9kZXRlY3RfbWFwcGluZyhzdHJ1
Y3Qgc29jayAqc2ssIHN0cnVjdAogICAgICAgICAgICAgICAgICAgICAgc2tfYnVmZiAqc2tiKTxi
ciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPn08YnIKICAgICAgICAgICAg
ICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4vKgogICAg
ICAgICAgICAgICAgICAgICAgRG9lcyB0aGUgRFNTIGhhZCA2NC1iaXQgc2VxbnVtJ3MgPyAqLzxi
ciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAg
ICAgICAgICghKHRjYi0mZ3Q7bXB0Y3BfZmxhZ3MgJmFtcDsgTVBUQ1BIRFJfU0VRNjRfU0VUKSkK
ICAgICAgICAgICAgICAgICAgICAgIHs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAg
ICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPmlmCiAgICAgICAgICAgICAgICAgICAgICAoIShza2ItJmd0O21wdGNwX2ZsYWdzICZh
bXA7IE1QVENQSERSX1NFUTY0X1NFVCkpCiAgICAgICAgICAgICAgICAgICAgICB7PGJyIGNsYXNz
PSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPi8qCiAgICAgICAgICAgICAgICAg
ICAgICBXcmFwcGVkIGFyb3VuZD8gKi88YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAg
ICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAgICAgICAgICh1bmxpa2VseShhZnRlcihkYXRh
X3NlcSwgbWV0YV90cC0mZ3Q7cmN2X254dCkKICAgICAgICAgICAgICAgICAgICAgICZhbXA7JmFt
cDsgZGF0YV9zZXEgJmx0OyBtZXRhX3RwLSZndDtyY3Zfbnh0KSkgezxicgogICAgICAgICAgICAg
ICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
dHAtJmd0O21wdGNwLSZndDttYXBfZGF0YV9zZXEKICAgICAgICAgICAgICAgICAgICAgID0gbXB0
Y3BfZ2V0X2RhdGFfc2VxXzY0KG1wY2IsCiAgICAgICAgICAgICAgICAgICAgICAhbXBjYi0mZ3Q7
cmN2X2hpc2VxX2luZGV4LCBkYXRhX3NlcSk7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAg
ICAgICAgQEAgLTc2Nyw5ICs3NjYsOSBAQCBzdGF0aWMgaW50CiAgICAgICAgICAgICAgICAgICAg
ICBtcHRjcF9kZXRlY3RfbWFwcGluZyhzdHJ1Y3Qgc29jayAqc2ssIHN0cnVjdAogICAgICAgICAg
ICAgICAgICAgICAgc2tfYnVmZiAqc2tiKTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAg
ICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+dHAtJmd0O21wdGNwLSZndDttYXBfZGF0YV9zZXEKICAgICAgICAg
ICAgICAgICAgICAgID0gbXB0Y3BfZ2V0X2RhdGFfc2VxXzY0KG1wY2IsCiAgICAgICAgICAgICAg
ICAgICAgICBtcGNiLSZndDtyY3ZfaGlzZXFfaW5kZXgsIGRhdGFfc2VxKTs8YnIgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+fTxicgogICAgICAgICAgICAgICAgICAg
ICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPn0KICAgICAgICAgICAg
ICAgICAgICAgIGVsc2UgezxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPnRwLSZndDttcHRjcC0mZ3Q7bWFwX2RhdGFfc2VxCiAgICAgICAgICAgICAgICAgICAgICA9
IG1wdGNwX2dldF9kYXRhX3NlcV82NChtcGNiLCAodGNiLSZndDttcHRjcF9mbGFncwogICAgICAg
ICAgICAgICAgICAgICAgJmFtcDsgTVBUQ1BIRFJfU0VRNjRfSU5ERVgpID8gMSA6IDAsIGRhdGFf
c2VxKTs8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAg
ICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj50cC0mZ3Q7bXB0Y3AtJmd0O21hcF9kYXRhX3NlcQogICAgICAgICAg
ICAgICAgICAgICAgPSBtcHRjcF9nZXRfZGF0YV9zZXFfNjQobXBjYiwgKHNrYi0mZ3Q7bXB0Y3Bf
ZmxhZ3MKICAgICAgICAgICAgICAgICAgICAgICZhbXA7IE1QVENQSERSX1NFUTY0X0lOREVYKSA/
IDEgOiAwLCBkYXRhX3NlcSk7PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgog
ICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAgICAgICAgICh1
bmxpa2VseSh0Y2ItJmd0O21wdGNwX2ZsYWdzICZhbXA7CiAgICAgICAgICAgICAgICAgICAgICBN
UFRDUEhEUl9TRVE2NF9PRk8pKSB7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+aWYKICAgICAgICAgICAgICAgICAgICAgICh1bmxpa2VseShza2ItJmd0O21wdGNw
X2ZsYWdzICZhbXA7CiAgICAgICAgICAgICAgICAgICAgICBNUFRDUEhEUl9TRVE2NF9PRk8pKSB7
PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4vKgogICAg
ICAgICAgICAgICAgICAgICAgV2UgbWFrZSBzdXJlIHRoYXQgdGhlIGRhdGFfc2VxIGlzIGludmFs
aWQuPGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAg
ICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICAgICogSXQgd2lsbCBiZSBk
cm9wcGVkIGxhdGVyLjxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgICAqLzxiciBjbGFzcz0iIj4KICAgICAgICAgICAg
ICAgICAgICAgIEBAIC0xMDIwLDYgKzEwMTksNjcgQEAgbmV4dDo8YnIgY2xhc3M9IiI+CiAgICAg
ICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5yZXR1cm4KICAgICAgICAgICAgICAgICAgICAgIGRhdGFf
cXVldWVkID8gLTEgOiAtMjs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoH08
YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArc3RhdGljIHN0cnVjdCBza19idWZm
ICo8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArbXB0Y3BfcHJvY2Vzc19hY2so
c3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3Qgc2tfYnVmZgogICAgICAgICAgICAgICAgICAgICAgKnNr
Yik8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArezxiciBjbGFzcz0iIj4KICAg
ICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c3RydWN0CiAgICAgICAgICAgICAgICAgICAgICB0Y3Bf
c29jayAqdHAgPSB0Y3Bfc2soc2spOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAg
ICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+aW50CiAgICAgICAgICAgICAgICAgICAgICBmbGFnID0gMDs8YnIgY2xhc3M9IiI+CiAg
ICAgICAgICAgICAgICAgICAgICArPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj4vKjxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAg
ICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgICAqIFRDUCB0YWtlcyBjYXJlIG9m
IGludmFsaWQgYWNrJ3M8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPgog
ICAgICAgICAgICAgICAgICAgICAgKiB0aGV5IHdpbGwgbmV2ZXIgc2hvdyB1cCBoZXJlLjxiciBj
bGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+CiAgICAgICAgICAgICAgICAgICAg
ICAqLzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8YnIgY2xhc3M9IiI+CiAg
ICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAgLyogSXMgdGhp
cyBza2IgYWNrbm93bGVkaW5nIGFueXRoaW5nIGRhdGEgKi88YnIKICAgICAgICAgICAgICAgICAg
ICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxicgogICAgICAgICAg
ICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAg
ICAgICAgICAgICAgICAgICAgICh0cC0mZ3Q7bXB0Y3AtJmd0O3NudF9pc24gKyAxICE9CiAgICAg
ICAgICAgICAgICAgICAgICBUQ1BfU0tCX0NCKHNrYiktJmd0O2Fja19zZXEpIHs8YnIgY2xhc3M9
IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5mbGFnCiAgICAgICAgICAgICAgICAg
ICAgICA9IE1QVENQX0ZMQUdfREFUQV9BQ0tFRDs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAg
ICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPn08YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAg
ICAgICAgICAgICAgICAgICArPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj5pZgogICAgICAgICAgICAgICAgICAgICAgKG1wdGNwX2ZhbGxiYWNrX2luZmluaXRlKHNrLCBm
bGFnKSkgezxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnByX2Vy
cigiJXMKICAgICAgICAgICAgICAgICAgICAgIHJlc2V0dGluZyBmbG93XG4iLCBfX2Z1bmNfXyk7
PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+bXB0Y3Bfc2VuZF9y
ZXNldChzayk7PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAg
ICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+Z290bwogICAgICAgICAgICAgICAgICAgICAgaW52YWxpZF9h
Y2s7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj59PGJyCiAgICAgICAg
ICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxiciBjbGFz
cz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+bXB0Y3BfY2xlYW5fcnR4X2luZmluaXRl
KHNrYiwKICAgICAgICAgICAgICAgICAgICAgIHNrKTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAg
ICAgICAgICAgICArPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5yZXR1
cm4KICAgICAgICAgICAgICAgICAgICAgIChza2IpOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAg
ICAgICAgICAgICtpbnZhbGlkX2Fjazo8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAg
ICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPl9fc2tiX3VubGluayhza2IsCiAgICAgICAgICAgICAgICAgICAgICAmYW1wO3NrLSZn
dDtza19yZWNlaXZlX3F1ZXVlKTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAr
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPl9fa2ZyZWVfc2tiKHNrYik7PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIi
PgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5yZXR1cm4KICAgICAgICAgICAgICAgICAgICAg
IChOVUxMKTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPGJyIGNsYXNzPSIi
PgogICAgICAgICAgICAgICAgICAgICAgK308YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAg
ICAgICArPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgK3N0YXRpYyBzdHJ1Y3Qg
c2tfYnVmZiAqPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgK21wdGNwX3Byb2Nl
c3Nfb3B0aW9uc19hY2soc3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3QKICAgICAgICAgICAgICAgICAg
ICAgIHNrX2J1ZmYgKnNrYik8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArezxi
ciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c3RydWN0CiAgICAgICAgICAg
ICAgICAgICAgICB0Y3Bfc29jayAqdHAgPSB0Y3Bfc2soc2spOzxiciBjbGFzcz0iIj4KICAgICAg
ICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+Y29uc3QKICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB0
Y3BoZHIgKnRoID0gdGNwX2hkcihza2IpOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAg
ICAgICs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnNrYi0mZ3Q7bXB0
Y3BfZmxhZ3MKICAgICAgICAgICAgICAgICAgICAgID0gMDs8YnIgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPnNrYi0mZ3Q7bXB0Y3BfZHNzX29mZgogICAgICAgICAgICAgICAg
ICAgICAgPSAwOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8YnIgY2xhc3M9
IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnRjcF9wYXJzZV9tcHRjcF9vcHRpb25zKHNr
YiwKICAgICAgICAgICAgICAgICAgICAgICZhbXA7dHAtJmd0O21wdGNwLSZndDtyeF9vcHQpOzxi
ciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAg
ICAgICAgIChtcHRjcF9oYW5kbGVfb3B0aW9ucyhzaywgdGgsIHNrYikpIHs8YnIgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5tcHRjcF9yZXNldF9tb3B0KHRwKTs8YnIK
ICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAr
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj5fX3NrYl91bmxpbmsoc2tiLAogICAgICAgICAgICAgICAgICAgICAgJmFtcDtzay0m
Z3Q7c2tfcmVjZWl2ZV9xdWV1ZSk7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+X19rZnJlZV9za2Ioc2tiKTs8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xh
c3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5za2IKICAgICAgICAgICAgICAg
ICAgICAgID0gTlVMTDs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPn08
YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAg
ICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPmlmCiAgICAgICAgICAgICAgICAgICAgICAoKHNrYiAhPSBOVUxMKSAmYW1wOyZhbXA7
IHNrYi0mZ3Q7bGVuID09IDApIHs8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5za2IKICAgICAgICAgICAgICAgICAgICAg
ID0gbXB0Y3BfcHJvY2Vzc19hY2soc2ssIHNrYik7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAg
ICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAgICAgICAgIChza2IgIT0gTlVMTCAm
YW1wOyZhbXA7IHNrYi0mZ3Q7bGVuID09IDApIHs8YnIKICAgICAgICAgICAgICAgICAgICAgICAg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+LyoKICAgICAgICAg
ICAgICAgICAgICAgIFB1cmUgYWNrICovPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAg
ICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPl9fc2tiX3VubGluayhza2IsCiAgICAgICAgICAgICAgICAgICAgICAm
YW1wO3NrLSZndDtza19yZWNlaXZlX3F1ZXVlKTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAg
ICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+X19rZnJlZV9za2Ioc2tiKTs8YnIKICAgICAgICAgICAgICAg
ICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c2ti
CiAgICAgICAgICAgICAgICAgICAgICA9IE5VTEw7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAg
ICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+fTxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4K
ICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+fTxicgogICAgICAgICAgICAgICAgICAgICAgICBj
bGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cmV0dXJuCiAgICAgICAgICAgICAg
ICAgICAgICAoc2tiKTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArfTxiciBj
bGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAg
ICAgICAgICAgICCgoHZvaWQgbXB0Y3BfZGF0YV9yZWFkeShzdHJ1Y3Qgc29jayAqc2spPGJyCiAg
ICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKB7
PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c3RydWN0CiAgICAgICAg
ICAgICAgICAgICAgICBzb2NrICptZXRhX3NrID0gbXB0Y3BfbWV0YV9zayhzayk7PGJyIGNsYXNz
PSIiPgogICAgICAgICAgICAgICAgICAgICAgQEAgLTEwNDUsNiArMTEwNSwxMCBAQCByZXN0YXJ0
OjxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPgogICAgICAgICAgICAg
ICAgICAgICAgKi88YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5za2Jf
cXVldWVfd2Fsa19zYWZlKCZhbXA7c2stJmd0O3NrX3JlY2VpdmVfcXVldWUsCiAgICAgICAgICAg
ICAgICAgICAgICBza2IsIHRtcCkgezxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAg
IKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj5pbnQKICAgICAgICAgICAgICAgICAgICAgIHJldDs8YnIgY2xhc3M9IiI+CiAg
ICAgICAgICAgICAgICAgICAgICArPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+c2tiCiAgICAgICAgICAgICAgICAgICAgICA9IG1wdGNwX3Byb2Nlc3Nfb3B0aW9u
c19hY2soc2ssIHNrYik7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+aWYKICAgICAgICAgICAgICAgICAgICAgIChza2IgPT0gTlVMTCk8YnIgY2xhc3M9IiI+CiAg
ICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+Y29udGludWU7PGJyCiAgICAgICAgICAg
ICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPi8q
CiAgICAgICAgICAgICAgICAgICAgICBQcmUtdmFsaWRhdGlvbiAtIGUuZy4sIGVhcmx5IGZhbGxi
YWNrICovPGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAg
ICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPnJldAogICAgICAgICAgICAgICAgICAgICAgPSBtcHRjcF9wcmV2
YWxpZGF0ZV9za2Ioc2ssIHNrYik7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
oKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPmlmCiAgICAgICAgICAgICAgICAgICAgICAocmV0ICZsdDsgMCk8YnIgY2xhc3M9
IiI+CiAgICAgICAgICAgICAgICAgICAgICBAQCAtMTEwOCwxMyArMTE3MiwxMSBAQCBpbnQgbXB0
Y3BfY2hlY2tfcmVxKHN0cnVjdAogICAgICAgICAgICAgICAgICAgICAgc2tfYnVmZiAqc2tiLCBz
dHJ1Y3QgbmV0ICpuZXQpPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
aWYKICAgICAgICAgICAgICAgICAgICAgICghbWV0YV9zayk8YnIgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cmV0dXJuCiAgICAgICAgICAgICAgICAgICAgICAwOzxi
ciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+VENQX1NLQl9DQihza2IpLSZn
dDttcHRjcF9mbGFncwogICAgICAgICAgICAgICAgICAgICAgfD0gTVBUQ1BIRFJfSk9JTjs8YnIg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPGJyIGNsYXNzPSIiPgogICAgICAgICAg
ICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+YmhfbG9ja19zb2NrX25lc3RlZChtZXRhX3NrKTs8YnIKICAgICAg
ICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5p
ZgogICAgICAgICAgICAgICAgICAgICAgKHNvY2tfb3duZWRfYnlfdXNlcihtZXRhX3NrKSkgezxi
ciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnNrYi0mZ3Q7c2sKICAg
ICAgICAgICAgICAgICAgICAgID0gbWV0YV9zazs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAg
ICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj5za2ItJmd0O3NrCiAgICAgICAgICAgICAgICAgICAgICA9IChzdHJ1
Y3Qgc29jayAqKTB4RkVFMURFQUQ7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
oKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPmlmCiAgICAgICAgICAgICAgICAgICAgICAodW5saWtlbHkoc2tfYWRkX2JhY2ts
b2cobWV0YV9zaywgc2tiLDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAgoKCgbWV0YV9zay0mZ3Q7c2tf
cmN2YnVmICsKICAgICAgICAgICAgICAgICAgICAgIG1ldGFfc2stJmd0O3NrX3NuZGJ1ZikpKSB7
PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5tZXRh
X3NrLSZndDtza19yY3ZidWYKICAgICAgICAgICAgICAgICAgICAgICsgbWV0YV9zay0mZ3Q7c2tf
c25kYnVmKSkpIHs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPmJoX3VubG9ja19zb2NrKG1ldGFfc2spOzxicgogICAgICAgICAgICAgICAgICAgICAgICBj
bGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+TkVUX0lOQ19TVEFU
U19CSChuZXQsCiAgICAgICAgICAgICAgICAgICAgICBMSU5VWF9NSUJfVENQQkFDS0xPR0RST1Ap
OzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c29ja19w
dXQobWV0YV9zayk7CiAgICAgICAgICAgICAgICAgICAgICAvKiBUYWtlbiBieSBtcHRjcF9zZWFy
Y2hfcmVxICovPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgQEAgLTExMjIsMTAg
KzExODQsMTQgQEAgaW50IG1wdGNwX2NoZWNrX3JlcShzdHJ1Y3QKICAgICAgICAgICAgICAgICAg
ICAgIHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5ldCAqbmV0KTxiciBjbGFzcz0iIj4KICAgICAgICAg
ICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cmV0dXJuCiAgICAgICAgICAgICAgICAgICAgICAx
OzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj59PGJyCiAgICAg
ICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
fQogICAgICAgICAgICAgICAgICAgICAgZWxzZSBpZiAoc2tiLSZndDtwcm90b2NvbCA9PSBodG9u
cyhFVEhfUF9JUCkpIHs8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAg
ICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj50Y3BfdjRfZG9fcmN2KG1ldGFfc2ssCiAgICAgICAg
ICAgICAgICAgICAgICBza2IpOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPi8qPGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAg
ICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgICAqIGNhbGwgb2xkIG1w
dGNwX3Y0X2RvX3JjdjxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PgogICAgICAgICAgICAgICAgICAgICAgKi88YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAg
ICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj5tcHRjcF92NF9wcm9jZXNzX2pvaW5fcmVxKG1ldGFfc2ssCiAgICAgICAg
ICAgICAgICAgICAgICBza2IpOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCg
I2lmIElTX0VOQUJMRUQoQ09ORklHX0lQVjYpPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAg
ICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+fQogICAgICAgICAgICAgICAgICAgICAgZWxzZSB7IC8qIElQdjYgKi88YnIg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj50Y3BfdjZfZG9fcmN2KG1l
dGFfc2ssCiAgICAgICAgICAgICAgICAgICAgICBza2IpOzxiciBjbGFzcz0iIj4KICAgICAgICAg
ICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPldBUk5fT04oMSk7PGJyCiAgICAgICAgICAgICAgICAgICAg
ICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+Ly9tcHRjcF92Nl9o
YW5kbGVfam9pbl9yZXEobWV0YV9zaywKICAgICAgICAgICAgICAgICAgICAgIHNrYik7PGJyIGNs
YXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKAjZW5kaWYgLyogQ09ORklHX0lQVjYgKi88
YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj59PGJyCiAgICAgICAgICAg
ICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+YmhfdW5s
b2NrX3NvY2sobWV0YV9zayk7PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgog
ICAgICAgICAgICAgICAgICAgICAgQEAgLTEyMjIsNyArMTI4OCw3IEBAIGludCBtcHRjcF9sb29r
dXBfam9pbihzdHJ1Y3QKICAgICAgICAgICAgICAgICAgICAgIHNrX2J1ZmYgKnNrYiwgc3RydWN0
IGluZXRfdGltZXdhaXRfc29jayAqdHcpPGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNz
PSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmluZXRfdHdza19wdXQodHcpOzxi
cgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAg
IKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPn08YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAg
ICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPlRDUF9TS0JfQ0Ioc2tiKS0mZ3Q7bXB0Y3BfZmxhZ3MKICAgICAgICAg
ICAgICAgICAgICAgIHw9IE1QVENQSERSX0pPSU47PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAg
ICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj5za2ItJmd0O21wdGNwX2ZsYWdzCiAgICAgICAgICAgICAgICAgICAgICB8
PSBNUFRDUEhEUl9KT0lOOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
Pi8qCiAgICAgICAgICAgICAgICAgICAgICBPSywgdGhpcyBpcyBhIG5ldyBzeW4vam9pbiwgbGV0
J3MgY3JlYXRlIGEgbmV3CiAgICAgICAgICAgICAgICAgICAgICBvcGVuIHJlcXVlc3QgYW5kPGJy
IGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+CiAgICAgICAgICAgICAgICAg
ICAgICAqIHNlbmQgc3luK2FjazxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCg
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPgogICAgICAgICAgICAgICAgICAgICAgKi88YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAg
ICAgICAgICBAQCAtMTI3OSw3ICsxMzQ1LDcgQEAgaW50CiAgICAgICAgICAgICAgICAgICAgICBt
cHRjcF9kb19qb2luX3Nob3J0KHN0cnVjdCBza19idWZmICpza2IsPGJyCiAgICAgICAgICAgICAg
ICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnJldHVy
bgogICAgICAgICAgICAgICAgICAgICAgLTE7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAg
ICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+fTxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAg
ICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+VENQX1NLQl9DQihza2IpLSZndDttcHRjcF9mbGFncwogICAg
ICAgICAgICAgICAgICAgICAgfD0gTVBUQ1BIRFJfSk9JTjs8YnIgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPi8vVENQX1NLQl9DQihza2IpLSZndDttcHRjcF9mbGFncwogICAg
ICAgICAgICAgICAgICAgICAgfD0gTVBUQ1BIRFJfSk9JTjs8YnIgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj4vKgogICAgICAgICAgICAgICAgICAgICAgT0ssIHRoaXMgaXMg
YSBuZXcgc3luL2pvaW4sIGxldCdzIGNyZWF0ZSBhIG5ldwogICAgICAgICAgICAgICAgICAgICAg
b3BlbiByZXF1ZXN0IGFuZDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PgogICAgICAgICAgICAgICAgICAgICAgKiBzZW5kIHN5bithY2s8YnIgY2xhc3M9IiI+CiAgICAg
ICAgICAgICAgICAgICAgICBAQCAtMTMwMyw3ICsxMzY5LDcgQEAgaW50CiAgICAgICAgICAgICAg
ICAgICAgICBtcHRjcF9kb19qb2luX3Nob3J0KHN0cnVjdCBza19idWZmICpza2IsPGJyCiAgICAg
ICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
fTxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAg
ICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPmlmCiAgICAgICAgICAgICAgICAgICAgICAoc29ja19vd25lZF9ieV91c2VyKG1l
dGFfc2spKSB7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c2ti
LSZndDtzawogICAgICAgICAgICAgICAgICAgICAgPSBtZXRhX3NrOzxiciBjbGFzcz0iIj4KICAg
ICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnNrYi0mZ3Q7c2sKICAgICAgICAgICAgICAgICAg
ICAgID0gKHN0cnVjdCBzb2NrICopMHhGRUUxREVBRDsgLy9za2ItJmd0O3NrID0KICAgICAgICAg
ICAgICAgICAgICAgIG1ldGFfc2s7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
oKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPmlmCiAgICAgICAgICAgICAgICAgICAgICAodW5saWtlbHkoc2tfYWRkX2JhY2ts
b2cobWV0YV9zaywgc2tiLDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICAgIKCgoG1ldGFfc2stJmd0O3Nr
X3JjdmJ1ZiArCiAgICAgICAgICAgICAgICAgICAgICBtZXRhX3NrLSZndDtza19zbmRidWYpKSk8
YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPk5FVF9JTkNf
U1RBVFNfQkgobmV0LAogICAgICAgICAgICAgICAgICAgICAgTElOVVhfTUlCX1RDUEJBQ0tMT0dE
Uk9QKTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICBAQCAtMTMxOSwxMCArMTM4
NSwxMiBAQCBpbnQKICAgICAgICAgICAgICAgICAgICAgIG1wdGNwX2RvX2pvaW5fc2hvcnQoc3Ry
dWN0IHNrX2J1ZmYgKnNrYiw8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAg
ICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgICAqLzxi
ciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5za2JfZ2V0KHNrYik7
PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAg
ICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPmlmCiAgICAgICAgICAgICAgICAgICAgICAoc2tiLSZndDtwcm90b2NvbCA9
PSBodG9ucyhFVEhfUF9JUCkpIHs8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+dGNwX3Y0X2RvX3JjdihtZXRhX3Nr
LAogICAgICAgICAgICAgICAgICAgICAgc2tiKTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAg
ICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+Ly90Y3BfdjRfZG9fcmN2KG1ldGFfc2ssCiAgICAgICAgICAg
ICAgICAgICAgICBza2IpOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj5tcHRjcF92NF9wcm9jZXNzX2pvaW5fcmVxKG1ldGFfc2ssCiAgICAgICAgICAgICAg
ICAgICAgICBza2IpOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgI2lmIElT
X0VOQUJMRUQoQ09ORklHX0lQVjYpPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
oKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPn0KICAgICAgICAgICAgICAgICAgICAgIGVsc2UgeyAvKiBJUHY2ICovPGJyIGNs
YXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnRjcF92Nl9kb19yY3Yo
bWV0YV9zaywKICAgICAgICAgICAgICAgICAgICAgIHNrYik7PGJyIGNsYXNzPSIiPgogICAgICAg
ICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPi8vbXB0Y3BfdjZfcHJvY2Vzc19qb2luX3JlcSht
ZXRhX3NrLAogICAgICAgICAgICAgICAgICAgICAgc2tiKTs8YnIgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+Ly90Y3BfdjZfZG9fcmN2KG1ldGFfc2ssCiAgICAg
ICAgICAgICAgICAgICAgICBza2IpOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAg
IKCgI2VuZGlmIC8qIENPTkZJR19JUFY2ICovPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAg
ICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPn08YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAg
ICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj59PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNs
YXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgQEAgLTE0NjEsNyArMTUyOSw2IEBAIHN0YXRp
YyB2b2lkCiAgICAgICAgICAgICAgICAgICAgICBtcHRjcF9kYXRhX2FjayhzdHJ1Y3Qgc29jayAq
c2ssIGNvbnN0IHN0cnVjdAogICAgICAgICAgICAgICAgICAgICAgc2tfYnVmZiAqc2tiKTxiciBj
bGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgezxiciBjbGFzcz0iIj4KICAgICAgICAg
ICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPnN0cnVjdAogICAgICAgICAgICAgICAgICAgICAgc29jayAqbWV0
YV9zayA9IG1wdGNwX21ldGFfc2soc2spOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAg
ICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPnN0cnVjdAogICAgICAgICAgICAgICAgICAgICAgdGNwX3NvY2sgKm1ldGFfdHAg
PSB0Y3Bfc2sobWV0YV9zayksICp0cCA9CiAgICAgICAgICAgICAgICAgICAgICB0Y3Bfc2soc2sp
OzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c3RydWN0CiAgICAgICAg
ICAgICAgICAgICAgICB0Y3Bfc2tiX2NiICp0Y2IgPSBUQ1BfU0tCX0NCKHNrYik7PGJyIGNsYXNz
PSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+dTMyCiAgICAgICAgICAgICAgICAgICAg
ICBwcmlvcl9zbmRfdW5hID0gbWV0YV90cC0mZ3Q7c25kX3VuYTs8YnIgY2xhc3M9IiI+CiAgICAg
ICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pbnQKICAgICAgICAgICAgICAgICAgICAgIHByaW9yX3Bh
Y2tldHM7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+dTMyCiAgICAg
ICAgICAgICAgICAgICAgICBud2luLCBkYXRhX2FjaywgZGF0YV9zZXE7PGJyIGNsYXNzPSIiPgog
ICAgICAgICAgICAgICAgICAgICAgQEAgLTE0ODEsNyArMTU0OCw3IEBAIHN0YXRpYyB2b2lkCiAg
ICAgICAgICAgICAgICAgICAgICBtcHRjcF9kYXRhX2FjayhzdHJ1Y3Qgc29jayAqc2ssIGNvbnN0
IHN0cnVjdAogICAgICAgICAgICAgICAgICAgICAgc2tfYnVmZiAqc2tiKTxiciBjbGFzcz0iIj4K
ICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPi8qCiAgICAgICAgICAgICAgICAgICAgICBJZiB3
ZSBhcmUgaW4gaW5maW5pdGUgbWFwcGluZyBtb2RlLAogICAgICAgICAgICAgICAgICAgICAgcnhf
b3B0LmRhdGFfYWNrIGhhcyBiZWVuPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
oKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgICAqIHNldCBieSBtcHRjcF9jbGVhbl9ydHhfaW5m
aW5pdGUuPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+CiAgICAgICAg
ICAgICAgICAgICAgICAqLzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
aWYKICAgICAgICAgICAgICAgICAgICAgICghKHRjYi0mZ3Q7bXB0Y3BfZmxhZ3MgJmFtcDsgTVBU
Q1BIRFJfQUNLKQogICAgICAgICAgICAgICAgICAgICAgJmFtcDsmYW1wOyAhdHAtJmd0O21wY2It
Jmd0O2luZmluaXRlX21hcHBpbmdfc25kKTxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFz
cz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAgICAgICAg
ICghKHNrYi0mZ3Q7bXB0Y3BfZmxhZ3MgJmFtcDsgTVBUQ1BIRFJfQUNLKQogICAgICAgICAgICAg
ICAgICAgICAgJmFtcDsmYW1wOyAhdHAtJmd0O21wY2ItJmd0O2luZmluaXRlX21hcHBpbmdfc25k
KTxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAg
ICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj5nb3RvCiAgICAgICAgICAgICAgICAgICAgICBleGl0OzxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmRhdGFfYWNrCiAgICAgICAgICAgICAgICAg
ICAgICA9IHRwLSZndDttcHRjcC0mZ3Q7cnhfb3B0LmRhdGFfYWNrOzxiciBjbGFzcz0iIj4KICAg
ICAgICAgICAgICAgICAgICAgIEBAIC0xNjQ3LDEwICsxNzE0LDExIEBAIHN0YXRpYyBpbmxpbmUg
Ym9vbAogICAgICAgICAgICAgICAgICAgICAgaXNfdmFsaWRfYWRkcm9wdF9vcHNpemUodTggbXB0
Y3BfdmVyLDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgdm9pZCBtcHRjcF9w
YXJzZV9vcHRpb25zKGNvbnN0IHVpbnQ4X3QgKnB0ciwgaW50CiAgICAgICAgICAgICAgICAgICAg
ICBvcHNpemUsPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj4KICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBtcHRjcF9vcHRpb25zX3JlY2VpdmVkICpt
b3B0LDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4KICAg
ICAgICAgICAgICAgICAgICAgIGNvbnN0IHN0cnVjdCBza19idWZmICpza2IsPGJyIGNsYXNzPSIi
PgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPgogICAgICAgICAgICAgICAgICAg
ICAgc3RydWN0IHNrX2J1ZmYgKnNrYiw8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAg
ICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHRjcF9zb2NrICp0
cCk8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoHs8YnIgY2xhc3M9IiI+CiAg
ICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5jb25zdAogICAgICAgICAgICAgICAgICAgICAgc3Ry
dWN0IG1wdGNwX29wdGlvbiAqbXBfb3B0ID0gKHN0cnVjdCBtcHRjcF9vcHRpb24KICAgICAgICAg
ICAgICAgICAgICAgICopcHRyOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+c3RydWN0CiAgICAgICAgICAgICAgICAgICAgICB0Y3Bfc2tiX2NiICp0Y2IgPSBUQ1BfU0tC
X0NCKHNrYik7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+LyoKICAg
ICAgICAgICAgICAgICAgICAgIElmIHRoZSBzb2NrZXQgaXMgbXAtY2FwYWJsZSB3ZSB3b3VsZCBo
YXZlIGEgbW9wdC4KICAgICAgICAgICAgICAgICAgICAgICovPGJyIGNsYXNzPSIiPgogICAgICAg
ICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAgICAgICAgICghbW9wdCk8YnIg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICBAQCAtMTc1Nyw3ICsxODI1LDcgQEAgdm9p
ZAogICAgICAgICAgICAgICAgICAgICAgbXB0Y3BfcGFyc2Vfb3B0aW9ucyhjb25zdCB1aW50OF90
ICpwdHIsIGludAogICAgICAgICAgICAgICAgICAgICAgb3BzaXplLDxiciBjbGFzcz0iIj4KICAg
ICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5wdHIKICAgICAgICAgICAgICAgICAgICAgICs9
IDQ7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmCiAgICAg
ICAgICAgICAgICAgICAgICAobWRzcy0mZ3Q7QSkgezxiciBjbGFzcz0iIj4KICAgICAgICAgICAg
ICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj50Y2ItJmd0O21wdGNwX2ZsYWdzCiAgICAgICAgICAgICAg
ICAgICAgICB8PSBNUFRDUEhEUl9BQ0s7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAg
ICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPnNrYi0mZ3Q7bXB0Y3BfZmxhZ3MKICAgICAgICAgICAgICAgICAgICAg
IHw9IE1QVENQSERSX0FDSzs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPmlmCiAgICAgICAgICAgICAgICAgICAgICAobWRzcy0mZ3Q7YSkgezxiciBjbGFz
cz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPm1vcHQtJmd0O2Rh
dGFfYWNrCiAgICAgICAgICAgICAgICAgICAgICA9ICh1MzIpIGdldF91bmFsaWduZWRfYmU2NChw
dHIpOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIEBAIC0xNzY4LDEzICsxODM2
LDEzIEBAIHZvaWQKICAgICAgICAgICAgICAgICAgICAgIG1wdGNwX3BhcnNlX29wdGlvbnMoY29u
c3QgdWludDhfdCAqcHRyLCBpbnQKICAgICAgICAgICAgICAgICAgICAgIG9wc2l6ZSw8YnIgY2xh
c3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPn08YnIKICAgICAgICAg
ICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
fTxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAg
ICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPnRjYi0mZ3Q7ZHNzX29mZgogICAgICAgICAgICAgICAgICAgICAgPSAocHRy
IC0gc2tiX3RyYW5zcG9ydF9oZWFkZXIoc2tiKSk7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAg
ICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1z
cGFjZTpwcmUiPgk8L3NwYW4+c2tiLSZndDttcHRjcF9kc3Nfb2ZmCiAgICAgICAgICAgICAgICAg
ICAgICA9IChwdHIgLSBza2JfdHJhbnNwb3J0X2hlYWRlcihza2IpKTs8YnIgY2xhc3M9IiI+CiAg
ICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAgICAgICAgICht
ZHNzLSZndDtNKSB7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj5pZgogICAgICAgICAgICAgICAgICAgICAgKG1kc3MtJmd0O20pIHs8YnIgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj51NjQKICAgICAgICAgICAg
ICAgICAgICAgIGRhdGFfc2VxNjQgPSBnZXRfdW5hbGlnbmVkX2JlNjQocHRyKTs8YnIgY2xhc3M9
IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnRjYi0mZ3Q7bXB0Y3Bf
ZmxhZ3MKICAgICAgICAgICAgICAgICAgICAgIHw9IE1QVENQSERSX1NFUTY0X1NFVDs8YnIgY2xh
c3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnNrYi0mZ3Q7bXB0
Y3BfZmxhZ3MKICAgICAgICAgICAgICAgICAgICAgIHw9IE1QVENQSERSX1NFUTY0X1NFVDs8YnIg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5tb3B0LSZn
dDtkYXRhX3NlcQogICAgICAgICAgICAgICAgICAgICAgPSAodTMyKSBkYXRhX3NlcTY0OzxiciBj
bGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnB0cgogICAg
ICAgICAgICAgICAgICAgICAgKz0gMTI7IC8qIDY0LWJpdCBkc2VxICsgc3Vic2VxICovPGJyIGNs
YXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgQEAgLTE3ODQsMTUgKzE4NTIsMTYgQEAgdm9p
ZAogICAgICAgICAgICAgICAgICAgICAgbXB0Y3BfcGFyc2Vfb3B0aW9ucyhjb25zdCB1aW50OF90
ICpwdHIsIGludAogICAgICAgICAgICAgICAgICAgICAgb3BzaXplLDxiciBjbGFzcz0iIj4KICAg
ICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+fTxicgogICAgICAgICAgICAgICAgICAg
ICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+bW9wdC0m
Z3Q7ZGF0YV9sZW4KICAgICAgICAgICAgICAgICAgICAgID0gZ2V0X3VuYWxpZ25lZF9iZTE2KHB0
cik7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnRjYi0m
Z3Q7bXB0Y3BfZmxhZ3MKICAgICAgICAgICAgICAgICAgICAgIHw9IE1QVENQSERSX1NFUTs8YnIg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c2tiLSZndDttcHRj
cF9mbGFncwogICAgICAgICAgICAgICAgICAgICAgfD0gTVBUQ1BIRFJfU0VROzxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+LyoKICAgICAgICAgICAgICAg
ICAgICAgIElzIGEgY2hlY2stc3VtIHByZXNlbnQ/ICovPGJyIGNsYXNzPSIiPgogICAgICAgICAg
ICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmCiAgICAgICAgICAgICAgICAgICAgICAob3BzaXpl
ID09IG1wdGNwX3N1Yl9sZW5fZHNzKG1kc3MsIDEpKTxiciBjbGFzcz0iIj4KICAgICAgICAgICAg
ICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+dGNiLSZndDttcHRjcF9mbGFncwogICAgICAgICAg
ICAgICAgICAgICAgfD0gTVBUQ1BIRFJfRFNTX0NTVU07PGJyIGNsYXNzPSIiPgogICAgICAgICAg
ICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmCiAgICAgICAgICAgICAgICAgICAgICAob3BzaXpl
ID09IG1wdGNwX3N1Yl9sZW5fZHNzKG1kc3MsIDEpKSB7PGJyCiAgICAgICAgICAgICAgICAgICAg
ICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5za2It
Jmd0O21wdGNwX2ZsYWdzCiAgICAgICAgICAgICAgICAgICAgICB8PSBNUFRDUEhEUl9EU1NfQ1NV
TTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+fTxicgog
ICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCg
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+LyoKICAgICAgICAgICAgICAgICAgICAgIERBVEFfRklOIG9ubHkgcG9zc2li
bGUgd2l0aCBEU1MtbWFwcGluZyAqLzxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAg
ICAgICAgIChtZHNzLSZndDtGKTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+dGNiLSZndDttcHRjcF9mbGFncwogICAgICAgICAgICAgICAgICAgICAg
fD0gTVBUQ1BIRFJfRklOOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+c2tiLSZndDttcHRjcF9mbGFncwogICAgICAgICAgICAgICAgICAgICAgfD0g
TVBUQ1BIRFJfRklOOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj59PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAg
ICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPmJyZWFrOzxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgIEBAIC0xOTA3LDggKzE5NzYsOSBAQCB2b2lkCiAgICAg
ICAgICAgICAgICAgICAgICB0Y3BfcGFyc2VfbXB0Y3Bfb3B0aW9ucyhjb25zdCBzdHJ1Y3Qgc2tf
YnVmZiAqc2tiLDxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAg
ICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnJldHVybjs8YnIKICAgICAgICAgICAgICAg
ICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlm
CiAgICAgICAgICAgICAgICAgICAgICAob3BzaXplICZndDsgbGVuZ3RoKTxiciBjbGFzcz0iIj4K
ICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnJldHVybjs8c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+LyoKICAg
ICAgICAgICAgICAgICAgICAgIGRvbid0IHBhcnNlIHBhcnRpYWwgb3B0aW9ucyAqLzxiciBjbGFz
cz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pZgogICAgICAgICAgICAg
ICAgICAgICAgKG9wY29kZSA9PSBUQ1BPUFRfTVBUQ1ApPGJyIGNsYXNzPSIiPgogICAgICAgICAg
ICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmCiAgICAgICAgICAgICAgICAgICAgICAob3Bjb2Rl
ID09IFRDUE9QVF9NUFRDUCkgezxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCg
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPm1wdGNwX3BhcnNlX29wdGlvbnMocHRyCiAgICAgICAgICAgICAgICAg
ICAgICAtIDIsIG9wc2l6ZSwgbW9wdCwgc2tiLCBOVUxMKTs8YnIgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+fTxicgogICAgICAgICAgICAgICAgICAgICAgICBj
bGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj59PGJyCiAgICAgICAgICAg
ICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnB0
cgogICAgICAgICAgICAgICAgICAgICAgKz0gb3BzaXplIC0gMjs8YnIgY2xhc3M9IiI+CiAgICAg
ICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+bGVuZ3RoCiAgICAgICAgICAgICAgICAgICAgICAt
PSBvcHNpemU7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgQEAgLTIxNjgsNiAr
MjIzOCw4IEBAIGJvb2wKICAgICAgICAgICAgICAgICAgICAgIG1wdGNwX2hhbmRsZV9vcHRpb25z
KHN0cnVjdCBzb2NrICpzaywgY29uc3Qgc3RydWN0CiAgICAgICAgICAgICAgICAgICAgICB0Y3Bo
ZHIgKnRoLDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnN0cnVjdAog
ICAgICAgICAgICAgICAgICAgICAgdGNwX3NvY2sgKnRwID0gdGNwX3NrKHNrKTs8YnIgY2xhc3M9
IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5zdHJ1Y3QKICAgICAgICAgICAgICAgICAg
ICAgIG1wdGNwX29wdGlvbnNfcmVjZWl2ZWQgKm1vcHQgPQogICAgICAgICAgICAgICAgICAgICAg
JmFtcDt0cC0mZ3Q7bXB0Y3AtJmd0O3J4X29wdDs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAg
ICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPkJVR19PTihzawogICAgICAgICAgICAgICAgICAgICAgPT0gbXB0Y3BfbWV0
YV9zayhzaykpOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8YnIgY2xhc3M9
IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pZgogICAgICAgICAgICAgICAgICAgICAg
KHRwLSZndDttcGNiLSZndDtpbmZpbml0ZV9tYXBwaW5nX3JjdiB8fAogICAgICAgICAgICAgICAg
ICAgICAgdHAtJmd0O21wY2ItJmd0O2luZmluaXRlX21hcHBpbmdfc25kKTxiciBjbGFzcz0iIj4K
ICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5yZXR1cm4KICAgICAgICAgICAgICAgICAg
ICAgIGZhbHNlOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIEBAIC0yMTg1LDcg
KzIyNTcsNyBAQCBib29sCiAgICAgICAgICAgICAgICAgICAgICBtcHRjcF9oYW5kbGVfb3B0aW9u
cyhzdHJ1Y3Qgc29jayAqc2ssIGNvbnN0IHN0cnVjdAogICAgICAgICAgICAgICAgICAgICAgdGNw
aGRyICp0aCw8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4KICAgICAg
ICAgICAgICAgICAgICAgICogcmVjZWl2ZXIgTVVTVCBjbG9zZSB0aGUgc3ViZmxvdyB3aXRoIGEg
UlNUIGFzIGl0CiAgICAgICAgICAgICAgICAgICAgICBpcyBjb25zaWRlcmVkIGJyb2tlbi48YnIg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4KICAgICAgICAgICAgICAgICAg
ICAgICovPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAg
ICAgICAgICAgICAgICAgIChtcHRjcF9pc19kYXRhX3NlcShza2IpICZhbXA7JmFtcDsKICAgICAg
ICAgICAgICAgICAgICAgIHRwLSZndDttcGNiLSZndDtkc3NfY3N1bSAmYW1wOyZhbXA7PGJyIGNs
YXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICAg
IKCgoCEoVENQX1NLQl9DQihza2IpLSZndDttcHRjcF9mbGFncyAmYW1wOwogICAgICAgICAgICAg
ICAgICAgICAgTVBUQ1BIRFJfRFNTX0NTVU0pKSB7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAg
ICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICAgIKCgoCEoc2tiLSZndDttcHRjcF9m
bGFncyAmYW1wOyBNUFRDUEhEUl9EU1NfQ1NVTSkpCiAgICAgICAgICAgICAgICAgICAgICB7PGJy
IGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPm1wdGNwX3NlbmRfcmVz
ZXQoc2spOzxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAg
ICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj5yZXR1cm4KICAgICAgICAgICAgICAgICAgICAgIHRydWU7PGJy
IGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+fTxicgogICAgICAgICAgICAg
ICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIEBAIC0yMzMwLDYgKzI0
MDIsNyBAQCBpbnQKICAgICAgICAgICAgICAgICAgICAgIG1wdGNwX3Jjdl9zeW5zZW50X3N0YXRl
X3Byb2Nlc3Moc3RydWN0IHNvY2sgKnNrLAogICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHNv
Y2sgKipza3B0ciw8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
LyoKICAgICAgICAgICAgICAgICAgICAgIFNldCB0aGlzIGZsYWcgaW4gb3JkZXIgdG8gcG9zdHBv
bmUgZGF0YSBzZW5kaW5nPGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAg
ICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAgKiB1bnRp
bCB0aGUgNHRoIGFjayBhcnJpdmVzLjxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAg
IKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICAgICovPGJyIGNsYXNzPSIiPgogICAgICAg
ICAgICAgICAgICAgICAgK3ByaW50aygibXB0Y3BfcmN2X3N5bnNlbnRfc3RhdGVfcHJvY2Vzcwog
ICAgICAgICAgICAgICAgICAgICAgoHByZV9lc3RhYmxpc2hlZCBzZXQgXG4iKTs8YnIgY2xhc3M9
IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+dHAtJmd0O21wdGNwLSZndDtwcmVf
ZXN0YWJsaXNoZWQKICAgICAgICAgICAgICAgICAgICAgID0gMTs8YnIgY2xhc3M9IiI+CiAgICAg
ICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+dHAtJmd0O21wdGNwLSZndDtyY3ZfbG93X3ByaW8K
ICAgICAgICAgICAgICAgICAgICAgID0gdHAtJmd0O21wdGNwLSZndDtyeF9vcHQubG93X3ByaW87
PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgZGlmZiAtLWdpdCBhL25ldC9tcHRj
cC9tcHRjcF9pcHY0LmMKICAgICAgICAgICAgICAgICAgICAgIGIvbmV0L21wdGNwL21wdGNwX2lw
djQuYzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIGluZGV4IGExNDdiMjAuLjNl
NjBhYjUgMTAwNjQ0PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLS0tIGEvbmV0
L21wdGNwL21wdGNwX2lwdjQuYzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICsr
KyBiL25ldC9tcHRjcC9tcHRjcF9pcHY0LmM8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAg
ICAgICBAQCAtMTgwLDQ1ICsxODAsMTIgQEAgc3RhdGljIGludAogICAgICAgICAgICAgICAgICAg
ICAgbXB0Y3BfdjRfam9pbl9yZXF1ZXN0KHN0cnVjdCBzb2NrICptZXRhX3NrLCBzdHJ1Y3QKICAg
ICAgICAgICAgICAgICAgICAgIHNrX2J1ZmYgKnNrYik8YnIgY2xhc3M9IiI+CiAgICAgICAgICAg
ICAgICAgICAgICCgoH08YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoC8qIFdl
IG9ubHkgcHJvY2VzcyBqb2luIHJlcXVlc3RzIGhlcmUuIChlaXRoZXIKICAgICAgICAgICAgICAg
ICAgICAgIHRoZSBTWU4gb3IgdGhlIGZpbmFsIEFDSykgKi88YnIgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICAtaW50IG1wdGNwX3Y0X2RvX3JjdihzdHJ1Y3Qgc29jayAqbWV0YV9zaywg
c3RydWN0CiAgICAgICAgICAgICAgICAgICAgICBza19idWZmICpza2IpPGJyIGNsYXNzPSIiPgog
ICAgICAgICAgICAgICAgICAgICAgK2ludCBtcHRjcF92NF9wcm9jZXNzX2pvaW5fcmVxKHN0cnVj
dCBzb2NrCiAgICAgICAgICAgICAgICAgICAgICAqbWV0YV9zaywgc3RydWN0IHNrX2J1ZmYgKnNr
Yik8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoHs8YnIgY2xhc3M9IiI+CiAg
ICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5jb25zdAogICAgICAgICAgICAgICAgICAgICAgc3Ry
dWN0IG1wdGNwX2NiICptcGNiID0gdGNwX3NrKG1ldGFfc2spLSZndDttcGNiOzxicgogICAgICAg
ICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnN0
cnVjdAogICAgICAgICAgICAgICAgICAgICAgc29jayAqY2hpbGQsICpyc2sgPSBOVUxMOzxiciBj
bGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmludAogICAgICAgICAgICAgICAg
ICAgICAgcmV0OzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAg
ICAgICAgICAgICAgICAgICAgICghKFRDUF9TS0JfQ0Ioc2tiKS0mZ3Q7bXB0Y3BfZmxhZ3MgJmFt
cDsKICAgICAgICAgICAgICAgICAgICAgIE1QVENQSERSX0pPSU4pKSB7PGJyIGNsYXNzPSIiPgog
ICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c3RydWN0CiAgICAgICAgICAgICAgICAgICAg
ICB0Y3BoZHIgKnRoID0gdGNwX2hkcihza2IpOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAg
ICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPmNvbnN0CiAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgaXBoZHIg
KmlwaCA9IGlwX2hkcihza2IpOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPnN0cnVjdAogICAgICAgICAgICAgICAgICAgICAgc29jayAqc2s7PGJyIGNsYXNzPSIi
PgogICAgICAgICAgICAgICAgICAgICAgLTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAg
ICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPnNrCiAgICAgICAgICAgICAgICAgICAgICA9IGluZXRfbG9va3VwX2VzdGFi
bGlzaGVkKHNvY2tfbmV0KG1ldGFfc2spLAogICAgICAgICAgICAgICAgICAgICAgJmFtcDt0Y3Bf
aGFzaGluZm8sPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgICCgoKCgaXBoLSZndDtzYWRkciwgdGgtJmd0
O3NvdXJjZSwgaXBoLSZndDtkYWRkciw8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9
IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4KICAgICAgICAg
ICAgICAgICAgICAgIKCgoKB0aC0mZ3Q7ZGVzdCwgaW5ldF9paWYoc2tiKSk7PGJyIGNsYXNzPSIi
PgogICAgICAgICAgICAgICAgICAgICAgLTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAg
ICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPmlmCiAgICAgICAgICAgICAgICAgICAgICAoIXNrKSB7PGJyIGNsYXNzPSIi
PgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmtmcmVlX3NrYihza2IpOzxicgog
ICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj5yZXR1cm4KICAgICAgICAgICAgICAgICAgICAgIDA7PGJyIGNsYXNzPSIiPgog
ICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+fTxicgogICAgICAgICAgICAgICAgICAgICAg
ICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmCiAgICAgICAgICAg
ICAgICAgICAgICAoaXNfbWV0YV9zayhzaykpIHs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAg
ICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+V0FSTigiJXMKICAgICAgICAgICAgICAgICAgICAgIERpZCBu
b3QgZmluZCBhIHN1Yi1zayAtIGRpZCBmb3VuZCB0aGUgbWV0YSFcbiIsCiAgICAgICAgICAgICAg
ICAgICAgICBfX2Z1bmNfXyk7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPmtmcmVlX3NrYihza2IpOzxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFz
cz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5zb2NrX3B1dChzayk7PGJy
CiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPnJldHVybgogICAgICAgICAgICAgICAgICAgICAgMDs8YnIgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj59PGJyCiAgICAgICAgICAgICAgICAgICAg
ICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxiciBjbGFzcz0iIj4KICAgICAg
ICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmCiAgICAgICAgICAgICAgICAgICAgICAoc2stJmd0
O3NrX3N0YXRlID09IFRDUF9USU1FX1dBSVQpIHs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAg
ICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aW5ldF90d3NrX3B1dChpbmV0X3R3c2soc2spKTs8YnIKICAg
ICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+a2ZyZWVfc2tiKHNrYik7PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNz
PSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnJldHVybgogICAgICAgICAg
ICAgICAgICAgICAgMDs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj59PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAg
ICAgICAgLTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnJldAog
ICAgICAgICAgICAgICAgICAgICAgPSB0Y3BfdjRfZG9fcmN2KHNrLCBza2IpOzxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnNvY2tfcHV0KHNrKTs8YnIKICAgICAg
ICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPGJyIGNs
YXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cmV0dXJuCiAgICAgICAgICAg
ICAgICAgICAgICByZXQ7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj59
PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAg
ICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj5UQ1BfU0tCX0NCKHNrYiktJmd0O21wdGNwX2ZsYWdzCiAgICAgICAgICAgICAgICAg
ICAgICA9IDA7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPi8qCiAgICAgICAgICAgICAgICAgICAgICBI
YXMgYmVlbiByZW1vdmVkIGZyb20gdGhlIHRrLXRhYmxlLiBUaHVzLCBubyBuZXcKICAgICAgICAg
ICAgICAgICAgICAgIHN1YmZsb3dzLjxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAg
IKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAgKjxiciBjbGFzcz0iIj4KICAgICAgICAgICAg
ICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAgKiBDaGVjayBmb3IgY2xvc2Ut
c3RhdGUgaXMgbmVjZXNzYXJ5LCBiZWNhdXNlIHdlCiAgICAgICAgICAgICAgICAgICAgICBtYXkg
aGF2ZSBiZWVuIGNsb3NlZDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIGRpZmYg
LS1naXQgYS9uZXQvbXB0Y3AvbXB0Y3BfaXB2Ni5jCiAgICAgICAgICAgICAgICAgICAgICBiL25l
dC9tcHRjcC9tcHRjcF9pcHY2LmM8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICBp
bmRleCAwZGU5NTNkLi4xOTU5ZDAxIDEwMDY0NDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAg
ICAgICAgIC0tLSBhL25ldC9tcHRjcC9tcHRjcF9pcHY2LmM8YnIgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICArKysgYi9uZXQvbXB0Y3AvbXB0Y3BfaXB2Ni5jPGJyIGNsYXNzPSIiPgog
ICAgICAgICAgICAgICAgICAgICAgQEAgLTE5OSw3ICsxOTksNyBAQCBpbnQgbXB0Y3BfdjZfZG9f
cmN2KHN0cnVjdAogICAgICAgICAgICAgICAgICAgICAgc29jayAqbWV0YV9zaywgc3RydWN0IHNr
X2J1ZmYgKnNrYik8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5zdHJ1
Y3QKICAgICAgICAgICAgICAgICAgICAgIHNvY2sgKmNoaWxkLCAqcnNrID0gTlVMTDs8YnIgY2xh
c3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pbnQKICAgICAgICAgICAgICAgICAg
ICAgIHJldDs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmCiAgICAg
ICAgICAgICAgICAgICAgICAoIShUQ1BfU0tCX0NCKHNrYiktJmd0O21wdGNwX2ZsYWdzICZhbXA7
CiAgICAgICAgICAgICAgICAgICAgICBNUFRDUEhEUl9KT0lOKSkgezxiciBjbGFzcz0iIj4KICAg
ICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAgICAgICAgICghKHNrYi0m
Z3Q7bXB0Y3BfZmxhZ3MgJmFtcDsgTVBUQ1BIRFJfSk9JTikpIHs8YnIKICAgICAgICAgICAgICAg
ICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c3RydWN0
CiAgICAgICAgICAgICAgICAgICAgICB0Y3BoZHIgKnRoID0gdGNwX2hkcihza2IpOzxiciBjbGFz
cz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5jb25zdAogICAgICAgICAgICAg
ICAgICAgICAgc3RydWN0IGlwdjZoZHIgKmlwNmggPSBpcHY2X2hkcihza2IpOzxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5zdHJ1Y3QKICAgICAgICAgICAgICAg
ICAgICAgIHNvY2sgKnNrOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIEBAIC0y
MzIsNyArMjMyLDcgQEAgaW50IG1wdGNwX3Y2X2RvX3JjdihzdHJ1Y3QKICAgICAgICAgICAgICAg
ICAgICAgIHNvY2sgKm1ldGFfc2ssIHN0cnVjdCBza19idWZmICpza2IpPGJyIGNsYXNzPSIiPgog
ICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnJldHVybgogICAgICAgICAgICAgICAgICAg
ICAgcmV0OzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPn08YnIKICAg
ICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PlRDUF9TS0JfQ0Ioc2tiKS0mZ3Q7bXB0Y3BfZmxhZ3MKICAgICAgICAgICAgICAgICAgICAgID0g
MDs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnNrYi0mZ3Q7bXB0Y3Bf
ZmxhZ3MKICAgICAgICAgICAgICAgICAgICAgID0gMDs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAg
ICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj4vKgogICAgICAgICAgICAgICAgICAgICAgSGFzIGJlZW4gcmVtb3Zl
ZCBmcm9tIHRoZSB0ay10YWJsZS4gVGh1cywgbm8gbmV3CiAgICAgICAgICAgICAgICAgICAgICBz
dWJmbG93cy48YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4KICAgICAg
ICAgICAgICAgICAgICAgICo8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICBkaWZm
IC0tZ2l0IGEvbmV0L21wdGNwL21wdGNwX291dHB1dC5jCiAgICAgICAgICAgICAgICAgICAgICBi
L25ldC9tcHRjcC9tcHRjcF9vdXRwdXQuYzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAg
ICAgIGluZGV4IDY5MWVmNmYuLmU3ZDM0MGQgMTAwNjQ0PGJyIGNsYXNzPSIiPgogICAgICAgICAg
ICAgICAgICAgICAgLS0tIGEvbmV0L21wdGNwL21wdGNwX291dHB1dC5jPGJyIGNsYXNzPSIiPgog
ICAgICAgICAgICAgICAgICAgICAgKysrIGIvbmV0L21wdGNwL21wdGNwX291dHB1dC5jPGJyIGNs
YXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgQEAgLTU5LDM5ICs1OSwxNyBAQAogICAgICAg
ICAgICAgICAgICAgICAgRVhQT1JUX1NZTUJPTChtcHRjcF9zdWJfbGVuX3JlbW92ZV9hZGRyX2Fs
aWduKTs8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAg
ICAgICAgICCgoKAqLzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgc3RhdGlj
IGJvb2wgbXB0Y3BfcmVjb25zdHJ1Y3RfbWFwcGluZyhzdHJ1Y3QKICAgICAgICAgICAgICAgICAg
ICAgIHNrX2J1ZmYgKnNrYik8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoHs8
YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmNvbnN0CiAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3QgbXBfZHNzICptcGRzcyA9IChzdHJ1Y3QgbXBfZHNzCiAgICAgICAg
ICAgICAgICAgICAgICAqKVRDUF9TS0JfQ0Ioc2tiKS0mZ3Q7ZHNzOzxiciBjbGFzcz0iIj4KICAg
ICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+dTMyCiAgICAgICAgICAgICAgICAgICAgICAqcDMyOzxi
ciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+dTE2CiAgICAgICAgICAgICAg
ICAgICAgICAqcDE2OzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08YnIgY2xh
c3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pZgogICAgICAgICAgICAgICAgICAg
ICAgKCFtcHRjcF9pc19kYXRhX3NlcShza2IpKTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAg
ICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj5yZXR1cm4KICAgICAgICAgICAgICAgICAgICAgIGZhbHNlOzxiciBj
bGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAgICAg
ICAgICghbXBkc3MtJmd0O00pPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+cmV0dXJuCiAgICAgICAgICAgICAgICAgICAgICBmYWxzZTs8YnIgY2xhc3M9IiI+CiAg
ICAgICAgICAgICAgICAgICAgICAtPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj4vKgogICAgICAgICAgICAgICAgICAgICAgTW92ZSB0aGUgcG9pbnRlciB0byB0aGUgZGF0
YS1zZXEgKi88YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnAzMgogICAg
ICAgICAgICAgICAgICAgICAgPSAodTMyICopbXBkc3M7PGJyIGNsYXNzPSIiPgogICAgICAgICAg
ICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj5wMzIrKzs8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9
IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmCiAgICAgICAgICAgICAgICAgICAgICAo
bXBkc3MtJmd0O0EpIHs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj5wMzIrKzs8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAg
ICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj5pZgogICAgICAgICAgICAgICAgICAgICAgKG1wZHNzLSZndDth
KTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5wMzIrKzs8
YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAg
ICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPn08YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAg
ICAgICAgICAgICAtPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5UQ1Bf
U0tCX0NCKHNrYiktJmd0O3NlcQogICAgICAgICAgICAgICAgICAgICAgPSBudG9obCgqcDMyKTs8
YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPGJyIGNsYXNzPSIiPgogICAgICAg
ICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj4vKgogICAgICAgICAgICAgICAgICAgICAgR2V0IHRoZSBkYXRh
X2xlbiB0byBjYWxjdWxhdGUgdGhlIGVuZF9kYXRhX3NlcSAqLzxicgogICAgICAgICAgICAgICAg
ICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cDMyKys7PGJyCiAg
ICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj5wMzIrKzs8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAg
ICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPnAxNgogICAgICAgICAgICAgICAgICAgICAgPSAodTE2ICopcDMyOzxi
ciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+VENQX1NLQl9DQihza2IpLSZn
dDtlbmRfc2VxCiAgICAgICAgICAgICAgICAgICAgICA9IG50b2hzKCpwMTYpICsgVENQX1NLQl9D
Qihza2IpLSZndDtzZXE7PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAg
ICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5UQ1BfU0tCX0NCKHNrYiktJmd0O3NlcQogICAgICAgICAg
ICAgICAgICAgICAgPSBUQ1BfU0tCX0NCKHNrYiktJmd0O21wdGNwX2RhdGFfc2VxOzxiciBjbGFz
cz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnJldHVybgogICAgICAgICAgICAgICAg
ICAgICAgdHJ1ZTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoH08YnIgY2xh
c3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoHN0YXRpYyBib29sIG1wdGNwX2lzX3JlaW5q
ZWN0ZWQoY29uc3Qgc3RydWN0CiAgICAgICAgICAgICAgICAgICAgICBza19idWZmICpza2IpPGJy
IGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKB7PGJyIGNsYXNzPSIiPgogICAgICAg
ICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj5yZXR1cm4KICAgICAgICAgICAgICAgICAgICAgIFRDUF9TS0Jf
Q0Ioc2tiKS0mZ3Q7bXB0Y3BfZmxhZ3MgJmFtcDsKICAgICAgICAgICAgICAgICAgICAgIE1QVENQ
X1JFSU5KRUNUOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cmV0dXJu
CiAgICAgICAgICAgICAgICAgICAgICBza2ItJmd0O21wdGNwX2ZsYWdzICZhbXA7IE1QVENQX1JF
SU5KRUNUOzxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAg
ICAgICAgICAgIKCgfTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgc3RhdGlj
IHZvaWQgbXB0Y3BfZmluZF9hbmRfc2V0X3BhdGhtYXNrKGNvbnN0CiAgICAgICAgICAgICAgICAg
ICAgICBzdHJ1Y3Qgc29jayAqbWV0YV9zaywgc3RydWN0IHNrX2J1ZmYgKnNrYik8YnIKICAgICAg
ICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICBAQCAtMTA1
LDcgKzgzLDcgQEAgc3RhdGljIHZvaWQKICAgICAgICAgICAgICAgICAgICAgIG1wdGNwX2ZpbmRf
YW5kX3NldF9wYXRobWFzayhjb25zdCBzdHJ1Y3Qgc29jawogICAgICAgICAgICAgICAgICAgICAg
Km1ldGFfc2ssIHN0cnVjdCBza19idTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAg
IKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+YnJlYWs7PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIi
PgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmCiAgICAgICAgICAgICAgICAgICAg
ICAoVENQX1NLQl9DQihza2JfaXQpLSZndDtzZXEgPT0KICAgICAgICAgICAgICAgICAgICAgIFRD
UF9TS0JfQ0Ioc2tiKS0mZ3Q7c2VxKSB7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAg
ICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPlRDUF9TS0JfQ0Ioc2tiKS0mZ3Q7cGF0aF9tYXNrCiAgICAgICAgICAg
ICAgICAgICAgICA9IFRDUF9TS0JfQ0Ioc2tiX2l0KS0mZ3Q7cGF0aF9tYXNrOzxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5UQ1BfU0tCX0NCKHNrYiktJmd0
O21wdGNwX3BhdGhfbWFzawogICAgICAgICAgICAgICAgICAgICAgPSBUQ1BfU0tCX0NCKHNrYl9p
dCktJmd0O21wdGNwX3BhdGhfbWFzazs8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9
IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmJyZWFrOzxicgogICAgICAg
ICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj59PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAg
ICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+fTxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAg
ICAgICAgICAgICAgICAgIEBAIC0xODAsOSArMTU4LDkgQEAgc3RhdGljIHZvaWQKICAgICAgICAg
ICAgICAgICAgICAgIF9fbXB0Y3BfcmVpbmplY3RfZGF0YShzdHJ1Y3Qgc2tfYnVmZiAqb3JpZ19z
a2IsCiAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgc29jayAqbWV0YV9zazxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPn08YnIKICAgICAgICAgICAgICAgICAgICAg
ICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4vKgogICAgICAgICAgICAg
ICAgICAgICAgU2VnbWVudCBnb2VzIGJhY2sgdG8gdGhlIE1QVENQLWxheWVyLiBTbywgd2UgbmVl
ZAogICAgICAgICAgICAgICAgICAgICAgdG8gemVybyB0aGU8YnIgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAgKiBwYXRoX21hc2svZHNz
LjxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+CiAgICAgICAgICAgICAg
ICAgICAgICAqIHBhdGhfbWFzay48YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCg
oDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj4KICAgICAgICAgICAgICAgICAgICAgICovPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAg
ICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj5tZW1zZXQoVENQX1NLQl9DQihza2IpLSZndDtkc3MsCiAgICAgICAgICAg
ICAgICAgICAgICAwICwgbXB0Y3BfZHNzX2xlbik7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAg
ICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj5UQ1BfU0tCX0NCKHNrYiktJmd0O21wdGNwX3BhdGhfbWFzawogICAgICAg
ICAgICAgICAgICAgICAgPSAwOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCg
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPi8qCiAgICAgICAgICAgICAgICAgICAgICBXZSBuZWVkIHRvIGZpbmQgb3V0IHRoZSBwYXRo
LW1hc2sgZnJvbSB0aGUKICAgICAgICAgICAgICAgICAgICAgIG1ldGEtd3JpdGUtcXVldWU8YnIg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4KICAgICAgICAgICAgICAgICAg
ICAgICogdG8gcHJvcGVybHkgc2VsZWN0IGEgc3ViZmxvdy48YnIgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICBAQCAtMjcyLDE0ICsyNTAsMTQgQEAgdm9pZAogICAgICAgICAgICAgICAg
ICAgICAgbXB0Y3BfcmVpbmplY3RfZGF0YShzdHJ1Y3Qgc29jayAqc2ssIGludCBjbG9uZV9pdCk8
YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAg
ICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAgICAgICAgIChtcHRjcF9pc19yZWluamVjdGVk
KHNrYl9pdCkpPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj5jb250aW51ZTs8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj50Y2ItJmd0O21wdGNwX2ZsYWdzCiAgICAgICAgICAgICAg
ICAgICAgICB8PSBNUFRDUF9SRUlOSkVDVDs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAg
ICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj5za2JfaXQtJmd0O21wdGNwX2ZsYWdzCiAgICAgICAgICAgICAgICAgICAg
ICB8PSBNUFRDUF9SRUlOSkVDVDs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCg
oDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+X19tcHRjcF9yZWluamVjdF9kYXRhKHNrYl9pdCwKICAgICAgICAgICAgICAgICAg
ICAgIG1ldGFfc2ssIHNrLCBjbG9uZV9pdCk7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAg
ICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+fTxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAg
ICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPnNrYl9pdAogICAgICAgICAgICAgICAgICAgICAgPSB0Y3Bf
d3JpdGVfcXVldWVfdGFpbChtZXRhX3NrKTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAg
ICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj4vKgogICAgICAgICAgICAgICAgICAgICAgSWYgc2sgaGFzIHNlbnQgdGhlIGVt
cHR5IGRhdGEtZmluLCB3ZSBoYXZlIHRvCiAgICAgICAgICAgICAgICAgICAgICByZWluamVjdCBp
dCB0b28uICovPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAg
ICAgICAgICAgICAgICAgICAgIChza2JfaXQgJmFtcDsmYW1wOyBtcHRjcF9pc19kYXRhX2Zpbihz
a2JfaXQpCiAgICAgICAgICAgICAgICAgICAgICAmYW1wOyZhbXA7IHNrYl9pdC0mZ3Q7bGVuID09
IDAgJmFtcDsmYW1wOzxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAg
ICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgICCgoKBUQ1BfU0tCX0NC
KHNrYl9pdCktJmd0O3BhdGhfbWFzayAmYW1wOwogICAgICAgICAgICAgICAgICAgICAgbXB0Y3Bf
cGlfdG9fZmxhZyh0cC0mZ3Q7bXB0Y3AtJmd0O3BhdGhfaW5kZXgpKSB7PGJyCiAgICAgICAgICAg
ICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4KICAgICAg
ICAgICAgICAgICAgICAgIKCgoFRDUF9TS0JfQ0Ioc2tiX2l0KS0mZ3Q7bXB0Y3BfcGF0aF9tYXNr
ICZhbXA7CiAgICAgICAgICAgICAgICAgICAgICBtcHRjcF9waV90b19mbGFnKHRwLSZndDttcHRj
cC0mZ3Q7cGF0aF9pbmRleCkpIHs8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+X19tcHRjcF9yZWluamVjdF9kYXRhKHNr
Yl9pdCwKICAgICAgICAgICAgICAgICAgICAgIG1ldGFfc2ssIE5VTEwsIDEpOzxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPn08YnIKICAgICAgICAgICAgICAgICAgICAg
ICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICBAQCAtMzE5LDI1ICsyOTcsNDMgQEAg
Y29tYmluZTo8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj59PGJyCiAg
ICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKB9
PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLXN0YXRpYyBpbnQgbXB0Y3Bfd3Jp
dGVfZHNzX21hcHBpbmcoY29uc3Qgc3RydWN0CiAgICAgICAgICAgICAgICAgICAgICB0Y3Bfc29j
ayAqdHAsIGNvbnN0IHN0cnVjdCBza19idWZmICpza2IsPGJyCiAgICAgICAgICAgICAgICAgICAg
ICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4KICAg
ICAgICAgICAgICAgICAgICAgIKCgX19iZTMyICpwdHIpPGJyIGNsYXNzPSIiPgogICAgICAgICAg
ICAgICAgICAgICAgKy8qPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKyAqIFJG
QzY4MjQgc3RhdGVzIHRoYXQgb25jZSBhIHBhcnRpY3VsYXIgc3ViZmxvdwogICAgICAgICAgICAg
ICAgICAgICAgbWFwcGluZyBoYXMgYmVlbiBzZW50PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAg
ICAgICAgICAgKyAqIG91dCBpdCBtdXN0IG5ldmVyIGJlIGNoYW5nZWQuIEhvd2V2ZXIsIHBhY2tl
dHMKICAgICAgICAgICAgICAgICAgICAgIG1heSBiZSBzcGxpdCB3aGlsZTxiciBjbGFzcz0iIj4K
ICAgICAgICAgICAgICAgICAgICAgICsgKiB0aGV5IGFyZSBpbiB0aGUgcmV0cmFuc21pc3Npb24g
cXVldWUgKGR1ZSB0bwogICAgICAgICAgICAgICAgICAgICAgU0FDSyBvciBBQ0tzKSBhbmQgdGhh
dDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICsgKiBhcmd1YWJseSBtZWFucyB0
aGF0IHdlIHdvdWxkIGNoYW5nZSB0aGUKICAgICAgICAgICAgICAgICAgICAgIG1hcHBpbmcgKGUu
Zy4gaXQgc3BsaXRzIGl0LDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICsgKiBv
dXIgc2VuZHMgb3V0IGEgc3Vic2V0IG9mIHRoZSBpbml0aWFsCiAgICAgICAgICAgICAgICAgICAg
ICBtYXBwaW5nKS48YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArICo8YnIgY2xh
c3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArICogRnVydGhlcm1vcmUsIHRoZSBza2IgY2hl
Y2tzdW0gaXMgbm90IGFsd2F5cwogICAgICAgICAgICAgICAgICAgICAgcHJlc2VydmVkIGFjcm9z
cyBzcGxpdHM8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArICogKGUuZy4gbXB0
Y3BfZnJhZ21lbnQpIHdoaWNoIHdvdWxkIG1lYW4gdGhhdCB3ZQogICAgICAgICAgICAgICAgICAg
ICAgbmVlZCB0byByZWNvbXB1dGU8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAr
ICogdGhlIERTUyBjaGVja3N1bSBpbiB0aGlzIGNhc2UuPGJyIGNsYXNzPSIiPgogICAgICAgICAg
ICAgICAgICAgICAgKyAqPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKyAqIFRv
IGF2b2lkIHRoaXMgd2Ugc2F2ZSB0aGUgaW5pdGlhbCBEU1MgbWFwcGluZwogICAgICAgICAgICAg
ICAgICAgICAgd2hpY2ggYWxsb3dzIHVzIHRvPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAg
ICAgICAgKyAqIHNlbmQgdGhlIHNhbWUgRFNTIG1hcHBpbmcgZXZlbiBmb3IgZnJhZ21lbnRlZAog
ICAgICAgICAgICAgICAgICAgICAgcmV0cmFuc21pdHMuPGJyIGNsYXNzPSIiPgogICAgICAgICAg
ICAgICAgICAgICAgKyAqLzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8YnIg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArc3RhdGljIGludCBtcHRjcF93cml0ZV9k
c3NfbWFwcGluZyhjb25zdCBzdHJ1Y3QKICAgICAgICAgICAgICAgICAgICAgIHRjcF9zb2NrICp0
cCw8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArIKCgoGNvbnN0IHN0cnVjdCBz
a19idWZmICpza2IsIF9fYmUzMiAqcHRyKTxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFz
cz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgezxiciBjbGFzcz0iIj4KICAgICAgICAgICAg
ICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPmNvbnN0CiAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdGNwX3Nr
Yl9jYiAqdGNiID0gVENQX1NLQl9DQihza2IpOzxicgogICAgICAgICAgICAgICAgICAgICAgICBj
bGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+X19iZTMyCiAgICAgICAgICAgICAg
ICAgICAgICAqc3RhcnQgPSBwdHI7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
oKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+X191MTYKICAgICAgICAgICAgICAgICAgICAgIGRhdGFfbGVuOzxiciBjbGFzcz0iIj4K
ICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+KnB0cisrCiAgICAgICAgICAgICAgICAgICAgICA9
IGh0b25sKHRjYi0mZ3Q7c2VxKTsgLyogZGF0YV9zZXEgKi88YnIgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPipwdHIrKwogICAgICAgICAgICAgICAgICAgICAgPSBodG9ubCh0
Y2ItJmd0O21wdGNwX2RhdGFfc2VxKTsgLyogZGF0YV9zZXEgKi88YnIKICAgICAgICAgICAgICAg
ICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4vKgogICAgICAg
ICAgICAgICAgICAgICAgSWYgaXQncyBhIG5vbi1kYXRhIERBVEFfRklOLCB3ZSBzZXQgc3Vic2Vx
IHRvIDAKICAgICAgICAgICAgICAgICAgICAgIChkcmFmdCB2NykgKi88YnIgY2xhc3M9IiI+CiAg
ICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pZgogICAgICAgICAgICAgICAgICAgICAgKG1wdGNw
X2lzX2RhdGFfZmluKHNrYikgJmFtcDsmYW1wOyBza2ItJmd0O2xlbiA9PQogICAgICAgICAgICAg
ICAgICAgICAgMCk8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
KnB0cisrCiAgICAgICAgICAgICAgICAgICAgICA9IDA7IC8qIHN1YnNlcSAqLzxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmVsc2U8YnIKICAgICAgICAgICAgICAgICAg
ICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4qcHRyKysKICAg
ICAgICAgICAgICAgICAgICAgID0gaHRvbmwodHAtJmd0O3dyaXRlX3NlcSAtCiAgICAgICAgICAg
ICAgICAgICAgICB0cC0mZ3Q7bXB0Y3AtJmd0O3NudF9pc24pOyAvKiBzdWJzZXEgKi88YnIKICAg
ICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj4qcHRyKysKICAgICAgICAgICAgICAgICAgICAgID0gaHRvbmwodGNiLSZndDtzZXEgLSB0
cC0mZ3Q7bXB0Y3AtJmd0O3NudF9pc24pOwogICAgICAgICAgICAgICAgICAgICAgLyogc3Vic2Vx
ICovPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pZgogICAgICAgICAg
ICAgICAgICAgICAgKHRjYi0mZ3Q7bXB0Y3BfZmxhZ3MgJmFtcDsgTVBUQ1BIRFJfSU5GKTxicgog
ICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+aWYKICAgICAgICAgICAgICAgICAgICAgIChza2ItJmd0O21wdGNwX2ZsYWdzICZhbXA7IE1Q
VENQSERSX0lORik8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+ZGF0YV9sZW4KICAgICAgICAgICAgICAgICAgICAgID0g
MDs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmVsc2U8YnIKICAgICAg
ICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmVs
c2UKICAgICAgICAgICAgICAgICAgICAgIHs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAg
ICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+ZGF0YV9sZW4KICAgICAgICAgICAgICAgICAgICAgID0gdGNiLSZndDtl
bmRfc2VxIC0gdGNiLSZndDtzZXE7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
KzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+LyoKICAgICAgICAgICAgICAgICAgICAgIG1wdGNwX2VudGFpbF9za2IgYWRkcyBv
bmUgZm9yIEZJTiAqLzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PmlmCiAgICAgICAgICAgICAgICAgICAgICAodGNiLSZndDt0Y3BfZmxhZ3MgJmFtcDsgVENQSERS
X0ZJTik8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+ZGF0
YV9sZW4KICAgICAgICAgICAgICAgICAgICAgIC09IDE7PGJyIGNsYXNzPSIiPgogICAgICAgICAg
ICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj59PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgog
ICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAgICAgICAgICh0cC0m
Z3Q7bXBjYi0mZ3Q7ZHNzX2NzdW0gJmFtcDsmYW1wOyBkYXRhX2xlbikgezxicgogICAgICAgICAg
ICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5f
X2JlMTYKICAgICAgICAgICAgICAgICAgICAgICpwMTYgPSAoX19iZTE2ICopcHRyOzxiciBjbGFz
cz0iIj4KICAgICAgICAgICAgICAgICAgICAgIEBAIC0zNTYsMTEgKzM1MiwxMSBAQCBzdGF0aWMg
aW50CiAgICAgICAgICAgICAgICAgICAgICBtcHRjcF93cml0ZV9kc3NfbWFwcGluZyhjb25zdCBz
dHJ1Y3QgdGNwX3NvY2sgKnRwLAogICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IHNr
X2J1PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4KICAg
ICAgICAgICAgICAgICAgICAgIKCgoKCgoChUQ1BPUFRfTk9QKSk7PGJyIGNsYXNzPSIiPgogICAg
ICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+fTxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFz
cz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+cmV0dXJuCiAgICAgICAgICAgICAgICAg
ICAgICBwdHIgLSBzdGFydDs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PnJldHVybgogICAgICAgICAgICAgICAgICAgICAgbXB0Y3BfZHNzX2xlbi9zaXplb2YoKnB0cik7
PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKB9PGJyIGNsYXNzPSIiPgogICAg
ICAgICAgICAgICAgICAgICAgLXN0YXRpYyBpbnQgbXB0Y3Bfd3JpdGVfZHNzX2RhdGFfYWNrKGNv
bnN0IHN0cnVjdAogICAgICAgICAgICAgICAgICAgICAgdGNwX3NvY2sgKnRwLCBjb25zdCBzdHJ1
Y3Qgc2tfYnVmZiAqc2tiLDxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAg
ICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+CiAgICAgICAgICAgICAgICAgICAg
ICCgoKBfX2JlMzIgKnB0cik8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArc3Rh
dGljIGludCBtcHRjcF93cml0ZV9kc3NfZGF0YV9hY2soY29uc3Qgc3RydWN0CiAgICAgICAgICAg
ICAgICAgICAgICB0Y3Bfc29jayAqdHAsPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAg
ICAgKyCgoKBjb25zdCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBfX2JlMzIgKnB0cik8YnIKICAgICAg
ICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoHs8YnIg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5zdHJ1Y3QKICAgICAgICAgICAg
ICAgICAgICAgIG1wX2RzcyAqbWRzcyA9IChzdHJ1Y3QgbXBfZHNzICopcHRyOzxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPl9fYmUzMgogICAgICAgICAgICAgICAgICAg
ICAgKnN0YXJ0ID0gcHRyOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIEBAIC0z
NzcsNTQgKzM3MywxMiBAQCBzdGF0aWMgaW50CiAgICAgICAgICAgICAgICAgICAgICBtcHRjcF93
cml0ZV9kc3NfZGF0YV9hY2soY29uc3Qgc3RydWN0IHRjcF9zb2NrCiAgICAgICAgICAgICAgICAg
ICAgICAqdHAsIGNvbnN0IHN0cnVjdCBza19iPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAg
ICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+bWRzcy0mZ3Q7bGVuCiAgICAgICAgICAgICAgICAgICAgICA9IG1wdGNwX3N1
Yl9sZW5fZHNzKG1kc3MsCiAgICAgICAgICAgICAgICAgICAgICB0cC0mZ3Q7bXBjYi0mZ3Q7ZHNz
X2NzdW0pOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnB0cisrOzxi
cgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAg
ICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+LyoKICAgICAgICAgICAgICAgICAgICAgIGRhdGFfYWNrICovPGJyIGNsYXNzPSIiPgog
ICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+KnB0cisrCiAgICAgICAgICAgICAgICAgICAgICA9
IGh0b25sKG1wdGNwX21ldGFfdHAodHApLSZndDtyY3Zfbnh0KTs8YnIKICAgICAgICAgICAgICAg
ICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5yZXR1cm4KICAg
ICAgICAgICAgICAgICAgICAgIHB0ciAtIHN0YXJ0OzxiciBjbGFzcz0iIj4KICAgICAgICAgICAg
ICAgICAgICAgIKCgfTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC0vKiBSRkM2
ODI0IHN0YXRlcyB0aGF0IG9uY2UgYSBwYXJ0aWN1bGFyIHN1YmZsb3cKICAgICAgICAgICAgICAg
ICAgICAgIG1hcHBpbmcgaGFzIGJlZW4gc2VudDxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAg
ICAgICAgIC0gKiBvdXQgaXQgbXVzdCBuZXZlciBiZSBjaGFuZ2VkLiBIb3dldmVyLCBwYWNrZXRz
CiAgICAgICAgICAgICAgICAgICAgICBtYXkgYmUgc3BsaXQgd2hpbGU8YnIgY2xhc3M9IiI+CiAg
ICAgICAgICAgICAgICAgICAgICAtICogdGhleSBhcmUgaW4gdGhlIHJldHJhbnNtaXNzaW9uIHF1
ZXVlIChkdWUgdG8KICAgICAgICAgICAgICAgICAgICAgIFNBQ0sgb3IgQUNLcykgYW5kIHRoYXQ8
YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtICogYXJndWFibHkgbWVhbnMgdGhh
dCB3ZSB3b3VsZCBjaGFuZ2UgdGhlCiAgICAgICAgICAgICAgICAgICAgICBtYXBwaW5nIChlLmcu
IGl0IHNwbGl0cyBpdCw8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtICogb3Vy
IHNlbmRzIG91dCBhIHN1YnNldCBvZiB0aGUgaW5pdGlhbAogICAgICAgICAgICAgICAgICAgICAg
bWFwcGluZykuPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLSAqPGJyIGNsYXNz
PSIiPgogICAgICAgICAgICAgICAgICAgICAgLSAqIEZ1cnRoZXJtb3JlLCB0aGUgc2tiIGNoZWNr
c3VtIGlzIG5vdCBhbHdheXMKICAgICAgICAgICAgICAgICAgICAgIHByZXNlcnZlZCBhY3Jvc3Mg
c3BsaXRzPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLSAqIChlLmcuIG1wdGNw
X2ZyYWdtZW50KSB3aGljaCB3b3VsZCBtZWFuIHRoYXQgd2UKICAgICAgICAgICAgICAgICAgICAg
IG5lZWQgdG8gcmVjb21wdXRlPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLSAq
IHRoZSBEU1MgY2hlY2tzdW0gaW4gdGhpcyBjYXNlLjxiciBjbGFzcz0iIj4KICAgICAgICAgICAg
ICAgICAgICAgIC0gKjxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC0gKiBUbyBh
dm9pZCB0aGlzIHdlIHNhdmUgdGhlIGluaXRpYWwgRFNTIG1hcHBpbmcKICAgICAgICAgICAgICAg
ICAgICAgIHdoaWNoIGFsbG93cyB1cyB0bzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAg
ICAgIC0gKiBzZW5kIHRoZSBzYW1lIERTUyBtYXBwaW5nIGV2ZW4gZm9yIGZyYWdtZW50ZWQKICAg
ICAgICAgICAgICAgICAgICAgIHJldHJhbnNtaXRzLjxiciBjbGFzcz0iIj4KICAgICAgICAgICAg
ICAgICAgICAgIC0gKi88YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtc3RhdGlj
IHZvaWQgbXB0Y3Bfc2F2ZV9kc3NfZGF0YV9zZXEoY29uc3Qgc3RydWN0CiAgICAgICAgICAgICAg
ICAgICAgICB0Y3Bfc29jayAqdHAsIHN0cnVjdCBza19idWZmICpza2IpPGJyIGNsYXNzPSIiPgog
ICAgICAgICAgICAgICAgICAgICAgLXs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAg
ICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPnN0cnVjdAogICAgICAgICAgICAgICAgICAgICAgdGNwX3NrYl9jYiAqdGNiID0gVENQ
X1NLQl9DQihza2IpOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+X19i
ZTMyCiAgICAgICAgICAgICAgICAgICAgICAqcHRyID0gKF9fYmUzMiAqKXRjYi0mZ3Q7ZHNzOzxi
ciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08YnIgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPnRjYi0mZ3Q7bXB0Y3BfZmxhZ3MKICAgICAgICAgICAgICAgICAg
ICAgIHw9IE1QVENQSERSX1NFUTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAt
PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5wdHIKICAgICAgICAgICAg
ICAgICAgICAgICs9IG1wdGNwX3dyaXRlX2Rzc19kYXRhX2Fjayh0cCwgc2tiLCBwdHIpOzxicgog
ICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+cHRyCiAgICAgICAgICAgICAgICAgICAgICArPSBtcHRjcF93cml0ZV9kc3NfbWFwcGluZyh0
cCwgc2tiLCBwdHIpOzxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAg
ICAgICAgICAgICAgICAgIC19PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxi
ciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC0vKiBXcml0ZSB0aGUgc2F2ZWQgRFNT
IG1hcHBpbmcgdG8gdGhlIGhlYWRlciAqLzxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFz
cz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC1zdGF0aWMgaW50IG1wdGNwX3dyaXRlX2Rzc19k
YXRhX3NlcShjb25zdCBzdHJ1Y3QKICAgICAgICAgICAgICAgICAgICAgIHRjcF9zb2NrICp0cCwg
c3RydWN0IHNrX2J1ZmYgKnNrYiw8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAt
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAgoKCgX19iZTMyICpwdHIpPGJy
IGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLXs8YnIgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPl9fYmUzMgogICAgICAgICAgICAgICAgICAgICAgKnN0YXJ0ID0g
cHRyOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08YnIgY2xhc3M9IiI+CiAg
ICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPm1lbWNweShwdHIsCiAgICAgICAgICAgICAgICAgICAg
ICBUQ1BfU0tCX0NCKHNrYiktJmd0O2RzcywgbXB0Y3BfZHNzX2xlbik7PGJyCiAgICAgICAgICAg
ICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+LyoKICAgICAgICAgICAgICAgICAgICAgIHVw
ZGF0ZSB0aGUgZGF0YV9hY2sgKi88YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAt
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPnN0YXJ0WzFdCiAgICAgICAgICAgICAgICAgICAgICA9IGh0b25sKG1wdGNwX21ldGFfdHAo
dHApLSZndDtyY3Zfbnh0KTs8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAg
ICAgICAgICAgICAgICAgICAgICAtPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj4vKgogICAgICAgICAgICAgICAgICAgICAgZHNzIGlzIGluIGEgdW5pb24gd2l0aCBpbmV0
X3NrYl9wYXJtIGFuZDxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAg
ICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgICAqIHRoZSBJUCBsYXll
ciBleHBlY3RzIHplcm9lZCBJUENCIGZpZWxkcy48YnIKICAgICAgICAgICAgICAgICAgICAgICAg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPgogICAgICAgICAgICAgICAgICAg
ICAgKi88YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPm1lbXNldChUQ1Bf
U0tCX0NCKHNrYiktJmd0O2RzcywKICAgICAgICAgICAgICAgICAgICAgIDAgLCBtcHRjcF9kc3Nf
bGVuKTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPGJyIGNsYXNzPSIiPgog
ICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5yZXR1cm4KICAgICAgICAgICAgICAgICAgICAgIG1w
dGNwX2Rzc19sZW4vc2l6ZW9mKCpwdHIpOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAg
ICAgIC19PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxiciBjbGFzcz0iIj4K
ICAgICAgICAgICAgICAgICAgICAgIKCgc3RhdGljIGJvb2wgbXB0Y3Bfc2tiX2VudGFpbChzdHJ1
Y3Qgc29jayAqc2ssCiAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBp
bnQgcmVpbmplY3QpPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKB7PGJyIGNs
YXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c3RydWN0CiAgICAgICAgICAgICAg
ICAgICAgICB0Y3Bfc29jayAqdHAgPSB0Y3Bfc2soc2spOzxiciBjbGFzcz0iIj4KICAgICAgICAg
ICAgICAgICAgICAgIEBAIC00MzQsNyArMzg4LDcgQEAgc3RhdGljIGJvb2wKICAgICAgICAgICAg
ICAgICAgICAgIG1wdGNwX3NrYl9lbnRhaWwoc3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3Qgc2tfYnVm
ZgogICAgICAgICAgICAgICAgICAgICAgKnNrYiwgaW50IHJlaW5qZWN0KTxiciBjbGFzcz0iIj4K
ICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnN0cnVjdAogICAgICAgICAgICAgICAgICAgICAg
c2tfYnVmZiAqc3Vic2tiID0gTlVMTDs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAg
ICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj5pZgogICAgICAgICAgICAgICAgICAgICAgKCFyZWluamVjdCk8YnIgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5UQ1BfU0tCX0NCKHNrYiktJmd0O21wdGNw
X2ZsYWdzCiAgICAgICAgICAgICAgICAgICAgICB8PSAobXBjYi0mZ3Q7c25kX2hpc2VxX2luZGV4
ID88YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5za2ItJmd0O21w
dGNwX2ZsYWdzCiAgICAgICAgICAgICAgICAgICAgICB8PSAobXBjYi0mZ3Q7c25kX2hpc2VxX2lu
ZGV4ID88YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAgoE1QVENQSERSX1NFUTY0X0lOREVYIDog
MCk7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c3Vic2tiCiAgICAg
ICAgICAgICAgICAgICAgICA9IHBza2JfY29weV9mb3JfY2xvbmUoc2tiLCBHRlBfQVRPTUlDKTs8
YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAg
ICBAQCAtNDQ3LDcgKzQwMSw3IEBAIHN0YXRpYyBib29sCiAgICAgICAgICAgICAgICAgICAgICBt
cHRjcF9za2JfZW50YWlsKHN0cnVjdCBzb2NrICpzaywgc3RydWN0IHNrX2J1ZmYKICAgICAgICAg
ICAgICAgICAgICAgICpza2IsIGludCByZWluamVjdCk8YnIgY2xhc3M9IiI+CiAgICAgICAgICAg
ICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICAgICovPGJyIGNsYXNzPSIiPgog
ICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+dGNwX3NrYl9wY291bnRfc2V0KHN1YnNrYiwKICAg
ICAgICAgICAgICAgICAgICAgIDApOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAg
IC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+VENQX1NLQl9DQihza2IpLSZndDtwYXRoX21hc2sKICAgICAgICAgICAgICAgICAgICAg
IHw9IG1wdGNwX3BpX3RvX2ZsYWcodHAtJmd0O21wdGNwLSZndDtwYXRoX2luZGV4KTs8YnIKICAg
ICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PlRDUF9TS0JfQ0Ioc2tiKS0mZ3Q7bXB0Y3BfcGF0aF9tYXNrCiAgICAgICAgICAgICAgICAgICAg
ICB8PSBtcHRjcF9waV90b19mbGFnKHRwLSZndDttcHRjcC0mZ3Q7cGF0aF9pbmRleCk7PGJyCiAg
ICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+aWYKICAgICAgICAgICAgICAgICAgICAgICghKHNrLSZndDtza19yb3V0ZV9jYXBzICZhbXA7
IE5FVElGX0ZfQUxMX0NTVU0pCiAgICAgICAgICAgICAgICAgICAgICAmYW1wOyZhbXA7PGJyIGNs
YXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+CiAgICAgICAgICAgICAgICAgICAg
ICCgoKBza2ItJmd0O2lwX3N1bW1lZCA9PSBDSEVDS1NVTV9QQVJUSUFMKSB7PGJyCiAgICAgICAg
ICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgQEAgLTQ2Mywx
MyArNDE3LDE0IEBAIHN0YXRpYyBib29sCiAgICAgICAgICAgICAgICAgICAgICBtcHRjcF9za2Jf
ZW50YWlsKHN0cnVjdCBzb2NrICpzaywgc3RydWN0IHNrX2J1ZmYKICAgICAgICAgICAgICAgICAg
ICAgICpza2IsIGludCByZWluamVjdCk8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAg
ICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+dHAtJmd0O21wdGNwLSZndDtmdWxseV9lc3RhYmxpc2hlZAogICAgICAgICAg
ICAgICAgICAgICAgPSAxOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj50cC0mZ3Q7bXBjYi0mZ3Q7aW5maW5pdGVfbWFwcGluZ19zbmQKICAgICAgICAgICAgICAg
ICAgICAgID0gMTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
dHAtJmd0O21wdGNwLSZndDtpbmZpbml0ZV9jdXRvZmZfc2VxCiAgICAgICAgICAgICAgICAgICAg
ICA9IHRwLSZndDt3cml0ZV9zZXE7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
LTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+dGNiLSZndDttcHRjcF9mbGFncwogICAgICAgICAgICAgICAgICAgICAgfD0gTVBU
Q1BIRFJfSU5GOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnNr
Yi0mZ3Q7bXB0Y3BfZmxhZ3MKICAgICAgICAgICAgICAgICAgICAgIHw9IE1QVENQSERSX0lORjs8
YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj59PGJyCiAgICAgICAgICAg
ICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAg
ICAgICAgICAgICAgICAgICAgIChtcHRjcF9pc19kYXRhX2ZpbihzdWJza2IpKTxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5tcHRjcF9jb21iaW5lX2RmaW4oc3Vi
c2tiLAogICAgICAgICAgICAgICAgICAgICAgbWV0YV9zaywgc2spOzxiciBjbGFzcz0iIj4KICAg
ICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+bXB0Y3Bfc2F2ZV9kc3NfZGF0YV9zZXEodHAsCiAgICAg
ICAgICAgICAgICAgICAgICBzdWJza2IpOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAg
ICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+c3Vic2tiLSZndDttcHRjcF9mbGFncwogICAgICAgICAgICAgICAgICAgICAgfD0g
TVBUQ1BIRFJfU0VROzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+dGNi
LSZndDttcHRjcF9kYXRhX3NlcQogICAgICAgICAgICAgICAgICAgICAgPSB0Y2ItJmd0O3NlcTs8
YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj50Y2ItJmd0O3NlcQogICAg
ICAgICAgICAgICAgICAgICAgPSB0cC0mZ3Q7d3JpdGVfc2VxOzxiciBjbGFzcz0iIj4KICAgICAg
ICAgICAgICAgICAgICAgIEBAIC01MzYsMTAgKzQ5MSwxMCBAQCBzdGF0aWMgaW50CiAgICAgICAg
ICAgICAgICAgICAgICBtcHRjcF9mcmFnbWVudChzdHJ1Y3Qgc29jayAqbWV0YV9zaywgc3RydWN0
CiAgICAgICAgICAgICAgICAgICAgICBza19idWZmICpza2IsIHUzMiBsZW4sPGJyIGNsYXNzPSIi
PgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+YnVmZgogICAgICAgICAgICAgICAgICAgICAg
PSBza2ItJmd0O25leHQ7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5m
bGFncwogICAgICAgICAgICAgICAgICAgICAgPSBUQ1BfU0tCX0NCKHNrYiktJmd0O21wdGNwX2Zs
YWdzOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+VENQX1NLQl9DQihz
a2IpLSZndDttcHRjcF9mbGFncwogICAgICAgICAgICAgICAgICAgICAgPSBmbGFncyAmYW1wOyB+
KE1QVENQSERSX0ZJTik7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5U
Q1BfU0tCX0NCKGJ1ZmYpLSZndDttcHRjcF9mbGFncwogICAgICAgICAgICAgICAgICAgICAgPSBm
bGFnczs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPlRDUF9TS0JfQ0Io
YnVmZiktJmd0O3BhdGhfbWFzawogICAgICAgICAgICAgICAgICAgICAgPSBUQ1BfU0tCX0NCKHNr
YiktJmd0O3BhdGhfbWFzazs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PmZsYWdzCiAgICAgICAgICAgICAgICAgICAgICA9IHNrYi0mZ3Q7bXB0Y3BfZmxhZ3M7PGJyIGNs
YXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5za2ItJmd0O21wdGNwX2ZsYWdzCiAg
ICAgICAgICAgICAgICAgICAgICA9IGZsYWdzICZhbXA7IH4oTVBUQ1BIRFJfRklOKTs8YnIgY2xh
c3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmJ1ZmYtJmd0O21wdGNwX2ZsYWdzCiAg
ICAgICAgICAgICAgICAgICAgICA9IGZsYWdzOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAg
ICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+VENQX1NLQl9DQihidWZmKS0mZ3Q7bXB0Y3BfcGF0aF9tYXNrCiAgICAgICAg
ICAgICAgICAgICAgICA9IFRDUF9TS0JfQ0Ioc2tiKS0mZ3Q7bXB0Y3BfcGF0aF9tYXNrOzxiciBj
bGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPi8qCiAgICAgICAgICAgICAgICAg
ICAgICBJZiByZWluamVjdCA9PSAxLCB0aGUgYnVmZiB3aWxsIGJlIGFkZGVkIHRvIHRoZQogICAg
ICAgICAgICAgICAgICAgICAgcmVpbmplY3Q8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAg
ICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICAgICogcXVldWUsIHdoaWNoIGlzIGN1cnJl
bnRseSBub3QgcGFydCBvZiBtZW1vcnkKICAgICAgICAgICAgICAgICAgICAgIGFjY291bnRpbmcu
IFNvPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgQEAgLTkyNyw4ICs4ODIsOSBA
QCB2b2lkCiAgICAgICAgICAgICAgICAgICAgICBtcHRjcF9lc3RhYmxpc2hlZF9vcHRpb25zKHN0
cnVjdCBzb2NrICpzaywgc3RydWN0CiAgICAgICAgICAgICAgICAgICAgICBza19idWZmICpza2Is
PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+CiAgICAgICAgICAgICAg
ICAgICAgICAqIEl0IGRvZXMgbm90IG1ha2Ugc2Vuc2UgdG8gY2hlY2sgZm9yIHRoZSBvcHRpb25z
LAogICAgICAgICAgICAgICAgICAgICAgYmVjYXVzZSB3aGVuIHRoZTxiciBjbGFzcz0iIj4KICAg
ICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAgKiBzZWdtZW50
IGdldHMgc2VudCwgYW5vdGhlciBzdWJmbG93IHdpbGwgYmUKICAgICAgICAgICAgICAgICAgICAg
IGNob3Nlbi48YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4KICAgICAg
ICAgICAgICAgICAgICAgICovPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj5pZgogICAgICAgICAgICAgICAgICAgICAgKCFza2IgJmFtcDsmYW1wOyBpc19tZXRhX3NrKHNr
KSk8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmCiAgICAgICAgICAg
ICAgICAgICAgICAoIXNrYiAmYW1wOyZhbXA7IGlzX21ldGFfc2soc2spKSB7PGJyIGNsYXNzPSIi
PgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnJldHVybjs8YnIKICAgICAgICAgICAg
ICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPn08YnIKICAg
ICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj4vKgogICAgICAgICAgICAgICAgICAgICAgSW4gZmFsbGJhY2sgbXBfZmFpbC1tb2RlLCB3ZSBo
YXZlIHRvIHJlcGVhdCBpdAogICAgICAgICAgICAgICAgICAgICAgdW50aWwgdGhlIGZhbGxiYWNr
PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+CiAgICAgICAgICAgICAg
ICAgICAgICAqIGhhcyBiZWVuIGRvbmUgYnkgdGhlIHNlbmRlcjxiciBjbGFzcz0iIj4KICAgICAg
ICAgICAgICAgICAgICAgIEBAIC05NjcsMTAgKzkyMywxMSBAQCB2b2lkCiAgICAgICAgICAgICAg
ICAgICAgICBtcHRjcF9lc3RhYmxpc2hlZF9vcHRpb25zKHN0cnVjdCBzb2NrICpzaywgc3RydWN0
CiAgICAgICAgICAgICAgICAgICAgICBza19idWZmICpza2IsPGJyIGNsYXNzPSIiPgogICAgICAg
ICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAgICAgICAgICh1bmxpa2VseSht
cGNiLSZndDtpbmZpbml0ZV9tYXBwaW5nX3NuZCkKICAgICAgICAgICAgICAgICAgICAgICZhbXA7
JmFtcDs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4KICAgICAgICAg
ICAgICAgICAgICAgIKCgoCgobXBjYi0mZ3Q7c2VuZF9pbmZpbml0ZV9tYXBwaW5nICZhbXA7JmFt
cDsgdGNiCiAgICAgICAgICAgICAgICAgICAgICAmYW1wOyZhbXA7PGJyIGNsYXNzPSIiPgogICAg
ICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgICCgoKCgoG1wdGNw
X2lzX2RhdGFfc2VxKHNrYikgJmFtcDsmYW1wOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAg
ICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgICCgoKCgoCEodGNiLSZndDttcHRjcF9m
bGFncyAmYW1wOyBNUFRDUEhEUl9JTkYpCiAgICAgICAgICAgICAgICAgICAgICAmYW1wOyZhbXA7
PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4KICAgICAgICAgICAgICAg
ICAgICAgIKCgoKCgIShza2ItJmd0O21wdGNwX2ZsYWdzICZhbXA7IE1QVENQSERSX0lORikKICAg
ICAgICAgICAgICAgICAgICAgICZhbXA7JmFtcDs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAg
ICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICAgIKCgoKCgIWJlZm9yZSh0Y2ItJmd0
O3NlcSwKICAgICAgICAgICAgICAgICAgICAgIHRwLSZndDttcHRjcC0mZ3Q7aW5maW5pdGVfY3V0
b2ZmX3NlcSkpIHx8PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAg
ICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICAgIKCgoKAhbXBjYi0mZ3Q7
c2VuZF9pbmZpbml0ZV9tYXBwaW5nKSk8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAg
ICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAgoKCgoCFtcGNiLSZndDtzZW5kX2luZmluaXRl
X21hcHBpbmcpKSB7PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAg
ICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnJldHVybjs8YnIKICAgICAgICAgICAgICAgICAgICAg
ICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPn08YnIKICAgICAgICAgICAg
ICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNz
PSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pZgogICAg
ICAgICAgICAgICAgICAgICAgKHVubGlrZWx5KHRwLSZndDttcHRjcC0mZ3Q7aW5jbHVkZV9tcGMp
KSB7PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAg
ICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPm9wdHMtJmd0O29wdGlvbnMKICAgICAgICAgICAgICAgICAgICAgIHw9
IE9QVElPTl9NUFRDUDs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICBAQCAtOTk1
LDkgKzk1MiwxMSBAQCB2b2lkCiAgICAgICAgICAgICAgICAgICAgICBtcHRjcF9lc3RhYmxpc2hl
ZF9vcHRpb25zKHN0cnVjdCBzb2NrICpzaywgc3RydWN0CiAgICAgICAgICAgICAgICAgICAgICBz
a19idWZmICpza2IsPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+CiAg
ICAgICAgICAgICAgICAgICAgICCgoKBtcGNiLSZndDttcHRjcF92ZXIgJmd0Oz0gTVBUQ1BfVkVS
U0lPTl8xCiAgICAgICAgICAgICAgICAgICAgICAmYW1wOyZhbXA7IHNrYiAmYW1wOyZhbXA7ICFt
cHRjcF9pc19kYXRhX3NlcShza2IpKQogICAgICAgICAgICAgICAgICAgICAgezxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5tcGNiLSZndDtwbV9vcHMtJmd0O2Fk
ZHJfc2lnbmFsKHNrLAogICAgICAgICAgICAgICAgICAgICAgc2l6ZSwgb3B0cywgc2tiKTs8YnIg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pZgogICAgICAgICAgICAg
ICAgICAgICAgKG9wdHMtJmd0O2FkZF9hZGRyX3Y2KTxiciBjbGFzcz0iIj4KICAgICAgICAgICAg
ICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPmlmCiAgICAgICAgICAgICAgICAgICAgICAob3B0cy0mZ3Q7YWRk
X2FkZHJfdjYpIHs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPGJyIGNsYXNz
PSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4vKgogICAgICAgICAgICAg
ICAgICAgICAgU2tpcCBzdWJzZXF1ZW50IG9wdGlvbnMgKi88YnIgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHls
ZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnJldHVybjs8YnIKICAgICAgICAgICAgICAgICAg
ICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj59PGJyCiAgICAg
ICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
fTxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAg
ICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJl
Ij4JPC9zcGFuPmlmCiAgICAgICAgICAgICAgICAgICAgICAoIXRwLSZndDttcHRjcC0mZ3Q7aW5j
bHVkZV9tcGMgJmFtcDsmYW1wOwogICAgICAgICAgICAgICAgICAgICAgIXRwLSZndDttcHRjcC0m
Z3Q7cHJlX2VzdGFibGlzaGVkKSB7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAg
QEAgLTExOTcsMTAgKzExNTYsMTEgQEAgdm9pZAogICAgICAgICAgICAgICAgICAgICAgbXB0Y3Bf
b3B0aW9uc193cml0ZShfX2JlMzIgKnB0ciwgc3RydWN0IHRjcF9zb2NrCiAgICAgICAgICAgICAg
ICAgICAgICAqdHAsPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+fTxi
cgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAg
IKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4J
PC9zcGFuPmlmCiAgICAgICAgICAgICAgICAgICAgICAoT1BUSU9OX0RBVEFfQUNLICZhbXA7IG9w
dHMtJmd0O21wdGNwX29wdGlvbnMpIHs8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9
IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pZgogICAgICAgICAgICAgICAgICAg
ICAgKCFtcHRjcF9pc19kYXRhX3NlcShza2IpKTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAg
ICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj5wdHIKICAgICAgICAgICAgICAgICAgICAgICs9IG1wdGNwX3dy
aXRlX2Rzc19kYXRhX2Fjayh0cCwgc2tiLCBwdHIpOzxicgogICAgICAgICAgICAgICAgICAgICAg
ICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmVsc2U8YnIKICAgICAg
ICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4g
Y2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+cHRyCiAgICAgICAgICAgICAgICAgICAgICArPSBtcHRjcF93cml0ZV9kc3NfZGF0YV9z
ZXEodHAsIHNrYiwgcHRyKTs8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAg
ICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5wdHIKICAgICAgICAgICAgICAgICAgICAgICs9
IG1wdGNwX3dyaXRlX2Rzc19kYXRhX2Fjayh0cCwgc2tiLCBwdHIpOzxicgogICAgICAgICAgICAg
ICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmCiAg
ICAgICAgICAgICAgICAgICAgICAobXB0Y3BfaXNfZGF0YV9zZXEoc2tiKSkgezxiciBjbGFzcz0i
Ij4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5wdHIKICAgICAgICAgICAgICAg
ICAgICAgICs9IG1wdGNwX3dyaXRlX2Rzc19tYXBwaW5nKHRwLCBza2IsIHB0cik7PGJyCiAgICAg
ICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+fTxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAg
ICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPnNrYi0mZ3Q7ZGV2CiAgICAgICAgICAgICAgICAgICAgICA9IE5VTEw7
PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+fTxicgogICAgICAgICAg
ICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmCiAg
ICAgICAgICAgICAgICAgICAgICAodW5saWtlbHkoT1BUSU9OX01QX1BSSU8gJmFtcDsKICAgICAg
ICAgICAgICAgICAgICAgIG9wdHMtJmd0O21wdGNwX29wdGlvbnMpKSB7PGJyIGNsYXNzPSIiPgog
ICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBz
dHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnN0cnVjdAogICAgICAgICAgICAgICAgICAg
ICAgbXBfcHJpbyAqbXBwcmlvID0gKHN0cnVjdCBtcF9wcmlvICopcHRyOzxicgogICAgICAgICAg
ICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIEBAIC0xMjMzLDcg
KzExOTMsNyBAQCB2b2lkIG1wdGNwX3NlbmRfZmluKHN0cnVjdAogICAgICAgICAgICAgICAgICAg
ICAgc29jayAqbWV0YV9zayk8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj5tc3Nfbm93CiAgICAgICAgICAgICAgICAgICAgICA9IG1wdGNwX2N1cnJlbnRfbXNzKG1ldGFf
c2spOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmCiAgICAgICAg
ICAgICAgICAgICAgICAodGNwX3NlbmRfaGVhZChtZXRhX3NrKSAhPSBOVUxMKSB7PGJyIGNsYXNz
PSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+VENQX1NLQl9DQihza2IpLSZndDtt
cHRjcF9mbGFncwogICAgICAgICAgICAgICAgICAgICAgfD0gTVBUQ1BIRFJfRklOOzxiciBjbGFz
cz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnNrYi0mZ3Q7bXB0Y3BfZmxhZ3MK
ICAgICAgICAgICAgICAgICAgICAgIHw9IE1QVENQSERSX0ZJTjs8YnIgY2xhc3M9IiI+CiAgICAg
ICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxl
PSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+VENQX1NLQl9DQihza2IpLSZndDtlbmRfc2VxKys7
PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAg
ICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPm1ldGFfdHAtJmd0O3dyaXRlX3NlcSsrOzxicgogICAgICAgICAgICAgICAg
ICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPn0KICAgICAgICAg
ICAgICAgICAgICAgIGVsc2UgezxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIEBA
IC0xMjUwLDcgKzEyMTAsNyBAQCB2b2lkIG1wdGNwX3NlbmRfZmluKHN0cnVjdAogICAgICAgICAg
ICAgICAgICAgICAgc29jayAqbWV0YV9zayk8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAg
ICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+dGNwX2luaXRfbm9uZGF0YV9za2Ioc2tiLAogICAgICAgICAgICAgICAg
ICAgICAgbWV0YV90cC0mZ3Q7d3JpdGVfc2VxLCBUQ1BIRFJfQUNLKTs8YnIgY2xhc3M9IiI+CiAg
ICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+VENQX1NLQl9DQihza2IpLSZndDtlbmRfc2Vx
Kys7PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAg
ICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+VENQX1NLQl9DQihza2IpLSZndDttcHRjcF9mbGFncwogICAgICAgICAg
ICAgICAgICAgICAgfD0gTVBUQ1BIRFJfRklOOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAg
ICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPnNrYi0mZ3Q7bXB0Y3BfZmxhZ3MKICAgICAgICAgICAgICAgICAgICAg
IHw9IE1QVENQSERSX0ZJTjs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxz
cGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bh
bj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8
L3NwYW4+dGNwX3F1ZXVlX3NrYihtZXRhX3NrLAogICAgICAgICAgICAgICAgICAgICAgc2tiKTs8
YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj59PGJyCiAgICAgICAgICAg
ICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+X190Y3Bf
cHVzaF9wZW5kaW5nX2ZyYW1lcyhtZXRhX3NrLAogICAgICAgICAgICAgICAgICAgICAgbXNzX25v
dywgVENQX05BR0xFX09GRik7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgZGlm
ZiAtLWdpdCBhL25ldC9tcHRjcC9tcHRjcF9yZWR1bmRhbnQuYwogICAgICAgICAgICAgICAgICAg
ICAgYi9uZXQvbXB0Y3AvbXB0Y3BfcmVkdW5kYW50LmM8YnIgY2xhc3M9IiI+CiAgICAgICAgICAg
ICAgICAgICAgICBpbmRleCA4ZmEyZGJhLi4zN2ExM2Y0IDEwMDY0NDxiciBjbGFzcz0iIj4KICAg
ICAgICAgICAgICAgICAgICAgIC0tLSBhL25ldC9tcHRjcC9tcHRjcF9yZWR1bmRhbnQuYzxiciBj
bGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICsrKyBiL25ldC9tcHRjcC9tcHRjcF9yZWR1
bmRhbnQuYzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIEBAIC03MiwxMCArNzIs
MTAgQEAgc3RhdGljIGJvb2wKICAgICAgICAgICAgICAgICAgICAgIHJlZHNjaGVkX3VzZV9zdWJm
bG93KHN0cnVjdCBzb2NrICptZXRhX3NrLDxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFz
cz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmCiAgICAgICAgICAgICAgICAgICAg
ICAoIXNrYiB8fCAhbXB0Y3BfaXNfYXZhaWxhYmxlKChzdHJ1Y3Qgc29jayAqKXRwLAogICAgICAg
ICAgICAgICAgICAgICAgc2tiLCBmYWxzZSkpPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAg
ICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPnJldHVybgogICAgICAgICAgICAgICAgICAgICAgZmFsc2U7PGJyIGNs
YXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pZgogICAgICAgICAgICAgICAgICAg
ICAgKFRDUF9TS0JfQ0Ioc2tiKS0mZ3Q7cGF0aF9tYXNrICE9IDApPGJyIGNsYXNzPSIiPgogICAg
ICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pZgogICAgICAgICAgICAgICAgICAgICAgKFRDUF9TS0Jf
Q0Ioc2tiKS0mZ3Q7bXB0Y3BfcGF0aF9tYXNrICE9IDApPGJyCiAgICAgICAgICAgICAgICAgICAg
ICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnJldHVybgogICAg
ICAgICAgICAgICAgICAgICAgc3ViZmxvd19pc19hY3RpdmUodHApOzxiciBjbGFzcz0iIj4KICAg
ICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAgICAgICAgIChUQ1BfU0tC
X0NCKHNrYiktJmd0O3BhdGhfbWFzayA9PSAwKSB7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAg
ICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CTwvc3Bhbj5pZgogICAgICAgICAgICAgICAgICAgICAgKFRDUF9TS0JfQ0Ioc2tiKS0m
Z3Q7bXB0Y3BfcGF0aF9tYXNrID09IDApIHs8YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xh
c3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAg
ICAgICAgIChhY3RpdmVfdmFsaWRfc2tzID09IC0xKTxiciBjbGFzcz0iIj4KICAgICAgICAgICAg
ICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+YWN0aXZlX3ZhbGlkX3NrcwogICAgICAgICAgICAgICAg
ICAgICAgPSByZWRzY2hlZF9nZXRfYWN0aXZlX3ZhbGlkX3NrcyhtZXRhX3NrKTs8YnIKICAgICAg
ICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICBAQCAtMjA5
LDcgKzIwOSw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZgogICAgICAgICAgICAgICAgICAgICAg
KnJlZHVuZGFudF9uZXh0X3NlZ21lbnQoc3RydWN0IHNvY2sgKm1ldGFfc2ssPGJyCiAgICAgICAg
ICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj5jYl9kYXRhLSZndDtuZXh0X3N1YmZsb3cKICAgICAgICAgICAgICAgICAgICAgID0gdHAt
Jmd0O21wdGNwLSZndDtuZXh0OzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCg
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+KnN1YnNrCiAgICAgICAgICAgICAgICAgICAgICA9IChzdHJ1Y3Qgc29jayAq
KXRwOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pZgog
ICAgICAgICAgICAgICAgICAgICAgKFRDUF9TS0JfQ0Ioc2tiKS0mZ3Q7cGF0aF9tYXNrKTxiciBj
bGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pZgogICAgICAgICAg
ICAgICAgICAgICAgKFRDUF9TS0JfQ0Ioc2tiKS0mZ3Q7bXB0Y3BfcGF0aF9tYXNrKTxiciBjbGFz
cz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUt
dGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFw
cGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPipyZWluamVjdAog
ICAgICAgICAgICAgICAgICAgICAgPSAtMTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAg
ICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPnJldHVybgogICAgICAgICAgICAgICAgICAgICAgc2tiOzxiciBj
bGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj59PGJyCiAgICAgICAgICAg
ICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgZGlmZiAtLWdpdCBh
L25ldC9tcHRjcC9tcHRjcF9yci5jCiAgICAgICAgICAgICAgICAgICAgICBiL25ldC9tcHRjcC9t
cHRjcF9yci5jPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgaW5kZXggODkxMGJh
OS4uODM4MzdmMiAxMDA2NDQ8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtLS0g
YS9uZXQvbXB0Y3AvbXB0Y3BfcnIuYzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAg
ICsrKyBiL25ldC9tcHRjcC9tcHRjcF9yci5jPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAg
ICAgICAgQEAgLTkzLDcgKzkzLDcgQEAgc3RhdGljIGludAogICAgICAgICAgICAgICAgICAgICAg
bXB0Y3BfcnJfZG9udF9yZWluamVjdF9za2IoY29uc3Qgc3RydWN0IHRjcF9zb2NrCiAgICAgICAg
ICAgICAgICAgICAgICAqdHAsIGNvbnN0IHN0cnVjdCBzazxiciBjbGFzcz0iIj4KICAgICAgICAg
ICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAgKi88YnIgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5yZXR1cm4KICAgICAgICAgICAgICAgICAgICAg
IHNrYiAmYW1wOyZhbXA7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPi8qCiAgICAgICAgICAgICAgICAgICAgICBIYXMgdGhlIHNrYiBhbHJlYWR5IGJlZW4gZW5x
dWV1ZWQgaW50byB0aGlzCiAgICAgICAgICAgICAgICAgICAgICBzdWJzb2NrZXQ/ICovPGJyIGNs
YXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3Bh
biIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+bXB0Y3BfcGlfdG9fZmxhZyh0
cC0mZ3Q7bXB0Y3AtJmd0O3BhdGhfaW5kZXgpCiAgICAgICAgICAgICAgICAgICAgICAmYW1wOyBU
Q1BfU0tCX0NCKHNrYiktJmd0O3BhdGhfbWFzazs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAg
ICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj5tcHRjcF9waV90b19mbGFnKHRwLSZndDttcHRjcC0mZ3Q7cGF0aF9p
bmRleCkKICAgICAgICAgICAgICAgICAgICAgICZhbXA7IFRDUF9TS0JfQ0Ioc2tiKS0mZ3Q7bXB0
Y3BfcGF0aF9tYXNrOzxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAg
ICAgICAgICAgICAgICAgIKCgfTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCg
LyogV2UganVzdCBsb29rIGZvciBhbnkgc3ViZmxvdyB0aGF0IGlzCiAgICAgICAgICAgICAgICAg
ICAgICBhdmFpbGFibGUgKi88YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICBAQCAt
MTM2LDcgKzEzNiw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc29jawogICAgICAgICAgICAgICAgICAgICAg
KnJyX2dldF9hdmFpbGFibGVfc3ViZmxvdyhzdHJ1Y3Qgc29jayAqbWV0YV9zayw8YnIKICAgICAg
ICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+CiAgICAgICAgICAgICAgICAgICAgICAqIGNoYW5jZSBhZ2FpbiBieSByZXN0YXJ0aW5nIGl0
cyBwYXRobWFzay48YnIKICAgICAgICAgICAgICAgICAgICAgICAgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRl
LXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgICAqLzxiciBjbGFz
cz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pZgogICAgICAgICAgICAgICAg
ICAgICAgKHNrYik8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICAtPHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+VENQX1NLQl9DQihza2IpLSZndDtwYXRoX21hc2sKICAgICAgICAgICAgICAgICAgICAgID0g
MDs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJB
cHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFz
cz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+VENQX1NL
Ql9DQihza2IpLSZndDttcHRjcF9wYXRoX21hc2sKICAgICAgICAgICAgICAgICAgICAgID0gMDs8
YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+c2sKICAgICAgICAg
ICAgICAgICAgICAgID0gYmFja3Vwc2s7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAg
ICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+fTxicgogICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAg
ICAgICAgICAgICAgIGRpZmYgLS1naXQgYS9uZXQvbXB0Y3AvbXB0Y3Bfc2NoZWQuYwogICAgICAg
ICAgICAgICAgICAgICAgYi9uZXQvbXB0Y3AvbXB0Y3Bfc2NoZWQuYzxiciBjbGFzcz0iIj4KICAg
ICAgICAgICAgICAgICAgICAgIGluZGV4IDU0NDA4ZmYuLjVjYmJmOTEgMTAwNjQ0PGJyIGNsYXNz
PSIiPgogICAgICAgICAgICAgICAgICAgICAgLS0tIGEvbmV0L21wdGNwL21wdGNwX3NjaGVkLmM8
YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArKysgYi9uZXQvbXB0Y3AvbXB0Y3Bf
c2NoZWQuYzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIEBAIC0xMTgsNyArMTE4
LDcgQEAgc3RhdGljIGludAogICAgICAgICAgICAgICAgICAgICAgbXB0Y3BfZG9udF9yZWluamVj
dF9za2IoY29uc3Qgc3RydWN0IHRjcF9zb2NrICp0cCwKICAgICAgICAgICAgICAgICAgICAgIGNv
bnN0IHN0cnVjdCBza19idTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNw
YW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PgogICAgICAgICAgICAgICAgICAgICAgKi88YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAg
ICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnBy
ZSI+CTwvc3Bhbj5yZXR1cm4KICAgICAgICAgICAgICAgICAgICAgIHNrYiAmYW1wOyZhbXA7PGJy
IGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFi
LXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxl
LXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPi8qCiAgICAgICAgICAg
ICAgICAgICAgICBIYXMgdGhlIHNrYiBhbHJlYWR5IGJlZW4gZW5xdWV1ZWQgaW50byB0aGlzCiAg
ICAgICAgICAgICAgICAgICAgICBzdWJzb2NrZXQ/ICovPGJyIGNsYXNzPSIiPgogICAgICAgICAg
ICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+bXB0Y3BfcGlfdG9fZmxhZyh0cC0mZ3Q7bXB0Y3AtJmd0O3Bh
dGhfaW5kZXgpCiAgICAgICAgICAgICAgICAgICAgICAmYW1wOyBUQ1BfU0tCX0NCKHNrYiktJmd0
O3BhdGhfbWFzazs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xh
c3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5t
cHRjcF9waV90b19mbGFnKHRwLSZndDttcHRjcC0mZ3Q7cGF0aF9pbmRleCkKICAgICAgICAgICAg
ICAgICAgICAgICZhbXA7IFRDUF9TS0JfQ0Ioc2tiKS0mZ3Q7bXB0Y3BfcGF0aF9tYXNrOzxicgog
ICAgICAgICAgICAgICAgICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCg
fTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgYm9vbCBzdWJmbG93X2lzX2Jh
Y2t1cChjb25zdCBzdHJ1Y3QgdGNwX3NvY2sKICAgICAgICAgICAgICAgICAgICAgICp0cCk8YnIg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICBAQCAtMjYxLDcgKzI2MSw3IEBAIHN0cnVj
dCBzb2NrCiAgICAgICAgICAgICAgICAgICAgICAqZ2V0X2F2YWlsYWJsZV9zdWJmbG93KHN0cnVj
dCBzb2NrICptZXRhX3NrLAogICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHNrX2J1ZmYgKnNr
Yiw8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+CiAgICAgICAg
ICAgICAgICAgICAgICAqIHRoZSBza2IgcGFzc2VkIHRocm91Z2ggYWxsIHRoZSBhdmFpbGFibGUg
YWN0aXZlCiAgICAgICAgICAgICAgICAgICAgICBhbmQgYmFja3VwczxiciBjbGFzcz0iIj4KICAg
ICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICAgICogc2tz
LCBzbyBjbGVhbiB0aGUgcGF0aCBtYXNrPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAg
ICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPgogICAgICAgICAgICAgICAgICAgICAgKi88YnIgY2xhc3M9IiI+CiAgICAg
ICAgICAgICAgICAgICAgICAtPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9
IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5UQ1BfU0tCX0NCKHNrYiktJmd0O3BhdGhfbWFzawog
ICAgICAgICAgICAgICAgICAgICAgPSAwOzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAg
ICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPlRDUF9TS0JfQ0Ioc2tiKS0mZ3Q7bXB0Y3BfcGF0aF9tYXNrCiAgICAgICAg
ICAgICAgICAgICAgICA9IDA7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+cmV0dXJuCiAgICAgICAgICAgICAgICAgICAgICBzazs8YnIgY2xhc3M9IiI+CiAgICAgICAg
ICAgICAgICAgICAgICCgoH08YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoEVY
UE9SVF9TWU1CT0xfR1BMKGdldF9hdmFpbGFibGVfc3ViZmxvdyk7PGJyCiAgICAgICAgICAgICAg
ICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgQEAgLTI5OCw3ICsyOTgs
NyBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYKICAgICAgICAgICAgICAgICAgICAgICptcHRjcF9y
Y3ZfYnVmX29wdGltaXphdGlvbihzdHJ1Y3Qgc29jayAqc2ssIGludAogICAgICAgICAgICAgICAg
ICAgICAgcGVuYWwpPGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBj
bGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+LyoK
ICAgICAgICAgICAgICAgICAgICAgIEhhbGYgdGhlIGN3bmQgb2YgdGhlIHNsb3cgZmxvdyAqLzxi
ciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPm1wdGNwX2Zvcl9lYWNoX3Rw
KHRwLSZndDttcGNiLAogICAgICAgICAgICAgICAgICAgICAgdHBfaXQpIHs8YnIgY2xhc3M9IiI+
CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5
bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4i
IHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+aWYKICAgICAgICAgICAgICAgICAgICAg
ICh0cF9pdCAhPSB0cCAmYW1wOyZhbXA7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAg
ICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+CiAgICAgICAgICAgICAgICAgICAgICCgoKBUQ1BfU0tCX0NCKHNrYl9oZWFk
KS0mZ3Q7cGF0aF9tYXNrICZhbXA7CiAgICAgICAgICAgICAgICAgICAgICBtcHRjcF9waV90b19m
bGFnKHRwX2l0LSZndDttcHRjcC0mZ3Q7cGF0aF9pbmRleCkpCiAgICAgICAgICAgICAgICAgICAg
ICB7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgKzxzcGFuIGNsYXNzPSJBcHBs
ZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0i
QXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+CiAgICAgICAg
ICAgICAgICAgICAgICCgoKBUQ1BfU0tCX0NCKHNrYl9oZWFkKS0mZ3Q7bXB0Y3BfcGF0aF9tYXNr
ICZhbXA7CiAgICAgICAgICAgICAgICAgICAgICBtcHRjcF9waV90b19mbGFnKHRwX2l0LSZndDtt
cHRjcC0mZ3Q7cGF0aF9pbmRleCkpCiAgICAgICAgICAgICAgICAgICAgICB7PGJyIGNsYXNzPSIi
PgogICAgICAgICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0
eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFu
IiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWIt
c3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj5pZgogICAgICAgICAgICAgICAg
ICAgICAgKHRwLSZndDtzcnR0X3VzICZsdDsgdHBfaXQtJmd0O3NydHRfdXMgJmFtcDsmYW1wOwog
ICAgICAgICAgICAgICAgICAgICAgaW5ldF9jc2soKHN0cnVjdCBzb2NrICopdHBfaXQpLSZndDtp
Y3NrX2NhX3N0YXRlCiAgICAgICAgICAgICAgICAgICAgICA9PSBUQ1BfQ0FfT3BlbikgezxiciBj
bGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPnUzMgogICAg
ICAgICAgICAgICAgICAgICAgcHJpb3JfY3duZCA9IHRwX2l0LSZndDtzbmRfY3duZDs8YnIgY2xh
c3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICBAQCAtMzE3LDExICszMTcsMTEgQEAgc3RhdGlj
IHN0cnVjdCBza19idWZmCiAgICAgICAgICAgICAgICAgICAgICAqbXB0Y3BfcmN2X2J1Zl9vcHRp
bWl6YXRpb24oc3RydWN0IHNvY2sgKnNrLCBpbnQKICAgICAgICAgICAgICAgICAgICAgIHBlbmFs
KTxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgcmV0cmFuczo8YnIgY2xhc3M9
IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4vKgogICAgICAgICAgICAgICAgICAgICAg
U2VnbWVudCBub3QgeWV0IGluamVjdGVkIGludG8gdGhpcyBwYXRoPyBUYWtlCiAgICAgICAgICAg
ICAgICAgICAgICBpdCEhISAqLzxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIC08
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+aWYKICAgICAgICAgICAgICAgICAgICAgICghKFRDUF9TS0JfQ0Ioc2tiX2hlYWQpLSZndDtw
YXRoX21hc2sgJmFtcDsKICAgICAgICAgICAgICAgICAgICAgIG1wdGNwX3BpX3RvX2ZsYWcodHAt
Jmd0O21wdGNwLSZndDtwYXRoX2luZGV4KSkpIHs8YnIKICAgICAgICAgICAgICAgICAgICAgICAg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICArPHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1z
cGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmlmCiAgICAgICAgICAgICAgICAg
ICAgICAoIShUQ1BfU0tCX0NCKHNrYl9oZWFkKS0mZ3Q7bXB0Y3BfcGF0aF9tYXNrICZhbXA7CiAg
ICAgICAgICAgICAgICAgICAgICBtcHRjcF9waV90b19mbGFnKHRwLSZndDttcHRjcC0mZ3Q7cGF0
aF9pbmRleCkpKSB7PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAg
ICAgICAgICAgICAgICAgoKA8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0
ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPmJvb2wKICAgICAgICAgICAgICAgICAgICAgIGRvX3Jl
dHJhbnMgPSBmYWxzZTs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFu
IGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48
c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3Nw
YW4+bXB0Y3BfZm9yX2VhY2hfdHAodHAtJmd0O21wY2IsCiAgICAgICAgICAgICAgICAgICAgICB0
cF9pdCkgezxiciBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgICAgIKCgPHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
aWYKICAgICAgICAgICAgICAgICAgICAgICh0cF9pdCAhPSB0cCAmYW1wOyZhbXA7PGJyIGNsYXNz
PSIiPgogICAgICAgICAgICAgICAgICAgICAgLTxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIg
c3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNw
YW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRh
Yi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPgogICAgICAgICAgICAgICAg
ICAgICAgoKCgVENQX1NLQl9DQihza2JfaGVhZCktJmd0O3BhdGhfbWFzayAmYW1wOwogICAgICAg
ICAgICAgICAgICAgICAgbXB0Y3BfcGlfdG9fZmxhZyh0cF9pdC0mZ3Q7bXB0Y3AtJmd0O3BhdGhf
aW5kZXgpKQogICAgICAgICAgICAgICAgICAgICAgezxiciBjbGFzcz0iIj4KICAgICAgICAgICAg
ICAgICAgICAgICs8c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFj
ZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9Indo
aXRlLXNwYWNlOnByZSI+CTwvc3Bhbj4KICAgICAgICAgICAgICAgICAgICAgIKCgoFRDUF9TS0Jf
Q0Ioc2tiX2hlYWQpLSZndDttcHRjcF9wYXRoX21hc2sgJmFtcDsKICAgICAgICAgICAgICAgICAg
ICAgIG1wdGNwX3BpX3RvX2ZsYWcodHBfaXQtJmd0O21wdGNwLSZndDtwYXRoX2luZGV4KSkKICAg
ICAgICAgICAgICAgICAgICAgIHs8YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCg
oDxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwv
c3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlIj4JPC9zcGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNw
YWNlOnByZSI+CTwvc3Bhbj5pZgogICAgICAgICAgICAgICAgICAgICAgKHRwX2l0LSZndDtzbmRf
Y3duZCAmbHQ7PSA0KSB7PGJyIGNsYXNzPSIiPgogICAgICAgICAgICAgICAgICAgICAgoKA8c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPjxzcGFuIGNsYXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+
CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpw
cmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3Bh
Y2U6cHJlIj4JPC9zcGFuPmRvX3JldHJhbnMKICAgICAgICAgICAgICAgICAgICAgID0gdHJ1ZTs8
YnIgY2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgICCgoDxzcGFuIGNsYXNzPSJBcHBsZS10
YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3BhbiBjbGFzcz0iQXBw
bGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+PHNwYW4gY2xhc3M9
IkFwcGxlLXRhYi1zcGFuIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPjxzcGFuIGNs
YXNzPSJBcHBsZS10YWItc3BhbiIgc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+CTwvc3Bhbj48c3Bh
biBjbGFzcz0iQXBwbGUtdGFiLXNwYW4iIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+
YnJlYWs7PGJyCiAgICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIiPgogICAgICAgICAgICAg
ICAgICAgIDwvYmxvY2txdW90ZT4KICAgICAgICAgICAgICAgICAgICBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzxicgogICAgICAgICAgICAgICAgICAgICAg
Y2xhc3M9IiI+CiAgICAgICAgICAgICAgICAgICAgbXB0Y3AgbWFpbGluZyBsaXN0PGJyIGNsYXNz
PSIiPgogICAgICAgICAgICAgICAgICAgIDxhIGhyZWY9Im1haWx0bzptcHRjcEBsaXN0cy4wMS5v
cmciIGNsYXNzPSIiCiAgICAgICAgICAgICAgICAgICAgICBtb3otZG8tbm90LXNlbmQ9InRydWUi
Pm1wdGNwQGxpc3RzLjAxLm9yZzwvYT48YnIKICAgICAgICAgICAgICAgICAgICAgIGNsYXNzPSIi
PgogICAgICAgICAgICAgICAgICAgIDxhIGNsYXNzPSJtb3otdHh0LWxpbmstZnJlZXRleHQiIGhy
ZWY9Imh0dHBzOi8vbGlzdHMuMDEub3JnL21haWxtYW4vbGlzdGluZm8vbXB0Y3AiPmh0dHBzOi8v
bGlzdHMuMDEub3JnL21haWxtYW4vbGlzdGluZm8vbXB0Y3A8L2E+PGJyCiAgICAgICAgICAgICAg
ICAgICAgICBjbGFzcz0iIj4KICAgICAgICAgICAgICAgICAgPC9ibG9ja3F1b3RlPgogICAgICAg
ICAgICAgICAgPC9ibG9ja3F1b3RlPgogICAgICAgICAgICAgICAgPGJyIGNsYXNzPSIiPgogICAg
ICAgICAgICAgIDwvZGl2PgogICAgICAgICAgICA8L2Rpdj4KICAgICAgICAgIDwvYmxvY2txdW90
ZT4KICAgICAgICA8L2Rpdj4KICAgICAgICA8YnIgY2xhc3M9IiI+CiAgICAgIDwvZGl2PgogICAg
PC9ibG9ja3F1b3RlPgogICAgPGJyPgogIDwvYm9keT4KPC9odG1sPgo=

--===============7618826272802434091==--
