Content-Type: multipart/mixed; boundary="===============8026062569828174817=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp 3/4] protocol: use sk_wait_event helper
Date: Tue, 05 Nov 2019 18:43:47 +0100
Message-ID: <4619f9f4b5a0329e388a8761f45e2b14de0f253c.camel@redhat.com>
In-Reply-To: 20191105170531.30407-4-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2399

--===============8026062569828174817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-11-05 at 18:05 +0100, Florian Westphal wrote:
> Avoids a bit of copy&paste code.
> squashto:  mptcp: recvmsg() can drain data from multiple subflows
> =

> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  net/mptcp/protocol.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 3af5f121af9e..8cc9cc5675c2 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -443,22 +443,12 @@ static void mptcp_wait_data(struct sock *sk, long *=
timeo)
>  {
>  	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
> -	int data_ready;
>  =

>  	add_wait_queue(sk_sleep(sk), &wait);
>  	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>  =

> -	release_sock(sk);
> -
> -	smp_mb__before_atomic();
> -	data_ready =3D test_and_clear_bit(MPTCP_DATA_READY, &msk->flags);
> -	smp_mb__after_atomic();
> -
> -	if (!data_ready)
> -		*timeo =3D wait_woken(&wait, TASK_INTERRUPTIBLE, *timeo);
> -
> -	sched_annotate_sleep();
> -	lock_sock(sk);
> +	sk_wait_event(sk, timeo,
> +		      test_and_clear_bit(MPTCP_DATA_READY, &msk->flags), &wait);
>  =

>  	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>  	remove_wait_queue(sk_sleep(sk), &wait);

IIRC, sk_wait_event() was intentionally avoided to allow placing the
smp_mb__{before,after}_atomic() pair around test_and_clear_bit(), which
I thought was required.

Reading again the relevant documentation:

https://elixir.bootlin.com/linux/latest/source/Documentation/core-api/atomi=
c_ops.rst#L485

it looks like test_and_clear_bit() provides already the required
barriers (also grepping inside the kernel sources suggests that).

So the above should be correct, I'm sorry for being cyclothymic ;)

/P

--===============8026062569828174817==--
