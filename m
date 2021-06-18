Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB5A71
	for <mptcp@lists.linux.dev>; Fri, 18 Jun 2021 23:19:47 +0000 (UTC)
IronPort-SDR: Sjsq5g5Z2jxQ0Nv7F+gwDLkWu84XA8IMLi3owRABJmMt4UmUfh/SfDAIQfP+AC3AT1tS+VqHtI
 /42qFxB7aPkg==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="204807999"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="204807999"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 16:19:46 -0700
IronPort-SDR: MwCghhP9lDF1KgwinDlGed5MkjKPB5jeRON83wfiRLP8f1QrwP6rowreojDF12kdtpsFvmgWzB
 qU9PmbfIHhFQ==
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="555717885"
Received: from rsurapan-mobl2.amr.corp.intel.com ([10.209.105.229])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 16:19:46 -0700
Date: Fri, 18 Jun 2021 16:19:46 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: wujianguo106@163.com
cc: mptcp@lists.linux.dev, pabeni@redhat.com, fw@strlen.de
Subject: Re: [PATCH v5 3/4] mptcp: fix syncookie process if mptcp can not_accept
 new subflow
In-Reply-To: <1623840570-42004-4-git-send-email-wujianguo106@163.com>
Message-ID: <3cdb43ff-a2c2-6599-4e8-3cb569e1a26a@linux.intel.com>
References: <1623840570-42004-1-git-send-email-wujianguo106@163.com> <1623840570-42004-4-git-send-email-wujianguo106@163.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 16 Jun 2021, wujianguo106@163.com wrote:

> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>
> Lots of "TCP: tcp_fin: Impossible, sk->sk_state=7" in client side
> when doing stress testing.

Hi Jianguo -

Like patch 1, do the existing syncookie selftests trigger this sometimes?

Or are there selftests that could be added to this series, or packetdrill 
tests, to do such syncookie stress tests?

Thanks,

Mat


>
> There are at least two cases may trigger this warning:
> 1.mptcp is in syncookie, and server recv MP_JOIN SYN request,
>  in subflow_check_req(), the mptcp_can_accept_new_subflow()
>  return false, so subflow_init_req_cookie_join_save() isn't
>  called, i.e. not store the data present in the MP_JOIN syn
>  request and the random nonce in hash table - join_entries[],
>  but still send synack. When recv 3rd-ack,
>  mptcp_token_join_cookie_init_state() will return false, and
>  3rd-ack is dropped, then if mptcp conn is closed by client,
>  client will send a DATA_FIN and a MPTCP FIN, the DATA_FIN
>  doesn't have MP_CAPABLE or MP_JOIN,
>  so mptcp_subflow_init_cookie_req() will return 0, and pass
>  the cookie check, MP_JOIN request is fallback to normal TCP.
>  Server will send a TCP FIN if closed, in client side,
>  when process TCP FIN, it will do reset, the code path is:
>    tcp_data_queue()->mptcp_incoming_options()
>      ->check_fully_established()->mptcp_subflow_reset().
>  mptcp_subflow_reset() will set sock state to TCP_CLOSE,
>  so tcp_fin will hit TCP_CLOSE, and print the warning.
> 2.mptcp is in syncookie, and server recv 3rd-ack, in
>  mptcp_subflow_init_cookie_req(), mptcp_can_accept_new_subflow()
>  return false, and subflow_req->mp_join is not set to 1,
>  so in subflow_syn_recv_sock() will not reset the MP_JOIN
>  subflow, but fallback to normal TCP, and then the same thing
>  happens when server will send a TCP FIN if closed.
>
> For case1, subflow_check_req() return -EPERM,
> then tcp_conn_request() will drop MP_JOIN SYN.
>
> For case2, let subflow_syn_recv_sock() call mptcp_can_accept_new_subflow(),
> and do fatal fallback, send reset.
>
> Fixes: 9466a1ccebbe("mptcp: enable JOIN requests even if cookies are in use")
> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
> ---
> net/mptcp/subflow.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 75ed530706c0..6d98e19a20aa 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -224,6 +224,8 @@ static int subflow_check_req(struct request_sock *req,
> 		if (unlikely(req->syncookie)) {
> 			if (mptcp_can_accept_new_subflow(subflow_req->msk))
> 				subflow_init_req_cookie_join_save(subflow_req, skb);
> +			else
> +				return -EPERM;
> 		}
>
> 		pr_debug("token=%u, remote_nonce=%u msk=%p", subflow_req->token,
> @@ -263,9 +265,7 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
> 		if (!mptcp_token_join_cookie_init_state(subflow_req, skb))
> 			return -EINVAL;
>
> -		if (mptcp_can_accept_new_subflow(subflow_req->msk))
> -			subflow_req->mp_join = 1;
> -
> +		subflow_req->mp_join = 1;
> 		subflow_req->ssn_offset = TCP_SKB_CB(skb)->seq - 1;
> 	}
>
> -- 
> 1.8.3.1
>
>
>

--
Mat Martineau
Intel
