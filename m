Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F643FD3
	for <mptcp@lists.linux.dev>; Wed, 29 Sep 2021 22:13:30 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="205199884"
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="205199884"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 15:13:29 -0700
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; 
   d="scan'208";a="563638517"
Received: from crobert2-mobl.amr.corp.intel.com ([10.212.137.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 15:13:29 -0700
Date: Wed, 29 Sep 2021 15:13:28 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH mptcp-next v6 4/9] mptcp: add last_ack_dss_start in the
 msk
In-Reply-To: <b67052f2a5ba451f12b0e29346a164da06712508.1632900306.git.geliangtang@gmail.com>
Message-ID: <a6d5305b-7ae-3637-7ac3-be55c745767@linux.intel.com>
References: <cover.1632900306.git.geliangtang@gmail.com> <b67052f2a5ba451f12b0e29346a164da06712508.1632900306.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 29 Sep 2021, Geliang Tang wrote:

> This patch added a new member named last_ack_dss_start to the msk to
> keep track of the beginning of the last fully-acked data segment. This
> would be updated in __mptcp_clean_una.
>

Can drop this patch, see patch 5 reply for more details.


Mat


> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/protocol.c | 3 +++
> net/mptcp/protocol.h | 1 +
> 2 files changed, 4 insertions(+)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 48979cb82126..334bbce69fcb 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -1071,6 +1071,7 @@ static void __mptcp_clean_una(struct sock *sk)
> 			WRITE_ONCE(msk->first_pending, mptcp_send_next(sk));
> 		}
>
> +		msk->last_ack_dss_start = dfrag->data_seq;
> 		dfrag_clear(sk, dfrag);
> 		cleaned = true;
> 	}
> @@ -2891,6 +2892,7 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
> 	msk->snd_una = msk->write_seq;
> 	msk->wnd_end = msk->snd_nxt + req->rsk_rcv_wnd;
> 	msk->setsockopt_seq = mptcp_sk(sk)->setsockopt_seq;
> +	msk->last_ack_dss_start = subflow_req->idsn - 1;
>
> 	if (mp_opt->suboptions & OPTIONS_MPTCP_MPC) {
> 		msk->can_ack = true;
> @@ -3147,6 +3149,7 @@ void mptcp_finish_connect(struct sock *ssk)
> 	WRITE_ONCE(msk->rcv_wnd_sent, ack_seq);
> 	WRITE_ONCE(msk->can_ack, 1);
> 	WRITE_ONCE(msk->snd_una, msk->write_seq);
> +	WRITE_ONCE(msk->last_ack_dss_start, subflow->idsn - 1);
>
> 	mptcp_pm_new_connection(msk, ssk, 0);
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 4807e486e762..7927acf53f06 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -224,6 +224,7 @@ struct mptcp_sock {
> 	u64		remote_key;
> 	u64		write_seq;
> 	u64		snd_nxt;
> +	u64		last_ack_dss_start;
> 	u64		ack_seq;
> 	u64		rcv_wnd_sent;
> 	u64		rcv_data_fin_seq;
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
