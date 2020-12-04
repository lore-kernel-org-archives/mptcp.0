Content-Type: multipart/mixed; boundary="===============3506698198676290891=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] mptcp: pm: simplify
 select_local_address()
Date: Thu, 03 Dec 2020 18:07:10 -0800
Message-ID: <4c9a8536-fbd-c3ca-7c7f-721a772655ae@linux.intel.com>
In-Reply-To: 41407581af582a6cb0d4e8a5e46c7af7d54b06d3.1607009691.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7038

--===============3506698198676290891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Dec 2020, Paolo Abeni wrote:

> There is no need to unconditionally acquire the join list
> lock, we can simply splice the join list into the subflow
> list and traverse only the latter.
>
> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
> ---
> net/mptcp/pm_netlink.c | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 5151cfcd6962..e34a0d57947d 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -135,7 +135,7 @@ select_local_address(const struct pm_nl_pernet *perne=
t,
> 	struct mptcp_pm_addr_entry *entry, *ret =3D NULL;
>
> 	rcu_read_lock();
> -	spin_lock_bh(&msk->join_list_lock);
> +	__mptcp_flush_join_list(msk);
> 	list_for_each_entry_rcu(entry, &pernet->local_addr_list, list) {
> 		if (!(entry->addr.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW))
> 			continue;
> @@ -144,13 +144,11 @@ select_local_address(const struct pm_nl_pernet *per=
net,
> 		 * pending join
> 		 */
> 		if (entry->addr.family =3D=3D ((struct sock *)msk)->sk_family &&
> -		    !lookup_subflow_by_saddr(&msk->conn_list, &entry->addr) &&
> -		    !lookup_subflow_by_saddr(&msk->join_list, &entry->addr)) {
> +		    !lookup_subflow_by_saddr(&msk->conn_list, &entry->addr)) {
> 			ret =3D entry;
> 			break;
> 		}
> 	}
> -	spin_unlock_bh(&msk->join_list_lock);
> 	rcu_read_unlock();
> 	return ret;
> }
> -- =

> 2.26.2

Thanks Paolo, looks good.

Reviewed-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>

--
Mat Martineau
Intel
--===============3506698198676290891==--
