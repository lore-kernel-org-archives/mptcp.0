Content-Type: multipart/mixed; boundary="===============0199782678241879240=="
MIME-Version: 1.0
From: Geliang Tang <geliangtang at gmail.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH][next] mptcp: fix a dereference of pointer before
 msk is null checked.
Date: Mon, 09 Nov 2020 22:36:25 +0800
Message-ID: <CA+WQbwsAn_4160ZR0P50McuhadLG_M_uC9mAvf_85DJLDeoSVQ@mail.gmail.com>
In-Reply-To: 20201109125215.2080172-1-colin.king@canonical.com
X-Status: 
X-Keywords:                  
X-UID: 6600

--===============0199782678241879240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Colin,

Thanks for your patch. But this bug is reported by Dan Carpenter to MPTCP
ML earlier, and I have already sent out a fix in MPTCP ML for review. So
your fix is duplicated. I'm sorry.

-Geliang

Colin King <colin.king(a)canonical.com> =E4=BA=8E2020=E5=B9=B411=E6=9C=889=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=888:52=E5=86=99=E9=81=93=EF=BC=
=9A

>
> From: Colin Ian King <colin.king(a)canonical.com>
>
> Currently the assignment of pointer net from the sock_net(sk) call
> is potentially dereferencing a null pointer sk. sk points to the
> same location as pointer msk and msk is being null checked after
> the sock_net call.  Fix this by calling sock_net after the null
> check on pointer msk.
>
> Addresses-Coverity: ("Dereference before null check")
> Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
> Signed-off-by: Colin Ian King <colin.king(a)canonical.com>
> ---
>  net/mptcp/pm_netlink.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index ed60538df7b2..e76879ea5a30 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -206,13 +206,15 @@ static void mptcp_pm_add_timer(struct timer_list *t=
imer)
>         struct mptcp_pm_add_entry *entry =3D from_timer(entry, timer, add=
_timer);
>         struct mptcp_sock *msk =3D entry->sock;
>         struct sock *sk =3D (struct sock *)msk;
> -       struct net *net =3D sock_net(sk);
> +       struct net *net;
>
>         pr_debug("msk=3D%p", msk);
>
>         if (!msk)
>                 return;
>
> +       net =3D sock_net(sk);
> +
>         if (inet_sk_state_load(sk) =3D=3D TCP_CLOSE)
>                 return;
>
> --
> 2.28.0
>
--===============0199782678241879240==--
