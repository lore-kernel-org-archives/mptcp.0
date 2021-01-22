Content-Type: multipart/mixed; boundary="===============5136998684301385671=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next] mptcp: send ack for every
 add_addr
Date: Thu, 21 Jan 2021 17:19:33 -0800
Message-ID: <a68ce22c-283-4e2-868d-28538fc41876@linux.intel.com>
In-Reply-To: 4be0fc0ea68afa7ab32a9132a938b4f6bcd6569b.1611126450.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7464

--===============5136998684301385671==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Jan 2021, Geliang Tang wrote:

> This patch changes the sending ACK conditions for the ADD_ADDR, send an A=
CK
> packet for any ADD_ADDR, not just when ipv6 addresses or port numbers
> are included.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/139
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>

Thanks Geliang. I'm trying to confirm that kbuild doesn't encounter the =

timeout any more, but I have to wait for the build queue.

> ---
> Obsoletes: "add add_addr_urgent" patchset
> ---
> net/mptcp/pm.c         | 3 +--
> net/mptcp/pm_netlink.c | 9 +++++----
> 2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 01a846b25771..3a22e73220b9 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -191,8 +191,7 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *ms=
k,
>
> void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk)
> {
> -	if (!mptcp_pm_should_add_signal_ipv6(msk) &&
> -	    !mptcp_pm_should_add_signal_port(msk))
> +	if (!mptcp_pm_should_add_signal(msk))
> 		return;
>
> 	mptcp_pm_schedule_work(msk, MPTCP_PM_ADD_ADDR_SEND_ACK);
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 39998c521133..7e6e99abdd33 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -496,8 +496,7 @@ void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock =
*msk)
> {
> 	struct mptcp_subflow_context *subflow;
>
> -	if (!mptcp_pm_should_add_signal_ipv6(msk) &&
> -	    !mptcp_pm_should_add_signal_port(msk))
> +	if (!mptcp_pm_should_add_signal(msk))
> 		return;
>
> 	__mptcp_flush_join_list(msk);
> @@ -507,10 +506,12 @@ void mptcp_pm_nl_add_addr_send_ack(struct mptcp_soc=
k *msk)
> 		u8 add_addr;
>
> 		spin_unlock_bh(&msk->pm.lock);
> +		if (mptcp_pm_should_add_signal(msk))
> +			pr_debug("send ack for add_addr");
> 		if (mptcp_pm_should_add_signal_ipv6(msk))
> -			pr_debug("send ack for add_addr6");
> +			pr_debug("[ipv6]");
> 		if (mptcp_pm_should_add_signal_port(msk))
> -			pr_debug("send ack for add_addr_port");
> +			pr_debug("[port]");

I suggest getting the debug output to print on one line like this:

if (mptcp_pm_should_add_signal(msk))
 	pr_debug("send ack for add_addr%s%s",
 		 mptcp_pm_should_add_signal_ipv6(msk) ? " [ipv6]" : "",
 		 mptcp_pm_should_add_signal_port(msk) ? " [port]" : "");

> 		lock_sock(ssk);
> 		tcp_send_ack(ssk);
> -- =

> 2.29.2

--
Mat Martineau
Intel
--===============5136998684301385671==--
