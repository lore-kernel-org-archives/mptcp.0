Content-Type: multipart/mixed; boundary="===============2487907335448146047=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-net] mptcp: Wake up MPTCP worker when
 DATA_FIN found on a TCP FIN packet
Date: Mon, 07 Sep 2020 11:36:49 +0200
Message-ID: <421e39795d3e6954c55b2e40b84e59ce9164dfe8.camel@redhat.com>
In-Reply-To: 20200904003531.291283-1-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 5743

--===============2487907335448146047==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-09-03 at 17:35 -0700, Mat Martineau wrote:
> When receiving a DATA_FIN MPTCP option on a TCP FIN packet, the DATA_FIN
> information would be stored but the MPTCP worker did not get
> scheduled. In turn, the MPTCP socket state would remain in
> TCP_ESTABLISHED and no blocked operations would be awakened.
> =

> TCP FIN packets are seen by the MPTCP socket when moving skbs out of the
> subflow receive queues, so schedule the MPTCP worker when a skb with
> DATA_FIN but no data payload is moved from a subflow queue. Other cases
> (DATA_FIN on a bare TCP ACK or on a packet with data payload) are
> already handled.
> =

> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---
> =

> This patch is targeted at the -net tree, but also applies to net-next
> without conflict. If it looks ok, we can carry it in the export branch
> until it gets merged to both -net and net-next.
> =

> net/mptcp/subflow.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> =

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index e8cac2655c82..3297233dece7 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -731,7 +731,7 @@ static enum mapping_status get_mapping_status(struct =
sock *ssk,
>  =

>  	if (mpext->data_fin =3D=3D 1) {
>  		if (data_len =3D=3D 1) {
> -			mptcp_update_rcv_data_fin(msk, mpext->data_seq);
> +			bool updated =3D mptcp_update_rcv_data_fin(msk, mpext->data_seq);
>  			pr_debug("DATA_FIN with no payload seq=3D%llu", mpext->data_seq);
>  			if (subflow->map_valid) {
>  				/* A DATA_FIN might arrive in a DSS
> @@ -742,6 +742,9 @@ static enum mapping_status get_mapping_status(struct =
sock *ssk,
>  				skb_ext_del(skb, SKB_EXT_MPTCP);
>  				return MAPPING_OK;
>  			} else {
> +				if (updated && schedule_work(&msk->work))
> +					sock_hold((struct sock *)msk);
> +

We already have 'schedule_work' call to handle incoming data fin
in mptcp_incoming_options(), can we instead extend the checks there to
cover also this scenario?

Cheers,

Paolo

--===============2487907335448146047==--
