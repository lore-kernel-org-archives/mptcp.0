Content-Type: multipart/mixed; boundary="===============5927557918279135943=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next] mptcp: free resources when
 the port number is mismatched
Date: Thu, 18 Feb 2021 17:20:42 -0800
Message-ID: <dc2ed18a-43ee-363e-f37-285039202e4@linux.intel.com>
In-Reply-To: 1080938f95ce04a83fcf6e874862b49f60ce7a82.1613620817.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7852

--===============5927557918279135943==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Feb 2021, Geliang Tang wrote:

> When the port number is mismatched with the announced ones, use
> 'goto dispose_child' to free the resources instead of using 'goto out'.
>
> This patch also moves the port number checking code in
> subflow_syn_recv_sock before mptcp_finish_join, otherwise subflow_drop_ctx
> will fail in dispose_child.
>
> Fixes: 5bc56388c74f ("mptcp: add port number check for MP_JOIN")
> Reported-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> v2:
> - move the port number check code defore mptcp_finish_join.
> ---
> net/mptcp/subflow.c | 13 +++++++------
> 1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 06e233410e0e..82ec174e2bac 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -687,11 +687,6 @@ static struct sock *subflow_syn_recv_sock(const stru=
ct sock *sk,
> 			/* move the msk reference ownership to the subflow */
> 			subflow_req->msk =3D NULL;
> 			ctx->conn =3D (struct sock *)owner;
> -			if (!mptcp_finish_join(child))
> -				goto dispose_child;
> -
> -			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKRX);
> -			tcp_rsk(req)->drop_req =3D true;
>
> 			if (subflow_use_different_sport(owner, sk)) {
> 				pr_debug("ack inet_sport=3D%d %d",
> @@ -699,10 +694,16 @@ static struct sock *subflow_syn_recv_sock(const str=
uct sock *sk,
> 					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
> 				if (!mptcp_pm_sport_in_anno_list(owner, sk)) {
> 					SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTACKRX);
> -					goto out;
> +					goto dispose_child;
> 				}
> 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINPORTACKRX);
> 			}
> +
> +			if (!mptcp_finish_join(child))
> +				goto dispose_child;
> +
> +			SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_JOINACKRX);
> +			tcp_rsk(req)->drop_req =3D true;
> 		}
> 	}
>
> -- =

> 2.29.2

v2 looks good. Thanks for the patch!

--
Mat Martineau
Intel
--===============5927557918279135943==--
