Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A203618858E
	for <mptcp@lists.linux.dev>; Thu,  5 Sep 2024 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523616; cv=none; b=Y2h4K67YLa4HrtFMjGSrFRr1E0P88T9SWmpAKLUW0Ww4Ft6Ae6lCV/QuQStBGS4kVveJ8ZrbE2bG8I5bVc5Mi3iLbkz4l7GclRSdcKXqO3zqu7RtB3p/tS5nn7jstsz+GjAyFwHaSjPzUDBf86L6TSsLlASYU9PkwEOc96/aSaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523616; c=relaxed/simple;
	bh=xYd00rk3ZsjVBcehWIm4pch5HvPB/hYOCR0WiXavphQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bn1Nqihtn4rbvvplFqrGyOpkK4vUo4OQRp3okUlOFLP+xupezs2ns+gYvUNSAhjBivSzffDCrqy5eBGns0zvCot1S8bRujxBIvPXICMgcKOZg3NzuY+t0efkNIw/4ZHxudlvY+/+rS6B1XsZL01pNv7sFBszezEc3ezpj/JXeLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeI7Ih6U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeI7Ih6U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE0CC4CEC3;
	Thu,  5 Sep 2024 08:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725523616;
	bh=xYd00rk3ZsjVBcehWIm4pch5HvPB/hYOCR0WiXavphQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MeI7Ih6UuboZ1IQ0C8UDF5ZjiDoVNNVv4yYSMauulGNgXtA3POsHjInIDcSrpjtLw
	 JFC7t3JywomogE3S5N6lAKgTDnH/yCtxB4tuuySk/uspTUjLwUMb7mVyMa16VDyQze
	 hHHhupFNJWmc1bJlNaTU8lkyn4QrzTyfVnxVJhik5o4B8k0czvRb+/aNrheQLeBv4Y
	 rw063RkNLM+8P5XAERhAJnsXeW22B8erTeaB01UlEECzHMOov3MkLEoKhd/X/bHHak
	 lTGjCu39OVlhIYulZmtDc+MdrLGsTC6qNaTOOUj69gqeR7b8dnwUBiOprrIbebbYZY
	 jOAKZq7LK1mqQ==
Message-ID: <3d0b6acfa9753162380c640bcb13c54bf00af544.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v8 2/4] selftests/bpf: Add getsockopt to
 inspect mptcp subflow
From: Geliang Tang <geliang@kernel.org>
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev
Date: Thu, 05 Sep 2024 16:06:52 +0800
In-Reply-To: <44ef8e395feddc3fe83c1ea043c3bc07f98c1042.1725502822.git.tanggeliang@kylinos.cn>
References: <cover.1725502822.git.tanggeliang@kylinos.cn>
	 <44ef8e395feddc3fe83c1ea043c3bc07f98c1042.1725502822.git.tanggeliang@kylinos.cn>
Autocrypt: addr=geliang@kernel.org; prefer-encrypt=mutual;
 keydata=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
 Px+2P2cKc7LXXedb/qQ3M
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Matt,

On Thu, 2024-09-05 at 10:26 +0800, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> This patch adds a "cgroup/getsockopt" way to inspect the subflows of
> a
> mptcp socket.
> 
> mptcp_for_each_stubflow() and other helpers related to list_dentry
> are
> added into progs/mptcp_bpf.h.
> 
> Add an extra "cgroup/getsockopt" prog to walk the msk->conn_list and
> use
> bpf_core_cast to cast a pointer to tcp_sock for readonly. It will
> allow
> to inspect all the fields in a tcp_sock.
> 
> Suggested-by: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/bpf/progs/mptcp_bpf.h | 27 ++++++++
>  .../selftests/bpf/progs/mptcp_subflow.c       | 69
> +++++++++++++++++++
>  2 files changed, 96 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> index 782f36ed027e..92d5deed0214 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> @@ -4,9 +4,36 @@
>  
>  #include <vmlinux.h>
>  #include <bpf/bpf_core_read.h>
> +#include "bpf_experimental.h"
>  
>  #define MPTCP_SUBFLOWS_MAX 8
>  
> +static inline int list_is_head(const struct list_head *list,
> +			       const struct list_head *head)
> +{
> +	return list == head;
> +}
> +
> +#define list_entry(ptr, type,
> member)					\
> +	container_of(ptr, type, member)
> +
> +#define list_first_entry(ptr, type,
> member)				\
> +	list_entry((ptr)->next, type, member)
> +
> +#define list_next_entry(pos,
> member)					\
> +	list_entry((pos)->member.next, typeof(*(pos)), member)
> +
> +#define list_entry_is_head(pos, head,
> member)				\
> +	list_is_head(&pos->member, (head))
> +
> +#define list_for_each_entry(pos, head,
> member)				\
> +	for (pos = list_first_entry(head, typeof(*pos),
> member);	\
> +	     cond_break, !list_entry_is_head(pos, head,
> member);	\
> +	     pos = list_next_entry(pos, member))
> +
> +#define mptcp_for_each_subflow(__msk,
> __subflow)			\
> +	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
> +

