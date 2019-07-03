Content-Type: multipart/mixed; boundary="===============0399053202816617486=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] mptcp: Make MPTCP socket block/wakeup ignore
 sk_receive_queue
Date: Wed, 03 Jul 2019 11:10:18 -0700
Message-ID: <alpine.OSX.2.21.1907031005390.30368@sscooper-mobl1.amr.corp.intel.com>
In-Reply-To: 292673d0597cb7cbac5b53a1155403e2c16c13ee.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1469

--===============0399053202816617486==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Jul 2019, Paolo Abeni wrote:

> Hi all,
>
> [sorry for lagging behind so much, the relocation trapped me for a
> while]
>
> On Wed, 2019-06-26 at 16:11 -0700, Mat Martineau wrote:
>> The MPTCP-level socket doesn't use sk_receive_queue, so it was possible
>> for mptcp_recvmsg() to remain blocked when there was data ready for it
>> to read. When the MPTCP socket is waiting for additional data and it
>> releases the subflow socket lock, the subflow may have incoming packets
>> ready to process and it sometimes called subflow_data_ready() before the
>> MPTCP socket called sk_wait_data().
>>
>> This change adds new functions for the MPTCP socket to use to wait and
>> to signal that data is ready. Atomic bitops are used to set, test, and
>> clear a MPTCP socket flag that indicates waiting subflow data. This flag
>> replaces the sk_receive_queue checks used by other socket types.
>>
>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>> ---
>>
>> Squashing this into "mptcp: Implement MPTCP receive path" has a few
>> conflicts with later commits that also fix up the receive code. It's
>> fine to add this to the end of the commit chain.
>>
>>  net/mptcp/protocol.c | 40 +++++++++++++++++++++++++++++++++++++++-
>>  net/mptcp/protocol.h |  4 ++++
>>  2 files changed, 43 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 774ed25d3b6d..5555ee1529bb 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -357,6 +357,26 @@ static enum mapping_status mptcp_get_mapping(struct=
 sock *ssk)
>>  	return ret;
>>  }
>>
>> +static void mptcp_wait_data(struct sock *sk, long *timeo)
>> +{
>> +	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
>> +
>> +	add_wait_queue(sk_sleep(sk), &wait);
>> +	sk_set_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>> +
>> +	release_sock(sk);
>> +
>> +	if (!test_and_clear_bit(MPTCP_DATA_READY, &msk->flags))
>> +		*timeo =3D wait_woken(&wait, TASK_INTERRUPTIBLE, *timeo);
>> +
>> +	sched_annotate_sleep();
>> +	lock_sock(sk);
>
> Can we reuse the sk_wait_event() macro here ? It would avoid a bit of
> code duplication.

My concern there was the second condition check in sk_wait_event() (after =

the lock is re-acquired). It looks like normal sk_wait_event() conditions =

do not modify anything, but test_and_clear_bit() does change the flag. =

sk_wait_event() would call test_and_clear_bit() twice, which it doesn't =

need to do and would modify the flag an extra time. While it doesn't break =

anything (the flag gets cleared yet again running through the recv loop), =

I thought I'd skip the extra atomic write operation.

I can see how that might be premature optimization, let me know if you =

still think it's best to reuse sk_wait_event().

>
>> +
>> +	sk_clear_bit(SOCKWQ_ASYNC_WAITDATA, sk);
>> +	remove_wait_queue(sk_sleep(sk), &wait);
>> +}
>> +
>>  static int mptcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t le=
n,
>>  			 int nonblock, int flags, int *addr_len)
>>  {
>> @@ -403,6 +423,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msg=
hdr *msg, size_t len,
>>  		u64 old_ack;
>>  		u32 ssn;
>>
>> +		clear_bit(MPTCP_DATA_READY, &msk->flags);
>>  		status =3D mptcp_get_mapping(ssk);
>>
>>  		if (status =3D=3D MAPPING_ADDED) {
>> @@ -536,7 +557,7 @@ static int mptcp_recvmsg(struct sock *sk, struct msg=
hdr *msg, size_t len,
>>
>>  		pr_debug("block");
>>  		release_sock(ssk);
>> -		sk_wait_data(sk, &timeo, NULL);
>> +		mptcp_wait_data(sk, &timeo);
>>  		lock_sock(ssk);
>>  	}
>>
>> @@ -548,6 +569,22 @@ static int mptcp_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
>>  	return copied;
>>  }
>>
>> +static void mptcp_data_ready(struct sock *sk)
>> +{
>> +	struct mptcp_sock *msk =3D mptcp_sk(sk);
>> +	struct socket_wq *wq;
>> +
>> +	set_bit(MPTCP_DATA_READY, &msk->flags);
>> +
>> +	rcu_read_lock();
>> +	wq =3D rcu_dereference(sk->sk_wq);
>> +	if (skwq_has_sleeper(wq))
>> +		wake_up_interruptible_sync_poll(&wq->wait, EPOLLIN | EPOLLPRI |
>> +						EPOLLRDNORM | EPOLLRDBAND);
>> +	sk_wake_async(sk, SOCK_WAKE_WAITD, POLL_IN);
>> +	rcu_read_unlock();
>
> It looks like the above chunk of code matches quite exactly
> sock_def_readable().
>
> To avoid code duplication, what about moving:
> 	set_bit(MPTCP_DATA_READY, &msk->flags);
>
> in subflow_data_ready(), just before calling:
> 	parent->sk_data_ready(parent)
>
> ?
>
> If so, we can also drop the following chunk.

I had wanted to make sure the set_bit() would happen for all callers of =

the MPTCP socket's sk_data_ready(), and sock_def_readable is static within =

net/core/sock.c so I couldn't call it without changing its scope.

Looking at other callers of sk_data_ready(), it does look like the only =

one relevant for the MPTCP socket is subflow_data_ready() so I will take =

your suggestion and place the set_bit() there instead.

>
> BTW, were you able to reproduce the self-test bug with this patch
> applied?

I haven't seen that bug lately with or without this patch. I'll try to =

reproduce it.

--
Mat Martineau
Intel

--===============0399053202816617486==--
