Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971E67C
	for <mptcp@lists.linux.dev>; Wed,  8 Jun 2022 00:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654648692; x=1686184692;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wLsH/DeBfLHtJBZX6Vxf+eCwj2o5Kmug7FjtmK/Mc/k=;
  b=mK0YVf5wZQceuReb9l90aJChGvdUOEyHhlQQZ6i6oJnpB8PQUqVqPp5X
   YKAE2yhsVl+x2A1KHmgRHkBvUrKyTLV4cHyurys0HW6jbuoipJ9f5bmdP
   Br+oDoDk9yjRCj2dEFBKdl5/m/j1vUqJCU0wQZUt0YK9hVZKEMkPNnVTt
   3Mq1a/qCnkDRTZwIGgravkZBTODouTXU2sybncQSble8g/vDVSdkn03yq
   oTRsYyRUhTOk8ZYvTBVKo8HPxx53q05JGFPod/nQfI4A7WPvi0NXwVq1z
   F1BXllzVfLvKHEaNNpgc8Zk+ZFLChw5PxgLvgVjKW4OFO+qCiDClyvIgK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="277841464"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="277841464"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 17:38:08 -0700
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="579828004"
Received: from felahi-mobl1.amr.corp.intel.com ([10.209.42.172])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 17:38:07 -0700
Date: Tue, 7 Jun 2022 17:38:06 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Dmytro SHYTYI <dmytro@shytyi.net>
cc: mptcp@lists.linux.dev
Subject: Re: [RFC PATCH mptcp-next v3] mptcp: Fast Open Mechanism
In-Reply-To: <75cef8e0-d668-d2de-fcf5-ca7c71a9161d@shytyi.net>
Message-ID: <5cb4530-f490-9d56-6f66-8140121bb83e@linux.intel.com>
References: <20220522183921.103526-1-dmytro@shytyi.net> <30709939-9ba2-c9f1-1a0-d63236f53d86@linux.intel.com> <75cef8e0-d668-d2de-fcf5-ca7c71a9161d@shytyi.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1421764532-1654648687=:18088"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1421764532-1654648687=:18088
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sun, 5 Jun 2022, Dmytro SHYTYI wrote:

