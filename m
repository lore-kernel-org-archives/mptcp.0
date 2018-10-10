Content-Type: multipart/mixed; boundary="===============0728473125596113053=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH v3 15/16] mptcp: Implement MPTCP receive path
Date: Wed, 10 Oct 2018 12:09:31 -0700
Message-ID: <alpine.OSX.2.21.1810101039220.11293@dwiltz-mobl1.amr.corp.intel.com>
In-Reply-To: 20181009163111.GI36310@MacBook-Pro-19.local
X-Status: 
X-Keywords:                  
X-UID: 812

--===============0728473125596113053==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Oct 2018, Christoph Paasch wrote:

> On 08/10/18 - 17:48:29, Mat Martineau wrote:
>>
>> On Mon, 8 Oct 2018, Christoph Paasch wrote:
>>
>>> On 05/10/18 - 15:59:17, Mat Martineau wrote:
>>>> Parses incoming DSS options and populates outgoing MPTCP ACK
>>>> fields. Clone incoming skbs containing MPTCP headers and propagate them
>>>> to the MMPTCP socket using the error queue. This avoids the need for T=
CP
>>>> coalesce/collapse bypass for MPTCP, although cloning incoming skbs does
>>>> prevent some coalescing.
>>>
>>> I think it's acceptable to bypass coalesce/collapse for MPTCP instead of
>>> cloning every incoming packet over to the error-queue.
>>>
>>> The way this is now, makes the error-queue quite loaded, and I don't th=
ink
>>> it handles packet-reordering correctly.
>>
>>
>> While the commit message says skbs with MPTCP headers are cloned, the co=
de
>> clones all incoming skbs right now. Maybe most data packets end up having
>> DSS headers anyway.
>>
>> I agree that the current method of reading the DSS information is fragile
>> with respect to out-of-order packet arrival.
>>
>>
>> I'm trying to get away from the previous approach of preventing
>> coalesce/collapse and depending on intact headers in the skb. That techn=
ique
>> relies on the integrity of data between sk_buff->head and sk_buff->data,
>> when sk_buff->data is is considered to be the beginning of valid data.
>>
>>
>> What do you think about using the parallel queue approach once this
>> implementation is further developed (and before you put a lot of thought=
 in
>> to it, read the rest of this reply for an alternative):
>>
>>  * Only packets with DSS headers are cloned
>>
>>  * The DSS mapping queue is emptied on every read, building a data struc=
ture
>> to represent the map for all the queued data on that subflow (deals with
>> ordering issue)
>>
>> with possible optimization:
>>
>>  * Rather than copy the entire skb, keep a pool of small skbs around and
>> only copy the TCP header
>>
>>
>> I tried out using the error queue since it has some similar per-packet u=
se
>> for tx timestamping, but the error queue does take a spinlock for every
>> enqueue/dequeue. Might make more sense to add a lockless linked list to =
the
>> subflow_sock for this purpose - since my intent is to empty that list ev=
ery
>> time it's read from, llist_del_all() to pop off all the entries at once =
is a
>> nice fit. It would also allow use of a much smaller data structure to ho=
ld
>> the mapping data.
>
> Did you consider using the priv-pointer in the skb to take care of this
> instead?
>
> The problem here is that the DSS-information is tightly linked to a byte =
in
> the payload. When we start sending this DSS-information asynchronously ov=
er
> to the meta-socket (which is what the error-queue or another queue is
> doing), we start making things very complex (e.g., need to keep ordering
> right,...).
>
> E.g., in skb_try_coalesce, we can simply do a check on the priv-used fiel=
d.
> And then decide based on the DSS-mapping (or do that in tcp_try_coalesce).
>
> When coalescing is happening, the issue is that we anyways need to
> "de-coalesce" after if non-continuous mappings have been coalesced. This =
is
> another reason why it's good to do a "smart" coalescing that takes
> DSS-mappings into account. priv_used is the perfect infrastructure for th=
at.
>
>
> Doing it that way will be much less error-prone.
>
>
> The parallel queue is great for asynchronous signals like ADD_ADDR,...

It depends on whether you want to read from a subflow and then figure out =

where the payload belongs in the MPTCP stream, or if you want to have the =

mapping info for all the subflows available before reading in order to =

decide which subflow to look at next.

I think there's something to be said for leaving the data in the subflow =

rx queue until it's requested by userspace. That would let TCP handle a =

lot of the buffering in a more normal (for TCP) way. While the MPTCP layer =

would have to handle some out-of-order reassembly and buffering, I think =

the common case would be to pass reads through to the appropriate subflow. =

MPTCP-layer reassembly and buffering would be the uncommon case (I =

assume...) and wouldn't need to be super optimized.

Speaking of assumptions, I should be more specific about what I expect =

from normal traffic patterns. For the mobile connectivity use case, I'd =

expect one subflow to be receiving all the incoming packets in-order until =

there was a change in the available interfaces, when the subflow in use =

might change. For the hybrid access use case, I would expect increasing =

sequence numbers (with wrap-around) on all subflows. In both cases, a jump =

backwards in the sequence numbers must be handled but is unlikely, and no =

buffering is required at the MPTCP layer. For hybrid access, knowing the =

sequence numbers prior to reading from the subflow seems like a win.

Does this fit with what you (or researchers) have seen from MPTCP in =

practice?

Thanks,

Mat


