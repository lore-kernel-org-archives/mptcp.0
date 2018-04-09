Content-Type: multipart/mixed; boundary="===============5260913458023025325=="
MIME-Version: 1.0
From: Christoph Paasch <cpaasch at apple.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [RFC 9/9] Add MPTCP specific code to core TCP code
Date: Sun, 08 Apr 2018 21:39:34 -0700
Message-ID: <20180409043934.GV16289@MacBook-Pro-6.local>
In-Reply-To: 8422f841-a3f8-3f92-7ff6-ba21e7729d5e@oracle.com
X-Status: 
X-Keywords:                  
X-UID: 521

--===============5260913458023025325==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 30/03/18 - 11:07:34, Rao Shoaib wrote:
> On 03/27/2018 03:27 AM, Christoph Paasch wrote:
> > On 22/02/18 - 15:50:01, rao.shoaib(a)oracle.com wrote:
> > > From: Rao Shoaib <rao.shoaib(a)oracle.com>
> > > =

> > > Signed-off-by: Rao Shoaib <rao.shoaib(a)oracle.com>
> > > ---
> > >   include/net/net_namespace.h     |  6 +++
> > >   include/net/tcp.h               | 20 +++++++--
> > >   net/core/secure_seq.c           | 70 +++++++++++++++++++++++++++++++
> > >   net/ipv4/af_inet.c              | 13 ++++++
> > >   net/ipv4/inet_connection_sock.c | 17 +++++++-
> > >   net/ipv4/ip_sockglue.c          | 20 +++++++++
> > >   net/ipv4/syncookies.c           |  3 ++
> > >   net/ipv4/tcp.c                  | 58 ++++++++++++++++++++++++++
> > >   net/ipv4/tcp_input.c            | 25 +++++++++++
> > >   net/ipv4/tcp_ipv4.c             | 66 ++++++++++++++++++++++++-----
> > >   net/ipv4/tcp_minisocks.c        | 56 ++++++++++++++++++++++++-
> > >   net/ipv4/tcp_output.c           | 31 +++++++++++---
> > >   net/ipv4/tcp_timer.c            | 44 ++++++++++++++++----
> > >   net/ipv6/ipv6_sockglue.c        | 14 +++++++
> > >   net/ipv6/tcp_ipv6.c             | 92 ++++++++++++++++++++++++++++++=
++++-------
> > >   15 files changed, 489 insertions(+), 46 deletions(-)
> > > =

> > > diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> > > index 9158ec1..eb845cb 100644
> > > --- a/include/net/net_namespace.h
> > > +++ b/include/net/net_namespace.h
> > > @@ -18,6 +18,9 @@
> > >   #include <net/netns/packet.h>
> > >   #include <net/netns/ipv4.h>
> > >   #include <net/netns/ipv6.h>
> > > +#ifdef CONFIG_MPTCP
> > > +#include <net/netns/mptcp.h>
> > > +#endif
> > >   #include <net/netns/ieee802154_6lowpan.h>
> > >   #include <net/netns/sctp.h>
> > >   #include <net/netns/dccp.h>
> > > @@ -100,6 +103,9 @@ struct net {
> > >   #if IS_ENABLED(CONFIG_IPV6)
> > >   	struct netns_ipv6	ipv6;
> > >   #endif
> > > +#ifdef CONFIG_MPTCP
> > > +	struct	netns_mptcp      mptcp;
> > > +#endif
> > >   #if IS_ENABLED(CONFIG_IEEE802154_6LOWPAN)
> > >   	struct netns_ieee802154_lowpan	ieee802154_lowpan;
> > >   #endif
> > > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > > index 3344b1d..a785a85 100644
> > > --- a/include/net/tcp.h
> > > +++ b/include/net/tcp.h
> > > @@ -2062,8 +2062,14 @@ extern void tcp_rack_update_reo_wnd(struct soc=
k *sk, struct rate_sample *rs);
> > >   static inline s64 tcp_rto_delta_us(const struct sock *sk)
> > >   {
> > >   	const struct sk_buff *skb =3D tcp_rtx_queue_head(sk);
> > > -	u32 rto =3D inet_csk(sk)->icsk_rto;
> > > -	u64 rto_time_stamp_us =3D skb->skb_mstamp + jiffies_to_usecs(rto);
> > > +	u32 rto;
> > > +	u64 rto_time_stamp_us;
> > > +
> > > +	if (!skb)
> > > +		return -1;
> > > +
> > > +	rto =3D inet_csk(sk)->icsk_rto;
> > > +	rto_time_stamp_us =3D skb->skb_mstamp + jiffies_to_usecs(rto);
> > >   	return rto_time_stamp_us - tcp_sk(sk)->tcp_mstamp;
> > >   }
> > > @@ -2334,8 +2340,6 @@ void tcp_v4_reqsk_destructor(struct request_soc=
k *req);
> > >   struct sock *tcp_v4_cookie_check(struct sock *sk, struct sk_buff *s=
kb);
> > >   void tcp_v4_fill_cb(struct sk_buff *skb, const struct iphdr *iph,
> > >   		    const struct tcphdr *th);
> > > -void tcp_v6_fill_cb(struct sk_buff *skb, const struct ipv6hdr *hdr,
> > > -		    const struct tcphdr *th);
> > >   void tcp_write_err(struct sock *sk);
> > >   bool retransmits_timed_out(struct sock *sk, unsigned int boundary,
> > >   			   unsigned int timeout);
> > > @@ -2345,7 +2349,15 @@ struct request_sock *tcp_cookie_req_alloc(stru=
ct sock *sk,
> > >   					  struct tcp_options_received *tcp_opts,
> > >   					  __u32 cookie, int mss);
> > >   void inet_twsk_free(struct inet_timewait_sock *tw);
> > > +void tcp_cookie_req_init(struct sock *sk, struct sk_buff *skb,
> > > +			 struct request_sock *req,
> > > +			 struct tcp_options_received *tcp_opts, __u32 cookie,
> > > +			 int mss);
> > > +extern const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops;
> > >   #if IS_ENABLED(CONFIG_IPV6)
> > > +extern const struct tcp_request_sock_ops tcp_request_sock_ipv6_ops;
> > > +void tcp_v6_fill_cb(struct sk_buff *skb, const struct ipv6hdr *hdr,
> > > +		    const struct tcphdr *th);
> > >   void inet6_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb=
);
> > >   void tcp_v6_mtu_reduced(struct sock *sk);
> > >   void tcp_v6_reqsk_destructor(struct request_sock *req);
> > > diff --git a/net/core/secure_seq.c b/net/core/secure_seq.c
> > > index 7232274..44226f1 100644
> > > --- a/net/core/secure_seq.c
> > > +++ b/net/core/secure_seq.c
> > > @@ -191,3 +191,73 @@ u64 secure_dccpv6_sequence_number(__be32 *saddr,=
 __be32 *daddr,
> > >   EXPORT_SYMBOL(secure_dccpv6_sequence_number);
> > >   #endif
> > >   #endif
> > > +
> > > +#ifdef CONFIG_MPTCP
> > > +u32 mptcp_v4_get_nonce(__be32 saddr, __be32 daddr, __be16 sport, __b=
e16 dport)
> > > +{
> > > +	u32 hash;
> > > +
> > > +	net_secret_init();
> > > +	hash =3D siphash_3u32((__force u32)saddr, (__force u32)daddr,
> > > +			    (__force u32)sport << 16 | (__force u32)dport,
> > > +			    &net_secret);
> > > +	return seq_scale(hash);
> > > +}
> > > +EXPORT_SYMBOL_GPL(mptcp_v4_get_nonce);
> > > +
> > > +u64 mptcp_v4_get_key(__be32 saddr, __be32 daddr, __be16 sport, __be1=
6 dport)
> > > +{
> > > +	u64 hash;
> > > +
> > > +	net_secret_init();
> > > +	hash =3D siphash_3u32((__force u32)saddr, (__force u32)daddr,
> > > +			    (__force u32)sport << 16 | (__force u32)dport,
> > > +			    &net_secret);
> > > +	return hash;
> > > +}
> > > +EXPORT_SYMBOL_GPL(mptcp_v4_get_key);
> > > +
> > > +#if IS_ENABLED(CONFIG_IPV6)
> > > +
> > > +u32 mptcp_v6_get_nonce(const __be32 *saddr, const __be32 *daddr,
> > > +		       __be16 sport, __be16 dport)
> > > +{
> > > +	const struct {
> > > +		struct in6_addr saddr;
> > > +		struct in6_addr daddr;
> > > +		__be16 sport;
> > > +		__be16 dport;
> > > +	} __aligned(SIPHASH_ALIGNMENT) combined =3D {
> > > +		.saddr =3D *(struct in6_addr *)saddr,
> > > +		.daddr =3D *(struct in6_addr *)daddr,
> > > +		.sport =3D sport,
> > > +		.dport =3D dport
> > > +	};
> > > +	u64 hash;
> > > +
> > > +	net_secret_init();
> > > +	hash =3D siphash(&combined, offsetofend(typeof(combined), dport),
> > > +		       &net_secret);
> > > +	return seq_scale(hash);
> > > +}
> > > +EXPORT_SYMBOL_GPL(mptcp_v6_get_nonce);
> > > +
> > > +u64 mptcp_v6_get_key(const __be32 *saddr, const __be32 *daddr,
> > > +		     __be16 sport, __be16 dport)
> > > +{
> > > +	const struct {
> > > +		struct in6_addr saddr;
> > > +		struct in6_addr daddr;
> > > +		__be16 dport;
> > > +	} __aligned(SIPHASH_ALIGNMENT) combined =3D {
> > > +		.saddr =3D *(struct in6_addr *)saddr,
> > > +		.daddr =3D *(struct in6_addr *)daddr,
> > > +		.dport =3D dport
> > > +	};
> > > +	net_secret_init();
> > > +	return siphash(&combined, offsetofend(typeof(combined), dport),
> > > +		       &net_secret);
> > > +}
> > > +EXPORT_SYMBOL_GPL(mptcp_v6_get_key);
> > > +#endif
> > > +#endif
> > > diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> > > index 5d8ea09..3334e68 100644
> > > --- a/net/ipv4/af_inet.c
> > > +++ b/net/ipv4/af_inet.c
> > > @@ -123,6 +123,10 @@
> > >   #include <trace/events/sock.h>
> > > +#ifdef CONFIG_MPTCP
> > > +#include <net/mptcp.h>
> > > +#endif
> > > +
> > >   /* The inetsw table contains everything that inet_create needs to
> > >    * build a new socket.
> > >    */
> > > @@ -150,6 +154,10 @@ void inet_sock_destruct(struct sock *sk)
> > >   		return;
> > >   	}
> > > +#ifdef CONFIG_MPTCP
> > > +	if (sock_flag(sk, SOCK_MPTCP))
> > > +		mptcp_disable_static_key();
> > > +#endif
> > >   	WARN_ON(atomic_read(&sk->sk_rmem_alloc));
> > >   	WARN_ON(refcount_read(&sk->sk_wmem_alloc));
> > >   	WARN_ON(sk->sk_wmem_queued);
> > > @@ -1915,6 +1923,11 @@ static int __init inet_init(void)
> > >   	ip_init();
> > > +#ifdef CONFIG_MPTCP
> > > +	/* We must initialize MPTCP before TCP. */
> > > +	mptcp_init();
> > > +#endif
> > > +
> > >   	/* Setup TCP slab cache for open requests. */
> > >   	tcp_init();
> > > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connecti=
on_sock.c
> > > index 881ac6d..398eeae 100644
> > > --- a/net/ipv4/inet_connection_sock.c
> > > +++ b/net/ipv4/inet_connection_sock.c
> > > @@ -26,6 +26,9 @@
> > >   #include <net/tcp.h>
> > >   #include <net/sock_reuseport.h>
> > >   #include <net/addrconf.h>
> > > +#ifdef CONFIG_MPTCP
> > > +#include <net/mptcp.h>
> > > +#endif
> > >   #ifdef INET_CSK_DEBUG
> > >   const char inet_csk_timer_bug_msg[] =3D "inet_csk BUG: unknown time=
r value\n";
> > > @@ -944,11 +947,23 @@ EXPORT_SYMBOL(inet_csk_reqsk_queue_add);
> > >   struct sock *inet_csk_complete_hashdance(struct sock *sk, struct so=
ck *child,
> > >   					 struct request_sock *req, bool own_req)
> > >   {
> > > +#ifdef CONFIG_MPTCP
> > > +	if (child->sk_protocol =3D=3D IPPROTO_TCP && mptcp(tcp_sk(child))) {
> > > +		if (is_meta_sk(sk))
> > > +			return(child);
> > > +		child =3D mptcp_meta_sk(child);
> > > +	}
> > > +#endif
> > TCP-specific code like this should not be in a function like
> > inet_csk_complete_hashdance(), which can be called from DCCP as well.
> > =

> > It's best to avoid this.
> If you have an idea please submit a patch.
> The patch is not the final patch by any means. As I have said this is a b=
ase
> to start working from. Any change is welcome.

The problem here is that MPTCP is cheating with subflow establishments
because the child that is created is not added to any real accept-queue.

So, the question becomes: Could we rather do this and add subflows to the
accept-queue? That would make MPTCP fit better into the existing TCP
framework.

> > =

> > >   	if (own_req) {
> > >   		inet_csk_reqsk_queue_drop(sk, req);
> > >   		reqsk_queue_removed(&inet_csk(sk)->icsk_accept_queue, req);
> > > -		if (inet_csk_reqsk_queue_add(sk, req, child))
> > > +		if (inet_csk_reqsk_queue_add(sk, req, child)) {
> > > +#ifdef CONFIG_MPTCP
> > > +			if (mptcp(tcp_sk(child)))
> > > +				child =3D tcp_sk(child)->mpcb->master_sk;
> > > +#endif
> > >   			return child;
> > > +		}
> > >   	}
> > >   	/* Too bad, another child took ownership of the request, undo. */
> > >   	bh_unlock_sock(child);
> > > diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> > > index 008be04..01543fb 100644
> > > --- a/net/ipv4/ip_sockglue.c
> > > +++ b/net/ipv4/ip_sockglue.c
> > > @@ -46,6 +46,9 @@
> > >   #include <linux/errqueue.h>
> > >   #include <linux/uaccess.h>
> > > +#ifdef CONFIG_MPTCP
> > > +#include <net/mptcp.h>
> > > +#endif
> > >   /*
> > >    *	SOL_IP control messages.
> > > @@ -752,6 +755,23 @@ static int do_ip_setsockopt(struct sock *sk, int=
 level,
> > >   			inet->tos =3D val;
> > >   			sk->sk_priority =3D rt_tos2priority(val);
> > >   			sk_dst_reset(sk);
> > > +#ifdef CONFIG_MPTCP
> > > +			/* Update TOS on mptcp subflow */
> > > +			if (is_meta_sk(sk)) {
> > > +				struct sock *sk_it;
> > > +
> > > +				mptcp_for_each_sk(tcp_sk(sk)->mpcb, sk_it) {
> > > +					if (inet_sk(sk_it)->tos !=3D
> > > +					    inet_sk(sk)->tos) {
> > > +						inet_sk(sk_it)->tos =3D
> > > +						    inet_sk(sk)->tos;
> > > +						sk_it->sk_priority =3D
> > > +						    sk->sk_priority;
> > > +						sk_dst_reset(sk_it);
> > > +					}
> > > +				}
> > > +			}
> > > +#endif
> > >   		}
> > >   		break;
> > >   	case IP_TTL:
> > > diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> > > index e0f511e..04e03c1 100644
> > > --- a/net/ipv4/syncookies.c
> > > +++ b/net/ipv4/syncookies.c
> > > @@ -19,6 +19,9 @@
> > >   #include <net/secure_seq.h>
> > >   #include <net/tcp.h>
> > >   #include <net/route.h>
> > > +#ifdef CONFIG_MPTCP
> > > +#include <net/mptcp.h>
> > > +#endif
> > >   static siphash_key_t syncookie_secret[2] __read_mostly;
> > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > index 20a69eb..e7b7a77 100644
> > > --- a/net/ipv4/tcp.c
> > > +++ b/net/ipv4/tcp.c
> > > @@ -282,6 +282,9 @@
> > >   #include <linux/uaccess.h>
> > >   #include <asm/ioctls.h>
> > >   #include <net/busy_poll.h>
> > > +#ifdef CONFIG_MPTCP
> > > +#include <net/mptcp.h>
> > > +#endif
> > >   struct percpu_counter tcp_orphan_count;
> > >   EXPORT_SYMBOL_GPL(tcp_orphan_count);
> > > @@ -850,6 +853,15 @@ ssize_t tcp_splice_read(struct socket *sock, lof=
f_t *ppos,
> > >   	int ret;
> > >   	sock_rps_record_flow(sk);
> > > +
> > > +#ifdef CONFIG_MPTCP
> > > +	if (mptcp(tcp_sk(sk))) {
> > > +		struct sock *sk_it;
> > > +
> > > +		mptcp_for_each_sk(tcp_sk(sk)->mpcb, sk_it)
> > > +			sock_rps_record_flow(sk_it);
> > > +	}
> > > +#endif
> > >   	/*
> > >   	 * We can't seek on a socket input
> > >   	 */
> > > @@ -1892,6 +1904,14 @@ int tcp_recvmsg(struct sock *sk, struct msghdr=
 *msg, size_t len, int nonblock,
> > >   	lock_sock(sk);
> > > +#ifdef CONFIG_MPTCP
> > > +	if (mptcp(tp)) {
> > > +		struct sock *sk_it;
> > > +
> > > +		mptcp_for_each_sk(tp->mpcb, sk_it)
> > > +			sock_rps_record_flow(sk_it);
> > > +	}
> > > +#endif
> > >   	err =3D -ENOTCONN;
> > >   	if (sk->sk_state =3D=3D TCP_LISTEN)
> > >   		goto out;
> > > @@ -2262,6 +2282,12 @@ void tcp_close(struct sock *sk, long timeout)
> > >   	int data_was_unread =3D 0;
> > >   	int state;
> > > +#ifdef CONFIG_MPTCP
> > > +	if (is_meta_sk(sk)) {
> > > +		mptcp_close(sk, timeout);
> > > +		return;
> > > +	}
> > > +#endif
> > I hope we can get rid of these changes when we expose MPTCP as a separa=
te
> > socket-type.
> That is not worth exposing MPTCP as a separate socket type. I prefer shar=
ing
> as much existing code as possible.
> > =

> > >   	lock_sock(sk);
> > >   	sk->sk_shutdown =3D SHUTDOWN_MASK;
> > > @@ -2502,6 +2528,12 @@ int tcp_disconnect(struct sock *sk, int flags)
> > >   	if (!(sk->sk_userlocks & SOCK_BINDADDR_LOCK))
> > >   		inet_reset_saddr(sk);
> > > +#ifdef CONFIG_MPTCP
> > > +	if (is_meta_sk(sk))
> > > +		mptcp_disconnect(sk);
> > > +	else if (tp->inside_tk_table)
> > > +		mptcp_hash_remove_bh(tp);
> > > +#endif
> > >   	sk->sk_shutdown =3D 0;
> > >   	sock_reset_flag(sk, SOCK_DONE);
> > >   	tp->srtt_us =3D 0;
> > > @@ -2870,6 +2902,14 @@ static int do_tcp_setsockopt(struct sock *sk, =
int level,
> > >   		break;
> > >   	case TCP_DEFER_ACCEPT:
> > > +#ifdef CONFIG_MPTCP
> > > +		/* An established MPTCP-connection should not use DEFER on new
> > > +		 * subflows. mptcp(tp) only returns true if the socket is
> > > +		 * established.
> > > +		 */
> > > +		if (mptcp(tp))
> > > +			break;
> > > +#endif
> > >   		/* Translate value in seconds to number of retransmits */
> > >   		icsk->icsk_accept_queue.rskq_defer_accept =3D
> > >   			secs_to_retrans(val, TCP_TIMEOUT_INIT / HZ,
> > > @@ -2964,6 +3004,19 @@ static int do_tcp_setsockopt(struct sock *sk, =
int level,
> > >   		tp->notsent_lowat =3D val;
> > >   		sk->sk_write_space(sk);
> > >   		break;
> > > +#ifdef CONFIG_MPTCP
> > > +	case MPTCP_ENABLED:
> > > +		if (mptcp_init_failed || !sysctl_mptcp_enabled ||
> > > +		    sk->sk_state !=3D TCP_CLOSE) {
> > > +			err =3D -EPERM;
> > > +			break;
> > > +		}
> > > +		if (val)
> > > +			mptcp_enable_sock(sk);
> > > +		else
> > > +			mptcp_disable_sock(sk);
> > > +		break;
> > > +#endif
> > >   	default:
> > >   		err =3D -ENOPROTOOPT;
> > >   		break;
> > > @@ -3383,6 +3436,11 @@ static int do_tcp_getsockopt(struct sock *sk, =
int level,
> > >   	case TCP_SAVE_SYN:
> > >   		val =3D tp->save_syn;
> > >   		break;
> > > +#ifdef CONFIG_MPTCP
> > > +	case MPTCP_ENABLED:
> > > +		val =3D sock_flag(sk, SOCK_MPTCP) ? 1 : 0;
> > > +		break;
> > > +#endif
> > >   	case TCP_SAVED_SYN: {
> > >   		if (get_user(len, optlen))
> > >   			return -EFAULT;
> > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > index 398505e..84ce46a 100644
> > > --- a/net/ipv4/tcp_input.c
> > > +++ b/net/ipv4/tcp_input.c
> > > @@ -78,6 +78,9 @@
> > >   #include <linux/errqueue.h>
> > >   #include <trace/events/tcp.h>
> > >   #include <linux/static_key.h>
> > > +#ifdef CONFIG_MPTCP
> > > +#include <net/mptcp.h>
> > > +#endif
> > >   int sysctl_tcp_max_orphans __read_mostly =3D NR_FILE;
> > > @@ -4038,6 +4041,10 @@ void tcp_fin(struct sock *sk)
> > >   		/* Move to CLOSE_WAIT */
> > >   		tcp_set_state(sk, TCP_CLOSE_WAIT);
> > >   		inet_csk(sk)->icsk_ack.pingpong =3D 1;
> > > +#ifdef CONFIG_MPTCP
> > > +		if (mptcp(tp))
> > > +			mptcp_sub_close_passive(sk);
> > > +#endif
> > >   		break;
> > >   	case TCP_CLOSE_WAIT:
> > > @@ -4059,6 +4066,15 @@ void tcp_fin(struct sock *sk)
> > >   		tcp_set_state(sk, TCP_CLOSING);
> > >   		break;
> > >   	case TCP_FIN_WAIT2:
> > > +#ifdef CONFIG_MPTCP
> > > +		if (mptcp(tp)) {
> > > +			/* The socket will get closed by mptcp_data_ready.
> > > +			 * We first have to process all data-sequences.
> > > +			 */
> > > +			tp->close_it =3D 1;
> > > +			break;
> > > +		}
> > > +#endif
> > >   		/* Received a FIN -- send ACK and enter TIME_WAIT. */
> > >   		tcp_send_ack(sk);
> > >   		tcp_time_wait(sk, TCP_TIME_WAIT, 0);
> > > @@ -4083,6 +4099,11 @@ void tcp_fin(struct sock *sk)
> > >   	if (!sock_flag(sk, SOCK_DEAD)) {
> > >   		sk->sk_state_change(sk);
> > > +#ifdef CONFIG_MPTCP
> > > +		/* Don't wake up MPTCP-subflows */
> > > +		if (mptcp(tp))
> > > +			return;
> > > +#endif
> > >   		/* Do not send POLL_HUP for half duplex close. */
> > >   		if (sk->sk_shutdown =3D=3D SHUTDOWN_MASK ||
> > >   		    sk->sk_state =3D=3D TCP_CLOSE)
> > > @@ -6154,6 +6175,10 @@ static void tcp_openreq_init(struct request_so=
ck *req,
> > >   #if IS_ENABLED(CONFIG_SMC)
> > >   	ireq->smc_ok =3D rx_opt->smc_ok;
> > >   #endif
> > > +#ifdef CONFIG_MPTCP
> > > +	ireq->saw_mpc =3D 0;
> > > +	ireq->mptcp_rqsk =3D 0;
> > > +#endif
> > >   }
> > >   struct request_sock *inet_reqsk_alloc(const struct request_sock_ops=
 *ops,
> > > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > > index 95d4c1f..b7f67d1 100644
> > > --- a/net/ipv4/tcp_ipv4.c
> > > +++ b/net/ipv4/tcp_ipv4.c
> > > @@ -87,6 +87,10 @@
> > >   #include <trace/events/tcp.h>
> > > +#ifdef CONFIG_MPTCP
> > > +#include <net/mptcp.h>
> > > +#endif
> > > +
> > >   #ifdef CONFIG_TCP_MD5SIG
> > >   static int tcp_v4_md5_hash_hdr(char *md5_hash, const struct tcp_md5=
sig_key *key,
> > >   			       __be32 daddr, __be32 saddr, const struct tcphdr *th);
> > > @@ -375,6 +379,7 @@ void tcp_v4_err(struct sk_buff *icmp_skb, u32 inf=
o)
> > >   	const int type =3D icmp_hdr(icmp_skb)->type;
> > >   	const int code =3D icmp_hdr(icmp_skb)->code;
> > >   	struct sock *sk;
> > > +	struct sock *meta_sk;
> > >   	struct sk_buff *skb;
> > >   	struct request_sock *fastopen;
> > >   	u32 seq, snd_una;
> > > @@ -403,13 +408,20 @@ void tcp_v4_err(struct sk_buff *icmp_skb, u32 i=
nfo)
> > >   				   (code =3D=3D ICMP_NET_UNREACH ||
> > >   				    code =3D=3D ICMP_HOST_UNREACH)));
> > > -	bh_lock_sock(sk);
> > > +	tp =3D tcp_sk(sk);
> > > +#ifdef CONFIG_MPTCP
> > > +	if (mptcp(tp))
> > > +		meta_sk =3D mptcp_meta_sk(sk);
> > > +	else
> > > +#endif
> > > +		meta_sk =3D sk;
> > > +	bh_lock_sock(meta_sk);
> > I see that we are taking the lock here on the meta-sk. This will make
> > RCU-debugging print lots of warnings, because we access the subflow's s=
ocket
> > without holding the socket's lock.
> > =

> > Changing this is something I am working towards (taking subflow-locks
> > instead of meta-locks).
> > However, it requires significant architectural changes and is not somet=
hing
> > that can easily be added afterwards.
> I have not looked at this level yet. I do not want any significant
> architectural changes just to disable RCU warning.

But it is an issue that must be taken care of.
Even if we don't have code for it yet, we need at least a plan on how to
address it and see how the solution would affect the overall design of
MPTCP.


Christoph


> Let me look at this at a
> later time. I am working with Paul McKinney on an RCU issue, I ask him as
> well.
> =

> Shoaib
> =

> > =

> > =

> > =

> > Christoph
> > =

> > >   	/* If too many ICMPs get dropped on busy
> > >   	 * servers this needs to be solved differently.
> > >   	 * We do take care of PMTU discovery (RFC1191) special case :
> > >   	 * we can receive locally generated ICMP messages while socket is =
held.
> > >   	 */
> > > -	if (sock_owned_by_user(sk)) {
> > > +	if (sock_owned_by_user(meta_sk)) {
> > >   		if (!(type =3D=3D ICMP_DEST_UNREACH && code =3D=3D ICMP_FRAG_NEED=
ED))
> > >   			__NET_INC_STATS(net, LINUX_MIB_LOCKDROPPEDICMPS);
> > >   	}
> > > @@ -456,11 +468,15 @@ void tcp_v4_err(struct sk_buff *icmp_skb, u32 i=
nfo)
> > >   				goto out;
> > >   			tp->mtu_info =3D info;
> > > -			if (!sock_owned_by_user(sk)) {
> > > +			if (!sock_owned_by_user(meta_sk)) {
> > >   				tcp_v4_mtu_reduced(sk);
> > >   			} else {
> > >   				if (!test_and_set_bit(TCP_MTU_REDUCED_DEFERRED, &sk->sk_tsq_fla=
gs))
> > >   					sock_hold(sk);
> > > +#ifdef CONFIG_MPTCP
> > > +				if (mptcp(tp))
> > > +					mptcp_tsq_flags(sk);
> > > +#endif
> > >   			}
> > >   			goto out;
> > >   		}
> > > @@ -474,7 +490,7 @@ void tcp_v4_err(struct sk_buff *icmp_skb, u32 inf=
o)
> > >   		    !icsk->icsk_backoff || fastopen)
> > >   			break;
> > > -		if (sock_owned_by_user(sk))
> > > +		if (sock_owned_by_user(meta_sk))
> > >   			break;
> > >   		icsk->icsk_backoff--;
> > > @@ -516,7 +532,7 @@ void tcp_v4_err(struct sk_buff *icmp_skb, u32 inf=
o)
> > >   		if (fastopen && !fastopen->sk)
> > >   			break;
> > > -		if (!sock_owned_by_user(sk)) {
> > > +		if (!sock_owned_by_user(meta_sk)) {
> > >   			sk->sk_err =3D err;
> > >   			sk->sk_error_report(sk);
> > > @@ -545,7 +561,7 @@ void tcp_v4_err(struct sk_buff *icmp_skb, u32 inf=
o)
> > >   	 */
> > >   	inet =3D inet_sk(sk);
> > > -	if (!sock_owned_by_user(sk) && inet->recverr) {
> > > +	if (!sock_owned_by_user(meta_sk) && inet->recverr) {
> > >   		sk->sk_err =3D err;
> > >   		sk->sk_error_report(sk);
> > >   	} else	{ /* Only an error on timeout */
> > > @@ -553,7 +569,7 @@ void tcp_v4_err(struct sk_buff *icmp_skb, u32 inf=
o)
> > >   	}
> > >   out:
> > > -	bh_unlock_sock(sk);
> > > +	bh_unlock_sock(meta_sk);
> > >   	sock_put(sk);
> > >   }
> > > @@ -747,10 +763,17 @@ static void tcp_v4_send_ack(const struct sock *=
sk,
> > >   #ifdef CONFIG_TCP_MD5SIG
> > >   			   + (TCPOLEN_MD5SIG_ALIGNED >> 2)
> > >   #endif
> > > +#ifdef CONFIG_MPTCP
> > > +			   + ((MPTCP_SUB_LEN_DSS >> 2) +
> > > +			      (MPTCP_SUB_LEN_ACK >> 2))
> > > +#endif
> > >   			];
> > >   	} rep;
> > >   	struct net *net =3D sock_net(sk);
> > >   	struct ip_reply_arg arg;
> > > +#if defined(CONFIG_MPTCP) || defined(CONFIG_TCP_MD5SIG)
> > > +	int offset =3D (tsecr) ? 3 : 0;
> > > +#endif
> > >   	memset(&rep.th, 0, sizeof(struct tcphdr));
> > >   	memset(&arg, 0, sizeof(arg));
> > > @@ -777,8 +800,6 @@ static void tcp_v4_send_ack(const struct sock *sk,
> > >   #ifdef CONFIG_TCP_MD5SIG
> > >   	if (key) {
> > > -		int offset =3D (tsecr) ? 3 : 0;
> > > -
> > >   		rep.opt[offset++] =3D htonl((TCPOPT_NOP << 24) |
> > >   					  (TCPOPT_NOP << 16) |
> > >   					  (TCPOPT_MD5SIG << 8) |
> > > @@ -791,6 +812,12 @@ static void tcp_v4_send_ack(const struct sock *s=
k,
> > >   				    ip_hdr(skb)->daddr, &rep.th);
> > >   	}
> > >   #endif
> > > +#ifdef CONFIG_MPTCP
> > > +	mptcp_v4_add_ack_opts(sk, skb, &offset, &arg, rep.opt);
> > > +	rep.th.doff =3D (arg.iov[0].iov_len >> 2);
> > > +#endif
> > > +	WARN_ON(rep.th.doff > (MAX_TCP_OPTION_SPACE >> 2) ||
> > > +		rep.th.doff > (sizeof(rep.opt) >> 2));
> > >   	arg.flags =3D reply_flags;
> > >   	arg.csum =3D csum_tcpudp_nofold(ip_hdr(skb)->daddr,
> > >   				      ip_hdr(skb)->saddr, /* XXX */
> > > @@ -1294,7 +1321,7 @@ struct request_sock_ops tcp_request_sock_ops __=
read_mostly =3D {
> > >   	.syn_ack_timeout =3D	tcp_syn_ack_timeout,
> > >   };
> > > -static const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops =
=3D {
> > > +const struct tcp_request_sock_ops tcp_request_sock_ipv4_ops =3D {
> > >   	.mss_clamp	=3D	TCP_MSS_DEFAULT,
> > >   #ifdef CONFIG_TCP_MD5SIG
> > >   	.req_md5_lookup	=3D	tcp_v4_md5_lookup,
> > > @@ -1684,7 +1711,20 @@ int tcp_v4_rcv(struct sk_buff *skb)
> > >   			reqsk_put(req);
> > >   			goto discard_it;
> > >   		}
> > > +
> > > +		/* In case of MPTCP join, the meta socket acts as the listener.
> > > +		 * So the state of the listener can be other than TCP_LISTEN
> > > +		 */
> > >   		if (unlikely(sk->sk_state !=3D TCP_LISTEN)) {
> > > +#ifdef CONFIG_MPTCP
> > > +			if (inet_rsk(req)->saw_mpc) {
> > > +				/* In case of MPTCP join, the meta socket acts
> > > +				 * as the listener. So the state of the listener
> > > +				 * can be other than TCP_LISTEN
> > > +				 */
> > > +				return mptcp_join_ack(req, skb);
> > > +			}
> > > +#endif
> > >   			inet_csk_reqsk_queue_drop_and_put(sk, req);
> > >   			goto lookup;
> > >   		}
> > > @@ -1918,6 +1958,12 @@ void tcp_v4_destroy_sock(struct sock *sk)
> > >   	tcp_cleanup_congestion_control(sk);
> > > +#ifdef CONFIG_MPTCP
> > > +	if (mptcp(tp))
> > > +		mptcp_destroy_sock(sk);
> > > +	if (tp->inside_tk_table)
> > > +		mptcp_hash_remove(tp);
> > > +#endif
> > >   	tcp_cleanup_ulp(sk);
> > >   	/* Cleanup up the write buffer. */
> > > diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> > > index e7e3643..c8712a9 100644
> > > --- a/net/ipv4/tcp_minisocks.c
> > > +++ b/net/ipv4/tcp_minisocks.c
> > > @@ -28,6 +28,9 @@
> > >   #include <net/inet_common.h>
> > >   #include <net/xfrm.h>
> > >   #include <net/busy_poll.h>
> > > +#ifdef CONFIG_MPTCP
> > > +#include <net/mptcp.h>
> > > +#endif
> > >   static bool tcp_in_window(u32 seq, u32 end_seq, u32 s_win, u32 e_wi=
n)
> > >   {
> > > @@ -94,9 +97,17 @@ tcp_timewait_state_process(struct inet_timewait_so=
ck *tw, struct sk_buff *skb,
> > >   	struct tcp_options_received tmp_opt;
> > >   	struct tcp_timewait_sock *tcptw =3D tcp_twsk((struct sock *)tw);
> > >   	bool paws_reject =3D false;
> > > +#ifdef CONFIG_MPTCP
> > > +	struct mptcp_options_received mopt;
> > > +#endif
> > >   	tmp_opt.saw_tstamp =3D 0;
> > > -	if (th->doff > (sizeof(*th) >> 2) && tcptw->tw_ts_recent_stamp) {
> > > +	if (th->doff > (sizeof(*th) >> 2) &&
> > > +#ifdef CONFIG_MPTCP
> > > +	    (tcptw->tw_ts_recent_stamp || tcptw->mptcp_tw)) {
> > > +#else
> > > +	     tcptw->tw_ts_recent_stamp) {
> > > +#endif
> > >   		tcp_parse_options(twsk_net(tw), skb, &tmp_opt, 0, NULL);
> > >   		if (tmp_opt.saw_tstamp) {
> > > @@ -106,6 +117,16 @@ tcp_timewait_state_process(struct inet_timewait_=
sock *tw, struct sk_buff *skb,
> > >   			tmp_opt.ts_recent_stamp	=3D tcptw->tw_ts_recent_stamp;
> > >   			paws_reject =3D tcp_paws_reject(&tmp_opt, th->rst);
> > >   		}
> > > +
> > > +#ifdef CONFIG_MPTCP
> > > +		if (unlikely(tcptw->mptcp_tw)) {
> > > +			mptcp_init_mp_opt(&mopt);
> > > +			tcp_parse_mptcp_options(skb, &mopt);
> > > +			if (mopt.mp_fclose &&
> > > +			    mopt.mptcp_sender_key =3D=3D tcptw->mptcp_tw->loc_key)
> > > +				return TCP_TW_RST;
> > > +		}
> > > +#endif
> > >   	}
> > >   	if (tw->tw_substate =3D=3D TCP_FIN_WAIT2) {
> > > @@ -129,6 +150,13 @@ tcp_timewait_state_process(struct inet_timewait_=
sock *tw, struct sk_buff *skb,
> > >   		if (!th->ack ||
> > >   		    !after(TCP_SKB_CB(skb)->end_seq, tcptw->tw_rcv_nxt) ||
> > >   		    TCP_SKB_CB(skb)->end_seq =3D=3D TCP_SKB_CB(skb)->seq) {
> > > +#ifdef CONFIG_MPTCP
> > > +			if (tcptw->mptcp_tw && tcptw->mptcp_tw->meta_tw &&
> > > +			    mptcp_is_data_fin(skb) &&
> > > +			    TCP_SKB_CB(skb)->seq =3D=3D tcptw->tw_rcv_nxt &&
> > > +			    mopt.data_seq + 1 =3D=3D (u32)tcptw->mptcp_tw->rcv_nxt)
> > > +				return TCP_TW_ACK;
> > > +#endif
> > >   			inet_twsk_put(tw);
> > >   			return TCP_TW_SUCCESS;
> > >   		}
> > > @@ -272,6 +300,17 @@ void tcp_time_wait(struct sock *sk, int state, i=
nt timeo)
> > >   		tcptw->tw_ts_offset	=3D tp->tsoffset;
> > >   		tcptw->tw_last_oow_ack_time =3D 0;
> > > +#ifdef CONFIG_MPTCP
> > > +		if (mptcp(tp)) {
> > > +			if (mptcp_init_tw_sock(sk, tcptw)) {
> > > +				inet_twsk_free(tw);
> > > +				goto exit;
> > > +			}
> > > +		} else {
> > > +			tcptw->mptcp_tw =3D NULL;
> > > +		}
> > > +#endif
> > > +
> > >   #if IS_ENABLED(CONFIG_IPV6)
> > >   		if (tw->tw_family =3D=3D PF_INET6) {
> > >   			struct ipv6_pinfo *np =3D inet6_sk(sk);
> > > @@ -329,15 +368,23 @@ void tcp_time_wait(struct sock *sk, int state, =
int timeo)
> > >   		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPTIMEWAITOVERFLOW);
> > >   	}
> > > +#ifdef CONFIG_MPTCP
> > > +exit:
> > > +#endif
> > >   	tcp_update_metrics(sk);
> > >   	tcp_done(sk);
> > >   }
> > >   void tcp_twsk_destructor(struct sock *sk)
> > >   {
> > > -#ifdef CONFIG_TCP_MD5SIG
> > >   	struct tcp_timewait_sock *twsk =3D tcp_twsk(sk);
> > > +#ifdef CONFIG_MPTCP
> > > +	if (twsk->mptcp_tw)
> > > +		mptcp_twsk_destructor(twsk);
> > > +#endif
> > > +#ifdef CONFIG_TCP_MD5SIG
> > > +
> > >   	if (twsk->tw_md5_key)
> > >   		kfree_rcu(twsk->tw_md5_key, rcu);
> > >   #endif
> > > @@ -851,6 +898,11 @@ int tcp_child_process(struct sock *parent, struc=
t sock *child,
> > >   	bh_unlock_sock(child);
> > >   	sock_put(child);
> > > +
> > > +#ifdef CONFIG_MPTCP
> > > +	if (mptcp(tcp_sk(child)))
> > > +		bh_unlock_sock(mptcp_meta_sk(child));
> > > +#endif
> > >   	return ret;
> > >   }
> > >   EXPORT_SYMBOL(tcp_child_process);
> > > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > > index 72b494a..dc638f8 100644
> > > --- a/net/ipv4/tcp_output.c
> > > +++ b/net/ipv4/tcp_output.c
> > > @@ -44,6 +44,9 @@
> > >   #include <linux/static_key.h>
> > >   #include <trace/events/tcp.h>
> > > +#ifdef CONFIG_MPTCP
> > > +#include <net/mptcp.h>
> > > +#endif
> > >   /* Account for new data that has been sent to the network. */
> > >   void tcp_event_new_data_sent(struct sock *sk, struct sk_buff *skb)
> > > @@ -381,6 +384,7 @@ void tcp_init_nondata_skb(struct sk_buff *skb, u3=
2 seq, u8 flags)
> > >   	TCP_SKB_CB(skb)->tcp_flags =3D flags;
> > >   	TCP_SKB_CB(skb)->sacked =3D 0;
> > > +	TCP_SKB_CB(skb)->mptcp_flags =3D 0;
> > >   	tcp_skb_pcount_set(skb, 1);
> > > @@ -802,7 +806,7 @@ static void tcp_tasklet_func(unsigned long data)
> > >   	unsigned long flags;
> > >   	struct list_head *q, *n;
> > >   	struct tcp_sock *tp;
> > > -	struct sock *sk;
> > > +	struct sock *sk, *meta_sk;
> > >   	local_irq_save(flags);
> > >   	list_splice_init(&tsq->head, &list);
> > > @@ -813,17 +817,22 @@ static void tcp_tasklet_func(unsigned long data)
> > >   		list_del(&tp->tsq_node);
> > >   		sk =3D (struct sock *)tp;
> > > +#ifndef CONFIG_MPTCP
> > > +		meta_sk =3D sk;
> > > +#else
> > > +		meta_sk =3D mptcp(tcp_sk(sk)) ? mptcp_meta_sk(sk) : sk;
> > > +#endif
> > >   		smp_mb__before_atomic();
> > >   		clear_bit(TSQ_QUEUED, &sk->sk_tsq_flags);
> > > -		if (!sk->sk_lock.owned &&
> > > +		if (!meta_sk->sk_lock.owned &&
> > >   		    test_bit(TCP_TSQ_DEFERRED, &sk->sk_tsq_flags)) {
> > > -			bh_lock_sock(sk);
> > > -			if (!sock_owned_by_user(sk)) {
> > > +			bh_lock_sock(meta_sk);
> > > +			if (!sock_owned_by_user(meta_sk)) {
> > >   				clear_bit(TCP_TSQ_DEFERRED, &sk->sk_tsq_flags);
> > >   				tcp_tsq_handler(sk);
> > >   			}
> > > -			bh_unlock_sock(sk);
> > > +			bh_unlock_sock(meta_sk);
> > >   		}
> > >   		sk_free(sk);
> > > @@ -879,6 +888,10 @@ void tcp_release_cb(struct sock *sk)
> > >   		inet_csk(sk)->icsk_af_ops->mtu_reduced(sk);
> > >   		__sock_put(sk);
> > >   	}
> > > +#ifdef CONFIG_MPTCP
> > > +	if (flags & (1UL << MPTCP_SUB_DEFERRED))
> > > +		mptcp_tsq_sub_deferred(sk);
> > > +#endif
> > >   }
> > >   EXPORT_SYMBOL(tcp_release_cb);
> > > @@ -1846,6 +1859,10 @@ inline bool tcp_nagle_test(const struct tcp_so=
ck *tp, const struct sk_buff *skb,
> > >   	/* Don't use the nagle rule for urgent data (or for the final FIN)=
. */
> > >   	if (tcp_urg_mode(tp) || (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN))
> > >   		return true;
> > > +#ifdef CONFIG_MPTCP
> > > +	if (mptcp_is_data_fin(skb))
> > > +		return true;
> > > +#endif
> > >   	if (!tcp_nagle_check(skb->len < cur_mss, tp, nonagle))
> > >   		return true;
> > > @@ -1941,6 +1958,10 @@ static bool tcp_tso_should_defer(struct sock *=
sk, struct sk_buff *skb,
> > >   	if (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN)
> > >   		goto send_now;
> > > +#ifdef CONFIG_MPTCP
> > > +	if (mptcp_is_data_fin(skb))
> > > +		goto send_now;
> > > +#endif
> > >   	if (icsk->icsk_ca_state >=3D TCP_CA_Recovery)
> > >   		goto send_now;
> > > diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> > > index dbf284d..e315ad1 100644
> > > --- a/net/ipv4/tcp_timer.c
> > > +++ b/net/ipv4/tcp_timer.c
> > > @@ -22,6 +22,10 @@
> > >   #include <linux/gfp.h>
> > >   #include <net/tcp.h>
> > > +#ifdef CONFIG_MPTCP
> > > +#include <net/mptcp.h>
> > > +#endif
> > > +
> > >   /**
> > >    *  tcp_write_err() - close socket and save error info
> > >    *  @sk:  The socket the error has appeared on.
> > > @@ -295,8 +299,13 @@ static void tcp_delack_timer(struct timer_list *=
t)
> > >   	struct inet_connection_sock *icsk =3D
> > >   			from_timer(icsk, t, icsk_delack_timer);
> > >   	struct sock *sk =3D &icsk->icsk_inet.sk;
> > > +#ifndef CONFIG_MPTCP
> > > +	struct sock *meta_sk =3D sk;
> > > +#else
> > > +	struct sock *meta_sk =3D mptcp(tcp_sk(sk)) ? mptcp_meta_sk(sk) : sk;
> > > +#endif
> > > -	bh_lock_sock(sk);
> > > +	bh_lock_sock(meta_sk);
> > >   	if (!sock_owned_by_user(sk)) {
> > >   		tcp_delack_timer_handler(sk);
> > >   	} else {
> > > @@ -305,8 +314,12 @@ static void tcp_delack_timer(struct timer_list *=
t)
> > >   		/* deleguate our work to tcp_release_cb() */
> > >   		if (!test_and_set_bit(TCP_DELACK_TIMER_DEFERRED, &sk->sk_tsq_flag=
s))
> > >   			sock_hold(sk);
> > > +#ifdef CONFIG_MPTCP
> > > +			if (mptcp(tcp_sk(sk)))
> > > +				mptcp_tsq_flags(sk);
> > > +#endif
> > >   	}
> > > -	bh_unlock_sock(sk);
> > > +	bh_unlock_sock(meta_sk);
> > >   	sock_put(sk);
> > >   }
> > > @@ -586,15 +599,25 @@ static void tcp_write_timer(struct timer_list *=
t)
> > >   			from_timer(icsk, t, icsk_retransmit_timer);
> > >   	struct sock *sk =3D &icsk->icsk_inet.sk;
> > > -	bh_lock_sock(sk);
> > > -	if (!sock_owned_by_user(sk)) {
> > > +#ifndef CONFIG_MPTCP
> > > +	struct sock *meta_sk =3D sk;
> > > +#else
> > > +	struct sock *meta_sk =3D mptcp(tcp_sk(sk)) ? mptcp_meta_sk(sk) : sk;
> > > +#endif
> > > +
> > > +	bh_lock_sock(meta_sk);
> > > +	if (!sock_owned_by_user(meta_sk)) {
> > >   		tcp_write_timer_handler(sk);
> > >   	} else {
> > >   		/* delegate our work to tcp_release_cb() */
> > >   		if (!test_and_set_bit(TCP_WRITE_TIMER_DEFERRED, &sk->sk_tsq_flags=
))
> > >   			sock_hold(sk);
> > > +#ifdef CONFIG_MPTCP
> > > +		if (mptcp(tcp_sk(sk)))
> > > +			mptcp_tsq_flags(sk);
> > > +#endif
> > >   	}
> > > -	bh_unlock_sock(sk);
> > > +	bh_unlock_sock(meta_sk);
> > >   	sock_put(sk);
> > >   }
> > > @@ -625,10 +648,15 @@ static void tcp_keepalive_timer (struct timer_l=
ist *t)
> > >   	struct inet_connection_sock *icsk =3D inet_csk(sk);
> > >   	struct tcp_sock *tp =3D tcp_sk(sk);
> > >   	u32 elapsed;
> > > +#ifndef CONFIG_MPTCP
> > > +	struct sock *meta_sk =3D sk;
> > > +#else
> > > +	struct sock *meta_sk =3D mptcp(tcp_sk(sk)) ? mptcp_meta_sk(sk) : sk;
> > > +#endif
> > >   	/* Only process if socket is not in use. */
> > > -	bh_lock_sock(sk);
> > > -	if (sock_owned_by_user(sk)) {
> > > +	bh_lock_sock(meta_sk);
> > > +	if (sock_owned_by_user(meta_sk)) {
> > >   		/* Try again later. */
> > >   		inet_csk_reset_keepalive_timer (sk, HZ/20);
> > >   		goto out;
> > > @@ -702,7 +730,7 @@ static void tcp_keepalive_timer (struct timer_lis=
t *t)
> > >   	tcp_done(sk);
> > >   out:
> > > -	bh_unlock_sock(sk);
> > > +	bh_unlock_sock(meta_sk);
> > >   	sock_put(sk);
> > >   }
> > > diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
> > > index d78d41f..c5956c2 100644
> > > --- a/net/ipv6/ipv6_sockglue.c
> > > +++ b/net/ipv6/ipv6_sockglue.c
> > > @@ -53,6 +53,10 @@
> > >   #include <net/xfrm.h>
> > >   #include <net/compat.h>
> > >   #include <net/seg6.h>
> > > +#ifdef CONFIG_MPTCP
> > > +#include <net/mptcp.h>
> > > +#include <net/mptcp_v4.h>
> > > +#endif
> > >   #include <linux/uaccess.h>
> > > @@ -216,6 +220,12 @@ static int do_ipv6_setsockopt(struct sock *sk, i=
nt level, int optname,
> > >   				sock_prot_inuse_add(net, &tcp_prot, 1);
> > >   				local_bh_enable();
> > >   				sk->sk_prot =3D &tcp_prot;
> > > +#ifdef CONFIG_MPTCP
> > > +				if (sock_flag(sk, SOCK_MPTCP))
> > > +					icsk->icsk_af_ops =3D &mptcp_v4_specific;
> > > +				else
> > > +#endif
> > > +					icsk->icsk_af_ops =3D &ipv4_specific;
> > >   				icsk->icsk_af_ops =3D &ipv4_specific;
> > >   				sk->sk_socket->ops =3D &inet_stream_ops;
> > >   				sk->sk_family =3D PF_INET;
> > > @@ -242,6 +252,10 @@ static int do_ipv6_setsockopt(struct sock *sk, i=
nt level, int optname,
> > >   			pktopt =3D xchg(&np->pktoptions, NULL);
> > >   			kfree_skb(pktopt);
> > > +#ifdef CONFIG_MPTCP
> > > +			if (is_meta_sk(sk))
> > > +				sk->sk_destruct =3D mptcp_sock_destruct;
> > > +#endif
> > >   			/*
> > >   			 * ... and add it to the refcnt debug socks count
> > >   			 * in the new family. -acme
> > > diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> > > index c226cf6..48c86b8 100644
> > > --- a/net/ipv6/tcp_ipv6.c
> > > +++ b/net/ipv6/tcp_ipv6.c
> > > @@ -71,6 +71,11 @@
> > >   #include <trace/events/tcp.h>
> > > +#ifdef CONFIG_MPTCP
> > > +#include <net/mptcp.h>
> > > +#include <net/mptcp_v6.h>
> > > +#endif
> > > +
> > >   #ifdef CONFIG_TCP_MD5SIG
> > >   static const struct tcp_sock_af_ops tcp_sock_ipv6_specific;
> > >   static const struct tcp_sock_af_ops tcp_sock_ipv6_mapped_specific;
> > > @@ -206,7 +211,12 @@ static int tcp_v6_connect(struct sock *sk, struc=
t sockaddr *uaddr,
> > >   		sin.sin_port =3D usin->sin6_port;
> > >   		sin.sin_addr.s_addr =3D usin->sin6_addr.s6_addr32[3];
> > > -		icsk->icsk_af_ops =3D &ipv6_mapped;
> > > +#ifdef CONFIG_MPTCP
> > > +		if (sock_flag(sk, SOCK_MPTCP))
> > > +			icsk->icsk_af_ops =3D &mptcp_v6_mapped;
> > > +		else
> > > +#endif
> > > +			icsk->icsk_af_ops =3D &ipv6_mapped;
> > >   		sk->sk_backlog_rcv =3D tcp_v4_do_rcv;
> > >   #ifdef CONFIG_TCP_MD5SIG
> > >   		tp->af_specific =3D &tcp_sock_ipv6_mapped_specific;
> > > @@ -216,7 +226,12 @@ static int tcp_v6_connect(struct sock *sk, struc=
t sockaddr *uaddr,
> > >   		if (err) {
> > >   			icsk->icsk_ext_hdr_len =3D exthdrlen;
> > > -			icsk->icsk_af_ops =3D &ipv6_specific;
> > > +#ifdef CONFIG_MPTCP
> > > +			if (sock_flag(sk, SOCK_MPTCP))
> > > +				icsk->icsk_af_ops =3D &mptcp_v6_specific;
> > > +			else
> > > +#endif
> > > +				icsk->icsk_af_ops =3D &ipv6_specific;
> > >   			sk->sk_backlog_rcv =3D tcp_v6_do_rcv;
> > >   #ifdef CONFIG_TCP_MD5SIG
> > >   			tp->af_specific =3D &tcp_sock_ipv6_specific;
> > > @@ -337,6 +352,7 @@ static void tcp_v6_err(struct sk_buff *skb, struc=
t inet6_skb_parm *opt,
> > >   	struct tcp_sock *tp;
> > >   	__u32 seq, snd_una;
> > >   	struct sock *sk;
> > > +	struct sock *meta_sk;
> > >   	bool fatal;
> > >   	int err;
> > > @@ -359,9 +375,15 @@ static void tcp_v6_err(struct sk_buff *skb, stru=
ct inet6_skb_parm *opt,
> > >   	fatal =3D icmpv6_err_convert(type, code, &err);
> > >   	if (sk->sk_state =3D=3D TCP_NEW_SYN_RECV)
> > >   		return tcp_req_err(sk, seq, fatal);
> > > -
> > > -	bh_lock_sock(sk);
> > > -	if (sock_owned_by_user(sk) && type !=3D ICMPV6_PKT_TOOBIG)
> > > +#ifdef CONFIG_MPTCP
> > > +	tp =3D tcp_sk(sk);
> > > +	if (mptcp(tp))
> > > +		meta_sk =3D mptcp_meta_sk(sk);
> > > +	else
> > > +#endif
> > > +		meta_sk =3D sk;
> > > +	bh_lock_sock(meta_sk);
> > > +	if (sock_owned_by_user(meta_sk) && type !=3D ICMPV6_PKT_TOOBIG)
> > >   		__NET_INC_STATS(net, LINUX_MIB_LOCKDROPPEDICMPS);
> > >   	if (sk->sk_state =3D=3D TCP_CLOSE)
> > > @@ -385,7 +407,7 @@ static void tcp_v6_err(struct sk_buff *skb, struc=
t inet6_skb_parm *opt,
> > >   	np =3D inet6_sk(sk);
> > >   	if (type =3D=3D NDISC_REDIRECT) {
> > > -		if (!sock_owned_by_user(sk)) {
> > > +		if (!sock_owned_by_user(meta_sk)) {
> > >   			struct dst_entry *dst =3D __sk_dst_check(sk, np->dst_cookie);
> > >   			if (dst)
> > > @@ -406,11 +428,17 @@ static void tcp_v6_err(struct sk_buff *skb, str=
uct inet6_skb_parm *opt,
> > >   			goto out;
> > >   		tp->mtu_info =3D ntohl(info);
> > > -		if (!sock_owned_by_user(sk))
> > > +		if (!sock_owned_by_user(meta_sk)) {
> > >   			tcp_v6_mtu_reduced(sk);
> > > -		else if (!test_and_set_bit(TCP_MTU_REDUCED_DEFERRED,
> > > -					   &sk->sk_tsq_flags))
> > > -			sock_hold(sk);
> > > +		} else {
> > > +			if (!test_and_set_bit(TCP_MTU_REDUCED_DEFERRED,
> > > +					      &sk->sk_tsq_flags))
> > > +				sock_hold(sk);
> > > +#ifdef CONFIG_MPTCP
> > > +			if (mptcp(tp))
> > > +				mptcp_tsq_flags(sk);
> > > +#endif
> > > +		}
> > >   		goto out;
> > >   	}
> > > @@ -425,7 +453,7 @@ static void tcp_v6_err(struct sk_buff *skb, struc=
t inet6_skb_parm *opt,
> > >   		if (fastopen && !fastopen->sk)
> > >   			break;
> > > -		if (!sock_owned_by_user(sk)) {
> > > +		if (!sock_owned_by_user(meta_sk)) {
> > >   			sk->sk_err =3D err;
> > >   			sk->sk_error_report(sk);		/* Wake people up to see the error (se=
e connect in sock.c) */
> > > @@ -435,14 +463,15 @@ static void tcp_v6_err(struct sk_buff *skb, str=
uct inet6_skb_parm *opt,
> > >   		goto out;
> > >   	}
> > > -	if (!sock_owned_by_user(sk) && np->recverr) {
> > > +	if (!sock_owned_by_user(meta_sk) && np->recverr) {
> > >   		sk->sk_err =3D err;
> > >   		sk->sk_error_report(sk);
> > > -	} else
> > > +	} else {
> > >   		sk->sk_err_soft =3D err;
> > > +	}
> > >   out:
> > > -	bh_unlock_sock(sk);
> > > +	bh_unlock_sock(meta_sk);
> > >   	sock_put(sk);
> > >   }
> > > @@ -749,7 +778,7 @@ struct request_sock_ops tcp6_request_sock_ops __r=
ead_mostly =3D {
> > >   	.syn_ack_timeout =3D	tcp_syn_ack_timeout,
> > >   };
> > > -static const struct tcp_request_sock_ops tcp_request_sock_ipv6_ops =
=3D {
> > > +const struct tcp_request_sock_ops tcp_request_sock_ipv6_ops =3D {
> > >   	.mss_clamp	=3D	IPV6_MIN_MTU - sizeof(struct tcphdr) -
> > >   				sizeof(struct ipv6hdr),
> > >   #ifdef CONFIG_TCP_MD5SIG
> > > @@ -787,6 +816,10 @@ static void tcp_v6_send_response(const struct so=
ck *sk, struct sk_buff *skb, u32
> > >   	if (key)
> > >   		tot_len +=3D TCPOLEN_MD5SIG_ALIGNED;
> > >   #endif
> > > +#ifdef CONFIG_MPTCP
> > > +	/* We always allocate space when MPTCP is enabled */
> > > +	tot_len +=3D MPTCP_SUB_LEN_DSS + MPTCP_SUB_LEN_ACK;
> > > +#endif
> > >   	buff =3D alloc_skb(MAX_HEADER + sizeof(struct ipv6hdr) + tot_len,
> > >   			 GFP_ATOMIC);
> > > @@ -827,6 +860,9 @@ static void tcp_v6_send_response(const struct soc=
k *sk, struct sk_buff *skb, u32
> > >   				    &ipv6_hdr(skb)->daddr, t1);
> > >   	}
> > >   #endif
> > > +#ifdef CONFIG_MPTCP
> > > +	mptcp_v6_add_ack_opts(sk, skb, t1, &topt);
> > > +#endif
> > >   	memset(&fl6, 0, sizeof(fl6));
> > >   	fl6.daddr =3D ipv6_hdr(skb)->saddr;
> > > @@ -1069,7 +1105,15 @@ struct sock *tcp_v6_syn_recv_sock(const struct=
 sock *sk, struct sk_buff *skb,
> > >   		newnp->saddr =3D newsk->sk_v6_rcv_saddr;
> > > -		inet_csk(newsk)->icsk_af_ops =3D &ipv6_mapped;
> > > +#ifdef CONFIG_MPTCP
> > > +		/* We must check on the request-socket because the listener
> > > +		 * socket's flag may have been changed halfway through.
> > > +		 */
> > > +		if (!inet_rsk(req)->saw_mpc)
> > > +			inet_csk(newsk)->icsk_af_ops =3D &mptcp_v6_mapped;
> > > +		else
> > > +#endif
> > > +			inet_csk(newsk)->icsk_af_ops =3D &ipv6_mapped;
> > >   		newsk->sk_backlog_rcv =3D tcp_v4_do_rcv;
> > >   #ifdef CONFIG_TCP_MD5SIG
> > >   		newtp->af_specific =3D &tcp_sock_ipv6_mapped_specific;
> > > @@ -1116,6 +1160,13 @@ struct sock *tcp_v6_syn_recv_sock(const struct=
 sock *sk, struct sk_buff *skb,
> > >   	if (!newsk)
> > >   		goto out_nonewsk;
> > > +#ifdef CONFIG_MPTCP
> > > +	/* If the meta_sk is v6-mapped we can end up here with the wrong af=
_ops.
> > > +	 * Just make sure that this subflow is v6.
> > > +	 */
> > > +	if (is_meta_sk(sk))
> > > +		inet_csk(newsk)->icsk_af_ops =3D &mptcp_v6_specific;
> > > +#endif
> > >   	/*
> > >   	 * No need to charge this sock to the relevant IPv6 refcnt debug s=
ocks
> > >   	 * count here, tcp_create_openreq_child now does this for us, see =
the
> > > @@ -1453,6 +1504,15 @@ static int tcp_v6_rcv(struct sk_buff *skb)
> > >   			goto discard_it;
> > >   		}
> > >   		if (unlikely(sk->sk_state !=3D TCP_LISTEN)) {
> > > +#ifdef CONFIG_MPTCP
> > > +			if (inet_rsk(req)->saw_mpc) {
> > > +				/* In case of MPTCP join, the meta socket acts
> > > +				 * as the listener. So the state of the listener
> > > +				 * can be other than TCP_LISTEN
> > > +				 */
> > > +				return mptcp_join_ack(req, skb);
> > > +			}
> > > +#endif
> > >   			inet_csk_reqsk_queue_drop_and_put(sk, req);
> > >   			goto lookup;
> > >   		}
> > > -- =

> > > 2.7.4
> > > =

> > > _______________________________________________
> > > mptcp mailing list
> > > mptcp(a)lists.01.org
> > > https://lists.01.org/mailman/listinfo/mptcp
>=20

--===============5260913458023025325==--
