Received: from mta0.migadu.com (out-66.mta0.migadu.com [91.218.175.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB4F4B04B5
	for <mptcp@lists.linux.dev>; Tue, 18 Aug 2026 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046506; cv=none; b=syg0RMGHqFVmwUACsNJ7jKpRzolB815adbW44mCG0fO1xHmby+1DhmxhRX3gntRAGjvwq23iI28E2qvhKnq9ntrKaFTId077ocZzhdfAlUHxu7H4ZdEsL2Ulw/lACv5WFOTkIvmMxBb8blt5KKWNg3srQoQ0GjhQQjxWApa5UgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046506; c=relaxed/simple;
	bh=CMr8Z09iuvdkbiX8WDKm7a3XtEH6UId/ExnNFxGrpvc=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:
	 In-Reply-To:References; b=gqy2QPvN4EG6RCTjc3Dcwa26PHayL2c5BIfdIS1g+XhAD2W6YOeqZ2kJxBvRGWZWehYUWEuFeon36k8xyQJKek02CBBZvuzHWYwz3QflVvuubWSkIyyAOzMcYXMDaBXw7SJ/SZ/jTOPc66QsBAwioHOjeHqKZOf661o5Mei+bIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JP0bdOGS; arc=none smtp.client-ip=91.218.175.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JP0bdOGS"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=CMr8Z09iuvdkbiX8WDKm7a3XtEH6UId/ExnNFxGrpvc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787046501; v=1; x=1787651301;
 b=JP0bdOGSsNG0LZO9qejtFpcLfM6xAAq9O31bxVy7VAyQmrRjXp78k7m67Y56ZjjhVmRFgSds
 QwI0VJgvgTnk1JqL64sI1+wJIGaSZbhoyriLPXkL2cXY9j5ZrMpkyL20YMPAQpt0SEhb3UX36JM
 Nlgm1DLkKUCGPJBjwvDRqT3M=
X-Envelope-To: mptcp@lists.linux.dev
Received: from webmail.migadu.com (2001:41d0:303:fc7a::)
	by smtp.migadu.com with ESMTPS id 30827e18144386cf;
	Tue, 18 Aug 2026 09:48:21 +0000
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Tue, 18 Aug 2026 09:48:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <e86b907f0b0eb389f2e6628a1184fb8e19078c9c@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next v2 2/5] mptcp: pm: change path_manager sysctl
 atomically
To: mptcp@lists.linux.dev
In-Reply-To: <20260818093910.47559-3-gang.yan@linux.dev>
References: <20260818093910.47559-1-gang.yan@linux.dev>
 <20260818093910.47559-3-gang.yan@linux.dev>

August 18, 2026 at 5:39 PM, "Gang Yan" <gang.yan@linux.dev mailto:gang.ya=
n@linux.dev?to=3D%22Gang%20Yan%22%20%3Cgang.yan%40linux.dev%3E > wrote:


Hi

Sorry for that. It seems that the rest of this series is not sent success=
fully
due to the bad network. I'll resend it.

Please ignore this noise.

Thanks
Gang

>=20
>=20From: Gang Yan <yangang@kylinos.cn>
>=20
>=20The per-netns path manager name is stored as an inline char[] buffer =
and
> updated via strscpy() from the sysctl handler; a concurrent reader can
> observe a half-written name (and KCSAN flags the race), which READ_ONCE=
()
> cannot fix for a multi-byte string.
>=20
>=20Following the tcp_congestion_control() model (and the scheduler chang=
e in
> the previous patch), store a pointer to the immutable struct mptcp_pm_o=
ps
> instead of the name string:
>  - mptcp_set_path_manager() looks the ops up and atomically swaps the
>  pernet pointer with xchg();
>  - mptcp_get_path_manager() copies the ops name out under rcu_read_lock=
();
>  - the default ops is assigned in mptcp_pernet_set_defaults().
>=20
>=20Assisted-by: Claude:GLM5.2
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/626
> Co-developed-by: Tao Cui <cuitao@kylinos.cn>
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  net/mptcp/ctrl.c | 28 ++++++++++++++++++----------
>  net/mptcp/pm.c | 3 ++-
>  net/mptcp/protocol.h | 3 +--
>  3 files changed, 21 insertions(+), 13 deletions(-)
>=20
>=20diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index 479b31eb3007..c0481b09c1a1 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -40,7 +40,7 @@ struct mptcp_pernet {
>  u8 pm_type;
>  u8 add_addr_v6_port_drop_ts;
>  struct mptcp_sched_ops __rcu *scheduler;
> - char path_manager[MPTCP_PM_NAME_MAX];
> + struct mptcp_pm_ops __rcu *path_manager;
>  };
>=20=20
>=20 static struct mptcp_pernet *mptcp_get_pernet(const struct net *net)
> @@ -85,9 +85,14 @@ int mptcp_get_pm_type(const struct net *net)
>  return mptcp_get_pernet(net)->pm_type;
>  }
>=20=20
>=20-const char *mptcp_get_path_manager(const struct net *net)
> +void mptcp_get_path_manager(const struct net *net, char *name)
>  {
> - return mptcp_get_pernet(net)->path_manager;
> + struct mptcp_pm_ops *pm_ops;
> +
> + rcu_read_lock();
> + pm_ops =3D rcu_dereference(mptcp_get_pernet(net)->path_manager);
> + strscpy(name, pm_ops ? pm_ops->name : "kernel", MPTCP_PM_NAME_MAX);
> + rcu_read_unlock();
>  }
>=20=20
>=20 void mptcp_get_scheduler(const struct net *net, char *name)
> @@ -119,8 +124,8 @@ static void mptcp_pernet_set_defaults(struct mptcp_=
pernet *pernet)
>  pernet->pm_type =3D MPTCP_PM_TYPE_KERNEL;
>=20=20
>=20 RCU_INIT_POINTER(pernet->scheduler, &mptcp_sched_default);
> + RCU_INIT_POINTER(pernet->path_manager, &mptcp_pm_kernel);
>=20=20
>=20- strscpy(pernet->path_manager, "kernel", sizeof(pernet->path_manager=
));
>  pernet->add_addr_v6_port_drop_ts =3D 1;
>  }
>=20=20
>=20@@ -201,7 +206,7 @@ static int proc_blackhole_detect_timeout(const st=
ruct ctl_table *table,
>  return ret;
>  }
>=20=20
>=20-static int mptcp_set_path_manager(char *path_manager, const char *na=
me)
> +static int mptcp_set_path_manager(struct mptcp_pernet *pernet, const c=
har *name)
>  {
>  struct mptcp_pm_ops *pm_ops;
>  int ret =3D 0;
> @@ -209,7 +214,7 @@ static int mptcp_set_path_manager(char *path_manage=
r, const char *name)
>  rcu_read_lock();
>  pm_ops =3D mptcp_pm_find(name);
>  if (pm_ops)
> - strscpy(path_manager, name, MPTCP_PM_NAME_MAX);
> + xchg(&pernet->path_manager, pm_ops);
>  else
>  ret =3D -ENOENT;
>  rcu_read_unlock();
> @@ -223,7 +228,7 @@ static int proc_path_manager(const struct ctl_table=
 *ctl, int write,
>  struct mptcp_pernet *pernet =3D container_of(ctl->data,
>  struct mptcp_pernet,
>  path_manager);
> - char (*path_manager)[MPTCP_PM_NAME_MAX] =3D ctl->data;
> + struct mptcp_pm_ops *pm_ops;
>  char pm_name[MPTCP_PM_NAME_MAX];
>  const struct ctl_table tbl =3D {
>  .data =3D pm_name,
> @@ -231,11 +236,14 @@ static int proc_path_manager(const struct ctl_tab=
le *ctl, int write,
>  };
>  int ret;
>=20=20
>=20- strscpy(pm_name, *path_manager, MPTCP_PM_NAME_MAX);
> + rcu_read_lock();
> + pm_ops =3D rcu_dereference(pernet->path_manager);
> + strscpy(pm_name, pm_ops ? pm_ops->name : "kernel", MPTCP_PM_NAME_MAX)=
;
> + rcu_read_unlock();
>=20=20
>=20 ret =3D proc_dostring(&tbl, write, buffer, lenp, ppos);
>  if (write && ret =3D=3D 0) {
> - ret =3D mptcp_set_path_manager(*path_manager, pm_name);
> + ret =3D mptcp_set_path_manager(pernet, pm_name);
>  if (ret =3D=3D 0) {
>  u8 pm_type =3D __MPTCP_PM_TYPE_NR;
>=20=20
>=20@@ -267,7 +275,7 @@ static int proc_pm_type(const struct ctl_table *c=
tl, int write,
>  pm_name =3D "kernel";
>  else if (pm_type =3D=3D MPTCP_PM_TYPE_USERSPACE)
>  pm_name =3D "userspace";
> - mptcp_set_path_manager(pernet->path_manager, pm_name);
> + mptcp_set_path_manager(pernet, pm_name);
>  }
>=20=20
>=20 return ret;
> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index ba7c6f80a183..09f99bcd827c 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -1204,7 +1204,7 @@ void mptcp_pm_destroy(struct mptcp_sock *msk)
>  void mptcp_pm_data_reset(struct mptcp_sock *msk)
>  {
>  const struct net *net =3D sock_net((struct sock *)msk);
> - const char *pm_name =3D mptcp_get_path_manager(net);
> + char pm_name[MPTCP_PM_NAME_MAX];
>  u8 pm_type =3D mptcp_get_pm_type(net);
>  struct mptcp_pm_data *pm =3D &msk->pm;
>=20=20
>=20@@ -1213,6 +1213,7 @@ void mptcp_pm_data_reset(struct mptcp_sock *msk=
)
>  pm->rm_list_rx.nr =3D 0;
>  WRITE_ONCE(pm->pm_type, pm_type);
>=20=20
>=20+ mptcp_get_path_manager(net, pm_name);
>  rcu_read_lock();
>  mptcp_pm_ops_init(msk, pm_name);
>  rcu_read_unlock();
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index af79b3450ab7..99f447f2808f 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -802,7 +802,7 @@ int mptcp_allow_join_id0(const struct net *net);
>  unsigned int mptcp_stale_loss_cnt(const struct net *net);
>  unsigned int mptcp_close_timeout(const struct sock *sk);
>  int mptcp_get_pm_type(const struct net *net);
> -const char *mptcp_get_path_manager(const struct net *net);
> +void mptcp_get_path_manager(const struct net *net, char *name);
>  void mptcp_get_scheduler(const struct net *net, char *name);
>  unsigned int mptcp_add_addr_v6_port_drop_ts(const struct net *net);
>=20=20
>=20@@ -1153,7 +1153,6 @@ int mptcp_pm_announce_addr(struct mptcp_sock *m=
sk,
>  bool echo);
>  int mptcp_pm_remove_addr(struct mptcp_sock *msk, const struct mptcp_rm=
_list *rm_list);
>=20=20
>=20-/* the default path manager, used in mptcp_pm_unregister */
>  extern struct mptcp_pm_ops mptcp_pm_kernel;
>  extern struct mptcp_sched_ops mptcp_sched_default;
>=20=20
>=20--=20
>=202.43.0
>
