Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0EE70
	for <mptcp@lists.linux.dev>; Fri,  4 Jun 2021 00:08:53 +0000 (UTC)
IronPort-SDR: QyWQ3Z/04QqtJBD3QoBiJNU7JE/jthmdRrck5CO5i5cxE3XaWmwn6BzOIa4YDTUeMx3Nlv40r+
 DxzPJe7Mo8TQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="184556853"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="184556853"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 17:08:27 -0700
IronPort-SDR: lBhBtx3O/DpPte8IPH5l1w/5v9ZPPJxF7aZQiL+Mj+xsZbx7NMTp8eIhC1AreTyTjPPf/PRNp0
 f5wALc021PZw==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="417574793"
Received: from jhe12-mobl.amr.corp.intel.com ([10.212.229.108])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 17:08:25 -0700
Date: Thu, 3 Jun 2021 17:08:25 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev, Maxim Galaganov <max@internet.ru>
Subject: Re: [PATCH v2 mptcp-next] mptcp: add MIB counter for invalid
 mapping
In-Reply-To: <9ec7261d647d0360851f3029ead0b46d38ccedd7.1622733220.git.pabeni@redhat.com>
Message-ID: <e512b57b-457-d157-c5ea-d01f2e97c5e2@linux.intel.com>
References: <9ec7261d647d0360851f3029ead0b46d38ccedd7.1622733220.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Thu, 3 Jun 2021, Paolo Abeni wrote:

> Account this exceptional events for better introspection.
>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v1 -> v2:
> - update mptcp_snmp_list accordingly - Max
> ---
> net/mptcp/mib.c     | 1 +
> net/mptcp/mib.h     | 1 +
> net/mptcp/subflow.c | 4 +++-
> 3 files changed, 5 insertions(+), 1 deletion(-)
>

Useful counter, thanks for adding.

Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>


> diff --git a/net/mptcp/mib.c b/net/mptcp/mib.c
> index e7e60bc1fb96..52ea2517e856 100644
> --- a/net/mptcp/mib.c
> +++ b/net/mptcp/mib.c
> @@ -25,6 +25,7 @@ static const struct snmp_mib mptcp_snmp_list[] = {
> 	SNMP_MIB_ITEM("MPJoinAckHMacFailure", MPTCP_MIB_JOINACKMAC),
> 	SNMP_MIB_ITEM("DSSNotMatching", MPTCP_MIB_DSSNOMATCH),
> 	SNMP_MIB_ITEM("InfiniteMapRx", MPTCP_MIB_INFINITEMAPRX),
> +	SNMP_MIB_ITEM("DSSNoMatchTCP", MPTCP_MIB_DSSTCPMISMATCH),
> 	SNMP_MIB_ITEM("DataCsumErr", MPTCP_MIB_DATACSUMERR),
> 	SNMP_MIB_ITEM("OFOQueueTail", MPTCP_MIB_OFOQUEUETAIL),
> 	SNMP_MIB_ITEM("OFOQueue", MPTCP_MIB_OFOQUEUE),
> diff --git a/net/mptcp/mib.h b/net/mptcp/mib.h
> index 92e56c0cfbdd..193466c9b549 100644
> --- a/net/mptcp/mib.h
> +++ b/net/mptcp/mib.h
> @@ -18,6 +18,7 @@ enum linux_mptcp_mib_field {
> 	MPTCP_MIB_JOINACKMAC,		/* HMAC was wrong on ACK + MP_JOIN */
> 	MPTCP_MIB_DSSNOMATCH,		/* Received a new mapping that did not match the previous one */
> 	MPTCP_MIB_INFINITEMAPRX,	/* Received an infinite mapping */
> +	MPTCP_MIB_DSSTCPMISMATCH,	/* DSS-mapping did not map with TCP's sequence numbers */
> 	MPTCP_MIB_DATACSUMERR,		/* The data checksum fail */
> 	MPTCP_MIB_OFOQUEUETAIL,	/* Segments inserted into OoO queue tail */
> 	MPTCP_MIB_OFOQUEUE,		/* Segments inserted into OoO queue */
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 259f99b61c35..ccc07cbab867 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1046,8 +1046,10 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
> 	/* we revalidate valid mapping on new skb, because we must ensure
> 	 * the current skb is completely covered by the available mapping
> 	 */
> -	if (!validate_mapping(ssk, skb))
> +	if (!validate_mapping(ssk, skb)) {
> +		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSTCPMISMATCH);
> 		return MAPPING_INVALID;
> +	}
>
> 	skb_ext_del(skb, SKB_EXT_MPTCP);
>
> -- 
> 2.26.3
>
>
>

--
Mat Martineau
Intel
