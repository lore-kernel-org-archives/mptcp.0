Content-Type: multipart/mixed; boundary="===============8481471699229781239=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next] mptcp: drop unused subflow in
 mptcp_pm_subflow_established
Date: Tue, 16 Feb 2021 17:30:29 -0800
Message-ID: <286c3ada-7c8f-c322-9267-e6d1d870afef@linux.intel.com>
In-Reply-To: 0c4e5341b9f9e8bbd38c3b882284f58babf786b8.1613183930.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7815

--===============8481471699229781239==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Feb 2021, Geliang Tang wrote:

> This patch drops the unused parameter subflow in
> mptcp_pm_subflow_established().
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/options.c  | 2 +-
> net/mptcp/pm.c       | 3 +--
> net/mptcp/protocol.h | 3 +--
> 3 files changed, 3 insertions(+), 5 deletions(-)

Change looks good to me, thanks for the cleanup.


Mat


>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index ea4cacff0f5f..95d67e2eefeb 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -877,7 +877,7 @@ static bool check_fully_established(struct mptcp_sock=
 *msk, struct sock *ssk,
> 	subflow->pm_notified =3D 1;
> 	if (subflow->mp_join) {
> 		clear_3rdack_retransmission(ssk);
> -		mptcp_pm_subflow_established(msk, subflow);
> +		mptcp_pm_subflow_established(msk);
> 	} else {
> 		mptcp_pm_fully_established(msk, ssk, GFP_ATOMIC);
> 	}
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 880c9cffe707..a15ce9704fda 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -152,8 +152,7 @@ void mptcp_pm_connection_closed(struct mptcp_sock *ms=
k)
> 	pr_debug("msk=3D%p", msk);
> }
>
> -void mptcp_pm_subflow_established(struct mptcp_sock *msk,
> -				  struct mptcp_subflow_context *subflow)
> +void mptcp_pm_subflow_established(struct mptcp_sock *msk)
> {
> 	struct mptcp_pm_data *pm =3D &msk->pm;
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 593085610971..d24e2829b0cb 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -642,8 +642,7 @@ void mptcp_pm_new_connection(struct mptcp_sock *msk, =
const struct sock *ssk, int
> void mptcp_pm_fully_established(struct mptcp_sock *msk, const struct sock=
 *ssk, gfp_t gfp);
> bool mptcp_pm_allow_new_subflow(struct mptcp_sock *msk);
> void mptcp_pm_connection_closed(struct mptcp_sock *msk);
> -void mptcp_pm_subflow_established(struct mptcp_sock *msk,
> -				  struct mptcp_subflow_context *subflow);
> +void mptcp_pm_subflow_established(struct mptcp_sock *msk);
> void mptcp_pm_subflow_closed(struct mptcp_sock *msk, u8 id);
> void mptcp_pm_add_addr_received(struct mptcp_sock *msk,
> 				const struct mptcp_addr_info *addr);
> -- =

> 2.29.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============8481471699229781239==--
