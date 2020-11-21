Content-Type: multipart/mixed; boundary="===============4364491666451082770=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next 4/5] mptcp: add the mibs for
 MP_PRIO
Date: Fri, 20 Nov 2020 17:19:52 -0800
Message-ID: <2fa7b62a-fe25-4fa4-1ef3-d2838da9a5f2@linux.intel.com>
In-Reply-To: 7d895c955dbde5094f6bfc18b17779a75baa5861.1605855783.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6889

--===============4364491666451082770==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Nov 2020, Geliang Tang wrote:

> This patch added the mibs for MP_PRIO, MPTCP_MIB_MPPRIOTX for transmitting
> of the MP_PRIO suboption, and MPTCP_MIB_MPPRIORX for receiving of it.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/mib.c        | 2 ++
> net/mptcp/mib.h        | 2 ++
> net/mptcp/options.c    | 1 +
> net/mptcp/pm_netlink.c | 1 +
> 4 files changed, 6 insertions(+)
>
> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index 5e8f7827cfe0..49fb978aeb7e 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -35,6 +35,8 @@ static const struct snmp_mib mptcp_snmp_list[] =3D {
> 	SNMP_MIB_ITEM("PortAckRx", MPTCP_MIB_PORTACKRX),
> 	SNMP_MIB_ITEM("RmAddr", MPTCP_MIB_RMADDR),
> 	SNMP_MIB_ITEM("RmSubflow", MPTCP_MIB_RMSUBFLOW),
> +	SNMP_MIB_ITEM("MPPrioTx", MPTCP_MIB_MPPRIOTX),

Thanks for adding the Tx MIB. Patch looks good to me.

> +	SNMP_MIB_ITEM("MPPrioRx", MPTCP_MIB_MPPRIORX),
> 	SNMP_MIB_SENTINEL
> };
>
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index b762941d492f..e023d8435d18 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -28,6 +28,8 @@ enum linux_mptcp_mib_field {
> 	MPTCP_MIB_PORTACKRX,		/* Received an ACK + MP_JOIN with port */
> 	MPTCP_MIB_RMADDR,		/* Received RM_ADDR */
> 	MPTCP_MIB_RMSUBFLOW,		/* Remove a subflow */
> +	MPTCP_MIB_MPPRIOTX,		/* Transmit a MP_PRIO */
> +	MPTCP_MIB_MPPRIORX,		/* Received a MP_PRIO */
> 	__MPTCP_MIB_MAX
> };
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index b1cb43c76be8..3171b620cab1 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1011,6 +1011,7 @@ void mptcp_incoming_options(struct sock *sk, struct=
 sk_buff *skb)
>
> 	if (mp_opt.mp_prio) {
> 		mptcp_pm_mp_prio_received(sk, mp_opt.backup);
> +		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIORX);
> 		mp_opt.mp_prio =3D 0;
> 	}
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 58960e1cdc32..90943138da7e 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -545,6 +545,7 @@ void mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *=
msk,
>
> 		subflow->send_mp_prio =3D 1;
> 		subflow->request_bkup =3D bkup;
> +		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIOTX);
>
> 		spin_unlock_bh(&msk->pm.lock);
> 		pr_debug("send ack for mp_prio");
> -- =

> 2.26.2

--
Mat Martineau
Intel
--===============4364491666451082770==--
