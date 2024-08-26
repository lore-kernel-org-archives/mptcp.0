Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE15E433DC
	for <mptcp@lists.linux.dev>; Mon, 26 Aug 2024 03:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724642131; cv=none; b=fbYI3HapkLnG0Gb42RCwgLSRoAWRDGu0VBd/FmeMwZk/4nfVNfW9OQHh289T0+Wq47fjycriV4QZq6eMWjiFlH3x1ZGreoKGTdw+D7CAP3wtphxL28FKgBsJk4BUMJjoHJz6+Xttciyi1TL7awxwSHzqurz0594UuA1uD64oWy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724642131; c=relaxed/simple;
	bh=0s4FVHwwurKHVcStR5WwFnR4s2rB55Bsk9cXOC86rlA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PZcFnCIVo4OPaPGPCNTLgvtzkqGWFRXgfQcQsjqGv9tZZK5wXo8a8U83Y3miHv8FPZ0OK5V7VibB7kx3AmKJBPcjU/zdQy38Omv8+0lKgWEj175uWWey0C0DdPscFp7yHfXxwojk6ElcRWjP/aGMdBJ14Jak5V6vTiChft0JaMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dl8TSbQ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dl8TSbQ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941A2C32786;
	Mon, 26 Aug 2024 03:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724642130;
	bh=0s4FVHwwurKHVcStR5WwFnR4s2rB55Bsk9cXOC86rlA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=dl8TSbQ1NmG8XlKD577Os0Z6InLSMderqMatI5u+apBWlx5pR48F/EEf3ZBZiO3+t
	 zES4uMlR35mlaXgNP5GUSCxdu/HIz/aUXQIADgLkPBWghUaopmzDBcvC5yYVIf8nWF
	 E/JsceZXX6wbsK0A63+96Q9J+G8jkysYR9beMNLcsWcWc/ZeEaYGC6liNPg8ZTUiSJ
	 xSLgDWNLVqPVUD1frgzzxl6909sja0RbYTU/hKQ/ZBUy07Da0DRK/PdSH93TNN1+WW
	 HDuIiNGHFI9HWel15GNZJZg76rmG2jRaK+3lxA3czG3RjfI+RA90oAqqHRg3sFEeXu
	 V14991keEauCg==
Message-ID: <4eb24c85cc153abf949c26553c1b2b6804d34a4d.camel@kernel.org>
Subject: Re: [PATCH mptcp-next v4 2/3] selftests/bpf: Add getsockopt to
 inspect mptcp subflow
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Mon, 26 Aug 2024 11:15:25 +0800
In-Reply-To: <7639ece4513d3caa7902013943cdd222d237bee7.1724415435.git.tanggeliang@kylinos.cn>
References: <cover.1724415435.git.tanggeliang@kylinos.cn>
	 <7639ece4513d3caa7902013943cdd222d237bee7.1724415435.git.tanggeliang@kylinos.cn>
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

On Fri, 2024-08-23 at 20:19 +0800, Geliang Tang wrote:
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
>  tools/testing/selftests/bpf/progs/mptcp_bpf.h | 35 ++++++++++
>  .../selftests/bpf/progs/mptcp_subflow.c       | 64
> +++++++++++++++++++
>  2 files changed, 99 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> index 782f36ed027e..d60e3c8f85a1 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf.h
> @@ -4,9 +4,44 @@
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
> +#define list_for_each_entry_safe(pos, n, head,
> member)			\
> +	for (pos = list_first_entry(head, typeof(*pos),
> member),	\
> +		n = list_next_entry(pos,
> member);			\
> +	     cond_break, !list_entry_is_head(pos, head,
> member);	\
> +	     pos = n, n = list_next_entry(n, member))
> +
> +#define mptcp_for_each_subflow(__msk,
> __subflow)			\
> +	list_for_each_entry(__subflow, &((__msk)->conn_list), node)
> +#define mptcp_for_each_subflow_safe(__msk, __subflow,
> __tmp)		\
> +	list_for_each_entry_safe(__subflow, __tmp, &((__msk)-
> >conn_list), node)
> +
>  extern void mptcp_subflow_set_scheduled(struct mptcp_subflow_context
> *subflow,
>  					bool scheduled) __ksym;
>  
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> index 2e28f4a215b5..dfb40a065813 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_subflow.c
> @@ -4,6 +4,7 @@
>  
>  /* vmlinux.h, bpf_helpers.h and other 'define' */
>  #include "bpf_tracing_net.h"
> +#include "mptcp_bpf.h"
>  
>  char _license[] SEC("license") = "GPL";
>  
> @@ -57,3 +58,66 @@ int mptcp_subflow(struct bpf_sock_ops *skops)
>  
>  	return 1;
>  }
> +
> +static int _check_getsockopt_subflows_mark(struct mptcp_sock *msk,

I prefer to rename this function as _check_getsockopt_subflow_mark. If
there's no next iteration version, please help me update this when
merging this patch.

Thanks,
-Geliang

> struct bpf_sockopt *ctx)
> +{
> +	struct mptcp_subflow_context *subflow;
> +	int *optval = ctx->optval;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		struct sock *ssk;
> +
> +		ssk = mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
> +							   struct
> mptcp_subflow_context));
> +
> +		if (ctx->optval + sizeof(int) <= ctx->optval_end) {
> +			*optval = ssk->sk_mark;
> +			ctx->retval = 0;
> +		}
> +	}
> +
> +	return 1;
> +}
> +
> +static int _check_getsockopt_subflow_cc(struct mptcp_sock *msk,
> struct bpf_sockopt *ctx)
> +{
> +	struct mptcp_subflow_context *subflow, *tmp;
> +	char *optval = ctx->optval;
> +
> +	mptcp_for_each_subflow_safe(msk, subflow, tmp) {
> +		struct inet_connection_sock *icsk;
> +		struct sock *ssk;
> +
> +		ssk = mptcp_subflow_tcp_sock(bpf_core_cast(subflow,
> +							   struct
> mptcp_subflow_context));
> +		icsk = bpf_core_cast(ssk, struct
> inet_connection_sock);
> +
> +		if (ctx->optval + TCP_CA_NAME_MAX <= ctx-
> >optval_end) {
> +			__builtin_memcpy(optval, icsk->icsk_ca_ops-
> >name, TCP_CA_NAME_MAX);
> +			ctx->retval = 0;
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
> +	if (!sk || sk->protocol != IPPROTO_MPTCP)
> +		return 1;
> +
> +	msk = bpf_core_cast(sk, struct mptcp_sock);
> +	if (msk->pm.subflows != 1)
> +		return 1;
> +
> +	if (ctx->level == SOL_SOCKET && ctx->optname == SO_MARK)
> +		return _check_getsockopt_subflows_mark(msk, ctx);
> +	if (ctx->level == SOL_TCP && ctx->optname == TCP_CONGESTION)
> +		return _check_getsockopt_subflow_cc(msk, ctx);
> +
> +	return 1;
> +}

