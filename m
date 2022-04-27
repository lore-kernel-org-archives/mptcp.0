Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FE136B
	for <mptcp@lists.linux.dev>; Wed, 27 Apr 2022 00:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651018655; x=1682554655;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SfD/SIdmUqXFC7/+gQ2h+CDIz9BiubOE4161nXZiJxA=;
  b=DF6gdsIU4+6Q9mpnXKu4fIPD87LUh5Udx2My54MiFrcco8tlWPWE4ZkO
   et9H/Owfll4Ut2v2XErEJ0a1E/ANvqHwJtl6hpfukWkOKrrURrMUNdZMq
   OG2so+bzQpGxnslcNZssZi2RpoKpox/mX99Kw/HfmuFPSKWIve5ijTPec
   Dhbw79Z7wQAHnEcF8eKEcvgQ0GqbNicTd2RIw/jBtQAUTR1/GVPDD8uLg
   aL3CXAyFxLP+oUdNeL5Q0bbrDxPaaiU1d4Kx0IMvfiG9DVdWmWBAGBMse
   OassSCNIi5wlS708oDMwPrZunN8R7NZpUf/u0uvoNs4rILgRTf5qykkC0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="264610338"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="264610338"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 17:17:34 -0700
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="532929276"
Received: from brpivitt-mobl1.amr.corp.intel.com ([10.252.136.44])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 17:17:34 -0700
Date: Tue, 26 Apr 2022 17:17:34 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "bpf: add
 bpf_skc_to_mptcp_sock_proto"
In-Reply-To: <a412b57378176f189e112a36443ac133fa90566c.1650947043.git.geliang.tang@suse.com>
Message-ID: <39951b3-5ec-09-6547-991ff81e2f1@linux.intel.com>
References: <a412b57378176f189e112a36443ac133fa90566c.1650947043.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 26 Apr 2022, Geliang Tang wrote:

> Update as Daniel suggested.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Looks good to squash, thanks. The 'base' bpf tests pass, which is what 
Daniel noted as failing.

- Mat


> ---
> include/linux/bpf.h      | 1 +
> include/net/mptcp.h      | 2 +-
> kernel/bpf/verifier.c    | 1 +
> kernel/trace/bpf_trace.c | 2 ++
> net/core/filter.c        | 3 ++-
> net/mptcp/Makefile       | 2 --
> 6 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index bdb5298735ce..2493f9601842 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2249,6 +2249,7 @@ extern const struct bpf_func_proto bpf_skc_to_tcp_timewait_sock_proto;
> extern const struct bpf_func_proto bpf_skc_to_tcp_request_sock_proto;
> extern const struct bpf_func_proto bpf_skc_to_udp6_sock_proto;
> extern const struct bpf_func_proto bpf_skc_to_unix_sock_proto;
> +extern const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto;
> extern const struct bpf_func_proto bpf_copy_from_user_proto;
> extern const struct bpf_func_proto bpf_snprintf_btf_proto;
> extern const struct bpf_func_proto bpf_snprintf_proto;
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 6b07011c060d..4d761ad530c9 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -284,7 +284,7 @@ static inline int mptcpv6_init(void) { return 0; }
> static inline void mptcpv6_handle_mapped(struct sock *sk, bool mapped) { }
> #endif
>
> -#if defined(CONFIG_MPTCP) && defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
> +#if defined(CONFIG_MPTCP) && defined(CONFIG_BPF_SYSCALL)
> struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk);
> #else
> static inline struct mptcp_sock *bpf_mptcp_sock_from_subflow(struct sock *sk) { return NULL; }
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9c1a02b82ecd..40602ec20c6a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -517,6 +517,7 @@ static bool is_ptr_cast_function(enum bpf_func_id func_id)
> 		func_id == BPF_FUNC_skc_to_tcp_sock ||
> 		func_id == BPF_FUNC_skc_to_tcp6_sock ||
> 		func_id == BPF_FUNC_skc_to_udp6_sock ||
> +		func_id == BPF_FUNC_skc_to_mptcp_sock ||
> 		func_id == BPF_FUNC_skc_to_tcp_timewait_sock ||
> 		func_id == BPF_FUNC_skc_to_tcp_request_sock;
> }
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index b26f3da943de..c7bf10cf2fa5 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1685,6 +1685,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> 		return &bpf_skc_to_udp6_sock_proto;
> 	case BPF_FUNC_skc_to_unix_sock:
> 		return &bpf_skc_to_unix_sock_proto;
> +	case BPF_FUNC_skc_to_mptcp_sock:
> +		return &bpf_skc_to_mptcp_sock_proto;
> 	case BPF_FUNC_sk_storage_get:
> 		return &bpf_sk_storage_get_tracing_proto;
> 	case BPF_FUNC_sk_storage_delete:
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 4bcf13b1d0e2..a0dd6f6b17f8 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -11282,10 +11282,11 @@ const struct bpf_func_proto bpf_skc_to_unix_sock_proto = {
>
> BPF_CALL_1(bpf_skc_to_mptcp_sock, struct sock *, sk)
> {
> +	BTF_TYPE_EMIT(struct mptcp_sock);
> 	return (unsigned long)bpf_mptcp_sock_from_subflow(sk);
> }
>
> -static const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto = {
> +const struct bpf_func_proto bpf_skc_to_mptcp_sock_proto = {
> 	.func		= bpf_skc_to_mptcp_sock,
> 	.gpl_only	= false,
> 	.ret_type	= RET_PTR_TO_BTF_ID_OR_NULL,
> diff --git a/net/mptcp/Makefile b/net/mptcp/Makefile
> index 4004347db47e..6e7df47c9584 100644
> --- a/net/mptcp/Makefile
> +++ b/net/mptcp/Makefile
> @@ -11,6 +11,4 @@ mptcp_crypto_test-objs := crypto_test.o
> mptcp_token_test-objs := token_test.o
> obj-$(CONFIG_MPTCP_KUNIT_TEST) += mptcp_crypto_test.o mptcp_token_test.o
>
> -ifeq ($(CONFIG_BPF_JIT),y)
> obj-$(CONFIG_BPF_SYSCALL) += bpf.o
> -endif
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
