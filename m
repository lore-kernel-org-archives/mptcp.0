Content-Type: multipart/mixed; boundary="===============5879323858456011536=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v8 mptcp-next 3/8] mptcp: add port number
 announced check
Date: Thu, 17 Dec 2020 16:32:34 -0800
Message-ID: <f4b78529-2b7a-772b-34cf-e81b8cbc65a9@linux.intel.com>
In-Reply-To: ad003dcc2d3ff4bd85cb911cdc482e1aea193498.1607823272.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7212

--===============5879323858456011536==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sun, 13 Dec 2020, Geliang Tang wrote:

> When we received the MP_JOIN's SYN/ACK, we do the port number checks. If
> the subflow's source port number is different, we use a new helper
> mptcp_pm_sport_in_anno_list to check whether this port number is announce=
d.
> If it isn't, we need to abort this connection.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/pm_netlink.c | 23 ++++++++++++++++++++++-
> net/mptcp/protocol.h   |  1 +
> net/mptcp/subflow.c    | 10 ++++++++++
> 3 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 1548efb22a1b..221bf997dcf4 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -92,8 +92,8 @@ static bool address_zero(const struct mptcp_addr_info *=
addr)
> static void local_address(const struct sock_common *skc,
> 			  struct mptcp_addr_info *addr)
> {
> -	addr->port =3D 0;
> 	addr->family =3D skc->skc_family;
> +	addr->port =3D htons(skc->skc_num);
> 	if (addr->family =3D=3D AF_INET)
> 		addr->addr.s_addr =3D skc->skc_rcv_saddr;
> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> @@ -204,6 +204,27 @@ lookup_anno_list_by_saddr(struct mptcp_sock *msk,
> 	return NULL;
> }
>
> +bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct so=
ck *sk)
> +{
> +	struct mptcp_pm_add_entry *entry;
> +	struct mptcp_addr_info saddr;
> +	bool ret =3D false;
> +
> +	local_address((struct sock_common *)sk, &saddr);
> +
> +	spin_lock_bh(&msk->pm.lock);
> +	list_for_each_entry(entry, &msk->pm.anno_list, list) {
> +		if (addresses_equal(&entry->addr, &saddr, true)) {
> +			ret =3D true;
> +			goto out;
> +		}
> +	}
> +
> +out:
> +	spin_unlock_bh(&msk->pm.lock);
> +	return ret;
> +}
> +
> static void mptcp_pm_add_timer(struct timer_list *timer)
> {
> 	struct mptcp_pm_add_entry *entry =3D from_timer(entry, timer, add_timer);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index a2a031cca97a..d700ee1a05bb 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -565,6 +565,7 @@ int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *m=
sk,
> 				 struct mptcp_addr_info *addr,
> 				 u8 bkup);
> void mptcp_pm_free_anno_list(struct mptcp_sock *msk);
> +bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct so=
ck *sk);
> struct mptcp_pm_add_entry *
> mptcp_pm_del_add_timer(struct mptcp_sock *msk,
> 		       struct mptcp_addr_info *addr);
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 398554590bf1..01d192c1acf7 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -193,6 +193,14 @@ static int subflow_init_req(struct request_sock *req,
> 			pr_debug("syn inet_sport=3D%d %d",
> 				 ntohs(inet_sk(sk_listener)->inet_sport),
> 				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
> +			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
> +				sock_put((struct sock *)subflow_req->msk);
> +				mptcp_token_destroy_request(req);
> +				tcp_request_sock_ops.destructor(req);
> +				subflow_req->msk =3D NULL;
> +				subflow_req->mp_join =3D 0;
> +				return -EPERM;
> +			}
> 		}

Since this adds a new error path where squbflow_req->local_nonce and =

subflow_req->thmac are not needed, could you create a separate helper =

function to initialize those and call it here? Those are more expensive to =

populate.

>
> 		if (unlikely(req->syncookie)) {
> @@ -680,6 +688,8 @@ static struct sock *subflow_syn_recv_sock(const struc=
t sock *sk,
> 				pr_debug("ack inet_sport=3D%d %d",
> 					 ntohs(inet_sk(sk)->inet_sport),
> 					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
> +				if (!mptcp_pm_sport_in_anno_list(owner, sk))
> +					goto out;
> 			}
> 		}
> 	}
> -- =

> 2.29.2

--
Mat Martineau
Intel
--===============5879323858456011536==--
