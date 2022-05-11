Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D3615A7
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 00:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652230590; x=1683766590;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Q0YgZrkLMDbRsVnonCnjgQKMXerNTF8gif5ZwrrsxIc=;
  b=njxrKFwfAGrUJLFEJEU4HWK3B0E2dp3CUlCLPgv3jT6mQh1NqNNZmlxI
   SnvHPus+HUwV5onNzswjva/knBBV55CJ7Y8vlX5xoq4v4nfj5MPxjaoJL
   TGR3NiYtJ9N2AkbN5c/Ze6jwj+BcaJpTQgv9wsmwnODQMhKSdq9284Z20
   rcS9kHpTVFx2Zr9/54ma3QaJEZ4qMF3/u+AelYu7ABezyihbC6Vj+7Qgz
   x9PX9Un4PhxggG13uJXWzx58y0ohmeT0xJMTXIx+Pp4dzQ3h98Wfhbxsh
   TVYpbJ3YUUpeFzf+wJmihGxOha1u86rNKbq/idIHETXlt0UpOcY7pc3Wm
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="269211714"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="269211714"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 17:56:29 -0700
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="636195795"
Received: from yperng-mobl1.amr.corp.intel.com ([10.209.50.90])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 17:56:29 -0700
Date: Tue, 10 May 2022 17:56:29 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliang.tang@suse.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-next 2/4] mptcp: add redundant subflows support
In-Reply-To: <7455f0b7b02d6f2edac5fca53c8667e1e0e84533.1652108279.git.geliang.tang@suse.com>
Message-ID: <e13f717d-47dd-b443-5142-40b7c104a9e@linux.intel.com>
References: <cover.1652108279.git.geliang.tang@suse.com> <7455f0b7b02d6f2edac5fca53c8667e1e0e84533.1652108279.git.geliang.tang@suse.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 9 May 2022, Geliang Tang wrote:

> This patch adds the redundant subflows support, sending all packets
> redundantly on all available subflows.
>
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> ---
> include/net/mptcp.h  |  1 +
> net/mptcp/protocol.c | 13 ++++++++-----
> net/mptcp/sched.c    |  1 +
> 3 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
> index 345f27a68eaa..d48c66de8466 100644
> --- a/include/net/mptcp.h
> +++ b/include/net/mptcp.h
> @@ -101,6 +101,7 @@ struct mptcp_out_options {
> struct mptcp_sched_data {
> 	struct sock	*sock;
> 	bool		call_again;
> +	u8		subflows;
> 	struct mptcp_subflow_context *contexts[MPTCP_SUBFLOWS_MAX];
> };
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 4a55a6e89ed5..e3e1026aad97 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1591,13 +1591,16 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
> 				goto out;

If the updates below were skipped on a previous iteration of the loop, 
they would need to be handled before the 'goto' here.

> 			}
>
> -			info.sent += ret;
> -			copied += ret;
> -			len -= ret;
> +			if (!call_again) {
> +				info.sent += ret;
> +				copied += ret;
> +				len -= ret;
>
> -			mptcp_update_post_push(msk, dfrag, ret);
> +				mptcp_update_post_push(msk, dfrag, ret);

I'm not sure this works, 'ret' is the number of bytes sent on the final 
scheduled subflow. A different amount of data could have been sent on 
other subflows.

The simple fix is to keep track of the largest value of 'ret' when 
repeating this loop and use that to track the amount of data sent. But I'm 
not sure how that will behave when the multiple subflows have different 
latencies, speeds, and window sizes.

Do we want to send the latest unsent data on every scheduled subflow? Or 
is it better to keep the data on the slower subflows contiguous until the 
received DATA_ACKs move msk->snd_una forward? The former case means that 
the slow subflows skip unacked data and increase the possible need for 
reinjecting data. The latter would only skip acked data, leading to fewer 
MPTCP reinjections.

The best thing for now may be to try the simple approach (track the 
largest copied amount) and see how it behaves, then we can discuss based 
on that data.

> +			}
> 		}
> -		WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> +		if (!call_again)
> +			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> 	}
>
> 	/* at this point we held the socket lock for the last subflow we used */
> diff --git a/net/mptcp/sched.c b/net/mptcp/sched.c
> index 83377cd1a4de..0d5fc96a2ce0 100644
> --- a/net/mptcp/sched.c
> +++ b/net/mptcp/sched.c
> @@ -104,6 +104,7 @@ static int mptcp_sched_data_init(struct mptcp_sock *msk,
> 		}
> 		data->contexts[i++] = subflow;
> 	}
> +	data->subflows = i;
>
> 	for (; i < MPTCP_SUBFLOWS_MAX; i++)
> 		data->contexts[i++] = NULL;


There's also the more complex __mptcp_subflow_push_pending() path and the 
chaining of further sends through mptcp_subflow_delegate(), and the 
retransmit loop.



--
Mat Martineau
Intel
