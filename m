Content-Type: multipart/mixed; boundary="===============4310133936398706804=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net 1/5] mptcp: consolidate synack processing.
Date: Wed, 29 Apr 2020 11:50:34 -0700
Message-ID: <20200429.115034.117126455083840977.davem@davemloft.net>
In-Reply-To: 5261bc9add632deda5890816c41188ee80c6765e.1588156257.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 4277

--===============4310133936398706804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>
Date: Wed, 29 Apr 2020 12:41:45 +0200

> @@ -222,6 +222,7 @@ static void subflow_finish_connect(struct sock *sk, c=
onst struct sk_buff *skb)
>  {
>  	struct mptcp_subflow_context *subflow =3D mptcp_subflow_ctx(sk);
>  	struct sock *parent =3D subflow->conn;
> +	struct tcp_sock *tp =3D tcp_sk(sk);

Since you introduce this 'tp' variable...

> +	} else if (subflow->request_mptcp) {
> +		tcp_sk(sk)->is_mptcp =3D 0;

Please use it here.

> +	}
> +
> +	if (!tcp_sk(sk)->is_mptcp)
>  		return;

And here.

Thank you.
--===============4310133936398706804==--
