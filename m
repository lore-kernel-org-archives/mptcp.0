Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC46A72
	for <mptcp@lists.linux.dev>; Thu,  9 Sep 2021 00:04:49 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10101"; a="200830708"
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="200830708"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 17:04:46 -0700
X-IronPort-AV: E=Sophos;i="5.85,279,1624345200"; 
   d="scan'208";a="469825432"
Received: from rdbrim-mobl3.amr.corp.intel.com ([10.209.14.139])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 17:04:46 -0700
Date: Wed, 8 Sep 2021 17:04:45 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev, Geliang Tang <geliangtang@xiaomi.com>
Subject: Re: [PATCH mptcp-next 3/6] mptcp: infinite mapping receiving
In-Reply-To: <dd69eaf87e848b1de94526a456215411184cc183.1630914699.git.geliangtang@xiaomi.com>
Message-ID: <b8f8ea9b-64cf-982-f5f1-26770456966@linux.intel.com>
References: <cover.1630914699.git.geliangtang@xiaomi.com> <dd69eaf87e848b1de94526a456215411184cc183.1630914699.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 6 Sep 2021, Geliang Tang wrote:

> From: Geliang Tang <geliangtang@xiaomi.com>
>
> This patch added the infinite mapping receiving logic.
>
> Added a new struct member infinite_mapping_rcv in struct
> mptcp_subflow_context, set it true when the infinite mapping is
> received.
>
> In subflow_check_data_avail, if the infinite_mapping_rcv flag is
> set, don't reset this subflow.
>
> Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
> ---
> net/mptcp/protocol.h | 1 +
> net/mptcp/subflow.c  | 4 +++-
> 2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index a058af61cf7c..b92b02c2ba61 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -435,6 +435,7 @@ struct mptcp_subflow_context {
> 		send_mp_prio : 1,
> 		send_mp_fail : 1,
> 		infinite_mapping_snd : 1,
> +		infinite_mapping_rcv : 1,
> 		rx_eof : 1,
> 		can_ack : 1,        /* only after processing the remote a key */
> 		disposable : 1,	    /* ctx can be free at ulp release time */
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 87f42ba7c09c..e7ede61c712a 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -968,6 +968,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
> 	data_len = mpext->data_len;
> 	if (data_len == 0) {
> 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
> +		subflow->infinite_mapping_rcv = 1;
> 		return MAPPING_INVALID;

If this returns MAPPING_INFINITE instead, that enum value can be checked 
in subflow_check_data_avail() and infinite_mapping_rcv is not needed.

> 	}
>
> @@ -1181,7 +1182,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
>
> 	if (subflow->mp_join ||
> 	    (subflow->fully_established &&
> -	     !subflow->infinite_mapping_snd)) {
> +	     !(subflow->infinite_mapping_snd || subflow->infinite_mapping_rcv))) {
> 		/* fatal protocol error, close the socket.
> 		 * subflow_error_report() will introduce the appropriate barriers
> 		 */
> @@ -1201,6 +1202,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
> 	subflow->map_data_len = skb->len;
> 	subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
> 	WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_DATA_AVAIL);
> +	subflow->infinite_mapping_rcv = 0;
> 	return true;
> }
>
> -- 
> 2.31.1
>
>
>

--
Mat Martineau
Intel
