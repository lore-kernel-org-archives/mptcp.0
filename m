Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C2D177
	for <mptcp@lists.linux.dev>; Tue, 29 Jun 2021 03:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=bbcVu
	837PdDwE/1G/Qo1U3bz4fYZmQN9YjWHMCjdPrU=; b=PIGuM69kdQNoV/hwjC5we
	sKwuZGVakFO+A/fb+GOUdp8eO8B41i5Y9JWpTwSy7gpDANF8BLwaD2vkwyBAFALs
	KnPbgDMFU5pV/2ukC9K75Ylwsmw3xsrl/F/7XT+p0JcRPAK/WhXCZ+SCGuv4Mq47
	mfIDnRvbC6kVhpwoLU+H+M=
Received: from [10.8.2.126] (unknown [36.111.140.26])
	by smtp11 (Coremail) with SMTP id D8CowAD3YqSti9pgDLDRAg--.69S2;
	Tue, 29 Jun 2021 10:57:12 +0800 (CST)
Subject: Re: [PATCH mptcp-net v8 4/5] mptcp: avoid processing packet if a
 subflow reset
To: Geliang Tang <geliangtang@gmail.com>
Cc: mptcp@lists.linux.dev, Paolo Abeni <pabeni@redhat.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
References: <1624698998-9029-1-git-send-email-wujianguo106@163.com>
 <1624698998-9029-5-git-send-email-wujianguo106@163.com>
 <CA+WQbwuJ64zQcCnOAwqw9_Mxud6BRJu300sP4pWFOeU7FH8nEA@mail.gmail.com>
From: Jianguo Wu <wujianguo106@163.com>
Message-ID: <9d701256-cc74-648b-cc0b-b91a2ec04450@163.com>
Date: Tue, 29 Jun 2021 10:55:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CA+WQbwuJ64zQcCnOAwqw9_Mxud6BRJu300sP4pWFOeU7FH8nEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:D8CowAD3YqSti9pgDLDRAg--.69S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKr1DArWxur4fJrWrZryxZrb_yoW3tFWrpF
	nxG3W3Jr4kXFyxWr1IyF48Wr1F9w4rtrZ8Gw4UG3WrAr1qyF1xtFy8KF1F9rW7GFW093W3
	Jr4UAF17uF17AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07juE_NUUUUU=
X-Originating-IP: [36.111.140.26]
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/xtbBSQjAkFaD-EH--wAAs5

Hi Geliang,

On 2021/6/28 16:35, Geliang Tang wrote:
> Hi Jianguo,
> 
> Thank you for this new patch set!
> 
> There are three checkpatch.pl warnings in this patch set, please fix them.
> And a minor comment below.
> 

Thanks for your checking and comment, I should do more checking next time.

