Content-Type: multipart/mixed; boundary="===============3860234979485374487=="
MIME-Version: 1.0
From: Dan Carpenter <dan.carpenter at oracle.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH net] mptcp: fix static checker warnings in
 mptcp_pm_add_timer
Date: Mon, 09 Nov 2020 14:17:06 +0300
Message-ID: <20201109111706.GL18329@kadam>
In-Reply-To: 81e64bc4a6891edcff237ef76f7c10ebb2873957.1604916744.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6594

--===============3860234979485374487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2020 at 06:13:12PM +0800, Geliang Tang wrote:
> Fix the following Smatch complaint:
> =

>      net/mptcp/pm_netlink.c:213 mptcp_pm_add_timer()
>      warn: variable dereferenced before check 'msk' (see line 208)
> =

>  net/mptcp/pm_netlink.c
>     207          struct mptcp_sock *msk =3D entry->sock;
>     208          struct sock *sk =3D (struct sock *)msk;
>     209          struct net *net =3D sock_net(sk);
>                                            ^^
>  "msk" dereferenced here.
> =

>     210
>     211          pr_debug("msk=3D%p", msk);
>     212
>     213          if (!msk)
>                     ^^^^
>  Too late.
> =

>     214                  return;
>     215
> =

> Fixes: 00cfd77b9063 ("mptcp: retransmit ADD_ADDR when timeout")
> Reported-by: Dan Carpenter <dan.carpenter(a)oracle.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

Reviewed-by: Dan Carpenter <dan.carpenter(a)oracle.com>

I don't know how mptcp patches are applied, but I think you need to CC
netdev and the other maintainers.

regards,
dan carpenter

--===============3860234979485374487==--
