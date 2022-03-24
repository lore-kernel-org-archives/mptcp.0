Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FD57E
	for <mptcp@lists.linux.dev>; Thu, 24 Mar 2022 23:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648164223; x=1679700223;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=iJ3lmjKy6TcCdzIaS0gfmSsDxSqjTSt8u+R0mtrSXs0=;
  b=kV55fK9ojCl88Vtmf46rqaGvlW4QMSqDrRA7FK/PL5HL0Lt9XvqPu5GH
   jQDj8a6PUivOOdvReqOk7S+1Rn8yykjC4I+nGDBCAf5YjHHiFHjGt261A
   RuKkprjo+WfsHv373cLhZKKV6P/FLbjMQZQM38sAIZ4keXZQdISR+sG+7
   ET2TnXXpWFFggqj22BKYTnEOklLWXqiCLsZ5w57E6mNZ60xtt8XMtY02Z
   5EEEv1jT7dtkGxgUlt+Fqure5eRym87Kx2SDJGG5QAP/q900qJHFLdV4/
   QhVKR4fsZ+caajvMYV5AhKxYypudKKlIgw76hiikSYUnAt+GK6MgYaRRA
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="321709478"
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="321709478"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 16:23:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="561592804"
Received: from lyang24-mobl.amr.corp.intel.com ([10.255.230.22])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 16:23:43 -0700
Date: Thu, 24 Mar 2022 16:23:42 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH RESEND mptcp-next v5 5/8] mptcp: add get_subflow
 wrapper
In-Reply-To: <0c0a5ee87793b0292eb80a57248c6ae4fcdeda93.1648130637.git.geliang.tang@suse.com>
Message-ID: <349b2dcd-e6c1-5cb9-189-6ef577f796a0@linux.intel.com>
References: <cover.1648130637.git.geliang.tang@suse.com> <0c0a5ee87793b0292eb80a57248c6ae4fcdeda93.1648130637.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 24 Mar 2022, Geliang Tang wrote:

> This patch defined a new wrapper mptcp_sched_get_subflow(), invoke
> get_subflow of msk->sched in it. Use the wrapper instead of using
> mptcp_subflow_get_send() directly.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> net/mptcp/protocol.c | 6 +++---
> net/mptcp/protocol.h | 1 +
> net/mptcp/sched.c    | 7 +++++++
> 3 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index c7969b9b567e..241cfda822c0 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1567,7 +1567,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 			int ret = 0;
>
> 			prev_ssk = ssk;
> -			ssk = mptcp_subflow_get_send(msk);
> +			ssk = mptcp_sched_get_subflow(msk);
>
> 			/* First check. If the ssk has changed since
> 			 * the last round, release prev_ssk
> @@ -1636,7 +1636,7 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk)
> 			 * check for a different subflow usage only after
> 			 * spooling the first chunk of data
> 			 */
> -			xmit_ssk = first ? ssk : mptcp_subflow_get_send(mptcp_sk(sk));
> +			xmit_ssk = first ? ssk : mptcp_sched_get_subflow(mptcp_sk(sk));
> 			if (!xmit_ssk)
> 				goto out;
> 			if (xmit_ssk != ssk) {
> @@ -3134,7 +3134,7 @@ void __mptcp_check_push(struct sock *sk, struct sock *ssk)
> 		return;
>
> 	if (!sock_owned_by_user(sk)) {
> -		struct sock *xmit_ssk = mptcp_subflow_get_send(mptcp_sk(sk));
> +		struct sock *xmit_ssk = mptcp_sched_get_subflow(mptcp_sk(sk));
>
> 		if (xmit_ssk == ssk)
> 			__mptcp_subflow_push_pending(sk, ssk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index ad45281e8562..7781eb527b9a 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -621,6 +621,7 @@ void mptcp_sched_init(void);
> void mptcp_init_sched(struct mptcp_sock *msk,
> 		      struct mptcp_sched_ops *sched);
> void mptcp_release_sched(struct mptcp_sock *msk);
> +struct sock *mptcp_sched_get_subflow(struct mptcp_sock *msk);
>
> static inline bool __mptcp_subflow_active(struct mptcp_subflow_context *subflow)
> {
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index e431b1eec5e1..2fd2a034ba49 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -11,6 +11,7 @@
> #include <linux/list.h>
> #include <linux/rculist.h>
> #include <linux/spinlock.h>
> +#include <linux/indirect_call_wrapper.h>
> #include <net/tcp.h>
> #include <net/netns/generic.h>
> #include "protocol.h"
> @@ -143,3 +144,9 @@ void mptcp_release_sched(struct mptcp_sock *msk)
> 		msk->sched->release(msk);
> 	msk->sched = NULL;
> }
> +
> +struct sock *mptcp_sched_get_subflow(struct mptcp_sock *msk)
> +{
> +	return INDIRECT_CALL_INET_1(msk->sched->get_subflow,
> +				    mptcp_subflow_get_send, msk);
> +}

Since the purpose of this is to limit function call overhead, this could 
be implemented as a static inline function in protocol.h

--
Mat Martineau
Intel
