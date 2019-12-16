Content-Type: multipart/mixed; boundary="===============5893919270800711115=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "sock: Make sk_protocol a 16-bit value"
Date: Mon, 16 Dec 2019 08:51:05 -0800
Message-ID: <alpine.OSX.2.21.1912160837330.6806@mjmartin-mac01.local>
In-Reply-To: a9ebee974914c23cc68877a188908d1a8fa07a5f.1576499362.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3080

--===============5893919270800711115==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 16 Dec 2019, Paolo Abeni wrote:

> move sk_pacing_shift to a separate field, so we can READ_ONCE() it.
>
> Binary layout of struct sock dose not change (except for the
> sk_pacing_shift position)
> ---
> This addresses Eric's upstream feedback on v1
> ---
> include/net/sock.h | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/net/sock.h b/include/net/sock.h
> index 9dd225f62012..0930f46c600c 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -456,8 +456,8 @@ struct sock {
> 				sk_no_check_tx : 1,
> 				sk_no_check_rx : 1,
> 				sk_userlocks : 4,
> -				sk_pacing_shift : 8,
> 				sk_type      : 16;
> +	u8			sk_pacing_shift;
> 	u16			sk_protocol;
> 	u16			sk_gso_max_segs;

sk_pacing_shift was here (between sk_gso_max_segs and sk_lingertime) =

before, would be good to put it back where it was for a clean diff.

> 	unsigned long	        sk_lingertime;
> -- =

> 2.21.0

--
Mat Martineau
Intel
--===============5893919270800711115==--
