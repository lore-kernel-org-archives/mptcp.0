Content-Type: multipart/mixed; boundary="===============0947751956300309742=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH net 2/2] mptcp: fix subflow's remote_id
 issues
Date: Mon, 07 Sep 2020 17:07:33 +0200
Message-ID: <a62124ba-bb3e-bd19-e2b4-50e8cb1465ea@tessares.net>
In-Reply-To: 7187516ee5a9f17a7bf1e4aa9a849da2dd56a734.1599474422.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5751

--===============0947751956300309742==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 07/09/2020 12:29, Geliang Tang wrote:
> This patch set the init remote_id to zero, otherwise it will be a random
> number.
> =

> Then it added the missing subflow's remote_id setting code both in
> __mptcp_subflow_connect and in subflow_ulp_clone.

Thank you for this other patch!

Here as well, may you add a "Fixes:" tag please?

(...)

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index dc2c57860d2d..255695221309 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -186,7 +186,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(st=
ruct mptcp_sock *msk)
>   {
>   	struct sock *sk =3D (struct sock *)msk;
>   	struct mptcp_pm_addr_entry *local;
> -	struct mptcp_addr_info remote;
> +	struct mptcp_addr_info remote =3D { 0 };

To respect the "reversed Xmas tree" way to declare variables, may you =

move this line up to be the first one in the list please?

The rest looks good to me, thank you!

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============0947751956300309742==--
