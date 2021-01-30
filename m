Content-Type: multipart/mixed; boundary="===============0213649946307689324=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH mptcp-next 7/8] mptcp: update the netlink
 event for rm_addr
Date: Fri, 29 Jan 2021 17:39:38 -0800
Message-ID: <135874a-e891-4199-7987-49863dc5dce@linux.intel.com>
In-Reply-To: 51b2607d102fec3b1e8edcfef464307e86726e06.1611914854.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7539

--===============0213649946307689324==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 29 Jan 2021, Geliang Tang wrote:

> Since the parameter id passed to mptcp_event_addr_removed was changed as
> a u64 number, the netlink event for removing addresses needed to be
> updated.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> include/uapi/linux/mptcp.h | 1 +
> net/mptcp/pm_netlink.c     | 4 ++--
> net/mptcp/protocol.h       | 2 +-
> 3 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index c91578aaab32..227e8edb4a28 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -172,6 +172,7 @@ enum mptcp_event_attr {
> 	MPTCP_ATTR_FLAGS,	/* u16 */
> 	MPTCP_ATTR_TIMEOUT,	/* u32 */
> 	MPTCP_ATTR_IF_IDX,	/* s32 */
> +	MPTCP_ATTR_PAD,
>
> 	__MPTCP_ATTR_AFTER_LAST
> };
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 3801931ab9ea..bc473ea4fcc2 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -1705,7 +1705,7 @@ static int mptcp_event_created(struct sk_buff *skb,
> 	return mptcp_event_add_subflow(skb, ssk);
> }
>
> -void mptcp_event_addr_removed(const struct mptcp_sock *msk, uint8_t id)
> +void mptcp_event_addr_removed(const struct mptcp_sock *msk, uint64_t ids)
> {
> 	struct net *net =3D sock_net((const struct sock *)msk);
> 	struct nlmsghdr *nlh;
> @@ -1725,7 +1725,7 @@ void mptcp_event_addr_removed(const struct mptcp_so=
ck *msk, uint8_t id)
> 	if (nla_put_u32(skb, MPTCP_ATTR_TOKEN, msk->token))
> 		goto nla_put_failure;
>
> -	if (nla_put_u8(skb, MPTCP_ATTR_REM_ID, id))
> +	if (nla_put_u64_64bit(skb, MPTCP_ATTR_REM_ID, ids, MPTCP_ATTR_PAD))

This kind of change to an existing userspace API isn't allowed. To have an =

event with a list of remote IDs, you would have to add a new event. But I =

think instead mptcp_event_addr_removed() could send multiple REM_ID =

events, without any change to the userspace API.

> 		goto nla_put_failure;
>
> 	genlmsg_end(skb, nlh);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 9dd276cb1f71..af1d70843791 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -674,7 +674,7 @@ int mptcp_pm_remove_subflow(struct mptcp_sock *msk, u=
64 local_ids);
> void mptcp_event(enum mptcp_event_type type, const struct mptcp_sock *msk,
> 		 const struct sock *ssk, gfp_t gfp);
> void mptcp_event_addr_announced(const struct mptcp_sock *msk, const struc=
t mptcp_addr_info *info);
> -void mptcp_event_addr_removed(const struct mptcp_sock *msk, u8 id);
> +void mptcp_event_addr_removed(const struct mptcp_sock *msk, u64 ids);
>
> static inline bool mptcp_pm_should_add_signal(struct mptcp_sock *msk)
> {
> -- =

> 2.29.2

--
Mat Martineau
Intel
--===============0213649946307689324==--
