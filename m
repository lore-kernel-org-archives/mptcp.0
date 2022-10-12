Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11097612F
	for <mptcp@lists.linux.dev>; Wed, 12 Oct 2022 23:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665618491; x=1697154491;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=0/ieAZ5CoX5yTEtXHymXvmdiDh3zj7C1mO9py05Ja64=;
  b=DogsbgOy5YXri7ESTOVdzoUkCyBXm0JnX1y7fKc+B5Z2tqFaTPuttnm7
   W0tMTSHqQILQHJNuWhRn6p9n6In1dFEgBlXI8HTkRPfdQkpPqzjfOco1+
   3KchoKSKbTusdcBGZrCG+hDLEPe5++ksKHMspOytTGEQt5kqwU7H0nHCL
   KNOc4/X6QqVw6uoikcm0ynV9SNZ3dn8OmkgNufjUj3kTxzGPmpXBLDNME
   txL/AUGlKJ71PY420c40rAuHE5VX60EnI++L9wLYoYlmLaBZ0lymjqP/X
   cFu425FQwrX9W3D8eOtdU8YC+UTDgj9IG2cFfPpN7OgbwpoAG6MvTN3ks
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="304923508"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="304923508"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 16:48:10 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="716115484"
X-IronPort-AV: E=Sophos;i="5.95,180,1661842800"; 
   d="scan'208";a="716115484"
Received: from mbrandt-mobl2.amr.corp.intel.com ([10.252.142.29])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 16:48:10 -0700
Date: Wed, 12 Oct 2022 16:48:09 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, 
    Paolo Abeni <pabeni@redhat.com>
cc: mptcp@lists.linux.dev
Subject: Re: [PATCH mptcp-net v3] mptcp: fix abba deadlock on fastopen
In-Reply-To: <dee06f30-f5ea-deb3-9d40-b4f7a5d460df@tessares.net>
Message-ID: <d704dd13-87c2-649a-2e15-2a5b7d2c880a@linux.intel.com>
References: <7c61250080c052b9dfb42a023c85dc36d4450daf.1665584136.git.pabeni@redhat.com> <dee06f30-f5ea-deb3-9d40-b4f7a5d460df@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Wed, 12 Oct 2022, Matthieu Baerts wrote:

> Hi Paolo,
>
> On 12/10/2022 16:48, Paolo Abeni wrote:
>> Our CI reported lockdep splat in the fastopen code:
>
> (...)
>
>> The problem is caused by the blocking inet_wait_for_connect() releasing
>> and re-acquiring the msk socket lock while the subflow socket lock is
>> still held and the MPTCP socket requires that the msk socket lock must
>> be acquired before the subflow socket lock.
>>
>> Address the issue always invoking tcp_sendmsg_fastopen() in an
>> unblocking manner, and later eventually complete the blocking
>> __inet_stream_connect() as needed.

Matthieu and Paolo -

When I tested with export-net (and cherry picked the "factor out 
mptcp_connect()" commit, I saw packetdrill failures that would indicate 
it's not blocking as expected:

FAIL [/home/mjmartin/work/packetdrill/gtests/net/mptcp/fastopen/client-TCP_FASTOPEN_CONNECT-blocking-sendmsg.pkt (ipv4)]
stdout:
stderr:
client-TCP_FASTOPEN_CONNECT-blocking-sendmsg.pkt:13: timing error: expected system call return at 0.400840 sec but happened at 0.002812 sec; tolerance 0.100000 sec
FAIL [/home/mjmartin/work/packetdrill/gtests/net/mptcp/fastopen/client-TCP_FASTOPEN_CONNECT-blocking-sendmsg.pkt (ipv6)]
stdout:
stderr:
client-TCP_FASTOPEN_CONNECT-blocking-sendmsg.pkt:13: timing error: expected system call return at 0.400827 sec but happened at 0.002901 sec; tolerance 0.100000 sec

...

FAIL 
[/home/mjmartin/work/packetdrill/gtests/net/mptcp/fastopen/client-TCP_FASTOPEN_CONNECT-blocking-sendmsg.pkt (ipv4-mapped-v6)]
stdout:
stderr:
client-TCP_FASTOPEN_CONNECT-blocking-sendmsg.pkt:13: timing error: expected system call return at 0.400735 sec but happened at 0.002602 sec; tolerance 0.100000 sec


(There were also FASTOPEN_NO_COOKIE failures because those commits aren't 
on export-net.)


Matthieu, did you see different behavior? Looking at timestamps you were 
likely doing packetdrill tests with v2 of this :)


