Content-Type: multipart/mixed; boundary="===============6272744408497946883=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH net 1/2] mptcp: fix static checker warnings
 in mptcp_pm_add_timer
Date: Mon, 09 Nov 2020 17:28:54 +0100
Message-ID: <009ea5da-8a44-3ea2-1b9f-a658a09f3396@tessares.net>
In-Reply-To: ccf004469e02fb5bd7ec822414b9a98b0015f4a3.1604930005.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6607

--===============6272744408497946883==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang, Dan,

On 09/11/2020 14:59, Geliang Tang wrote:
> Fix the following Smatch complaint:

Thanks for the report and the patch!

>       net/mptcp/pm_netlink.c:213 mptcp_pm_add_timer()
>       warn: variable dereferenced before check 'msk' (see line 208)
> =

>   net/mptcp/pm_netlink.c
>      207          struct mptcp_sock *msk =3D entry->sock;
>      208          struct sock *sk =3D (struct sock *)msk;
>      209          struct net *net =3D sock_net(sk);
>                                             ^^
>   "msk" dereferenced here.
> =

>      210
>      211          pr_debug("msk=3D%p", msk);
>      212
>      213          if (!msk)
>                      ^^^^
>   Too late.
> =

>      214                  return;
>      215
> =

> Fixes: 93f323b9cccc ("mptcp: add a new sysctl add_addr_timeout")
> Reported-by: Dan Carpenter <dan.carpenter(a)oracle.com>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> Reviewed-by: Dan Carpenter <dan.carpenter(a)oracle.com>

A small detail (I think): the Signed-off-by of the sender (Geliang) =

should be the last one in the list if I am not mistaken.
But I guess this is not blocking.

Reviewed-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============6272744408497946883==--
