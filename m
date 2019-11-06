Content-Type: multipart/mixed; boundary="===============1585974862210754329=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2 5/6] mptcp: Export low-level routines for IPv6
Date: Wed, 06 Nov 2019 10:03:20 +0100
Message-ID: <c80e8e0f7ae025b051fe5492e27a0ef1f7a36d17.camel@redhat.com>
In-Reply-To: 20191106044133.14418-6-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2420

--===============1585974862210754329==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-11-05 at 20:41 -0800, Peter Krystad wrote:
> @@ -1111,7 +1111,8 @@ static void tcp_v6_restore_cb(struct sk_buff *skb)
>  		sizeof(struct inet6_skb_parm));
>  }
>  =

> -static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct s=
k_buff *skb,
> +static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk,
> +					 struct sk_buff *skb,
>  					 struct request_sock *req,
>  					 struct dst_entry *dst,
>  					 struct request_sock *req_unhash,

Minor nit: it looks like this chunk is not needed[1].

Cheers,

Paolo

[1] https://youtu.be/XfEuxRDYiyc ;)

--===============1585974862210754329==--
