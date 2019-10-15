Content-Type: multipart/mixed; boundary="===============6815609632534648259=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 2/3] mptcp: flush duplicate data at
 data_ready() time
Date: Tue, 15 Oct 2019 12:47:21 +0200
Message-ID: <cdc98748c1bcea2201f626496205b68aa53d6bde.camel@redhat.com>
In-Reply-To: alpine.OSX.2.21.1910141542270.18802@ntadesse-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2135

--===============6815609632534648259==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for the review.

On Mon, 2019-10-14 at 16:28 -0700, Mat Martineau wrote:
[...]
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 98080d9f72fd..6e36207d9800 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -204,8 +204,8 @@ struct mptcp_subflow_context {
> > 	u32     rel_write_seq;
> > 	u32	map_subflow_seq;
> > 	u32	ssn_offset;
> > -	u16	map_data_len;
> > -	u16	request_mptcp : 1,  /* send MP_CAPABLE */
> > +	u32	map_data_len;
> =

> Is this changed to u32 to fill the new hole in the data structure? The =

> mapping length is 16 bits in RFC6824/6824bis.

This is needed because this patch also introduces trivial mapping
coalescing, a few hunks below. It also will allow more extensive skb
colaescing some day ;)
> =

> > +	u32	request_mptcp : 1,  /* send MP_CAPABLE */
> > 		request_join : 1,   /* send MP_JOIN */
> > 		request_bkup : 1,
> > 		request_version : 4,
> > @@ -214,7 +214,9 @@ struct mptcp_subflow_context {
> > 		fourth_ack : 1,     /* send initial DSS */
> > 		conn_finished : 1,
> > 		map_valid : 1,
> > -		backup : 1;
> > +		backup : 1,
> > +		data_avail : 1,
> > +		rx_eof : 1;
> > 	u32	remote_nonce;
> > 	u64	thmac;
> > 	u32	local_nonce;

[...]
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
> =

> Is there a need to re-validate the existing mapping when =

> subflow->map_valid is true and this function hasn't modified the mapping?

I'm not actually 110% this is strictly necessary, but I introduced that
as an additional safeguards ad validate_mapping() depends on the
current ssn, and such sequence can be changed since last validation, as
it's cheap.

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
> > +		pr_debug("DATA_FIN with no payload");
> > +		return MAPPING_OK;
> > +	}
> > +
> > +	if (!mpext->dsn64) {
> > +		map_seq =3D expand_seq(subflow->map_seq, subflow->map_data_len,
> > +				     mpext->data_seq);
> > +		pr_debug("expanded seq=3D%llu", subflow->map_seq);
> > +	} else {
> > +		map_seq =3D mpext->data_seq;
> > +	}
> > +
> > +	if (subflow->map_valid) {
> > +		/* check for in-sequence new map; since the current mapping
> > +		 * still valid, we can't replace it yet; instead increase the
> > +		 * current mapping size
> > +		 */
> > +		if (subflow->map_seq + subflow->map_data_len =3D=3D mpext->data_seq)=
 {
> > +			subflow->map_data_len +=3D mpext->data_len;
> > +			goto validate_seq;
> > +		}
> =

> When checksums are added this gets more complicated, but I think it's ok =

> for now.

yep! gladly we don't have that now ;)

> > +
> > +		/* Allow replacing only with a map extending the current one */
> =

> Regarding this comment: the code below is also intended to allow duplicat=
e =

> mappings (not only extension of the current one).
> =

> > +		if (subflow->map_seq !=3D mpext->data_seq ||
> > +		    subflow->map_subflow_seq !=3D mpext->subflow_seq ||
> > +		    subflow->map_data_len < mpext->data_len) {
> =

> Should this instead invalidate the mapping when subflow->map_data_len > =

> mpext->data_len ?

uhmm... this code followed some discussion on the ML and a few mtgs
ago.  My [mis]understanding is that we can[/want] be quite strict about
map replacing: allowing it only if the old and the new maps are
identical.

With the proposed alternative check we will allow also several kind of
partial overlaps. I think could still be safe, but I would opt for a
more conservative approach, if possible.

The implemented condition a bit weeker of my understanding of the
preferred option, allowing the replace even if the new map completely
overlap with the old one and additionally extends it. I did that
because - due to some bug in the previous private version of these
patches - I stumbled upon the above condition.

I can adapt to the stricter rule, if agreed.

> > +			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSNOMATCH);
> > +			return MAPPING_INVALID;
> > +		}
> > +
> > +		subflow->map_data_len =3D mpext->data_len;
> =

> Does it make sense to add a skb_ext_del() here to avoid processing the DS=
S =

> option again?

Indeed! will do in the next iteration.

Note: I think we get the greater performance benefit here from hitting
more consistently the slab fast path for skb ext life cycle.

[...]
> +		/* only accept in-sequence mapping. Old values are spurious
> > +		 * retransmission; we can hit "future" values on active backup
> > +		 * subflow switch, we relay on retransmissions to get
> > +		 * in-sequence data.
> > +		 * Cuncurrent subflows support will require subflow data
> > +		 * reordering
> > +		 */
> > +		map_remaining =3D subflow->map_data_len -
> > +				mptcp_subflow_get_map_offset(subflow);
> > +		if (before64(ack_seq, old_ack))
> > +			delta =3D min_t(size_t, old_ack - ack_seq, map_remaining);
> > +		else
> > +			delta =3D min_t(size_t, ack_seq - old_ack, map_remaining);
> > +
> > +		/* discard mapping data */
> =

> s/mapping/mapped/

Yep, thanks. will cover in the next iteration!

cheers,

Paolo

--===============6815609632534648259==--
