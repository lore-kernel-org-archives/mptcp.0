Content-Type: multipart/mixed; boundary="===============5971520117300648222=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next] mptcp: send ack for every
 add_addr
Date: Fri, 22 Jan 2021 18:42:16 +0100
Message-ID: <95a54af9621efd66517159b948c65ead3d886143.camel@redhat.com>
In-Reply-To: 93f8d1cb4ad54d30539c7a3ec1455afc13388844.1611314528.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7471

--===============5971520117300648222==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-01-22 at 19:25 +0800, Geliang Tang wrote:
> This patch changes the sending ACK conditions for the ADD_ADDR, send an A=
CK
> packet for any ADD_ADDR, not just when ipv6 addresses or port numbers
> are included.
> =

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/139
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  v3:
>   - drop the duplicate mptcp_pm_should_add_signal(msk) check in v2.
>  v2:
>   - print out the debug output on one line.
> ---
>  net/mptcp/pm.c         |  3 +--
>  net/mptcp/pm_netlink.c | 10 ++++------
>  2 files changed, 5 insertions(+), 8 deletions(-)
> =

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 01a846b25771..3a22e73220b9 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -191,8 +191,7 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *ms=
k,
>  =

>  void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
>  {
> -	if (!mptcp_pm_should_add_signal_ipv6(msk) &&
> -	    !mptcp_pm_should_add_signal_port(msk))
> +	if (!mptcp_pm_should_add_signal(msk))
>  		return;
>  =

>  	mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 39998c521133..37b4c9068f8d 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -496,8 +496,7 @@ void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock =
*msk)
>  {
>  	struct mptcp_subflow_context *subflow;
>  =

> -	if (!mptcp_pm_should_add_signal_ipv6(msk) &&
> -	    !mptcp_pm_should_add_signal_port(msk))
> +	if (!mptcp_pm_should_add_signal(msk))
>  		return;
>  =

>  	__mptcp_flush_join_list(msk);
> @@ -507,10 +506,9 @@ void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock=
 *msk)
>  		u8 add_addr;
>  =

>  		spin_unlock_bh(&msk->pm.lock);
> -		if (mptcp_pm_should_add_signal_ipv6(msk))
> -			pr_debug("send ack for add_addr6");
> -		if (mptcp_pm_should_add_signal_port(msk))
> -			pr_debug("send ack for add_addr_port");
> +		pr_debug("send ack for add_addr%s%s",
> +			 mptcp_pm_should_add_signal_ipv6(msk) ? " [ipv6]" : "",
> +			 mptcp_pm_should_add_signal_port(msk) ? " [port]" : "");
>  =

>  		lock_sock(ssk);
>  		tcp_send_ack(ssk);

This version LGTM!

Acked-by: Paolo Abeni <pabeni(a)redhat.com>

--===============5971520117300648222==--
