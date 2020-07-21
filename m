Content-Type: multipart/mixed; boundary="===============2281884079581234798=="
MIME-Version: 1.0
From: Luc Van Oostenryck <luc.vanoostenryck at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 02/24] bpfilter: fix up a sparse annotation
Date: Tue, 21 Jul 2020 04:40:16 +0200
Message-ID: <20200721024016.2talwdt5hjqvirr6@ltop.local>
In-Reply-To: 20200720124737.118617-3-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5136

--===============2281884079581234798==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2020 at 02:47:15PM +0200, Christoph Hellwig wrote:
> The __user doesn't make sense when casting to an integer type.
> =

> Signed-off-by: Christoph Hellwig <hch(a)lst.de>
> ---
>  net/bpfilter/bpfilter_kern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
> index 977e9dad72ca4f..713b4b3d02005d 100644
> --- a/net/bpfilter/bpfilter_kern.c
> +++ b/net/bpfilter/bpfilter_kern.c
> @@ -49,7 +49,7 @@ static int __bpfilter_process_sockopt(struct sock *sk, =
int optname,
>  	req.is_set =3D is_set;
>  	req.pid =3D current->pid;
>  	req.cmd =3D optname;
> -	req.addr =3D (long __force __user)optval;
> +	req.addr =3D (__force long)optval;

For casts to integers, even '__force' is not needed (since integers
can't be dereferenced, the concept of address-space is meaningless
for them, so it's never useful to warn when it's dropped and
'__force' is thus not needed).

-- Luc
--===============2281884079581234798==--
