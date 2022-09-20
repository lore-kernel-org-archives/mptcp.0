Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E3A1C03
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 22:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663713407; x=1695249407;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=nj+AtvZoXLJW86l3ppCfqI3g0/SWUNB0TP0AObVb0OQ=;
  b=FlX7FOFPUWa14ejlcs1i32tlKFFdfMUbkoyJjwj7YWofDzZxA0PpmjBg
   1FWOqjcAOJkoCq+0arIVubc/HGmVOtTXGHFXBcq2qjYYzMpxJpTo+chHy
   KgFgXe0RKfcoHhTYCvnGl1qiJQCPcEX9S5gCWHN90EcSa3yl9sPLvJd0a
   VXpIqHpMOZjCLmdjuefn+PePUi37VA8c/jHi+jwbl+9f21+q+qDFFpZoZ
   LyzV7FGHPL+MFbBTe3wI5qdGgnSfLyunvWWdqHUz0JnJ+AHr4o2ngISvv
   b8QWMhmofyc/x5jiWEdsR+IkCXfhsr2E9EblHQ5pmrxiGjeAqv+zBfWY7
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="301232940"
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="301232940"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 15:36:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="864160127"
Received: from criedene-mobl2.amr.corp.intel.com ([10.212.165.150])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 15:36:45 -0700
Date: Tue, 20 Sep 2022 15:36:45 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>
cc: pabeni@redhat.com, mptcp@lists.linux.dev, 
    Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH mptcp] net: mptcp: add statistics for mptcp socket in
 use
In-Reply-To: <CADxym3a3q_Tz=SWPqfwL+apnVtEpCd1Ng47xmCbN9ywNXnnMaw@mail.gmail.com>
Message-ID: <44a260ec-6a0c-15f8-516b-6304ae9610d6@linux.intel.com>
References: <20220919132156.3649522-1-imagedong@tencent.com> <61ca3016-5f92-7779-9213-f8b75ff9ff55@linux.intel.com> <CADxym3a3q_Tz=SWPqfwL+apnVtEpCd1Ng47xmCbN9ywNXnnMaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Tue, 20 Sep 2022, Menglong Dong wrote:

> On Tue, Sep 20, 2022 at 6:37 AM Mat Martineau
> <mathew.j.martineau@linux.intel.com> wrote:
>>
>> On Mon, 19 Sep 2022, menglong8.dong@gmail.com wrote:
>>
>>> From: Menglong Dong <imagedong@tencent.com>
>>>
>>> Do the statistics of mptcp socket in use with sock_prot_inuse_add().
>>> Therefore, we can get the count of used mptcp socket from
>>> /proc/net/protocols:
>>>
>>> & cat /proc/net/protocols
>>> protocol  size sockets  memory press maxhdr  slab module     cl co di ac io in de sh ss gs se re sp bi br ha uh gp em
>>> MPTCPv6   2048      0       0   no       0   yes  kernel      y  n  y  y  y  y  y  y  y  y  y  y  n  n  n  y  y  y  n
>>> MPTCP     1896      1       0   no       0   yes  kernel      y  n  y  y  y  y  y  y  y  y  y  y  n  n  n  y  y  y  n
>>>
>>> Signed-off-by: Menglong Dong <imagedong@tencent.com>
>>
>> Hello Menglong -
>>
>> Thanks for your patch.
>>
>> One minor thing: please use the subject line tags listed in
>> https://github.com/multipath-tcp/mptcp_net-next/wiki/Patch-prefixes :
>> either "[PATCH mptcp-net]" or "[PATCH mptcp-next]", so it's clear which
>> tree the patch is intended for.
>>
>
> Thanks for your remind, I'll send the next version with
> mptcp-next tag.
>
>>> ---
>>> net/mptcp/protocol.c | 19 +++++++++++++------
>>> net/mptcp/subflow.c  |  3 +++
>>> 2 files changed, 16 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 45ed50e9aec9..4da77aa8b070 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -2311,6 +2311,7 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
>>>                       tcp_set_state(ssk, TCP_CLOSE);
>>>                       mptcp_subflow_queue_clean(ssk);
>>>                       inet_csk_listen_stop(ssk);
>>> +                     sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
>>
>> The code in this function is for a closing subflow, not a closing MPTCP
>> socket. I don't think this call belongs here.
>>
>
> I think this is the path of the listening mptcp close.
> The mptcp socket in listening status is not hashed
> to the token hash table, or has 'MPTCP_FALLBACK_DONE'
> flags. Therefore, the use statistics of it is not freed in
> mptcp_destroy_common().
>
> Hmm...maybe there is a better code path for
> this part?

Ah, right: the above block of code only runs once for the single listener 
subflow.

