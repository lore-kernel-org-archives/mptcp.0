Content-Type: multipart/mixed; boundary="===============5903364273704591639=="
MIME-Version: 1.0
From: Eric Dumazet <eric.dumazet at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 02/11] sock: Make sk_protocol a 16-bit
 value
Date: Fri, 13 Dec 2019 15:16:39 -0800
Message-ID: <9a83715c-92c3-7e3e-304d-34b1d9285138@gmail.com>
In-Reply-To: 20191213230022.28144-3-mathew.j.martineau@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3039

--===============5903364273704591639==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 12/13/19 3:00 PM, Mat Martineau wrote:
> Match the 16-bit width of skbuff->protocol. Fills an 8-bit hole so
> sizeof(struct sock) does not change.
> =

> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> ---
>  include/net/sock.h          | 4 ++--
>  include/trace/events/sock.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> =

> diff --git a/include/net/sock.h b/include/net/sock.h
> index 81dc811aad2e..9dd225f62012 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -456,10 +456,10 @@ struct sock {
>  				sk_no_check_tx : 1,
>  				sk_no_check_rx : 1,
>  				sk_userlocks : 4,
> -				sk_protocol  : 8,
> +				sk_pacing_shift : 8,
>  				sk_type      : 16;
> +	u16			sk_protocol;
>  	u16			sk_gso_max_segs;
> -	u8			sk_pacing_shift;

Unfortunately sk_pacing_shift must not be a bit field.

I have a patch to add proper READ_ONCE()/WRITE_ONCE() on it,
since an update can be done from a lockless context ( sk_pacing_shift_updat=
e())
--===============5903364273704591639==--
