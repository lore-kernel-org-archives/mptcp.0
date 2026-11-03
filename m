Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703822;
	b=CZccDWrf6yDrCqC7haRDmn4oO0oosVpzplu7FuWpmO93Rna5NmEZdK+/8Xfwcz8vmcVw
	 Xt7kQrCk+0k7AYne4FuIYHSCSMfGhk7QIq2JU252O/ROYmy3+YoPw5j/hCJTk0jm8lgeO
	 QbWO0zIioClfxsSN3YvCakmMNlQ9LszmliFGgP6eSo0aDhJMADuKxtR/cpuxNbYu9IABb
	 rDdPxbOmCn00PLPJqRwUAV20vfau2noKsPyeWa9I2Ri0xCBlUZto0gA1ekaQcdbE+WTWv
	 3XPOJTxxETtDIY6nIs4UgyKkFfp3f6VuO232kU/m8YHPr8HKksEnWMu4Lkhs/mGumNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703822;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JyM24O+rf+svFmAkF/rQOfx0k+ek4EwDrMXxgQ5Nhow=;
	b=rpU6kwONDKMdk6wtYbnLTZ4V5qIW5YV7XHP1/21npH/X91joselpbBZ5K7lGVHBY3/e6
	 keR3bqct32Xv/zDX4cvtJGCtMvjMZWz0omWp3JOsQc3ioQ5EEg8lqx9kvAIXT9lBXaTuP
	 9SSEWCeEOk5pnmQYvhXXopFava3X5hBNrpyjXdX7R1j+Bg/a8iOxgxz42Gw/QQsxZKPtM
	 +kYnIWAWTis3cKTKXWdrPCCMU2i7otl4n9ktg9YivoK8bQ63a5o4dcmtTTwLsbK7q4+vl
	 SUrSHy89wXA/2C+X/TeWNwQQGfaU6slR2bgWmUxqEjJQ28ItdIiMKSEvBsN+u71Z8pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fxQ2tZEZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7311606BA4B
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 11:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fxQ2tZEZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823721F00A18
	for <mptcp@lists.linux.dev>; Tue,  3 Nov 2026 11:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793703821;
	bh=JyM24O+rf+svFmAkF/rQOfx0k+ek4EwDrMXxgQ5Nhow=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fxQ2tZEZz+PbVM3Z4auQyCMbdO7aGrzjU5Xveb23ELRrVyCn6TcXGZuT7DR2SdngH
	 8ddSwT5ZeGYqFze5MgT3jazyU+cDMSvKa4Dvl1/HmKhpyQnxI4cLauY2Exi+9i+RjH
	 J+353L6LEjmTbU2juCF9fPVHOfd1XB0LpEVRyEFe/eDh8XGfepd7scv7hLoNIAaGtD
	 bS3E349yU2nqW5OTQXPavCB3+5Qkk2JHyJvb9LEm/uvT2yLkSIw/kvf+HFaZhBix0i
	 5PHEAZ0+sVv1uw4wM23R+KiuIeiQKpDGXL3AhQr/5IJlXw5JF8jl7HMO6ZLUjDP3yg
	 VTMgS+B9KYHFw==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4911df1e196so2495454fac.1
        for <mptcp@lists.linux.dev>; Tue, 03 Nov 2026 03:03:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxTDlHgtwkSa38zqpYSq0oC/7ugc61INe3iSIr+Od3aLAZZCDy1aQ+Kr3nPXKtcG21QeQx07Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z+uF719c5MUixF2nppF9yy+nfpcnRoOSD7de1FbApvZdxNXYPhJ
	SrgZrP+QaXd4P/WxpkSmwyJtxCrXPVE/lcLMoGNomPmKFtal6SVU6uk7y4H8+jl8YZVZLeQ8XPo
	IqQl6pzcavZHdHP0RvvAVqebnf/a7XjY=
