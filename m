Content-Type: multipart/mixed; boundary="===============5966736057433033162=="
MIME-Version: 1.0
From: Peter Krystad <peter.krystad at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] mptcp: move from sha1 (v0) to sha256 (v1)
Date: Thu, 21 Nov 2019 17:20:37 -0800
Message-ID: <e7a9f364c5ff6799dba2624b3724d9e9fb14a423.camel@linux.intel.com>
In-Reply-To: 956ad1cdcb16e6320c16c7ff429743250a4d5591.1573465037.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2657

--===============5966736057433033162==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-11-11 at 10:41 +0100, Paolo Abeni wrote:
> For simplicity's sake use directly sha256 primitives (and pull
> them as a required build dep).
> While extracting the data from the hash results, take in account
> that sha256_final() swaps to be32.
> Also rename functions and macro accordingly and fix some checkpatch
> issue (long lines).
> =

> Open questions: do we want to squash this into the current patches?
> Otherwise, should I push some cleanup the existing patches, to reduce
> the change introduced here?

Hi Paolo -

Not sure if it's too late to comment here. If you do one patch that renames

mptcp_crypto_key_sha1 to mptcp_crypto_key_sha AND
mptcp_crypto_hmac_sha1 to mptcp_crypto_hmac_sha AND
mptcp_cryptio_key_gen_sha1 to mptcp_crypto_key_gen_sha AND
MPTCP_CAP_HMAC_SHA1 to MPTCP_CAP_HMAC_SHA

and squash it then the standalone change patch will only have changes for t=
he
sha routines themselves.

Peter.

> ---
>  net/mptcp/Kconfig    |  1 +
>  net/mptcp/crypto.c   | 99 ++++++++++++++------------------------------
>  net/mptcp/options.c  | 13 ++++--
>  net/mptcp/protocol.c |  5 ++-
>  net/mptcp/protocol.h | 12 +++---
>  net/mptcp/subflow.c  | 28 ++++++-------
>  net/mptcp/token.c    | 10 ++---
>  7 files changed, 69 insertions(+), 99 deletions(-)
> =

> diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
> index f21190a4f7e9..a4d261ccfbc0 100644
> --- a/net/mptcp/Kconfig
> +++ b/net/mptcp/Kconfig
> @@ -3,6 +3,7 @@ config MPTCP
>  	bool "Multipath TCP"
>  	depends on INET
>  	select SKB_EXTENSIONS
> +	select CRYPTO_LIB_SHA256
>  	help
>  	  Multipath TCP (MPTCP) connections send and receive data over multiple
>  	  subflows in order to utilize multiple network paths. Each subflow
> diff --git a/net/mptcp/crypto.c b/net/mptcp/crypto.c
> index 0d7b10939ba6..4066cfbc227e 100644
> --- a/net/mptcp/crypto.c
> +++ b/net/mptcp/crypto.c
> @@ -21,56 +21,40 @@
>   */
>  =

>  #include <linux/kernel.h>
> -#include <linux/cryptohash.h>
> -#include <linux/random.h>
> -#include <linux/siphash.h>
>  #include <asm/unaligned.h>
> +#include <crypto/sha.h>
>  =

>  #include "protocol.h"
>  =