mptcp_destroy_common() still seems like the better place to adjust the 
counter for the TCP_LISTEN case. Does it work to check the sk_state of 
__mptcp_nmpc_socket(msk) for TCP_LISTEN before the loop in 
mptcp_destroy_common() that calls __mptcp_close_ssk(), like this?

ssock = __mptcp_nmpc_socket(msk);
if (ssock && inet_sk_state_load(ssock->sk) == TCP_LISTEN)
 	listener = true;

>
>>>               }
>>>               __tcp_close(ssk, 0);
>>>
>>> @@ -3067,6 +3068,9 @@ void mptcp_destroy_common(struct mptcp_sock *msk, unsigned int flags)
>>>       skb_rbtree_purge(&msk->out_of_order_queue);
>>>       mptcp_data_unlock(sk);
>>>
>>> +     if (!sk_unhashed(sk) || __mptcp_check_fallback(msk))

then you could change this to

if (!sk_unhashed(sk) || __mptcp_check_fallback(msk) || listener)

?


Thanks,

Mat


>>> +             sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
>>> +
>>>       /* move all the rx fwd alloc into the sk_mem_reclaim_final in
>>>        * inet_sock_destruct() will dispose it
>>>        */
>>> @@ -3513,6 +3517,7 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
>>>       mptcp_token_destroy(msk);
>>>       inet_sk_state_store(sock->sk, TCP_SYN_SENT);
>>>       subflow = mptcp_subflow_ctx(ssock->sk);
>>> +     sock_prot_inuse_add(sock_net(sock->sk), sock->sk->sk_prot, 1);
>>> #ifdef CONFIG_TCP_MD5SIG
>>>       /* no MPTCP if MD5SIG is enabled on this socket or we may run out of
>>>        * TCP option space.
>>> @@ -3547,12 +3552,13 @@ static int mptcp_stream_connect(struct socket *sock, struct sockaddr *uaddr,
>>> static int mptcp_listen(struct socket *sock, int backlog)
>>> {
>>>       struct mptcp_sock *msk = mptcp_sk(sock->sk);
>>> +     struct sock *sk = sock->sk;
>>
>> Changing all of the "sock->sk" text in this function to "sk" creates a lot
>> of diffs that aren't related to maintaining the inuse statistics. If you'd
>> like to do that refactoring change, please split that into a separate
>> patch for mptcp-next.
>>
>
> Ok, I'll split it into a separate patch.
>
> Thanks!
> Menglong Dong
>
>> -Mat
>>
>>>       struct socket *ssock;
>>>       int err;
>>>
>>>       pr_debug("msk=%p", msk);
>>>
>>> -     lock_sock(sock->sk);
>>> +     lock_sock(sk);
>>>       ssock = __mptcp_nmpc_socket(msk);
>>>       if (!ssock) {
>>>               err = -EINVAL;
>>> @@ -3560,16 +3566,17 @@ static int mptcp_listen(struct socket *sock, int backlog)
>>>       }
>>>
>>>       mptcp_token_destroy(msk);
>>> -     inet_sk_state_store(sock->sk, TCP_LISTEN);
>>> -     sock_set_flag(sock->sk, SOCK_RCU_FREE);
>>> +     inet_sk_state_store(sk, TCP_LISTEN);
>>> +     sock_set_flag(sk, SOCK_RCU_FREE);
>>> +     sock_prot_inuse_add(sock_net(sk), sk->sk_prot, 1);
>>>
>>>       err = ssock->ops->listen(ssock, backlog);
>>> -     inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
>>> +     inet_sk_state_store(sk, inet_sk_state_load(ssock->sk));
>>>       if (!err)
>>> -             mptcp_copy_inaddrs(sock->sk, ssock->sk);
>>> +             mptcp_copy_inaddrs(sk, ssock->sk);
>>>
>>> unlock:
>>> -     release_sock(sock->sk);
>>> +     release_sock(sk);
>>>       return err;
>>> }
>>>
>>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>>> index 07dd23d0fe04..da6cfa73a3bd 100644
>>> --- a/net/mptcp/subflow.c
>>> +++ b/net/mptcp/subflow.c
>>> @@ -747,6 +747,9 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
>>>                       mptcp_sk(new_msk)->setsockopt_seq = ctx->setsockopt_seq;
>>>                       mptcp_pm_new_connection(mptcp_sk(new_msk), child, 1);
>>>                       mptcp_token_accept(subflow_req, mptcp_sk(new_msk));
>>> +                     sock_prot_inuse_add(sock_net(new_msk),
>>> +                                         new_msk->sk_prot,
>>> +                                         1);
>>>                       ctx->conn = new_msk;
>>>                       new_msk = NULL;
>>>
>>> --
>>> 2.37.2
>>>
>>>
>>>
>>
>> --
>> Mat Martineau
>> Intel
>

--
Mat Martineau
Intel
