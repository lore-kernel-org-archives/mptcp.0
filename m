Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8E66D1BA
	for <mptcp@lists.linux.dev>; Wed, 31 Jan 2024 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692093; cv=none; b=CMG2WoJWdCskAvgwkUrfEuO101rB8gTqkOQIioYugP0txbSVmG10vShTerzwcJnCho84yQSYzucc5Vk3vXe+pjxm9mbm1XCM3YajBZLf4QoHCDmEjEk/AFijVA3tv19H8vGsrbW5qwubVEBP6WCvU8SufkhQP7WWSfsMAQJIxVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692093; c=relaxed/simple;
	bh=Z6aHuGxlnVt8/83lAwk2OMBYzq6b65VMszniWGteeWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUftlNrf1zUyI0/LDmmNDfGH082Ic8+CgmJqMdFtFOGc/lxnNqmqpi2lMg5cQw+dkKcAdoest0KfVd7LYezZlO+9dotW71JBVf/apeWJHNcc4/RmXqAEvlGHX8fb91Pab6r46CEc2ixGR0hmuOdbXyGganHh1huBHiDrewT1iOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNy4ETHA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNy4ETHA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D4DC433F1;
	Wed, 31 Jan 2024 09:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706692092;
	bh=Z6aHuGxlnVt8/83lAwk2OMBYzq6b65VMszniWGteeWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jNy4ETHAt/i43IQPTZCpK5/ypWnDKaospKEJ7dWK70abaA17P/pffd9+ecxLf+lbb
	 hl9FXMZCnnXdrVBuxhysMWN6dP4EBmUn5txqd+jHyAo3GuSI3iWYNIvfGDZFiEnmv1
	 MhlSzFaMNHoGHP3teLT899QXuZFMRSBbnQ60X7m0FfH39Dh/is/CWHsh/ED9Xz1bPv
	 PnQGAd2KkqmdJC5WGSDxtfM6GSX7Lk7UTge8u3BVbxoUW3Z/E40k2ya1i21/CSbTTR
	 c6RO+brDGjn3fsCqD1vlbWqhCExP6vSrUIhpdenwQaRKXanMHJXeQwHoDQAgs+mGBD
	 qu88gInjSDsJQ==
Date: Wed, 31 Jan 2024 17:08:04 +0800
From: Geliang Tang <geliang@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Subject: Re: Fwd: [PATCH bpf-next v17 11/14] bpf, net: switch to dynamic
 registration
Message-ID: <ZboN9HLRTqbG7/fA@t480>
References: <4a617858-30d9-40a6-a00a-d0e4384f6227@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a617858-30d9-40a6-a00a-d0e4384f6227@kernel.org>

On Tue, Jan 30, 2024 at 10:45:48AM +0100, Matthieu Baerts wrote:
> Hi Geliang,
> 
> This is just to let you know that I had to modify two commits you made
> to sync with upstream changes (see the patch below):
> 
> - a93c47792fc3: conflict in t/mptcp-add-bpf_mptcp_sched_ops
> - 8ac5b9528258: mptcp: bpf: adapt code to match upstream changes
> - ebd80ac09e97: conflict in t/bpf-Add-bpf_mptcp_sched_kfunc_set
> 
> Please see the new version of these two commits from our 'export' branch:
> 
> ff544a232510 ("bpf: Add bpf_mptcp_sched_ops")
> 66dfa335e74b ("bpf: Add bpf_mptcp_sched_kfunc_set")
> 
> Do you mind checking that everything is OK for you, please?

Thanks Matt,

All mptcp bpf tests passed in docker with my commit "[virtme-docker,v2]
tests: add bpftests support" on my side.

But got a new failure:

# Failed to load bpf_testmod.ko into the kernel: -22

It looks like register_bpf_struct_ops() in bpf_testmod_init() in
bpf_testmod/bpf_testmod.c failed. I'll try to fix it.

-Geliang