>
> Thank you for the v3!
>
> I just have one last question here below (+ 2 small comments but a v4 is
> probably not needed):
>
> (...)
>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 1cdf9cd1a3cc..82d899233df4 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -1673,6 +1673,37 @@ static void mptcp_set_nospace(struct sock *sk)
>>  	set_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags);
>>  }
>>
>> +static int mptcp_sendmsg_fastopen(struct sock *sk, struct sock *ssk, struct msghdr *msg,
>> +				  size_t len, int *copied_syn)
>> +{
>> +	unsigned int saved_flags = msg->msg_flags;
>> +	struct mptcp_sock *msk = mptcp_sk(sk);
>> +	int ret;
>> +
>> +	lock_sock(ssk);
>> +	msg->msg_flags |= MSG_DONTWAIT;
>> +	msk->connect_flags = O_NONBLOCK;
>
> Just to be sure I understand properly: here O_NONBLOCK is set but that
> will only be used for the subflow and only if MSG_FASTOPEN is set (and
> allowed), so not for TCP_FASTOPEN_CONNECT, right?
>
> But no need to reset them later, right?
>
> (I'm a bit confused by the fact we set msk->connect_flags in
> mptcp_stream_connect() before calling __inet_stream_connect() and not
> here below)
>

msk->connect_flags is set above? But I wonder if the packetdrill problem 
above is happening because msk->connect_flags should be updated again 
before the __inet_stream_connect() call.


>> +	msk->is_sendmsg = 1;
>> +	ret = tcp_sendmsg_fastopen(ssk, msg, copied_syn, len, NULL);
>> +	msk->is_sendmsg = 0;
>> +	msg->msg_flags = saved_flags;
>> +	release_sock(ssk);
>> +
>> +	/* do the blocking bits of inet_stream_connect outside the ssk socket lock */
>> +	if (ret == -EINPROGRESS && !(msg->msg_flags & MSG_DONTWAIT)) {
>> +		ret = __inet_stream_connect(sk->sk_socket, msg->msg_name,
>> +					    msg->msg_namelen, msg->msg_flags, 1);
>> +
>> +		/* Keep the same behaviout of plain TCP: zero the copied bytes in
>
> s/behaviout/behaviour/ but I can fix that when applying the patch, I
> guess "checkpatch.pl --codespell" will remind me that.
>
>> +		 * case of any error, except timeout or signal
>> +		 */
>> +		if (ret && ret != -EINPROGRESS && ret != -ERESTARTSYS && ret != -EINTR)
>> +			*copied_syn = 0;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>  static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>>  {
>>  	struct mptcp_sock *msk = mptcp_sk(sk);
>> @@ -1693,26 +1724,14 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>>
>>  	ssock = __mptcp_nmpc_socket(msk);
>>  	if (unlikely(ssock && inet_sk(ssock->sk)->defer_connect)) {
>> -		struct sock *ssk = ssock->sk;
>>  		int copied_syn = 0;
>>
>> -		lock_sock(ssk);
>> -
>> -		msk->connect_flags = (msg->msg_flags & MSG_DONTWAIT) ? O_NONBLOCK : 0;
>> -		msk->is_sendmsg = 1;
>> -		ret = tcp_sendmsg_fastopen(ssk, msg, &copied_syn, len, NULL);
>> -		msk->is_sendmsg = 0;
>> +		ret = mptcp_sendmsg_fastopen(sk, ssock->sk, msg, len, &copied_syn);
>
>
> It might look a bit strange to add some code here and then move it to a
> dedicated function in the following commit but I'm sure that will be
> fine for other net maintainers! :-)
>

The other changes in "mptcp: factor out mptcp_connect()" are big enough 
that I think it makes sense to have two separate commits!



--
Mat Martineau
Intel
