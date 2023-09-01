Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5524AC8D4
	for <mptcp@lists.linux.dev>; Fri,  1 Sep 2023 23:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FB1C433C7;
	Fri,  1 Sep 2023 23:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693612437;
	bh=u4Nsa21l4sANu94Q9UcmuxS66S04PKkuOkZkW2RQ3rQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=IWHJH7RNa8Ok6XZ0H70pB3Gg4OKMwP4P/i9tEk/P82KzVANs0mkPXJ0E19fFhRlnx
	 28lkqbD2Xrp8nbN+xgWDaCK88I/0/VzfqbUhe50qGujDLJhjAtzuE79xyA9ZUu2GfB
	 LQn6eI5JTbtz+mYnrTOZaki4LWQEAoieT2U6JsSWE2QSfmzoS1orixRNAgp1Wb1XHC
	 jc0uxq4Ul4y3LrgJsfeyuJsuv1W7uE8p4HT6Eft98tqGVowOG9lCZECo7puPRuB8bF
	 +eultN5yqXyWWGjmofJAvn5zPny4BFw/KgXudmAKb1rZ3R8rv2feb2ZsQ5JxGlm4U4
	 LPIdAHb/Y9ziQ==
Date: Fri, 1 Sep 2023 16:53:56 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [RFC mptcp-next v2 2/2] mptcp: add bpf_burst set/get params
In-Reply-To: <486891cb494ba4e9eeb02b6e220ca670dbc80866.1692788531.git.geliang.tang@suse.com>
Message-ID: <ee098f0f-89ef-ba84-c09b-e93a770ab264@kernel.org>
References: <cover.1692788531.git.geliang.tang@suse.com> <486891cb494ba4e9eeb02b6e220ca670dbc80866.1692788531.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 23 Aug 2023, Geliang Tang wrote:

> This patch implements the set/get params interfaces for bpf_burst
> scheduler.
>
> Export bpf_sk_storage_lookup(), use it to get bpf_local_storage_data
> from sk->sk_bpf_storage, then get or set its params ptr->snd_burst.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> include/net/bpf_sk_storage.h |  7 +++++++
> net/core/bpf_sk_storage.c    |  2 +-
> net/mptcp/sched.c            | 39 ++++++++++++++++++++++++++++++++++++
> 3 files changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/bpf_sk_storage.h b/include/net/bpf_sk_storage.h
> index 2926f1f00d65..805142d59d02 100644
> --- a/include/net/bpf_sk_storage.h
> +++ b/include/net/bpf_sk_storage.h
> @@ -37,6 +37,8 @@ int bpf_sk_storage_diag_put(struct bpf_sk_storage_diag *diag,
> 			    struct sock *sk, struct sk_buff *skb,
> 			    int stg_array_type,
> 			    unsigned int *res_diag_size);
> +struct bpf_local_storage_data *
> +bpf_sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_lockit);
> #else
> static inline int bpf_sk_storage_clone(const struct sock *sk,
> 				       struct sock *newsk)
> @@ -58,6 +60,11 @@ static inline int bpf_sk_storage_diag_put(struct bpf_sk_storage_diag *diag,
> {
> 	return 0;
> }
> +struct bpf_local_storage_data *
> +bpf_sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_lockit)
> +{
> +	return NULL;
> +}
> #endif
>
> #endif /* _BPF_SK_STORAGE_H */
> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index cca7594be92e..1c023f65017f 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -17,7 +17,7 @@
>
> DEFINE_BPF_STORAGE_CACHE(sk_cache);
>
> -static struct bpf_local_storage_data *
> +struct bpf_local_storage_data *
> bpf_sk_storage_lookup(struct sock *sk, struct bpf_map *map, bool cacheit_lockit)
> {
> 	struct bpf_local_storage *sk_storage;
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index c78ed61290d2..067df28899a6 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -11,6 +11,7 @@
> #include <linux/list.h>
> #include <linux/rculist.h>
> #include <linux/spinlock.h>
> +#include <net/bpf_sk_storage.h>
> #include "protocol.h"
>
> static DEFINE_SPINLOCK(mptcp_sched_list_lock);
> @@ -202,18 +203,56 @@ mptcp_subflow_ctx_by_pos(const struct mptcp_sched_data *data, unsigned int pos)
>
> int mptcp_sched_get_params(struct mptcp_sock *msk)
> {
> +	struct sock *sk = (struct sock *)msk;
> +
> 	if (msk->sched == &mptcp_sched_default)
> 		return msk->snd_burst;
>
> +	if (sk->sk_bpf_storage && sk->sk_bpf_storage->smap &&
> +	    !strcmp(sk->sk_bpf_storage->smap->map.name, "mptcp_burst_map")) {
> +		struct bpf_local_storage_data *sdata;
> +
> +		sdata = bpf_sk_storage_lookup(sk, &sk->sk_bpf_storage->smap->map, true);
> +		if (sdata) {
> +			struct mptcp_burst_storage {
> +				int snd_burst;
> +			} *ptr;
> +
> +			ptr = (struct mptcp_burst_storage *)sdata->data;
> +			if (ptr)
> +				return ptr->snd_burst;
> +		}
> +	}
> +
> 	return 0;
> }

This seems very complex. Why implement it this way versus adding snd_burst 
to 'struct mptcp_sock' in bpf_tcp_helpers.h?

- Mat


>
> int mptcp_sched_set_params(struct mptcp_sock *msk, int burst)
> {
> +	struct sock *sk = (struct sock *)msk;
> +
> 	if (msk->sched == &mptcp_sched_default) {
> 		msk->snd_burst = burst;
> 		return 0;
> 	}
>
> +	if (sk->sk_bpf_storage && sk->sk_bpf_storage->smap &&
> +	    !strcmp(sk->sk_bpf_storage->smap->map.name, "mptcp_burst_map")) {
> +		struct bpf_local_storage_data *sdata;
> +
> +		sdata = bpf_sk_storage_lookup(sk, &sk->sk_bpf_storage->smap->map, true);
> +		if (sdata) {
> +			struct mptcp_burst_storage {
> +				int snd_burst;
> +			} *ptr;
> +
> +			ptr = (struct mptcp_burst_storage *)sdata->data;
> +			if (ptr) {
> +				ptr->snd_burst = burst;
> +				return 0;
> +			}
> +		}
> +	}
> +
> 	return 0;
> }
> -- 
> 2.35.3
>
>
>
