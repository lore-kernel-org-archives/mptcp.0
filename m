Content-Type: multipart/mixed; boundary="===============3936638724588792560=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 5/5] mptcp: implement delegated actions
Date: Wed, 20 Jan 2021 13:48:16 +0100
Message-ID: <cfbbf7b06522e21331328973756831ed06af2a68.camel@redhat.com>
In-Reply-To: 8706d39df58e903238c050999e6f88b8eb78d4a1.1610991949.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 7442

--===============3936638724588792560==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-01-20 at 11:40 +0100, Paolo Abeni wrote:
> @@ -428,6 +429,7 @@ static int subflow_v4_conn_request(struct sock *sk, s=
truct sk_buff *skb)
>  static struct tcp_request_sock_ops subflow_request_sock_ipv6_ops;
>  static struct inet_connection_sock_af_ops subflow_v6_specific;
>  static struct inet_connection_sock_af_ops subflow_v6m_specific;
> +static struct proto tcpv6_prot_override;
>  =

>  static int subflow_v6_conn_request(struct sock *sk, struct sk_buff *skb)
>  {
> @@ -509,6 +511,14 @@ static void subflow_ulp_fallback(struct sock *sk,
>  	icsk->icsk_ulp_ops =3D NULL;
>  	rcu_assign_pointer(icsk->icsk_ulp_data, NULL);
>  	tcp_sk(sk)->is_mptcp =3D 0;
> +
> +	/* undo override */
> +#if IS_ENABLED(CONFIG_MPTCP_IPV6)
> +	if (sk->sk_prot =3D=3D &tcpv6_prot_override)
> +		sk->sk_prot =3D &tcpv6_prot;
> +	else
> +#endif
> +		sk->sk_prot =3D &tcp_prot;

CI just spotted an UaF due this patch. We need to do the above also at
ULP release time. I'll send a v2 soon.

Sorry for the noise.

Paolo

--===============3936638724588792560==--
