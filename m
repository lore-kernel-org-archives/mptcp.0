Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C4F7E
	for <mptcp@lists.linux.dev>; Wed,  1 Jun 2022 00:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654045182; x=1685581182;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qeB1I69UckP6fZp6Ym2htlUn/Y8tCFo/KInZOBx84dU=;
  b=BIlBDXdAml8mEtTB/ieqHwOczaffTRaufLrQElwGnBy6qPtfJuSerXPl
   khqrN4sjn7jICVBUFyEc2ogj3kCfBbhZkTTgQlmv5PCXBmCzbBU+o9ZEm
   C6MpwTwvSSbNq+92Fae0RreImDAk2lrymqzHA0YkZWwLki5uYcZTLJ2NG
   P+n6Qd6jU7XYaEgWEyv64hHmja+QoJsSbnXU19ntiOII+w3f6B/ysfT45
   u7NX7DAjDBdNTMHrgT9XS2ErK3Y2Sx90CC1+8yxIK1wHgOZfB2DdpJzz7
   P3EeU8PI05rI8vXHSmhxie5lgT9G1ZdTbHm1NKmsyIktuOHmiSbpqOgTQ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="275157470"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="275157470"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 17:59:41 -0700
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="720552870"
Received: from sbeaupre-mobl1.amr.corp.intel.com ([10.209.105.200])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 17:59:41 -0700
Date: Tue, 31 May 2022 17:59:40 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v4 03/10] Squash to "mptcp: add get_subflow
 wrappers"
In-Reply-To: <38eee17dadb62fe1e21a19c875cf63e1cadb0f1f.1653987929.git.geliang.tang@suse.com>
Message-ID: <4afab57d-4c35-fa46-c379-453c98a963ef@linux.intel.com>
References: <cover.1653987929.git.geliang.tang@suse.com> <38eee17dadb62fe1e21a19c875cf63e1cadb0f1f.1653987929.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 31 May 2022, Geliang Tang wrote:

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
> Check the subflow scheduled flags to test which subflow or subflows are
> picked by the scheduler.
> '''
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/sched.c | 54 +++++++++++++++++++++++++++++++++++++----------
> 1 file changed, 43 insertions(+), 11 deletions(-)
>
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 3ceb721e6489..613b7005938c 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -88,11 +88,25 @@ void mptcp_release_sched(struct mptcp_sock *msk)
> 	bpf_module_put(sched, sched->owner);
> }
>
> -static int mptcp_sched_data_init(struct mptcp_sock *msk,
> +static int mptcp_sched_data_init(struct mptcp_sock *msk, bool reinject,
> 				 struct mptcp_sched_data *data)
> {
> -	data->sock = NULL;
> -	data->call_again = 0;
> +	struct mptcp_subflow_context *subflow;
> +	int i = 0;
> +
> +	data->reinject = reinject;
> +
> +	mptcp_for_each_subflow(msk, subflow) {
> +		if (i == MPTCP_SUBFLOWS_MAX) {
> +			pr_warn_once("too many subflows");
> +			break;
> +		}
> +		WRITE_ONCE(subflow->scheduled, false);

If subflow->scheduled is using READ_ONCE/WRITE_ONCE semantics, then 
writing it directly from BPF code is going to be a problem. The code in 
this patch set would work ok since all read and write access is under the 
msk lock, but I think integrating with all of the transmit and retransmit 
code (especially transmission in mptcp_subflow_process_delegated()) would 
make it important to use WRITE_ONCE() to set subflow->scheduled.

I think that requires using a C helper function called from BPF to do 
WRITE_ONCE(subflow->scheduled), or using a lock to order accesses. The 
mptcp_data_lock is already used in mptcp_subflow_process_delegated() but 
we probably don't want to add more locking to mptcp_sendmsg(). That makes 
me think the helper function might be better - unless there's a generic 
BPF technique for using WRITE_ONCE.

> +		data->contexts[i++] = subflow;
> +	}
> +
> +	for (; i < MPTCP_SUBFLOWS_MAX; i++)
> +		data->contexts[i] = NULL;
>
> 	return 0;
> }
> @@ -100,6 +114,8 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk,
> struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
> {
> 	struct mptcp_sched_data data;
> +	struct sock *ssk = NULL;
> +	int i;
>
> 	sock_owned_by_me((struct sock *)msk);
>
> @@ -113,16 +129,25 @@ struct sock *mptcp_sched_get_send(struct mptcp_sock *msk)
> 	if (!msk->sched)
> 		return mptcp_subflow_get_send(msk);
>
> -	mptcp_sched_data_init(msk, &data);
> -	msk->sched->get_subflow(msk, false, &data);
> +	mptcp_sched_data_init(msk, false, &data);
> +	msk->sched->get_subflow(msk, &data);
> +
> +	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
> +		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
> +			ssk = data.contexts[i]->tcp_sock;
> +			msk->last_snd = ssk;
> +			break;
> +		}
> +	}

I think this is ok for a placeholder until more of the transmit 
integration is done.

>
> -	msk->last_snd = data.sock;
> -	return data.sock;
> +	return ssk;
> }
>
> struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
> {
> 	struct mptcp_sched_data data;
> +	struct sock *ssk = NULL;
> +	int i;
>
> 	sock_owned_by_me((const struct sock *)msk);
>
> @@ -133,9 +158,16 @@ struct sock *mptcp_sched_get_retrans(struct mptcp_sock *msk)
> 	if (!msk->sched)
> 		return mptcp_subflow_get_retrans(msk);
>
> -	mptcp_sched_data_init(msk, &data);
> -	msk->sched->get_subflow(msk, true, &data);
> +	mptcp_sched_data_init(msk, true, &data);
> +	msk->sched->get_subflow(msk, &data);
> +
> +	for (i = 0; i < MPTCP_SUBFLOWS_MAX; i++) {
> +		if (data.contexts[i] && READ_ONCE(data.contexts[i]->scheduled)) {
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
