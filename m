Content-Type: multipart/mixed; boundary="===============2611067858301596193=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH net 1/2] mptcp: fix subflow's local_id
 issues
Date: Mon, 07 Sep 2020 17:07:05 +0200
Message-ID: <16c012eb-7bf9-2606-5a60-d43c2579873b@tessares.net>
In-Reply-To: f24ee917e4043d2befe2a0f96cd57aa74d2a4b26.1599474422.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5750

--===============2611067858301596193==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Geliang,

On 07/09/2020 12:29, Geliang Tang wrote:
> In mptcp_pm_nl_get_local_id, skc_local is the same as msk_local, so it
> always return 0. Thus every subflow's local_id is 0. It's incorrect.
> =

> This patch fixed this issue.
> =

> Also, we need to ignore the zero address here, like 0.0.0.0 in IPv4. When
> we use the zero address as a local address, it means that we can use any
> one of the local addresses. The zero address is not a new address, we don=
't
> need to add it to PM, so this patch added a new function address_zero to
> check whether an address is the zero address, if it is, we ignore this
> address.

Thank you for this patch!

As any patch for -net, may you add a "Fixes:" tag please?

(Also, I don't know if it is normal but I didn't receive the cover-letter)

(...)

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 2c208d2e65cd..dc2c57860d2d 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -66,6 +66,19 @@ static bool addresses_equal(const struct mptcp_addr_in=
fo *a,
>   	return a->port =3D=3D b->port;
>   }
>   =

> +static bool address_zero(const struct mptcp_addr_info *addr)
> +{
> +	struct mptcp_addr_info zero;
> +
> +	memset(&zero, 0, sizeof(zero));
> +	zero.family =3D addr->family;
> +
> +	if (addresses_equal(addr, &zero, false))

Small detail: here you can simply have:

   return addresses_equal(addr, &zero, false);

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2611067858301596193==--
