Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1E933D6
	for <mptcp@lists.linux.dev>; Tue, 28 Jun 2022 23:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656458915; x=1687994915;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=U08JTszrwXohBMhflc/ubf+M/wemS+4Bxy2dyfuodXQ=;
  b=gqUC1Q5XZRMhyHiXcqc9tUdL8wW0HC378dxiUTuhIMlWWG5owdo+NDKD
   6f2rz1TItIAwupmPzDZ0NrmpzMydYyNG35xdFLcN/+52FoiDh8UGgAkA/
   3xZmP9ecaczG+Q09keP/aNQ0dSY0h8ebSm6H1xuPAn8CAr98PCzPqoIXL
   UcrLs1G+m5BPMPcQOLl6hmjoYYdkl7DIhF21HxyuSuzto+PW0oCJ1vr+2
   0WN8n0ssqTZZiuCQlGE3x+cL1HVKNnwnClPILzzTlA0NOALxhhs1viewX
   jSCbY8e+9aPF04YvCyThDv5y9N1QzKemBGXFLGS7m98gN3VmP+B+8Ctpc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="280635853"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="280635853"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 16:28:34 -0700
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="680252468"
Received: from hmok-mobl1.amr.corp.intel.com ([10.209.98.71])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 16:28:34 -0700
Date: Tue, 28 Jun 2022 16:28:34 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH RFC 2/4]  mptcp: introduce and use mptcp_pm_send_ack()
In-Reply-To: <a59c3eb1e47c5c32f97c87d66c52f6c0021846bc.1656088406.git.pabeni@redhat.com>
Message-ID: <12f7b059-d6c8-cd75-1e1-33abe8b2b8fd@linux.intel.com>
References: <cover.1656088406.git.pabeni@redhat.com> <a59c3eb1e47c5c32f97c87d66c52f6c0021846bc.1656088406.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 24 Jun 2022, Paolo Abeni wrote:

> The in-kernel PM has a bit of duplicate code related to ack
> generation. Create a new helper factoring out the PM-specific
> needs and use it in a couple of places.
>
> Note that this additionally moves a few unsafe subflow socket
> access under the relevant socket lock.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/pm_netlink.c | 45 ++++++++++++++++++++++++------------------
> net/mptcp/protocol.c   | 11 ++++++++---
> net/mptcp/protocol.h   |  2 +-
> 3 files changed, 35 insertions(+), 23 deletions(-)
>
> diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
> index 2b2bb3599781..91f6ed2a076a 100644
> --- a/net/mptcp/pm_netlink.c
> +++ b/net/mptcp/pm_netlink.c
> @@ -463,6 +463,29 @@ static unsigned int fill_remote_addresses_vec(struct mptcp_sock *msk, bool fullm
> 	return i;
> }
>
> +static void mptcp_pm_send_ack(struct mptcp_sock *msk, struct mptcp_subflow_context *subflow,
> +			      bool prio, bool backup)
> +{
> +	struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> +	bool slow;
> +
> +	spin_unlock_bh(&msk->pm.lock);
> +	pr_debug("send ack for %s",
> +		 prio ? "mp_prio" : (mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr"));
> +
> +	slow = lock_sock_fast(ssk);
> +	if (prio) {
> +		subflow->send_mp_prio = 1;
> +		subflow->backup = backup;
> +		subflow->request_bkup = backup;
> +	}
> +
> +	__mptcp_subflow_send_ack(ssk);
> +	unlock_sock_fast(ssk, slow);
> +
> +	spin_lock_bh(&msk->pm.lock);
> +}

I was short on time yesterday so I delayed reviewing this RFC series... 
Instead I spent time working on the "Locking fixes for subflow flag 
changes" series which has very, very similar locking changes. MPTCP minds 
think alike?

I guess the lesson is that I should always look at Paolo's pending patches 
before trying to solve a "new" problem :)

In that other series, I remove the pm locking when sending this ack for 
MP_PRIO - but I think this refactoring could still be helpful. The pm lock 
could be released and reacquired by the caller instead of inside 
mptcp_pm_send_ack().

- Mat

> +
> static struct mptcp_pm_addr_entry *
> __lookup_addr_by_id(struct pm_nl_pernet *pernet, unsigned int id)
> {
> @@ -705,16 +728,8 @@ void mptcp_pm_nl_addr_send_ack(struct mptcp_sock *msk)
> 		return;
>
> 	subflow = list_first_entry_or_null(&msk->conn_list, typeof(*subflow), node);
> -	if (subflow) {
> -		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
> -
> -		spin_unlock_bh(&msk->pm.lock);
> -		pr_debug("send ack for %s",
> -			 mptcp_pm_should_add_signal(msk) ? "add_addr" : "rm_addr");
> -
> -		mptcp_subflow_send_ack(ssk);
> -		spin_lock_bh(&msk->pm.lock);
> -	}
> +	if (subflow)
> +		mptcp_pm_send_ack(msk, subflow, false, false);
> }
>
> static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
> @@ -736,16 +751,8 @@ static int mptcp_pm_nl_mp_prio_send_ack(struct mptcp_sock *msk,
>
> 		if (subflow->backup != bkup)
> 			msk->last_snd = NULL;
> -		subflow->backup = bkup;
> -		subflow->send_mp_prio = 1;
> -		subflow->request_bkup = bkup;
> 		__MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPPRIOTX);
> -
> -		spin_unlock_bh(&msk->pm.lock);
> -		pr_debug("send ack for mp_prio");
> -		mptcp_subflow_send_ack(ssk);
> -		spin_lock_bh(&msk->pm.lock);
> -
> +		mptcp_pm_send_ack(msk, subflow, true, bkup);
> 		return 0;
> 	}
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index b1fae2f747c9..874344f7e0fa 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -502,13 +502,18 @@ static inline bool tcp_can_send_ack(const struct sock *ssk)
> 	       (TCPF_SYN_SENT | TCPF_SYN_RECV | TCPF_TIME_WAIT | TCPF_CLOSE | TCPF_LISTEN));
> }
>
> -void mptcp_subflow_send_ack(struct sock *ssk)
> +void __mptcp_subflow_send_ack(struct sock *ssk)
> +{
> +	if (tcp_can_send_ack(ssk))
> +		tcp_send_ack(ssk);
> +}
> +
> +static void mptcp_subflow_send_ack(struct sock *ssk)
> {
> 	bool slow;
>
> 	slow = lock_sock_fast(ssk);
> -	if (tcp_can_send_ack(ssk))
> -		tcp_send_ack(ssk);
> +	__mptcp_subflow_send_ack(ssk);
> 	unlock_sock_fast(ssk, slow);
> }
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 95c9ace1437b..a92b6276a03c 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -609,7 +609,7 @@ void __init mptcp_subflow_init(void);
> void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how);
> void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
> 		     struct mptcp_subflow_context *subflow);
> -void mptcp_subflow_send_ack(struct sock *ssk);
> +void __mptcp_subflow_send_ack(struct sock *ssk);
> void mptcp_subflow_reset(struct sock *ssk);
> void mptcp_subflow_queue_clean(struct sock *ssk);
> void mptcp_sock_graft(struct sock *sk, struct socket *parent);
> -- 
> 2.35.3
>
>
>

--
Mat Martineau
Intel
