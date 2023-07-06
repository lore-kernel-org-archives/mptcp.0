Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C56AD3B
	for <mptcp@lists.linux.dev>; Thu,  6 Jul 2023 17:02:46 +0000 (UTC)
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-c5fc972760eso910152276.1
        for <mptcp@lists.linux.dev>; Thu, 06 Jul 2023 10:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688662966; x=1691254966;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DYV6pgHKw9Q1C2YF3sEExIYRzKeLNEpN6/la5lAPVV8=;
        b=DKTLpShZENcFE2yL3MQu8uyInElijPQXhM9gOWCj/AGnHRCSo23f/Os5LImNFG2Nd5
         I8eLlPHjqYShBTX4kd5BFjrirG93Io15ICIKTfAO+GOvFzsEpX56ZB5O02ALXZWEGzXP
         YoFuTL0Ftlzd25/sGqD6JLfVrlWLfDAQ/OyvJD53pb/LVGxFVruVmJOQZBsG85vULBex
         JJP70hW3NKWo/NHf0HxNokWrQbG5TrNVa4bDacw+LtlM1xxw9BDAwM7pfToXVFSaTqFq
         LatlV7n63nn69y+wEpaN5hg9JU32ACGSvgRjwQ6/GJ0HITjxlvu+3YURlFyoYY53wliF
         Ch1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688662966; x=1691254966;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DYV6pgHKw9Q1C2YF3sEExIYRzKeLNEpN6/la5lAPVV8=;
        b=VUNja5F8EQy0z4y1InWH74DW8EV35mVgc8gb9YPp4UWwZ3sVfKOIZxQUnWayqqtqKH
         DpGabuZvgZYhowZ7R9Eu99iWOfzcarWOL8McbdMylExnB9+B33qzu5A1JeYE9MFZgrMC
         qPc8inBB8rik0Y0/B+WyR8scX9n8ySdmdpI/ZwHIq2Wn7Jkg1beCRgyH/PLvcBUjFjsW
         5W32CdGmd6Tu16X6xebn4+MopGD9JPJMl16y9mUgASpIjOxrEALgTsBq8uGnJqa728JT
         FPVbPG6OHHuUO8JaDg4KNRnLfIaQcZeESiVGAuxW316QrdDuiCsCzVl4yqs21aXTlMgI
         3Wmw==
X-Gm-Message-State: ABy/qLZEwD0B8aZiFz4I7nAVDZaJTYDdP4jLkE9F52E6jLSdWnvNDrNk
	/fBwN1PO9z7fmQdq2OLKc7kSRIA=
X-Google-Smtp-Source: APBJJlEcTp7aLooWtTlpFj7fNm1rfJvxR2RgiG9PgmZLd+u+tMyps1C+w/AO73eIzJFk6Hda97LNZnw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:4802:0:b0:bcf:9ae7:c38 with SMTP id
 v2-20020a254802000000b00bcf9ae70c38mr11333yba.2.1688662965838; Thu, 06 Jul
 2023 10:02:45 -0700 (PDT)
Date: Thu, 6 Jul 2023 10:02:43 -0700
In-Reply-To: <cover.1688616142.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <cover.1688616142.git.geliang.tang@suse.com>
Message-ID: <ZKbzs7foUw+eeNnn@google.com>
Subject: Re: [RFC bpf-next 0/8] BPF 'force to MPTCP'
From: Stanislav Fomichev <sdf@google.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="utf-8"

