Content-Type: multipart/mixed; boundary="===============5185014790814089920=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 2/9] Squash-to: "mptcp: Add path manager
 interface"
Date: Fri, 21 Feb 2020 18:59:31 +0100
Message-ID: <3eabe4a7-75b8-ec1f-a40c-46459de40160@tessares.net>
In-Reply-To: b8758e0d5d7b8c8955171d59b0d1b5e5712ce726.1582303591.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3738

--===============5185014790814089920==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

Thank you for looking at that!

On 21/02/2020 17:48, Paolo Abeni wrote:
> Factor out PM addr info to simplify PM data definition and
> simplify the PM hooks/APIs.
> =

> The PM will carry a single local and remote addrs - the one
> currently being processed, if any. It's up to the PM impl,
> e.g. netlink, maintain additional per msk data, if needed.
> =

> Account the number of created subflow and received addresses,
> to enforce limits.
> =

> Add a spinlock to protect PM datas, so that we can manipulate
> them from subflow BH.
> =

> Delegate events handling to a workqueue, so that PM events can
> be processed with both the above spinlock and the msk socket
> lock held. The PM impl should hook inside the worker.
> =

> v1 -> v2:
>   - be sure to initialize the address port before calling
>     mptcp_pm_add_addr()
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>   net/mptcp/options.c  |  46 ++++++++++--------
>   net/mptcp/pm.c       | 112 ++++++++++++++-----------------------------
>   net/mptcp/protocol.c |   2 +
>   net/mptcp/protocol.h |  98 ++++++++++++++++++++++---------------
>   4 files changed, 123 insertions(+), 135 deletions(-)
> =

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index c9f508451f2e..08f00f251838 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -8,38 +8,22 @@

[...]

> +void mptcp_pm_data_init(struct mptcp_sock *msk)
> +{
> +	msk->pm.add_addr_signaled =3D 0;
> +	msk->pm.add_addr_accepted =3D 0;
> +	msk->pm.local_addr_used =3D 0;
> +	WRITE_ONCE(msk->pm.work_pending, false);
> +	WRITE_ONCE(msk->pm.addr_signal, false);
> +	WRITE_ONCE(msk->pm.fully_established, false);
> +	WRITE_ONCE(msk->pm.accept_addr, false);
> +	msk->pm.status =3D MPTCP_PM_IDLE;
Just by curiosity, why do we need to reset those fields to 0? Is this =

msk not already init to 0? Can we not memset the whole pm part?

>   =

> -	return 0;
> +	spin_lock_init(&msk->pm.lock);
> +	INIT_WORK(&msk->pm.work, pm_worker);
>   }

[...]

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 1d658d9aac36..7e43a2a09a68 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h

[...]

> -int mptcp_pm_addr_signal(struct mptcp_sock *msk, u8 *id,
> -			 struct sockaddr_storage *saddr);
> -int mptcp_pm_get_local_id(struct request_sock *req, struct sock *sk,
> -			  const struct sk_buff *skb);
> +bool mptcp_pm_addr_signal(struct mptcp_sock *msk, unsigned int remaining,
> +			  struct mptcp_addr_info *saddr);
> +int mptcp_pm_get_local_id(struct mptcp_sock *msk, struct sock_common *sk=
c);

I guess I will see that in another patch but why "struct sock_common" =

instead of "struc sock"?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5185014790814089920==--
