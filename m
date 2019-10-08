Content-Type: multipart/mixed; boundary="===============6623446837680729439=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 1/2] mptcp: subflow: disallow setsockopt(...
 TCP_ULP, "mptcp")
Date: Tue, 08 Oct 2019 17:00:01 +0200
Message-ID: <92a4ccb4-57b7-4dfb-e631-bc399a5b0401@tessares.net>
In-Reply-To: ae8e4d5132a8882ae4ae558d31f200a8ef8bef96.1570545679.git.dcaratti@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2052

--===============6623446837680729439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Davide,

On 08/10/2019 16:43, Davide Caratti wrote:
> the MPTCP ULP can be attached to a TCP socket only if the socket has been
> created with sock_create_kern(): ensure that the value of sk->sk_kern_sock
> is 1 in the MPTCP subflow init() function, and let it return -EOPNOTSUPP
> otherwise.
> =

> Signed-off-by: Davide Caratti <dcaratti(a)redhat.com>
> ---
>  net/mptcp/subflow.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> =

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index ebe93525b0aa..b40d927e71ca 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -435,6 +435,13 @@ static int subflow_ulp_init(struct sock *sk)
>  	struct tcp_sock *tp =3D tcp_sk(sk);
>  	int err =3D 0;
>  =

> +	/* disallow attaching ULP to a socket unless it has been
> +	 * created with sock_create_kern()
> +	 */
> +	if (!sk->sk_kern_sock) {
> +		err =3D -EOPNOTSUPP;
> +		goto out;
> +	}

That's good to do that only in MPTCP code!

A very small detail if you have to do a v2: may you add a new line here
to separate your new code from the following?

If you don't need a v2 and OK with you, I can add a new line by applying
the new patch.

>  	ctx =3D subflow_create_ctx(sk, sk->sk_socket, GFP_KERNEL);
>  	if (!ctx) {
>  		err =3D -ENOMEM;
> =


Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============6623446837680729439==--
