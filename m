Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7F52D9EDC
	for <mptcp@lists.linux.dev>; Wed, 27 May 2026 05:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779860609; cv=none; b=Ogo4K3dS9H9AY5s8ZqlQZuiuj9gt4BbNLuw7W7/mlaCWWdiDLDEwICO5M+HCPpixwoMm2YhecnsLuJDJOc8ppajr/WEap7HRGYjDOc/P0FoCNeYMuu/4m4jtbpivb+WwiBJVuQsG/iG/dfn+WkReZXXQ6ESTWG/5/8isDHAweqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779860609; c=relaxed/simple;
	bh=4YI+ag22hljjFbKLtfYWXqawehFZ7Xqobw1r2j9VKUM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=a/xVQdfbJFsLLARIXNVkPkzDtXFQQqcJE5t6DeZwh4Qw33ZeuS6AbpYBaJQAjER2GXLjGs4jgUF/+auiafDH717bQp0COTc4lnrEjtZyO04mjNduyVpccXVc3nNhKHF4frLI4cButuWSQiA2Skyfp3E2S3ej8e+NPTaO4uoEHDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AJURJNvJ; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AJURJNvJ"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779860603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=74o9dph1JxeFIoey1IqLXXqao0NJRvpn5S/F/Zpq6/M=;
	b=AJURJNvJE/EEsOhLrSVz0tx8zCoysZulxtn4buTx3c7DfhUfCpBmDKDNrOM5RW+O6HMa5B
	qu5UEedg7zNoIWP3KklWnaHDNey5ROrb0dXze7/8nC8K8QHOcwaRKU9urw0A+QApzhmc01
	cG0Vtf95mHMB2QP2X2aDHinHlCaLIOc=
Date: Wed, 27 May 2026 05:43:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: gang.yan@linux.dev
Message-ID: <311f0492cc7283f6888451425cdb25fdfeca5185@linux.dev>
TLS-Required: No
Subject: Re: [PATCH mptcp-next v5 1/6] mptcp: replace lock_sock_fast with
 lock_sock in sockopt
To: "MPTCP Linux" <mptcp@lists.linux.dev>
Cc: "Gang Yan" <yangang@kylinos.cn>, pabeni@redhat.com, matttbe@kernel.org
In-Reply-To: <20260522-sockopt_lock-v5-1-108629a46e98@kylinos.cn>
References: <20260522-sockopt_lock-v5-0-108629a46e98@kylinos.cn>
 <20260522-sockopt_lock-v5-1-108629a46e98@kylinos.cn>
X-Migadu-Flow: FLOW_OUT

May 22, 2026 at 5:12 PM, "Gang Yan" <gang.yan@linux.dev mailto:gang.yan@l=
inux.dev?to=3D%22Gang%20Yan%22%20%3Cgang.yan%40linux.dev%3E > wrote:

Hi Matt, Paolo:

I have a question about this patch.

My plan is to take patches 2~6 as a new series that focuses on fixing
MPTCP setsockopt issues under BPF context in the next version.

This patch 1 is separate =E2=80=94 it addresses a potential sleeping-in-a=
tomic
problem in the normal (non-BPF) setsockopt call path, similar to=20
b5c52908d5("mptcp:=20fix scheduling with atomic in timestamp sockopt").

Could you please take a look and let me know if this patch is needed?

If it is, I'd appreciate it if you could review it separately and
potentially apply it directly, or I can spin a new version based on
your feedback.

If it's not required, I'll just drop it.

Thanks,
Gang=20
>=20
> From: Gang Yan <yangang@kylinos.cn>
>=20
>=20Replace lock_sock_fast()/unlock_sock_fast() with lock_sock()/
> release_sock() in the MPTCP sockopt handlers to avoid accidentally
> introducing sleeping operations inside the lock_sock_fast() critical
> section.
>=20
>=20This is consistent with how other sockopt handlers in the Net code
> already use lock_sock()/release_sock().
>=20
>=20Signed-off-by: Gang Yan <yangang@kylinos.cn>
> ---
>  net/mptcp/sockopt.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>=20
>=20diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index 1cf608e7357b..35a74e44a500 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -77,8 +77,8 @@ static void mptcp_sol_socket_sync_intval(struct mptcp=
_sock *msk, int optname, in
>=20=20
>=20 mptcp_for_each_subflow(msk, subflow) {
>  struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> - bool slow =3D lock_sock_fast(ssk);
>=20=20
>=20+ lock_sock(ssk);
>  switch (optname) {
>  case SO_DEBUG:
>  sock_valbool_flag(ssk, SOCK_DBG, !!val);
> @@ -114,7 +114,7 @@ static void mptcp_sol_socket_sync_intval(struct mpt=
cp_sock *msk, int optname, in
>  }
>=20=20
>=20 subflow->setsockopt_seq =3D msk->setsockopt_seq;
> - unlock_sock_fast(ssk, slow);
> + release_sock(ssk);
>  }
>=20=20
>=20 release_sock(sk);
> @@ -270,8 +270,8 @@ static int mptcp_setsockopt_sol_socket_linger(struc=
t mptcp_sock *msk, sockptr_t
>  sockopt_seq_inc(msk);
>  mptcp_for_each_subflow(msk, subflow) {
>  struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> - bool slow =3D lock_sock_fast(ssk);
>=20=20
>=20+ lock_sock(ssk);
>  if (!ling.l_onoff) {
>  sock_reset_flag(ssk, SOCK_LINGER);
>  } else {
> @@ -280,7 +280,7 @@ static int mptcp_setsockopt_sol_socket_linger(struc=
t mptcp_sock *msk, sockptr_t
>  }
>=20=20
>=20 subflow->setsockopt_seq =3D msk->setsockopt_seq;
> - unlock_sock_fast(ssk, slow);
> + release_sock(ssk);
>  }
>=20=20
>=20 release_sock(sk);
> @@ -749,11 +749,10 @@ static int mptcp_setsockopt_v4_set_tos(struct mpt=
cp_sock *msk, int optname,
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
>  release_sock(sk);
>=20=20
>=20@@ -1647,12 +1646,11 @@ int mptcp_set_rcvlowat(struct sock *sk, int v=
al)
>  WRITE_ONCE(sk->sk_rcvbuf, space);
>  mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
>  struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> - bool slow;
>=20=20
>=20- slow =3D lock_sock_fast(ssk);
> + lock_sock(ssk);
>  WRITE_ONCE(ssk->sk_rcvbuf, space);
>  WRITE_ONCE(tcp_sk(ssk)->window_clamp, val);
> - unlock_sock_fast(ssk, slow);
> + release_sock(ssk);
>  }
>  return 0;
>  }
>=20
>=20--=20
>=202.43.0
>
