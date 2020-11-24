Content-Type: multipart/mixed; boundary="===============0386234954112748421=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: put reference in mptcp timeout
 timer
Date: Tue, 24 Nov 2020 17:42:21 +0100
Message-ID: <e44300a0567cdec8241c06d1c6b78083cdd4254a.camel@redhat.com>
In-Reply-To: 20201124162446.11448-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 6903

--===============0386234954112748421==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-11-24 at 17:24 +0100, Florian Westphal wrote:
> On close this timer might be scheduled. mptcp uses sk_reset_timer for
> this, so the a reference on the mptcp socket is taken.
> =

> This causes a refcount leak which can for example be reproduced
> with 'mp_join_server_v4.pkt' from the mptcp-packetdrill repo.

Whoops, my fault!

> The leak has nothing to do with join requests, v1_mp_capable_bind_no_cs.p=
kt
> works too when replacing the last ack mpcapable to v1 instead of v0.
> =

> unreferenced object 0xffff888109bba040 (size 2744):
>   comm "packetdrill", [..]
>   backtrace:
>     [..] sk_prot_alloc.isra.0+0x2b/0xc0
>     [..] sk_clone_lock+0x2f/0x740
>     [..] mptcp_sk_clone+0x33/0x1a0
>     [..] subflow_syn_recv_sock+0x2b1/0x690 [..]
> =

> Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
> Cc: Paolo Abeni <pabeni(a)redhat.com>
> Cc: Davide Caratti <dcaratti(a)redhat.com>
> Signed-off-by: Florian Westphal <fw(a)strlen.de>
> ---
>  net/mptcp/protocol.c | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 4b7794835fea..dc979571f561 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1710,6 +1710,7 @@ static void mptcp_timeout_timer(struct timer_list *=
t)
>  	struct sock *sk =3D from_timer(sk, t, sk_timer);
>  =

>  	mptcp_schedule_work(sk);
> +	sock_put(sk);
>  }
>  =

>  /* Find an idle subflow.  Return NULL if there is unacked data at tcp

LGTM, thanks!
Acked-by: Paolo Abeni <pabeni(a)redhat.com>

--===============0386234954112748421==--
