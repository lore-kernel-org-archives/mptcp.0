Content-Type: multipart/mixed; boundary="===============1518931778610021709=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next 6/8] mptcp: avoid work queue scheduling
 if possible
Date: Tue, 25 Feb 2020 13:55:45 +0100
Message-ID: <20200225125545.GL19559@breakpoint.cc>
In-Reply-To: 20200225120526.2866-7-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3785

--===============1518931778610021709==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Florian Westphal <fw(a)strlen.de> wrote:
> +void mptcp_data_ready(struct sock *sk, struct sock *ssk)
>  {
>  	struct mptcp_sock *msk =3D mptcp_sk(sk);
>  =

>  	set_bit(MPTCP_DATA_READY, &msk->flags);
>  	sk->sk_data_ready(sk);
>  =

> +	if (atomic_read(&sk->sk_rmem_alloc) < READ_ONCE(sk->sk_rcvbuf) &&
> +	    move_skbs_to_msk(msk, ssk))
> +		return;
> +

It just occured to me that it might be better to move the
sk->sk_data_ready(sk); call to the end of mptcp_data_ready(),
I would do this for next iteration.
--===============1518931778610021709==--
