Content-Type: multipart/mixed; boundary="===============0034437262298845491=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH mptcp v3] mptcp: switch sublist to mptcp socket
 lock protection
Date: Mon, 27 May 2019 10:36:57 +0200
Message-ID: <5428184a-b1d9-99f0-e132-ac7bba771d7b@tessares.net>
In-Reply-To: 20190525092614.7wm44r6bwzeuagpa@breakpoint.cc
X-Status: 
X-Keywords:                  
X-UID: 1248

--===============0034437262298845491==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Mat,

On 25/05/2019 11:26, Florian Westphal wrote:
> Mat Martineau <mathew.j.martineau(a)linux.intel.com> wrote:
>>> +	if (sock->sk->sk_state =3D=3D TCP_CLOSE)
>>> +		sock->sk->sk_state =3D TCP_SYN_SENT;
>>
>> Should this use inet_sk_state_store()?
> =

> I can change it.
> =

>>> 	return inet_stream_connect(msk->subflow, uaddr, addr_len, flags);
>>
>> Since this could return an error, the MPTCP socket state could be set to
>> TCP_SYN_SENT if the subflow connect call succeeded and ended up in the r=
ight
>> state.
> =

> Yes.  I think we need to decide how to handle sk_state on the mptcp socke=
t.
> E.g., should this match/mirror the state of the initial subflow?

That's a good question!

For the moment with only one subflow, that's easy, we can mirror the state.

But for later, we will need something different:
- we can have multiple subflows, the first one can be disconnected while
others are still alive.

- maybe not all states are relevant for MPTCP use case but that's a detail.

- we might need to add states to manage some MPTCP-specific cases, e.g.
if you send an ACK with MP_FASTCLOSE, you will need to wait for a RST
and possibly do some retransmissions. Note that with the new RFC6824
bis, MPTCP v1, we might no longer need this if you pick the new "Option
R (RST)":

https://tools.ietf.org/html/draft-ietf-mptcp-rfc6824bis-16#section-3.5

It can be interesting to have this discussion with Christoph!

> After this change, we have transition to TCP_SYN_SENT when the
> connection attempt on the first subflow is initiated, and instant
> transition to ESTABLISHED when that subflow finishes 3WHS.
> =

> It should move back to TCP_CLOSE on failure, but at this time this will
> only happen on mptcp_close().
> =

>>> @@ -994,24 +1001,20 @@ static int mptcp_shutdown(struct socket *sock, i=
nt how)
>>> 	}
>>>
>>> 	/* protect against concurrent mptcp_close(), so that nobody can
>>> -	 * remove entries from the conn list and walking the list breaking
>>> -	 * the RCU critical section is still safe. We need to release the
>>> -	 * RCU lock to call the blocking kernel_sock_shutdown() primitive
>>> -	 * Note: we can't use MPTCP socket lock to protect conn_list changes,
>>> +	 * remove entries from the conn list and walking the list
>>> +	 * is still safe.
>>> +	 *
>>> +	 * We can't use MPTCP socket lock to protect conn_list changes,
>>> 	 * as we need to update it from the BH via the mptcp_finish_connect()
>>> 	 */
>>> 	lock_sock(sock->sk);
>>> -	rcu_read_lock();
>>> -	list_for_each_entry_rcu(subflow, &msk->conn_list, node) {
>>> +	list_for_each_entry(subflow, &msk->conn_list, node) {
>>
>> Minor: this could use mptcp_for_each_subflow()
> =

> Yes, although I do wonder if we should just axe that macro, I think that
> it doesn't provide any added value vs. using list_for_each_entry directly.

That's true but maybe mptcp_for_each_subflow() is clearer and it can
help to quickly identify where we walk through all subflows (if you need
to debug locking issues, etc.).
But that's indeed minor.

Cheers,
Matt

> _______________________________________________
> mptcp mailing list
> mptcp(a)lists.01.org
> https://lists.01.org/mailman/listinfo/mptcp
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============0034437262298845491==--
