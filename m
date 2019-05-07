Content-Type: multipart/mixed; boundary="===============3524837152632335001=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH net-next] mptcp: mptcp option len must be skb
 independent
Date: Tue, 07 May 2019 16:48:32 -0700
Message-ID: <alpine.OSX.2.21.1905071456160.21662@ldraghi-mobl.amr.corp.intel.com>
In-Reply-To: e4e2f74ff6c4c2b5c434a5da01ae0756032bf22b.1557234439.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1125

--===============3524837152632335001==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 7 May 2019, Paolo Abeni wrote:

> Otherwise the TCP stack can't compute correctly the mss and
> that will break segmentation. Note that we can't observe the
> issue with the self-test until we allow skb collapsing -
> loopback default MTU is pretty big and we dont build big enogh
> skb otherwise.
>
> Fix the issue always reserving space for map in tcp_established_options().
> The map is effectively added according to skb extensions,
> if available.
> Overall we underestimate the MSS (always accounting for the map), but
> we emit the map only if needed.
>
> v1 -> v2:
> - rebased on top of current git
> - use slightly different way to compute the opt len

In reviewing the code, I only had one minor comment (not requiring a =

change to the patch). That's inline with the code below.


When I applied and ran the self tests with the patch, the first three =

cases ran ok. The fourth test, where packets get routed and segmentation =

happens, seemed to behave better in terms of segmentation but had corrupt =

TCP options following the MPTCP DSS option.

With mptcp_established_options_dss() always reporting the largest DSS =

option size (both DSS map and DSS ack), the full 40 bytes get allocated =

for the TCP option header. When there's no mapping data to fill all those =

option bytes, which happens in ACK packets or segments without the DSS =

mapping, the MPTCP option only has length 12. That leaves 16 uninitialized =

bytes at the end of the TCP options.

Did you consider only reporting the extra DSS bytes when skb =3D=3D NULL in =

mptcp_established_options_dss? It looks like this would add the extra =

header size for MSS purposes when called from tcp_current_mss(), but would =

not allocate the DSS map space in the TCP header. I haven't found a call =

to tcp_established_options() with a NULL skb arg anywhere other than =

tcp_current_mss() yet, but I'm still working to confirm that.


>
> Fixes: 9aaf99d52fc1 ("mptcp: Write MPTCP DSS headers to outgoing data pac=
kets")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> --
> this can be squashed into the fixes commit
> ---
> net/mptcp/options.c  | 33 ++++++++++++++++++---------------
> net/mptcp/protocol.h |  4 +++-
> net/mptcp/subflow.c  |  2 ++
> 3 files changed, 23 insertions(+), 16 deletions(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index b5f0914d01ba..870311f75d04 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -260,40 +260,43 @@ bool mptcp_established_options(struct sock *sk, uns=
igned int *size,
> }
>
> bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
> -			unsigned int *size, unsigned int remaining,
> -			struct mptcp_out_options *opts)
> +				   unsigned int *size, unsigned int remaining,
> +				   struct mptcp_out_options *opts)
> {
> 	unsigned int dss_size =3D 0;
> 	struct mptcp_ext *mpext;
> 	unsigned int ack_size;
> +	unsigned int map_size;
> +	bool use_csum;
>
> -	if (!subflow_ctx(sk)->mp_capable || !skb)
> +	if (!subflow_ctx(sk)->mp_capable)
> 		return false;
>
> -	mpext =3D mptcp_get_ext(skb);
> +	map_size =3D TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
>
> -	if (mpext && mpext->use_map) {
> -		unsigned int map_size;
> -		map_size =3D TCPOLEN_MPTCP_DSS_BASE + TCPOLEN_MPTCP_DSS_MAP64;
> +	use_csum =3D subflow_ctx(sk)->use_checksum;
> +	if (use_csum)
> +		map_size +=3D TCPOLEN_MPTCP_DSS_CHECKSUM;
>
> -		if (mpext->use_checksum)
> -			map_size +=3D TCPOLEN_MPTCP_DSS_CHECKSUM;
> -
> -		if (map_size <=3D remaining) {
> -			remaining -=3D map_size;
> -			dss_size =3D map_size;
> +	if (map_size <=3D remaining) {
> +		remaining -=3D map_size;
> +		dss_size =3D map_size;
>
> +		mpext =3D skb ? mptcp_get_ext(skb) : NULL;
> +		if (mpext && mpext->use_map) {
> 			opts->ext_copy.data_seq =3D mpext->data_seq;
> 			opts->ext_copy.subflow_seq =3D mpext->subflow_seq;
> 			opts->ext_copy.data_len =3D mpext->data_len;
> 			opts->ext_copy.checksum =3D mpext->checksum;
> 			opts->ext_copy.use_map =3D 1;
> 			opts->ext_copy.dsn64 =3D mpext->dsn64;
> -			opts->ext_copy.use_checksum =3D mpext->use_checksum;
> +			opts->ext_copy.use_checksum =3D use_csum;

My initial reaction was to want to move use_checksum from struct mptcp_ext =

to struct mptcp_out_options, but it would make struct mptcp_out_options =

larger without offering other improvements. I think it's fine to leave =

use_checksum where it is, until we run out of bits in the mptcp_ext =

bitfield.


Mat


> 		} else {
> 			opts->ext_copy.use_map =3D 0;
> -			WARN(1, "MPTCP: Map dropped");
> 		}
> +	} else {
> +		opts->ext_copy.use_map =3D 0;
> +		WARN_ONCE(1, "MPTCP: Map dropped");
> 	}
>
> 	ack_size =3D TCPOLEN_MPTCP_DSS_ACK64;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 870249761c0e..d67c38a2198b 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -87,7 +87,9 @@ struct subflow_context {
> 		fourth_ack : 1,     /* send initial DSS */
> 		version : 4,
> 		conn_finished : 1,
> -		map_valid : 1;
> +		map_valid : 1,
> +		use_checksum : 1;
> +
> 	struct  sock *sk;       /* underlying tcp_sock */
> 	struct  sock *conn;     /* parent mptcp_sock */
> 	void	(*tcp_sk_data_ready)(struct sock *sk);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index b503e13faf96..f88bc48ca997 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -210,6 +210,7 @@ static int subflow_ulp_init(struct sock *sk)
> 	tp->is_mptcp =3D 1;
> 	icsk->icsk_af_ops =3D &subflow_specific;
> 	ctx->tcp_sk_data_ready =3D sk->sk_data_ready;
> +	ctx->use_checksum =3D 0;
> 	sk->sk_data_ready =3D subflow_data_ready;
> out:
> 	return err;
> @@ -241,6 +242,7 @@ static void subflow_ulp_clone(const struct request_so=
ck *req,
> 	new_ctx->conn =3D NULL;
> 	new_ctx->conn_finished =3D 1;
> 	new_ctx->tcp_sk_data_ready =3D old_ctx->tcp_sk_data_ready;
> +	new_ctx->use_checksum =3D old_ctx->use_checksum;
>
> 	if (subflow_req->mp_capable) {
> 		new_ctx->mp_capable =3D 1;
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

--===============3524837152632335001==--
