Content-Type: multipart/mixed; boundary="===============3658526162582609820=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: set correct vfs info for subflows
Date: Mon, 04 May 2020 18:19:24 -0700
Message-ID: <alpine.OSX.2.22.394.2005041813440.23858@nelizabe-mobl.amr.corp.intel.com>
In-Reply-To: 2d848b43d0e52e6e2ecda5c878293ff3f12a5e23.1588609997.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4310

--===============3658526162582609820==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 4 May 2020, Paolo Abeni wrote:

> When a subflow is created via mptcp_subflow_create_socket(),
> a new 'struct socket' is allocated, with a new i_ino value.
>
> When inspecting TCP sockets via the procfs and or the diag
> interface, the above ones are not related to the process owning
> the MPTCP master socket, even if they are a logical part of it
> ('ss' shows an empty process field)
>
> Additionally, subflows created by the path manager get
> the uid/gid from the running workqueue.
>
> Subflows are part of the owning MPTCP master socket, let's
> adjust the vfs info to reflect this.
>
> After this patch, 'ss' correctly displays subflows as belonging
> to the msk socket creator.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>

Seems like better information for userspace. Does this make sense for =

-net, since the uid/gid info is not useful otherwise? Or is it benign =

enough behavior to fix in net-next?


> ---
> net/mptcp/subflow.c | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 67a4e35d4838..86ade8f09f4a 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1012,6 +1012,16 @@ int mptcp_subflow_create_socket(struct sock *sk, s=
truct socket **new_sock)
> 	if (err)
> 		return err;
>
> +	/* the newly created socket really belong to the owing MPTCP master

Minor fix: "belongs to the owning"

> +	 * socket, even if for additional subflows the allocation is performed
> +	 * by a kernel workqueue. Adjust inode references, so that the
> +	 * procfs/diag interaces really show this one belonging to the correct
> +	 * user.
> +	 */
> +	SOCK_INODE(sf)->i_ino =3D SOCK_INODE(sk->sk_socket)->i_ino;
> +	SOCK_INODE(sf)->i_uid =3D SOCK_INODE(sk->sk_socket)->i_uid;
> +	SOCK_INODE(sf)->i_gid =3D SOCK_INODE(sk->sk_socket)->i_gid;
> +
> 	subflow =3D mptcp_subflow_ctx(sf->sk);
> 	pr_debug("subflow=3D%p", subflow);
>
> -- =

> 2.21.1

--
Mat Martineau
Intel
--===============3658526162582609820==--
