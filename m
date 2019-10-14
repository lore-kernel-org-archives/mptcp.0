Content-Type: multipart/mixed; boundary="===============5850710076581811450=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 2/3] mptcp: flush duplicate data at
 data_ready() time
Date: Mon, 14 Oct 2019 16:28:15 -0700
Message-ID: <alpine.OSX.2.21.1910141542270.18802@ntadesse-mobl.amr.corp.intel.com>
In-Reply-To: 25e34d82a98e9b9dc325a9408912d5c0cc1fe95c.1570834035.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2129

--===============5850710076581811450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, 13 Oct 2019, Paolo Abeni wrote:

> Move subflow mapping related function to subflow.c - I think
> they belong there.
>
> Refactor slightly get_mapping() to additionally validate the
> current mapping, moving some code from mptcp_recvmsg().
>
> mptcp_data_ready() drops any skb which does not match exactly
> the current MPTCP seq number.
>
> Old seqs are likely spurious retransmit we really want to ignore
> "future" seq may really happen in case of active backup switch-over,
> but we should converge to the current seq via 'correct' MPTCP-level
> retransmissions.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/protocol.c | 187 +-----------------------------
> net/mptcp/protocol.h |  10 +-
> net/mptcp/subflow.c  | 270 ++++++++++++++++++++++++++++++++++++++++++-
> 3 files changed, 279 insertions(+), 188 deletions(-)

(no comments for protocol.c)

>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 98080d9f72fd..6e36207d9800 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -204,8 +204,8 @@ struct mptcp_subflow_context {
> 	u32     rel_write_seq;
> 	u32	map_subflow_seq;
> 	u32	ssn_offset;
> -	u16	map_data_len;
> -	u16	request_mptcp : 1,  /* send MP_CAPABLE */
> +	u32	map_data_len;

Is this changed to u32 to fill the new hole in the data structure? The =

mapping length is 16 bits in RFC6824/6824bis.

> +	u32	request_mptcp : 1,  /* send MP_CAPABLE */
> 		request_join : 1,   /* send MP_JOIN */
> 		request_bkup : 1,
> 		request_version : 4,
> @@ -214,7 +214,9 @@ struct mptcp_subflow_context {
> 		fourth_ack : 1,     /* send initial DSS */
> 		conn_finished : 1,
> 		map_valid : 1,
> -		backup : 1;
> +		backup : 1,
> +		data_avail : 1,
> +		rx_eof : 1;
> 	u32	remote_nonce;
> 	u64	thmac;
> 	u32	local_nonce;
> @@ -260,7 +262,7 @@ mptcp_subflow_get_mapped_dsn(struct mptcp_subflow_con=
text *subflow)
> }
>
> int mptcp_is_enabled(struct net *net);
> -
> +bool mptcp_subflow_data_available(struct sock *sk);
> void mptcp_subflow_init(void);
> int mptcp_subflow_connect(struct sock *sk, struct sockaddr_in *local,
> 			  struct sockaddr_in *remote, u8 remote_id);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index ebe93525b0aa..e5ea2eba6537 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -311,17 +311,281 @@ static struct sock *subflow_syn_recv_sock(const st=
ruct sock *sk,
>
> static struct inet_connection_sock_af_ops subflow_specific;
>
> +enum mapping_status {
> +	MAPPING_OK,
> +	MAPPING_INVALID,
> +	MAPPING_EMPTY,
> +	MAPPING_DATA_FIN
> +};
> +
> +static u64 expand_seq(u64 old_seq, u16 old_data_len, u64 seq)
> +{
> +	if ((u32)seq =3D=3D (u32)old_seq)
> +		return old_seq;
> +
> +	/* Assume map covers data not mapped yet. */
> +	return seq | ((old_seq + old_data_len + 1) & GENMASK_ULL(63, 32));
> +}
> +
> +static void warn_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
> +{
> +	WARN_ONCE(1, "Bad mapping: ssn=3D%d map_seq=3D%d map_data_len=3D%d",
> +		  ssn, subflow->map_subflow_seq, subflow->map_data_len);
> +}
> +
> +static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)

skb is unused.

> +{
> +	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> +	u32 ssn =3D tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
> +
> +	if (unlikely(before(ssn, subflow->map_subflow_seq))) {
> +		/* Mapping covers data later in the subflow stream,
> +		 * currently unsupported.
> +		 */
> +		warn_bad_map(subflow, ssn);
> +		return false;
> +	}
> +	if (unlikely(!before(ssn, (subflow->map_subflow_seq +
> +					  subflow->map_data_len)))) {
> +		/* Mapping ends earlier in the subflow stream. Invalid */
> +		warn_bad_map(subflow, ssn);
> +		return false;
> +	}
> +	return true;
> +}
> +
> +static enum mapping_status get_mapping_status(struct sock *ssk)
> +{
> +	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> +	struct mptcp_ext *mpext;
> +	struct sk_buff *skb;
> +	u64 map_seq;
> +
> +	skb =3D skb_peek(&ssk->sk_receive_queue);
> +	if (!skb)
> +		return MAPPING_EMPTY;
> +
> +	mpext =3D mptcp_get_ext(skb);
> +	if (!mpext || !mpext->use_map) {
> +		if (!subflow->map_valid && !skb->len) {
> +			/* the TCP stack deliver 0 len FIN pkt to the receive
> +			* queue, that is the only 0len pkts ever expected here,
> +			* and we can admit no mapping only for 0 len pkts
> +			*/
> +			if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN))
> +				WARN_ONCE(1, "0len seq %d:%d flags %x",
> +					  TCP_SKB_CB(skb)->seq,
> +					  TCP_SKB_CB(skb)->end_seq,
> +					  TCP_SKB_CB(skb)->tcp_flags);
> +			sk_eat_skb(ssk, skb);
> +			return MAPPING_EMPTY;
> +		}
> +
> +		if (!subflow->map_valid)
> +			return MAPPING_INVALID;
> +		goto validate_seq;

Is there a need to re-validate the existing mapping when =

subflow->map_valid is true and this function hasn't modified the mapping?

> +	}
> +
> +	pr_debug("seq=3D%llu is64=3D%d ssn=3D%u data_len=3D%u", mpext->data_seq,
> +		 mpext->dsn64, mpext->subflow_seq, mpext->data_len);
> +
> +	if (mpext->data_len =3D=3D 0) {
> +		pr_err("Infinite mapping not handled");
> +		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
> +		return MAPPING_INVALID;
> +	} else if (mpext->subflow_seq =3D=3D 0 &&
> +		   mpext->data_fin =3D=3D 1) {
> +		if (WARN_ON_ONCE(mpext->data_len !=3D 1))
> +			return false;
> +
> +		pr_debug("DATA_FIN with no payload");
> +		return MAPPING_OK;
> +	}
> +
> +	if (!mpext->dsn64) {
> +		map_seq =3D expand_seq(subflow->map_seq, subflow->map_data_len,
> +				     mpext->data_seq);
> +		pr_debug("expanded seq=3D%llu", subflow->map_seq);
> +	} else {
> +		map_seq =3D mpext->data_seq;
> +	}
> +
> +	if (subflow->map_valid) {
> +		/* check for in-sequence new map; since the current mapping
> +		 * still valid, we can't replace it yet; instead increase the
> +		 * current mapping size
> +		 */
> +		if (subflow->map_seq + subflow->map_data_len =3D=3D mpext->data_seq) {
> +			subflow->map_data_len +=3D mpext->data_len;
> +			goto validate_seq;
> +		}

When checksums are added this gets more complicated, but I think it's ok =

for now.

> +
> +		/* Allow replacing only with a map extending the current one */

Regarding this comment: the code below is also intended to allow duplicate =

mappings (not only extension of the current one).

> +		if (subflow->map_seq !=3D mpext->data_seq ||
> +		    subflow->map_subflow_seq !=3D mpext->subflow_seq ||
> +		    subflow->map_data_len < mpext->data_len) {

Should this instead invalidate the mapping when subflow->map_data_len > =

mpext->data_len ?

> +			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSNOMATCH);
> +			return MAPPING_INVALID;
> +		}
> +
> +		subflow->map_data_len =3D mpext->data_len;

