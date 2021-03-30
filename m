Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4854D70
	for <mptcp@lists.linux.dev>; Tue, 30 Mar 2021 00:41:00 +0000 (UTC)
IronPort-SDR: iyGWt5ibvDgC1bq0Eip7shx2/+mAkOrpXMPM5KOn2dUotWX2WjmNvjYaP2wuhXYtxa6eKtyZKm
 yy9KTNlwwzGA==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="255648504"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="255648504"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 17:40:59 -0700
IronPort-SDR: fb8j/xLDcAisK35yMtLEqmRQcE5Q4BDxJFNjJ0mybMWS6f/XpNGlfagy48W0rSPg/Wmxs5NUgv
 wgR+1RZctfvA==
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="417915250"
Received: from erwebste-mobl.amr.corp.intel.com ([10.251.11.21])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 17:40:58 -0700
Date: Mon, 29 Mar 2021 17:40:55 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH v2 mptcp-next 10/16] mptcp: validate the data
 checksum
In-Reply-To: <07856073b42a0343f81e6b6e468d6965b693fc5d.1617014019.git.geliangtang@gmail.com>
Message-ID: <e1601dc-808a-440-4c24-eddad62091f3@linux.intel.com>
References: <cover.1617014019.git.geliangtang@gmail.com> <ee1d26bf90397d9cbec5e4a165fc369ffab60d3e.1617014019.git.geliangtang@gmail.com> <26ccf630ac9be0aee87f4ccfcefc46515c9d61e8.1617014019.git.geliangtang@gmail.com>
 <a138746729a11cf08e8236d2c8cdf91226936690.1617014019.git.geliangtang@gmail.com> <14b6923c9fd052b140d5af261dfd2575d94b3e05.1617014019.git.geliangtang@gmail.com> <08ab4ce9f13e954b45d24c9e7842f7a6a9798d54.1617014019.git.geliangtang@gmail.com>
 <d8a242cfe08b2ab0ccb4752a15c8ea8ef0226ac1.1617014019.git.geliangtang@gmail.com> <1c0a240472edcc1afbcb822bd9af3cf03800759e.1617014019.git.geliangtang@gmail.com> <4c7e346e9d1005e8838dd8cf742d8324ef7553c0.1617014019.git.geliangtang@gmail.com>
 <4a289b981d90fcfda872ade12ec94d27d47bc01f.1617014019.git.geliangtang@gmail.com> <07856073b42a0343f81e6b6e468d6965b693fc5d.1617014019.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed


Hi Geliang,

On Mon, 29 Mar 2021, Geliang Tang wrote:

> This patch add three new members named data_csum, csum_len and map_csum in
> struct mptcp_subflow_context, implemented a new function named
> mptcp_validate_data_checksum(). Validate the data checksum in the function
> __mptcp_move_skbs_from_subflow.
>
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
> net/mptcp/protocol.c | 35 +++++++++++++++++++++++++++++++++++
> net/mptcp/protocol.h |  3 +++
> net/mptcp/subflow.c  |  7 +++++--
> 3 files changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 436969d95e36..0b4ab35e234a 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -532,6 +532,35 @@ static bool mptcp_check_data_fin(struct sock *sk)
> 	return ret;
> }
>
> +static bool mptcp_validate_data_checksum(struct sock *ssk)
> +{
> +	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
> +	struct mptcp_sock *msk = mptcp_sk(subflow->conn);
> +	struct csum_pseudo_header header;
> +	__wsum csum;
> +
> +	if (__mptcp_check_fallback(msk))
> +		goto out;
> +
> +	if (subflow->csum_len < subflow->map_data_len)
> +		goto out;
> +
> +	header.data_seq = subflow->map_seq;
> +	header.subflow_seq = subflow->map_subflow_seq;
> +	header.data_len = subflow->map_data_len;
> +	header.csum = subflow->map_csum;
> +
> +	csum = csum_partial(&header, sizeof(header), subflow->data_csum);
> +
> +	if (csum_fold(csum))
> +		return false;
> +	subflow->data_csum = 0;
> +	subflow->csum_len = 0;
> +
> +out:
> +	return true;
> +}
> +
> static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
> 					   struct sock *ssk,
> 					   unsigned int *bytes)
> @@ -600,6 +629,12 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
> 			if (tp->urg_data)
> 				done = true;
>
> +			if (READ_ONCE(msk->csum_enabled)) {
> +				subflow->data_csum = skb_checksum(skb, offset, len,
> +								  subflow->data_csum);
> +				subflow->csum_len += len;
> +				mptcp_validate_data_checksum(ssk);

The return value is ignored there so a bad checksum doesn't seem to have 
any effect.

There needs to be different handling for several different cases here.


1. Checksums are not enabled, code works same as before this patch set


2. All data needed for the checksum is present and the checksum is valid

    --> Checksum validation will have to look through the queue of skbs in 
sk_receive_queue to add up the available length and compare to map length, 
then if there is enough combined data to cover map_data_len, go ahead and 
validate the checksum. For example, map_data_len could be 4500, and the 
payload of the first skb might be only 1500 bytes. Would have to wait for 
skb2 and skb3 (each with 1500 bytes) to arrive before validating the 
checksum.

    --> If the checksum for all the data is valid, make sure all skbs 
covered by the checksum are moved to the msk with __mptcp_move_skb()


3. All data needed for the checksum is present and the checksum is invalid

    --> Ignore all data from mapping (it must not be acked at the MPTCP 
level), update MPTCP_MIB_DSSCSUMERR). Discard the skbs with bad data, but 
be careful with the last skb in case it has a new mapping.


4. Checksums are enabled but there is some kind of non-checksum condition 
to handle (FIN flag, etc)

    --> Probably best to treat like a failed checksum and ensure other 
required actions happen, like handling the FIN


Thanks,

Mat



> +			}
> 			if (__mptcp_move_skb(msk, ssk, skb, offset, len))
> 				moved += len;
> 			seq += len;
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 6be10ebabcd5..d4bf264d16cc 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -394,6 +394,9 @@ struct mptcp_subflow_context {
> 	u32	map_subflow_seq;
> 	u32	ssn_offset;
> 	u32	map_data_len;
> +	__wsum	data_csum;
> +	u32	csum_len;
> +	__sum16	map_csum;
> 	u32	request_mptcp : 1,  /* send MP_CAPABLE */
> 		request_join : 1,   /* send MP_JOIN */
> 		request_bkup : 1,
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 75664da251a6..df7ad478bb2e 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -944,9 +944,12 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
> 	subflow->map_data_len = data_len;
> 	subflow->map_valid = 1;
> 	subflow->mpc_map = mpext->mpc_map;
> -	pr_debug("new map seq=%llu subflow_seq=%u data_len=%u",
> +	subflow->data_csum = 0;
> +	subflow->csum_len = 0;
> +	subflow->map_csum = mpext->csum;
> +	pr_debug("new map seq=%llu subflow_seq=%u data_len=%u csum=%u",
> 		 subflow->map_seq, subflow->map_subflow_seq,
> -		 subflow->map_data_len);
> +		 subflow->map_data_len, subflow->map_csum);
>
> validate_seq:
> 	/* we revalidate valid mapping on new skb, because we must ensure
> -- 
> 2.30.2
>
>
>

--
Mat Martineau
Intel