> 
> Cheers,
> Matt
> 
> 
> -------- Forwarded Message --------
> Subject: [PATCH bpf-next v17 11/14] bpf, net: switch to dynamic registration
> Date: Fri, 19 Jan 2024 14:50:02 -0800
> From: thinker.li@gmail.com
> To: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
> song@kernel.org, kernel-team@meta.com, andrii@kernel.org, drosen@google.com
> CC: sinquersw@gmail.com, kuifeng@meta.com, Kui-Feng Lee
> <thinker.li@gmail.com>, netdev@vger.kernel.org
> 
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Replace the static list of struct_ops types with per-btf struct_ops_tab to
> enable dynamic registration.
> 
> Both bpf_dummy_ops and bpf_tcp_ca now utilize the registration function
> instead of being listed in bpf_struct_ops_types.h.
> 
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---
>  include/linux/bpf.h               |  33 +++++++---
>  include/linux/btf.h               |  12 ++++
>  kernel/bpf/bpf_struct_ops.c       | 100 ++++--------------------------
>  kernel/bpf/bpf_struct_ops_types.h |  12 ----
>  kernel/bpf/btf.c                  |  84 +++++++++++++++++++++++--
>  net/bpf/bpf_dummy_struct_ops.c    |  11 +++-
>  net/ipv4/bpf_tcp_ca.c             |  12 +++-
>  7 files changed, 146 insertions(+), 118 deletions(-)
>  delete mode 100644 kernel/bpf/bpf_struct_ops_types.h
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 90f78f04e139..085070ea3021 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1700,10 +1700,22 @@ struct bpf_struct_ops_common_value {
>  	enum bpf_struct_ops_state state;
>  };
>  +/* This macro helps developer to register a struct_ops type and generate
> + * type information correctly. Developers should use this macro to register
> + * a struct_ops type instead of calling __register_bpf_struct_ops()
> directly.
> + */
> +#define register_bpf_struct_ops(st_ops, type)				\
> +	({								\
> +		struct bpf_struct_ops_##type {				\
> +			struct bpf_struct_ops_common_value common;	\
> +			struct type data ____cacheline_aligned_in_smp;	\
> +		};							\
> +		BTF_TYPE_EMIT(struct bpf_struct_ops_##type);		\
> +		__register_bpf_struct_ops(st_ops);			\
> +	})
> +
>  #if defined(CONFIG_BPF_JIT) && defined(CONFIG_BPF_SYSCALL)
>  #define BPF_MODULE_OWNER ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
> -const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf,
> u32 type_id);
> -void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log);
>  bool bpf_struct_ops_get(const void *kdata);
>  void bpf_struct_ops_put(const void *kdata);
>  int bpf_struct_ops_map_sys_lookup_elem(struct bpf_map *map, void *key,
> @@ -1745,16 +1757,11 @@ struct bpf_dummy_ops {
>  int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr
> *kattr,
>  			    union bpf_attr __user *uattr);
>  #endif
> +int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
> +			     struct btf *btf,
> +			     struct bpf_verifier_log *log);
>  void bpf_map_struct_ops_info_fill(struct bpf_map_info *info, struct
> bpf_map *map);
>  #else
> -static inline const struct bpf_struct_ops_desc
> *bpf_struct_ops_find(struct btf *btf, u32 type_id)
> -{
> -	return NULL;
> -}
> -static inline void bpf_struct_ops_init(struct btf *btf,
> -				       struct bpf_verifier_log *log)
> -{
> -}
>  static inline bool bpf_try_module_get(const void *data, struct module
> *owner)
>  {
>  	return try_module_get(owner);
> @@ -1792,6 +1799,12 @@ static inline int
> bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
>  static inline void bpf_trampoline_unlink_cgroup_shim(struct bpf_prog *prog)
>  {
>  }
> +static inline int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc
> *st_ops_desc,
> +					   struct btf *btf,
> +					   struct bpf_verifier_log *log) {
> +	return -EOPNOTSUPP;
> +}
> +
>  #endif
>   struct bpf_array {
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 1d852dad7473..714801a382fd 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -496,6 +496,7 @@ static inline void *btf_id_set8_contains(const
> struct btf_id_set8 *set, u32 id)
>  }
>   struct bpf_verifier_log;
> +struct bpf_struct_ops;
>   #ifdef CONFIG_BPF_SYSCALL
>  const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
> @@ -520,6 +521,9 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log,
> const struct btf *btf,
>  int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum
> bpf_prog_type prog_type);
>  bool btf_types_are_same(const struct btf *btf1, u32 id1,
>  			const struct btf *btf2, u32 id2);
> +int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops);
> +const struct bpf_struct_ops_desc *bpf_struct_ops_find_value(struct btf
> *btf, u32 value_id);
> +const struct bpf_struct_ops_desc *bpf_struct_ops_find(struct btf *btf,
> u32 type_id);
>  #else
>  static inline const struct btf_type *btf_type_by_id(const struct btf *btf,
>  						    u32 type_id)
> @@ -572,6 +576,14 @@ static inline bool btf_types_are_same(const struct
> btf *btf1, u32 id1,
>  {
>  	return false;
>  }
> +static inline int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
> +{
> +	return -ENOTSUPP;
> +}
> +static inline const struct bpf_struct_ops_desc
> *bpf_struct_ops_find(struct btf *btf, u32 type_id)
> +{
> +	return NULL;
> +}
>  #endif
>   static inline bool btf_type_is_struct_ptr(struct btf *btf, const
> struct btf_type *t)
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 30ab34fab0f8..defc052e4622 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -62,35 +62,6 @@ static DEFINE_MUTEX(update_mutex);
>  #define VALUE_PREFIX "bpf_struct_ops_"
>  #define VALUE_PREFIX_LEN (sizeof(VALUE_PREFIX) - 1)
>  -/* bpf_struct_ops_##_name (e.g. bpf_struct_ops_tcp_congestion_ops) is
> - * the map's value exposed to the userspace and its btf-type-id is
> - * stored at the map->btf_vmlinux_value_type_id.
> - *
> - */
> -#define BPF_STRUCT_OPS_TYPE(_name)				\
> -extern struct bpf_struct_ops bpf_##_name;			\
> -								\
> -struct bpf_struct_ops_##_name {					\
> -	struct bpf_struct_ops_common_value common;		\
> -	struct _name data ____cacheline_aligned_in_smp;		\
> -};
> -#include "bpf_struct_ops_types.h"
> -#undef BPF_STRUCT_OPS_TYPE
> -
> -enum {
> -#define BPF_STRUCT_OPS_TYPE(_name) BPF_STRUCT_OPS_TYPE_##_name,
> -#include "bpf_struct_ops_types.h"
> -#undef BPF_STRUCT_OPS_TYPE
> -	__NR_BPF_STRUCT_OPS_TYPE,
> -};
> -
> -static struct bpf_struct_ops_desc bpf_struct_ops[] = {
> -#define BPF_STRUCT_OPS_TYPE(_name)				\
> -	[BPF_STRUCT_OPS_TYPE_##_name] = { .st_ops = &bpf_##_name },
> -#include "bpf_struct_ops_types.h"
> -#undef BPF_STRUCT_OPS_TYPE
> -};
> -
>  const struct bpf_verifier_ops bpf_struct_ops_verifier_ops = {
>  };
>  @@ -145,9 +116,9 @@ static bool is_valid_value_type(struct btf *btf,
> s32 value_id,
>  	return true;
>  }
>  -static void bpf_struct_ops_desc_init(struct bpf_struct_ops_desc
> *st_ops_desc,
> -				     struct btf *btf,
> -				     struct bpf_verifier_log *log)
> +int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
> +			     struct btf *btf,
> +			     struct bpf_verifier_log *log)
>  {
>  	struct bpf_struct_ops *st_ops = st_ops_desc->st_ops;
>  	const struct btf_member *member;
> @@ -161,7 +132,7 @@ static void bpf_struct_ops_desc_init(struct
> bpf_struct_ops_desc *st_ops_desc,
>  	    sizeof(value_name)) {
>  		pr_warn("struct_ops name %s is too long\n",
>  			st_ops->name);
> -		return;
> +		return -EINVAL;
>  	}
>  	sprintf(value_name, "%s%s", VALUE_PREFIX, st_ops->name);
>  @@ -170,13 +141,13 @@ static void bpf_struct_ops_desc_init(struct
> bpf_struct_ops_desc *st_ops_desc,
>  	if (type_id < 0) {
>  		pr_warn("Cannot find struct %s in %s\n",
>  			st_ops->name, btf_get_name(btf));
> -		return;
> +		return -EINVAL;
>  	}
>  	t = btf_type_by_id(btf, type_id);
>  	if (btf_type_vlen(t) > BPF_STRUCT_OPS_MAX_NR_MEMBERS) {
>  		pr_warn("Cannot support #%u members in struct %s\n",
>  			btf_type_vlen(t), st_ops->name);
> -		return;
> +		return -EINVAL;
>  	}
>   	value_id = btf_find_by_name_kind(btf, value_name,
> @@ -184,10 +155,10 @@ static void bpf_struct_ops_desc_init(struct
> bpf_struct_ops_desc *st_ops_desc,
>  	if (value_id < 0) {
>  		pr_warn("Cannot find struct %s in %s\n",
>  			value_name, btf_get_name(btf));
> -		return;
> +		return -EINVAL;
>  	}
>  	if (!is_valid_value_type(btf, value_id, t, value_name))
> -		return;
> +		return -EINVAL;
>   	for_each_member(i, t, member) {
>  		const struct btf_type *func_proto;
> @@ -196,13 +167,13 @@ static void bpf_struct_ops_desc_init(struct
> bpf_struct_ops_desc *st_ops_desc,
>  		if (!*mname) {
>  			pr_warn("anon member in struct %s is not supported\n",
>  				st_ops->name);
> -			break;
> +			return -EOPNOTSUPP;
>  		}
>   		if (__btf_member_bitfield_size(t, member)) {
>  			pr_warn("bit field member %s in struct %s is not supported\n",
>  				mname, st_ops->name);
> -			break;
> +			return -EOPNOTSUPP;
>  		}
>   		func_proto = btf_type_resolve_func_ptr(btf,
> @@ -214,7 +185,7 @@ static void bpf_struct_ops_desc_init(struct
> bpf_struct_ops_desc *st_ops_desc,
>  					   &st_ops->func_models[i])) {
>  			pr_warn("Error in parsing func ptr %s in struct %s\n",
>  				mname, st_ops->name);
> -			break;
> +			return -EINVAL;
>  		}
>  	}
>  @@ -222,6 +193,7 @@ static void bpf_struct_ops_desc_init(struct
> bpf_struct_ops_desc *st_ops_desc,
>  		if (st_ops->init(btf)) {
>  			pr_warn("Error in init bpf_struct_ops %s\n",
>  				st_ops->name);
> +			return -EINVAL;
>  		} else {
>  			st_ops_desc->type_id = type_id;
>  			st_ops_desc->type = t;
> @@ -230,54 +202,8 @@ static void bpf_struct_ops_desc_init(struct
> bpf_struct_ops_desc *st_ops_desc,
>  								 value_id);
>  		}
>  	}
> -}
>  -void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
> -{
> -	struct bpf_struct_ops_desc *st_ops_desc;
> -	u32 i;
> -
> -	/* Ensure BTF type is emitted for "struct bpf_struct_ops_##_name" */
> -#define BPF_STRUCT_OPS_TYPE(_name) BTF_TYPE_EMIT(struct
> bpf_struct_ops_##_name);
> -#include "bpf_struct_ops_types.h"
> -#undef BPF_STRUCT_OPS_TYPE
> -
> -	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
> -		st_ops_desc = &bpf_struct_ops[i];
> -		bpf_struct_ops_desc_init(st_ops_desc, btf, log);
> -	}
> -}
> -
> -static const struct bpf_struct_ops_desc *
> -bpf_struct_ops_find_value(struct btf *btf, u32 value_id)
> -{
> -	unsigned int i;
> -
> -	if (!value_id || !btf)
> -		return NULL;
> -
> -	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
> -		if (bpf_struct_ops[i].value_id == value_id)
> -			return &bpf_struct_ops[i];
> -	}
> -
> -	return NULL;
> -}
> -
> -const struct bpf_struct_ops_desc *
> -bpf_struct_ops_find(struct btf *btf, u32 type_id)
> -{
> -	unsigned int i;
> -
> -	if (!type_id || !btf)
> -		return NULL;
> -
> -	for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
> -		if (bpf_struct_ops[i].type_id == type_id)
> -			return &bpf_struct_ops[i];
> -	}
> -
> -	return NULL;
> +	return 0;
>  }
>   static int bpf_struct_ops_map_get_next_key(struct bpf_map *map, void *key,
> diff --git a/kernel/bpf/bpf_struct_ops_types.h
> b/kernel/bpf/bpf_struct_ops_types.h
> deleted file mode 100644
> index 5678a9ddf817..000000000000
> --- a/kernel/bpf/bpf_struct_ops_types.h
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/* internal file - do not include directly */
> -
> -#ifdef CONFIG_BPF_JIT
> -#ifdef CONFIG_NET
> -BPF_STRUCT_OPS_TYPE(bpf_dummy_ops)
> -#endif
> -#ifdef CONFIG_INET
> -#include <net/tcp.h>
> -BPF_STRUCT_OPS_TYPE(tcp_congestion_ops)
> -#endif
> -#endif
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 3fa84c44b882..78eacd4aa362 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -19,6 +19,7 @@
>  #include <linux/bpf_verifier.h>
>  #include <linux/btf.h>
>  #include <linux/btf_ids.h>
> +#include <linux/bpf.h>
>  #include <linux/bpf_lsm.h>
>  #include <linux/skmsg.h>
>  #include <linux/perf_event.h>
> @@ -5792,8 +5793,6 @@ struct btf *btf_parse_vmlinux(void)
>  	/* btf_parse_vmlinux() runs under bpf_verifier_lock */
>  	bpf_ctx_convert.t = btf_type_by_id(btf, bpf_ctx_convert_btf_id[0]);
>  -	bpf_struct_ops_init(btf, log);
> -
>  	refcount_set(&btf->refcnt, 1);
>   	err = btf_alloc_id(btf);
> @@ -8489,10 +8488,11 @@ bool btf_type_ids_nocast_alias(struct
> bpf_verifier_log *log,
>  }
>   static int
> -btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops)
> +btf_add_struct_ops(struct btf *btf, struct bpf_struct_ops *st_ops,
> +		   struct bpf_verifier_log *log)
>  {
>  	struct btf_struct_ops_tab *tab, *new_tab;
> -	int i;
> +	int i, err;
>   	if (!btf)
>  		return -ENOENT;
> @@ -8529,7 +8529,83 @@ btf_add_struct_ops(struct btf *btf, struct
> bpf_struct_ops *st_ops)
>   	tab->ops[btf->struct_ops_tab->cnt].st_ops = st_ops;
>  +	err = bpf_struct_ops_desc_init(&tab->ops[btf->struct_ops_tab->cnt],
> btf, log);
> +	if (err)
> +		return err;
> +
>  	btf->struct_ops_tab->cnt++;
>   	return 0;
>  }
> +
> +const struct bpf_struct_ops_desc *
> +bpf_struct_ops_find_value(struct btf *btf, u32 value_id)
> +{
> +	const struct bpf_struct_ops_desc *st_ops_list;
> +	unsigned int i;
> +	u32 cnt;
> +
> +	if (!value_id)
> +		return NULL;
> +	if (!btf->struct_ops_tab)
> +		return NULL;
> +
> +	cnt = btf->struct_ops_tab->cnt;
> +	st_ops_list = btf->struct_ops_tab->ops;
> +	for (i = 0; i < cnt; i++) {
> +		if (st_ops_list[i].value_id == value_id)
> +			return &st_ops_list[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +const struct bpf_struct_ops_desc *
> +bpf_struct_ops_find(struct btf *btf, u32 type_id)
> +{
> +	const struct bpf_struct_ops_desc *st_ops_list;
> +	unsigned int i;
> +	u32 cnt;
> +
> +	if (!type_id)
> +		return NULL;
> +	if (!btf->struct_ops_tab)
> +		return NULL;
> +
> +	cnt = btf->struct_ops_tab->cnt;
> +	st_ops_list = btf->struct_ops_tab->ops;
> +	for (i = 0; i < cnt; i++) {
> +		if (st_ops_list[i].type_id == type_id)
> +			return &st_ops_list[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +int __register_bpf_struct_ops(struct bpf_struct_ops *st_ops)
> +{
> +	struct bpf_verifier_log *log;
> +	struct btf *btf;
> +	int err = 0;
> +
> +	btf = btf_get_module_btf(st_ops->owner);
> +	if (!btf)
> +		return -EINVAL;
> +
> +	log = kzalloc(sizeof(*log), GFP_KERNEL | __GFP_NOWARN);
> +	if (!log) {
> +		err = -ENOMEM;
> +		goto errout;
> +	}
> +
> +	log->level = BPF_LOG_KERNEL;
> +
> +	err = btf_add_struct_ops(btf, st_ops, log);
> +
> +errout:
> +	kfree(log);
> +	btf_put(btf);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(__register_bpf_struct_ops);
> diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
> index ba2c58dba2da..02de71719aed 100644
> --- a/net/bpf/bpf_dummy_struct_ops.c
> +++ b/net/bpf/bpf_dummy_struct_ops.c
> @@ -7,7 +7,7 @@
>  #include <linux/bpf.h>
>  #include <linux/btf.h>
>  -extern struct bpf_struct_ops bpf_bpf_dummy_ops;
> +static struct bpf_struct_ops bpf_bpf_dummy_ops;
>   /* A common type for test_N with return value in bpf_dummy_ops */
>  typedef int (*dummy_ops_test_ret_fn)(struct bpf_dummy_ops_state *state,
> ...);
> @@ -256,7 +256,7 @@ static struct bpf_dummy_ops __bpf_bpf_dummy_ops = {
>  	.test_sleepable = bpf_dummy_test_sleepable,
>  };
>  -struct bpf_struct_ops bpf_bpf_dummy_ops = {
> +static struct bpf_struct_ops bpf_bpf_dummy_ops = {
>  	.verifier_ops = &bpf_dummy_verifier_ops,
>  	.init = bpf_dummy_init,
>  	.check_member = bpf_dummy_ops_check_member,
> @@ -265,4 +265,11 @@ struct bpf_struct_ops bpf_bpf_dummy_ops = {
>  	.unreg = bpf_dummy_unreg,
>  	.name = "bpf_dummy_ops",
>  	.cfi_stubs = &__bpf_bpf_dummy_ops,
> +	.owner = THIS_MODULE,
>  };
> +
> +static int __init bpf_dummy_struct_ops_init(void)
> +{
> +	return register_bpf_struct_ops(&bpf_bpf_dummy_ops, bpf_dummy_ops);
> +}
> +late_initcall(bpf_dummy_struct_ops_init);
> diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
> index dffd8828079b..8e7716256d3c 100644
> --- a/net/ipv4/bpf_tcp_ca.c
> +++ b/net/ipv4/bpf_tcp_ca.c
> @@ -12,7 +12,7 @@
>  #include <net/bpf_sk_storage.h>
>   /* "extern" is to avoid sparse warning.  It is only used in
> bpf_struct_ops.c. */
> -extern struct bpf_struct_ops bpf_tcp_congestion_ops;
> +static struct bpf_struct_ops bpf_tcp_congestion_ops;
>   static u32 unsupported_ops[] = {
>  	offsetof(struct tcp_congestion_ops, get_info),
> @@ -345,7 +345,7 @@ static struct tcp_congestion_ops
> __bpf_ops_tcp_congestion_ops = {
>  	.release = __bpf_tcp_ca_release,
>  };
>  -struct bpf_struct_ops bpf_tcp_congestion_ops = {
> +static struct bpf_struct_ops bpf_tcp_congestion_ops = {
>  	.verifier_ops = &bpf_tcp_ca_verifier_ops,
>  	.reg = bpf_tcp_ca_reg,
>  	.unreg = bpf_tcp_ca_unreg,
> @@ -356,10 +356,16 @@ struct bpf_struct_ops bpf_tcp_congestion_ops = {
>  	.validate = bpf_tcp_ca_validate,
>  	.name = "tcp_congestion_ops",
>  	.cfi_stubs = &__bpf_ops_tcp_congestion_ops,
> +	.owner = THIS_MODULE,
>  };
>   static int __init bpf_tcp_ca_kfunc_init(void)
>  {
> -	return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> &bpf_tcp_ca_kfunc_set);
> +	int ret;
> +
> +	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> &bpf_tcp_ca_kfunc_set);
> +	ret = ret ?: register_bpf_struct_ops(&bpf_tcp_congestion_ops,
> tcp_congestion_ops);
> +
> +	return ret;
>  }
>  late_initcall(bpf_tcp_ca_kfunc_init);
> -- 
> 2.34.1
> 