>>
>>
>> Thanks,
>> Mat
>>
>>
>>>>
>>>> Keeping DSS map handling separate from data reading makes it easier to
>>>> add multiple-subflow receiving, since the receive code can determine
>>>> which subflow contains relevant data or data that needs to be purged
>>>> without touching the subflow data queues.
>>>>
>>>> MPTCP ACK values are now populated from an atomic value stored in the
>>>> connection socket rather than carried in the extended control block,
>>>> which makes use of the most up-to-date sequence number and allows the
>>>> MPTCP ACK to be populated on TCP ACK packets that have no payload.
>>>>
>>>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>>>> ---
>>>>  include/linux/tcp.h           |  12 ++
>>>>  include/net/mptcp.h           |  41 +++--
>>>>  include/uapi/linux/errqueue.h |   1 +
>>>>  net/ipv4/tcp_input.c          |   3 +
>>>>  net/ipv4/tcp_output.c         | 123 +++++++-------
>>>>  net/mptcp/options.c           |  90 +++++++++-
>>>>  net/mptcp/protocol.c          | 304 +++++++++++++++++++++++++++++++---
>>>>  net/mptcp/subflow.c           |  29 +++-
>>>>  8 files changed, 508 insertions(+), 95 deletions(-)
>>>>
>>>> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
>>>> index b109798482d3..845da5ee9c44 100644
>>>> --- a/include/linux/tcp.h
>>>> +++ b/include/linux/tcp.h
>>>> @@ -112,6 +112,18 @@ struct tcp_options_received {
>>>>  		u8      flags;
>>>>  		u64     sndr_key;
>>>>  		u64     rcvr_key;
>>>> +		u64	ack;
>>>> +		u64	seq;
>>>> +		u32	subflow_seq;
>>>> +		u16	dll;
>>>> +		u16	checksum;
>>>> +		u8	use_ack:1,
>>>> +			ack64:1,
>>>> +			use_map:1,
>>>> +			dsn64:1,
>>>> +			use_checksum:1,
>>>> +			data_fin:1,
>>>> +			__unused:2;
>>>>  	} mptcp;
>>>>
>>>>  };
>>>> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
>>>> index 73f2d25cc42d..6c9516360de4 100644
>>>> --- a/include/net/mptcp.h
>>>> +++ b/include/net/mptcp.h
>>>> @@ -38,14 +38,14 @@
>>>>  /* MPTCP connection sock */
>>>>  struct mptcp_sock {
>>>>  	/* inet_connection_sock must be the first member */
>>>> -	struct	inet_connection_sock sk;
>>>> -	u64	local_key;
>>>> -	u64	remote_key;
>>>> -	u64	write_seq;
>>>> -	u64	ack_seq;
>>>> -	u32	token;
>>>> -	struct	socket *connection_list; /* @@ needs to be a list */
>>>> -	struct	socket *subflow; /* outgoing connect, listener or !mp_capable=
 */
>>>> +	struct inet_connection_sock sk;
>>>> +	u64		local_key;
>>>> +	u64		remote_key;
>>>> +	u64		write_seq;
>>>> +	atomic64_t	ack_seq;
>>>> +	u32		token;
>>>> +	struct socket	*connection_list; /* @@ needs to be a list */
>>>> +	struct socket	*subflow; /* outgoing connect, listener or !mp_capable=
 */
>>>>  };
>>>>
>>>>  static inline struct mptcp_sock *mptcp_sk(const struct sock *sk)
>>>> @@ -56,7 +56,6 @@ static inline struct mptcp_sock *mptcp_sk(const stru=
ct sock *sk)
>>>>  /* MPTCP sk_buff private control buffer */
>>>>  struct mptcp_skb_cb {
>>>>  	refcount_t	refcnt;
>>>> -	u64		data_ack;
>>>>  	u64		data_seq;
>>>>  	u32		subflow_seq;
>>>>  	u16		dll;
>>>> @@ -65,9 +64,7 @@ struct mptcp_skb_cb {
>>>>  			dsn64:1,
>>>>  			use_checksum:1,
>>>>  			data_fin:1,
>>>> -			use_ack:1,
>>>> -			ack64:1,
>>>> -			__unused:2;
>>>> +			__unused:4;
>>>>  };
>>>>
>>>>  static inline struct mptcp_skb_cb *mptcp_skb_priv_cb(struct sk_buff *=
skb)
>>>> @@ -81,16 +78,23 @@ struct subflow_sock {
>>>>  	/* tcp_sock must be the first member */
>>>>  	struct	tcp_sock sk;
>>>>  	u64	local_key;
>>>> +	u64	map_seq;
>>>> +	u32	map_subflow_seq;
>>>>  	u32	token;
>>>>  	u64	idsn;
>>>>  	u64	remote_key;
>>>>  	u32	rel_write_seq;
>>>> +	u32	ssn_offset;
>>>> +	u16	map_dll;
>>>>  	bool	request_mptcp;	// send MP_CAPABLE
>>>>  	bool	checksum;
>>>>  	bool	version;
>>>>  	bool	mp_capable;	// remote is MPTCP capable
>>>>  	bool	fourth_ack;	// send initial DSS
>>>> +	bool	conn_finished;
>>>> +	bool	map_valid;
>>>>  	struct	sock *conn;	// parent mptcp_sock
>>>> +	void	(*tcp_sk_data_ready)(struct sock *sk);
>>>>  };
>>>>
>>>>  static inline struct subflow_sock *subflow_sk(const struct sock *sk)
>>>> @@ -98,6 +102,16 @@ static inline struct subflow_sock *subflow_sk(cons=
t struct sock *sk)
>>>>  	return (struct subflow_sock *)sk;
>>>>  }
>>>>
>>>> +static inline struct subflow_sock *subflow_tp(const struct tcp_sock *=
tp)
>>>> +{
>>>> +	return (struct subflow_sock *)tp;
>>>> +}
>>>> +
>>>> +static inline struct sock *sock_sk(const struct subflow_sock *sk)
>>>> +{
>>>> +	return (struct sock *)sk;
>>>> +}
>>>> +
>>>>  struct subflow_request_sock {
>>>>  	struct	tcp_request_sock sk;
>>>>  	u8	mp_capable : 1,
>>>> @@ -109,6 +123,7 @@ struct subflow_request_sock {
>>>>  	u32	token;
>>>>  	u64	idsn;
>>>>  	u64	remote_key;
>>>> +	u32	ssn_offset;
>>>>  };
>>>>
>>>>  static inline
>>>> @@ -133,6 +148,8 @@ void mptcp_subflow_exit(void);
>>>>  void mptcp_get_options(const struct sk_buff *skb,
>>>>  		       struct tcp_options_received *options);
>>>>
>>>> +void mptcp_queue_headers(struct sock *sk, struct sk_buff *original_sk=
b);
>>>> +
>>>>  extern const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops;
>>>>
>>>>  void token_init(void);
>>>> diff --git a/include/uapi/linux/errqueue.h b/include/uapi/linux/errque=
ue.h
>>>> index c0151200f7d1..1a1ec7362a55 100644
>>>> --- a/include/uapi/linux/errqueue.h
>>>> +++ b/include/uapi/linux/errqueue.h
>>>> @@ -21,6 +21,7 @@ struct sock_extended_err {
>>>>  #define SO_EE_ORIGIN_TXSTATUS	4
>>>>  #define SO_EE_ORIGIN_ZEROCOPY	5
>>>>  #define SO_EE_ORIGIN_TXTIME	6
>>>> +#define SO_EE_ORIGIN_MPTCP	7
>>>>  #define SO_EE_ORIGIN_TIMESTAMPING SO_EE_ORIGIN_TXSTATUS
>>>>
>>>>  #define SO_EE_OFFENDER(ee)	((struct sockaddr*)((ee)+1))
>>>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>>>> index 9a326729637f..0904d9baa685 100644
>>>> --- a/net/ipv4/tcp_input.c
>>>> +++ b/net/ipv4/tcp_input.c
>>>> @@ -5642,6 +5642,9 @@ void tcp_rcv_established(struct sock *sk, struct=
 sk_buff *skb)
>>>>  	tcp_urg(sk, skb, th);
>>>>
>>>>  	/* step 7: process the segment text */
>>>> +	if (tcp_sk(sk)->is_mptcp)
>>>> +		mptcp_queue_headers(sk, skb);
>>>> +
>>>>  	tcp_data_queue(sk, skb);
>>>>
>>>>  	tcp_data_snd_check(sk);
>>>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>>>> index 471f196711fc..1c9517db82c2 100644
>>>> --- a/net/ipv4/tcp_output.c
>>>> +++ b/net/ipv4/tcp_output.c
>>>> @@ -422,8 +422,8 @@ static inline bool tcp_urg_mode(const struct tcp_s=
ock *tp)
>>>>  #define OPTION_MPTCP_MPC_SYN	(1 << 0)
>>>>  #define OPTION_MPTCP_MPC_SYNACK	(1 << 1)
>>>>  #define OPTION_MPTCP_MPC_ACK	(1 << 2)
>>>> -#define OPTION_MPTCP_MPC_DSS_MAP	(1 << 6)
>>>> -#define OPTION_MPTCP_MPC_DSS_ACK	(1 << 7)
>>>> +#define OPTION_MPTCP_DSS_MAP	(1 << 6)
>>>> +#define OPTION_MPTCP_DSS_ACK	(1 << 7)
>>>>
>>>>  struct tcp_out_options {
>>>>  	u16 options;		/* bit field of OPTION_* */
>>>> @@ -472,16 +472,12 @@ static void mptcp_options_write(__be32 *ptr, str=
uct sk_buff *skb,
>>>>  		}
>>>>  	}
>>>>
>>>> -	if ((OPTION_MPTCP_MPC_DSS_MAP |
>>>> -	     OPTION_MPTCP_MPC_DSS_ACK) & opts->suboptions) {
>>>> -		struct mptcp_skb_cb *mcb =3D mptcp_skb_priv_cb(skb);
>>>> -		bool write_ack =3D (OPTION_MPTCP_MPC_DSS_ACK & opts->suboptions) &&=
 skb->priv_used && mcb->use_ack;
>>>> -		bool write_map =3D (OPTION_MPTCP_MPC_DSS_MAP & opts->suboptions) &&=
 skb->priv_used && mcb->use_map;
>>>> +	if ((OPTION_MPTCP_DSS_MAP | OPTION_MPTCP_DSS_ACK) & opts->suboptions=
) {
>>>> +		bool write_ack =3D !!(OPTION_MPTCP_DSS_ACK & opts->suboptions);
>>>> +		bool write_map =3D (OPTION_MPTCP_DSS_MAP & opts->suboptions) &&
>>>> +			skb->priv_used && mptcp_skb_priv_cb(skb)->use_map;
>>>>  		u8 flags =3D 0;
>>>>  		u8 len =3D 4;
>>>> -		u8 *p =3D (u8 *)ptr;
>>>> -
>>>> -		BUG_ON(!write_ack && !write_map);
>>>>
>>>>  		if (write_ack) {
>>>>  			len +=3D 8;
>>>> @@ -489,46 +485,60 @@ static void mptcp_options_write(__be32 *ptr, str=
uct sk_buff *skb,
>>>>  		}
>>>>
>>>>  		if (write_map) {
>>>> +			pr_debug("Updating DSS length and flags for map");
>>>>  			len +=3D 14;
>>>>
>>>> -			if (mcb->use_checksum)
>>>> +			if (mptcp_skb_priv_cb(skb)->use_checksum)
>>>>  				len +=3D 2;
>>>>
>>>>  			/* Use only 64-bit mapping flags for now, add
>>>>  			 * support for optional 32-bit mappings later.
>>>>  			 */
>>>>  			flags |=3D 0x0c;
>>>> -			if (mcb->data_fin)
>>>> +			if (mptcp_skb_priv_cb(skb)->data_fin)
>>>>  				flags |=3D 0x10;
>>>>  		}
>>>>
>>>> -		*p++ =3D 0x1e; // TCP option: Multipath TCP
>>>> -		*p++ =3D len;  // length
>>>> -		*p++ =3D 0x20; // subtype=3DDSS
>>>> -		*p++ =3D flags;
>>>> +		*ptr++ =3D htonl((0x1e << 24) |  // TCP option: Multipath TCP
>>>> +			       (len  << 16) |  // length
>>>> +			       (0x20 <<  8) |  // subtype=3DDSS
>>>> +			       (flags));
>>>>
>>>>  		if (write_ack) {
>>>> -			*(__be64 *)p =3D cpu_to_be64(mcb->data_ack);
>>>> -			p +=3D 8;
>>>> +			struct mptcp_sock *msk =3D mptcp_sk(subflow_tp(tp)->conn);
>>>> +			u64 ack_seq;
>>>> +			__be64 ack;
>>>> +
>>>> +			if (msk) {
>>>> +				ack_seq =3D atomic64_read(&msk->ack_seq);
>>>> +			} else {
>>>> +				crypto_key_sha1(subflow_tp(tp)->remote_key,
>>>> +						NULL, &ack_seq);
>>>> +				ack_seq++;
>>>> +			}
>>>> +
>>>> +			pr_debug("ack=3D%llu", ack_seq);
>>>> +			ack =3D cpu_to_be64(ack_seq);
>>>> +			memcpy((u8 *) ptr, (u8 *) &ack, 8);
>>>> +			ptr +=3D 2;
>>>>  		}
>>>>
>>>>  		if (write_map) {
>>>> -			*(__be64 *)p =3D cpu_to_be64(mcb->data_seq);
>>>> -			p +=3D 8;
>>>> -
>>>> -			*(__be32 *)p =3D htonl(mcb->subflow_seq);
>>>> -			p +=3D 4;
>>>> +			struct mptcp_skb_cb *mcb =3D mptcp_skb_priv_cb(skb);
>>>> +			u16 checksum;
>>>> +			__be64 dss;
>>>>
>>>> -			*(__be16 *)p =3D htons(mcb->dll);
>>>> -			p +=3D 2;
>>>> +			pr_debug("Writing map values");
>>>> +			dss =3D cpu_to_be64(mcb->data_seq);
>>>> +			memcpy((u8 *) ptr, &dss, 8);
>>>> +			ptr +=3D 2;
>>>> +			*ptr++ =3D htonl(mcb->subflow_seq);
>>>>
>>>> -			if (mcb->use_checksum) {
>>>> -				*(__be16 *)p =3D htons(mcb->checksum);
>>>> -				p +=3D 2;
>>>> -			} else {
>>>> -				*p++ =3D TCPOPT_NOP;
>>>> -				*p++ =3D TCPOPT_NOP;
>>>> -			}
>>>> +			if (mcb->use_checksum)
>>>> +				checksum =3D (__force u16) mcb->checksum;
>>>> +			else
>>>> +				checksum =3D TCPOPT_NOP << 8 | TCPOPT_NOP;
>>>> +			*ptr++ =3D htonl(mcb->dll << 16 | checksum);
>>>>  		}
>>>>  	}
>>>>  }
>>>> @@ -899,50 +909,44 @@ static unsigned int tcp_established_options(stru=
ct sock *sk, struct sk_buff *skb
>>>>  					size +=3D 20;
>>>>  				}
>>>>  				subflow->fourth_ack =3D 1;
>>>> -			} else if (skb && skb->priv_used) {
>>>> -				struct mptcp_skb_cb *cb;
>>>> +			} else if (skb) {
>>>>  				unsigned int dss_size =3D 0;
>>>> -				u16 options =3D 0;
>>>> +				unsigned int ack_size =3D 8;
>>>> +				u16 suboptions =3D 0;
>>>>
>>>> -				cb =3D mptcp_skb_priv_cb(skb);
>>>> -
>>>> -				if (skb->priv_used && cb->use_map) {
>>>> +				if (skb->priv_used &&
>>>> +				    mptcp_skb_priv_cb(skb)->use_map) {
>>>>  					unsigned int map_size =3D 18;
>>>>
>>>> -					if (cb->use_checksum)
>>>> +					if (mptcp_skb_priv_cb(skb)->use_checksum)
>>>>  						map_size +=3D 2;
>>>>
>>>>  					if (map_size <=3D remaining) {
>>>>  						remaining -=3D map_size;
>>>>  						dss_size =3D map_size;
>>>> -						opts->options |=3D OPTION_MPTCP;
>>>> -						opts->suboptions =3D OPTION_MPTCP_MPC_DSS_MAP;
>>>> +						suboptions =3D OPTION_MPTCP_DSS_MAP;
>>>>  					} else {
>>>>  						WARN(1, "MPTCP: Map dropped");
>>>>  					}
>>>>  				}
>>>>
>>>> -				if (cb->use_ack) {
>>>> -					unsigned int ack_size =3D 8;
>>>> -
>>>> -					/* Add kind/length/subtype/flag
>>>> -					 * overhead if mapping not populated
>>>> -					 */
>>>> -					if (dss_size =3D=3D 0)
>>>> -						ack_size +=3D 4;
>>>> -
>>>> -					if (ack_size <=3D remaining) {
>>>> -						dss_size +=3D ack_size;
>>>> -						opts->options |=3D OPTION_MPTCP;
>>>> -						opts->suboptions |=3D OPTION_MPTCP_MPC_DSS_ACK;
>>>> -					} else {
>>>> -						WARN(1, "MPTCP: Ack dropped");
>>>> -					}
>>>> +				/* Add kind/length/subtype/flag
>>>> +				 * overhead if mapping not populated
>>>> +				 */
>>>> +				if (dss_size =3D=3D 0)
>>>> +					ack_size +=3D 4;
>>>> +
>>>> +				if (ack_size <=3D remaining) {
>>>> +					dss_size +=3D ack_size;
>>>> +					suboptions |=3D OPTION_MPTCP_DSS_ACK;
>>>> +				} else {
>>>> +					WARN(1, "MPTCP: Ack dropped");
>>>>  				}
>>>>
>>>>  				if (dss_size) {
>>>>  					size +=3D ALIGN(dss_size, 4);
>>>> -					opts->options |=3D options;
>>>> +					opts->options |=3D OPTION_MPTCP;
>>>> +					opts->suboptions =3D suboptions;
>>>>  				}
>>>>  			}
>>>>  		}
>>>> @@ -3804,6 +3808,9 @@ void __tcp_send_ack(struct sock *sk, u32 rcv_nxt)
>>>>  	skb_set_tcp_pure_ack(buff);
>>>>
>>>>  	/* Send it off, this clears delayed acks for us. */
>>>> +	if (tcp_sk(sk)->is_mptcp)
>>>> +		pr_debug("mptcp sk=3D%p", sk);
>>>> +
>>>>  	__tcp_transmit_skb(sk, buff, 0, (__force gfp_t)0, rcv_nxt);
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(__tcp_send_ack);
>>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>>> index 7e48d1d92aac..f5b7be888e84 100644
>>>> --- a/net/mptcp/options.c
>>>> +++ b/net/mptcp/options.c
>>>> @@ -14,6 +14,7 @@
>>>>   */
>>>>
>>>>  #include <linux/kernel.h>
>>>> +#include <linux/errqueue.h>
>>>>  #include <net/tcp.h>
>>>>  #include <net/mptcp.h>
>>>>
>>>> @@ -21,9 +22,8 @@ void mptcp_parse_option(const unsigned char *ptr, in=
t opsize,
>>>>  			struct tcp_options_received *opt_rx)
>>>>  {
>>>>  	u8 subtype;
>>>> -	u64 *p;
>>>> +	int expected_opsize;
>>>>
>>>> -	opsize -=3D 2;
>>>>  	subtype =3D *ptr++;
>>>>
>>>>  	/* MPTCPOPT_MP_CAPABLE
>>>> @@ -82,6 +82,68 @@ void mptcp_parse_option(const unsigned char *ptr, i=
nt opsize,
>>>>  	case 0x20:
>>>>  		pr_debug("DSS");
>>>>  		opt_rx->mptcp.dss =3D 1;
>>>> +
>>>> +		opt_rx->mptcp.flags =3D (*ptr++) & 0x1F;
>>>> +		opt_rx->mptcp.data_fin =3D (opt_rx->mptcp.flags & 0x10) !=3D 0;
>>>> +		opt_rx->mptcp.dsn64 =3D (opt_rx->mptcp.flags & 0x08) !=3D 0;
>>>> +		opt_rx->mptcp.use_map =3D (opt_rx->mptcp.flags & 0x04) !=3D 0;
>>>> +		opt_rx->mptcp.ack64 =3D (opt_rx->mptcp.flags & 0x02) !=3D 0;
>>>> +		opt_rx->mptcp.use_ack =3D (opt_rx->mptcp.flags & 0x01);
>>>> +
>>>> +		pr_debug("data_fin=3D%d dsn64=3D%d use_map=3D%d ack64=3D%d use_ack=
=3D%d",
>>>> +			 opt_rx->mptcp.data_fin, opt_rx->mptcp.dsn64,
>>>> +			 opt_rx->mptcp.use_map, opt_rx->mptcp.ack64,
>>>> +			 opt_rx->mptcp.use_ack);
>>>> +
>>>> +		expected_opsize =3D 0;
>>>> +
>>>> +		if (opt_rx->mptcp.use_ack) {
>>>> +			expected_opsize =3D 4;
>>>> +			if (opt_rx->mptcp.ack64)
>>>> +				expected_opsize +=3D 4;
>>>> +
>>>> +			if (opsize < expected_opsize)
>>>> +				break;
>>>> +
>>>> +			if (opt_rx->mptcp.ack64) {
>>>> +				opt_rx->mptcp.ack =3D get_unaligned_be64(ptr);
>>>> +				ptr +=3D 8;
>>>> +			} else {
>>>> +				opt_rx->mptcp.ack =3D get_unaligned_be32(ptr);
>>>> +				ptr +=3D 4;
>>>> +			}
>>>> +
>>>> +			pr_debug("ack=3D%llu", opt_rx->mptcp.ack);
>>>> +		}
>>>> +
>>>> +		if (opt_rx->mptcp.use_map) {
>>>> +			expected_opsize +=3D 12;
>>>> +			if (opt_rx->mptcp.dsn64)
>>>> +				expected_opsize +=3D 4;
>>>> +
>>>> +			if (opsize < expected_opsize)
>>>> +				break;
>>>> +
>>>> +			if (opt_rx->mptcp.dsn64) {
>>>> +				opt_rx->mptcp.seq =3D get_unaligned_be64(ptr);
>>>> +				ptr +=3D 8;
>>>> +			} else {
>>>> +				opt_rx->mptcp.seq =3D get_unaligned_be32(ptr);
>>>> +				ptr +=3D 4;
>>>> +			}
>>>> +
>>>> +			opt_rx->mptcp.subflow_seq =3D get_unaligned_be32(ptr);
>>>> +			ptr +=3D 4;
>>>> +
>>>> +			opt_rx->mptcp.dll =3D get_unaligned_be16(ptr);
>>>> +			ptr +=3D 2;
>>>> +
>>>> +			opt_rx->mptcp.checksum =3D get_unaligned_be16(ptr);
>>>> +
>>>> +			pr_debug("seq=3D%llu subflow_seq=3D%u dll=3D%u ck=3D%u",
>>>> +				 opt_rx->mptcp.seq, opt_rx->mptcp.subflow_seq,
>>>> +				 opt_rx->mptcp.dll, opt_rx->mptcp.checksum);
>>>> +		}
>>>>  		break;
>>>>
>>>>  	/* MPTCPOPT_ADD_ADDR
>>>> @@ -175,3 +237,27 @@ unsigned int mptcp_synack_options(struct request_=
sock *req, u64 *local_key,
>>>>  	}
>>>>  	return subflow_req->mp_capable;
>>>>  }
>>>> +
>>>> +void mptcp_queue_headers(struct sock *sk, struct sk_buff *original_sk=
b)
>>>> +{
>>>> +	struct sock_exterr_skb *serr;
>>>> +	struct sk_buff *skb;
>>>> +	int err;
>>>> +
>>>> +	BUILD_BUG_ON(sizeof(struct sock_exterr_skb) > sizeof(skb->cb));
>>>> +
>>>> +	skb =3D skb_clone(original_skb, GFP_ATOMIC);
>>>> +	if (!skb) {
>>>> +		pr_err("clone failed skb=3D%p sk=3D%p", original_skb, sk);
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	serr =3D SKB_EXT_ERR(skb);
>>>> +	memset(serr, 0, sizeof(*serr));
>>>> +	serr->ee.ee_origin =3D SO_EE_ORIGIN_MPTCP;
>>>> +
>>>> +	err =3D sock_queue_err_skb(sk, skb);
>>>> +
>>>> +	if (err)
>>>> +		kfree_skb(skb);
>>>> +}
>>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>>> index dcaaa0dd3784..911428122c9c 100644
>>>> --- a/net/mptcp/protocol.c
>>>> +++ b/net/mptcp/protocol.c
>>>> @@ -16,6 +16,8 @@
>>>>  #include <linux/kernel.h>
>>>>  #include <linux/module.h>
>>>>  #include <linux/netdevice.h>
>>>> +#include <linux/sched/signal.h>
>>>> +#include <linux/atomic.h>
>>>>  #include <net/sock.h>
>>>>  #include <net/inet_common.h>
>>>>  #include <net/inet_hashtables.h>
>>>> @@ -23,6 +25,12 @@
>>>>  #include <net/tcp.h>
>>>>  #include <net/mptcp.h>
>>>>
>>>> +static inline bool before64(__u64 seq1, __u64 seq2)
>>>> +{
>>>> +	return (__s64)(seq1-seq2) < 0;
>>>> +}
>>>> +#define after64(seq2, seq1)	before64(seq1, seq2)
>>>> +
>>>>  static void mptcp_cb_copy(const struct sk_buff *from, struct sk_buff =
*to)
>>>>  {
>>>>  	struct mptcp_skb_cb *mcb =3D from->priv;
>>>> @@ -131,15 +139,12 @@ static int mptcp_sendmsg(struct sock *sk, struct=
 msghdr *msg, size_t len)
>>>>  	skb =3D tcp_write_queue_tail(ssk);
>>>>
>>>>  	refcount_set(&mcb->refcnt, 1);
>>>> -	mcb->data_ack =3D msk->ack_seq;
>>>>  	mcb->data_seq =3D msk->write_seq;
>>>>  	mcb->subflow_seq =3D subflow_sk(ssk)->rel_write_seq;
>>>>  	mcb->dll =3D ret;
>>>>  	mcb->checksum =3D 0xbeef;
>>>>  	mcb->use_map =3D 1;
>>>>  	mcb->dsn64 =3D 1;
>>>> -	mcb->use_ack =3D 1;
>>>> -	mcb->ack64 =3D 1;
>>>>
>>>>  	if (mcb->use_map) {
>>>>  		pr_debug("data_seq=3D%llu subflow_seq=3D%u "
>>>> @@ -170,21 +175,262 @@ static int mptcp_sendmsg(struct sock *sk, struc=
t msghdr *msg, size_t len)
>>>>  	return ret;
>>>>  }
>>>>
>>>> +struct mptcp_read_arg {
>>>> +	struct msghdr *msg;
>>>> +};
>>>> +
>>>> +static u64 expand_seq(u64 old_seq, u16 old_dll, u64 seq)
>>>> +{
>>>> +	if ((u32)seq =3D=3D (u32)old_seq)
>>>> +		return old_seq;
>>>> +
>>>> +	/* Assume map covers data not mapped yet. */
>>>> +	return seq | ((old_seq + old_dll + 1) & ~0xFFFFFFFFULL);
>>>> +}
>>>> +
>>>> +static u64 get_mapped_dsn(struct subflow_sock *subflow)
>>>> +{
>>>> +	u32 map_offset =3D (tcp_sk(sock_sk(subflow))->copied_seq -
>>>> +			  subflow->ssn_offset -
>>>> +			  subflow->map_subflow_seq);
>>>> +
>>>> +	return subflow->map_seq + map_offset;
>>>> +}
>>>> +
>>>> +static int mptcp_read_actor(read_descriptor_t *desc, struct sk_buff *=
skb,
>>>> +			    unsigned int offset, size_t len)
>>>> +{
>>>> +	struct mptcp_read_arg *arg =3D desc->arg.data;
>>>> +	size_t copy_len;
>>>> +
>>>> +	copy_len =3D min(desc->count, len);
>>>> +
>>>> +	if (likely(arg->msg)) {
>>>> +		int err;
>>>> +
>>>> +		err =3D skb_copy_datagram_msg(skb, offset, arg->msg, copy_len);
>>>> +		if (err) {
>>>> +			pr_debug("error path");
>>>> +			desc->error =3D err;
>>>> +			return err;
>>>> +		}
>>>> +	} else {
>>>> +		pr_debug("Flushing skb payload");
>>>> +	}
>>>> +
>>>> +	// MSG_PEEK support? Other flags? MSG_TRUNC?
>>>> +
>>>> +	desc->count -=3D copy_len;
>>>> +
>>>> +	pr_debug("consumed %lu bytes, %lu left", copy_len, desc->count);
>>>> +	return copy_len;
>>>> +}
>>>> +
>>>> +static bool mptcp_get_mapping(struct subflow_sock *subflow)
>>>> +{
>>>> +	struct tcp_options_received opt;
>>>> +	struct sk_buff *skb;
>>>> +	bool found_map =3D false;
>>>> +
>>>> +	do {
>>>> +		pr_debug("Dequeue mapping skb");
>>>> +		skb =3D sock_dequeue_err_skb(sock_sk(subflow));
>>>> +		if (!skb) {
>>>> +			pr_debug("Empty queue");
>>>> +			break;
>>>> +		}
>>>> +
>>>> +		opt.mptcp.dss =3D 0;
>>>> +		opt.mptcp.use_map =3D 0;
>>>> +		opt.mptcp.data_fin =3D 0;
>>>> +		mptcp_get_options(skb, &opt);
>>>> +
>>>> +		if (opt.mptcp.dss && opt.mptcp.use_map) {
>>>> +			pr_debug("seq=3D%llu is64=3D%d ssn=3D%u dll=3D%u ck=3D%u",
>>>> +				 opt.mptcp.seq, opt.mptcp.dsn64,
>>>> +				 opt.mptcp.subflow_seq,
>>>> +				 opt.mptcp.dll, opt.mptcp.checksum);
>>>> +
>>>> +			if (opt.mptcp.dll =3D=3D 0) {
>>>> +				pr_err("Infinite mapping not handled");
>>>> +			} else if (opt.mptcp.subflow_seq =3D=3D 0 &&
>>>> +				   opt.mptcp.data_fin =3D=3D 1) {
>>>> +				pr_debug("DATA_FIN with no payload");
>>>> +				kfree_skb(skb);
>>>> +				break;
>>>> +			}
>>>> +
>>>> +			if (!opt.mptcp.dsn64) {
>>>> +				subflow->map_seq =3D expand_seq(subflow->map_seq,
>>>> +							      subflow->map_dll,
>>>> +							      opt.mptcp.seq);
>>>> +				pr_debug("expanded seq=3D%llu", subflow->map_seq);
>>>> +			} else {
>>>> +				subflow->map_seq =3D opt.mptcp.seq;
>>>> +			}
>>>> +
>>>> +			subflow->map_subflow_seq =3D opt.mptcp.subflow_seq;
>>>> +			subflow->map_dll =3D opt.mptcp.dll;
>>>> +			subflow->map_valid =3D true;
>>>> +			pr_debug("new map seq=3D%llu subflow_seq=3D%u dll=3D%u",
>>>> +				 subflow->map_seq, subflow->map_subflow_seq,
>>>> +				 subflow->map_dll);
>>>> +			found_map =3D true;
>>>> +		}
>>>> +
>>>> +		kfree_skb(skb);
>>>> +	} while (!found_map);
>>>> +
>>>> +	return found_map;
>>>> +}
>>>> +
>>>>  static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t =
len,
>>>>  			 int nonblock, int flags, int *addr_len)
>>>>  {
>>>>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
>>>> -	struct socket *subflow;
>>>> +	struct subflow_sock *subflow;
>>>> +	struct mptcp_read_arg arg;
>>>> +	read_descriptor_t desc;
>>>> +	struct tcp_sock *tp;
>>>> +	struct sock *ssk;
>>>> +	int copied =3D 0;
>>>> +	long timeo;
>>>>
>>>> -	if (msk->connection_list) {
>>>> -		subflow =3D msk->connection_list;
>>>> -		pr_debug("conn_list->subflow=3D%p", subflow->sk);
>>>> -	} else {
>>>> -		subflow =3D msk->subflow;
>>>> -		pr_debug("subflow=3D%p", subflow->sk);
>>>> +	if (!msk->connection_list) {
>>>> +		pr_debug("fallback-read subflow=3D%p", msk->subflow->sk);
>>>> +		return sock_recvmsg(msk->subflow, msg, flags);
>>>>  	}
>>>>
>>>> -	return sock_recvmsg(subflow, msg, flags);
>>>> +	ssk =3D msk->connection_list->sk;
>>>> +	subflow =3D subflow_sk(ssk);
>>>> +	tp =3D tcp_sk(ssk);
>>>> +
>>>> +	desc.arg.data =3D &arg;
>>>> +	desc.error =3D 0;
>>>> +
>>>> +	timeo =3D sock_rcvtimeo(sk, nonblock);
>>>> +
>>>> +	len =3D min_t(size_t, len, INT_MAX);
>>>> +
>>>> +	while (copied < len) {
>>>> +		size_t discard_len =3D 0;
>>>> +		int bytes_read;
>>>> +		u64 ack_seq;
>>>> +		u64 old_ack;
>>>> +		u32 ssn;
>>>> +
>>>> +		pr_debug("map_valid=3D%d", subflow->map_valid);
>>>> +		if (!subflow->map_valid && !mptcp_get_mapping(subflow))
>>>> +			goto wait_for_data;
>>>> +
>>>> +		ssn =3D tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
>>>> +		old_ack =3D atomic64_read(&msk->ack_seq);
>>>> +
>>>> +		if (unlikely(before(ssn, subflow->map_subflow_seq))) {
>>>> +			/* Mapping covers data later in the subflow stream,
>>>> +			 * discard unmapped data. */
>>>> +			pr_debug("Mapping covers data later in stream");
>>>> +			discard_len =3D subflow->map_subflow_seq - ssn;
>>>> +		} else if (unlikely(!before(ssn, (subflow->map_subflow_seq +
>>>> +						  subflow->map_dll)))) {
>>>> +			/* Mapping ends earlier in the subflow stream.
>>>> +			 * Invalidate the mapping and try again.
>>>> +			 */
>>>> +			subflow->map_valid =3D false;
>>>> +			pr_debug("Invalid mapping ssn=3D%d map_seq=3D%d map_dll=3D%d",
>>>> +				 ssn, subflow->map_subflow_seq, subflow->map_dll);
>>>> +			continue;
>>>> +		} else {
>>>> +			ack_seq =3D get_mapped_dsn(subflow);
>>>> +
>>>> +			if (before64(ack_seq, old_ack)) {
>>>> +				/* Mapping covers data already received,
>>>> +				 * discard data in the current mapping
>>>> +				 * and invalidate the map
>>>> +				 */
>>>> +				u64 map_end_dsn =3D subflow->map_seq +
>>>> +					subflow->map_dll;
>>>> +				discard_len =3D min(map_end_dsn - ack_seq,
>>>> +						  old_ack - ack_seq);
>>>> +				subflow->map_valid =3D false;
>>>> +				pr_debug("Duplicate MPTCP data found");
>>>> +			}
>>>> +		}
>>>> +
>>>> +		if (discard_len) {
>>>> +			/* Discard data for the current mapping.
>>>> +			 */
>>>> +			pr_debug("Discard %lu bytes", discard_len);
>>>> +
>>>> +			arg.msg =3D NULL;
>>>> +			desc.count =3D discard_len;
>>>> +
>>>> +			bytes_read =3D tcp_read_sock(ssk, &desc,
>>>> +						   mptcp_read_actor);
>>>> +
>>>> +			if (bytes_read < 0)
>>>> +				break;
>>>> +			else if (bytes_read =3D=3D discard_len)
>>>> +				continue;
>>>> +			else
>>>> +				goto wait_for_data;
>>>> +		}
>>>> +
>>>> +		/* Read mapped data */
>>>> +		desc.count =3D ssn - subflow->map_subflow_seq + subflow->map_dll;
>>>> +		arg.msg =3D msg;
>>>> +		bytes_read =3D tcp_read_sock(ssk, &desc, mptcp_read_actor);
>>>> +		if (bytes_read < 0)
>>>> +			break;
>>>> +
>>>> +		/* Refresh current MPTCP sequence number based on subflow seq */
>>>> +		ack_seq =3D get_mapped_dsn(subflow);
>>>> +
>>>> +		if (before64(old_ack, ack_seq)) {
>>>> +			atomic64_set(&msk->ack_seq, ack_seq);
>>>> +		}
>>>> +
>>>> +		if (!before(tcp_sk(ssk)->copied_seq - subflow->ssn_offset,
>>>> +			    subflow->map_subflow_seq + subflow->map_dll)) {
>>>> +			subflow->map_valid =3D false;
>>>> +			pr_debug("Done with mapping: seq=3D%u dll=3D%u",
>>>> +				 subflow->map_subflow_seq, subflow->map_dll);
>>>> +		}
>>>> +
>>>> +		copied +=3D bytes_read;
>>>> +
>>>> +wait_for_data:
>>>> +		if (copied)
>>>> +			break;
>>>> +
>>>> +		if (tp->urg_data && tp->urg_seq =3D=3D tp->copied_seq) {
>>>> +			pr_err("Urgent data present, cannot proceed");
>>>> +			break;
>>>> +		}
>>>> +
>>>> +		if (ssk->sk_err || ssk->sk_state =3D=3D TCP_CLOSE ||
>>>> +		    (ssk->sk_shutdown & RCV_SHUTDOWN) || !timeo ||
>>>> +		    signal_pending(current)) {
>>>> +			pr_debug("nonblock or error");
>>>> +			break;
>>>> +		}
>>>> +
>>>> +		/* Handle blocking and retry read if needed.
>>>> +		 *
>>>> +		 * Wait on MPTCP sock, the subflow will notify via data ready.
>>>> +		 */
>>>> +
>>>> +		pr_debug("block");
>>>> +		release_sock(ssk);
>>>> +		sk_wait_data(sk, &timeo, NULL);
>>>> +		lock_sock(ssk);
>>>> +
>>>> +	}
>>>> +
>>>> +	release_sock(ssk);
>>>> +	release_sock(sk);
>>>> +
>>>> +	return copied;
>>>>  }
>>>>
>>>>  static int mptcp_init_sock(struct sock *sk)
>>>> @@ -240,18 +486,27 @@ static struct sock *mptcp_accept(struct sock *sk=
, int flags, int *err,
>>>>  	subflow->conn =3D mp->sk;
>>>>
>>>>  	if (subflow->mp_capable) {
>>>> +		u64 ack_seq;
>>>> +
>>>> +		msk->remote_key =3D subflow->remote_key;
>>>>  		msk->local_key =3D subflow->local_key;
>>>>  		msk->token =3D subflow->token;
>>>> +		pr_debug("token=3D%u", msk->token);
>>>>  		token_update_accept(new_sock->sk, mp->sk);
>>>> +		msk->connection_list =3D new_sock;
>>>> +
>>>> +		crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
>>>>  		msk->write_seq =3D subflow->idsn + 1;
>>>> +		ack_seq++;
>>>> +		atomic64_set(&msk->ack_seq, ack_seq);
>>>> +		subflow->map_seq =3D ack_seq;
>>>> +		subflow->map_subflow_seq =3D 1;
>>>>  		subflow->rel_write_seq =3D 1;
>>>> -		msk->remote_key =3D subflow->remote_key;
>>>> -		crypto_key_sha1(msk->remote_key, NULL, &msk->ack_seq);
>>>> -		msk->ack_seq++;
>>>> -		msk->connection_list =3D new_sock;
>>>> +		subflow->conn =3D mp->sk;
>>>>  	} else {
>>>>  		msk->subflow =3D new_sock;
>>>>  	}
>>>> +	inet_sk_state_store(sk, TCP_ESTABLISHED);
>>>>
>>>>  	return mp->sk;
>>>>  }
>>>> @@ -329,17 +584,24 @@ void mptcp_finish_connect(struct sock *sk, int m=
p_capable)
>>>>  	pr_debug("msk=3D%p", msk);
>>>>
>>>>  	if (mp_capable) {
>>>> +		u64 ack_seq;
>>>> +
>>>> +		msk->remote_key =3D subflow->remote_key;
>>>>  		msk->local_key =3D subflow->local_key;
>>>>  		msk->token =3D subflow->token;
>>>> -		msk->write_seq =3D subflow->idsn + 1;
>>>> -		subflow->rel_write_seq =3D 1;
>>>> -		msk->remote_key =3D subflow->remote_key;
>>>> -		crypto_key_sha1(msk->remote_key, NULL, &msk->ack_seq);
>>>> -		msk->ack_seq++;
>>>> +		pr_debug("token=3D%u", msk->token);
>>>>  		msk->connection_list =3D msk->subflow;
>>>>  		msk->subflow =3D NULL;
>>>> +
>>>> +		crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
>>>> +		msk->write_seq =3D subflow->idsn + 1;
>>>> +		ack_seq++;
>>>> +		atomic64_set(&msk->ack_seq, ack_seq);
>>>> +		subflow->map_seq =3D ack_seq;
>>>> +		subflow->map_subflow_seq =3D 1;
>>>> +		subflow->rel_write_seq =3D 1;
>>>>  	}
>>>> -	sk->sk_state =3D TCP_ESTABLISHED;
>>>> +	inet_sk_state_store(sk, TCP_ESTABLISHED);
>>>>  }
>>>>
>>>>  static int subflow_create(struct sock *sock)
>>>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>>>> index e0b4aa8fe51d..3c9dca4be26a 100644
>>>> --- a/net/mptcp/subflow.c
>>>> +++ b/net/mptcp/subflow.c
>>>> @@ -107,6 +107,8 @@ static void subflow_v4_init_req(struct request_soc=
k *req,
>>>>  		subflow_req->remote_key =3D rx_opt.mptcp.sndr_key;
>>>>  		pr_debug("remote_key=3D%llu", subflow_req->remote_key);
>>>>  		token_new_request(req, skb);
>>>> +		pr_debug("syn seq=3D%u", TCP_SKB_CB(skb)->seq);
>>>> +		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq;
>>>>  	} else {
>>>>  		subflow_req->mp_capable =3D 0;
>>>>  	}
>>>> @@ -120,10 +122,15 @@ static void subflow_finish_connect(struct sock *=
sk, const struct sk_buff *skb)
>>>>
>>>>  	pr_debug("subflow=3D%p", subflow);
>>>>
>>>> -	if (subflow->conn) {
>>>> +	if (!subflow->conn_finished) {
>>>>  		pr_debug("remote_key=3D%llu", subflow->remote_key);
>>>>  		mptcp_finish_connect(subflow->conn, subflow->mp_capable);
>>>> -		subflow->conn =3D NULL;
>>>> +		subflow->conn_finished =3D 1;
>>>> +
>>>> +		if (skb) {
>>>> +			pr_debug("synack seq=3D%u", TCP_SKB_CB(skb)->seq);
>>>> +			subflow->ssn_offset =3D TCP_SKB_CB(skb)->seq;
>>>> +		}
>>>>  	}
>>>>  }
>>>>
>>>> @@ -172,7 +179,9 @@ static struct sock *subflow_syn_recv_sock(const st=
ruct sock *sk,
>>>>  			subflow->fourth_ack =3D 1;
>>>>  			subflow->remote_key =3D subflow_req->remote_key;
>>>>  			subflow->local_key =3D subflow_req->local_key;
>>>> +			subflow->ssn_offset =3D subflow_req->ssn_offset;
>>>>  			subflow->token =3D subflow_req->token;
>>>> +			subflow->idsn =3D subflow_req->idsn;
>>>>  			pr_debug("token=3D%u", subflow->token);
>>>>  			token_new_accept(child);
>>>>  		} else {
>>>> @@ -202,6 +211,20 @@ const struct inet_connection_sock_af_ops subflow_=
specific =3D {
>>>>  	.mtu_reduced	   =3D tcp_v4_mtu_reduced,
>>>>  };
>>>>
>>>> +static void subflow_data_ready(struct sock *sk)
>>>> +{
>>>> +	struct subflow_sock *subflow =3D subflow_sk(sk);
>>>> +	struct sock *parent =3D subflow->conn;
>>>> +
>>>> +	pr_debug("sk=3D%p", sk);
>>>> +	subflow->tcp_sk_data_ready(sk);
>>>> +
>>>> +	if (parent) {
>>>> +		pr_debug("parent=3D%p", parent);
>>>> +		parent->sk_data_ready(parent);
>>>> +	}
>>>> +}
>>>> +
>>>>  static int subflow_init_sock(struct sock *sk)
>>>>  {
>>>>  	struct subflow_sock *subflow =3D subflow_sk(sk);
>>>> @@ -215,6 +238,8 @@ static int subflow_init_sock(struct sock *sk)
>>>>  	if (!err) { // @@ AND mptcp is enabled
>>>>  		tsk->is_mptcp =3D 1;
>>>>  		icsk->icsk_af_ops =3D &subflow_specific;
>>>> +		subflow->tcp_sk_data_ready =3D sk->sk_data_ready;
>>>> +		sk->sk_data_ready =3D subflow_data_ready;
>>>>  	}
>>>>
>>>>  	return err;
>>>> --
>>>> 2.19.1
>>>>
>>>> _______________________________________________
>>>> mptcp mailing list
>>>> mptcp(a)lists.01.org
>>>> https://lists.01.org/mailman/listinfo/mptcp
>>>
>>
>> --
>> Mat Martineau
>> Intel OTC
>

--
Mat Martineau
Intel OTC

--===============0728473125596113053==--
