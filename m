Content-Type: multipart/mixed; boundary="===============2828576407976193991=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] squash-to: "mptcp: Add key generation and token
 tree"
Date: Fri, 13 Dec 2019 17:12:18 +0100
Message-ID: <fee641df628e3b1676aefa202f1fef8bf11a1def.camel@redhat.com>
In-Reply-To: e6ab4f649aee5fd642f284c311a51993723a0664.1576252967.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2957

--===============2828576407976193991==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-12-13 at 17:05 +0100, Davide Caratti wrote:
> checkpatch fixes
> =

> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
>  net/mptcp/crypto.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> =

> diff --git a/net/mptcp/crypto.c b/net/mptcp/crypto.c
> index ccb9f7effdcd..bbd6d01af211 100644
> --- a/net/mptcp/crypto.c
> +++ b/net/mptcp/crypto.c
> @@ -44,8 +44,8 @@ static void sha1_update(struct sha1_state *state, u8 *i=
nput)
>  	state->count +=3D SHA_MESSAGE_BYTES;
>  }
>  =

> -static void sha1_pad_final(struct sha1_state *state, u8 *input, unsigned=
 length,
> -			   __be32 *mptcp_hashed_key)
> +static void sha1_pad_final(struct sha1_state *state, u8 *input,
> +			   unsigned int length, __be32 *mptcp_hashed_key)
>  {
>  	int i;
>  =

> @@ -78,7 +78,7 @@ void mptcp_crypto_key_sha(u64 key, u32 *token, u64 *ids=
n)
>  }
>  =

>  void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
> -			    u32 *hash_out)
> +			   u32 *hash_out)
>  {
>  	u8 input[SHA_MESSAGE_BYTES * 2];
>  	struct sha1_state state;
> @@ -118,5 +118,5 @@ void mptcp_crypto_hmac_sha(u64 key1, u64 key2, u32 no=
nce1, u32 nonce2,
>  	sha1_init(&state);
>  	sha1_update(&state, input);
>  	sha1_pad_final(&state, &input[SHA_MESSAGE_BYTES], SHA_DIGEST_WORDS << 2,
> -		      (__be32*)hash_out);
> +		       (__be32 *)hash_out);
>  }

I guess this will cause a bit of work for Matt... Anyhow LGTM


--===============2828576407976193991==--
