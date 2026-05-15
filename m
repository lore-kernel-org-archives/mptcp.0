Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CE936998B
	for <mptcp@lists.linux.dev>; Fri, 15 May 2026 01:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778808465; cv=none; b=I8IdwXrl5TQqkIu4kQHd1QYNylD0m1/UiE1sGsVWw1GB9/kpi88+fzT7lK4pfGN/9DfYIopITNdwaq/cRZrIqiaswKRwkk4qxYJuFWNLCa9e4OGXKJZobV2o2qjhFcJsJVSQanHEMK285Ymhkdr5VcD5ErTsLlR+fmdyiXxAu4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778808465; c=relaxed/simple;
	bh=7Jleb3oSYFtP5IEm0o5q3PdThfQ1zTnOPOr8Lr1vp54=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=hSWZ0fXiLhkHwb2HwP5bm2tsNAEZ6mWMkNKiItMIHc15g/j8fMiyTGRw2bqtZoXkc1OKghS2do9Q7hEcytjokjQJPTNUc8Jz/uWSi5G9CmKYyMFqgpZZBi2QHuHuFBHUplNVm/YPLUmpYNO89vRD8u9Dt2HsC/v1xA52PtJWEa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UuwoznQI; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UuwoznQI"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778808460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5hswdRBso/yhEsbA+2nNwzx7OqiU//fF43T0WNfklwA=;
	b=UuwoznQIB3yB2bG9vgci4MxefuDZJSNbTEFx8h95DSqTKNI3tNlJ/+0cRQhFz6VTWp5qOt
	WoCxSfag2w2gzhzrOJzUiaulxXFYQ2iklrG6dWruTl0ErdAB84QU1jP2n0p1ID24p7ZT4f
	NWyJykVnq9eleTGod/tXWLjt84g6vDQ=
Date: Fri, 15 May 2026 01:27:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <cb257c5c1af85f1512a175730e832c7b8cc7ba14@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-net v4 1/2] mptcp: use sockopt_lock(release)_sock
 in sockopt
To: "MPTCP Linux" <mptcp@lists.linux.dev>
Cc: "Gang Yan" <yangang@kylinos.cn>
In-Reply-To: <20260509-sockopt_lock-v4-1-33f3a1c4d7a0@kylinos.cn>
References: <20260509-sockopt_lock-v4-0-33f3a1c4d7a0@kylinos.cn>
 <20260509-sockopt_lock-v4-1-33f3a1c4d7a0@kylinos.cn>
X-Migadu-Flow: FLOW_OUT

May 9, 2026 at 2:44 PM, "Gang Yan" <gang.yan@linux.dev mailto:gang.yan@li=
nux.dev?to=3D%22Gang%20Yan%22%20%3Cgang.yan%40linux.dev%3E > wrote:


