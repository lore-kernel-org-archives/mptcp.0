Received: from mta1.migadu.com (out-101.mta1.migadu.com [95.215.58.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00C833BBAF
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 03:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786679468; cv=none; b=ShSGxJt8mVS1iy504ky8xF9ndnhw4aFlbLiqfC0TezHhWe3jolUlgSqON9CutAlrLRF9gfo/PLqUGmxa44W0cvonQF0XK9ez/b3DjdLNzTv2YcvyPZGeKo8M0qdYdI3Y4XoDt8ypi2xhLmoIIhMcLM78F4wJRIr6wHAisTqcsqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786679468; c=relaxed/simple;
	bh=lrTMD3ztqu1OpFwjut6Owyk047sziI1g6/07GogzfqQ=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=qhu5Li+QhWB+64QBxdU/DqHszjf8Tmaww8rn9RZpC0zazsyWFL9SOUpO8Ty5CJq8lSkg9JmfgRkoDeCtiXWtbo8tVrf+amnFOCnPxxqFppDS9/CilAwrxhUgG6ADbVZOFeNXUllxnCKheHse6L9DBCHHoTSop9mfMfNm1v0wJpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X53HvdkQ; arc=none smtp.client-ip=95.215.58.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X53HvdkQ"
X-Envelope-To: mptcp@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=lrTMD3ztqu1OpFwjut6Owyk047sziI1g6/07GogzfqQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786679464; v=1; x=1787284264;
 b=X53HvdkQFSvNBviSAsBgHS6BPX1yHXE7yLyUCg7nhLXL+GeSTkbHTI/1Y+9IUu5ITaS5HUsS
 2gEhCU5fl36odvUSXk+rhEp9Y8CpxSfCQm5Tk9BEAdFaaMyrdO1LJCujH1ZOFpB5iwJKy1Vnc2G
 15jFfLuX2/4nefCpNfMXTBl8=
X-Envelope-To: mptcp@lists.linux.dev
Received: from webmail.migadu.com (2001:41d0:303:fc7a::)
	by mta12.migadu.com with ESMTPS id 0e672baa8805be4a;
	Fri, 14 Aug 2026 03:51:04 +0000
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Fri, 14 Aug 2026 03:51:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: gang.yan@linux.dev
Message-ID: <44897d3c50a4ce9db11d52c19382a2c9f648a62c@linux.dev>
TLS-Required: No
Subject: Re: [RFC PATCH mptcp-next] mptcp: annotate data-races around sysctl
 reads
To: "Tao Cui" <cui.tao@linux.dev>, mptcp@lists.linux.dev
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, "Tao Cui"
 <cuitao@kylinos.cn>
In-Reply-To: <20260814032749.2222975-1-cui.tao@linux.dev>
References: <20260814032749.2222975-1-cui.tao@linux.dev>

August 14, 2026 at 11:27 AM, "Tao Cui" <cui.tao@linux.dev mailto:cui.tao@=
linux.dev?to=3D%22Tao%20Cui%22%20%3Ccui.tao%40linux.dev%3E > wrote:

Hi, Tao

Thanks for your patch, but it has been submitted by Matt before in [1].

I think Matt wanted change the PM and sched sysctl from string to atomica=
lly,
that may need another patches (READ_ONCE is not enough), right? If no, yo=
u can
wait for the other maintainers' reply.

If yes, I still think this patch should keep author as matt, the rest of
others can be yours.

Note: Some patches about sched is only in our export branch, not mainline=
d,
so it's better to do your work based on it.

[1] https://patchwork.kernel.org/project/mptcp/patch/20260601-mptcp-add-a=
ddr6-port-ts-fixes-v2-v1-4-d7c842e80446@kernel.org/

Thanks
Gang

>=20
>=20From: Tao Cui <cuitao@kylinos.cn>
>=20
>=20#626 plans a READ_ONCE-over-sysctls series for the string sysctls; th=
is
> is the numeric side. Asking whether to send it on its own or fold it in=
.
>=20
>=20The per-netns MPTCP sysctl values (net.mptcp.enabled, add_addr_timeou=
t,
> checksum_enabled, allow_join_initial_addr_port, stale_loss_cnt,
> close_timeout, pm_type) are written from the sysctl handlers and read
> without locking through the ctrl.c accessors.
>=20
>=20Add READ_ONCE() on the readers and WRITE_ONCE() on the pm_type store =
in
> proc_path_manager(), matching what is already done for other mptcp
> fields (fully_established, local_id, remote_id, sysctl_tcp_wmem[0]).
>=20
>=20The string sysctls (path_manager, scheduler) are not covered: they ne=
ed
> atomic replacement, see the tracker below.
>=20
>=20KCSAN reproduces the race on net.mptcp.enabled, and the READ_ONCE mak=
es
> it go away:
>=20
>=20 BUG: KCSAN: data-race in mptcp_is_enabled / proc_dou8vec_minmax
>=20
>=20 write to 0xffff8f93c18553e9 of 1 bytes by task 214 on cpu 1:
>  proc_dou8vec_minmax+0x1b1/0x200
>  proc_sys_call_handler+0x268/0x350
>  vfs_write+0x423/0x710
>=20
>=20 read to 0xffff8f93c18553e9 of 1 bytes by task 72 on cpu 0:
>  mptcp_is_enabled+0x50/0x60
>  mptcp_init_sock+0x2a/0x1c0
>  inet_create+0x3f9/0x5a0
>=20
>=20 value changed: 0x00 -> 0x01
>=20
>=20No functional change.
>=20
>=20Link: https://github.com/multipath-tcp/mptcp_net-next/issues/626
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  net/mptcp/ctrl.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
>=20diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
> index 63c5747f0f63..b0ef6aea4eba 100644
> --- a/net/mptcp/ctrl.c
> +++ b/net/mptcp/ctrl.c
> @@ -50,39 +50,39 @@ static struct mptcp_pernet *mptcp_get_pernet(const =
struct net *net)
>=20
>=20 int mptcp_is_enabled(const struct net *net)
>  {
> - return mptcp_get_pernet(net)->mptcp_enabled;
> + return READ_ONCE(mptcp_get_pernet(net)->mptcp_enabled);
>  }
>=20
>=20 unsigned int mptcp_get_add_addr_timeout(const struct net *net)
>  {
> - return mptcp_get_pernet(net)->add_addr_timeout;
> + return READ_ONCE(mptcp_get_pernet(net)->add_addr_timeout);
>  }
>=20
>=20 int mptcp_is_checksum_enabled(const struct net *net)
>  {
> - return mptcp_get_pernet(net)->checksum_enabled;
> + return READ_ONCE(mptcp_get_pernet(net)->checksum_enabled);
>  }
>=20
>=20 int mptcp_allow_join_id0(const struct net *net)
>  {
> - return mptcp_get_pernet(net)->allow_join_initial_addr_port;
> + return READ_ONCE(mptcp_get_pernet(net)->allow_join_initial_addr_port)=
;
>  }
>=20
>=20 unsigned int mptcp_stale_loss_cnt(const struct net *net)
>  {
> - return mptcp_get_pernet(net)->stale_loss_cnt;
> + return READ_ONCE(mptcp_get_pernet(net)->stale_loss_cnt);
>  }
>=20
>=20 unsigned int mptcp_close_timeout(const struct sock *sk)
>  {
>  if (sock_flag(sk, SOCK_DEAD))
>  return TCP_TIMEWAIT_LEN;
> - return mptcp_get_pernet(sock_net(sk))->close_timeout;
> + return READ_ONCE(mptcp_get_pernet(sock_net(sk))->close_timeout);
>  }
>=20
>=20 int mptcp_get_pm_type(const struct net *net)
>  {
> - return mptcp_get_pernet(net)->pm_type;
> + return READ_ONCE(mptcp_get_pernet(net)->pm_type);
>  }
>=20
>=20 const char *mptcp_get_path_manager(const struct net *net)
> @@ -230,7 +230,7 @@ static int proc_path_manager(const struct ctl_table=
 *ctl, int write,
>  pm_type =3D MPTCP_PM_TYPE_KERNEL;
>  else if (strncmp(pm_name, "userspace", MPTCP_PM_NAME_MAX) =3D=3D 0)
>  pm_type =3D MPTCP_PM_TYPE_USERSPACE;
> - pernet->pm_type =3D pm_type;
> + WRITE_ONCE(pernet->pm_type, pm_type);
>  }
>  }
>=20
>=20--
> 2.43.0
>