>
> On 25/05/2022 02:04, Mat Martineau wrote:
>> 
>> On Sun, 22 May 2022, Dmytro SHYTYI wrote:
>> 
>>> This set of patches will bring "Fast Open" Option support to MPTCP.
>>> The aim of Fast Open Mechanism is to eliminate one round trip
>>> time from a TCP conversation by allowing data to be included as
>>> part of the SYN segment that initiates the connection.
>>> 
>>> IETF RFC 8684: Appendix B.  TCP Fast Open and MPTCP.
>>> 
>>> [PATCH v3] includes "client-server" partial support for :
>>> 1. MPTCP cookie request from client.
>>> 2. MPTCP cookie offering from server.
>>> 3. MPTCP SYN+DATA+COOKIE from client.
>>> 4. subsequent write + read on the opened socket.
>>> 
>>> This patch is Work In Progress transitional draft. There was a pause
>>> in code development that was unpaused recently.
>> 
>> Welcome back Dmytro.
>
> I'm happy to be back :) Thank you!
>
>> 
>>> Now this code is based
>>> on the top of mptcp-next branch. The option below will be modified in
>>> future inelligently, depending on socket type (TCP||MPTCP):
>>> *tcp_options ^= OPTION_TS
>>> You also might notice some of commented pieces of the upstream code -
>>> that (is probably not good) and was done to observe an
>>> expected behavior of MPTCP Fast Open mechanism. Any comments how
>>> to achive the same behavior of MPTCP_FO without commenting the related
>>> parts of the code are welcome.
>> 
>> One step would be to split those commented out regions in to a separate 
>> commit, so they're at least separate from the other changes
> Understood.
>
>> Also, if you could trim out any extra whitespace changes (blank lines that 
>> were added or deleted), that makes it easier to review.
> My bad - forgot about those lines. will fix that.
>
>> I have some first-pass comments below. I'll have to learn more about 
>> fastopen before I can comment on the protocol specifics.
> Thank's for comments!
>
>>> 
>>> Signed-off-by: Dmytro SHYTYI <dmytro@shytyi.net>
>>> ---
>>> include/net/mptcp.h     |  2 +-
>>> net/ipv4/tcp_fastopen.c |  4 +++
>>> net/ipv4/tcp_input.c    |  7 ++---
>>> net/ipv4/tcp_output.c   |  3 +--
>>> net/mptcp/options.c     |  8 ++++--
>>> net/mptcp/protocol.c    | 59 ++++++++++++++++++++++++++++++++++++++---
>>> net/mptcp/sockopt.c     | 41 ++++++++++++++++++++++++++++
>>> net/mptcp/subflow.c     |  9 ++++---
>>> 8 files changed, 118 insertions(+), 15 deletions(-)
>>> 
>>> diff --git a/include/net/mptcp.h b/include/net/mptcp.h
>>> index 6456ea26e4c7..692197187af8 100644
>>> --- a/include/net/mptcp.h
>>> +++ b/include/net/mptcp.h
>>> @@ -139,7 +139,7 @@ void mptcp_space(const struct sock *ssk, int *space, 
>>> int *full_space);
>>> bool mptcp_syn_options(struct sock *sk, const struct sk_buff *skb,
>>>                unsigned int *size, struct mptcp_out_options *opts);
>>> bool mptcp_synack_options(const struct request_sock *req, unsigned int 
>>> *size,
>>> -              struct mptcp_out_options *opts);
>>> +              struct mptcp_out_options *opts, u16 *tcp_options);
>>> bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>>>                    unsigned int *size, unsigned int remaining,
>>>                    struct mptcp_out_options *opts);
>>> diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
>>> index fdbcf2a6d08e..f5f189e4d15a 100644
>>> --- a/net/ipv4/tcp_fastopen.c
>>> +++ b/net/ipv4/tcp_fastopen.c
>>> @@ -346,8 +346,10 @@ struct sock *tcp_try_fastopen(struct sock *sk, struct 
>>> sk_buff *skb,
>>>                   struct tcp_fastopen_cookie *foc,
>>>                   const struct dst_entry *dst)
>>> {
>>> +    /*
>>>     bool syn_data = TCP_SKB_CB(skb)->end_seq != TCP_SKB_CB(skb)->seq + 1;
>>>     int tcp_fastopen = sock_net(sk)->ipv4.sysctl_tcp_fastopen;
>>> +    */
>>>     struct tcp_fastopen_cookie valid_foc = { .len = -1 };
>>>     struct sock *child;
>>>     int ret = 0;
>>> @@ -355,12 +357,14 @@ struct sock *tcp_try_fastopen(struct sock *sk, 
>>> struct sk_buff *skb,
>>>     if (foc->len == 0) /* Client requests a cookie */
>>>         NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPFASTOPENCOOKIEREQD);
>>> 
>>> +    /*
>>>     if (!((tcp_fastopen & TFO_SERVER_ENABLE) &&
>>>           (syn_data || foc->len >= 0) &&
>>>           tcp_fastopen_queue_check(sk))) {
>>>         foc->len = -1;
>>>         return NULL;
>>>     }
>>> +    */
>>>
>>>     if (tcp_fastopen_no_cookie(sk, dst, TFO_SERVER_COOKIE_NOT_REQD))
>>>         goto fastopen;
>>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>>> index 3231af73e430..38119b96171d 100644
>>> --- a/net/ipv4/tcp_input.c
>>> +++ b/net/ipv4/tcp_input.c
>>> @@ -6273,9 +6273,10 @@ static int tcp_rcv_synsent_state_process(struct 
>>> sock *sk, struct sk_buff *skb,
>>>         }
>>>         if (fastopen_fail)
>>>             return -1;
>>> -        if (sk->sk_write_pending ||
>>> -            icsk->icsk_accept_queue.rskq_defer_accept ||
>>> -            inet_csk_in_pingpong_mode(sk)) {
>>> +
>>> +        if (!sk_is_mptcp(sk) && (sk->sk_write_pending ||
>>> +             icsk->icsk_accept_queue.rskq_defer_accept ||
>>> +             inet_csk_in_pingpong_mode(sk))) {
>>>             /* Save one ACK. Data will be ready after
>>>              * several ticks, if write_pending is set.
>>>              *
>>> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
>>> index b4b2284ed4a2..864517e63bdf 100644
>>> --- a/net/ipv4/tcp_output.c
>>> +++ b/net/ipv4/tcp_output.c
>>> @@ -747,7 +747,7 @@ static void mptcp_set_option_cond(const struct 
>>> request_sock *req,
>>>     if (rsk_is_mptcp(req)) {
>>>         unsigned int size;
>>> 
>>> -        if (mptcp_synack_options(req, &size, &opts->mptcp)) {
>>> +        if (mptcp_synack_options(req, &size, &opts->mptcp, 
>>> &opts->options)) {
>>>             if (*remaining >= size) {
>>>                 opts->options |= OPTION_MPTCP;
>>>                 *remaining -= size;
>>> @@ -822,7 +822,6 @@ static unsigned int tcp_syn_options(struct sock *sk, 
>>> struct sk_buff *skb,
>>>             tp->syn_fastopen_exp = fastopen->cookie.exp ? 1 : 0;
>>>         }
>>>     }
>>> -
>>>     smc_set_option(tp, opts, &remaining);
>>>
>>>     if (sk_is_mptcp(sk)) {
>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>> index be3b918a6d15..ebcb9c04ead9 100644
>>> --- a/net/mptcp/options.c
>>> +++ b/net/mptcp/options.c
>>> @@ -887,16 +887,20 @@ bool mptcp_established_options(struct sock *sk, 
>>> struct sk_buff *skb,
>>> }
>>> 
>>> bool mptcp_synack_options(const struct request_sock *req, unsigned int 
>>> *size,
>>> -              struct mptcp_out_options *opts)
>>> +              struct mptcp_out_options *opts, u16 *tcp_options)
>>> {
>>>     struct mptcp_subflow_request_sock *subflow_req = 
>>> mptcp_subflow_rsk(req);
>>> +#define OPTION_TS               BIT(1)
>>> +
>>> +
>>> +        *tcp_options ^= OPTION_TS;
>> 
>> Did you try setting tstamp_ok = 0 in the inet_request_sock, so 
>> tcp_synack_options() doesn't consume the space for the timestamp option to 
>> begin with?
>
> Something like this?
>
>        struct inet_request_sock *ireq = inet_rsk(req);
>        ireq->tstamp_ok = 0;
>
> I'm not sure it will help... Because a function mptcp_synack_options is a 
> part of mptcp_set_option_cond(req, opts, &remaining) that is called in the 
> end of tcp_synack_options after all.

I was thinking of it mostly as a way to leverage the existing conditional 
code that turns off the timestamps, much like the CONFIG_TCP_MD5SIG code 
does.

>
>
>>>
>>>     if (subflow_req->mp_capable) {
>>>         opts->suboptions = OPTION_MPTCP_MPC_SYNACK;
>>>         opts->sndr_key = subflow_req->local_key;
>>>         opts->csum_reqd = subflow_req->csum_reqd;
>>>         opts->allow_join_id0 = subflow_req->allow_join_id0;
>>> -        *size = TCPOLEN_MPTCP_MPC_SYNACK;
>>> +        *size = TCPOLEN_MPTCP_MPC_SYNACK  - TCPOLEN_TSTAMP_ALIGNED + 
>>> TCPOLEN_SACKPERM_ALIGNED;
>> 
>> It's important to keep the timestamp and SACK logic in tcp_synack_options() 
>> so this function won't have to readjust the options size based on whatever 
>> combination of fastopen/timestamps/sack are enabled.
>
> So does this mean we are allowed to modify it?
> If yes -> I think to move this(code below) to the end of tcp_synack_options. 
> In this case we can set tstamp_ok = 0 in the inet_requst_sock in the 
> mptcp_synack_options.
>
> 	if (likely(ireq->tstamp_ok)) {
> 		opts->options |= OPTION_TS;
> 		opts->tsval = tcp_skb_timestamp(skb) + tcp_rsk(req)->ts_off;
> 		opts->tsecr = req->ts_recent;
> 		remaining -= TCPOLEN_TSTAMP_ALIGNED;
> 	}
> 	if (likely(ireq->sack_ok)) {
> 		opts->options |= OPTION_SACK_ADVERTISE;
> 		if (unlikely(!ireq->tstamp_ok))
> 			remaining -= TCPOLEN_SACKPERM_ALIGNED;
> 	}

It's an option to modify tcp_synack_options() to a limited degree, but we 
do want to avoid changes there if we can. I'd recommend avoiding 
reordering the logic so we don't affect regular TCP operation.

Rather than rearranging the existing code, a separate helper function that 
sets tstamp_ok early in the tcp_synack_options() code (kind of like the 
MD5 code there) is probably a better bet. Section B.1 in RFC 8684 seems to 
say that just dropping the timestamp is sufficient to free up enough 
cookie space so we don't need to give MPTCP options priority over both 
timestamp and SACK_ADVERTISE.

>
>>>         pr_debug("subflow_req=%p, local_key=%llu",
>>>              subflow_req, subflow_req->local_key);
>>>         return true;
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index d6aef4b13b8a..6649088baae5 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -54,6 +54,8 @@ static struct percpu_counter mptcp_sockets_allocated 
>>> ____cacheline_aligned_in_sm
>>> 
>>> static void __mptcp_destroy_sock(struct sock *sk);
>>> static void __mptcp_check_send_data_fin(struct sock *sk);
>>> +static int mptcp_stream_connect(struct socket *sock, struct sockaddr 
>>> *uaddr,
>>> +                int addr_len, int flags);
>>> 
>>> DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
>>> static struct net_device mptcp_napi_dev;
>>> @@ -1673,6 +1675,53 @@ static void __mptcp_subflow_push_pending(struct 
>>> sock *sk, struct sock *ssk)
>>>     }
>>> }
>>> 
>>> +static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
>>> +                  size_t len, struct mptcp_sock *msk, size_t copied)
>>> +{
>>> +    const struct iphdr *iph;
>>> +    struct ubuf_info *uarg;
>>> +    struct sockaddr *uaddr;
>>> +    struct sk_buff *skb;
>>> +    struct tcp_sock *tp;
>>> +    struct socket *ssk;
>>> +    int ret;
>>> +
>>> +    ssk = __mptcp_nmpc_socket(msk);
>>> +    if (unlikely(!ssk))
>>> +        goto out_EFAULT;
>> 
>> Need to lock_sock() / release_sock() for both sk and ssk here. Be sure to 
>> observe the correct locking order (sk acquired first, released last).
> Understood. I will check that.
>
>>> +    skb = tcp_stream_alloc_skb(ssk->sk, 0, ssk->sk->sk_allocation, true);
>>> +    if (unlikely(!skb))
>>> +        goto out_EFAULT;
>>> +    iph = ip_hdr(skb);
>>> +    if (unlikely(!iph))
>>> +        goto out_EFAULT;
>>> +    uarg = msg_zerocopy_realloc(sk, len, skb_zcopy(skb));
>>> +    if (unlikely(!uarg))
>>> +        goto out_EFAULT;
>>> +    uaddr = msg->msg_name;
>>> +
>>> +    tp = tcp_sk(ssk->sk);
>>> +    if (unlikely(!tp))
>>> +        goto out_EFAULT;
>>> +    if (!tp->fastopen_req)
>>> +        tp->fastopen_req = kzalloc(sizeof(*tp->fastopen_req), 
>>> ssk->sk->sk_allocation);
>>> +
>>> +    if (unlikely(!tp->fastopen_req))
>>> +        goto out_EFAULT;
>>> +    tp->fastopen_req->data = msg;
>>> +    tp->fastopen_req->size = len;
>>> +    tp->fastopen_req->uarg = uarg;
>>> 
>>> Similar to how mptcp_sendmsg() has to reimplement tcp_sendmsg() because of 
>>> all the custom handling of the MPTCP retransmit queue and coordinating the 
>>> mappings and data, I don't think the normal TCP fastopen code invoked by 
>>> ssock->ops->connect() in mptcp_stream_connect() is going to work 
>>> out-of-the-box.
>>> 
>>> I haven't had a chance to look at how the multipath-tcp.org kernel handles 
>>> that yet, it might be good to check that out
>> 
>> I realized what I said here might not be correct. Since the initial data is 
>> not part of the DSS-mapped sequence space, it doesn't need to be stored for 
>> possible retransmission. The regular TCP fastopen code for adding the data 
>> skb to the SYN packet might be ok on the transmit side.
>> 
>> - Mat
>
>
> Okay.
>
>
>>> +
>>> +    /* requests a cookie */
>>> +    ret = mptcp_stream_connect(sk->sk_socket, uaddr,
>>> +                   msg->msg_namelen, msg->msg_flags);
>>> +
>>> +    return ret;
>>> +out_EFAULT:
>>> +    ret = -EFAULT;
>>> +    return ret;
>>> +}
>>> +
>>> static void mptcp_set_nospace(struct sock *sk)
>>> {
>>>     /* enable autotune */
>>> @@ -1690,9 +1739,9 @@ static int mptcp_sendmsg(struct sock *sk, struct 
>>> msghdr *msg, size_t len)
>>>     int ret = 0;
>>>     long timeo;
>>> 
>>> -    /* we don't support FASTOPEN yet */
>>> +    /* we don't fully support FASTOPEN yet */
>>>     if (msg->msg_flags & MSG_FASTOPEN)
>>> -        return -EOPNOTSUPP;
>>> +        ret = mptcp_sendmsg_fastopen(sk, msg, len, msk, copied);
>>>
>>>     /* silently ignore everything else */
>>>     msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL;
>>> @@ -2558,10 +2607,10 @@ static void mptcp_worker(struct work_struct *work)
>>>
>>>     if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
>>>         __mptcp_close_subflow(msk);
>>> -
>>> +/*
>>>     if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
>>>         __mptcp_retrans(sk);
>>> -
>>> +*/
>>>     mptcp_mp_fail_no_response(msk);
>>> 
>>> unlock:
>>> @@ -2681,6 +2730,8 @@ void mptcp_subflow_shutdown(struct sock *sk, struct 
>>> sock *ssk, int how)
>>>     case TCP_SYN_SENT:
>>>         tcp_disconnect(ssk, O_NONBLOCK);
>>>         break;
>>> +    case TCP_ESTABLISHED:
>>> +        break;
>> 
>> This would prevent subflows from being closed by any calls to 
>> mptcp_subflow_shutdown() - I'm curious what caused you to add this?
>
> I observer this exchange when "break" is abscent (please have a look at lines 
> 16-19.
>
>    1   0.000000 5a:32:1b:03:7b:fd →              ARP 44      Who has 
> 10.0.0.2? Tell 10.0.0.1
>    2   0.000028 5e:44:20:24:ea:59 →              ARP 44      10.0.0.2 is at 
> 5e:44:20:24:ea:59
>    3   0.000036     10.0.0.1 → 10.0.0.2     MPTCP 84  0 1 0  56860 → 7003 
> [SYN] Seq=0 Win=64240 Len=0 MSS=1460 SACK_PERM=1 TSval=1622166160 TSecr=0 
> WS=128 TFO=R
>    4   0.000076     10.0.0.2 → 10.0.0.1     MPTCP 92  0 1 1  7003 → 56860 
> [SYN, ACK] Seq=0 Ack=1 Win=65160 Len=0 MSS=1460 SACK_PERM=1 WS=128 TFO=C
>    5   0.000108     10.0.0.1 → 10.0.0.2     MPTCP 76  1 1 1  56860 → 7003 
> [ACK] Seq=1 Ack=1 Win=64256 Len=0
>    6   0.000234     10.0.0.1 → 10.0.0.2     MPTCP 83 3 1 4 1 ✓ 56860 → 
> 7003 [PSH, ACK] Seq=1 Ack=1 Win=64256 Len=3
>    7   0.000247     10.0.0.2 → 10.0.0.1     MPTCP 80  1 1 4  7003 → 56860 
> [ACK] Seq=1 Ack=4 Win=65280 Len=0 TSval=15353468 TSecr=1622166160
>    8   0.001918     10.0.0.1 → 10.0.0.2     MPTCP 83 3 4 7 1 ✓ 56860 → 
> 7003 [PSH, ACK] Seq=4 Ack=1 Win=64256 Len=3
>    9   0.001937     10.0.0.2 → 10.0.0.1     MPTCP 80  1 1 7  7003 → 56860 
> [ACK] Seq=1 Ack=7 Win=65280 Len=0 TSval=15353469 TSecr=1622166160
>   10   0.001986     10.0.0.1 → 10.0.0.2     MPTCP 83 3 7 10 1 ✓ 56860 → 
> 7003 [PSH, ACK] Seq=7 Ack=1 Win=64256 Len=3
>   11   0.001993     10.0.0.2 → 10.0.0.1     MPTCP 80  1 1 10  7003 → 56860 
> [ACK] Seq=1 Ack=10 Win=65280 Len=0 TSval=15353469 TSecr=1622166160
>   12   0.002016     10.0.0.1 → 10.0.0.2     MPTCP 83 3 10 13 1 ✓ 56860 → 
> 7003 [PSH, ACK] Seq=10 Ack=1 Win=64256 Len=3
>   13   0.002023     10.0.0.2 → 10.0.0.1     MPTCP 80  1 1 13  7003 → 56860 
> [ACK] Seq=1 Ack=13 Win=65280 Len=0 TSval=15353469 TSecr=1622166160
>   14   0.002043     10.0.0.1 → 10.0.0.2     MPTCP 83 3 13 16 1 ✓ 56860 → 
> 7003 [PSH, ACK] Seq=13 Ack=1 Win=64256 Len=3
>   15   0.002048     10.0.0.2 → 10.0.0.1     MPTCP 80  1 1 16  7003 → 56860 
> [ACK] Seq=1 Ack=16 Win=65280 Len=0 TSval=15353469 TSecr=1622166160
>   16   0.002070     10.0.0.1 → 10.0.0.2     MPTCP 80  16 16 1  [TCP Dup ACK 
> 5#1] 56860 → 7003 [ACK] Seq=16 Ack=1 Win=64256 Len=0
>   17   0.002100     10.0.0.2 → 10.0.0.1     MPTCP 80  1 1 16  [TCP Dup ACK 
> 15#1] 7003 → 56860 [ACK] Seq=1 Ack=16 Win=65280 Len=0 TSval=15353469 
> TSecr=1622166160
>   18   0.004087     10.0.0.2 → 10.0.0.1     MPTCP 96  1 1 16  [TCP Dup ACK 
> 15#2] 7003 → 56860 [ACK] Seq=1 Ack=16 Win=65280 Len=0 TSval=15353469 
> TSecr=1622166160
>   19   0.004182     10.0.0.1 → 10.0.0.2     MPTCP 64  16 16 1  [TCP Dup ACK 
> 5#2] 56860 → 7003 [ACK] Seq=16 Ack=1 Win=64256 Len=0

There's not quite enough detail in this to see what the concern is in 
lines 16-19. I suspect a few of these dup ack packets are carrying 
DATA_FIN options as part of the MPTCP-level disconnect handshake before 
the TCP FIN packets in 20-21

You could upload gzipped pcap files to 
https://github.com/multipath-tcp/mptcp_net-next/issues/59 to share the 
full packet and header details.

>   20   0.004195     10.0.0.1 → 10.0.0.2     MPTCP 64  16 17 1  56860 → 
> 7003 [FIN, ACK] Seq=16 Ack=1 Win=64256 Len=0
>   21   0.004209     10.0.0.2 → 10.0.0.1     MPTCP 80  1 2 17  7003 → 56860 
> [FIN, ACK] Seq=1 Ack=17 Win=65280 Len=0 TSval=15353472 TSecr=1622166160
>   22   0.004235     10.0.0.1 → 10.0.0.2     MPTCP 64  17 17 2  56860 → 
> 7003 [ACK] Seq=17 Ack=2 Win=64256 Len=0
>   23   0.588626 fe80::5832:1bff:fe03:7bfd → ff02::2      ICMPv6 72   Router 
> Solicitation from 5a:32:1b:03:7b:fd
>   24   3.361860 fe80::5c44:20ff:fe24:ea59 → ff02::2      ICMPv6 72   Router 
> Solicitation from 5e:44:20:24:ea:59
>   25   5.068551 5e:44:20:24:ea:59 →              ARP 44      Who has 
> 10.0.0.1? Tell 10.0.0.2
>   26   5.068640 5a:32:1b:03:7b:fd →              ARP 44      10.0.0.1 is at 
> 5a:32:1b:03:7b:fd
>   27   5.645553     10.0.0.1 → 10.0.0.2     MPTCP 95 3 0 4 0 ✓ 56862 → 
> 7003 [SYN] Seq=0 Win=64240 Len=3 MSS=1460 SACK_PERM=1 TSval=1622171806 
> TSecr=0 WS=128 TFO=C
>   28   5.645634     10.0.0.2 → 10.0.0.1     MPTCP 80  0 1 4  7003 → 56862 
> [SYN, ACK] Seq=0 Ack=4 Win=65160 Len=0 MSS=1460 SACK_PERM=1 WS=128
>   29   5.645661     10.0.0.1 → 10.0.0.2     MPTCP 76  4 4 1  56862 → 7003 
> [ACK] Seq=4 Ack=1 Win=64256 Len=0
>   30   5.647081     10.0.0.1 → 10.0.0.2     MPTCP 83 3 4 7 1 ✓ 56862 → 
> 7003 [PSH, ACK] Seq=4 Ack=1 Win=64256 Len=3
>   31   5.647131     10.0.0.2 → 10.0.0.1     MPTCP 80  1 1 7  7003 → 56862 
> [ACK] Seq=1 Ack=7 Win=65280 Len=0 TSval=15359115 TSecr=1622171806
>   32   5.647497     10.0.0.1 → 10.0.0.2     MPTCP 83 3 7 10 1 ✓ 56862 → 
> 7003 [PSH, ACK] Seq=7 Ack=1 Win=64256 Len=3
>   33   5.647526     10.0.0.2 → 10.0.0.1     MPTCP 80  1 1 10  7003 → 56862 
> [ACK] Seq=1 Ack=10 Win=65280 Len=0 TSval=15359115 TSecr=1622171806
>   34   5.647827     10.0.0.1 → 10.0.0.2     MPTCP 83 3 10 13 1 ✓ 56862 → 
> 7003 [PSH, ACK] Seq=10 Ack=1 Win=64256 Len=3
>   35   5.647864     10.0.0.2 → 10.0.0.1     MPTCP 80  1 1 13  7003 → 56862 
> [ACK] Seq=1 Ack=13 Win=65280 Len=0 TSval=15359115 TSecr=1622171806
>   36   5.648198     10.0.0.1 → 10.0.0.2     MPTCP 83 3 13 16 1 ✓ 56862 → 
> 7003 [PSH, ACK] Seq=13 Ack=1 Win=64256 Len=3
>   37   5.648228     10.0.0.2 → 10.0.0.1     MPTCP 80  1 1 16  7003 → 56862 
> [ACK] Seq=1 Ack=16 Win=65280 Len=0 TSval=15359116 TSecr=1622171806
>   38   5.648671     10.0.0.2 → 10.0.0.1     MPTCP 96  1 1 16  [TCP Dup ACK 
> 37#1] 7003 → 56862 [ACK] Seq=1 Ack=16 Win=65280 Len=0 TSval=15359116 
> TSecr=1622171806
>   39   5.648732     10.0.0.1 → 10.0.0.2     MPTCP 64  16 16 1  [TCP Dup ACK 
> 29#1] 56862 → 7003 [ACK] Seq=16 Ack=1 Win=64256 Len=0
>   40   5.648743     10.0.0.1 → 10.0.0.2     MPTCP 80  16 16 1  [TCP Dup ACK 
> 29#2] 56862 → 7003 [ACK] Seq=16 Ack=1 Win=64256 Len=0
>   41  15.948621 fe80::5832:1bff:fe03:7bfd → ff02::2      ICMPv6 72   Router 
> Solicitation from 5a:32:1b:03:7b:fd
>
> With "break" what is not normal (I agree) as you also mentioned, I observe 
> this (seems ok for me):
>
>    5   1.702231     10.0.0.1 → 10.0.0.2     MPTCP 84  0 1 0  52756 → 7003 
> [SYN] Seq=0 Win=64240 Len=0 MSS=1460 SACK_PERM=1 TSval=2507020170 TSecr=0 
> WS=128 TFO=R
>    6   1.702251     10.0.0.2 → 10.0.0.1     MPTCP 92  0 1 1  7003 → 52756 
> [SYN, ACK] Seq=0 Ack=1 Win=65160 Len=0 MSS=1460 SACK_PERM=1 WS=128 TFO=C
>    7   1.702270     10.0.0.1 → 10.0.0.2     MPTCP 76  1 1 1  52756 → 7003 
> [ACK] Seq=1 Ack=1 Win=64256 Len=0
>    8   1.702316     10.0.0.1 → 10.0.0.2     MPTCP 83 3 1 4 1 ✓ 52756 → 
> 7003 [PSH, ACK] Seq=1 Ack=1 Win=64256 Len=3
>    9   1.702338     10.0.0.2 → 10.0.0.1     MPTCP 80  1 1 4  7003 → 52756 
> [ACK] Seq=1 Ack=4 Win=65280 Len=0 TSval=696906899 TSecr=2507020170
>   10   1.703196     10.0.0.1 → 10.0.0.2     MPTCP 83 3 4 7 1 ✓ 52756 → 
> 7003 [PSH, ACK] Seq=4 Ack=1 Win=64256 Len=3
>   11   1.703221     10.0.0.2 → 10.0.0.1     MPTCP 80  1 1 7  7003 → 52756 
> [ACK] Seq=1 Ack=7 Win=65280 Len=0 TSval=696906900 TSecr=2507020170
>   12   1.703231     10.0.0.1 → 10.0.0.2     MPTCP 83 3 7 10 1 ✓ 52756 → 
> 7003 [PSH, ACK] Seq=7 Ack=1 Win=64256 Len=3
>   13   1.703234     10.0.0.2 → 10.0.0.1     MPTCP 80  1 1 10  7003 → 52756 
> [ACK] Seq=1 Ack=10 Win=65280 Len=0 TSval=696906900 TSecr=2507020170
>   14   1.703240     10.0.0.1 → 10.0.0.2     MPTCP 83 3 10 13 1 ✓ 52756 → 
> 7003 [PSH, ACK] Seq=10 Ack=1 Win=64256 Len=3
>   15   1.703242     10.0.0.2 → 10.0.0.1     MPTCP 80  1 1 13  7003 → 52756 
> [ACK] Seq=1 Ack=13 Win=65280 Len=0 TSval=696906900 TSecr=2507020170
>   16   1.703246     10.0.0.1 → 10.0.0.2     MPTCP 83 3 13 16 1 ✓ 52756 → 
> 7003 [PSH, ACK] Seq=13 Ack=1 Win=64256 Len=3
>   17   1.703248     10.0.0.2 → 10.0.0.1     MPTCP 80  1 1 16  7003 → 52756 
> [ACK] Seq=1 Ack=16 Win=65280 Len=0 TSval=696906900 TSecr=2507020170
>   18   6.826669 5e:44:20:24:ea:59 →              ARP 44      Who has 
> 10.0.0.1? Tell 10.0.0.2
>   19   6.826783 5a:32:1b:03:7b:fd →              ARP 44      10.0.0.1 is at 
> 5a:32:1b:03:7b:fd
>   20   7.253337 fe80::5c44:20ff:fe24:ea59 → ff02::2      ICMPv6 72   Router 
> Solicitation from 5e:44:20:24:ea:59
>   21   7.680014 fe80::5832:1bff:fe03:7bfd → ff02::2      ICMPv6 72   Router 
> Solicitation from 5a:32:1b:03:7b:fd
>   22  21.973339 fe80::5c44:20ff:fe24:ea59 → ff02::2      ICMPv6 72   Router 
> Solicitation from 5e:44:20:24:ea:59
>   23  23.680053 fe80::5832:1bff:fe03:7bfd → ff02::2      ICMPv6 72   Router 
> Solicitation from 5a:32:1b:03:7b:fd
>   24  52.693332 fe80::5c44:20ff:fe24:ea59 → ff02::2      ICMPv6 72   Router 
> Solicitation from 5e:44:20:24:ea:59
>   25  56.106676 fe80::5832:1bff:fe03:7bfd → ff02::2      ICMPv6 72   Router 
> Solicitation from 5a:32:1b:03:7b:fd
>   26  62.933206     10.0.0.2 → 10.0.0.1     MPTCP 96  1 2 16  7003 → 52756 
> [FIN, ACK] Seq=1 Ack=16 Win=65280 Len=0 TSval=696968130 TSecr=2507020170
>   27  62.933223     10.0.0.1 → 10.0.0.2     MPTCP 80  16 17 1  52756 → 
> 7003 [FIN, ACK] Seq=16 Ack=1 Win=64256 Len=0
>   28  62.933303     10.0.0.1 → 10.0.0.2     MPTCP 80  17 17 2  52756 → 
> 7003 [ACK] Seq=17 Ack=2 Win=64256 Len=0
>   29  62.933319     10.0.0.2 → 10.0.0.1     MPTCP 96  2 2 17  7003 → 52756 
> [ACK] Seq=2 Ack=17 Win=65280 Len=0 TSval=696968130 TSecr=2507020170
>   30  67.754885     10.0.0.1 → 10.0.0.2     MPTCP 95 3 0 4 0 ✓ 51742 → 
> 7003 [SYN] Seq=0 Win=64240 Len=3 MSS=1460 SACK_PERM=1 TSval=2507086222 
> TSecr=0 WS=128 TFO=C
>   31  67.754921     10.0.0.2 → 10.0.0.1     MPTCP 80  0 1 4  7003 → 51742 
> [SYN, ACK] Seq=0 Ack=4 Win=65160 Len=0 MSS=1460 SACK_PERM=1 WS=128
>   32  67.754983     10.0.0.1 → 10.0.0.2     MPTCP 76  4 4 1  51742 → 7003 
> [ACK] Seq=4 Ack=1 Win=64256 Len=0
>   33  67.756278     10.0.0.1 → 10.0.0.2     MPTCP 83 3 4 7 1 ✓ 51742 → 
> 7003 [PSH, ACK] Seq=4 Ack=1 Win=64256 Len=3
>   34  67.756326     10.0.0.2 → 10.0.0.1     MPTCP 80  1 1 7  7003 → 51742 
> [ACK] Seq=1 Ack=7 Win=65280 Len=0 TSval=696972953 TSecr=2507086222
>   35  67.756368     10.0.0.1 → 10.0.0.2     MPTCP 83 3 7 10 1 ✓ 51742 → 
> 7003 [PSH, ACK] Seq=7 Ack=1 Win=64256 Len=3
>   36  67.756375     10.0.0.2 → 10.0.0.1     MPTCP 80  1 1 10  7003 → 51742 
> [ACK] Seq=1 Ack=10 Win=65280 Len=0 TSval=696972953 TSecr=2507086222
>   37  67.756393     10.0.0.1 → 10.0.0.2     MPTCP 83 3 10 13 1 ✓ 51742 → 
> 7003 [PSH, ACK] Seq=10 Ack=1 Win=64256 Len=3
>   38  67.756401     10.0.0.2 → 10.0.0.1     MPTCP 80  1 1 13  7003 → 51742 
> [ACK] Seq=1 Ack=13 Win=65280 Len=0 TSval=696972953 TSecr=2507086222
>   39  67.756417     10.0.0.1 → 10.0.0.2     MPTCP 83 3 13 16 1 ✓ 51742 → 
> 7003 [PSH, ACK] Seq=13 Ack=1 Win=64256 Len=3
>   40  67.756422     10.0.0.2 → 10.0.0.1     MPTCP 80  1 1 16  7003 → 51742 
> [ACK] Seq=1 Ack=16 Win=65280 Len=0 TSval=696972953 TSecr=2507086222
>   41 112.426695 fe80::5c44:20ff:fe24:ea59 → ff02::2      ICMPv6 72   Router 
> Solicitation from 5e:44:20:24:ea:59
>   42 119.253281 fe80::5832:1bff:fe03:7bfd → ff02::2      ICMPv6 72   Router 
> Solicitation from 5a:32:1b:03:7b:fd
>   43 127.786550     10.0.0.2 → 10.0.0.1     MPTCP 96  1 2 16  7003 → 51742 
> [FIN, ACK] Seq=1 Ack=16 Win=65280 Len=0 TSval=697032983 TSecr=2507086222
>   44 127.786674     10.0.0.1 → 10.0.0.2     MPTCP 80  16 17 1  51742 → 
> 7003 [FIN, ACK] Seq=16 Ack=1 Win=64256 Len=0
>   45 127.786696     10.0.0.2 → 10.0.0.1     MPTCP 96  2 2 17  7003 → 51742 
> [ACK] Seq=2 Ack=17 Win=65280 Len=0 TSval=697032983 TSecr=2507086222
>   46 127.786720     10.0.0.1 → 10.0.0.2     MPTCP 80  17 17 2  51742 → 
> 7003 [ACK] Seq=17 Ack=2 Win=64256 Len=0
>
>
>
>
>>>     default:
>>>         if (__mptcp_check_fallback(mptcp_sk(sk))) {
>>>             pr_debug("Fallback");
>>> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
>>> index 423d3826ca1e..e1ae1ef224cf 100644
>>> --- a/net/mptcp/sockopt.c
>>> +++ b/net/mptcp/sockopt.c
>>> @@ -560,6 +560,8 @@ static bool mptcp_supported_sockopt(int level, int 
>>> optname)
>>>         case TCP_TX_DELAY:
>>>         case TCP_INQ:
>>>             return true;
>>> +        case TCP_FASTOPEN:
>>> +            return true;
>>>         }
>>>
>>>         /* TCP_MD5SIG, TCP_MD5SIG_EXT are not supported, MD5 is not 
>>> compatible with MPTCP */
>>> @@ -768,6 +770,43 @@ static int mptcp_setsockopt_sol_tcp_defer(struct 
>>> mptcp_sock *msk, sockptr_t optv
>>>     return tcp_setsockopt(listener->sk, SOL_TCP, TCP_DEFER_ACCEPT, optval, 
>>> optlen);
>>> }
>>> 
>>> +static int mptcp_setsockopt_sol_tcp_fastopen(struct mptcp_sock *msk, 
>>> sockptr_t optval,
>>> +                         unsigned int optlen)
>>> +{
>>> +    struct mptcp_subflow_context *subflow;
>>> +    struct sock *sk = (struct sock *)msk;
>>> +    struct net *net = sock_net(sk);
>>> +    int val;
>>> +    int ret;
>>> +
>>> +    ret = 0;
>>> +
>>> +    if (copy_from_sockptr(&val, optval, sizeof(val)))
>>> +        return -EFAULT;
>>> +
>>> +    lock_sock(sk);
>>> +
>>> +    mptcp_for_each_subflow(msk, subflow) {
>>> +        struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
>>> +
>>> +        lock_sock(ssk);
>>> +
>>> +        if (val >= 0 && ((1 << sk->sk_state) & (TCPF_CLOSE |
>>> +            TCPF_LISTEN))) {
>>> +            tcp_fastopen_init_key_once(net);
>>> +            fastopen_queue_tune(sk, val);
>> 
>> Need to use ssk instead of sk in these several lines, right?
> Heh) I will check this, thanks!
>
>>> +        } else {
>>> +            ret = -EINVAL;
>>> +        }
>>> +
>>> +        release_sock(ssk);
>>> +    }
>>> +
>>> +    release_sock(sk);
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> static int mptcp_setsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
>>>                     sockptr_t optval, unsigned int optlen)
>>> {
>>> @@ -796,6 +835,8 @@ static int mptcp_setsockopt_sol_tcp(struct mptcp_sock 
>>> *msk, int optname,
>>>         return mptcp_setsockopt_sol_tcp_nodelay(msk, optval, optlen);
>>>     case TCP_DEFER_ACCEPT:
>>>         return mptcp_setsockopt_sol_tcp_defer(msk, optval, optlen);
>>> +    case TCP_FASTOPEN:
>>> +        return mptcp_setsockopt_sol_tcp_fastopen(msk, optval, optlen);
>>>     }
>>>
>>>     return -EOPNOTSUPP;
>>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>>> index 8841e8cd9ad8..f732e41e12df 100644
>>> --- a/net/mptcp/subflow.c
>>> +++ b/net/mptcp/subflow.c
>>> @@ -1002,16 +1002,17 @@ static enum mapping_status 
>>> get_mapping_status(struct sock *ssk,
>>>             sk_eat_skb(ssk, skb);
>>>             return MAPPING_EMPTY;
>>>         }
>>> -
>>> +/*
>>>         if (!subflow->map_valid)
>>>             return MAPPING_INVALID;
>>> -
>>> +*/
>> 
>> Yeah, there's some work to do to handle TFO data since the RFC says it is 
>> not part of the data sequence number space. Fastopen will need to move the 
>> SYN data directly to the msk->receive_queue, bypassing the normal mapping 
>> code.
> I will check that, thanks for the tip.
>
>>
>>>         goto validate_seq;
>>>     }
>>>
>>>     trace_get_mapping_status(mpext);
>>>
>>>     data_len = mpext->data_len;
>>> +
>>>     if (data_len == 0) {
>>>         pr_debug("infinite mapping received");
>>>         MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_INFINITEMAPRX);
>>> @@ -1075,6 +1076,7 @@ static enum mapping_status get_mapping_status(struct 
>>> sock *ssk,
>>>         /* If this skb data are fully covered by the current mapping,
>>>          * the new map would need caching, which is not supported
>>>          */
>>> +
>>>         if (skb_is_fully_mapped(ssk, skb)) {
>>>             MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSNOMATCH);
>>>             return MAPPING_INVALID;
>>> @@ -1107,11 +1109,12 @@ static enum mapping_status 
>>> get_mapping_status(struct sock *ssk,
>>>     /* we revalidate valid mapping on new skb, because we must ensure
>>>      * the current skb is completely covered by the available mapping
>>>      */
>>> +    /*
>>>     if (!validate_mapping(ssk, skb)) {
>>>         MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSTCPMISMATCH);
>>>         return MAPPING_INVALID;
>>>     }
>>> -
>>> +    */
>> 
>> If the fastopen data bypasses the normal mptcp receive path, mappings can 
>> still be validated (as they must be :) ) for regular data.
>> 
>
> No objections :)
>
>>>     skb_ext_del(skb, SKB_EXT_MPTCP);
>>> 
>>> validate_csum:
>>> -- 
>>> 2.25.1
>>> 
>>> 
>>> 
>
> Btw, I noticed one more thing:
>
> Without this messy modification, userspace receiver doesn't get the data:
>
> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 8841e8cd9ad8..b72527d6398c 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -1002,10 +1002,10 @@ static enum mapping_status get_mapping_status(struct 
> sock *ssk,
>                        sk_eat_skb(ssk, skb);
>                        return MAPPING_EMPTY;
>                }
> -
> +/*
>                if (!subflow->map_valid)
>                        return MAPPING_INVALID;
> -
> +*/
>                goto validate_seq;
>        }
>
> @@ -1084,6 +1084,15 @@ static enum mapping_status get_mapping_status(struct 
> sock *ssk,
>                goto validate_csum;
>        }
>
> +       skb = skb_peek(&ssk->sk_receive_queue);
> +       subflow->map_valid = 1;
> +       subflow->map_seq = READ_ONCE(msk->ack_seq);
> +       subflow->map_data_len = skb->len;
> +       subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq - 
> subflow->ssn_offset;
> +
> +       WRITE_ONCE(subflow->data_avail, MPTCP_SUBFLOW_DATA_AVAIL);
> +       goto validate_csum;
> +/*
>        subflow->map_seq = map_seq;
>        subflow->map_subflow_seq = mpext->subflow_seq;
>        subflow->map_data_len = data_len;
> @@ -1093,7 +1102,7 @@ static enum mapping_status get_mapping_status(struct 
> sock *ssk,
>        subflow->map_csum_reqd = mpext->csum_reqd;
>        subflow->map_csum_len = 0;
>        subflow->map_data_csum = csum_unfold(mpext->csum);
> -
> +*/
>        /* Cfr RFC 8684 Section 3.3.0 */
>        if (unlikely(subflow->map_csum_reqd != csum_reqd))
>                return MAPPING_INVALID;
>

I think what's happening here is that the initial TFO data lacks a 
mapping, so the above mapping code doesn't know what to do with it and 
discards the data.

For the TFO data that's outside the sequence space, there needs to be 
special case code that moves that bypasses the mapping code and moves the 
TFO skb directly in to the msk->receive_queue. Take a look at 
__mptcp_move_skb() for the code that normally moves subflow skbs to the 
msk->sk_receive_queue - the TFO code will need to do very similar work to 
detach the skb from the subflow, do all the memory accounting, and then 
call __skb_queue_tail(msk->receive_queue, skb)

Since __mptcp_recvmsg_mskq() and mptcp_try_coalesce() look for some 
MPTCP_SKB_CB fields in the queued skbs, you probably need to add an 
"is_tso" bit to 'struct mptcp_skb_cb' and add some checks to those 
functions so the TFO skb (without sequence numbers) can be detected and 
handled.


>
>
>> Dymtro, it will also be important to add some 'fast open' coverage to the 
>> kernel self tests in this directory of the kernel source tree:
>> 
>> tools/testing/selftests/net/mptcp/
>> 
>> There's a short guide to running these tests at 
>> https://github.com/multipath-tcp/mptcp_net-next/wiki/Testing#kselftest
>> 
>> 
>> We appreciate your work to add this feature to MPTCP in the Linux kernel!
>> 
>> -- 
>> Mat Martineau
>> Intel
>
> I wrote 2 simple userspace tests (sender(with sendmsg) and receiver) using 
> namespaces.
> I would add 2 *.c files and 2 *.bash files. But maybe it is better just to 
> alter the existing files in mptcp tests folder?

Yes, I think the tests would fit well in mptcp_connect.c and 
mptcp_connect.sh

--
Mat Martineau
Intel
--0-1421764532-1654648687=:18088--
