Content-Type: multipart/mixed; boundary="===============0187782861624438012=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: do not warn when replacing an identical
 mapping.
Date: Wed, 05 Jun 2019 14:31:55 -0700
Message-ID: <alpine.OSX.2.21.1906051426500.2787@dgenex-mobl.amr.corp.intel.com>
In-Reply-To: 87926986ed8572ddad3c82230f0cf9b883fbbeb9.1559742173.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1294

--===============0187782861624438012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Wed, 5 Jun 2019, Paolo Abeni wrote:

> Said event can happen due GSO/TSO, do not warn then.
>
> Fixes: af798ed636e2 ("mptcp: Implement MPTCP receive path")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> --
> Notes:
> - I'm ok squashing this commit into the fixed one
> - I can't reproduce the warn locally, need someone else to verify
>  this one

This patch eliminates the warnings for me. I think it's good to merge (and =

squash) for now.

Thanks for the fix, Paolo.


Mat


> ---
> net/mptcp/protocol.c | 22 +++++++++++++++-------
> 1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 4e809719dcfd..65ad881daf0d 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -291,6 +291,7 @@ static enum mapping_status mptcp_get_mapping(struct s=
ock *ssk)
> 	struct mptcp_ext *mpext;
> 	enum mapping_status ret;
> 	struct sk_buff *skb;
> +	u64 map_seq;
>
> 	skb =3D skb_peek(&ssk->sk_receive_queue);
> 	if (!skb) {
> @@ -325,18 +326,25 @@ static enum mapping_status mptcp_get_mapping(struct=
 sock *ssk)
> 		goto del_out;
> 	}
>
> -	if (subflow->map_valid)
> -		pr_warn("Replaced mapping before it was done");
> -
> 	if (!mpext->dsn64) {
> -		subflow->map_seq =3D expand_seq(subflow->map_seq,
> -					      subflow->map_data_len,
> -					      mpext->data_seq);
> +		map_seq =3D expand_seq(subflow->map_seq, subflow->map_data_len,
> +				     mpext->data_seq);
> 		pr_debug("expanded seq=3D%llu", subflow->map_seq);
> 	} else {
> -		subflow->map_seq =3D mpext->data_seq;
> +		map_seq =3D mpext->data_seq;
> +	}
> +
> +	if (subflow->map_valid) {
> +		/* due to GSO/TSO we can receive the same mapping multiple
> +		 * times, before it's expiration.
> +		 */
> +		if (subflow->map_seq !=3D map_seq ||
> +		    subflow->map_subflow_seq !=3D mpext->subflow_seq ||
> +		    subflow->map_data_len !=3D mpext->data_len)
> +			pr_warn("Replaced mapping before it was done");
> 	}
>
> +	subflow->map_seq =3D map_seq;
> 	subflow->map_subflow_seq =3D mpext->subflow_seq;
> 	subflow->map_data_len =3D mpext->data_len;
> 	subflow->map_valid =3D 1;
> -- =

> 2.20.1
>
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
>

--
Mat Martineau
Intel

--===============0187782861624438012==--
