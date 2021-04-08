Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A670070
	for <mptcp@lists.linux.dev>; Thu,  8 Apr 2021 21:14:26 +0000 (UTC)
IronPort-SDR: YZJA+/kdcNY+iB+5HHYUHr1iU5XQ5cxBvORLk9mbasltkR6p6+E2QnXa+FJtpP/vGNuDPsxGPH
 cXmIJZXIDTxQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="173109702"
X-IronPort-AV: E=Sophos;i="5.82,207,1613462400"; 
   d="scan'208";a="173109702"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 14:14:25 -0700
IronPort-SDR: Cja1fFJ5OkC/YqhqTj1no8KDh7qsWRhdJ6VyPVB/ikGyrneiGDRj5q+j12DNbk2UnFbqoWscEO
 q/zK6vTkVFZg==
X-IronPort-AV: E=Sophos;i="5.82,207,1613462400"; 
   d="scan'208";a="613490994"
Received: from sudheerk-mobl3.gar.corp.intel.com ([10.212.209.196])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 14:14:25 -0700
Date: Thu, 8 Apr 2021 14:14:24 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next 2/2] mptcp: use mptcp_for_each_subflow
 in mptcp_close
In-Reply-To: <ce612a158a171e421dda4f08bcb99894bb7c2991.1617703144.git.geliangtang@gmail.com>
Message-ID: <fd3d840-0b0-7d9-637-ecfcaa8a95@linux.intel.com>
References: <cover.1617703144.git.geliangtang@gmail.com> <ba5b4db66f47311d65703f5ea25430a5957106a9.1617703144.git.geliangtang@gmail.com> <ce612a158a171e421dda4f08bcb99894bb7c2991.1617703144.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Tue, 6 Apr 2021, Geliang Tang wrote:

> This patch used the macro helper mptcp_for_each_subflow() instead of
> list_for_each_entry() in mptcp_close.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/protocol.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>

Thanks for the reminder Geliang. Yes, this patch is good!

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 2d895c3c8746..3b7d1df8d019 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -2581,7 +2581,7 @@ static void mptcp_close(struct sock *sk, long timeout)
> cleanup:
> 	/* orphan all the subflows */
> 	inet_csk(sk)->icsk_mtup.probe_timestamp = tcp_jiffies32;
> -	list_for_each_entry(subflow, &mptcp_sk(sk)->conn_list, node) {
> +	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
> 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> 		bool slow = lock_sock_fast(ssk);
>
> -- 
> 2.30.2

--
Mat Martineau
Intel
