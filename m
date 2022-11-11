Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730F67E
	for <mptcp@lists.linux.dev>; Fri, 11 Nov 2022 00:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668126565; x=1699662565;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DEU8R0fEE4d8ov8y6OBPeayVRXsARrh5fU30kCfudWY=;
  b=Zh+4x15g5t8pe4UEXtOMg3ZSmB1zaItWixxFp8ORyjdi2DeyCa6CZ0Oh
   NanzI05h+pbt5btM3qDW88vRtKW1tU5zk6IxIQasD358A0GHB5UV7IMZ4
   1iHgKpzT74FcbcoebjkztySs97kHX8fmza+LXsp6x4mPDL8PAbN5c7rZ2
   jKBfcAm3gY3XajhgqxGDMTqdaIf0VGfLG6TTMVlv1kV0x8/t8+bHgcQYO
   bAIveqKrbzqTNjewBcKLzqxNN/28fS4UD8TYkNu9pALo8KvhuLUnqIQFx
   OXus5t1JCqw3iQV2r71QDpeXBRsRXwSzwRZ1X+wBhusC0LKVKhnr+AYSV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="294835714"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="294835714"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 16:29:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="706353184"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="706353184"
Received: from ssamaraj-mobl1.amr.corp.intel.com ([10.209.53.250])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 16:29:23 -0800
Date: Thu, 10 Nov 2022 16:29:23 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v18 09/15] Squash to "selftests/bpf: Add bpf_rr
 scheduler"
In-Reply-To: <bc0bb04ee334a2a38c7e5603405c16d6af4fff5f.1667897099.git.geliang.tang@suse.com>
Message-ID: <fcb034ce-ac54-b874-411e-e6156fa5b7bc@linux.intel.com>
References: <cover.1667897099.git.geliang.tang@suse.com> <bc0bb04ee334a2a38c7e5603405c16d6af4fff5f.1667897099.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 8 Nov 2022, Geliang Tang wrote:

> Use new API.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

After patch 1 is updated, I think the series is looking good up to this 
patch.

- Mat


> ---
> tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 10 +++++++++-
> 1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
> index ce4e98f83e43..e101428e5906 100644
> --- a/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
> +++ b/tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c
> @@ -16,8 +16,14 @@ void BPF_PROG(mptcp_sched_rr_release, const struct mptcp_sock *msk)
> {
> }
>
> -void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
> +void BPF_STRUCT_OPS(bpf_rr_data_init, const struct mptcp_sock *msk,
> 		    struct mptcp_sched_data *data)
> +{
> +	mptcp_sched_data_set_contexts(msk, data);
> +}
> +
> +int BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
> +		   struct mptcp_sched_data *data)
> {
> 	int nr = 0;
>
> @@ -35,12 +41,14 @@ void BPF_STRUCT_OPS(bpf_rr_get_subflow, const struct mptcp_sock *msk,
> 	}
>
> 	mptcp_subflow_set_scheduled(data->contexts[nr], true);
> +	return 0;
> }
>
> SEC(".struct_ops")
> struct mptcp_sched_ops rr = {
> 	.init		= (void *)mptcp_sched_rr_init,
> 	.release	= (void *)mptcp_sched_rr_release,
> +	.data_init	= (void *)bpf_rr_data_init,
> 	.get_subflow	= (void *)bpf_rr_get_subflow,
> 	.name		= "bpf_rr",
> };
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
