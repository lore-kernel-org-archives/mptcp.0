Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B241C6F
	for <mptcp@lists.linux.dev>; Wed, 24 Mar 2021 00:52:14 +0000 (UTC)
IronPort-SDR: 9tbIC41Ck6abdMCFGaJmGBRSORcVQVRWz+zHeeruvL7csUwvpp5XELdMjXODSjGT5NVvY7y2RJ
 eVqEncJ0UM8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="169928794"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="169928794"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 17:52:10 -0700
IronPort-SDR: 4z7VVsOTyGicv/7yOwFdmvQOiFwsDGIlbDdxxKTFTLyWdnoS3Lukeni2tqowioOj+YOyJIwI2g
 dpDEBIj2sUAA==
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="513977480"
Received: from dnwagbuo-mobl1.amr.corp.intel.com ([10.252.143.194])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 17:52:09 -0700
Date: Tue, 23 Mar 2021 17:52:09 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp <mptcp@lists.01.org>, mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH mptcp-next 5/6] mptcp: add the DSS checksum
 receiving
In-Reply-To: <CA+WQbwucpkpczKvvLhrjt_2NivwTbitD-Y1DREjrSEUdCtsZgw@mail.gmail.com>
Message-ID: <be37aeab-85fc-3f4e-3b98-93fa85121297@linux.intel.com>
References: <cover.1616412490.git.geliangtang@gmail.com> <e56c579836e40e330bfd24a191fd0c313a9e4634.1616412490.git.geliangtang@gmail.com> <7ad133370d4bb939ba69e35203797494181873b0.1616412490.git.geliangtang@gmail.com>
 <33da8b854a7397e7ecc807b335a0c7e69e023ca6.1616412490.git.geliangtang@gmail.com> <643a31ae30f00dd0d1d49834f6e996b3fe637c47.1616412490.git.geliangtang@gmail.com> <7762b80e2310ae0f1a09ec5a4324293d8e9943eb.1616412490.git.geliangtang@gmail.com>
 <5cff4d79-a754-c99d-976f-ea2a89541781@linux.intel.com> <CA+WQbwucpkpczKvvLhrjt_2NivwTbitD-Y1DREjrSEUdCtsZgw@mail.gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2013041558-1616547129=:6220"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-2013041558-1616547129=:6220
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 23 Mar 2021, Geliang Tang wrote:

