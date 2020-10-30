Content-Type: multipart/mixed; boundary="===============2214503310534087107=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next] mptcp: add
 mptcp_pm_should_add_signal_echo helper
Date: Thu, 29 Oct 2020 17:03:49 -0700
Message-ID: <acdace46-c5d0-614d-566-4e0d4f2cf7a@linux.intel.com>
In-Reply-To: 9b71955a98bb1d28d8c5603d007a6a22aa584082.1603943436.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6479

--===============2214503310534087107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Thu, 29 Oct 2020, Geliang Tang wrote:

> This patch added a new helper mptcp_pm_should_add_signal_echo.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/pm.c       | 2 +-
> net/mptcp/protocol.h | 5 +++++
> 2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 83f59a428560..75c5040e8d5d 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -198,7 +198,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk,=
 unsigned int remaining,
> 	if (!mptcp_pm_should_add_signal(msk))
> 		goto out_unlock;
>
> -	*echo =3D READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_ECHO);
> +	*echo =3D mptcp_pm_should_add_signal_echo(msk);
>
> 	if (remaining < mptcp_add_addr_len(msk->pm.local.family, *echo))
> 		goto out_unlock;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 7a5c16f176c0..d29c6a4749eb 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -529,6 +529,11 @@ static inline bool mptcp_pm_should_add_signal(struct=
 mptcp_sock *msk)
> 	return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_SIGNAL);
> }
>
> +static inline bool mptcp_pm_should_add_signal_echo(struct mptcp_sock *ms=
k)
> +{
> +	return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_ECHO);
> +}
> +
> static inline bool mptcp_pm_should_add_signal_ipv6(struct mptcp_sock *msk)
> {
> 	return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_ADD_ADDR_IPV6);
> -- =

> 2.26.2

Thanks for the cleanup

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============2214503310534087107==--
