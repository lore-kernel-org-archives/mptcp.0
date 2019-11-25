Content-Type: multipart/mixed; boundary="===============0261185822455279588=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC 7/7] make accept not allocate kernel socket struct
Date: Mon, 25 Nov 2019 13:24:45 +0100
Message-ID: <8521f5a18bb86408469be4b83e7ae200a8d81e42.camel@redhat.com>
In-Reply-To: 20191125021508.29153-8-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2683

--===============0261185822455279588==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-11-25 at 03:15 +0100, Florian Westphal wrote:
> @@ -924,10 +924,17 @@ static void mptcp_close(struct sock *sk, long timeo=
ut)
>  =

>  	list_for_each_entry_safe(subflow, tmp, &msk->conn_list, node) {
>  		struct sock *ssk =3D mptcp_subflow_tcp_sock(subflow);
> +		struct socket *sock =3D READ_ONCE(ssk->sk_socket);
>  =

>  		pr_debug("conn_list->subflow=3D%p", subflow);
>  		list_del(&subflow->node);
> -		sock_release(ssk->sk_socket);
> +
> +		if (sock && sock !=3D sk->sk_socket) {
> +			sock_release(sock);

Double checking I read the above correctly: the condition 'sock && sock
!=3D sk->sk_socket' only for the first subflow of a client socket, right?
If so, can we use the msk socket even for that one?

> @@ -1443,6 +1470,20 @@ static int mptcp_stream_accept(struct socket *sock=
, struct socket *newsock,
>  		return -EINVAL;
>  =

>  	err =3D ssock->ops->accept(sock, newsock, flags, kern);
> +	if (err =3D=3D 0 && (newsock->sk->sk_prot =3D=3D &mptcp_prot ||
> +			 is_mptcp_v6(newsock))) {

Is not clear to me why/how we can hit the condition '!(newsock->sk-
>sk_prot =3D=3D &mptcp_prot || is_mptcp_v6(newsock))' ... Can you please
explain?

Thanks!

Paolo

--===============0261185822455279588==--
