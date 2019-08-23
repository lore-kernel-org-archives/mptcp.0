Content-Type: multipart/mixed; boundary="===============6347003459962093839=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC PATCH v2 2/8] mptcp: update per subflow unacked
 sequence on pkt reception
Date: Thu, 22 Aug 2019 17:34:23 -0700
Message-ID: <alpine.OSX.2.21.1908221624420.27597@gargpiyu-mobl1.amr.corp.intel.com>
In-Reply-To: c0f17ae559af2f38f61401479e5f6715fd96a279.1566481012.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1686

--===============6347003459962093839==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 22 Aug 2019, Paolo Abeni wrote:

> So that we keep per subflow unacked sequence number consistent;
> since we update only per socket data, no additional locking is
> required.
>
> Subflow and msk unacked seq are updated at different stages
> to keep the locking schema simple.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> rfc v1 -> rfc v2:
> - initialize subflow snd_una on subflow connect()/accept()
> ---
> net/mptcp/options.c  | 31 +++++++++++++++++++++++++------
> net/mptcp/protocol.c |  2 ++
> net/mptcp/protocol.h |  1 +
> 3 files changed, 28 insertions(+), 6 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 0e7abcea5bae..e0895834ff82 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -524,6 +524,21 @@ bool mptcp_synack_options(const struct request_sock =
*req, unsigned int *size,
> 	return false;
> }
>
> +static u64 expand_ack(u64 old_ack, u64 cur_ack, bool use_64bit)
> +{
> +	u32 old_ack32, cur_ack32;
> +
> +	if (use_64bit)
> +		return cur_ack;
> +
> +	old_ack32 =3D (u32)old_ack;
> +	cur_ack32 =3D (u32)cur_ack;
> +	cur_ack =3D (old_ack & GENMASK_ULL(63, 32)) + cur_ack32;
> +	if (unlikely(before(cur_ack32, old_ack32)))
> +		return cur_ack + (1LL<<32);
> +	return cur_ack;
> +}

Expanding the 32-bit sequence numbers correctly and consistently has been =

a concern of mine for a while, and trying to think through all the issues =

in the context of ack processing has only made me realize it's even =

trickier!

With the 32-bit data acks, we can encounter delayed acks on any subflow. =

Even timely acks seen on one subflow might have large changes in value due =

to the peer's transmit scheduling choices (acks might only show up on =

other subflows for a while). The penalty for incorrectly accepting a data =

ack is significant, since we would discard data from our MPTCP-level =

retransmission buffer that the peer will know it doesn't have (leading to =

an unrecoverable stall). Incorrectly discarding a data ack would be =

recoverable and likely fix itself through additional acks but maybe lead =

to an unnecessary reinjection by the peer.


I point this out in order to say that expanding 32-bit acks seems like a =

hard problem, and by decoupling the subflow->snd_una values it becomes =

even harder :) . I also understand that the possible locking problems from =

trying to share snd_una across subflows would be difficult too.


Rather than trying to sync subflow->snd_una values for the purpose of =

expanding them to 64 bits, the subflow could record the 32-bit value and =

let the MPTCP-level socket do the expansion? Then the subflows only need =

to track their most recent data ack: the ack value, size (32 or 64), and =

whether it's been updated since the last access by the MPTCP-level socket. =

The MPTCP-level socket has more information to know whether to reject an =

ambiguous 32-bit ack. Latency between the update of subflow->snd_una and =

the check of that value by the MPTCP socket is still an issue, but could =

be more manageable.


Side note: I know we have to handle what compliant peers send to us, but =

maybe we should keep sending only 64-bit acks!


Mat


> +
> void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb,
> 			    struct tcp_options_received *opt_rx)
> {
> @@ -537,6 +552,16 @@ void mptcp_incoming_options(struct sock *sk, struct =
sk_buff *skb,
> 	if (!mp_opt->dss)
> 		return;
>
> +	/* we can't wait for recvmsg() to update the ack_seq, otherwise
> +	 * monodirectional flows will stuck
> +	 */
> +	if (mp_opt->use_ack) {
> +		struct subflow_context *subflow =3D subflow_ctx(sk);
> +
> +		subflow->snd_una =3D expand_ack(subflow->snd_una,
> +					      mp_opt->data_ack, mp_opt->ack64);
> +	}
> +
> 	mpext =3D skb_ext_add(skb, SKB_EXT_MPTCP);
> 	if (!mpext)
> 		return;
> @@ -553,12 +578,6 @@ void mptcp_incoming_options(struct sock *sk, struct =
sk_buff *skb,
> 		mpext->use_checksum =3D mp_opt->use_checksum;
> 	}
>
> -	if (mp_opt->use_ack) {
> -		mpext->data_ack =3D mp_opt->data_ack;
> -		mpext->use_ack =3D 1;
> -		mpext->ack64 =3D mp_opt->ack64;
> -	}
> -
> 	mpext->data_fin =3D mp_opt->data_fin;
>
> 	if (msk)
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 5b7ddbe64e4b..65f7cc4712ef 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -674,6 +674,7 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
> 		subflow->map_subflow_seq =3D 1;
> 		subflow->rel_write_seq =3D 1;
> 		subflow->tcp_sock =3D new_sock;
> +		subflow->snd_una =3D msk->write_seq;
> 		newsk =3D new_mptcp_sock;
> 		subflow->conn =3D new_mptcp_sock;
> 		list_add(&subflow->node, &msk->conn_list);
> @@ -809,6 +810,7 @@ void mptcp_finish_connect(struct sock *sk, int mp_cap=
able)
> 		subflow->map_seq =3D ack_seq;
> 		subflow->map_subflow_seq =3D 1;
> 		subflow->rel_write_seq =3D 1;
> +		subflow->snd_una =3D msk->write_seq;
>
> 		list_add(&subflow->node, &msk->conn_list);
> 		msk->subflow =3D NULL;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 9f261ee31917..e37fd4bcd904 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -165,6 +165,7 @@ struct subflow_context {
> 	u32	token;
> 	u32     rel_write_seq;
> 	u64     idsn;
> +	u64	snd_una;
> 	u64	map_seq;
> 	u32	map_subflow_seq;
> 	u32	ssn_offset;
> -- =

> 2.21.0
>
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
>

--
Mat Martineau
Intel

--===============6347003459962093839==--
