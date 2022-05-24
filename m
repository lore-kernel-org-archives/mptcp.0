Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFB3629
	for <mptcp@lists.linux.dev>; Tue, 24 May 2022 01:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653354089; x=1684890089;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HP3zqqWhvbtXutw7gQrOnJuYqxt1+F41P22toHsoxEk=;
  b=hIRYAfm+xyi9IKWS3QFQ1LDVahA/+qhX3U6BXNcdysX0AOXc/jBhTHux
   lF/nstfDBPYTpbQ0uM+Wu/XsDvNtvfFWBIbmH59W5mYNzhug+/3RfQ0OY
   4lQ82Q4pECGvr3BMR3NBD8E3d+m4XziVmU5xqgzBC6WSn0FDpPLdcRZ3T
   kawPPyQItIZVT+YWt1HTFrIIM3dz6yyd3m3jCFAVkorU6Q9Vof7e7C/zt
   zunLwbWpaNjPy4CjB0pOGDYVcgaCIAyfZU82aYTGuPXP0pTP1+w+frdn9
   FbXViVXm1H7WbAH4LECiXAZ+maNc3EsECHonX4vbU7LGbyd4BAMbCs5NS
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="253273606"
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; 
   d="scan'208";a="253273606"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 18:01:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; 
   d="scan'208";a="572383795"
Received: from samuelal-mobl.amr.corp.intel.com ([10.212.199.128])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 18:01:10 -0700
Date: Mon, 23 May 2022 18:01:03 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v2 3/5] Squash to "mptcp: add get_subflow
 wrappers"
In-Reply-To: <e0034f846f86901bd0c996bca6693c4036602750.1653305364.git.geliang.tang@suse.com>
Message-ID: <294011b7-28d5-5549-c138-e6e674b18b9e@linux.intel.com>
References: <cover.1653305364.git.geliang.tang@suse.com> <e0034f846f86901bd0c996bca6693c4036602750.1653305364.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 23 May 2022, Geliang Tang wrote:

> Please update the commit log:
>
> '''
> This patch defines two new wrappers mptcp_sched_get_send() and
> mptcp_sched_get_retrans(), invoke get_subflow() of msk->sched in them.
> Use them instead of using mptcp_subflow_get_send() or
> mptcp_subflow_get_retrans() directly.
>
> Set the subflow pointers array in struct mptcp_sched_data before invoking
> get_subflow(), then it can be used in get_subflow() in the BPF contexts.
>
> Get the return bitmap of get_subflow() and test which subflow or subflows
> are picked by the scheduler.
> '''
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/sched.c | 47 +++++++++++++++++++++++++++++++++++++++--------
> 1 file changed, 39 insertions(+), 8 deletions(-)
>
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 3ceb721e6489..0ef805c489ab 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -91,8 +91,19 @@ void mptcp_release_sched(struct mptcp_sock *msk)
> static int mptcp_sched_data_init(struct mptcp_sock *msk,
> 				 struct mptcp_sched_data *data)
> {
> -	data->sock = NULL;
> -	data->call_again = 0;
> +	struct mptcp_subflow_context *subflow;
> +	int i = 0;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		if (i == MPTCP_SUBFLOWS_MAX) {
> +			pr_warn_once("too many subflows");
> +			break;
> +		}
> +		data->contexts[i++] = subflow;
> +	}
> +
> +	for (; i < MPTCP_SUBFLOWS_MAX; i++)
> +		data->contexts[i++] = NULL;
>
> 	return 0;
> }
> @@ -100,6 +111,9 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk,
> struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
> {
> 	struct mptcp_sched_data data;
> +	struct sock *ssk = NULL;
> +	unsigned long bitmap;
> +	int i;
>
> 	sock_owned_by_me((struct sock *)msk);
>
> @@ -114,15 +128,25 @@ struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
> 		return mptcp_subflow_get_send(msk);
>
> 	mptcp_sched_data_init(msk, &data);
> -	msk->sched->get_subflow(msk, false, &data);
> +	bitmap = msk->sched->get_subflow(msk, false, &data);
>
> -	msk->last_snd = data.sock;
> -	return data.sock;
> +	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
> +		if (test_bit(i, &bitmap) && data.contexts[i]) {
> +			ssk = data.contexts[i]->tcp_sock;
> +			msk->last_snd = ssk;
> +			break;
> +		}
> +	}
> +
> +	return ssk;

The commit that this gets squashed too also ignores call_again, so is this 
code that just returns the ssk for the first bit in the bitmap also 
placeholder code?


It also seems like correlate the bitmap bits with the data.contexts array 
makes the bitmap require extra work. What do you think about using an 
array instead, like:

struct mptcp_sched_data {
        struct mptcp_subflow_context *context;
        bool is_scheduled;
};

And passing an array of that struct to the BPF code? Then the is_scheduled 
flag could be set for the corresponding subflow.

Do you think that array-based API would be clearer than the bitmap to 
someone writing a BPF scheduler?


- Mat


> }
>
> struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
> {
> 	struct mptcp_sched_data data;
> +	struct sock *ssk = NULL;
> +	unsigned long bitmap;
> +	int i;
>
> 	sock_owned_by_me((const struct sock *)msk);
>
> @@ -134,8 +158,15 @@ struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
> 		return mptcp_subflow_get_retrans(msk);
>
> 	mptcp_sched_data_init(msk, &data);
> -	msk->sched->get_subflow(msk, true, &data);
> +	bitmap = msk->sched->get_subflow(msk, true, &data);
> +
> +	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
> +		if (test_bit(i, &bitmap) && data.contexts[i]) {
> +			ssk = data.contexts[i]->tcp_sock;
> +			msk->last_snd = ssk;
> +			break;
> +		}
> +	}
>
> -	msk->last_snd = data.sock;
> -	return data.sock;
> +	return ssk;
> }
> -- 
> 2.34.1
>
>
>

--
Mat Martineau
Intel