Does it make sense to add a skb_ext_del() here to avoid processing the DSS =

option again?

> +		return MAPPING_OK;
> +	}
> +
> +	subflow->map_seq =3D map_seq;
> +	subflow->map_subflow_seq =3D mpext->subflow_seq;
> +	subflow->map_data_len =3D mpext->data_len;
> +	subflow->map_valid =3D 1;
> +	pr_debug("new map seq=3D%llu subflow_seq=3D%u data_len=3D%u",
> +		 subflow->map_seq, subflow->map_subflow_seq,
> +		 subflow->map_data_len);
> +
> +validate_seq:
> +	if (!validate_mapping(ssk, skb))
> +		return MAPPING_INVALID;
> +
> +	skb_ext_del(skb, SKB_EXT_MPTCP);
> +	return MAPPING_OK;
> +}
> +
> +static bool subflow_check_data_avail(struct sock *ssk)
> +{
> +	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> +	enum mapping_status status;
> +	struct mptcp_sock *msk;
> +	struct sk_buff *skb;
> +
> +	pr_debug("msk=3D%p ssk=3D%p data_avail=3D%d skb=3D%p", subflow->conn, s=
sk,
> +		 subflow->data_avail, skb_peek(&ssk->sk_receive_queue));
> +	if (subflow->data_avail)
> +		return true;
> +
> +	if (!subflow->conn)
> +		return false;
> +
> +	msk =3D mptcp_sk(subflow->conn);
> +	for (;;) {
> +		u32 map_remaining;
> +		size_t delta;
> +		u64 ack_seq;
> +		u64 old_ack;
> +
> +		status =3D get_mapping_status(ssk);
> +		pr_debug("msk=3D%p ssk=3D%p status=3D%d", msk, ssk, status);
> +		if (status =3D=3D MAPPING_INVALID) {
> +			ssk->sk_err =3D EBADMSG;
> +			goto fatal;
> +		}
> +
> +		if (status !=3D MAPPING_OK)
> +			return false;
> +
> +		skb =3D skb_peek(&ssk->sk_receive_queue);
> +		if (WARN_ON_ONCE(!skb))
> +			return false;
> +
> +		old_ack =3D READ_ONCE(msk->ack_seq);
> +		ack_seq =3D mptcp_subflow_get_mapped_dsn(subflow);
> +		pr_debug("msk ack_seq=3D%llx subflow ack_seq=3D%llx", old_ack,
> +			 ack_seq);
> +		if (ack_seq =3D=3D old_ack)
> +			break;
> +
> +		/* only accept in-sequence mapping. Old values are spurious
> +		 * retransmission; we can hit "future" values on active backup
> +		 * subflow switch, we relay on retransmissions to get
> +		 * in-sequence data.
> +		 * Cuncurrent subflows support will require subflow data
> +		 * reordering
> +		 */
> +		map_remaining =3D subflow->map_data_len -
> +				mptcp_subflow_get_map_offset(subflow);
> +		if (before64(ack_seq, old_ack))
> +			delta =3D min_t(size_t, old_ack - ack_seq, map_remaining);
> +		else
> +			delta =3D min_t(size_t, ack_seq - old_ack, map_remaining);
> +
> +		/* discard mapping data */

s/mapping/mapped/


Overall, the refactoring is an improvement. Thanks!

Mat


> +		pr_debug("discarding %ld bytes, current map len=3D%d", delta,
> +			 map_remaining);
> +		if (delta) {
> +			struct mptcp_read_arg arg =3D {
> +				.msg =3D NULL,
> +			};
> +			read_descriptor_t desc =3D {
> +				.count =3D delta,
> +				.arg.data =3D &arg,
> +			};
> +			int ret;
> +
> +			ret =3D tcp_read_sock(ssk, &desc, mptcp_read_actor);
> +			if (ret < 0) {
> +				ssk->sk_err =3D -ret;
> +				goto fatal;
> +			}
> +			if (ret < delta)
> +				return false;
> +			if (delta =3D=3D map_remaining)
> +				subflow->map_valid =3D 0;
> +		}
> +	}
> +	return true;
> +
> +fatal:
> +	/* fatal protocol error, close the socket */
> +	/* This barrier is coupled with smp_rmb() in tcp_poll() */
> +	smp_wmb();
> +	ssk->sk_error_report(ssk);
> +	tcp_set_state(ssk, TCP_CLOSE);
> +	tcp_send_active_reset(ssk, GFP_ATOMIC);
> +	return false;
> +}
> +
> +bool mptcp_subflow_data_available(struct sock *sk)
> +{
> +	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
> +	struct sk_buff *skb;
> +
> +	/* check if current mapping is still valid */
> +	if (subflow->map_valid &&
> +	    mptcp_subflow_get_map_offset(subflow) >=3D subflow->map_data_len) {
> +		subflow->map_valid =3D 0;
> +		subflow->data_avail =3D 0;
> +
> +		pr_debug("Done with mapping: seq=3D%u data_len=3D%u",
> +			 subflow->map_subflow_seq,
> +			 subflow->map_data_len);
> +	}
> +
> +	if (!subflow_check_data_avail(sk)) {
> +		/* set EoF only there is no data available - we already spooled
> +		 * all the pending skbs
> +		 */
> +		if (sk->sk_shutdown & RCV_SHUTDOWN || sk->sk_state =3D=3D TCP_CLOSE)
> +			subflow->rx_eof =3D 1;
> +		return false;
> +	}
> +
> +	skb =3D skb_peek(&sk->sk_receive_queue);
> +	if (!skb)
> +		return false;
> +
> +	subflow->data_avail =3D tcp_sk(sk)->copied_seq < TCP_SKB_CB(skb)->end_s=
eq;
> +	return subflow->data_avail;
> +}
> +
> static void subflow_data_ready(struct sock *sk)
> {
> 	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
> 	struct sock *parent =3D subflow->conn;
>
> -	pr_debug("sk=3D%p", sk);
> 	subflow->tcp_sk_data_ready(sk);
>
> -	if (parent) {
> -		pr_debug("parent=3D%p", parent);
> +	if (!parent || !(subflow->mp_capable || subflow->mp_join))
> +		return;
>
> +	/* always propagate the EoF */
> +	if (mptcp_subflow_data_available(sk) || subflow->rx_eof) {
> 		smp_mb__before_atomic();
> 		set_bit(MPTCP_DATA_READY, &mptcp_sk(parent)->flags);
> 		smp_mb__after_atomic();
> -- =

> 2.21.0
>
>

--
Mat Martineau
Intel
--===============5850710076581811450==--
