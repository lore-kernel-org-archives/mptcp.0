Content-Type: multipart/mixed; boundary="===============2225809670439412114=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 03/13] mptcp: trigger msk processing even for OoO
 data
Date: Thu, 06 Aug 2020 20:11:16 +0200
Message-ID: <906cdedc-ac16-cdbd-dca0-006b0b45bbc0@tessares.net>
In-Reply-To: f94b1368b3019e75c924a20902004a8d978d71a6.1596649926.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5501

--===============2225809670439412114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thank you for the patch!

On 05/08/2020 19:57, Paolo Abeni wrote:
> This is a pre requiste to allow receiving data from multiple
> subflows without re-injection.
> =

> Instead of dropping the OoO - "future" data in
> subflow_check_data_avail(), call into __mptcp_move_skbs()
> and let the msk drop that.
> =

> To avoid code duplication factor out the mptcp_subflow_discard_data()
> helper.
> =

> Note that __mptcp_move_skbs() can now find multiple subflows
> with data avail (comprising to-be-discarded data), so must
> update the byte counter incrementally.

(...)

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 22621172f36f..7555dee019a0 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -828,6 +828,40 @@ static int subflow_read_actor(read_descriptor_t *des=
c,
>   	return copy_len;
>   }
>   =

> +int mptcp_subflow_discard_data(struct sock *ssk, unsigned limit)

Checkpatch is telling me:

   WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
   #249: FILE: net/mptcp/protocol.h:356:
   +int mptcp_subflow_discard_data(struct sock *sk, unsigned limit);

   WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
   #261: FILE: net/mptcp/subflow.c:831:
   +int mptcp_subflow_discard_data(struct sock *ssk, unsigned limit)

Should we use "u32" instead of "unsigned"?

> +{
> +	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> +	u32 map_remaining;
> +	size_t delta;
> +
> +	map_remaining =3D subflow->map_data_len -
> +			mptcp_subflow_get_map_offset(subflow);
> +	delta =3D min_t(size_t, limit, map_remaining);
> +
> +	/* discard mapped data */
> +	pr_debug("discarding %zu bytes, current map len=3D%d", delta,
> +		 map_remaining);
> +	if (delta) {
> +		read_descriptor_t desc =3D {
> +			.count =3D delta,
> +		};
> +		int ret;
> +
> +		ret =3D tcp_read_sock(ssk, &desc, subflow_read_actor);
> +		if (ret < 0) {
> +			ssk->sk_err =3D -ret;
> +			return ret;
> +		}
> +		if (ret < delta)
> +			return 0;
> +		if (delta =3D=3D map_remaining) {
> +			subflow->data_avail =3D 0;
> +			subflow->map_valid =3D 0;
> +		}
> +	}
> +	return 0;
> +}
> +
>   static bool subflow_check_data_avail(struct sock *ssk)
>   {
>   	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(ssk);
> @@ -844,8 +878,6 @@ static bool subflow_check_data_avail(struct sock *ssk)
>   =

>   	msk =3D mptcp_sk(subflow->conn);
>   	for (;;) {
> -		u32 map_remaining;
> -		size_t delta;
>   		u64 ack_seq;
>   		u64 old_ack;
>   =

> @@ -863,7 +895,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
>   			subflow->map_data_len =3D skb->len;
>   			subflow->map_subflow_seq =3D tcp_sk(ssk)->copied_seq -
>   						   subflow->ssn_offset;
> -			subflow->data_avail =3D 1;
> +			subflow->data_avail =3D MPTCP_SUBFLOW_DATA_AVAIL;
>   			return true;
>   		}
>   =

> @@ -892,43 +924,19 @@ static bool subflow_check_data_avail(struct sock *s=
sk)
>   		pr_debug("msk ack_seq=3D%llx subflow ack_seq=3D%llx", old_ack,
>   			 ack_seq);
>   		if (ack_seq =3D=3D old_ack) {
> -			subflow->data_avail =3D 1;
> +			subflow->data_avail =3D MPTCP_SUBFLOW_DATA_AVAIL;
> +			break;
> +		} else if (after64(ack_seq, old_ack)) {
> +			subflow->data_avail =3D MPTCP_SUBFLOW_OOO_DATA;
>   			break;
>   		}
>   =

>   		/* only accept in-sequence mapping. Old values are spurious
> -		 * retransmission; we can hit "future" values on active backup
> -		 * subflow switch, we relay on retransmissions to get
> -		 * in-sequence data.
> -		 * Cuncurrent subflows support will require subflow data
> -		 * reordering
> +		 * retransmission
>   		 */
> -		map_remaining =3D subflow->map_data_len -
> -				mptcp_subflow_get_map_offset(subflow);
> -		if (before64(ack_seq, old_ack))
> -			delta =3D min_t(size_t, old_ack - ack_seq, map_remaining);
> -		else
> -			delta =3D min_t(size_t, ack_seq - old_ack, map_remaining);
> -
> -		/* discard mapped data */
> -		pr_debug("discarding %zu bytes, current map len=3D%d", delta,
> -			 map_remaining);
> -		if (delta) {
> -			read_descriptor_t desc =3D {
> -				.count =3D delta,
> -			};
> -			int ret;
> -
> -			ret =3D tcp_read_sock(ssk, &desc, subflow_read_actor);
> -			if (ret < 0) {
> -				ssk->sk_err =3D -ret;
> -				goto fatal;
> -			}
> -			if (ret < delta)
> -				return false;
> -			if (delta =3D=3D map_remaining)
> -				subflow->map_valid =3D 0;
> -		}
> +		if (mptcp_subflow_discard_data(ssk, old_ack - ack_seq))

Will the second arg ((u64)old_ack - (u64)ack_seq) always fit in a "u32"?

Cheers,
Matt

> +			goto fatal;
> +		return false;
>   	}
>   	return true;
>   =

> =


-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2225809670439412114==--