On 07/06, Geliang Tang wrote:
> As is described in the "How to use MPTCP?" section in MPTCP wiki [1]:
> 
> "Your app can create sockets with IPPROTO_MPTCP as the proto:
> ( socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP); ). Legacy apps can be
> forced to create and use MPTCP sockets instead of TCP ones via the
> mptcpize command bundled with the mptcpd daemon."
> 
> But the mptcpize (LD_PRELOAD technique) command has some limitations
> [2]:
> 
>  - it doesn't work if the application is not using libc (e.g. GoLang
> apps)
>  - in some envs, it might not be easy to set env vars / change the way
> apps are launched, e.g. on Android
>  - mptcpize needs to be launched with all apps that want MPTCP: we could
> have more control from BPF to enable MPTCP only for some apps or all the
> ones of a netns or a cgroup, etc.
>  - it is not in BPF, we cannot talk about it at netdev conf.
> 
> So this patchset attempts to use BPF to implement functions similer to
> mptcpize.
> 
> The main idea is add a hook in sys_socket() to change the protocol id
> from IPPROTO_TCP (or 0) to IPPROTO_MPTCP.
> 
> 1. This first solution [3] is using "cgroup/sock_create":
> 
> Implement a new helper bpf_mptcpify() to change the protocol id:
> 
> +BPF_CALL_1(bpf_mptcpify, struct sock *, sk)
> +{
> +	if (sk && sk_fullsock(sk) && sk->sk_protocol == IPPROTO_TCP) {
> +		sk->sk_protocol = IPPROTO_MPTCP;
> +		return (unsigned long)sk;
> +	}
> +
> +	return (unsigned long)NULL;
> +}
> +
> +const struct bpf_func_proto bpf_mptcpify_proto = {
> +	.func		= bpf_mptcpify,
> +	.gpl_only	= false,
> +	.ret_type	= RET_PTR_TO_BTF_ID_OR_NULL,
> +	.ret_btf_id	= &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
> +	.arg1_type	= ARG_PTR_TO_CTX,
> +};
> 
> Add a hook in "cgroup/sock_create" section, invoking bpf_mptcpify()
> helper in this hook:
> 
> +SEC("cgroup/sock_create")
> +int sock(struct bpf_sock *ctx)
> +{
> +	struct sock *sk;
> +
> +	if (ctx->type != SOCK_STREAM)
> +		return 1;
> +
> +	sk = bpf_mptcpify(ctx);
> +	if (!sk)
> +		return 1;
> +
> +	protocol = sk->sk_protocol;
> +	return 1;
> +}
> 
> But this solution doesn't work, because the sock_create section is
> hooked at the end of inet_create(). It's too late to change the protocol
> id.
> 
> 2. The second solution [4] is using "fentry":
> 
> Implement a bpf_mptcpify() helper:
> 
> +BPF_CALL_1(bpf_mptcpify, struct socket_args *, args)
> +{
> +	if (args->family == AF_INET &&
> +	    args->type == SOCK_STREAM &&
> +	    (!args->protocol || args->protocol == IPPROTO_TCP))
> +		args->protocol = IPPROTO_MPTCP;
> +
> +	return 0;
> +}
> +
> +BTF_ID_LIST(bpf_mptcpify_btf_ids)
> +BTF_ID(struct, socket_args)
> +
> +static const struct bpf_func_proto bpf_mptcpify_proto = {
> +	.func		= bpf_mptcpify,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type	= ARG_PTR_TO_BTF_ID,
> +	.arg1_btf_id	= &bpf_mptcpify_btf_ids[0],
> +};
> 
> Add a new wrapper socket_create() in sys_socket() path, passing a
> pointer of struct socket_args (int family; int type; int protocol) to
> the wrapper.
> 
> +int socket_create(struct socket_args *args, struct socket **res)
> +{
> +	return sock_create(args->family, args->type, args->protocol, res);
> +}
> +EXPORT_SYMBOL(socket_create);
> +
>  /**
>   *	sock_create_kern - creates a socket (kernel space)
>   *	@net: net namespace
> @@ -1608,6 +1614,7 @@  EXPORT_SYMBOL(sock_create_kern);
>  
>  static struct socket *__sys_socket_create(int family, int type, int protocol)
>  {
> +	struct socket_args args = { 0 };
>  	struct socket *sock;
>  	int retval;
>  
> @@ -1621,7 +1628,10 @@  static struct socket *__sys_socket_create(int family, int type, int protocol)
>  		return ERR_PTR(-EINVAL);
>  	type &= SOCK_TYPE_MASK;
>  
> -	retval = sock_create(family, type, protocol, &sock);
> +	args.family = family;
> +	args.type = type;
> +	args.protocol = protocol;
> +	retval = socket_create(&args, &sock);
>  	if (retval < 0)
>  		return ERR_PTR(retval);
> 
> Add "fentry" hook to the newly added wrapper, invoking bpf_mptcpify()
> in the hook:
> 
> +SEC("fentry/socket_create")
> +int BPF_PROG(trace_socket_create, void *args,
> +		struct socket **res)
> +{
> +	bpf_mptcpify(args);
> +	return 0;
> +}
> 
> This version works. But it's just a work around version. Since the code
> to add a wrapper to sys_socket() is not very elegant indeed, and it
> shouldn't be accepted by upstream.
> 
> 3. The last solution is this patchset itself:
> 
> Introduce new program type BPF_PROG_TYPE_CGROUP_SOCKINIT and attach type
> BPF_CGROUP_SOCKINIT on cgroup basis.
> 
> Define BPF_CGROUP_RUN_PROG_SOCKINIT() helper, and implement
> __cgroup_bpf_run_sockinit() helper to run a sockinit program:
> 
> +#define BPF_CGROUP_RUN_PROG_SOCKINIT(family, type, protocol)		       \
> +({									       \
> +	int __ret = 0;							       \
> +	if (cgroup_bpf_enabled(CGROUP_SOCKINIT))			       \
> +		__ret = __cgroup_bpf_run_sockinit(family, type, protocol,      \
> +						  CGROUP_SOCKINIT);	       \
> +	__ret;								       \
> +})
> +
> 
> Invoke BPF_CGROUP_RUN_PROG_SOCKINIT() in __socket_create() to change
> the arguments:
> 
> @@ -1469,6 +1469,12 @@  int __sock_create(struct net *net, int family, int type, int protocol,
>  	struct socket *sock;
>  	const struct net_proto_family *pf;
>  
> +	if (!kern) {
> +		err = BPF_CGROUP_RUN_PROG_SOCKINIT(&family, &type, &protocol);
> +		if (err)
> +			return err;
> +	}
> +
>  	/*
>  	 *      Check protocol is in range
>  	 */
> 
> Define BPF program in this newly added 'sockinit' SEC, so it will be
> hooked in BPF_CGROUP_RUN_PROG_SOCKINIT() in __socket_create().
> 
> @@ -158,6 +158,11 @@  static struct sec_name_test tests[] = {
>  		{0, BPF_PROG_TYPE_CGROUP_SOCKOPT, BPF_CGROUP_SETSOCKOPT},
>  		{0, BPF_CGROUP_SETSOCKOPT},
>  	},
> +	{
> +		"cgroup/sockinit",
> +		{0, BPF_PROG_TYPE_CGROUP_SOCKINIT, BPF_CGROUP_SOCKINIT},
> +		{0, BPF_CGROUP_SOCKINIT},
> +	},
>  };
> 
> +SEC("cgroup/sockinit")
> +int mptcpify(struct bpf_sockinit_ctx *ctx)
> +{
> +	if ((ctx->family == AF_INET || ctx->family == AF_INET6) &&
> +	    ctx->type == SOCK_STREAM &&
> +	    (!ctx->protocol || ctx->protocol == IPPROTO_TCP)) {
> +		ctx->protocol = IPPROTO_MPTCP;
> +	}
> +
> +	return 1;
> +}
> 
> This version is the best solution we have found so far.
> 
> [1]
> https://github.com/multipath-tcp/mptcp_net-next/wiki
> [2]
> https://github.com/multipath-tcp/mptcp_net-next/issues/79
> [3]
> https://patchwork.kernel.org/project/mptcp/cover/cover.1688215769.git.geliang.tang@suse.com/
> [4]
> https://patchwork.kernel.org/project/mptcp/cover/cover.1688366249.git.geliang.tang@suse.com/

cgroup/sock_create being weird and triggering late and only for af_inet4/6
was the reason we added ability to attach to lsm hooks on a per-cgroup
basis:
https://lore.kernel.org/bpf/20220628174314.1216643-1-sdf@google.com/

Unfortunately, using it here won't help either :-( The following
hook triggers early enough but doesn't allow changing the arguments (I was
interested only in filtering based on the arguments, not changing them):

LSM_HOOK(int, 0, socket_create, int family, int type, int protocol, int kern)

So maybe another alternative might be to change its definition to int *family,
int *type, int *protocol and use lsm_cgroup/socket_create to rewrite the
protocol? (some verifier changes might needed to make those writable)
