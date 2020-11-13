Content-Type: multipart/mixed; boundary="===============3129357176558873653=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: refine MPTCP-level ack scheduling
Date: Fri, 13 Nov 2020 09:09:41 -0800
Message-ID: <63c76249-a6b4-2e44-88a6-4ff8dac42f9b@linux.intel.com>
In-Reply-To: 8b2de8e93e5bf8c502a3c49e0fd1636a04d48d4b.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6723

--===============3129357176558873653==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Nov 2020, Paolo Abeni wrote:

> On Thu, 2020-11-12 at 16:53 -0800, Mat Martineau wrote:
>> On Tue, 10 Nov 2020, Paolo Abeni wrote:
>>
>>> Send timely MPTCP-level ack is somewhat difficult when
>>> the insertion into the msk receive level is performed
>>> by the worker.
>>>
>>> It needs TCP-level dup-ack to notify the MPTCP-level
>>> ack_seq increase, as both the TCP-level ack seq and the
>>> rcv window are unchanged.
>>>
>>> We can actually avoid processing incoming data with the
>>> worker, and let the subflow or recevmsg() send ack as needed.
>>>
>>> When recvmsg() moves the skbs inside the msk receive queue,
>>> the msk space is still unchanged, so tcp_cleanup_rbuf() could
>>> end-up skipping TCP-level ack generation. Anyway, when
>>> __mptcp_move_skbs() is invoked, a known amount of bytes is
>>> going to be consumed soon: we update rcv wnd computation taking
>>> them in account.
>>>
>>> Additionally we need to explicitly trigger tcp_cleanup_rbuf()
>>> when recvmsg() consumes a significant amount of the receive buffer.
>>>
>>> Signed-off-by:  Paolo Abeni <pabeni(a)redhat.com>
>>> ---
>>> RFC -> v1:
>>> - removed unneeded deltas in __mptcp_move_skbs()
>>> ---
>>> net/mptcp/options.c  |   1 +
>>> net/mptcp/protocol.c | 105 +++++++++++++++++++++----------------------
>>> net/mptcp/protocol.h |   8 ++++
>>> net/mptcp/subflow.c  |   4 +-
>>> 4 files changed, 61 insertions(+), 57 deletions(-)
>>>
>>> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
>>> index 248e3930c0cb..8a59b3e44599 100644
>>> --- a/net/mptcp/options.c
>>> +++ b/net/mptcp/options.c
>>> @@ -530,6 +530,7 @@ static bool mptcp_established_options_dss(struct so=
ck *sk, struct sk_buff *skb,
>>> 		opts->ext_copy.ack64 =3D 0;
>>> 	}
>>> 	opts->ext_copy.use_ack =3D 1;
>>> +	WRITE_ONCE(msk->old_wspace, __mptcp_space((struct sock *)msk));
>>>
>>> 	/* Add kind/length/subtype/flag overhead if mapping is not populated */
>>> 	if (dss_size =3D=3D 0)
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index 4abec5f74f1c..68f7a1daba29 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -405,16 +405,42 @@ static void mptcp_set_timeout(const struct sock *=
sk, const struct sock *ssk)
>>> 	mptcp_sk(sk)->timer_ival =3D tout > 0 ? tout : TCP_RTO_MIN;
>>> }
>>>
>>> -static void mptcp_send_ack(struct mptcp_sock *msk)
>>> +static bool mptcp_subflow_active(struct mptcp_subflow_context *subflow)
>>> +{
>>> +	struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
>>> +
>>> +	/* can't send if JOIN hasn't completed yet (i.e. is usable for mptcp)=
 */
>>> +	if (subflow->request_join && !subflow->fully_established)
>>> +		return false;
>>> +
>>> +	/* only send if our side has not closed yet */
>>> +	return ((1 << ssk->sk_state) & (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT));
>>> +}
>>> +
>>> +static void mptcp_send_ack(struct mptcp_sock *msk, bool force)
>>> {
>>> 	struct mptcp_subflow_context *subflow;
>>> +	struct sock *pick =3D NULL;
>>>
>>> 	mptcp_for_each_subflow(msk, subflow) {
>>> 		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
>>>
>>> -		lock_sock(ssk);
>>> -		tcp_send_ack(ssk);
>>> -		release_sock(ssk);
>>> +		if (force) {
>>> +			lock_sock(ssk);
>>> +			tcp_send_ack(ssk);
>>> +			release_sock(ssk);
>>> +			continue;
>>> +		}
>>> +
>>> +		/* if the hintes ssk is still active, use it */
>>> +		pick =3D ssk;
>>> +		if (ssk =3D=3D msk->ack_hint)
>>> +			break;
>>
>> Choosing the subflow for the ack this way looks good to me.
>>
>> Trying to think of corner cases, the last subflow that set ack_hint might
>> be closed before mptcp_recvmsg() tries to send the dup ack. In that case
>> there doesn't seem to be much risk in picking the wrong subflow here, so
>> it doesn't seem worthwhile to make things too much more complicated. If
>> the ack_hint is a stale pointer then the ssk would have already been
>> removed from the conn_list.
>>
>>> +	}
>>> +	if (!force && pick) {
>>> +		lock_sock(pick);
>>> +		tcp_cleanup_rbuf(pick, 1);
>>> +		release_sock(pick);
>>> 	}
>>> }
>>>
>>> @@ -466,7 +492,7 @@ static bool mptcp_check_data_fin(struct sock *sk)
>>>
>>> 		ret =3D true;
>>> 		mptcp_set_timeout(sk, NULL);
>>> -		mptcp_send_ack(msk);
>>> +		mptcp_send_ack(msk, true);
>>> 		if (sock_flag(sk, SOCK_DEAD))
>>> 			return ret;
>>>
>>> @@ -489,7 +515,6 @@ static bool __mptcp_move_skbs_from_subflow(struct m=
ptcp_sock *msk,
>>> 	unsigned int moved =3D 0;
>>> 	bool more_data_avail;
>>> 	struct tcp_sock *tp;
>>> -	u32 old_copied_seq;
>>> 	bool done =3D false;
>>> 	int sk_rbuf;
>>>
>>> @@ -506,7 +531,6 @@ static bool __mptcp_move_skbs_from_subflow(struct m=
ptcp_sock *msk,
>>>
>>> 	pr_debug("msk=3D%p ssk=3D%p", msk, ssk);
>>> 	tp =3D tcp_sk(ssk);
>>> -	old_copied_seq =3D tp->copied_seq;
>>> 	do {
>>> 		u32 map_remaining, offset;
>>> 		u32 seq =3D tp->copied_seq;
>>> @@ -570,11 +594,9 @@ static bool __mptcp_move_skbs_from_subflow(struct =
mptcp_sock *msk,
>>> 			break;
>>> 		}
>>> 	} while (more_data_avail);
>>> +	msk->ack_hint =3D ssk;
>>
>> With the data path refactor series, the msk lock won't be held here any
>> more. WRITE_ONCE() here (and READ_ONCE() in mptcp_send_ack()) should be
>> enough.
>
> Good catch! That change shoul land in the worker removal series, right?
>

Yes, that works. Thanks!

--
Mat Martineau
Intel
--===============3129357176558873653==--
