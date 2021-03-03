Content-Type: multipart/mixed; boundary="===============2672453957620164797=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v3 mptcp-next 2/3] mptcp: check the
 removing initial subflow
Date: Tue, 02 Mar 2021 17:44:15 -0800
Message-ID: <483ee3c5-c9be-1391-5574-cc8ba928c294@linux.intel.com>
In-Reply-To: e496b266e0b5c7e559cced0802c7112583e53b29.1614672171.git.geliangtang@gmail.com
X-Status: 
X-Keywords:                  
X-UID: 7982

--===============2672453957620164797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Mar 2021, Geliang Tang wrote:

> If the removing address id is 0, the initial subflow needs to be removed.
> Since the initial subflow's both local_id and remote_id are all zeros,
> this patch checks them to make sure it's now removing the right subflow.
>
> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
> ---
> net/mptcp/pm_netlink.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index eaac9824f444..439c9ee57566 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -629,6 +629,11 @@ static void mptcp_pm_nl_rm_addr_or_subflow(struct mp=
tcp_sock *msk,
> 			if (rm_list.ids[i] !=3D id)
> 				continue;
>
> +			if (!rm_list.ids[i]) {
> +				if (subflow->local_id || subflow->remote_id)
> +					continue;
> +			}
> +

In my reply to v2, I commented that I did not see the initial subflow =

closed. But that does not mean that RM_ADDR 0 should only affect the =

initial subflow. There may be other subflows involving that address id =

that need to be closed.

Without this commit, do some self tests fail only because all of the =

subflows got closed?  <--- (I am interested in the answer to this and =

having a discussion before making more code changes)

If peer A sends RM_ADDR 0 and all of the subflows are using local_id 0 on =

peer A's side, then it seems like it is expected that all of the subflows w=
ill =

close. We would want to test RM_ADDR 0 when there are subflows that will =

stay open because they do not use ID 0 on the side that is sending =

RM_ADDR. Is this what is going on with the tests or is there a different =

issue that is solved by the added code in this patch?

Thanks,

Mat


> 			pr_debug(" -> %s rm_list_ids[%d]=3D%u local_id=3D%u remote_id=3D%u",
> 				 type =3D=3D RM_ADDR ? "address" : "subflow", i, rm_list.ids[i],
> 				 subflow->local_id, subflow->remote_id);
> -- =

> 2.29.2
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============2672453957620164797==--
