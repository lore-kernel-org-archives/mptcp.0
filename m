Content-Type: multipart/mixed; boundary="===============7850078500648875255=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next] Squash to "mptcp: add
 rm_list_tx in mptcp_pm_data"
Date: Tue, 16 Feb 2021 17:57:14 -0800
Message-ID: <59205b74-e198-abc-b857-8938e9d3953@linux.intel.com>
In-Reply-To: 8557847ae1d94d4b4cb4067407253011925c46f7.1613397714.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7818

--===============7850078500648875255==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Feb 2021, Geliang Tang wrote:

> Fix the length of RM_ADDR suboption in mptcp_pm_rm_addr_signal.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/pm.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 32f203f186a2..8e97f90cbdec 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -260,7 +260,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk,=
 unsigned int remaining,
> bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk, unsigned int remaini=
ng,
> 			     struct mptcp_rm_list *rm_list)
> {
> -	int ret =3D false;
> +	int ret =3D false, len;
>
> 	spin_lock_bh(&msk->pm.lock);
>
> @@ -268,7 +268,10 @@ bool mptcp_pm_rm_addr_signal(struct mptcp_sock *msk,=
 unsigned int remaining,
> 	if (!mptcp_pm_should_rm_signal(msk))
> 		goto out_unlock;
>
> -	if (remaining < TCPOLEN_MPTCP_RM_ADDR_BASE)

Thanks for catching that.

> +	len =3D mptcp_rm_addr_len(msk->pm.rm_list_tx);
> +	if (len < 0)
> +		goto out_unlock;

Should this also clear msk->pm.addr_signal in this error case? Otherwise =

the bad rm_list will be stuck forever. We shouldn't really run in to this =

error path since it's our code setting rm_list_tx.

> +	if (remaining < len)
> 		goto out_unlock;
>
> 	*rm_list =3D msk->pm.rm_list_tx;
> -- =

> 2.29.2

--
Mat Martineau
Intel
--===============7850078500648875255==--
