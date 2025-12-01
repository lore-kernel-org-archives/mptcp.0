Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383503064B1
	for <mptcp@lists.linux.dev>; Mon,  1 Dec 2025 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764587719; cv=none; b=lIjMLW6FesJC8haBGUjYwL/nW4NSpB1WB+AE2+5L3pvQdoZCTc+ZEDiuJpTHptrR3Rd/52llXiThKRL5b3Xsjyj7yU0pEUM+5+FtOQT1eGEwhd5XUTPp3sqc0vAA5RNgF0wR7mMH+jDUlYEqwhuLWXzsmLdV0F2mQogPRhp4QPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764587719; c=relaxed/simple;
	bh=35Ioes8F9NuIOJPlbXL2e4SFn/P/8Eaqe4nMlITnMdI=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=nlMz1orNvlsAdK8RLJPhWon0sA1twEut/HpU6u9NPg57ZRPSy3FEfH7SCiPGkfpepvBdfC6wSK2BUbLhyraSti8eF812o8oZlXwx8p6HwN955ZSYwCAvrLPSKnEmZAhlszpUuXuRuSQHqKmUJUrkxG4hBohlM54ccvVv8hgcUzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tbjnDzGW; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tbjnDzGW"
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764587714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e9mggv6DfPBghIR8nxbEbjiHW97QJ9xR/zSwx2wi9Dk=;
	b=tbjnDzGWBiJUCfqokzNfq9AzQV73ajvagdI8CPI6ZX+KcKlmvAqqmHGxjQ8+B8RoITez9t
	RQP+tM6Py71zyw44gLAbKJ8RmpIEMZLHZgjqYJmwpABShbZ0djAYHXcISuWaAtuu3AiV+u
	qGLxL68G3sXpl7VuxYzVIqvRnjvbWFY=
Date: Mon, 01 Dec 2025 11:15:10 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <e6ec12b0a9a3e0bc4db370b3fb6647f7127f4a04@linux.dev>
TLS-Required: No
Subject: Re: [PATCH 6.1.y] mptcp: Fix proto fallback detection with BPF
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, stable@vger.kernel.org,
 gregkh@linuxfoundation.org
Cc: "MPTCP Upstream" <mptcp@lists.linux.dev>, "Martin KaFai Lau"
 <martin.lau@kernel.org>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
In-Reply-To: <20251201104459.3440448-2-matttbe@kernel.org>
References: <2025112444-entangled-winking-ac86@gregkh>
 <20251201104459.3440448-2-matttbe@kernel.org>
X-Migadu-Flow: FLOW_OUT

December 1, 2025 at 18:45, "Matthieu Baerts (NGI0)" <matttbe@kernel.org m=
ailto:matttbe@kernel.org?to=3D%22Matthieu%20Baerts%20(NGI0)%22%20%3Cmattt=
be%40kernel.org%3E > wrote:


>=20
>=20From: Jiayuan Chen <jiayuan.chen@linux.dev>
>=20
>=20commit c77b3b79a92e3345aa1ee296180d1af4e7031f8f upstream.
>=20
>=20The sockmap feature allows bpf syscall from userspace, or based
> on bpf sockops, replacing the sk_prot of sockets during protocol stack
> processing with sockmap's custom read/write interfaces.
> '''
> tcp_rcv_state_process()
>  syn_recv_sock()/subflow_syn_recv_sock()
>  tcp_init_transfer(BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB)
>  bpf_skops_established <=3D=3D sockops
>  bpf_sock_map_update(sk) <=3D=3D call bpf helper
>  tcp_bpf_update_proto() <=3D=3D update sk_prot
> '''
>=20
>=20When the server has MPTCP enabled but the client sends a TCP SYN
> without MPTCP, subflow_syn_recv_sock() performs a fallback on the
> subflow, replacing the subflow sk's sk_prot with the native sk_prot.
> '''
> subflow_syn_recv_sock()
>  subflow_ulp_fallback()
>  subflow_drop_ctx()
>  mptcp_subflow_ops_undo_override()
> '''
>=20
>=20Then, this subflow can be normally used by sockmap, which replaces th=
e
> native sk_prot with sockmap's custom sk_prot. The issue occurs when the
> user executes accept::mptcp_stream_accept::mptcp_fallback_tcp_ops().
> Here, it uses sk->sk_prot to compare with the native sk_prot, but this
> is incorrect when sockmap is used, as we may incorrectly set
> sk->sk_socket->ops.
>=20
>=20This fix uses the more generic sk_family for the comparison instead.
>=20
>=20Additionally, this also prevents a WARNING from occurring:
>=20
>=20result from ./scripts/decode_stacktrace.sh:
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 337 at net/mptcp/protocol.c:68 mptcp_stream_accept=
 \
> (net/mptcp/protocol.c:4005)
> Modules linked in:
> ...
>=20
>=20PKRU: 55555554
> Call Trace:
> <TASK>
> do_accept (net/socket.c:1989)
> __sys_accept4 (net/socket.c:2028 net/socket.c:2057)
> __x64_sys_accept (net/socket.c:2067)
> x64_sys_call (arch/x86/entry/syscall_64.c:41)
> do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64=
.c:94)
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> RIP: 0033:0x7f87ac92b83d
>=20
>=20---[ end trace 0000000000000000 ]---
>=20
>=20Fixes: 0b4f33def7bb ("mptcp: fix tcp fallback crash")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> Cc: <stable@vger.kernel.org>
> Link: https://patch.msgid.link/20251111060307.194196-3-jiayuan.chen@lin=
ux.dev
> [ Conflicts in protocol.c, because commit 8e2b8a9fa512 ("mptcp: don't
>  overwrite sock_ops in mptcp_is_tcpsk()") is not in this version. It
>  changes the logic on how and where the sock_ops is overridden in case
>  of passive fallback. To fix this, mptcp_is_tcpsk() is modified to use
>  the family, but first, a check of the protocol is required to continue
>  returning 'false' in case of MPTCP socket. ]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  net/mptcp/protocol.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
>=20diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index e2908add97d3..10844f08752c 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -79,8 +79,13 @@ static u64 mptcp_wnd_end(const struct mptcp_sock *ms=
k)
>  static bool mptcp_is_tcpsk(struct sock *sk)
>  {
>  struct socket *sock =3D sk->sk_socket;
> + unsigned short family;
>=20=20
>=20- if (unlikely(sk->sk_prot =3D=3D &tcp_prot)) {
> + if (likely(sk->sk_protocol =3D=3D IPPROTO_MPTCP))
> + return false;
> +
> + family =3D READ_ONCE(sk->sk_family);
> + if (unlikely(family =3D=3D AF_INET)) {
>  /* we are being invoked after mptcp_accept() has
>  * accepted a non-mp-capable flow: sk is a tcp_sk,
>  * not an mptcp one.
> @@ -91,7 +96,7 @@ static bool mptcp_is_tcpsk(struct sock *sk)
>  sock->ops =3D &inet_stream_ops;
>  return true;
>  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> - } else if (unlikely(sk->sk_prot =3D=3D &tcpv6_prot)) {
> + } else if (unlikely(family =3D=3D AF_INET6)) {
>  sock->ops =3D &inet6_stream_ops;
>  return true;
>  #endif
> --=20
>=202.51.0
>

Thank you, Matthieu. I=E2=80=99ve tested the patch and confirmed it resol=
ves the issue.
