Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14623208
	for <mptcp@lists.linux.dev>; Wed, 11 May 2022 21:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652303074; x=1683839074;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yL0YIkSEDA5mChPF9Wjq5eMdx81EXk3YNP0kROt3Iyc=;
  b=HbMgCzfvCLQ9kmHUZLk1zgXCGf+T5Jw+MMCHOPnY7sJVBBv7kAhgCWUx
   FnHZe0hUajaqwHRyMi/wT3vWZegiTOfikRr84ENCZi8WZSH8K7yMpmhrV
   gkC6tTysH3K73oaM7VXOIt6GJ8xu2twMSkBvOUm/V5yMUpbj163pvI6+J
   TQQ2He2VmtfXj3Oj13BYTZAVhQMEQLUt98UYG3ElsQ+CWxr+9YiJ1qezF
   B98tWZd5/Zm0rlj7OUYA/Iur120TQyq9cufZt8HNLLClcF5+IGDTEceTr
   pfFrv1AsDq5elHuzR2JPFFuGLfrw2L/ZRycHq+rnvOJu5vg5Dx9J+GHgB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="269750846"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="269750846"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 14:04:34 -0700
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="814636353"
Received: from rdstein-mobl.amr.corp.intel.com ([10.212.177.197])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 14:04:33 -0700
Date: Wed, 11 May 2022 14:04:33 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: Paolo Abeni <pabeni@redhat.com>, MPTCP Upstream <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net] mptcp: Do TCP fallback on early DSS checksum
 failure
In-Reply-To: <CA+WQbwt4F=ymHM2CqnyNKLK6ds+uvV36kRfimq-sBE9uSxmGPA@mail.gmail.com>
Message-ID: <406724b6-297e-4ad-eaf-cf9425671b8@linux.intel.com>
References: <20220510000320.82652-1-mathew.j.martineau@linux.intel.com> <7f458d7eaf9ed5180d9e3d0295949a717ba3c895.camel@redhat.com> <CA+WQbwt4F=ymHM2CqnyNKLK6ds+uvV36kRfimq-sBE9uSxmGPA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-564765746-1652303073=:15525"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-564765746-1652303073=:15525
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 11 May 2022, Geliang Tang wrote:

> Paolo Abeni <pabeni@redhat.com> 于2022年5月11日周三 18:31写道：
>>
>> On Mon, 2022-05-09 at 17:03 -0700, Mat Martineau wrote:
>>> RFC 8684 section 3.7 describes several opportunities for a MPTCP
>>> connection to "fall back" to regular TCP early in the connection
>>> process, before it has been confirmed that MPTCP options can be
>>> successfully propagated on all SYN, SYN/ACK, and data packets. If a peer
>>> acknowledges the first received data packet with a regular TCP header
>>> (no MPTCP options), fallback is allowed.
>>>
>>> If the recipient of that first data packet finds a MPTCP DSS checksum
>>> error, this provides an opportunity to fail gracefully with a TCP
>>> fallback rather than resetting the connection (as might happen if a
>>> checksum failure were detected later).
>>>
>>> This commit modifies the checksum failure code to attempt fallback on
>>> the initial subflow of a MPTCP connection, only if it's a failure in the
>>> first data mapping. In cases where the peer initiates the connection,
>>> requests checksums, is the first to send data, and the peer is sending
>>> incorrect checksums (see
>>> https://github.com/multipath-tcp/mptcp_net-next/issues/275), this allows
>>> the connection to proceed as TCP rather than reset.
>>>
>>> Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
>>> ---
>>>
>>> I tested this on the export-net branch along with Paolo's proposed
>>> checksum fix ("mptcp: fix checksum byte order"). Testing between the
>>> patched export-net kernel and 5.17.5-200.fc35.x86_64 (Fedora) showed the
>>> fallback succeeding if checksums are enabled on one side, export-net was
>>> the listener, and 5.17.5 initiated the connection and sent the first
>>> data. Without this patch, if one side has the fixed checksum byte order
>>> then all connections would reset after a checksum failure.
>>>
>>> ---
>>>  net/mptcp/protocol.h |  3 ++-
>>>  net/mptcp/subflow.c  | 15 ++++++++++++---
>>>  2 files changed, 14 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>>> index f4ce28bb0fdc..6c7e78ec88e8 100644
>>> --- a/net/mptcp/protocol.h
>>> +++ b/net/mptcp/protocol.h
>>> @@ -443,7 +443,8 @@ struct mptcp_subflow_context {
>>>               can_ack : 1,        /* only after processing the remote a key */
>>>               disposable : 1,     /* ctx can be free at ulp release time */
>>>               stale : 1,          /* unable to snd/rcv data, do not use for xmit */
>>> -             local_id_valid : 1; /* local_id is correctly initialized */
>>> +             local_id_valid : 1, /* local_id is correctly initialized */
>>> +             valid_csum_seen : 1;        /* at least one csum validated */
>>>       enum mptcp_data_avail data_avail;
>>>       u32     remote_nonce;
>>>       u64     thmac;
>>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>>> index 8c37087f0d84..3a7b02a92239 100644
>>> --- a/net/mptcp/subflow.c
>>> +++ b/net/mptcp/subflow.c
>>> @@ -955,11 +955,14 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
>>>                                subflow->map_data_csum);
>>>       if (unlikely(csum)) {
>>>               MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
>>> -             subflow->send_mp_fail = 1;
>>> -             MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPFAILTX);
>>> +             if (subflow->mp_join || subflow->valid_csum_seen) {
>>> +                     subflow->send_mp_fail = 1;
>>> +                     MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPFAILTX);
>>> +             }
>>>               return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
>>>       }
>>>
>>> +     subflow->valid_csum_seen = 1;
>>>       return MAPPING_OK;
>>>  }
>>>
>>> @@ -1145,6 +1148,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
>>>  {
>>>       struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
>>>       enum mapping_status status;
>>> +     bool fallback_impossible;
>>>       struct mptcp_sock *msk;
>>>       struct sk_buff *skb;
>>>
>>> @@ -1218,7 +1222,12 @@ static bool subflow_check_data_avail(struct sock *ssk)
>>>               return true;
>>>       }
>>>
>>> -     if (subflow->mp_join || subflow->fully_established) {
>>> +     if (READ_ONCE(msk->csum_enabled))
>>> +             fallback_impossible = subflow->valid_csum_seen;
>>> +     else
>>> +             fallback_impossible = subflow->fully_established;
>>> +
>
> Mat, how about using this instead:
>
> fallback_impossible = READ_ONCE(msk->csum_enabled) ? subflow->valid_csum_seen :
>
>                          subflow->fully_established;
>

I did consider that but the line wrapping with the ?: operator seemed 
awkward.

>>> +     if (subflow->mp_join || fallback_impossible) {
>>>               /* fatal protocol error, close the socket.
>>>                * subflow_error_report() will introduce the appropriate barriers
>>>                */
>>
>> LGTM, thanks! Perhaps the last chunk can be encapsulated in an helper:
>>
>> subflow_is_fallback_possible(subflow, msk)
>>
>> embedding all the relevant test?
>>

Yeah, I'll do that for v2.

>> Either ways:
>>
>> Acked-by: Paolo Abeni <pabeni@redhat.com>

Thanks!


--
Mat Martineau
Intel
--0-564765746-1652303073=:15525--
