Content-Type: multipart/mixed; boundary="===============0823760691694175796=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][RFC PATCH mptcp-next 4/6] mptcp: send out MP_PRIO
 before RM_ADDR
Date: Mon, 09 Nov 2020 18:07:36 -0800
Message-ID: <c6ec21d-63b4-bfb0-97d6-ccbe17c33fab@linux.intel.com>
In-Reply-To: 6af87960a4afd05da94429626d240c266c6bab23.1604572610.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6624

--===============0823760691694175796==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Nov 2020, Geliang Tang wrote:

> Before sending the RM_ADDR suboption, we also send the MP_PRIO suboption
> to change the related subflow's priority as backup. So here invoke
> mptcp_pm_mp_prio_send_ack from mptcp_pm_remove_anno_addr to send the
> MP_PRIO suboption and check whether the subflow's backup value is changed.
>

Geliang,

I also think this patch is not needed. The part of RFC 8684 that mentions =

using the backup flag before a close is assuming a much longer period of =

time between the ACK that changes priority and the REMOVE_ADDR. It will be =

up to the path manager to coordinate the timing on that.


Thanks,

Mat


> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/pm_netlink.c | 2 ++
> 1 file changed, 2 insertions(+)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index a243017c4892..f80ebd4f6a29 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -491,6 +491,7 @@ void mptcp_pm_nl_rm_addr_received(struct mptcp_sock *=
msk)
> 		if (msk->pm.rm_id !=3D subflow->remote_id)
> 			continue;
>
> +		WARN_ON_ONCE(!subflow->backup);
> 		spin_unlock_bh(&msk->pm.lock);
> 		mptcp_subflow_shutdown(sk, ssk, how);
> 		__mptcp_close_ssk(sk, ssk, subflow);
> @@ -830,6 +831,7 @@ static bool mptcp_pm_remove_anno_addr(struct mptcp_so=
ck *msk,
> 	ret =3D remove_anno_list_by_saddr(msk, addr);
> 	if (ret || force) {
> 		spin_lock_bh(&msk->pm.lock);
> +		mptcp_pm_mp_prio_send_ack(msk, addr, 1);
> 		mptcp_pm_remove_addr(msk, addr->id);
> 		spin_unlock_bh(&msk->pm.lock);
> 	}
> -- =

> 2.26.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============0823760691694175796==--
