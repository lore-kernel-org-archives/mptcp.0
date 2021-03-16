Content-Type: multipart/mixed; boundary="===============7283203346147415746=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v2 mptcp-next] Squash to "mptcp: remove id
 0 address"
Date: Tue, 16 Mar 2021 15:23:30 -0700
Message-ID: <912874c9-605-a63e-24b7-55d6fbc85b90@linux.intel.com>
In-Reply-To: be80ad2d5230a0e414a263c871172a4c5b3eaf50.1615871767.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 8174

--===============7283203346147415746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Mar 2021, Geliang Tang wrote:

> Hold msk->pm.lock when invoking mptcp_pm_remove_addr.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> v2:
> - use mptcp_pm_nl_rm_subflow_received instead of
>   mptcp_pm_remove_subflow.

Thanks Geliang! v2 looks good to squash.

Mat


> ---
> net/mptcp/pm_netlink.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index c73b7cfc7ae9..f9606934104d 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1185,8 +1185,10 @@ static int mptcp_nl_remove_id_zero_address(struct =
net *net,
> 			goto next;
>
> 		lock_sock(sk);
> +		spin_lock_bh(&msk->pm.lock);
> 		mptcp_pm_remove_addr(msk, &list);
> -		mptcp_pm_remove_subflow(msk, &list);
> +		mptcp_pm_nl_rm_subflow_received(msk, &list);
> +		spin_unlock_bh(&msk->pm.lock);
> 		release_sock(sk);
>
> next:
> -- =

> 2.30.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============7283203346147415746==--
