Content-Type: multipart/mixed; boundary="===============4431113801554002619=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 2/3] mptcp: flush duplicate data at data_ready()
 time
Date: Wed, 16 Oct 2019 09:24:35 +0200
Message-ID: <9fa80d643393f67f319fde3711b381d891afa9df.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1910151643380.44426@hshang-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2164

--===============4431113801554002619==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-10-15 at 16:53 -0700, Mat Martineau wrote:
> On Tue, 15 Oct 2019, Paolo Abeni wrote:
> =

> > Move subflow mapping related function to subflow.c - I think
> > they belong there.
> > =

> > Refactor slightly get_mapping() to additionally validate the
> > current mapping, moving some code from mptcp_recvmsg().
> > =

> > mptcp_data_ready() drops any skb which does not match exactly
> > the current MPTCP seq number.
> > =

> > Old seqs are likely spurious retransmit we really want to ignore
> > "future" seq may really happen in case of active backup switch-over,
> > but we should converge to the current seq via 'correct' MPTCP-level
> > retransmissions.
> > =

> > Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> > ---
> > RFC -> v1:
> > - stricter checking in validate_mapping(): the skb
> >   must be fully covered by the current mapping
> > - always re-validate valid mapping on new skb
> > - always drop skb ext on MAP_OK
> > - explicitly handle possible map_len overflow on
> >   map coalescing
> > - added a bunch of hopefully more descriptive comments
> > ---
> > net/mptcp/protocol.c | 187 +---------------------------
> > net/mptcp/protocol.h |  10 +-
> > net/mptcp/subflow.c  | 289 ++++++++++++++++++++++++++++++++++++++++++-
> > 3 files changed, 298 insertions(+), 188 deletions(-)
> > =

> =

> ...
> =

> > diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> > index b0cda95fbe20..b2fd57341889 100644
> > --- a/net/mptcp/subflow.c
> > +++ b/net/mptcp/subflow.c
> > @@ -311,17 +311,300 @@ static struct sock *subflow_syn_recv_sock(const =
struct sock *sk,
> > =

> > static struct inet_connection_sock_af_ops subflow_specific;
> > =

> > +enum mapping_status {
> > +	MAPPING_OK,
> > +	MAPPING_INVALID,
> > +	MAPPING_EMPTY,
> > +	MAPPING_DATA_FIN
> > +};
> > +
> > +static u64 expand_seq(u64 old_seq, u16 old_data_len, u64 seq)
> > +{
> > +	if ((u32)seq =3D=3D (u32)old_seq)
> > +		return old_seq;
> > +
> > +	/* Assume map covers data not mapped yet. */
> > +	return seq | ((old_seq + old_data_len + 1) & GENMASK_ULL(63, 32));
> > +}
> > +
> > +static void warn_bad_map(struct mptcp_subflow_context *subflow, u32 ss=
n)
> > +{
> > +	WARN_ONCE(1, "Bad mapping: ssn=3D%d map_seq=3D%d map_data_len=3D%d",
> > +		  ssn, subflow->map_subflow_seq, subflow->map_data_len);
> > +}
> > +
> > +static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
> > +{
> > +	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> > +	u32 ssn =3D tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
> > +
> > +	if (unlikely(before(ssn, subflow->map_subflow_seq))) {
> > +		/* Mapping covers data later in the subflow stream,
> > +		 * currently unsupported.
> > +		 */
> > +		warn_bad_map(subflow, ssn);
> > +		return false;
> > +	}
> > +	if (unlikely(after(ssn + skb->len, subflow->map_subflow_seq +
> > +					   subflow->map_data_len))) {
> > +		/* Mapping does not cover the full skb. Invalid */
> > +		warn_bad_map(subflow, ssn + skb->len);
> > +		return false;
> > +	}
> > +	return true;
> > +}
> > +
> > +static enum mapping_status get_mapping_status(struct sock *ssk)
> > +{
> > +	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> > +	struct mptcp_ext *mpext;
> > +	struct sk_buff *skb;
> > +	u64 map_seq;
> > +
> > +	skb =3D skb_peek(&ssk->sk_receive_queue);
> > +	if (!skb)
> > +		return MAPPING_EMPTY;
> > +
> > +	mpext =3D mptcp_get_ext(skb);
> > +	if (!mpext || !mpext->use_map) {
> > +		if (!subflow->map_valid && !skb->len) {
> > +			/* the TCP stack deliver 0 len FIN pkt to the receive
> > +			* queue, that is the only 0len pkts ever expected here,
> > +			* and we can admit no mapping only for 0 len pkts
> > +			*/
> > +			if (!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN))
> > +				WARN_ONCE(1, "0len seq %d:%d flags %x",
> > +					  TCP_SKB_CB(skb)->seq,
> > +					  TCP_SKB_CB(skb)->end_seq,
> > +					  TCP_SKB_CB(skb)->tcp_flags);
> > +			sk_eat_skb(ssk, skb);
> > +			return MAPPING_EMPTY;
> > +		}
> > +
> > +		if (!subflow->map_valid)
> > +			return MAPPING_INVALID;
> > +		goto validate_seq;
> > +	}
> > +
> > +	pr_debug("seq=3D%llu is64=3D%d ssn=3D%u data_len=3D%u", mpext->data_s=
eq,
> > +		 mpext->dsn64, mpext->subflow_seq, mpext->data_len);
> > +
> > +	if (mpext->data_len =3D=3D 0) {
> > +		pr_err("Infinite mapping not handled");
> > +		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
> > +		return MAPPING_INVALID;
> > +	} else if (mpext->subflow_seq =3D=3D 0 &&
> > +		   mpext->data_fin =3D=3D 1) {
> > +		if (WARN_ON_ONCE(mpext->data_len !=3D 1))
> > +			return false;
> > +
> > +		/* do not try hard to handle this any better, till we have
> > +		 * real data_fin support
> > +		 */
> > +		pr_debug("DATA_FIN with no payload");
> > +		return MAPPING_OK;
> =

> The selftests ran ok, but when I tested against the multipath-tcp.org 0.9=
5 =

> kernel (upstream code listening, 0.95 connecting) I got stuck in an =

> infinite loop right after the "DATA_FIN with now payload" debug message:
> =

> [ 1400.701168] get_mapping_status: MPTCP: seq=3D1608718165 is64=3D0 ssn=
=3D0 =

> data_len=3D1
> [ 1400.703524] get_mapping_status: MPTCP: DATA_FIN with no payload
> [ 1400.704981] subflow_check_data_avail: MPTCP: msk=3D0000000033ef992f =

> ssk=3D00000000bf3516c5 status=3D0
> [ 1400.706184] subflow_check_data_avail: MPTCP: msk =

> ack_seq=3D47a0403f5fe31755 subflow ack_seq=3D47a0403f5fe31755
> [ 1400.707906] mptcp_recvmsg: MPTCP: msk=3D0000000033ef992f =

> ssk=3D00000000bf3516c5
> [ 1400.709878] subflow_check_data_avail: MPTCP: msk=3D0000000033ef992f =

> ssk=3D00000000bf3516c5 data_avail=3D1 skb=3D00000000163802aa
> [ 1400.711261] mptcp_recvmsg: MPTCP: reading 0 bytes, copied 0
> [ 1400.713431] mptcp_recvmsg: MPTCP: msk ack_seq=3D47a0403f5fe31755 -> =

> 47a0403f5fe31755
> [ 1400.714652] subflow_check_data_avail: MPTCP: msk=3D0000000033ef992f =

> ssk=3D00000000bf3516c5 data_avail=3D1 skb=3D00000000ecda9abb
> [ 1400.716289] mptcp_recvmsg: MPTCP: msk=3D0000000033ef992f =

> ssk=3D00000000bf3516c5
> [ 1400.718560] subflow_check_data_avail: MPTCP: msk=3D0000000033ef992f =

> ssk=3D00000000bf3516c5 data_avail=3D1 skb=3D00000000ecda9abb
> [ 1400.720005] mptcp_recvmsg: MPTCP: msk=3D0000000033ef992f =

> ssk=3D00000000bf3516c5
> <repeats last two messages until forced VM destruction...>
> =

> Changing this line of code to "return MAPPING_DATA_FIN" prevents the loop=
, =

> and the selftests still succeed.

Thank you for the additional testing. I did not very vs mptcp.org,
sorry.

Likely, with the posted code, we end-up with a 'valid' mapping that
can't be really consumed, ence the loop. The change you suggested look
good to me. I'll post a v2 incorporating that.

Thanks,

Paolo

--===============4431113801554002619==--
