Content-Type: multipart/mixed; boundary="===============5151142528524322601=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH] subflow: held a ref to the current net
Date: Mon, 13 Jan 2020 15:04:40 -0800
Message-ID: <alpine.OSX.2.21.2001131501540.9332@nhnichol-mobl2.amr.corp.intel.com>
In-Reply-To: 9c759abdef0ec82c2648c423578256f0f71611ea.1578941741.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3349

--===============5151142528524322601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 13 Jan 2020, Paolo Abeni wrote:

> The MPTCP subflows are created via sock_create_kern(), so they
> do not held any references to the current network namespace.
>
> The TCP timer infrastructure assumes the current net is always
> alive/goes away after the relevant sock.
>
> Due to the above packetdrill is able to trigger UAF with some
> simple scenario (and fast netns tear-down).
>
> Acquire a reference to the current net at creation time.
>
> Note: using __sock_create(/*...*/, 0) will break lockdep (kernel
> socket get a different lockdep key).
> ---
> net/mptcp/subflow.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 2c0f2ed7a428..750fe14db4bc 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -585,6 +585,11 @@ int mptcp_subflow_create_socket(struct sock *sk, str=
uct socket **new_sock)
> 		return err;
>
> 	lock_sock(sf->sk);
> +	/* kern socket do not acquire by default net ref, but TCP timer need it
> +	 */
> +	sf->sk->sk_net_refcnt =3D 1;
> +	get_net(net);
> +	this_cpu_add(*net->core.sock_inuse, 1);
> 	err =3D tcp_set_ulp(sf->sk, "mptcp");
> 	release_sock(sf->sk);
>
> -- =

> 2.21.0

Looks good to me - I was wondering where the matching put_net() would be, =

and saw that setting sk_net_refcnt here will trigger the put_net() in =

__sk_destruct()

--
Mat Martineau
Intel
--===============5151142528524322601==--
