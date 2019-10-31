Content-Type: multipart/mixed; boundary="===============7974945865322456281=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH 5/6] mptcp: Export low-level routines for IPv6
Date: Thu, 31 Oct 2019 09:26:40 +0100
Message-ID: <3b89f10dd6a661921b1757a1b2d5346f29ba398c.camel@redhat.com>
In-Reply-To: 20191030233844.4790-6-peter.krystad@linux.intel.com
X-Status: 
X-Keywords:                  
X-UID: 2371

--===============7974945865322456281==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2019-10-30 at 16:38 -0700, Peter Krystad wrote:
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

Minor nit: it looks like this chunk is not needed ?

Cheers,

Paolo

--===============7974945865322456281==--
