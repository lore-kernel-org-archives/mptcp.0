Content-Type: multipart/mixed; boundary="===============7079615349037112375=="
MIME-Version: 1.0
From: Jakub Kicinski <kuba at kernel.org>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 net-next] mptcp: fix static checker
 warnings in mptcp_pm_add_timer
Date: Thu, 12 Nov 2020 07:55:54 -0800
Message-ID: <20201112075554.00739ede@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: 078a2ef5bdc4e3b2c25ef852461692001f426495.1604976945.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6686

--===============7079615349037112375==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Nov 2020 11:01:43 +0800 Geliang Tang wrote:
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

> Fixes: 93f323b9cccc ("mptcp: add a new sysctl add_addr_timeout")
> Reported-by: Dan Carpenter <dan.carpenter(a)oracle.com>
> Reviewed-by: Dan Carpenter <dan.carpenter(a)oracle.com>
> Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

Applied, thanks!
--===============7079615349037112375==--
