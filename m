Content-Type: multipart/mixed; boundary="===============3911219910533052169=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] mptcp: use rightmost 64 bits in
 ADD_ADDR HMAC
Date: Tue, 19 May 2020 18:09:26 -0700
Message-ID: <20200520010926.GF45434@MacBook-Pro-64.local>
In-Reply-To: 20200518222916.108513-1-todd.malsbary@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 4429

--===============3911219910533052169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 18/05/20 - 15:29:16, Todd Malsbary wrote:
> This changes the HMAC used in the ADD_ADDR option from the leftmost 64
> bits to the rightmost 64 bits as described in RFC 8684, section 3.4.1.
> =

> Signed-off-by: Todd Malsbary <todd.malsbary(a)linux.intel.com>
> ---
> =

> I found this while adding support to packetdrill for the ADD_ADDR v1
> option.  The computation I used for the HMAC in the pending
> packetdrill work gave a different result than what was being computed
> by the kernel.
> =

> It appears that the usage of the leftmost bits has been in place since
> at least 2016 in the out-of-tree code (commit de09a83186666).  Given
> that, is the issue in the implementation or the RFC?
> =

>  net/mptcp/options.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index ece6f92cf7d1..0e11fb3d908f 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -550,7 +550,7 @@ static u64 add_addr_generate_hmac(u64 key1, u64 key2,=
 u8 addr_id,
>  =

>  	mptcp_crypto_hmac_sha(key1, key2, msg, 7, hmac);
>  =

> -	return get_unaligned_be64(hmac);
> +	return get_unaligned_be64(&hmac[MPTCP_ADDR_HMAC_LEN - sizeof(u64)]);

as I was trying to do the same change in out-of-tree MPTCP, I realize
something maybe a little bit late:

I think MPTCP_ADDR_HMAC_LEN is the wrong variable, no?

We want to take the rightmost bits of the SHA-256 output. Meaning, we need
to get the right most out of mptcp_hashed_key in mptcp_crypto_hmac_sha().

Because this latter function is already only copying the first 160bits to
hashed_out - thus we are missing the remaining bits...


Right?


Christoph



>  }
>  =

>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> @@ -567,7 +567,7 @@ static u64 add_addr6_generate_hmac(u64 key1, u64 key2=
, u8 addr_id,
>  =

>  	mptcp_crypto_hmac_sha(key1, key2, msg, 19, hmac);
>  =

> -	return get_unaligned_be64(hmac);
> +	return get_unaligned_be64(&hmac[MPTCP_ADDR_HMAC_LEN - sizeof(u64)]);
>  }
>  #endif
>  =

> -- =

> 2.25.4
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
--===============3911219910533052169==--
