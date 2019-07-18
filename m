Content-Type: multipart/mixed; boundary="===============7242878885941425212=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH 4/9] Re-factor and fixes for crypto_hmac_sha1()
Date: Thu, 18 Jul 2019 09:06:25 +0200
Message-ID: <b8cc56206a5f0c4621cfbf4b08b7044ca29a0079.camel@redhat.com>
In-Reply-To: 20190717221256.7358-5-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 1523

--===============7242878885941425212==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2019-07-17 at 15:12 -0700, Peter Krystad wrote:
> Re-factor to use parameters specific to MPTCP use case similar to
> diff --git a/net/mptcp/token.c b/net/mptcp/token.c
> index c2f4fcb37566..c9160f50f047 100644
> --- a/net/mptcp/token.c
> +++ b/net/mptcp/token.c
> @@ -114,12 +114,11 @@ static void new_req_join(struct request_sock *req, =
struct sock *sk,
>  	}
>  	subflow_req->local_nonce =3D nonce;
>  >local_key,
> -			 msk->remote_key,
> -			 (u32 *)hmac, 2,
> -			 4, (u8 *)&subflow_req->local_nonce,
> -			 4, (u8 *)&subflow_req->remote_nonce);
> -	subflow_req->thmac =3D *(u64 *)hmac;
> +	crypto_hmac_sha1(msk->local_key, msk->remote_key,
> +			 subflow_req->local_nonce, subflow_req->remote_nonce,
> +			 (u32 *)hmac);
> +
> +	subflow_req->thmac =3D get_unaligned_be64(hmac);
>  	pr_debug("local_nonce=3D%u, thmac=3D%llu", subflow_req->local_nonce,
>  		 subflow_req->thmac);
>  }

It looks like this is going to conflict with Davide's pending patch
"net: mptcp: randomness improvements for crypto.c"

Other than this, LGTM!

Paolo


--===============7242878885941425212==--