X-Received: by 2002:a05:6870:d614:b0:494:117b:81d7 with SMTP id
 586e51a60fabf-4a9077981a6mr8442786fac.54.1793703820673; Tue, 03 Nov 2026
 03:03:40 -0800 (PST)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261103103633.2707416-1-zhiyuzhang999@gmail.com>
In-Reply-To: <20261103103633.2707416-1-zhiyuzhang999@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 3 Nov 2026 12:03:29 +0100
X-Gmail-Original-Message-ID: <CAL4Wiip0RPZkfrwHeuNp6ntVWarpkL=wJ-wW6sUvNzYWS68s3Q@mail.gmail.com>
X-Gm-Features: AclHuK9W0Wv5Y05dpi8H0OgE8o30SKR3SptbPMVtNuc87b7hbFA_4UpDoxGktls
Message-ID: <CAL4Wiip0RPZkfrwHeuNp6ntVWarpkL=wJ-wW6sUvNzYWS68s3Q@mail.gmail.com>
Subject: Re: [PATCH net v3] tcp: prevent cross-family skb processing after disconnect
To: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Tong Liu <lyutoon@gmail.com>, Qi Tang <tpluszz77@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 3 nov. 2026 =C3=A0 11:40, Zhiyu Zhang <zhiyuzhang999@gmail.com> a =
=C3=A9crit :
>
> From: Eric Dumazet <edumazet@kernel.org>
>
> A successful connect() of an IPv6 socket to a v4-mapped address switches
> icsk_af_ops, sk_backlog_rcv and af_specific to their IPv4-mapped
> variants. A later connect(AF_UNSPEC) calls tcp_disconnect(), which does
> not restore them.
>
> The socket can then be reused for a native IPv6 connection while
> tcp_v4_do_rcv() remains installed. IPv6 packets drained from its backlog
> are consequently passed to the IPv4 receive path.
>
> There is also a race in the opposite direction. tcp_v6_rcv() can look up
> the socket and initialize TCP_SKB_CB(skb)->header.h6 before taking the
> socket lock. If the socket is disconnected and reconnected to a
> v4-mapped peer in that window, release_sock() can drain the queued IPv6
> skb through the newly installed tcp_v4_do_rcv().
>
> tcp_v4_send_reset() and tcp_v4_send_ack() then interpret header.h6 as
> IPv4 options. __ip_options_echo() can consequently overflow its 40-byte
> destination buffer.
>
> Commit 8cc3aef0cb19 ("tcp: Do not allow buggy transitions between ehash
> and lhash2.") prevents listen() after connect(AF_UNSPEC), but a native
> IPv6 connect is still allowed.
>
> Add tcp_v6_disconnect() to restore the IPv6 handlers after disconnecting
> a v4-mapped socket, and use the same helper in the connect error path.
> Reject non-IPv4 skbs in tcp_v4_do_rcv() before accessing IPv4
> control-block data. In the reverse race, the skb belongs to the
> disconnected connection, so drop it instead of redirecting it to the
> IPv6 receive path.
>
> MPTCP subflows override sk_prot, while two teardown paths call
> tcp_disconnect() directly. Route them through the protocol-specific
> disconnect operation so IPv6 MPTCP subflows receive the same
> restoration.
>
> Tested with TCP and MPTCP by reconnecting an AF_INET6 socket in both
> directions after connect(AF_UNSPEC). A socket filter was used to widen
> the native-to-mapped race window and verify that the stale IPv6 skb did
> not reach tcp_v4_send_reset().
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Tong Liu <lyutoon@gmail.com>
> Reported-by: Qi Tang <tpluszz77@gmail.com>
> Closes: https://lore.kernel.org/netdev/CALf2hKvp0NPVLwr=3Da3+jUHtPohxbra8=
gox+aYAfWathJnn-J+Q@mail.gmail.com/
> Link: https://lore.kernel.org/netdev/CAL4WiiqFJpmcV4=3DTWRpukCq6q=3D-7296=
58FwGvieNcPXe97kLvQ@mail.gmail.com/
> Signed-off-by: Eric Dumazet <edumazet@kernel.org>
> Co-developed-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
> Signed-off-by: Zhiyu Zhang <zhiyuzhang999@gmail.com>
> ---
> Changes in v3:
> - Reject non-IPv4 skbs in tcp_v4_do_rcv() to cover packets queued
>   across a native IPv6 to v4-mapped reconnect.
> - Drop Kuniyuki's Reviewed-by tag due to the code change.
>
> v2: https://lore.kernel.org/netdev/20261101182736.430733-1-zhiyuzhang999@=
gmail.com/
> v1: https://lore.kernel.org/netdev/20261030032314.1978575-1-zhiyuzhang999=
@gmail.com/
>
>  net/ipv4/tcp_ipv4.c  |  5 +++++
>  net/ipv6/tcp_ipv6.c  | 37 ++++++++++++++++++++++++++++---------
>  net/mptcp/protocol.c |  4 ++--
>  3 files changed, 35 insertions(+), 11 deletions(-)
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index a7f9242f1e42..8fa6564d2b60 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1836,6 +1836,11 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff =
*skb)
>  {
>         enum skb_drop_reason reason;
>
> +       if (unlikely(skb->protocol !=3D htons(ETH_P_IP))) {
> +               reason =3D SKB_DROP_REASON_INVALID_PROTO;
> +               goto err_discard;
> +       }
> +

We do not want to add yet another check in TCP IPv4 fast path,
for a problem that only exists for IPv6 sockets.

tcp_v6_do_rcv() already dispatches IPv4 skbs to tcp_v4_do_rcv().

Simply stop changing sk->sk_backlog_rcv for v4-mapped sockets
(tcp_v6_connect() and tcp_v6_mapped_child_init()),
so that skbs found in the backlog are always handled by the correct path.

tcp_v6_disconnect() can then test
inet_csk(sk)->icsk_af_ops->net_header_len =3D=3D sizeof(struct iphdr)
(this also covers subflow_v6m_specific).

Thanks.

Untested patch:

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e006a30360eae1b43a4d53173b46b931ae668825..74358bed6ba210074f0534dff61=
247de34a56727
100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -130,6 +130,18 @@ static int tcp_v6_pre_connect(struct sock *sk,
struct sockaddr_unsized *uaddr,
        return BPF_CGROUP_RUN_PROG_INET6_CONNECT(sk, uaddr, &addr_len);
 }

+/* Undo the v4-mapped setup done by tcp_v6_connect(). */
+static void tcp_v6_restore_af_ops(struct sock *sk)
+{
+       /* Paired with READ_ONCE() in tcp_(get|set)sockopt() */
+       WRITE_ONCE(inet_csk(sk)->icsk_af_ops, &ipv6_specific);
+       if (sk_is_mptcp(sk))
+               mptcpv6_handle_mapped(sk, false);
+#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
+       tcp_sk(sk)->af_specific =3D &tcp_sock_ipv6_specific;
+#endif
+}
+
 static int tcp_v6_connect(struct sock *sk, struct sockaddr_unsized *uaddr,
                          int addr_len)
 {
@@ -234,7 +246,6 @@ static int tcp_v6_connect(struct sock *sk, struct
sockaddr_unsized *uaddr,
                WRITE_ONCE(icsk->icsk_af_ops, &ipv6_mapped);
                if (sk_is_mptcp(sk))
                        mptcpv6_handle_mapped(sk, true);
-               sk->sk_backlog_rcv =3D tcp_v4_do_rcv;
 #if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
                tp->af_specific =3D &tcp_sock_ipv6_mapped_specific;
 #endif
@@ -243,14 +254,7 @@ static int tcp_v6_connect(struct sock *sk, struct
sockaddr_unsized *uaddr,

                if (err) {
                        icsk->icsk_ext_hdr_len =3D exthdrlen;
-                       /* Paired with READ_ONCE() in tcp_(get|set)sockopt(=
) */
-                       WRITE_ONCE(icsk->icsk_af_ops, &ipv6_specific);
-                       if (sk_is_mptcp(sk))
-                               mptcpv6_handle_mapped(sk, false);
-                       sk->sk_backlog_rcv =3D tcp_v6_do_rcv;
-#if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
-                       tp->af_specific =3D &tcp_sock_ipv6_specific;
-#endif
+                       tcp_v6_restore_af_ops(sk);
                        goto failure;
                }
                np->saddr =3D sk->sk_v6_rcv_saddr;
@@ -1363,7 +1367,6 @@ static void tcp_v6_mapped_child_init(struct sock
*newsk, const struct sock *sk)
        inet_csk(newsk)->icsk_af_ops =3D &ipv6_mapped;
        if (sk_is_mptcp(newsk))
                mptcpv6_handle_mapped(newsk, true);
-       newsk->sk_backlog_rcv =3D tcp_v4_do_rcv;
 #if defined(CONFIG_TCP_MD5SIG) || defined(CONFIG_TCP_AO)
        tcp_sk(newsk)->af_specific =3D &tcp_sock_ipv6_mapped_specific;
 #endif
@@ -2093,6 +2096,21 @@ static int tcp_v6_init_sock(struct sock *sk)
        return 0;
 }

+static int tcp_v6_disconnect(struct sock *sk, int flags)
+{
+       int ret =3D tcp_disconnect(sk, flags);
+
+       /* A socket used for a v4-mapped connection must not keep IPv4
+        * handlers when it is reused for listen() or a native IPv6 connect=
().
+        * Note that ipv6_mapped and subflow_v6m_specific both use an IPv4
+        * network header.
+        */
+       if (inet_csk(sk)->icsk_af_ops->net_header_len =3D=3D sizeof(struct =
iphdr))
+               tcp_v6_restore_af_ops(sk);
+
+       return ret;
+}
+
 #ifdef CONFIG_PROC_FS
 /* Proc filesystem TCPv6 sock list dumping. */
 static void get_openreq6(struct seq_file *seq,
@@ -2283,7 +2301,7 @@ struct proto tcpv6_prot =3D {
        .close                  =3D tcp_close,
        .pre_connect            =3D tcp_v6_pre_connect,
        .connect                =3D tcp_v6_connect,
-       .disconnect             =3D tcp_disconnect,
+       .disconnect             =3D tcp_v6_disconnect,
        .accept                 =3D inet_csk_accept,
        .ioctl                  =3D tcp_ioctl,
        .init                   =3D tcp_v6_init_sock,
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7a22e9388e0e9a8b1bd6fe27d04245a1db6950b1..fdfbc7de2ec03612bc49d0a337a=
80fe1089a7d81
100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2608,7 +2608,7 @@ static void __mptcp_subflow_disconnect(struct sock *s=
sk,
                /* The MPTCP code never wait on the subflow sockets, TCP-le=
vel
                 * disconnect should never fail
                 */
-               WARN_ON_ONCE(tcp_disconnect(ssk, 0));
+               WARN_ON_ONCE(ssk->sk_prot->disconnect(ssk, 0));
                mptcp_subflow_ctx_reset(subflow);
        } else {
                tcp_shutdown(ssk, SEND_SHUTDOWN);
@@ -3287,7 +3287,7 @@ void mptcp_subflow_shutdown(struct sock *sk,
struct sock *ssk, int how)
                        break;
                fallthrough;
        case TCP_SYN_SENT:
-               WARN_ON_ONCE(tcp_disconnect(ssk, O_NONBLOCK));
+               WARN_ON_ONCE(ssk->sk_prot->disconnect(ssk, O_NONBLOCK));
                break;
        default:
                if (__mptcp_check_fallback(mptcp_sk(sk))) {