> -void mptcp_crypto_key_sha1(u64 key, u32 *token, u64 *idsn)
> +void mptcp_crypto_key_sha256(u64 key, u32 *token, u64 *idsn)
>  {
> -	u32 workspace[SHA_WORKSPACE_WORDS];
> -	u32 mptcp_hashed_key[SHA_DIGEST_WORDS];
> -	u8 input[64];
> +	__be32 mptcp_hashed_key[SHA256_DIGEST_SIZE/sizeof(u32)];
> +	__be64 input =3D cpu_to_be64(key);
> +	struct sha256_state state;
>  =

> -	memset(workspace, 0, sizeof(workspace));
> -
> -	/* Initialize input with appropriate padding */
> -	memset(&input[9], 0, sizeof(input) - 10); /* -10, because the last byte
> -						   * is explicitly set too
> -						   */
> -	put_unaligned_be64(key, input);
> -	input[8] =3D 0x80; /* Padding: First bit after message =3D 1 */
> -	input[63] =3D 0x40; /* Padding: Length of the message =3D 64 bits */
> -
> -	sha_init(mptcp_hashed_key);
> -	sha_transform(mptcp_hashed_key, input, workspace);
> +	sha256_init(&state);
> +	sha256_update(&state, (const u8 *)&input, 8);
> +	sha256_final(&state, (u8 *)mptcp_hashed_key);
>  =

>  	if (token)
> -		*token =3D mptcp_hashed_key[0];
> +		*token =3D be32_to_cpu(mptcp_hashed_key[0]);
>  	if (idsn)
> -		*idsn =3D ((u64)mptcp_hashed_key[3] << 32) + mptcp_hashed_key[4];
> +		*idsn =3D be64_to_cpu(*((__be64 *)&mptcp_hashed_key[6]));
>  }
>  =

