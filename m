Content-Type: multipart/mixed; boundary="===============7567507598081039343=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 24/24] net: pass a sockptr_t into ->setsockopt
Date: Wed, 22 Jul 2020 10:26:42 +0200
Message-ID: <b3665200-2476-9d35-8dea-d5da141c6b70@tessares.net>
In-Reply-To: 20200720124737.118617-25-hch@lst.de
X-Status: 
X-Keywords:                  
X-UID: 5168

--===============7567507598081039343==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On 20/07/2020 14:47, Christoph Hellwig wrote:
> Rework the remaining setsockopt code to pass a sockptr_t instead of a
> plain user pointer.  This removes the last remaining set_fs(KERNEL_DS)
> outside of architecture specific code.
> =

> Signed-off-by: Christoph Hellwig <hch(a)lst.de>
> ---

...
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 27b6f250b87dfd..30a8e697b9db9c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1627,7 +1627,7 @@ static void mptcp_destroy(struct sock *sk)
>   }
>   =

>   static int mptcp_setsockopt_sol_socket(struct mptcp_sock *msk, int optn=
ame,
> -				       char __user *optval, unsigned int optlen)
> +				       sockptr_t optval, unsigned int optlen)
>   {
>   	struct sock *sk =3D (struct sock *)msk;
>   	struct socket *ssock;
> @@ -1643,8 +1643,8 @@ static int mptcp_setsockopt_sol_socket(struct mptcp=
_sock *msk, int optname,
>   			return -EINVAL;
>   		}
>   =

> -		ret =3D sock_setsockopt(ssock, SOL_SOCKET, optname,
> -				      USER_SOCKPTR(optval), optlen);
> +		ret =3D sock_setsockopt(ssock, SOL_SOCKET, optname, optval,
> +				      optlen);

A very small detail related to the modifications in MPTCP code, only if =

you have to send a v2 and if you don't mind: may you move "optlen" to =

the previous line like it was before your patch 7/24. Same below at the =

end of the function.

That would reduce the global diff in MPTCP files to function signatures =

only.

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============7567507598081039343==--