>=20
>=20From: Gang Yan <yangang@kylinos.cn>
>=20
>=20TCP and the core socket layer all use sockopt_lock_sock()
> sockopt_release_sock() in their setsockopt and getsockopt handlers. It
> is a BPF-aware wrapper that skips lock acquisition when invoked from a
> BPF program, where the socket lock is already held.
>=20
>=20Using lock_sock_fast() on subflows requires extra care: the fast path
> holds the socket spinlock with BH disabled, creating an atomic context
> where sleeping is not allowed. Switching to lock_sock() avoids the
> risk of accidentally introducing sleeping operations inside the
> lock_sock_fast() critical section.
>=20
>=20Fixes: 24426654ed3a ("bpf: net: Avoid sk_setsockopt() taking sk lock =
when called from bpf")
> Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  net/mptcp/sockopt.c | 97 ++++++++++++++++++++++++++-------------------=
--------
>  1 file changed, 48 insertions(+), 49 deletions(-)
>=20
>=20diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 1cf608e7357b..57ffde0d0b87 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -72,12 +72,12 @@ static void mptcp_sol_socket_sync_intval(struct mpt=
cp_sock *msk, int optname, in
>  struct mptcp_subflow_context *subflow;
>  struct sock *sk =3D (struct sock *)msk;
>=20=20
>=20- lock_sock(sk);
> + sockopt_lock_sock(sk);
>  sockopt_seq_inc(msk);
>=20=20
>=20 mptcp_for_each_subflow(msk, subflow) {
>  struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> - bool slow =3D lock_sock_fast(ssk);

Hi, Maintainers:

Thanks for the review of sashiko. Let me address these two points.

First, I think this patch does not introduce issues for existing MPTCP co=
de.
Currently there is no scenario where a BPF program invokes the MPTCP
setsockopt/getsockopt handler =E2=80=94 BPF helpers (bpf_setsockopt) bypa=
ss the
protocol-specific handler via __bpf_setsockopt(), and the cgroup BPF sock=
opt
filter clears the BPF context before calling ops->setsockopt(). So
has_current_bpf_ctx() is always false when the MPTCP handler executes. Th=
e
commit's primary purpose, as stated in the commit message, is to replace
lock_sock_fast() with lock_sock() to avoid sleeping within the
lock_sock_fast() critical section.


The subflow locking concern is valid for future BPF support.

That said, the observation about the subflow locking gap is a valid desig=
n
concern. As sashiko pointed out, when the MPTCP setsockopt handler is
eventually called from BPF context, the MPTCP meta socket (msk) is alread=
y
locked externally, but the subflow sockets (ssk) are not. The internal
delegation via sk_setsockopt(ssk, ...) or tcp_setsockopt(ssk, ...) calls
sockopt_lock_sock(ssk) which skips the lock due to the per-thread
has_current_bpf_ctx() flag, leaving ssk unprotected.

However, solving this is not straightforward. In BPF context we don't hav=
e a
good way to call lock_sock() on the subflow =E2=80=94 as sashiko noted in=
 first point,
lock_sock() unconditionally calls might_sleep(), and will cause 'sleeping=
 in
atomic context' problems in BPF context. So properly locking the subflow =
in
BPF context remains an open question that needs to be addressed when MPTC=
P
BPF setsockopt support is actually introduced.

WDYT?

Thanks,
Gang

> + lock_sock(ssk);
>=20=20
>=20 switch (optname) {
>  case SO_DEBUG:
> @@ -114,10 +114,10 @@ static void mptcp_sol_socket_sync_intval(struct m=
ptcp_sock *msk, int optname, in
>  }
>=20=20
>=20 subflow->setsockopt_seq =3D msk->setsockopt_seq;
> - unlock_sock_fast(ssk, slow);
> + release_sock(ssk);
>  }
>=20=20
>=20- release_sock(sk);
> + sockopt_release_sock(sk);
>  }
>=20=20
>=20 static int mptcp_sol_socket_intval(struct mptcp_sock *msk, int optna=
me, int val)
> @@ -156,7 +156,7 @@ static int mptcp_setsockopt_sol_socket_tstamp(struc=
t mptcp_sock *msk, int optnam
>  if (ret)
>  return ret;
>=20=20
>=20- lock_sock(sk);
> + sockopt_lock_sock(sk);
>  mptcp_for_each_subflow(msk, subflow) {
>  struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
>=20=20
>=20@@ -165,7 +165,7 @@ static int mptcp_setsockopt_sol_socket_tstamp(str=
uct mptcp_sock *msk, int optnam
>  release_sock(ssk);
>  }
>=20=20
>=20- release_sock(sk);
> + sockopt_release_sock(sk);
>  return 0;
>  }
>=20=20
>=20@@ -231,7 +231,7 @@ static int mptcp_setsockopt_sol_socket_timestampi=
ng(struct mptcp_sock *msk,
>  if (ret)
>  return ret;
>=20=20
>=20- lock_sock(sk);
> + sockopt_lock_sock(sk);
>=20=20
>=20 mptcp_for_each_subflow(msk, subflow) {
>  struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> @@ -241,7 +241,7 @@ static int mptcp_setsockopt_sol_socket_timestamping=
(struct mptcp_sock *msk,
>  release_sock(ssk);
>  }
>=20=20
>=20- release_sock(sk);
> + sockopt_release_sock(sk);
>=20=20
>=20 return 0;
>  }
> @@ -266,11 +266,11 @@ static int mptcp_setsockopt_sol_socket_linger(str=
uct mptcp_sock *msk, sockptr_t
>  if (ret)
>  return ret;
>=20=20
>=20- lock_sock(sk);
> + sockopt_lock_sock(sk);
>  sockopt_seq_inc(msk);
>  mptcp_for_each_subflow(msk, subflow) {
>  struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> - bool slow =3D lock_sock_fast(ssk);
> + lock_sock(ssk);
>=20=20
>=20 if (!ling.l_onoff) {
>  sock_reset_flag(ssk, SOCK_LINGER);
> @@ -280,10 +280,10 @@ static int mptcp_setsockopt_sol_socket_linger(str=
uct mptcp_sock *msk, sockptr_t
>  }
>=20=20
>=20 subflow->setsockopt_seq =3D msk->setsockopt_seq;
> - unlock_sock_fast(ssk, slow);
> + release_sock(ssk);
>  }
>=20=20
>=20- release_sock(sk);
> + sockopt_release_sock(sk);
>  return 0;
>  }
>=20=20
>=20@@ -299,10 +299,10 @@ static int mptcp_setsockopt_sol_socket(struct m=
ptcp_sock *msk, int optname,
>  case SO_REUSEADDR:
>  case SO_BINDTODEVICE:
>  case SO_BINDTOIFINDEX:
> - lock_sock(sk);
> + sockopt_lock_sock(sk);
>  ssk =3D __mptcp_nmpc_sk(msk);
>  if (IS_ERR(ssk)) {
> - release_sock(sk);
> + sockopt_release_sock(sk);
>  return PTR_ERR(ssk);
>  }
>=20=20
>=20@@ -317,7 +317,7 @@ static int mptcp_setsockopt_sol_socket(struct mpt=
cp_sock *msk, int optname,
>  else if (optname =3D=3D SO_BINDTOIFINDEX)
>  sk->sk_bound_dev_if =3D ssk->sk_bound_dev_if;
>  }
> - release_sock(sk);
> + sockopt_release_sock(sk);
>  return ret;
>  case SO_KEEPALIVE:
>  case SO_PRIORITY:
> @@ -395,16 +395,16 @@ static int mptcp_setsockopt_v6(struct mptcp_sock =
*msk, int optname,
>  case IPV6_V6ONLY:
>  case IPV6_TRANSPARENT:
>  case IPV6_FREEBIND:
> - lock_sock(sk);
> + sockopt_lock_sock(sk);
>  ssk =3D __mptcp_nmpc_sk(msk);
>  if (IS_ERR(ssk)) {
> - release_sock(sk);
> + sockopt_release_sock(sk);
>  return PTR_ERR(ssk);
>  }
>=20=20
>=20 ret =3D tcp_setsockopt(ssk, SOL_IPV6, optname, optval, optlen);
>  if (ret !=3D 0) {
> - release_sock(sk);
> + sockopt_release_sock(sk);
>  return ret;
>  }
>=20=20
>=20@@ -424,7 +424,7 @@ static int mptcp_setsockopt_v6(struct mptcp_sock =
*msk, int optname,
>  break;
>  }
>=20=20
>=20- release_sock(sk);
> + sockopt_release_sock(sk);
>  break;
>  }
>=20=20
>=20@@ -601,7 +601,7 @@ static int mptcp_setsockopt_sol_tcp_congestion(st=
ruct mptcp_sock *msk, sockptr_t
>  cap_net_admin =3D ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN);
>=20=20
>=20 ret =3D 0;
> - lock_sock(sk);
> + sockopt_lock_sock(sk);
>  sockopt_seq_inc(msk);
>  mptcp_for_each_subflow(msk, subflow) {
>  struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> @@ -618,7 +618,7 @@ static int mptcp_setsockopt_sol_tcp_congestion(stru=
ct mptcp_sock *msk, sockptr_t
>  if (ret =3D=3D 0)
>  strscpy(msk->ca_name, name, sizeof(msk->ca_name));
>=20=20
>=20- release_sock(sk);
> + sockopt_release_sock(sk);
>  return ret;
>  }
>=20=20
>=20@@ -697,11 +697,11 @@ static int mptcp_setsockopt_sol_ip_set(struct m=
ptcp_sock *msk, int optname,
>  if (err !=3D 0)
>  return err;
>=20=20
>=20- lock_sock(sk);
> + sockopt_lock_sock(sk);
>=20=20
>=20 ssk =3D __mptcp_nmpc_sk(msk);
>  if (IS_ERR(ssk)) {
> - release_sock(sk);
> + sockopt_release_sock(sk);
>  return PTR_ERR(ssk);
>  }
>=20=20
>=20@@ -722,13 +722,13 @@ static int mptcp_setsockopt_sol_ip_set(struct m=
ptcp_sock *msk, int optname,
>  READ_ONCE(inet_sk(sk)->local_port_range));
>  break;
>  default:
> - release_sock(sk);
> + sockopt_release_sock(sk);
>  WARN_ON_ONCE(1);
>  return -EOPNOTSUPP;
>  }
>=20=20
>=20 sockopt_seq_inc(msk);
> - release_sock(sk);
> + sockopt_release_sock(sk);
>  return 0;
>  }
>=20=20
>=20@@ -744,18 +744,17 @@ static int mptcp_setsockopt_v4_set_tos(struct m=
ptcp_sock *msk, int optname,
>  if (err !=3D 0)
>  return err;
>=20=20
>=20- lock_sock(sk);
> + sockopt_lock_sock(sk);
>  sockopt_seq_inc(msk);
>  val =3D READ_ONCE(inet_sk(sk)->tos);
>  mptcp_for_each_subflow(msk, subflow) {
>  struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> - bool slow;
>=20=20
>=20- slow =3D lock_sock_fast(ssk);
> + lock_sock(ssk);
>  __ip_sock_set_tos(ssk, val);
> - unlock_sock_fast(ssk, slow);
> + release_sock(ssk);
>  }
> - release_sock(sk);
> + sockopt_release_sock(sk);
>=20=20
>=20 return 0;
>  }
> @@ -784,7 +783,7 @@ static int mptcp_setsockopt_first_sf_only(struct mp=
tcp_sock *msk, int level, int
>  int ret;
>=20=20
>=20 /* Limit to first subflow, before the connection establishment */
> - lock_sock(sk);
> + sockopt_lock_sock(sk);
>  ssk =3D __mptcp_nmpc_sk(msk);
>  if (IS_ERR(ssk)) {
>  ret =3D PTR_ERR(ssk);
> @@ -794,7 +793,7 @@ static int mptcp_setsockopt_first_sf_only(struct mp=
tcp_sock *msk, int level, int
>  ret =3D tcp_setsockopt(ssk, level, optname, optval, optlen);
>=20=20
>=20 unlock:
> - release_sock(sk);
> + sockopt_release_sock(sk);
>  return ret;
>  }
>=20=20
>=20@@ -846,7 +845,7 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_=
sock *msk, int optname,
>  if (ret)
>  return ret;
>=20=20
>=20- lock_sock(sk);
> + sockopt_lock_sock(sk);
>  switch (optname) {
>  case TCP_INQ:
>  if (val < 0 || val > 1)
> @@ -889,7 +888,7 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_so=
ck *msk, int optname,
>  ret =3D -ENOPROTOOPT;
>  }
>=20=20
>=20- release_sock(sk);
> + sockopt_release_sock(sk);
>  return ret;
>  }
>=20=20
>=20@@ -913,9 +912,9 @@ int mptcp_setsockopt(struct sock *sk, int level, =
int optname,
>  * is in TCP fallback, when TCP socket options are passed through
>  * to the one remaining subflow.
>  */
> - lock_sock(sk);
> + sockopt_lock_sock(sk);
>  ssk =3D __mptcp_tcp_fallback(msk);
> - release_sock(sk);
> + sockopt_release_sock(sk);
>  if (ssk)
>  return tcp_setsockopt(ssk, level, optname, optval, optlen);
>=20=20
>=20@@ -938,7 +937,7 @@ static int mptcp_getsockopt_first_sf_only(struct =
mptcp_sock *msk, int level, int
>  struct sock *ssk;
>  int ret;
>=20=20
>=20- lock_sock(sk);
> + sockopt_lock_sock(sk);
>  ssk =3D msk->first;
>  if (ssk)
>  goto get;
> @@ -953,7 +952,7 @@ static int mptcp_getsockopt_first_sf_only(struct mp=
tcp_sock *msk, int level, int
>  ret =3D tcp_getsockopt(ssk, level, optname, optval, optlen);
>=20=20
>=20 out:
> - release_sock(sk);
> + sockopt_release_sock(sk);
>  return ret;
>  }
>=20=20
>=20@@ -1124,7 +1123,7 @@ static int mptcp_getsockopt_tcpinfo(struct mptc=
p_sock *msk, char __user *optval,
>=20=20
>=20 infoptr =3D optval + sfd.size_subflow_data;
>=20=20
>=20- lock_sock(sk);
> + sockopt_lock_sock(sk);
>=20=20
>=20 mptcp_for_each_subflow(msk, subflow) {
>  struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> @@ -1137,7 +1136,7 @@ static int mptcp_getsockopt_tcpinfo(struct mptcp_=
sock *msk, char __user *optval,
>  tcp_get_info(ssk, &info);
>=20=20
>=20 if (copy_to_user(infoptr, &info, sfd.size_user)) {
> - release_sock(sk);
> + sockopt_release_sock(sk);
>  return -EFAULT;
>  }
>=20=20
>=20@@ -1147,7 +1146,7 @@ static int mptcp_getsockopt_tcpinfo(struct mptc=
p_sock *msk, char __user *optval,
>  }
>  }
>=20=20
>=20- release_sock(sk);
> + sockopt_release_sock(sk);
>=20=20
>=20 sfd.num_subflows =3D sfcount;
>=20=20
>=20@@ -1216,7 +1215,7 @@ static int mptcp_getsockopt_subflow_addrs(struc=
t mptcp_sock *msk, char __user *o
>=20=20
>=20 addrptr =3D optval + sfd.size_subflow_data;
>=20=20
>=20- lock_sock(sk);
> + sockopt_lock_sock(sk);
>=20=20
>=20 mptcp_for_each_subflow(msk, subflow) {
>  struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> @@ -1229,7 +1228,7 @@ static int mptcp_getsockopt_subflow_addrs(struct =
mptcp_sock *msk, char __user *o
>  mptcp_get_sub_addrs(ssk, &a);
>=20=20
>=20 if (copy_to_user(addrptr, &a, sfd.size_user)) {
> - release_sock(sk);
> + sockopt_release_sock(sk);
>  return -EFAULT;
>  }
>=20=20
>=20@@ -1239,7 +1238,7 @@ static int mptcp_getsockopt_subflow_addrs(struc=
t mptcp_sock *msk, char __user *o
>  }
>  }
>=20=20
>=20- release_sock(sk);
> + sockopt_release_sock(sk);
>=20=20
>=20 sfd.num_subflows =3D sfcount;
>=20=20
>=20@@ -1325,7 +1324,7 @@ static int mptcp_getsockopt_full_info(struct mp=
tcp_sock *msk, char __user *optva
>  sizeof(struct mptcp_subflow_info));
>  tcpinfoptr =3D u64_to_user_ptr(mfi.tcp_info);
>=20=20
>=20- lock_sock(sk);
> + sockopt_lock_sock(sk);
>  mptcp_for_each_subflow(msk, subflow) {
>  struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
>  struct mptcp_subflow_info sfinfo;
> @@ -1355,7 +1354,7 @@ static int mptcp_getsockopt_full_info(struct mptc=
p_sock *msk, char __user *optva
>  tcpinfoptr +=3D mfi.size_tcpinfo_user;
>  sfinfoptr +=3D mfi.size_sfinfo_user;
>  }
> - release_sock(sk);
> + sockopt_release_sock(sk);
>=20=20
>=20 mfi.num_subflows =3D sfcount;
>  if (mptcp_put_full_info(&mfi, optval, copylen, optlen))
> @@ -1364,7 +1363,7 @@ static int mptcp_getsockopt_full_info(struct mptc=
p_sock *msk, char __user *optva
>  return 0;
>=20=20
>=20 fail_release:
> - release_sock(sk);
> + sockopt_release_sock(sk);
>  return -EFAULT;
>  }
>=20=20
>=20@@ -1519,9 +1518,9 @@ int mptcp_getsockopt(struct sock *sk, int level=
, int optname,
>  * is in TCP fallback, when socket options are passed through
>  * to the one remaining subflow.
>  */
> - lock_sock(sk);
> + sockopt_lock_sock(sk);
>  ssk =3D __mptcp_tcp_fallback(msk);
> - release_sock(sk);
> + sockopt_release_sock(sk);
>  if (ssk)
>  return tcp_getsockopt(ssk, level, optname, optval, option);
>=20=20
>=20
> --=20
>=202.43.0
>
