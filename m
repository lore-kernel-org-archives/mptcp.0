Content-Type: multipart/mixed; boundary="===============1653776939051334287=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] Revert tcp_skb_cb to it's original size and
 cleanup main TCP Rx code from MPTCP specific code.
Date: Tue, 27 Jun 2017 16:22:55 -0700
Message-ID: <alpine.OSX.2.21.1706271459160.10721@jvshah-mobl3.amr.corp.intel.com>
In-Reply-To: 20170626211352.GA7371@caduceus5
X-Status: 
X-Keywords:                  
X-UID: 58

--===============1653776939051334287==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Rao,

On Mon, 26 Jun 2017, Rao Shoaib wrote:

> This patch returns tcp_skb_cb to it's original size. It also refactors =

> MPTCP code so that there are no MPTCP checks in the main Rx pathi, no =

> performance overheads such as cpu prodiction issues. tcp_v4_rcv() and =

> tcp_v4_do_rcv() do not have any MPTCP specific checks any more, niether =

> does tcp_ack(). On the Rx path MPTCP options are not parsed till the =

> data is being pushed up to the meta socket (mptcp_data_ready). on the Tx =

> side there is one check to add MPTCP specific options but that's it, =

> that should not be that bad as for regular TCP it is a simple check, but =

> it would be good to remove it..
>
> I have tested the changes with ndiffports set to 2, so join works. I =

> have also tested accessing multipath-tcp.org and downloading files from =

> there and also ran the speed test.
>
> The Bad:
>
> The error cases still have MPTCP checks but that should be OK as they =

> are error cases. I had to use a special marker 0xFEE1DEAD for indicate a =

> special case. I had to introdue a new socket specfic function. IPv6 has =

> not been changed yet. I am sure I have missed some corner cases and more =

> testing will reveal more issues but we just have to fix them.
>
> I would like to hear comments from the list and if this direction seems =

> reasonable we can take this as the starting point, port it to latest =

> Linux and share the design with the mainstream folks.

I've read the earlier messages in this thread, so I've seen Christoph's =

concern about zero-length packets and your comment that more work is =

needed.

The TCP option handling patch I posted earlier (I'm testing an updated =

version of that before sending it out again) might help us avoid passing =

unexpected zero-length packets up the stack.

My coworkers and I have some ideas for other upstream-friendly =

architecture changes, but I still need to type those up for mailing list =

discussion. We've done some work building up from the current net-next =

kernel and will get some patches in shape for this list.

I have some comments below:


>
> Signed-off-by: Rao Shoaib <rao.shoaib(a)oracle.com>
> ---
> include/linux/skbuff.h      |   8 ++-
> include/net/mptcp.h         |  21 +++---
> include/net/mptcp_v4.h      |   1 +
> include/net/sock.h          |  12 +++-
> include/net/tcp.h           |  23 +++----
> net/ipv4/af_inet.c          |   4 ++
> net/ipv4/tcp_input.c        |  37 ++--------
> net/ipv4/tcp_ipv4.c         | 135 +++++++++++++++++++++++--------------
> net/ipv4/tcp_output.c       |   1 +
> net/ipv6/af_inet6.c         |   4 ++
> net/ipv6/tcp_ipv6.c         |   4 --
> net/mptcp/mptcp_ctrl.c      |  21 ++++++
> net/mptcp/mptcp_input.c     | 131 ++++++++++++++++++++++++++++--------
> net/mptcp/mptcp_ipv4.c      |  35 +---------
> net/mptcp/mptcp_ipv6.c      |   4 +-
> net/mptcp/mptcp_output.c    | 160 +++++++++++++++++----------------------=
-----
> net/mptcp/mptcp_redundant.c |   6 +-
> net/mptcp/mptcp_rr.c        |   4 +-
> net/mptcp/mptcp_sched.c     |  10 +--
> 19 files changed, 335 insertions(+), 286 deletions(-)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index f66cd5e..348cbc1 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -532,7 +532,13 @@ struct sk_buff {
> 		struct rb_node	rbnode; /* used in netem & tcp stack */
> 	};
> 	struct sock		*sk;
> -	struct net_device	*dev;
> +	union {
> +		struct net_device	*dev;
> +		struct {
> +			__u8 mptcp_flags;
> +			__u8 mptcp_dss_off;
> +		};
> +	};