> Hi Mat,
>
> Mat Martineau <mathew.j.martineau@linux.intel.com> 于2021年3月23日周二 上午7:40写道：
>>
>> On Mon, 22 Mar 2021, Geliang Tang wrote:
>>
>>> This patch added a new member csum in struct mptcp_options_received. In
>>> mptcp_parse_option, parse the checksum value from the receiving DSS, and
>>> save it in mp_opt->csum. In mptcp_incoming_options, pass it to
>>> mpext->csum.
>>>
>>> In validate_mapping, use the new function validate_dss_csum to validata
>>> the DSS checksum.
>>>
>>> In validate_dss_csum, if the data has been split in different packets,
>>> skip validating.
>>>
>>> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
>>> ---
>>> net/mptcp/options.c  | 13 +++++++++++--
>>> net/mptcp/protocol.h |  1 +
>>> net/mptcp/subflow.c  | 37 +++++++++++++++++++++++++++++++++++++
>>> 3 files changed, 49 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>> index 69eb15ef9385..ed89f6c2ed49 100644
>>> --- a/net/mptcp/options.c
>>> +++ b/net/mptcp/options.c
>>> @@ -206,9 +206,14 @@ static void mptcp_parse_option(const struct sk_buff *skb,
>>>                       mp_opt->data_len = get_unaligned_be16(ptr);
>>>                       ptr += 2;
>>>
>>> -                     pr_debug("data_seq=%llu subflow_seq=%u data_len=%u",
>>> +                     if (opsize == expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM) {
>>
>> Now that more of the checksum code has been added, I think that
>> expected_opsize should be set to the exact value that is needed - either
>> expect the checksum, or don't expect the checksum.
>>
>> RFC 6824 said: "If a checksum is present, but its use had not been
>> negotiated in the MP_CAPABLE handshake, the checksum field MUST be
>> ignored."
>>
>> RFC 8684 says: "If a checksum is present but its use had
>> not been negotiated in the MP_CAPABLE handshake, the receiver MUST
>> close the subflow with a RST, as it is not behaving as negotiated.
>> If a checksum is not present when its use has been negotiated, the
>> receiver MUST close the subflow with a RST, as it is considered
>> broken."
>>
>> There's some old RFC 6824-based code earlier in the function:
>>
>>                 if (opsize != expected_opsize &&
>>                     opsize != expected_opsize + TCPOLEN_MPTCP_DSS_CHECKSUM)
>>                         break;
>>
>> That needs to be changed to:
>>
>>                 if (opsize != expected_opsize)
>>                         break;
>>
>> and expected_opsize should include TCPOLEN_MPTCP_DSS_CHECKSUM only if the
>> checksum is enabled.
>>
>>> +                             mp_opt->csum = get_unaligned_be16(ptr);
>>> +                             ptr += 2;
>>> +                     }
>>> +
>>> +                     pr_debug("data_seq=%llu subflow_seq=%u data_len=%u csum=%u",
>>>                                mp_opt->data_seq, mp_opt->subflow_seq,
>>> -                              mp_opt->data_len);
>>> +                              mp_opt->data_len, mp_opt->csum);
>>>               }
>>>
>>>               break;
>>> @@ -339,6 +344,7 @@ void mptcp_get_options(const struct sk_buff *skb,
>>>       mp_opt->mp_prio = 0;
>>>       mp_opt->reset = 0;
>>>       mp_opt->csum_reqd = 0;
>>> +     mp_opt->csum = 0;
>>>
>>>       length = (th->doff * 4) - sizeof(struct tcphdr);
>>>       ptr = (const unsigned char *)(th + 1);
>>> @@ -1124,6 +1130,9 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>>>               }
>>>               mpext->data_len = mp_opt.data_len;
>>>               mpext->use_map = 1;
>>> +
>>> +             if (READ_ONCE(msk->csum_reqd))
>>> +                     mpext->csum = mp_opt.csum;
>>>       }
>>> }
>>>
>>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>>> index f62cea8635f0..51ef3173a2e5 100644
>>> --- a/net/mptcp/protocol.h
>>> +++ b/net/mptcp/protocol.h
>>> @@ -123,6 +123,7 @@ struct mptcp_options_received {
>>>       u64     data_seq;
>>>       u32     subflow_seq;
>>>       u16     data_len;
>>> +     u16     csum;
>>>       u16     mp_capable : 1,
>>>               mp_join : 1,
>>>               fastclose : 1,
>>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>>> index 9fec1a273100..2eeea7d527f0 100644
>>> --- a/net/mptcp/subflow.c
>>> +++ b/net/mptcp/subflow.c
>>> @@ -799,10 +799,45 @@ static bool skb_is_fully_mapped(struct sock *ssk, struct sk_buff *skb)
>>>                                         mptcp_subflow_get_map_offset(subflow);
>>> }
>>>
>>> +static bool validate_dss_csum(struct sock *ssk, struct sk_buff *skb)
>>> +{
>>> +     struct csum_pseudo_header header;
>>> +     struct mptcp_ext *mpext;
>>> +     __wsum csum;
>>> +
>>> +     if (!skb)
>>> +             goto out;
>>> +
>>> +     mpext = mptcp_get_ext(skb);
>>> +     if (!mpext || !mpext->use_map || !mpext->csum ||
>>> +         mpext->data_len != skb->len)
>>> +             goto out;
>>> +
>>> +     header.data_seq = mpext->data_seq;
>>> +     header.subflow_seq = mpext->subflow_seq;
>>> +     header.data_len = mpext->data_len;
>>> +     header.csum = mpext->csum;
>>> +
>>> +     csum = skb_checksum(skb, 0, skb->len, 0);
>>
>> The checksum isn't calculated using the data from a single skb, it
>> requires the complete reassembled data for the current mapping. If we're
>> lucky, GRO has placed everything in one skb. But that can't be assumed.
>>
>> The checksum can be calculated incrementally as skbs arrive, but checksum
>> verification will require changes to data reassembly and MPTCP-level
>> acknowledgements, and will delay movement of data to the msk until the
>> checksum is verified. Also review my comments on the MP_FAIL RFC patch:
>
> I need some help here.
>
> How can I get the reassembled data for the current mapping? And in which
> function to calculate the skbs checksum and where to verify them? Could
> you please give me more detail?
>

Look at __mptcp_mvoe_skbs_from_subflow() - the skbs will arrive in 
ssk->sk_receive_queue. The way the rx code works now, it is fairly 
aggressive about moving data to the msk as quickly as possible.

There will need to be a check to see if checksums are enabled, delaying 
the call to __mptcp_move_skb() until enough data is available in 
ssk->sk_receive_queue for the full mapping (ssk->map_data_len), then 
validating the checksum for the pseudoheader and the full mapping, and 
finally moving the skbs covered by that mapping.

The data covered by the checksum might not align with the skbs, so the 
code will have to make sure it is only using the data with sequence 
numbers in the range required by the mapping.

Delaying __mptcp_move_skb() will also delay changes to msk->ack_seq, which 
is a good thing: that will mean the data is not acked until the checksum 
is validated.


Does that give a good place to start? The exact place to calculate the 
checksum isn't immediately obvious - might be up the call stack from where 
__mptcp_move_skb() is called.

Mat


>
>>
>> https://lists.01.org/hyperkitty/list/mptcp@lists.01.org/message/KSEEB5Q4ND3GKOW7S3FZ32PHCWWON5QC/
>>
>>
>> Thanks for the patch set!
>>
>> Mat
>>
>>
>>> +     csum = csum_partial(&header, sizeof(header), csum);
>>> +
>>> +     if (csum_fold(csum)) {
>>> +             pr_err("DSS checksum error! data_seq=%llu subflow_seq=%u data_len=%u csum=%u %u",
>>> +                    header.data_seq, header.subflow_seq, header.data_len,
>>> +                    header.csum, csum_fold(csum));
>>> +
>>> +             return false;
>>> +     }
>>> +
>>> +out:
>>> +     return true;
>>> +}
>>> +
>>> static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
>>> {
>>>       struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
>>>       u32 ssn = tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
>>> +     struct mptcp_sock *msk = mptcp_sk(subflow->conn);
>>>
>>>       if (unlikely(before(ssn, subflow->map_subflow_seq))) {
>>>               /* Mapping covers data later in the subflow stream,
>>> @@ -817,6 +852,8 @@ static bool validate_mapping(struct sock *ssk, struct sk_buff *skb)
>>>               warn_bad_map(subflow, ssn + skb->len);
>>>               return false;
>>>       }
>>> +     if (READ_ONCE(msk->csum_reqd))
>>> +             validate_dss_csum(ssk, skb);
>>>       return true;
>>> }
>>>
>>> --
>>> 2.30.2
>>
>> --
>> Mat Martineau
>> Intel
>

--
Mat Martineau
Intel
--0-2013041558-1616547129=:6220--
