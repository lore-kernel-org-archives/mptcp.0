Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404BA72
	for <mptcp@lists.linux.dev>; Tue, 13 Jul 2021 20:35:13 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="232042742"
X-IronPort-AV: E=Sophos;i="5.84,237,1620716400"; 
   d="scan'208";a="232042742"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 13:35:11 -0700
X-IronPort-AV: E=Sophos;i="5.84,237,1620716400"; 
   d="scan'208";a="649646886"
Received: from tpierc1x-mobl1.amr.corp.intel.com ([10.209.110.90])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 13:35:11 -0700
Date: Tue, 13 Jul 2021 13:35:10 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Geliang Tang <geliangtang@gmail.com>
cc: mptcp@lists.linux.dev
Subject: Re: [MPTCP][PATCH v3 mptcp-next 3/8] mptcp: send out MP_FAIL when
 data checksum fail
In-Reply-To: <CA+WQbwv_dpYt6aKAA4g-pV2HYDKM5Y4G_K-nY31ZLLLwkpLCHA@mail.gmail.com>
Message-ID: <e53ce4a6-d4a2-1248-9541-8b3c643e939c@linux.intel.com>
References: <cover.1624854005.git.geliangtang@gmail.com> <3cc57b70ec147b4c77610737241aeadf4150f323.1624854005.git.geliangtang@gmail.com> <d10ab4b89d053ba9a3debc9c7f6bdab0ca0d95bd.1624854005.git.geliangtang@gmail.com>
 <30a102a69a09fe644776dbddc93a1a3710c0fd51.1624854005.git.geliangtang@gmail.com> <ce51fdd8-f261-a17-ce9e-362b8712cc55@linux.intel.com> <CA+WQbwv_dpYt6aKAA4g-pV2HYDKM5Y4G_K-nY31ZLLLwkpLCHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1024008088-1626208511=:51498"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1024008088-1626208511=:51498
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 13 Jul 2021, Geliang Tang wrote:

