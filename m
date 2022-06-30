Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327306AA1
	for <mptcp@lists.linux.dev>; Thu, 30 Jun 2022 14:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656599642; x=1688135642;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=V08KPTdh9MK0E3cvWZ3eMlZOKA5/OS1X7QN9lhgtGzU=;
  b=mqfYDzr/eUlcpGw9+11M2vBpRGSHb+jzZ00nUjTQ9RHTF5wBxmg8n8me
   302cYCWjECpwBziAOv66IeYM5v0xUaO9rrgBhscyk+WLLS1UWCOmgzB3B
   qM2Cgee5mkd54a9n9NhqBn6qeKahHy1nftiCNpvHxlM6me66gqwXdFqC9
   Nid89g1AAxnRm8eT1Xp1KWf/fYvOpwAH0G3fsfukU9YLGXFvH7KJPE9rs
   IruW1bqpazqEdc/z68mvorR4fwpyGcMMsLdXuZym6dvV6ydB+Pmkfc+Ny
   ttxxYdlrhon5OpggnG+qIHbaZk9VgLkljxJjZqWU9XSlVkr8xXzZAtUP7
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="262162382"
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="262162382"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 07:34:01 -0700
X-IronPort-AV: E=Sophos;i="5.92,234,1650956400"; 
   d="scan'208";a="837623920"
Received: from ooadegok-mobl1.amr.corp.intel.com ([10.209.100.138])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 07:34:01 -0700
Date: Thu, 30 Jun 2022 07:34:00 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Squash to "bpf: Add bpf_mptcp_sched_ops"
In-Reply-To: <9ab93a02e7bf2ea1b2cfd40ce9e2001970d2e890.1656586148.git.geliang.tang@suse.com>
Message-ID: <cb697422-a36d-9511-4f0-a5badb4144bd@linux.intel.com>
References: <9ab93a02e7bf2ea1b2cfd40ce9e2001970d2e890.1656586148.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 30 Jun 2022, Geliang Tang wrote:

> Rename optional_ops to optional_sched_ops, rename is_optional() to
> is_optional_sched(). We may add optional_pm_ops and is_optional_pm()
> in bpf.c in the future for BPF path managers.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>

Fine to squash this, thanks Geliang.

- Mat

> ---
> net/mptcp/bpf.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
> index e86dff4272d5..a450b0521ef6 100644
> --- a/net/mptcp/bpf.c
> +++ b/net/mptcp/bpf.c
> @@ -21,7 +21,7 @@ extern struct btf *btf_vmlinux;
> static const struct btf_type *mptcp_sched_type __read_mostly;
> static u32 mptcp_sched_id;
>
> -static u32 optional_ops[] = {
> +static u32 optional_sched_ops[] = {
> 	offsetof(struct mptcp_sched_ops, init),
> 	offsetof(struct mptcp_sched_ops, release),
> };
> @@ -92,12 +92,12 @@ static int bpf_mptcp_sched_check_member(const struct btf_type *t,
> 	return 0;
> }
>
> -static bool is_optional(u32 member_offset)
> +static bool is_optional_sched(u32 member_offset)
> {
> 	unsigned int i;
>
> -	for (i = 0; i < ARRAY_SIZE(optional_ops); i++) {
> -		if (member_offset == optional_ops[i])
> +	for (i = 0; i < ARRAY_SIZE(optional_sched_ops); i++) {
> +		if (member_offset == optional_sched_ops[i])
> 			return true;
> 	}
>
> @@ -132,7 +132,7 @@ static int bpf_mptcp_sched_init_member(const struct btf_type *t,
>
> 	/* Ensure bpf_prog is provided for compulsory func ptr */
> 	prog_fd = (int)(*(unsigned long *)(udata + moff));
> -	if (!prog_fd && !is_optional(moff))
> +	if (!prog_fd && !is_optional_sched(moff))
> 		return -EINVAL;
>
> 	return 0;
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
