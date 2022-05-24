Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD7B629
	for <mptcp@lists.linux.dev>; Tue, 24 May 2022 01:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653354157; x=1684890157;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=dAUbU1ue3iAiNVy+OhOU+uTYL2lbvglYL6ySgRHCvDk=;
  b=cVKBAjv1MqlSp48TCmdugkfA6DEhapxaTKP0I+ZUkLPv8/QGieHhxTWe
   m0d2UH9lgoS8ZLe4HhP0wq62SzFAqQVXzgbqUhG6KJia1NTfxHeUM0gGW
   yKlWdBzHRLOTUJ6p04JmYmI6PGho/foCuROnGXYWZQcrkUgO7KEVCvasG
   KJ7Xb1wkrHHEflmrJ4KWwFp+Y+ZTwCGDiK0IhaJ/tEuUxLdPqE45KtLAe
   7XI4jrzlElEFQHhsWtRnKR/HSIhpFgl+IKqtmv1bdz9hG3YKTE0WIu/Ta
   KZ12bEjfvpvftM6zo38LQeagS0A8ppkq1EASMF6t2WPRT9yrRFoJ6sRfn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273393461"
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; 
   d="scan'208";a="273393461"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 18:02:36 -0700
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; 
   d="scan'208";a="572384171"
Received: from samuelal-mobl.amr.corp.intel.com ([10.212.199.128])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 18:02:36 -0700
Date: Mon, 23 May 2022 18:02:36 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 5/5] Squash to "selftests/bpf: add bpf_first
 scheduler"
In-Reply-To: <94abb5c4207ee3fc0827c77816648ad37dccf5d0.1653305364.git.geliang.tang@suse.com>
Message-ID: <b475a6e4-c734-e78c-bf90-19601686aac6@linux.intel.com>
References: <cover.1653305364.git.geliang.tang@suse.com> <94abb5c4207ee3fc0827c77816648ad37dccf5d0.1653305364.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 23 May 2022, Geliang Tang wrote:

> Add set_bit() helper and use new get_subflow API.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> tools/testing/selftests/bpf/bpf_tcp_helpers.h       | 11 +++++++++++
> tools/testing/selftests/bpf/progs/mptcp_bpf_first.c | 10 ++++++----
> 2 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/bpf_tcp_helpers.h b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> index cb3db7ea36b9..9c7d33e106a4 100644
> --- a/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> +++ b/tools/testing/selftests/bpf/bpf_tcp_helpers.h
> @@ -260,4 +260,15 @@ struct mptcp_sock {
> 	char		ca_name[TCP_CA_NAME_MAX];
> } __attribute__((preserve_access_index));
>
> +#define _AC(X,Y)	(X##Y)
> +#define UL(x)		(_AC(x, UL))
> +
> +static inline void set_bit(unsigned int nr, volatile unsigned long *addr)
> +{
> +        unsigned long *p = ((unsigned long *)addr) + (nr / sizeof(unsigned long));
> +        unsigned long mask = UL(1) << (nr % sizeof(unsigned long));
> +
> +        *p  |= mask;
> +}
> +
> #endif
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> index fd67b5f42964..e5dc53965642 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_first.c
> @@ -16,11 +16,13 @@ void BPF_PROG(mptcp_sched_first_release, const struct mptcp_sock *msk)
> {
> }
>
> -void BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
> -		    bool reinject, struct mptcp_sched_data *data)
> +unsigned long BPF_STRUCT_OPS(bpf_first_get_subflow, const struct mptcp_sock *msk,
> +			     bool reinject, struct mptcp_sched_data *data)
> {
> -	data->sock = msk->first;
> -	data->call_again = 0;
> +	unsigned long bitmap = 0;
> +
> +	set_bit(0, &bitmap);
> +	return bitmap;

It might be more realistic to return the first non-backup subflow (or 
first backup if there are only backup subflows). Do you think that would 
be better as a replacement for this test or as an additional test?

- Mat

> }
>
> SEC(".struct_ops")
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
