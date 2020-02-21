Content-Type: multipart/mixed; boundary="===============7564187765255740488=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v3 5/9] Squash-to: "mptcp: Implement path manager
 interface commands"
Date: Fri, 21 Feb 2020 19:24:48 +0100
Message-ID: <83b0f2c7-ffb7-69d9-1d25-2af434175d6a@tessares.net>
In-Reply-To: bc5e217ca53ebee92cacecf42167bcce64069601.1582303591.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3739

--===============7564187765255740488==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 21/02/2020 17:48, Paolo Abeni wrote:
> Implement stubs for PM events delegating the action to the work
> queue. This allows acquiring whatever lock is needed to perform
> the actual implementation.
> =

> Try to avoid scheduling the worker if no action is needed/possible.
> I relies on the accounting info included into the PM struct and
> on great deal of double-checked locking [anti-]pattern.
> =

> v1  -> v2:
>   - fix several issues in mptcp_pm_addr_signal()
> =

> RFC -> v1:
>   - simplify/cleanup mptcp_pm_work_pending() - Mat
>   - likewise simplify/cleanup mptcp_pm_add_addr()
> =

> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
>   net/mptcp/pm.c | 223 +++++++++++++++++++------------------------------
>   1 file changed, 86 insertions(+), 137 deletions(-)
> =

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 30bce85adda1..d6e60b4bdb56 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -209,7 +130,24 @@ void mptcp_pm_add_addr(struct mptcp_sock *msk,
>   bool mptcp_pm_addr_signal(struct mptcp_sock *msk, unsigned int remainin=
g,
>   			  struct mptcp_addr_info *saddr)
>   {
> -	return false;
> +	int ret =3D false;
> +
> +	spin_lock_bh(&msk->pm.lock);
> +
> +	/* double check after the lock is acquired */
> +	if (!mptcp_pm_should_signal(msk))
> +		goto out_unlock;
> +
> +	if (remaining < mptcp_add_addr_len(msk->pm.local.family))
> +		goto out_unlock;
> +
> +	*saddr =3D msk->pm.local;
> +	WRITE_ONCE(msk->pm.addr_signal, false);
> +	ret =3D true;
> +
> +out_unlock:
> +	spin_unlock_bh(&msk->pm.lock);
> +	return ret;
>   }

I would still need to digest this new code (and look at the next =

patches) but if a PM has to announce more than one ADD_ADDR, would it be =

notified when the first one has been sent? To know when it can call =

mptcp_pm_announce_addr() again.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7564187765255740488==--
