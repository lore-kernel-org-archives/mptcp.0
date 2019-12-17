Content-Type: multipart/mixed; boundary="===============2120082860455151731=="
MIME-Version: 1.0
From: Eric Dumazet <eric.dumazet at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v2 02/11] sock: Make sk_protocol a 16-bit
 value
Date: Mon, 16 Dec 2019 18:25:55 -0800
Message-ID: <03207138-4067-d3dc-c904-e9ff4a8ed197@gmail.com>
In-Reply-To: 20191217002455.24849-3-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3109

--===============2120082860455151731==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 12/16/19 4:24 PM, Mat Martineau wrote:
> Match the 16-bit width of skbuff->protocol. Fills an 8-bit hole so
> sizeof(struct sock) does not change.
> =

> Co-developed-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---
> =

> Changes for v2:
> =

> Moved sk_pacing_shift back to a regular struct member, adjacent to the
> bitfield. gcc then packs the bitfield and the u8 in a single 32-bit word.
> =

> =

>  include/net/sock.h          | 4 ++--
>  include/trace/events/sock.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> =

> diff --git a/include/net/sock.h b/include/net/sock.h
> index 81dc811aad2e..0930f46c600c 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -456,10 +456,10 @@ struct sock {
>  				sk_no_check_tx : 1,
>  				sk_no_check_rx : 1,
>  				sk_userlocks : 4,
> -				sk_protocol  : 8,
>  				sk_type      : 16;
> -	u16			sk_gso_max_segs;
>  	u8			sk_pacing_shift;
> +	u16			sk_protocol;
> +	u16			sk_gso_max_segs;
>  	unsigned long	        sk_lingertime;
>  	struct proto		*sk_prot_creator;
>  	rwlock_t		sk_callback_lock;


sk_type is no longer at a 16bit (u16) aligned location, which might force t=
he compiler
to do extra operations to fetch sk->sk_type on some arches.

Note that I do not even know why sk_type is a 16bit field, we might be able=
 to convert it to 8bit.

--===============2120082860455151731==--
