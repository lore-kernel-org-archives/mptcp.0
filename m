Content-Type: multipart/mixed; boundary="===============6594009033131992515=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [RFC PATCH 04/12] mptcp: basic sndbuf autotuning
Date: Sun, 02 Aug 2020 00:45:03 +0200
Message-ID: <20200801224503.GC29169@breakpoint.cc>
In-Reply-To: f82128dc0044d0a52ba11940b57f18f3630076f5.1596216310.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5423

--===============6594009033131992515==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Paolo Abeni <pabeni(a)redhat.com> wrote:
> Let the msk sendbuf track the size of the larger subflow's
> send buffer.
>
> The update is performed just before try to send any data.

Looks good, small nit:

> +	/* do auto tuning */
> +	if (!(sk->sk_userlocks & SOCK_RCVBUF_LOCK) &&
> +	    sndbuf > READ_ONCE(sk->sk_sndbuf))
> +		WRITE_ONCE(sk->sk_sndbuf, sndbuf);

SOCK_SNDBUF_LOCK
--===============6594009033131992515==--
