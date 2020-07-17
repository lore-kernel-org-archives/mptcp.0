Content-Type: multipart/mixed; boundary="===============4248652807985376404=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next 07/12] mptcp: Send DATA_FIN in
 appropriate states during shutdown or close
Date: Fri, 17 Jul 2020 11:39:32 -0700
Message-ID: <alpine.OSX.2.23.453.2007171129090.39222@kdpetti-mobl.amr.corp.intel.com>
In-Reply-To: 7dd3420d01d8eef99586436bde3fcbccdf8fe013.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5087

--===============4248652807985376404==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Jul 2020, Paolo Abeni wrote:

> On Wed, 2020-07-15 at 17:20 -0700, Mat Martineau wrote:
>> mptcp_shutdown now sends DATA_FIN on the subflows without shutting the
>> subflows themselves down. The subflows need to stay connected while
>> DATA_FIN is acked or possibly retransmitted.
>>
>> mptcp_close should only send DATA_FIN if the MPTCP-level connection
>> state requires it.
>>
>> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
>> ---
>>  net/mptcp/protocol.c | 44 ++++++++++++++++++++++++++++++++------------
>>  1 file changed, 32 insertions(+), 12 deletions(-)
>>
>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>> index 2a93976fdb58..9eef1fbe300b 100644
>> --- a/net/mptcp/protocol.c
>> +++ b/net/mptcp/protocol.c
>> @@ -1512,7 +1512,7 @@ static void mptcp_cancel_work(struct sock *sk)
>>  		sock_put(sk);
>>  }
>>
>> -static void mptcp_subflow_shutdown(struct sock *ssk, int how)
>> +static void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, i=
nt how)
>>  {
>>  	lock_sock(ssk);
>>
>> @@ -1525,8 +1525,8 @@ static void mptcp_subflow_shutdown(struct sock *ss=
k, int how)
>>  		tcp_disconnect(ssk, O_NONBLOCK);
>>  		break;
>>  	default:
>> -		ssk->sk_shutdown |=3D how;
>> -		tcp_shutdown(ssk, how);
>> +		mptcp_set_timeout(sk, ssk);
>> +		tcp_send_ack(ssk);
>>  		break;
>>  	}
>>
>> @@ -1565,9 +1565,11 @@ static void mptcp_close(struct sock *sk, long tim=
eout)
>>  	struct mptcp_subflow_context *subflow, *tmp;
>>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
>>  	LIST_HEAD(conn_list);
>> +	int prev_state;
>>
>>  	lock_sock(sk);
>>
>> +	prev_state =3D sk->sk_state;
>>  	inet_sk_state_store(sk, TCP_CLOSE);
>>
>>  	/* be sure to always acquire the join list lock, to sync vs
>> @@ -1578,7 +1580,15 @@ static void mptcp_close(struct sock *sk, long tim=
eout)
>>  	spin_unlock_bh(&msk->join_list_lock);
>>  	list_splice_init(&msk->conn_list, &conn_list);
>>
>> -	msk->snd_data_fin_enable =3D 1;
>> +	if ((1 << prev_state) &
>> +	    (TCPF_ESTABLISHED | TCPF_SYN_SENT |
>> +	     TCPF_SYN_RECV | TCPF_CLOSE_WAIT)) {
>> +		WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
>> +		WRITE_ONCE(msk->snd_data_fin_enable, 1);
>> +	} else {
>> +		/* DATA_FIN has already been sent in other states */
>> +		WRITE_ONCE(msk->snd_data_fin_enable, 0);
>> +	}
>
> Why do we need to explicitly clear 'snd_data_fin_enable' here?
>
> Why don't we need an 'mptcp_close_state()' call here, replacing
> the inet_sk_state_store() above?

Both these issues are introduced here and immediately clobbered in the =

next commit. My intent was to align the mptcp_close behavior with the =

change to mptcp_shutdown made in this commit so the close wouldn't =

duplicate what's happening in shutdown. But it probably adds more =

confusion than value.

I'll drop this hunk and just leave mptcp_close unchanged in this commit, =

leaving the real changes in the next commit.

>
>>  	__mptcp_clear_xmit(sk);
>>
>> @@ -2263,11 +2273,8 @@ static int mptcp_shutdown(struct socket *sock, in=
t how)
>>  	pr_debug("sk=3D%p, how=3D%d", msk, how);
>>
>>  	lock_sock(sock->sk);
>> -	if (how =3D=3D SHUT_WR || how =3D=3D SHUT_RDWR)
>> -		inet_sk_state_store(sock->sk, TCP_FIN_WAIT1);
>>
>>  	how++;
>> -
>>  	if ((how & ~SHUTDOWN_MASK) || !how) {
>>  		ret =3D -EINVAL;
>>  		goto out_unlock;
>> @@ -2281,13 +2288,26 @@ static int mptcp_shutdown(struct socket *sock, i=
nt how)
>>  			sock->state =3D SS_CONNECTED;
>>  	}
>>
>> -	__mptcp_flush_join_list(msk);
>> -	msk->snd_data_fin_enable =3D 1;
>> +	/* If we've already sent a FIN, or it's a closed state, skip this. */
>> +	if ((how & SEND_SHUTDOWN) &&
>> +	    ((1 << sock->sk->sk_state) &
>> +	     (TCPF_ESTABLISHED | TCPF_SYN_SENT |
>> +	      TCPF_SYN_RECV | TCPF_CLOSE_WAIT))) {
>>
>> -	mptcp_for_each_subflow(msk, subflow) {
>> -		struct sock *tcp_sk =3D mptcp_subflow_tcp_sock(subflow);
>> +		if (mptcp_close_state(sock->sk)) {
>> +			__mptcp_flush_join_list(msk);
>>
>> -		mptcp_subflow_shutdown(tcp_sk, how);
>> +			WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
>> +			WRITE_ONCE(msk->snd_data_fin_enable, 1);
>
> This is quite alike the code inside mptcp_close(), except for
> the mptcp_close_state() call. Can we factor out the code in an helper?
>

Sure.

--
Mat Martineau
Intel
--===============4248652807985376404==--
