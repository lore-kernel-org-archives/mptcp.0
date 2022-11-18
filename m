Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81371A464
	for <mptcp@lists.linux.dev>; Fri, 18 Nov 2022 18:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668795962; x=1700331962;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ivthouUOAclsr6MSOuAcv2IbVVH1TK5egp+/siyb14Y=;
  b=LGozP5KNmMjQAox3V7E1caxmWGetFLN5oEpoArIeL1EeiDn9U75CFoKc
   jxiGrvi80iib0rtdGDgby/TIZEKh4xvTeDVEtR8sIGgUw1ofnHsejwkzs
   hfNwZwEh0hMewbfkV4yvl43V46Q2dK5QGlhmvVcDkEhCaZYGSROhgz71z
   mBgQG8POSu/5qijJqIZ1tLxhIP/wiJqkTEqHu1q/H1DX3Hvzoe+Jicv1+
   i9W3SR3Sb+0IhTn2nvKjIHvwsO6M7sVXHtHcMJfPHkTKly9RhDXU1Ufgm
   pun6axbueva/M2g/CrpA4q5ZcMc3sZVRqpMIK+ZLWZLcqiMjxM0NDwBTN
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="313218851"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="313218851"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 10:26:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="782737060"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="782737060"
Received: from kwells1-mobl1.amr.corp.intel.com ([10.212.140.181])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 10:26:01 -0800
Date: Fri, 18 Nov 2022 10:26:01 -0800 (PST)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>
cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v19 3/9] mptcp: add sched_data_set_contexts
 helper
In-Reply-To: <cb2a531a-02bf-9c80-5385-e02d9e61c368@tessares.net>
Message-ID: <1d505549-92ba-6b80-0a10-95d26d18fcb4@linux.intel.com>
References: <cover.1668151131.git.geliang.tang@suse.com> <5ad9715e09a2acc245c7a504b086d6ff33b40a7e.1668151131.git.geliang.tang@suse.com> <cb2a531a-02bf-9c80-5385-e02d9e61c368@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 18 Nov 2022, Matthieu Baerts wrote:

> Hi Geliang, Mat,
>
> On 11/11/2022 08:47, Geliang Tang wrote:
>> Add a new helper mptcp_sched_data_set_contexts() to set the subflow
>> pointers array in struct mptcp_sched_data. It will be invoked by the
>> BPF schedulers to export the subflow pointers to the BPF contexts.
>
> I have an issue with the CI and this commit: it adds a new helper which
> is not used before before "selftests/bpf: Add mptcp sched structs" commit.
>
> We then have this warning when compiling with W=1:
>
>  $ make W=1 net/mptcp/sched.o
>  net/mptcp/sched.c:97:6: warning: symbol
> 'mptcp_sched_data_set_contexts' was not declared. Should it be static?
>
> I'm not sure what to do:
> - modify the script to parse error and ignore it (I would prefer to
> avoid case per case)
> - move the commit after "selftests/bpf: Add mptcp sched structs" and
> directly use it (extern + kfunc)
> - squash it elsewhere?
> - add a patch like that:
>
> ------------------- 8< -------------------
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 0d7c73e9562e..e9b1ff932a3b 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -94,6 +94,8 @@ void mptcp_subflow_set_scheduled(struct
> mptcp_subflow_context *subflow,
>        WRITE_ONCE(subflow->scheduled, scheduled);
> }
>
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Wmissing-prototypes"
> void mptcp_sched_data_set_contexts(const struct mptcp_sock *msk,
>                                   struct mptcp_sched_data *data)
> {
> @@ -112,3 +114,4 @@ void mptcp_sched_data_set_contexts(const struct
> mptcp_sock *msk,
>        for (; i < MPTCP_SUBFLOWS_MAX; i++)
>                data->contexts[i] = NULL;
> }
> +#pragma GCC diagnostic pop
> ------------------- 8< -------------------

One more option:

Add a declaration in net/mptcp/protocol.h


>
> But well... :-)
>
> I suggest to apply this patch for the moment to avoid errors with all
> new patches and check later which solution to use.

This is fine with me, if you'd rather wait for a squash-to patch.

--
Mat Martineau
Intel
