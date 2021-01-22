Content-Type: multipart/mixed; boundary="===============5662689058858707581=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next] mptcp: send ack for every
 add_addr
Date: Fri, 22 Jan 2021 11:45:23 +0100
Message-ID: <646875c8907c209d3addf1c2e5897a2b920777e7.camel@redhat.com>
In-Reply-To: e5e3e55c8caf3cba6b07d0a92ff080792949a41a.1611285417.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7468

--===============5662689058858707581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I'm sorry for the late feeback.

On Fri, 2021-01-22 at 11:18 +0800, Geliang Tang wrote:
> This patch changes the sending ACK conditions for the ADD_ADDR, send an A=
CK
> packet for any ADD_ADDR, not just when ipv6 addresses or port numbers
> are included.
> =

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/139
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  v2:
>   - print out the debug output on one line.
> ---
>  net/mptcp/pm.c         |  3 +--
>  net/mptcp/pm_netlink.c | 12 ++++++------
>  2 files changed, 7 insertions(+), 8 deletions(-)
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
> index 39998c521133..369cb787169f 100644
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
> @@ -507,10 +506,11 @@ void mptcp_pm_nl_add_addr_send_ack(struct mptcp_soc=
k *msk)
>  		u8 add_addr;
>  =

>  		spin_unlock_bh(&msk->pm.lock);
> -		if (mptcp_pm_should_add_signal_ipv6(msk))
> -			pr_debug("send ack for add_addr6");
> -		if (mptcp_pm_should_add_signal_port(msk))
> -			pr_debug("send ack for add_addr_port");
> +		if (mptcp_pm_should_add_signal(msk)) {

Didn't we check mptcp_pm_should_add_signal(msk) eariler in this same
function? I think we can skip the check here.

Thanks!

Paolo

--===============5662689058858707581==--
