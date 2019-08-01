Content-Type: multipart/mixed; boundary="===============2614585431664599107=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 2/2] Remove unused variable, causes compile warning
Date: Thu, 01 Aug 2019 09:04:11 -0700
Message-ID: <alpine.OSX.2.21.1908010903570.37892@aindraka-mobl.amr.corp.intel.com>
In-Reply-To: 20190731164249.14383-2-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1572

--===============2614585431664599107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Jul 2019, Peter Krystad wrote:

> squashto: Add handling of incoming MP_JOIN requests
>
> Signed-off-by: Peter Krystad <peter.krystad(a)linux.intel.com>
> ---
> net/mptcp/token.c | 1 -
> 1 file changed, 1 deletion(-)
>
> diff --git a/net/mptcp/token.c b/net/mptcp/token.c
> index 2324a477d513..d5ae77446590 100644
> --- a/net/mptcp/token.c
> +++ b/net/mptcp/token.c
> @@ -77,7 +77,6 @@ static void new_req_token(struct request_sock *req,
> static void new_req_join(struct request_sock *req, struct sock *sk,
> 			 const struct sk_buff *skb)
> {
> -	const struct inet_request_sock *ireq =3D inet_rsk(req);
> 	struct subflow_request_sock *subflow_req =3D subflow_rsk(req);
> 	struct mptcp_sock *msk =3D mptcp_sk(sk);
> 	u8 hmac[MPTCPOPT_HMAC_LEN];
> -- =

> 2.17.2
>

Both patches look good to me, thanks!

--
Mat Martineau
Intel

--===============2614585431664599107==--
