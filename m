Content-Type: multipart/mixed; boundary="===============0434463290562035629=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: fix oops on accept
Date: Tue, 23 Apr 2019 17:17:43 -0700
Message-ID: <alpine.OSX.2.21.1904231708570.13139@leejosex-mobl.amr.corp.intel.com>
In-Reply-To: b1afba00fa51ded07cdfabed76b28bd2ccb7cc8c.1555593820.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1083

--===============0434463290562035629==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Apr 2019, Paolo Abeni wrote:

> while running the self-test on a multi core VM, with a standard (non
> debug) kernel config, I hit the following oops:
>
> [  234.587877] BUG: unable to handle kernel NULL pointer dereference at 0=
000000000000020
> [  234.591567] #PF error: [normal kernel read fault]
> [  234.593862] PGD 800000013a8ec067 P4D 800000013a8ec067 PUD 13a2ad067 PM=
D 0
> [  234.596616] Oops: 0000 [#1] SMP PTI
> [  234.597173] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.1.0-rc4.mptcp_=
xmit_07723d4+ #2139
> [  234.598363] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S ?-20180724_192412-buildhw-07.phx2.fedoraproject.org-1.fc29 04/01/2014
> [  234.599847] RIP: 0010:mptcp_finish_connect+0x2a/0x160

...

>
> The problem is in mptcp_accept(): the newly created subflow is
> already added to the mptcp subflow list, but conn_finished is not set.
>
> On next rx dst cache update we enter subflow_finish_connect()/mptcp_finis=
h_connect()
> and hit the crash due to NULL msk->subflow de-referncing.
>
> Fix the above properly initializing the subflow at accept() time.

Peter and I have been looking in to this crash. It could be due to a =

use-after-free bug, since conn_finished isn't expected to be used on the =

accepting socket. The symptoms are similar to KASAN report I was seeing on =

my multicore VM.

I'm working on a full fix, but you might see if setting =

newsk->icsk_ulp_ops and newsk->icsk_ulp_data to NULL in =

inet_csk_clone_lock() prevents the crash.


Mat


>
> Fixes: a36080381c36 ("mptcp: Create SUBFLOW socket for incoming connectio=
ns")
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
>
> ---
> Note: I'm ok with swashing this change in the commit referenced by the
> 'fixes' tag.
> ---
> net/mptcp/protocol.c | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 55a39ec748b5..fcfb74818c30 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -639,6 +639,7 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
> 		subflow->map_subflow_seq =3D 1;
> 		subflow->rel_write_seq =3D 1;
> 		subflow->conn =3D new_mptcp_sock->sk;
> +		subflow->conn_finished =3D 1;
> 	} else {
> 		msk->subflow =3D new_sock;
> 	}
> -- =

> 2.20.1
>
> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
>

--
Mat Martineau
Intel

--===============0434463290562035629==--