> ---------------------------------------------------------------
> 0001-mptcp-fix-warning-in-__skb_flow_dissect-when-do-syn-.patch
> ---------------------------------------------------------------
> WARNING: Possible unwrapped commit description (prefer a maximum 75
> chars per line)
> #7:
> I did stress test with wrk(https://github.com/wg/wrk) and
> webfsd(https://github.com/ourway/webfsd)
> 
> total: 0 errors, 1 warnings, 0 checks, 22 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> 0001-mptcp-fix-warning-in-__skb_flow_dissect-when-do-syn-.patch has
> style problems, please review.
> ---------------------------------------------------------------
> 0002-mptcp-remove-redundant-req-destruct-in-subflow_check.patch
> ---------------------------------------------------------------
> WARNING: Possible unwrapped commit description (prefer a maximum 75
> chars per line)
> #14:
> tcp_v4_reqsk_destructor() twice, and may double free inet_rsk(req)->ireq_opt.
> 
> total: 0 errors, 1 warnings, 0 checks, 11 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> 0002-mptcp-remove-redundant-req-destruct-in-subflow_check.patch has
> style problems, please review.
> ---------------------------------------------------------------
> 0005-selftests-mptcp-fix-case-multiple-subflows-limited-b.patch
> ---------------------------------------------------------------
> WARNING: Possible unwrapped commit description (prefer a maximum 75
> chars per line)
> #7:
> After patch "mptcp: fix syncookie process if mptcp can not_accept new subflow",
> 
> total: 0 errors, 1 warnings, 8 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> 0005-selftests-mptcp-fix-case-multiple-subflows-limited-b.patch has
> style problems, please review.
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
> 
> <wujianguo106@163.com> 于2021年6月26日周六 下午5:17写道：
>>
>> From: Jianguo Wu <wujianguo@chinatelecom.cn>
>>
>> If check_fully_established() causes a subflow reset, it should not
>> continue to process the packet in tcp_data_queue().
>> Add a return value to mptcp_incoming_options(), and return false if a
>> subflow has been reset, else return true. Then drop the packet in
>> tcp_data_queue()/tcp_rcv_state_process() if mptcp_incoming_options()
>> return false.
>>
>> Fixes: d582484726c4 ("mptcp: fix fallback for MP_JOIN subflows")
>> Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
>> ---
>>  include/net/mptcp.h  |  5 +++--
>>  net/ipv4/tcp_input.c | 19 +++++++++++++++----
>>  net/mptcp/options.c  | 19 +++++++++++++------
>>  3 files changed, 31 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
>> index cb580b0..8b5af68 100644
>> --- a/include/net/mptcp.h
>> +++ b/include/net/mptcp.h
>> @@ -105,7 +105,7 @@ bool mptcp_synack_options(const struct request_sock *req, unsigned int *size,
>>  bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>>                                unsigned int *size, unsigned int remaining,
>>                                struct mptcp_out_options *opts);
>> -void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
>> +bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb);
>>
>>  void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
>>                          struct mptcp_out_options *opts);
>> @@ -227,9 +227,10 @@ static inline bool mptcp_established_options(struct sock *sk,
>>         return false;
>>  }
>>
>> -static inline void mptcp_incoming_options(struct sock *sk,
>> +static inline bool mptcp_incoming_options(struct sock *sk,
>>                                           struct sk_buff *skb)
>>  {
>> +       return true;
>>  }
>>
>>  static inline void mptcp_skb_ext_move(struct sk_buff *to,
>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>> index 7d5e59f..4bacd7d 100644
>> --- a/net/ipv4/tcp_input.c
>> +++ b/net/ipv4/tcp_input.c
>> @@ -4247,6 +4247,9 @@ void tcp_reset(struct sock *sk, struct sk_buff *skb)
>>  {
>>         trace_tcp_receive_reset(sk);
>>
>> +       /* mptcp can't tell us to ignore reset pkts,
>> +        * so just ignore the return value of mptcp_incoming_options().
>> +        */
>>         if (sk_is_mptcp(sk))
>>                 mptcp_incoming_options(sk, skb);
>>
>> @@ -4941,8 +4944,13 @@ static void tcp_data_queue(struct sock *sk, struct sk_buff *skb)
>>         bool fragstolen;
>>         int eaten;
>>
>> -       if (sk_is_mptcp(sk))
>> -               mptcp_incoming_options(sk, skb);
>> +       /* If a subflow has been reset, the packet should not continue
>> +        * to be processed, drop the packet.
>> +        */
>> +       if (sk_is_mptcp(sk) && !mptcp_incoming_options(sk, skb)) {
>> +               __kfree_skb(skb);
>> +               return;
>> +       }
>>
>>         if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq) {
>>                 __kfree_skb(skb);
>> @@ -6523,8 +6531,11 @@ int tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
>>         case TCP_CLOSING:
>>         case TCP_LAST_ACK:
>>                 if (!before(TCP_SKB_CB(skb)->seq, tp->rcv_nxt)) {
>> -                       if (sk_is_mptcp(sk))
>> -                               mptcp_incoming_options(sk, skb);
>> +                       /* If a subflow has been reset, the packet should not
>> +                        * continue to be processed, drop the packet.
>> +                        */
>> +                       if (sk_is_mptcp(sk) && !mptcp_incoming_options(sk, skb))
>> +                               goto discard;
>>                         break;
>>                 }
>>                 fallthrough;
>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>> index b5850af..4452455 100644
>> --- a/net/mptcp/options.c
>> +++ b/net/mptcp/options.c
>> @@ -1035,7 +1035,8 @@ static bool add_addr_hmac_valid(struct mptcp_sock *msk,
>>         return hmac == mp_opt->ahmac;
>>  }
>>
>> -void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>> +/* Return false if a subflow has been reset, else return true */
>> +bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>>  {
>>         struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
>>         struct mptcp_sock *msk = mptcp_sk(subflow->conn);
>> @@ -1053,12 +1054,16 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>>                         __mptcp_check_push(subflow->conn, sk);
>>                 __mptcp_data_acked(subflow->conn);
>>                 mptcp_data_unlock(subflow->conn);
>> -               return;
>> +               return true;
>>         }
>>
>>         mptcp_get_options(sk, skb, &mp_opt);
>> +
>> +       /* The subflow can be in close state only if check_fully_established()
>> +        * just sent a reset. If so, tell the caller to ignore the current packet.
>> +        */
>>         if (!check_fully_established(msk, sk, subflow, skb, &mp_opt))
>> -               return;
>> +               return sk->sk_state != TCP_CLOSE;
>>
>>         if (mp_opt.fastclose &&
>>             msk->local_key == mp_opt.rcvr_key) {
>> @@ -1100,7 +1105,7 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>>         }
>>
>>         if (!mp_opt.dss)
>> -               return;
>> +               return true;
>>
>>         /* we can't wait for recvmsg() to update the ack_seq, otherwise
>>          * monodirectional flows will stuck
>> @@ -1119,12 +1124,12 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>>                     schedule_work(&msk->work))
>>                         sock_hold(subflow->conn);
>>
>> -               return;
>> +               return true;
>>         }
>>
>>         mpext = skb_ext_add(skb, SKB_EXT_MPTCP);
>>         if (!mpext)
>> -               return;
>> +               return true;
>>
>>         memset(mpext, 0, sizeof(*mpext));
>>
>> @@ -1153,6 +1158,8 @@ void mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>>                 if (mpext->csum_reqd)
>>                         mpext->csum = mp_opt.csum;
>>         }
>> +
> 
> How about adding a label 'out:' here, and all above 'return true' can use
> 'goto out' instead. This is more like the kernel code style. WDYT?
> 
> -Geliang
> 
>> +       return true;
>>  }
>>
>>  static void mptcp_set_rwin(const struct tcp_sock *tp)
>> --
>> 1.8.3.1
>>
>>
>>

