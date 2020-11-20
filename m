Content-Type: multipart/mixed; boundary="===============3202196895884828582=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next 1/2] mptcp: drop
 rm_addr_signal flag
Date: Thu, 19 Nov 2020 17:12:20 -0800
Message-ID: <f7a6bc69-1a31-1011-f582-4ec6dde2b60@linux.intel.com>
In-Reply-To: a87f95bb18d451efb10a2ed82ac6f3178ea739af.1605781893.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6855

--===============3202196895884828582==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Nov 2020, Geliang Tang wrote:

> This patch reused add_addr_signal for the RM_ADDR announce signal, by
> defining a new add_addr status named MPTCP_RM_ADDR_SIGNAL. Then the flag
> rm_addr_signal in PM could be dropped.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/pm.c       | 22 +++++++++++++++++-----
> net/mptcp/protocol.h |  4 ++--
> 2 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index e63e14f4cf2a..cc424222894b 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -18,7 +18,12 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
> {
> 	u8 add_addr =3D READ_ONCE(msk->pm.add_addr_signal);
>
> -	pr_debug("msk=3D%p, local_id=3D%d", msk, addr->id);
> +	pr_debug("msk=3D%p, local_id=3D%d, add_addr=3D%d", msk, addr->id, add_a=
ddr);
> +
> +	if (add_addr) {
> +		pr_err("addr_signal error.");

Hi Geliang,

One minor thing, pr_err() indicates a more serious problem that a user =

might need to do something about. These seem like pr_warn() at most. There =

is only one pr_err() in the rest of the MPTCP code.


Mat


> +		return -EINVAL;
> +	}
>
> 	msk->pm.local =3D *addr;
> 	add_addr |=3D BIT(MPTCP_ADD_ADDR_SIGNAL);
> @@ -34,10 +39,18 @@ int mptcp_pm_announce_addr(struct mptcp_sock *msk,
>
> int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 local_id)
> {
> -	pr_debug("msk=3D%p, local_id=3D%d", msk, local_id);
> +	u8 rm_addr =3D READ_ONCE(msk->pm.add_addr_signal);
> +
> +	pr_debug("msk=3D%p, local_id=3D%d, rm_addr=3D%d", msk, local_id, rm_add=
r);
> +
> +	if (rm_addr) {
> +		pr_err("addr_signal error.");
> +		return -EINVAL;
> +	}
>
> 	msk->pm.rm_id =3D local_id;
> -	WRITE_ONCE(msk->pm.rm_addr_signal, true);
> +	rm_addr |=3D BIT(MPTCP_RM_ADDR_SIGNAL);
> +	WRITE_ONCE(msk->pm.add_addr_signal, rm_addr);
> 	return 0;
> }
>
> @@ -231,7 +244,7 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, =
unsigned int remaining,
> 		goto out_unlock;
>
> 	*rm_id =3D msk->pm.rm_id;
> -	WRITE_ONCE(msk->pm.rm_addr_signal, false);
> +	WRITE_ONCE(msk->pm.add_addr_signal, 0);
> 	ret =3D true;
>
> out_unlock:
> @@ -253,7 +266,6 @@ void mptcp_pm_data_init(struct mptcp_sock *msk)
> 	msk->pm.rm_id =3D 0;
> 	WRITE_ONCE(msk->pm.work_pending, false);
> 	WRITE_ONCE(msk->pm.add_addr_signal, 0);
> -	WRITE_ONCE(msk->pm.rm_addr_signal, false);
> 	WRITE_ONCE(msk->pm.accept_addr, false);
> 	WRITE_ONCE(msk->pm.accept_subflow, false);
> 	msk->pm.status =3D 0;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index d926deae8610..05c853e337a0 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -172,6 +172,7 @@ enum mptcp_add_addr_status {
> 	MPTCP_ADD_ADDR_ECHO,
> 	MPTCP_ADD_ADDR_IPV6,
> 	MPTCP_ADD_ADDR_PORT,
> +	MPTCP_RM_ADDR_SIGNAL,
> };
>
> struct mptcp_pm_data {
> @@ -182,7 +183,6 @@ struct mptcp_pm_data {
> 	spinlock_t	lock;		/*protects the whole PM data */
>
> 	u8		add_addr_signal;
> -	bool		rm_addr_signal;
> 	bool		server_side;
> 	bool		work_pending;
> 	bool		accept_addr;
> @@ -564,7 +564,7 @@ static inline bool mptcp_pm_should_add_signal_port(st=
ruct mptcp_sock *msk)
>
> static inline bool mptcp_pm_should_rm_signal(struct mptcp_sock *msk)
> {
> -	return READ_ONCE(msk->pm.rm_addr_signal);
> +	return READ_ONCE(msk->pm.add_addr_signal) & BIT(MPTCP_RM_ADDR_SIGNAL);
> }
>
> static inline unsigned int mptcp_add_addr_len(int family, bool echo, bool=
 port)
> -- =

> 2.26.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============3202196895884828582==--
