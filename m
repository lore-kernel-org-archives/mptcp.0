Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19E16112
	for <mptcp@lists.linux.dev>; Tue, 11 Oct 2022 22:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665526725; x=1697062725;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tM9o3YRwd/Vby04SIhKst6zy6WUukSU9LAbf8nxv8B8=;
  b=ZnOWQSJntuTNa7tAZBvIuu2d8XkO+I2WzDiTvMuuv/WNi+uIu6tcw3iK
   yfTqMZSahrMWPdykMoWSAFQXyjAdVSOnEaWoywmiwI7wY45+RI+omt83F
   d1JZuj/Rp9X+1/gURyCr7+PvdWT3L4SYLqMxzQQ0EUpxW5nEQr+IM4ul3
   ZskqnoV0IXR+DOC7631Jze6IiQFF7vKTMQLX31REL67QtM+JTKNQfssqP
   UzhSNfH2dyxfMbIXcKJTof4j/5jo0TDtLp23rOsnV/5sD6O+nZBToF28Y
   RY/yVqlkBO+2Uz4WMceISvED3hLHyKL/vk7Av2Xc4ugv4DLMWRVcDqGXb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="287905288"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="287905288"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 15:18:45 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="768970543"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="768970543"
Received: from sgzinzer-mobl.amr.corp.intel.com (HELO klee13-mobl1.amr.corp.intel.com) ([10.212.187.101])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 15:18:44 -0700
Date: Tue, 11 Oct 2022 15:18:44 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next v6 07/13] mptcp: don't delegate sending
 repeatedly
In-Reply-To: <20221011120137.5475-8-geliang.tang@suse.com>
Message-ID: <f9a2c67a-89f5-6d09-1749-bf7839b91789@linux.intel.com>
References: <20221011120137.5475-1-geliang.tang@suse.com> <20221011120137.5475-8-geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 11 Oct 2022, Geliang Tang wrote:

> Do not delegate sending to a subflow repeatedly. Only do it to the subflow
> without delegated action.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 86ac38d10bc4..6f55b51e10eb 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1600,6 +1600,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
> 					 bool first)
> {
> 	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_subflow_context *subflow;
> 	struct mptcp_sendmsg_info info = {
> 		.data_lock_held = true,
> 	};
> @@ -1622,7 +1623,10 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk,
> 			if (!xmit_ssk)
> 				goto out;
> 			if (xmit_ssk != ssk) {
> -				mptcp_subflow_delegate(mptcp_subflow_ctx(xmit_ssk),
> +				subflow = mptcp_subflow_ctx(xmit_ssk);
> +				if (mptcp_subflow_has_delegated_action(subflow))
> +					goto out;
> +				mptcp_subflow_delegate(subflow,
> 						       MPTCP_DELEGATE_SEND);

Hi Geliang -

Did this patch fix a problem you were seeing? It seems like it isn't 
needed, and might introduce a bug.

mptcp_subflow_delegate() does a test_and_set_bit() to see if the specific 
action is already scheduled. This new code will skip the delegated send if 
*any* delegated action is set on the subflow.

> 				goto out;
> 			}
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