> -void mptcp_crypto_hmac_sha1(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
> -			    u32 *hash_out)
> +void mptcp_crypto_hmac_sha256(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
> +			      void *hmac)
>  {
> -	u32 workspace[SHA_WORKSPACE_WORDS];
> -	u8 input[128]; /* 2 512-bit blocks */
> -	int i;
> -	int index;
> +	__be32 mptcp_hashed_key[SHA256_DIGEST_SIZE/sizeof(u32)];
> +	u8 input[SHA256_BLOCK_SIZE + SHA256_DIGEST_SIZE];
> +	__be32 *hash_out =3D (__force __be32*)hmac;
> +	struct sha256_state state;
>  	u8 key_1[8];
>  	u8 key_2[8];
> -	u8 nonce_1[4];
> -	u8 nonce_2[4];
> -
> -	memset(workspace, 0, sizeof(workspace));
> +	int i;
>  =

>  	put_unaligned_be64(key1, key_1);
>  	put_unaligned_be64(key2, key_2);
> -	put_unaligned_be32(nonce1, nonce_1);
> -	put_unaligned_be32(nonce2, nonce_2);
>  =

>  	/* Generate key xored with ipad */
>  	memset(input, 0x36, 64);
> @@ -79,50 +63,29 @@ void mptcp_crypto_hmac_sha1(u64 key1, u64 key2, u32 n=
once1, u32 nonce2,
>  	for (i =3D 0; i < 8; i++)
>  		input[i + 8] ^=3D key_2[i];
>  =

> -	index =3D 64;
> -	memcpy(&input[index], nonce_1, 4);
> -	index =3D 68;
> -	memcpy(&input[index], nonce_2, 4);
> -	index =3D 72;
> -
> -	input[index] =3D 0x80; /* Padding: First bit after message =3D 1 */
> -	memset(&input[index + 1], 0, (126 - index));
> +	put_unaligned_be32(nonce1, &input[SHA256_BLOCK_SIZE]);
> +	put_unaligned_be32(nonce2, &input[SHA256_BLOCK_SIZE + 4]);
>  =

> -	/* Padding: Length of the message =3D 512 + message length (bits) */
> -	input[126] =3D 0x02;
> -	input[127] =3D ((index - 64) * 8); /* Message length (bits) */
> +	sha256_init(&state);
> +	sha256_update(&state, input, SHA256_BLOCK_SIZE + 8);
>  =

> -	sha_init(hash_out);
> -	sha_transform(hash_out, input, workspace);
> -	memset(workspace, 0, sizeof(workspace));
> -
> -	sha_transform(hash_out, &input[64], workspace);
> -	memset(workspace, 0, sizeof(workspace));
> -
> -	for (i =3D 0; i < 5; i++)
> -		hash_out[i] =3D (__force u32)cpu_to_be32(hash_out[i]);
> +	/* emit sha256(K1 || msg ) on the second input block, so we can
> +	 * reuse 'input' for the last hashing
> +	 */
> +	sha256_final(&state, &input[SHA256_BLOCK_SIZE]);
>  =

>  	/* Prepare second part of hmac */
> -	memset(input, 0x5C, 64);
> +	memset(input, 0x5C, SHA256_BLOCK_SIZE);
>  	for (i =3D 0; i < 8; i++)
>  		input[i] ^=3D key_1[i];
>  	for (i =3D 0; i < 8; i++)
>  		input[i + 8] ^=3D key_2[i];
>  =

> -	memcpy(&input[64], hash_out, 20);
> -	input[84] =3D 0x80;
> -	memset(&input[85], 0, 41);
> -
> -	/* Padding: Length of the message =3D 512 + 160 bits */
> -	input[126] =3D 0x02;
> -	input[127] =3D 0xA0;
> -
> -	sha_init(hash_out);
> -	sha_transform(hash_out, input, workspace);
> -	memset(workspace, 0, sizeof(workspace));
> -
> -	sha_transform(hash_out, &input[64], workspace);
> +	sha256_init(&state);
> +	sha256_update(&state, input, SHA256_BLOCK_SIZE + SHA256_DIGEST_SIZE);
> +	sha256_final(&state, (u8 *)mptcp_hashed_key);
>  =

> +	/* takes only first 160 bits */
>  	for (i =3D 0; i < 5; i++)
> -		hash_out[i] =3D (__force u32)cpu_to_be32(hash_out[i]);
> +		hash_out[i] =3D mptcp_hashed_key[i];
>  }
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 43f849fc03ab..5569e6d5b5c4 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -9,6 +9,11 @@
>  #include <net/mptcp.h>
>  #include "protocol.h"
>  =

> +static bool mptcp_cap_flag_sha256(u8 flags)
> +{
> +	return (flags & MPTCP_CAP_FLAG_MASK) =3D=3D MPTCP_CAP_HMAC_SHA256;
> +}
> +
>  void mptcp_parse_option(const struct sk_buff *skb, const unsigned char *=
ptr,
>  			int opsize, struct tcp_options_received *opt_rx)
>  {
> @@ -45,7 +50,7 @@ void mptcp_parse_option(const struct sk_buff *skb, cons=
t unsigned char *ptr,
>  			break;
>  =

>  		mp_opt->flags =3D *ptr++;
> -		if (!((mp_opt->flags & MPTCP_CAP_FLAG_MASK) =3D=3D MPTCP_CAP_HMAC_SHA1=
) ||
> +		if (!mptcp_cap_flag_sha256(mp_opt->flags) ||
>  		    (mp_opt->flags & MPTCP_CAP_EXTENSIBILITY))
>  			break;
>  =

> @@ -736,8 +741,8 @@ void mptcp_incoming_options(struct sock *sk, struct s=
k_buff *skb,
>  			/* this is an MP_CAPABLE carrying MPTCP data
>  			 * we know this map the first chunk of data
>  			 */
> -			mptcp_crypto_key_sha1(subflow->remote_key, NULL,
> -					      &mpext->data_seq);
> +			mptcp_crypto_key_sha256(subflow->remote_key, NULL,
> +						&mpext->data_seq);
>  			mpext->data_seq++;
>  			mpext->subflow_seq =3D 1;
>  			mpext->dsn64 =3D 1;
> @@ -773,7 +778,7 @@ void mptcp_write_options(__be32 *ptr, struct mptcp_ou=
t_options *opts)
>  			len =3D TCPOLEN_MPTCP_MPC_ACK;
>  =

>  		*ptr++ =3D mptcp_option(MPTCPOPT_MP_CAPABLE, len, 1,
> -				      MPTCP_CAP_HMAC_SHA1);
> +				      MPTCP_CAP_HMAC_SHA256);
>  =

>  		if (!((OPTION_MPTCP_MPC_SYNACK | OPTION_MPTCP_MPC_ACK) &
>  		    opts->suboptions))
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e1f029e742a5..97e643999fb0 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -835,7 +835,8 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
>  		if (subflow->can_ack) {
>  			msk->can_ack =3D true;
>  			msk->remote_key =3D subflow->remote_key;
> -			mptcp_crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
> +			mptcp_crypto_key_sha256(msk->remote_key, NULL,
> +						&ack_seq);
>  			ack_seq++;
>  			msk->ack_seq =3D ack_seq;
>  		}
> @@ -1007,7 +1008,7 @@ void mptcp_finish_connect(struct sock *sk, int mp_c=
apable)
>  =

>  		msk->write_seq =3D subflow->idsn + 1;
>  		atomic64_set(&msk->snd_una, msk->write_seq);
> -		mptcp_crypto_key_sha1(msk->remote_key, NULL, &ack_seq);
> +		mptcp_crypto_key_sha256(msk->remote_key, NULL, &ack_seq);
>  		ack_seq++;
>  		msk->ack_seq =3D ack_seq;
>  		msk->can_ack =3D 1;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 1018197aabae..1565a1d5206f 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -59,7 +59,7 @@
>  #define MPTCP_VERSION_MASK	(0x0F)
>  #define MPTCP_CAP_CHECKSUM_REQD	BIT(7)
>  #define MPTCP_CAP_EXTENSIBILITY	BIT(6)
> -#define =

 =

> 	BIT(0)
> +#define MPTCP_CAP_HMAC_SHA256	BIT(0)
>  #define MPTCP_CAP_FLAG_MASK	(0x3F)
>  =

>  /* MPTCP DSS flags */
> @@ -307,8 +307,8 @@ void mptcp_token_update_accept(struct sock *sk, struc=
t sock *conn);
>  struct mptcp_sock *mptcp_token_get_sock(u32 token);
>  void mptcp_token_destroy(u32 token);
>  =

> -void mptcp_crypto_key_sha1(u64 key, u32 *token, u64 *idsn);
> -static inline void mptcp_crypto_key_gen_sha1(u64 *key, u32 *token, u64 *=
idsn)
> +void mptcp_crypto_key_sha256(u64 key, u32 *token, u64 *idsn);
> +static inline void mptcp_crypto_key_gen_sha256(u64 *key, u32 *token, u64=
 *idsn)
>  {
>  	/* we might consider a faster version that computes the key as a
>  	 * hash of some information available in the MPTCP socket. Use
> @@ -317,11 +317,11 @@ static inline void mptcp_crypto_key_gen_sha1(u64 *k=
ey, u32 *token, u64 *idsn)
>  	 * the same time.
>  	 */
>  	get_random_bytes(key, sizeof(u64));
> -	mptcp_crypto_key_sha1(*key, token, idsn);
> +	mptcp_crypto_key_sha256(*key, token, idsn);
>  }
>  =

> -void mptcp_crypto_hmac_sha1(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
> -			    u32 *hash_out);
> +void mptcp_crypto_hmac_sha256(u64 key1, u64 key2, u32 nonce1, u32 nonce2,
> +			      void *hmac);
>  =

>  void mptcp_pm_init(void);
>  void mptcp_pm_new_connection(struct mptcp_sock *msk, int server_side);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index c9f765905712..e5ed351a9a35 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -83,9 +83,9 @@ static bool subflow_token_join_request(struct request_s=
ock *req,
>  =

>  	get_random_bytes(&subflow_req->local_nonce, sizeof(u32));
>  =

> -	mptcp_crypto_hmac_sha1(msk->local_key, msk->remote_key,
> -			       subflow_req->local_nonce,
> -			       subflow_req->remote_nonce, (u32 *)hmac);
> +	mptcp_crypto_hmac_sha256(msk->local_key, msk->remote_key,
> +				 subflow_req->local_nonce,
> +				 subflow_req->remote_nonce, hmac);
>  =

>  	subflow_req->thmac =3D get_unaligned_be64(hmac);
>  =

> @@ -176,9 +176,9 @@ static bool subflow_thmac_valid(struct mptcp_subflow_=
context *subflow)
>  	u8 hmac[MPTCPOPT_HMAC_LEN];
>  	u64 thmac;
>  =

> -	mptcp_crypto_hmac_sha1(subflow->remote_key, subflow->local_key,
> -			       subflow->remote_nonce, subflow->local_nonce,
> -			       (u32 *)hmac);
> +	mptcp_crypto_hmac_sha256(subflow->remote_key, subflow->local_key,
> +				 subflow->remote_nonce, subflow->local_nonce,
> +				 hmac);
>  =

>  	thmac =3D get_unaligned_be64(hmac);
>  	pr_debug("subflow=3D%p, token=3D%u, thmac=3D%llu, subflow->thmac=3D%llu=
\n",
> @@ -219,10 +219,10 @@ static void subflow_finish_connect(struct sock *sk,=
 const struct sk_buff *skb)
>  			return;
>  		}
>  =

> -		mptcp_crypto_hmac_sha1(subflow->local_key, subflow->remote_key,
> -				       subflow->local_nonce,
> -				       subflow->remote_nonce,
> -				       (u32 *)subflow->hmac);
> +		mptcp_crypto_hmac_sha256(subflow->local_key,
> +					 subflow->remote_key,
> +					 subflow->local_nonce,
> +					 subflow->remote_nonce, subflow->hmac);
>  =

>  		mptcp_finish_join(sk);
>  		subflow->conn_finished =3D 1;
> @@ -289,9 +289,9 @@ static bool subflow_hmac_valid(const struct request_s=
ock *req,
>  	if (!msk)
>  		return false;
>  =

> -	mptcp_crypto_hmac_sha1(msk->remote_key, msk->local_key,
> -			       subflow_req->remote_nonce,
> -			       subflow_req->local_nonce, (u32 *)hmac);
> +	mptcp_crypto_hmac_sha256(msk->remote_key, msk->local_key,
> +				 subflow_req->remote_nonce,
> +				 subflow_req->local_nonce, hmac);
>  =

>  	ret =3D true;
>  	if (crypto_memneq(hmac, rx_opt->mptcp.hmac, sizeof(hmac)))
> @@ -734,7 +734,7 @@ int mptcp_subflow_connect(struct sock *sk, struct soc=
kaddr *local,
>  	if (err)
>  		goto failed;
>  =

> -	mptcp_crypto_key_sha1(subflow->remote_key, &remote_token, NULL);
> +	mptcp_crypto_key_sha256(subflow->remote_key, &remote_token, NULL);
>  	pr_debug("msk=3D%p remote_token=3D%u", msk, remote_token);
>  	subflow->remote_token =3D remote_token;
>  	subflow->remote_id =3D remote_id;
> diff --git a/net/mptcp/token.c b/net/mptcp/token.c
> index aeb7059d19e1..b3e053a40b2f 100644
> --- a/net/mptcp/token.c
> +++ b/net/mptcp/token.c
> @@ -57,9 +57,9 @@ int mptcp_token_new_request(struct request_sock *req)
>  	while (1) {
>  		u32 token;
>  =

> -		mptcp_crypto_key_gen_sha1(&subflow_req->local_key,
> -					  &subflow_req->token,
> -					  &subflow_req->idsn);
> +		mptcp_crypto_key_gen_sha256(&subflow_req->local_key,
> +					    &subflow_req->token,
> +					    &subflow_req->idsn);
>  		pr_debug("req=3D%p local_key=3D%llu, token=3D%u, idsn=3D%llu\n",
>  			 req, subflow_req->local_key, subflow_req->token,
>  			 subflow_req->idsn);
> @@ -103,8 +103,8 @@ int mptcp_token_new_connect(struct sock *sk)
>  	while (1) {
>  		u32 token;
>  =

> -		mptcp_crypto_key_gen_sha1(&subflow->local_key, &subflow->token,
> -					  &subflow->idsn);
> +		mptcp_crypto_key_gen_sha256(&subflow->local_key,
> +					    &subflow->token, &subflow->idsn);
>  =

>  		pr_debug("ssk=3D%p, local_key=3D%llu, token=3D%u, idsn=3D%llu\n",
>  			 sk, subflow->local_key, subflow->token, subflow->idsn);

--===============5966736057433033162==--