I think the maintainers will oppose placement of protocol-specific fields =

in struct sk_buff.

Recent kernels have changed this to a union between the dev pointer and a =

dev_scratch integer. So far dev_scratch is only used by UDP.


> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 655ecd4..cbe8ef2 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -47,6 +47,9 @@
> #include <linux/seq_file.h>
> #include <linux/memcontrol.h>
>
> +typedef int (* process_unclaimed)(struct sock *sk, struct sk_buff *skb);
> +extern process_unclaimed tcp_process_unclaimed;
> +
> extern struct inet_hashinfo tcp_hashinfo;
>
> extern struct percpu_counter tcp_orphan_count;
> @@ -581,6 +584,7 @@ struct sock *tcp_v4_syn_recv_sock(struct sock *sk, st=
ruct sk_buff *skb,
> 				  struct request_sock *req,
> 				  struct dst_entry *dst);
> int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb);
> +
> int tcp_v4_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
> int tcp_connect(struct sock *sk);
> struct sk_buff *tcp_make_synack(struct sock *sk, struct dst_entry *dst,
> @@ -842,11 +846,6 @@ struct tcp_skb_cb {
> 		__u32		tcp_gso_segs;
> 	};
>
> -#ifdef CONFIG_MPTCP
> -	__u8		mptcp_flags;	/* flags for the MPTCP layer    */
> -	__u8		dss_off;	/* Number of 4-byte words until
> -					 * seq-number */
> -#endif
> 	__u8		tcp_flags;	/* TCP header flags. (tcp[13])	*/
>
> 	__u8		sacked;		/* State flags for SACK/FACK.	*/
> @@ -859,9 +858,13 @@ struct tcp_skb_cb {
> #define TCPCB_RETRANS		(TCPCB_SACKED_RETRANS|TCPCB_EVER_RETRANS| \
> 				TCPCB_REPAIRED)
>
> -	__u8		ip_dsfield;	/* IPv4 tos or IPv6 dsfield	*/
> +	__u8		ip_dsfield;	/* IPv4 tos or IPv6 dsfield */
> 	/* 1 byte hole */
> -	__u32		ack_seq;	/* Sequence number ACK'd	*/
> +	union {
> +		__u32		ack_seq;	/* Sequence number ACK'd */
> +		__u32 		mptcp_data_seq;

ack_seq is only used on incoming packets, and mptcp_data_seq only on =

outgoing?

> +		__u32		mptcp_path_mask;
> +	};

One architectural change we're considering is not sharing sk_buffs between =

subflows, which would make mptcp_path_mask unnecessary. It would still be =

necessary to track that information, just not as part of sk_buff.


>
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 73480b9..1e7827f 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -356,6 +356,10 @@ lookup_protocol:
> 	sk->sk_destruct	   =3D inet_sock_destruct;
> 	sk->sk_protocol	   =3D protocol;
> 	sk->sk_backlog_rcv =3D sk->sk_prot->backlog_rcv;
> +	sk->sk_prequeue =3D sk->sk_prot->prequeue;
> +	if (sk->sk_prequeue =3D=3D NULL) {
> +		sk->sk_prequeue =3D sk_prequeue;
> +	}

Although it differs from my personal preference, kernel coding style calls =

for no braces when there's a single statement after an 'if':

https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-br=
aces-and-spaces

I noticed this several places in the patch.



--
Mat Martineau
Intel OTC

--===============1653776939051334287==--
