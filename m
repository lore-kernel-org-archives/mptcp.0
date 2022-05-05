Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B5D7F
	for <mptcp@lists.linux.dev>; Thu,  5 May 2022 23:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651794035; x=1683330035;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=x+T5AGc3fyhIDyjhT6Xd5HhRdbquPAj6YkryC4sY0gk=;
  b=MtPpvza4cSRtk6aYm/FsgIVHXlMPmIXomanQiPkemQe72UhIgyRu/Ri0
   DDgUC4MHBJkYQLLzsU9hHdmCqeOY+xwQjtaHkp7GKz4ecO3eNRVyXa+N2
   6FmZZV9lB5KERdvPbZram8D2rmvjVlX/hJYFMcPJvwPFUaY0Q6l3U9zr5
   lSo6ZZr0QKa3LL6+OYB0Y+8doIAizA8XRoTvf852vZmJy8XzTO6Xmtqgt
   nVAWLZA+noOD0HPQzH8Eknj8FhzJPifVF8uR1smXdbc0lOYj4QmDeiWPy
   YROtnAmiAmgOnTeVe4paTm/j928E1oJ9S8GHPGSRrNFSypbdA74W8oJIl
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="267127899"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="267127899"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:40:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="621533206"
Received: from barreola-mobl1.amr.corp.intel.com ([10.212.167.175])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 16:40:34 -0700
Date: Thu, 5 May 2022 16:40:34 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: Geliang Tang <geliang.tang@suse.com>, mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next] Revert "mptcp: add data lock for sk timers"
In-Reply-To: <0343ae0f3f81535f20d387147ce6b8e4158cc1fc.1651770128.git.pabeni@redhat.com>
Message-ID: <bdde3a40-1471-c8b9-65bd-f53ddebacdb4@linux.intel.com>
References: <0343ae0f3f81535f20d387147ce6b8e4158cc1fc.1651770128.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Thu, 5 May 2022, Paolo Abeni wrote:

> This reverts commit 4293248c6704b854bf816aa1967e433402bee11c.
>
> Additional locks are not needed, all the touched sections
> are already under mptcp socket lock protection.
>

I agree that this needs to be reverted:

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


But msk->sk_timer is *also* accessed in two places without the mptcp 
socket lock (but with the data lock):

  * mptcp_pm_mp_fail_received() (stop timer when mp_fail received)

  * subflow_check_data_avail() (start timer on infinite mapping rx)


I think these were the reason the locking was added, because we don't want 
the use of msk->sk_timer for MP_FAIL timeout to interfere with other use 
of msk->sk_timer when a msk is closing.

Now I see that the data lock doesn't work for that purpose. In addition to 
removing the data locks as this patch does, it looks like the two 
functions I listed above need to use msk->cb_flags and deferred events to 
safely check msk->sk_state and modify msk->sk_timer. What do you think? I 
can send a patch on Friday.


- Mat


> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> net/mptcp/protocol.c | 12 ------------
> 1 file changed, 12 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 5243c58789a4..ff567e9d0b1f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1605,10 +1605,8 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
>
> out:
> 	/* ensure the rtx timer is running */
> -	mptcp_data_lock(sk);
> 	if (!mptcp_timer_pending(sk))
> 		mptcp_reset_timer(sk);
> -	mptcp_data_unlock(sk);
> 	if (copied)
> 		__mptcp_check_send_data_fin(sk);
> }
> @@ -2516,10 +2514,8 @@ static void __mptcp_retrans(struct sock *sk)
> reset_timer:
> 	mptcp_check_and_set_pending(sk);
>
> -	mptcp_data_lock(sk);
> 	if (!mptcp_timer_pending(sk))
> 		mptcp_reset_timer(sk);
> -	mptcp_data_unlock(sk);
> }
>
> static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
> @@ -2707,10 +2703,8 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
> 		} else {
> 			pr_debug("Sending DATA_FIN on subflow %p", ssk);
> 			tcp_send_ack(ssk);
> -			mptcp_data_lock(sk);
> 			if (!mptcp_timer_pending(sk))
> 				mptcp_reset_timer(sk);
> -			mptcp_data_unlock(sk);
> 		}
> 		break;
> 	}
> @@ -2811,10 +2805,8 @@ static void __mptcp_destroy_sock(struct sock *sk)
> 	/* join list will be eventually flushed (with rst) at sock lock release time*/
> 	list_splice_init(&msk->conn_list, &conn_list);
>
> -	mptcp_data_lock(sk);
> 	mptcp_stop_timer(sk);
> 	sk_stop_timer(sk, &sk->sk_timer);
> -	mptcp_data_unlock(sk);
> 	msk->pm.status = 0;
> 	mptcp_release_sched(msk);
>
> @@ -2877,9 +2869,7 @@ static void mptcp_close(struct sock *sk, long timeout)
> 		__mptcp_destroy_sock(sk);
> 		do_cancel_work = true;
> 	} else {
> -		mptcp_data_lock(sk);
> 		sk_reset_timer(sk, &sk->sk_timer, jiffies + TCP_TIMEWAIT_LEN);
> -		mptcp_data_unlock(sk);
> 	}
> 	release_sock(sk);
> 	if (do_cancel_work)
> @@ -2924,10 +2914,8 @@ static int mptcp_disconnect(struct sock *sk, int flags)
> 		__mptcp_close_ssk(sk, ssk, subflow, MPTCP_CF_FASTCLOSE);
> 	}
>
> -	mptcp_data_lock(sk);
> 	mptcp_stop_timer(sk);
> 	sk_stop_timer(sk, &sk->sk_timer);
> -	mptcp_data_unlock(sk);
>
> 	if (mptcp_sk(sk)->token)
> 		mptcp_event(MPTCP_EVENT_CLOSED, mptcp_sk(sk), NULL, GFP_KERNEL);
> -- 
> 2.35.1
>
>
>

--
Mat Martineau
Intel
