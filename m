Content-Type: multipart/mixed; boundary="===============1863692196267135714=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v8 mptcp-next 3/8] mptcp: implementing
 mptcp_pm_remove_subflow
Date: Tue, 01 Sep 2020 18:08:15 +0200
Message-ID: <8598b4ae88711343ba9bf68d65b0491177d1ed3b.camel@redhat.com>
In-Reply-To: 28b149a285e6463b0aae95188c494d843a30b22e.1598267961.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 5684

--===============1863692196267135714==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-08-24 at 19:36 +0800, Geliang Tang wrote:
> Like mptcp_pm_rm_addr_received and the related functions, we implemented
> the remove subflow logic.
> =

> We use mptcp_pm_remove_subflow to remove a local subflow, so change it's
> argument from remote_id to local_id.
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  net/mptcp/pm.c       | 19 +++++++++++++++++--
>  net/mptcp/protocol.c |  4 ++++
>  net/mptcp/protocol.h |  4 +++-
>  3 files changed, 24 insertions(+), 3 deletions(-)
> =

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 57227ab816fd..5c6b087c68b8 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -31,9 +31,12 @@ int mptcp_pm_remove_addr(struct mptcp_sock *msk, u8 lo=
cal_id)
>  	return 0;
>  }
>  =

> -int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 remote_id)
> +int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u8 local_id)
>  {
> -	return -ENOTSUPP;
> +	pr_debug("%s msk=3D%p, local_id=3D%d", __func__, msk, local_id);
> +
> +	mptcp_pm_rm_subflow_received(msk, local_id);

Since here the caller can block and have already acquired the msk
socket lock, you could simply acquire the pm spin lock and call:

mptcp_pm_nl_rm_subflow_received();

No need for an additional work queue scheduling, I think.

Cheers,

Paolo

--===============1863692196267135714==--
