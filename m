Content-Type: multipart/mixed; boundary="===============6761542492419960538=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next] mptcp: send ack for rm_addr
Date: Mon, 15 Mar 2021 17:04:50 -0700
Message-ID: <983375b7-e142-e5c5-eafc-16f77c618557@linux.intel.com>
In-Reply-To: 1bab2d6ccf0f6d8212af7f9e6f8349b0c0926bbb.1615818221.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8160

--===============6761542492419960538==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Mar 2021, Geliang Tang wrote:

> This patch changes the sending ACK conditions for the ADD_ADDR, send an
> ACK packet for RM_ADDR too.
>
> Note:
> - Insert this commit between "mptcp: move to next addr when subflow
> creation fail" and "selftests: mptcp: signal addresses testcases".
> - Apply the patch 'Squash to "mptcp: remove id 0 address"' first.
> - tag: export/20210315T064655.
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/173
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/pm.c         |  1 +
> net/mptcp/pm_netlink.c | 15 +++++++++------
> net/mptcp/protocol.h   |  1 +
> 3 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 966942d1013f..efa7deb96139 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -53,6 +53,7 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, const =
struct mptcp_rm_list *rm_
> 	msk->pm.rm_list_tx =3D *rm_list;
> 	rm_addr |=3D BIT(MPTCP_RM_ADDR_SIGNAL);
> 	WRITE_ONCE(msk->pm.addr_signal, rm_addr);
> +	mptcp_pm_nl_add_addr_send_ack(msk);
> 	return 0;
> }
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 6bb6117bf2f7..71ba203bfc5f 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -56,8 +56,6 @@ struct pm_nl_pernet {
> #define MPTCP_PM_ADDR_MAX	8
> #define ADD_ADDR_RETRANS_MAX	3
>
> -static void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *msk);
> -
> static bool addresses_equal(const struct mptcp_addr_info *a,
> 			    struct mptcp_addr_info *b, bool use_port)
> {
> @@ -524,14 +522,15 @@ static void mptcp_pm_nl_add_addr_received(struct mp=
tcp_sock *msk)
> 	mptcp_pm_nl_add_addr_send_ack(msk);
> }
>
> -static void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *msk)
> +void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *msk)

Like commit 13ad9f01a29e3f458fb3b319fb53323b2b0d1e68 I think it makes =

sense to remove the "add" from this function name, since this is now used =

for both add and rm cases. Ok to make that a separate commit.

> {
> 	struct mptcp_subflow_context *subflow;
>
> 	msk_owned_by_me(msk);
> 	lockdep_assert_held(&msk->pm.lock);
>
> -	if (!mptcp_pm_should_add_signal(msk))
> +	if (!mptcp_pm_should_add_signal(msk) &&
> +	    !mptcp_pm_should_rm_signal(msk))
> 		return;
>
> 	__mptcp_flush_join_list(msk);
> @@ -541,9 +540,11 @@ static void mptcp_pm_nl_add_addr_send_ack(struct mpt=
cp_sock *msk)
> 		u8 add_addr;
>
> 		spin_unlock_bh(&msk->pm.lock);
> -		pr_debug("send ack for add_addr%s%s",
> +		pr_debug("send ack for %s%s%s%s",
> +			 mptcp_pm_should_add_signal(msk) ? "add_addr" : "",
> 			 mptcp_pm_should_add_signal_ipv6(msk) ? " [ipv6]" : "",
> -			 mptcp_pm_should_add_signal_port(msk) ? " [port]" : "");
> +			 mptcp_pm_should_add_signal_port(msk) ? " [port]" : "",
> +			 mptcp_pm_should_rm_signal(msk) ? "rm_addr" : "");

It would be better to add this before the ipv6 line above, so "add_addr" =

and "rm_addr" would appear in the same place in the debug output.

>
> 		lock_sock(ssk);
> 		tcp_send_ack(ssk);
> @@ -555,6 +556,8 @@ static void mptcp_pm_nl_add_addr_send_ack(struct mptc=
p_sock *msk)
> 			add_addr &=3D ~BIT(MPTCP_ADD_ADDR_IPV6);
> 		if (mptcp_pm_should_add_signal_port(msk))
> 			add_addr &=3D ~BIT(MPTCP_ADD_ADDR_PORT);
> +		if (mptcp_pm_should_rm_signal(msk))
> +			add_addr &=3D ~BIT(MPTCP_RM_ADDR_SIGNAL);

It looks like msk->pm.addr_signal is also cleared in =

mptcp_pm_rm_addr_signal() - is it necessary to clear it here? It seems =

like adding these lines could clear the bit even when the RM_ADDR hasn't =

been sent due to lack of space.

(Similarly, mptcp_pm_add_addr_signal() clears the pm.addr_signal bits, so =

I'm not sure why they are also cleared in this function. I'm either =

misunderstanding the use of the bits or something is buggy)

> 		WRITE_ONCE(msk->pm.addr_signal, add_addr);
> 	}
> }
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index a0e301ae56b0..34fddb1fcd1e 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -667,6 +667,7 @@ void mptcp_pm_add_addr_received(struct mptcp_sock *ms=
k,
> void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
> 			      struct mptcp_addr_info *addr);
> void mptcp_pm_add_addr_send_ack(struct mptcp_sock *msk);
> +void mptcp_pm_nl_add_addr_send_ack(struct mptcp_sock *msk);
> void mptcp_pm_rm_addr_received(struct mptcp_sock *msk,
> 			       const struct mptcp_rm_list *rm_list);
> void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup);
>

--
Mat Martineau
Intel
--===============6761542492419960538==--
