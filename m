Content-Type: multipart/mixed; boundary="===============2194224675193556012=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v6 mptcp-next 1/9] mptcp: create the
 listening socket for new port
Date: Wed, 25 Nov 2020 10:15:46 +0100
Message-ID: <873036d6d8e44f56e9062f7320dac1fa150811b7.camel@redhat.com>
In-Reply-To: 74db8aa5673425f6c9cba9a1be138485b8eaa1c0.1606272852.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 6920

--===============2194224675193556012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-11-25 at 11:01 +0800, Geliang Tang wrote:
> This patch created a listening socket when a address with a port number
> is added by PM netlink. Then binded the new port to the socket, and
> listened for the connection.
> =

> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
>  net/mptcp/pm_netlink.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  net/mptcp/protocol.h   |  2 ++
>  net/mptcp/subflow.c    |  4 ++--
>  3 files changed, 45 insertions(+), 2 deletions(-)
> =

> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 2560c502356b..0d9a3c77fdf1 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -26,6 +26,7 @@ struct mptcp_pm_addr_entry {
>  	struct list_head	list;
>  	struct mptcp_addr_info	addr;
>  	struct rcu_head		rcu;
> +	struct socket		*lsk;
>  };
>  =

>  struct mptcp_pm_add_entry {
> @@ -732,6 +733,43 @@ static struct pm_nl_pernet *genl_info_pm_nl(struct g=
enl_info *info)
>  	return net_generic(genl_info_net(info), pm_nl_pernet_id);
>  }
>  =

> +static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
> +					    struct mptcp_pm_addr_entry *entry)
> +{
> +	struct sockaddr_storage addr;
> +	int backlog =3D 20;
> +	int err;
> +
> +	err =3D sock_create_kern(sock_net(sk), entry->addr.family,
> +			       SOCK_STREAM, IPPROTO_TCP,
> +			       &entry->lsk);
> +	if (err)
> +		return err;
> +
> +	SOCK_INODE(entry->lsk)->i_uid =3D GLOBAL_ROOT_UID;
> +	SOCK_INODE(entry->lsk)->i_gid =3D GLOBAL_ROOT_GID;
> +
> +	mptcp_info2sockaddr(&entry->addr, &addr);
> +	err =3D kernel_bind(entry->lsk, (struct sockaddr *)&addr,
> +			  sizeof(struct sockaddr_in));
> +	if (err) {
> +		pr_warn("kernel_bind error, err=3D%d", err);
> +		goto out;
> +	}
> +
> +	err =3D kernel_listen(entry->lsk, backlog);
> +	if (err) {
> +		pr_warn("kernel_listen error, err=3D%d", err);
> +		goto out;
> +	}
> +
> +	return 0;
> +
> +out:
> +	sock_release(entry->lsk);
> +	return err;
> +}
> +
>  static int mptcp_nl_cmd_add_addr(struct sk_buff *skb, struct genl_info *=
info)
>  {
>  	struct nlattr *attr =3D info->attrs[MPTCP_PM_ATTR_ADDR];
> @@ -757,6 +795,9 @@ static int mptcp_nl_cmd_add_addr(struct sk_buff *skb,=
 struct genl_info *info)
>  		return ret;
>  	}
>  =

> +	if (entry->addr.port)
> +		mptcp_pm_nl_create_listen_socket(skb->sk, entry);

This should be invoked before
calling mptcp_pm_nl_append_new_local_addr(), in case of
error mptcp_nl_cmd_add_addr() should fail and the error code should be
returned to the caller.

Moreover, if mptcp_pm_nl_append_new_local_addr() later fails, we should
dispose the listener socket, if present.

Also is likely better squash patch 3/9 here, so that after this patch
we don't leak the listener socket on endpoint deletion (for a couple of
patches only).

Cheers,

Paolo

--===============2194224675193556012==--
