Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C364370
	for <mptcp@lists.linux.dev>; Wed,  7 Jul 2021 23:49:28 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="270527099"
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="270527099"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 16:49:27 -0700
X-IronPort-AV: E=Sophos;i="5.84,222,1620716400"; 
   d="scan'208";a="461534093"
Received: from wilesamy-mobl.amr.corp.intel.com ([10.212.141.74])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 16:49:27 -0700
Date: Wed, 7 Jul 2021 16:49:27 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH v3 mptcp-next 7/8] mptcp: infinite mapping
 receiving
In-Reply-To: <699d4e2d58c11360fd7244e4e4aee8c7f01ef189.1624854005.git.geliangtang@gmail.com>
Message-ID: <80924576-4ea5-ade7-5eda-61677b987496@linux.intel.com>
References: <cover.1624854005.git.geliangtang@gmail.com> <3cc57b70ec147b4c77610737241aeadf4150f323.1624854005.git.geliangtang@gmail.com> <d10ab4b89d053ba9a3debc9c7f6bdab0ca0d95bd.1624854005.git.geliangtang@gmail.com>
 <30a102a69a09fe644776dbddc93a1a3710c0fd51.1624854005.git.geliangtang@gmail.com> <fd3ac7612efa93564019e8542bf67ed38ef06627.1624854005.git.geliangtang@gmail.com> <926e95605f1d2a7cdc02b99a1701a1dddf1e6424.1624854005.git.geliangtang@gmail.com>
 <0e01e10358c89896ad265d9b57cfe4995965e445.1624854005.git.geliangtang@gmail.com> <699d4e2d58c11360fd7244e4e4aee8c7f01ef189.1624854005.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 28 Jun 2021, Geliang Tang wrote:

> This patch added the infinite mapping receiving logic.
>
> Added a new struct member infinite_mapping_received in struct
> mptcp_subflow_context, set it true when the infinite mapping is
> received.
>
> In subflow_check_data_avail, if this flag is set, fallback to a regular
> TCP.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/protocol.h | 1 +
> net/mptcp/subflow.c  | 9 +++++++++
> 2 files changed, 10 insertions(+)
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index fff2f5021619..4ee97e9ceece 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -424,6 +424,7 @@ struct mptcp_subflow_context {
> 		send_mp_prio : 1,
> 		send_mp_fail : 1,
> 		mp_fail_need_echo : 1,
> +		infinite_mapping_received : 1,
> 		rx_eof : 1,
> 		can_ack : 1,        /* only after processing the remote a key */
> 		disposable : 1;	    /* ctx can be free at ulp release time */
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index d46c171ef9b0..987fb6b55145 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -965,7 +965,9 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
>
> 	data_len = mpext->data_len;
> 	if (data_len == 0) {
> +		pr_debug("infinite mapping received, data_seq=%llu", mpext->data_seq);
> 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
> +		subflow->infinite_mapping_received = 1;
> 		return MAPPING_INVALID;
> 	}
>
> @@ -1179,6 +1181,13 @@ static bool subflow_check_data_avail(struct sock *ssk)
> 		}
> 	}
>
> +	if (subflow->infinite_mapping_received) {
> +		pr_fallback(msk);
> +		__mptcp_do_fallback(msk);
> +		subflow->infinite_mapping_received = 0;
> +		return true;
> +	}
> +

I think there's more checking to do before falling back with the infinite 
mapping. The RFC says:

"""
    This infinite mapping will be a DSS option (Section 3.3) on the first
    new packet, containing a Data Sequence Mapping that acts retroactively,
    referring to the start of the subflow sequence number of the most
    recent segment that was known to be delivered intact (i.e., was
    successfully DATA_ACKed).  From that point onward, data can be altered
    by a middlebox without affecting MPTCP, as the data stream is
    equivalent to a regular, legacy TCP session.
"""


> 	if (subflow->mp_join || subflow->fully_established) {
> 		/* fatal protocol error, close the socket.
> 		 * subflow_error_report() will introduce the appropriate barriers
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
