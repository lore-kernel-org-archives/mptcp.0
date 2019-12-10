Content-Type: multipart/mixed; boundary="===============4284637374113154475=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 2/4] imptcp: cleanup fallback handling
Date: Mon, 09 Dec 2019 18:28:35 -0800
Message-ID: <alpine.OSX.2.21.1912091815380.11558@mjmartin-mac01.local>
In-Reply-To: alpine.OSX.2.21.1912091752400.11558@mjmartin-mac01.local
X-Status: 
X-Keywords:                  
X-UID: 2855

--===============4284637374113154475==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 9 Dec 2019, Mat Martineau wrote:

> On Tue, 10 Dec 2019, Paolo Abeni wrote:

...
>
>> @@ -962,11 +994,15 @@ static int mptcp_listen(struct socket *sock, int =

>> backlog)
>>
>> 	pr_debug("msk=3D%p", msk);
>> =

>> -	ssock =3D mptcp_socket_create_get(msk);
>> +	ssock =3D mptcp_socket_create_get(msk, TCP_LISTEN);
>> 	if (IS_ERR(ssock))
>> 		return PTR_ERR(ssock);
>>
>> 	err =3D ssock->ops->listen(ssock, backlog);
>> +
>> +	/* should we keep msk socket lock instead? and release it this
>> +	 * latter state update */
>
> Same locking comment as mptcp_stream_connect above, and same caveat =

> concerning patch 4 and squashing.
>
> Other than these two functions, locking looks ok.
>
>
> Mat
>
>
>> +	inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
>> 	sock_put(ssock->sk);
>> 	return err;
>> }
>> @@ -985,13 +1021,20 @@ static int mptcp_stream_accept(struct socket *soc=
k, =

>> struct socket *newsock,
>> {
>> 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
>> 	struct socket *ssock;
>> -	int err;
>> +	int err =3D -EINVAL;
>>
>> 	pr_debug("msk=3D%p", msk);
>> =

>> -	ssock =3D mptcp_fallback_get_ref(msk);
>> +	lock_sock(sock->sk);
>> +	if (sock->sk->sk_state !=3D TCP_LISTEN)
>> +		goto unlock_fail;
>> +
>> +	ssock =3D __mptcp_nmpc_socket(msk);
>> 	if (!ssock)
>> -		return -EINVAL;
>> +		goto unlock_fail;
>> +
>> +	sock_hold(ssock->sk);
>> +	release_sock(sock->sk);
>>
>> 	err =3D ssock->ops->accept(sock, newsock, flags, kern);
>> 	if (err =3D=3D 0 && !is_tcp_proto(newsock->sk->sk_prot)) {

I did just say "locking looks ok", but just below this is some iteration =

over msk->conn_list without the msk lock held. The locking there is =

unaffected by your patch, but this might be a good chance to take a look =

at the locking around that list iteration!


Mat

>> @@ -1011,6 +1054,10 @@ static int mptcp_stream_accept(struct socket *soc=
k, =

>> struct socket *newsock,
>>
>> 	sock_put(ssock->sk);
>> 	return err;
>> +
>> +unlock_fail:
>> +	release_sock(sock->sk);
>> +	return -EINVAL;
>> }
>> =

>> static __poll_t mptcp_poll(struct file *file, struct socket *sock,
>> @@ -1023,8 +1070,9 @@ static __poll_t mptcp_poll(struct file *file, stru=
ct =

>> socket *sock,
>>
>> 	msk =3D mptcp_sk(sk);
>> 	lock_sock(sk);
>> -	ssock =3D __mptcp_fallback_get_ref(msk);
>> +	ssock =3D __mptcp_nmpc_socket(msk);
>> 	if (ssock) {
>> +		sock_hold(ssock->sk);
>> 		release_sock(sk);
>> 		mask =3D ssock->ops->poll(file, ssock, wait);
>> 		sock_put(ssock->sk);
>> @@ -1061,7 +1109,7 @@ static int mptcp_shutdown(struct socket *sock, int =

>> how)
>> 	if (how =3D=3D SHUT_WR || how =3D=3D SHUT_RDWR)
>> 		inet_sk_state_store(sock->sk, TCP_FIN_WAIT1);
>> =

>> -	ssock =3D __mptcp_fallback_get_ref(msk);
>> +	ssock =3D __mptcp_tcp_fallback_get(msk);
>> 	if (ssock) {
>> 		release_sock(sock->sk);
>> 		pr_debug("subflow=3D%p", ssock->sk);
>> -- =

>> 2.21.0
>
> --
> Mat Martineau
> Intel
> _______________________________________________
> mptcp mailing list -- mptcp(a)lists.01.org
> To unsubscribe send an email to mptcp-leave(a)lists.01.org
>

--
Mat Martineau
Intel
--===============4284637374113154475==--