The helper mptcp_subflow_tcp_sock() added by the commit "selftests/bpf:
Add bpf_rr scheduler & test" needs be added into this commit:

static __always_inline struct sock *
mptcp_subflow_tcp_sock(const struct mptcp_subflow_context *subflow)
{
        return subflow->tcp_sock;
}

Otherwise, compiling errors occur.

Thanks,
-Geliang

>  extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context
> *subflow,
>  					bool scheduled) __ksym;
>  
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> index 2e28f4a215b5..70302477e326 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> @@ -4,10 +4,12 @@
>  
>  /* vmlinux.h, bpf_helpers.h and other 'define' */
>  #include "bpf_tracing_net.h"
> +#include "mptcp_bpf.h"
>  
>  char _license[] SEC("license") = "GPL";
>  
>  char cc[TCP_CA_NAME_MAX] = "reno";
> +int pid;
>  
>  /* Associate a subflow counter to each token */
>  struct {
> @@ -57,3 +59,70 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
>  
>  	return 1;
>  }
> +
> +static int _check_getsockopt_subflow_mark(struct mptcp_sock *msk,
> struct bpf_sockopt *ctx)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	int i = 0;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk;
> +
> +		ssk = mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
> +							   struct
> mptcp_subflow_context));
> +
> +		if (ssk->sk_mark != ++i) {
> +			ctx->retval = -2;
> +			break;
> +		}
> +	}
> +
> +	return 1;
> +}
> +
> +static int _check_getsockopt_subflow_cc(struct mptcp_sock *msk,
> struct bpf_sockopt *ctx)
> +{
> +	struct mptcp_subflow_context *subflow;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct inet_connection_sock *icsk;
> +		struct sock *ssk;
> +
> +		ssk = mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
> +							   struct
> mptcp_subflow_context));
> +		icsk = bpf_core_cast(ssk, struct
> inet_connection_sock);
> +
> +		if (ssk->sk_mark == 2 &&
> +		    __builtin_memcmp(icsk->icsk_ca_ops->name, cc,
> TCP_CA_NAME_MAX)) {
> +			ctx->retval = -2;
> +			break;
> +		}
> +	}
> +
> +	return 1;
> +}
> +
> +SEC("cgroup/getsockopt")
> +int _getsockopt_subflow(struct bpf_sockopt *ctx)
> +{
> +	struct bpf_sock *sk = ctx->sk;
> +	struct mptcp_sock *msk;
> +
> +	if (bpf_get_current_pid_tgid() >> 32 != pid)
> +		return 1;
> +
> +	if (!sk || sk->protocol != IPPROTO_MPTCP ||
> +	    (!(ctx->level == SOL_SOCKET && ctx->optname == SO_MARK)
> &&
> +	     !(ctx->level == SOL_TCP && ctx->optname ==
> TCP_CONGESTION)))
> +		return 1;
> +
> +	msk = bpf_core_cast(sk, struct mptcp_sock);
> +	if (msk->pm.subflows != 1) {
> +		ctx->retval = -1;
> +		return 1;
> +	}
> +
> +	if (ctx->optname == SO_MARK)
> +		return _check_getsockopt_subflow_mark(msk, ctx);
> +	return _check_getsockopt_subflow_cc(msk, ctx);
> +}

