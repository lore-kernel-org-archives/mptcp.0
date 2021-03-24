Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922786F
	for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 01:07:40 +0000 (UTC)
IronPort-SDR: SbcT4rFx9zjTsGSkcHYMhkPS7slKd7qiL8MjQk3ZuBlZO+oxZewNE8PIX3C1nSD+ON+0mEdsLj
 NJT5WNZWiNqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="188281034"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="188281034"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 18:07:39 -0700
IronPort-SDR: ylMVX0UAAKfpD/MkwsWUGzj+iwapX4/8xIwVPKYO3k/TvdpwvDmtgo7yl+iTEcOgse6jRE/A0L
 ElZp9G91XeYw==
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="391103701"
Received: from dnwagbuo-mobl1.amr.corp.intel.com ([10.252.143.194])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 18:07:39 -0700
Date: Tue, 23 Mar 2021 18:07:39 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: Geliang Tang <geliangtang@gmail.com>, mptcp@lists.01.org, 
    mptcp@lists.linux.dev
Subject: Re: [MPTCP] Re: [MPTCP][PATCH mptcp-next 4/6] mptcp: add the DSS
 checksum sending
In-Reply-To: <4ca665eeba3d66ee4d213eba2eb5e91ef2ceed95.camel@redhat.com>
Message-ID: <cf47f387-8561-67bb-9ca8-984fcf18ba2b@linux.intel.com>
References: <cover.1616412490.git.geliangtang@gmail.com>  <e56c579836e40e330bfd24a191fd0c313a9e4634.1616412490.git.geliangtang@gmail.com>  <7ad133370d4bb939ba69e35203797494181873b0.1616412490.git.geliangtang@gmail.com> 
 <33da8b854a7397e7ecc807b335a0c7e69e023ca6.1616412490.git.geliangtang@gmail.com>  <643a31ae30f00dd0d1d49834f6e996b3fe637c47.1616412490.git.geliangtang@gmail.com>  <41604ba7-65b8-7675-3f12-bfb6c124c61d@linux.intel.com>
 <4ca665eeba3d66ee4d213eba2eb5e91ef2ceed95.camel@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 23 Mar 2021, Paolo Abeni wrote:

> On Mon, 2021-03-22 at 16:10 -0700, Mat Martineau wrote:
>> On Mon, 22 Mar 2021, Geliang Tang wrote:
>>
>>> In mptcp_established_options_dss, use the new function
>>> mptcp_generate_dss_csum to generate the DSS checksum value.
>>>
>>> In mptcp_write_options, send out DSS with the checksum value.
>>>
>>> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
>>> ---
>>> include/net/mptcp.h  |  1 +
>>> net/mptcp/options.c  | 41 ++++++++++++++++++++++++++++++++++++++---
>>> net/mptcp/protocol.h |  7 +++++++
>>> 3 files changed, 46 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
>>> index 36fb6907aa6f..869a6d98a72e 100644
>>> --- a/include/net/mptcp.h
>>> +++ b/include/net/mptcp.h
>>> @@ -32,6 +32,7 @@ struct mptcp_ext {
>>> 			frozen:1,
>>> 			reset_transient:1;
>>> 	u8		reset_reason:4;
>>> +	u16		csum;
>>> };
>>>
>>> #define MPTCP_RM_IDS_MAX	8
>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>> index bdced173edff..69eb15ef9385 100644
>>> --- a/net/mptcp/options.c
>>> +++ b/net/mptcp/options.c
>>> @@ -521,6 +521,30 @@ static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
>>> 	}
>>> }
>>>
>>> +static u16 mptcp_generate_dss_csum(struct sk_buff *skb)
>>> +{
>>> +	struct csum_pseudo_header header;
>>> +	struct mptcp_ext *mpext;
>>> +	__wsum csum;
>>> +
>>> +	if (!skb)
>>> +		return 0;
>>> +
>>> +	mpext = mptcp_get_ext(skb);
>>> +	if (!mpext || !mpext->use_map)
>>> +		return 0;
>>> +
>>> +	header.data_seq = mpext->data_seq;
>>> +	header.subflow_seq = mpext->subflow_seq;
>>> +	header.data_len = mpext->data_len;
>>> +	header.csum = 0;
>>> +
>>> +	csum = skb_checksum(skb, 0, skb->len, 0);
>>> +	csum = csum_partial(&header, sizeof(header), csum);
>>> +
>>> +	return csum_fold(csum);
>>> +}
>>> +
>>> static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
>>> 					  bool snd_data_fin_enable,
>>> 					  unsigned int *size,
>>> @@ -544,8 +568,11 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
>>>
>>> 		remaining -= map_size;
>>> 		dss_size = map_size;
>>> -		if (mpext)
>>> +		if (mpext) {
>>> +			if (msk->csum_reqd)
>>> +				mpext->csum = mptcp_generate_dss_csum(skb);
>>> 			opts->ext_copy = *mpext;
>>> +		}
>>>
>>> 		if (skb && snd_data_fin_enable)
>>> 			mptcp_write_data_fin(subflow, skb, &opts->ext_copy);
>>> @@ -1304,6 +1331,9 @@ void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>>> 			flags |= MPTCP_DSS_HAS_MAP | MPTCP_DSS_DSN64;
>>> 			if (mpext->data_fin)
>>> 				flags |= MPTCP_DSS_DATA_FIN;
>>> +
>>> +			if (mpext->csum)
>>
>> Instead of relying on a non-zero mpext->csum, what about using
>> opts->csum_enabled instead? (Would have to make sure that flag is set in
>> mptcp_out_options for data packets too)
>>
>> This would be more compatible with hardware offload if that gets added
>> later.
>
> Side note, not sure if already discussed in the last mtgs, xmit csum
> offload looks doable, togethar with TSO !?! The nic have all the pieces
> in place/available to compute it...
>

Yes, I did talk about this with one of the NIC maintainers and the tx side 
seemed doable. See notes near the end of 
https://lore.kernel.org/mptcp/e308928e-872d-a7b3-2b0b-751572915de2@tessares.net/

--
Mat Martineau
Intel