> Hi Mat,
>
> Sorry for late response on this.
>
> Mat Martineau <mathew.j.martineau@linux.intel.com> 于2021年7月8日周四 上午7:20写道：
>>
>> On Mon, 28 Jun 2021, Geliang Tang wrote:
>>
>>> When a bad checksum is detected, send out the MP_FAIL option.
>>>
>>> When multiple subflows are in use, close the affected subflow with a RST
>>> that includes an MP_FAIL option.
>>>
>>> When a single subfow is in use, send back an MP_FAIL option on the
>>> subflow-level ACK. And the receiver of this MP_FAIL respond with an
>>> MP_FAIL in the reverse direction.
>>>
>>> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
>>> ---
>>> net/mptcp/pm.c       | 10 ++++++++++
>>> net/mptcp/protocol.h | 14 ++++++++++++++
>>> net/mptcp/subflow.c  | 18 ++++++++++++++++++
>>> 3 files changed, 42 insertions(+)
>>>
>>> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
>>> index d4c19420194a..c34c9c0b2fa5 100644
>>> --- a/net/mptcp/pm.c
>>> +++ b/net/mptcp/pm.c
>>> @@ -250,8 +250,18 @@ void mptcp_pm_mp_prio_received(struct sock *sk, u8 bkup)
>>> void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
>>> {
>>>       struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
>>> +     struct mptcp_sock *msk = mptcp_sk(subflow->conn);
>>>
>>>       pr_debug("map_seq=%llu fail_seq=%llu", subflow->map_seq, fail_seq);
>>> +
>>> +     if (!msk->pm.subflows) {
>>
>> The pm.lock isn't held so it's not safe to access pm.subflows
>>
>> I don't think it's sufficient to read pm.subflows with the lock or add
>> READ_ONCE/WRITE_ONCE, since that would still allow race conditions with
>> the msk. To handle fallback when receiving MP_FAIL I think the
>> sock_owned_by_user() checks and delegated callback (similar to
>> mptcp_subflow_process_delegated()) may be needed.
>>
>
> I think it's better to use the below mptcp_has_another_subflow() function
> here instead of using msk->pm.subflows to check the single subflow case.
>

Yes, that sounds good.

>>> +             if (!subflow->mp_fail_need_echo) {
>>> +                     subflow->send_mp_fail = 1;
>>> +                     subflow->fail_seq = fail_seq;
>>
>> Echoing the fail_seq back doesn't seem correct, from the RFC it seems like
>> this side should send a sequence number for the opposite data direction?
>> Do you agree?
>
> So we should use 'subflow->fail_seq = subflow->map_seq;' here?

I think so - but I'm concerned about the possibility of out-of-order data 
and checking for single- or multiple-subflow cases. I need to look at the 
RFC some more to tell for sure.

>
>>
>>> +             } else {
>>> +                     subflow->mp_fail_need_echo = 0;
>>> +             }
>>> +     }
>>> }
>>>
>>> /* path manager helpers */
>>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>>> index 8e050575a2d9..7a49454c77a6 100644
>>> --- a/net/mptcp/protocol.h
>>> +++ b/net/mptcp/protocol.h
>>> @@ -422,6 +422,7 @@ struct mptcp_subflow_context {
>>>               backup : 1,
>>>               send_mp_prio : 1,
>>>               send_mp_fail : 1,
>>> +             mp_fail_need_echo : 1,
>>
>> I think mp_fail_expect_echo would be a more accurate name.
>
> Updated in v4.
>

Ok.

>>
>>>               rx_eof : 1,
>>>               can_ack : 1,        /* only after processing the remote a key */
>>>               disposable : 1;     /* ctx can be free at ulp release time */
>>> @@ -594,6 +595,19 @@ static inline void mptcp_subflow_tcp_fallback(struct sock *sk,
>>>       inet_csk(sk)->icsk_af_ops = ctx->icsk_af_ops;
>>> }
>>>
>>> +static inline bool mptcp_has_another_subflow_established(struct sock *ssk)
>>> +{
>>> +     struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk), *tmp;
>>> +     struct mptcp_sock *msk = mptcp_sk(subflow->conn);
>>> +
>>> +     mptcp_for_each_subflow(msk, tmp) {
>>> +             if (tmp->fully_established && tmp != subflow)
>>
>> Why check tmp->fully_established here?
>
> I'll drop tmp->fully_established, and rename this function
> mptcp_has_another_subflow to check whether there's a single subflow.

Sounds good.

>
>
> In my test, this MP_FAIL patchset only works in the multiple subflows case.
> The receiver detected the bad checksum, sent RST + MP_FAIL to close this
> subflow and discard the data with the bad checksum. Then the sender will
> retransmit a new data with good checksum from other subflow. And the
> receiver can resemble the whole data successfully.
>
> But the single subflow case dosen't work. I don't know how the new data
> can be retransmitted from the sender side when it fallback to regular TCP.
> So I'm not sure how to implement the single subflow case.
>
> Could you please give me some suggestions?

Yes, the multiple subflow case is the simpler one this time. We can throw 
away the affected subflow and recover using the others.

Since the non-contiguous, single subflow case has to close the subflow, 
that's more like the "easier" case.

So, it's the infinite mapping case that's tricky. Have you looked at the 
multipath-tcp.org code? The important part seems to be using the 
information in the infinite mapping to determine what data to keep or 
throw away before beginning "fallback" behavior. I can look at the 
infinite mapping information in the RFC and see how that fits with our 
implementation tomorrow.

- Mat


>>
>>> +                     return true;
>>> +     }
>>> +
>>> +     return false;
>>> +}
>>> +
>>> void __init mptcp_proto_init(void);
>>> #if IS_ENABLED(CONFIG_MPTCP_IPV6)
>>> int __init mptcp_proto_v6_init(void);
>>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>>> index 0b5d4a3eadcd..46302208c474 100644
>>> --- a/net/mptcp/subflow.c
>>> +++ b/net/mptcp/subflow.c
>>> @@ -913,6 +913,8 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
>>>       csum = csum_partial(&header, sizeof(header), subflow->map_data_csum);
>>>       if (unlikely(csum_fold(csum))) {
>>>               MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
>>> +             subflow->send_mp_fail = 1;
>>> +             subflow->fail_seq = subflow->map_seq;
>>>               return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
>>>       }
>>>
>>> @@ -1160,6 +1162,22 @@ static bool subflow_check_data_avail(struct sock *ssk)
>>>
>>> fallback:
>>>       /* RFC 8684 section 3.7. */
>>> +     if (subflow->send_mp_fail) {
>>> +             if (mptcp_has_another_subflow_established(ssk)) {
>>> +                     mptcp_subflow_reset(ssk);
>>> +                     while ((skb = skb_peek(&ssk->sk_receive_queue)))
>>> +                             sk_eat_skb(ssk, skb);
>>> +                     WRITE_ONCE(subflow->data_avail, 0);
>>> +                     return true;
>>> +             }
>>> +
>>> +             if (!msk->pm.subflows) {
>>> +                     subflow->mp_fail_need_echo = 1;
>>> +                     WRITE_ONCE(subflow->data_avail, 0);
>>> +                     return true;
>>> +             }
>>> +     }
>>> +
>>>       if (subflow->mp_join || subflow->fully_established) {
>>>               /* fatal protocol error, close the socket.
>>>                * subflow_error_report() will introduce the appropriate barriers
>>> --
>>> 2.31.1

--
Mat Martineau
Intel
--0-1024008088-1626208511=:51498--
