Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793918374;
	b=HPGinegUs5QK+3AidZnd1saD/DKAOxBsDayM8OkSX8QHb86eVVIpWR+jXPSqY4BzSw9h
	 ptJmym7I5G8YKcS8UejK70MpUtaAusbrxjmqMBuvl6fMjXXfu3OCudya8LBOS/IcHhtSB
	 rP7QCK72HJBdpan0sjncxdip4/p6z27WmqpRu4sNQLYrs/W39prNpN2PKsL+O5dyx1T6d
	 NqzZOS9ZfXOdZeEUHAV+gi0Ymeu7wCDVrxsfR26FY2wHesXcxSX3oz3uSs79vB+evBPHJ
	 xWr00JeoIMtK32Cr1wW6oqpz1cbOyt+NZbVjrqRFxm7wpkX0tRJeJXkR+4YfiuwfzTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793918374;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/QGtANsqVzWW7lMh8V1+HQMX0rdYIU6nvwiqbuN0l4A=;
	b=m+7bMTGho4sJOSDAWbCQXmnJ3aZy9TppV13uNFZDF4yp3PRkGpaXWZeFIHk1OLc1Z/Ce
	 sqUAkgO8JtabrNPESxv1b0t1B0+Z8LTrhAWsj74hmrQ4UQTS8AqImcx6EvAJUg2r+X/4T
	 8GPqg2mSkztJkHG2ABvlC7XdTn/diJtKgQdH8qEmB5W96vFRD6Xh8FBa4T2F8is5OoVHp
	 v1C8+NJD53n8WxIvP2+pXV/dvlUdQu91ybND+wJdsmrWyQ8DQWufOmq9vxDORmXWXdicE
	 BQZStCHtJ32MAWlm8JhMM2RdkdElKGT4w/PoUvV581if89CAMnsctVzLyHY9pKqGslg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KXPLpT7L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECFE606A31B;
	Thu,  5 Nov 2026 22:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KXPLpT7L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5E91F0089F;
	Thu,  5 Nov 2026 22:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793918373;
	bh=/QGtANsqVzWW7lMh8V1+HQMX0rdYIU6nvwiqbuN0l4A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KXPLpT7LWSb58yZgoi41kTcT+3VUj/SSZvxBvb2ewMiBV4+VDgqi639Pk2rOum62y
	 5yfKH/Kuv3n/St4GomZ5qx2jeZctJo2xxYEZOVkTi885FDI2CE1F3RJsDdndvSSODx
	 xhYni29Opz5ZWvGyGC2yEGyxzdxDZLfhB+hNf+EP9TIaS5oexvngoMeVI99o+rysP5
	 8CLevhT1aq/1BFOKYzy6jvhETT7t4OxfT6KaYhnKNhEpWJj+mPQBeq907xGS6iakQU
	 IOkUfuO1O5OFOJ8STrLS+SGcH+UXJ9pqokdRj+C5BG9OjEP0699lkAEwmsI2da6eMp
	 rxt9VSRDWRzYw==
Subject:
 Re: [PATCH net v3] tcp: prevent cross-family skb processing after disconnect
From: netdev-bot+sashiko@kernel.org
To: zhiyuzhang999@gmail.com
Cc: edumazet@kernel.org, kuniyu@google.com, ncardwell@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 lyutoon@gmail.com, tpluszz77@gmail.com
Date: Thu, 05 Nov 2026 22:39:32 +0000
Message-ID: <179391837250.994134.9616228003361553058@kernel.org>
In-Reply-To: <20261103103633.2707416-1-zhiyuzhang999@gmail.com>
References: <20261103103633.2707416-1-zhiyuzhang999@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch blocks only one direction of the stale-skb race (an
  IPv6 skb reaching tcp_v4_do_rcv()).
- [Medium] The commit message says that in the native-to-mapped race the
  stale IPv6 skb 'belongs to the disconnected connection, so drop it'.

--

tcp: prevent cross-family skb processing after disconnect

This commit adds tcp_v6_disconnect(), which puts back the IPv6 af_ops,
backlog_rcv and af_specific handlers after a v4-mapped socket is
disconnected. It also makes tcp_v4_do_rcv() drop skbs that are not
ETH_P_IP, and sends the MPTCP subflow teardown paths through
sk_prot->disconnect.

Link: https://lore.kernel.org/netdev/CAL4WiiqFJpmcV4=TWRpukCq6q=-729658FwGvieNcPXe97kLvQ@mail.gmail.com/

> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index a7f9242f1e429..8fa6564d2b602 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -1836,6 +1836,11 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
>  {
>  	enum skb_drop_reason reason;
>  
> +	if (unlikely(skb->protocol != htons(ETH_P_IP))) {
> +		reason = SKB_DROP_REASON_INVALID_PROTO;
> +		goto err_discard;
> +	}
> +

[Severity: Medium]
The commit message says:

  In the reverse race, the skb belongs to the disconnected connection, so
  drop it instead of redirecting it to the IPv6 receive path.

Is the skb dropped when the socket is not owned by the user? This check
only runs when the skb goes through sk->sk_backlog_rcv. The unowned branch
of tcp_v6_rcv() calls tcp_v6_do_rcv() directly:

net/ipv6/tcp_ipv6.c:tcp_v6_rcv() {
    ...
	bh_lock_sock_nested(sk);
	tcp_segs_in(tcp_sk(sk), skb);
	ret = 0;
	if (!sock_owned_by_user(sk)) {
		ret = tcp_v6_do_rcv(sk, skb);
    ...
}

tcp_v6_do_rcv() only diverts ETH_P_IP skbs:

	if (skb->protocol == htons(ETH_P_IP))
		return tcp_v4_do_rcv(sk, skb);

Take an IPv6 skb that was looked up before connect(AF_UNSPEC), where the
socket is reconnected to a v4-mapped peer before bh_lock_sock_nested().
That skb goes through tcp_v6_do_rcv() and tcp_rcv_state_process() on the
new connection, whose icsk_af_ops is now &ipv6_mapped.

In SYN_SENT, can an IPv6 SYN-ACK carrying the new ISN (old write_seq +
max_window + 2) complete the mapped connection? If so, tcp_finish_connect()
calls:

	icsk->icsk_af_ops->sk_rx_dst_set(sk, skb);

For ipv6_mapped that callback is inet_sk_rx_dst_set(), so an IPv6 rt6_info
gets cached as sk_rx_dst on the v4-mapped socket.

The __ip_options_echo() overflow is not reached on this path, because
resets go out through tcp_v6_send_reset(). I could not confirm whether the
cached IPv6 dst is later reused for IPv4 skbs. That depends on
ip6_dst_check() accepting a zero cookie.

Even so, the stale skb can still change the state of the new connection.
That contradicts the drop described in the commit message.

> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index e006a30360eae..a93410aab66e6 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c

[ ... ]

> @@ -2093,6 +2099,19 @@ static int tcp_v6_init_sock(struct sock *sk)
>  	return 0;
>  }
>  
> +static int tcp_v6_disconnect(struct sock *sk, int flags)
> +{
> +	int ret = tcp_disconnect(sk, flags);
> +
> +	/* A socket used for a v4-mapped connection must not keep IPv4
> +	 * handlers when it is reused for listen() or a native IPv6 connect().
> +	 */
> +	if (sk->sk_backlog_rcv == tcp_v4_do_rcv)
> +		tcp_v6_restore_af_ops(sk);

[Severity: High]
After this restore, can a stale IPv4 skb be processed with IPv6 af_ops?
The new check in tcp_v4_do_rcv() only looks at skb->protocol. It does not
check whether the socket is still in v4-mapped mode.

A possible sequence:

1. An AF_INET6 socket is connected to a v4-mapped peer. tcp_v4_rcv() looks
   it up for an IPv4 segment.

2. tcp_v4_rcv() runs tcp_inbound_hash() and tcp_filter() before
   bh_lock_sock_nested(). A socket filter can widen this window, as the
   commit message describes.

3. Inside that window, connect(AF_UNSPEC) calls tcp_v6_disconnect(). That
   restores ipv6_specific, tcp_v6_do_rcv and tcp_sock_ipv6_specific. The
   socket is then connected to a native IPv6 peer.

4. The stale IPv4 skb reaches tcp_v4_do_rcv() in one of two ways. If the
   socket is not owned, tcp_v4_rcv() calls it directly. Otherwise the
   backlog drain goes through tcp_v6_do_rcv(), which forwards any ETH_P_IP
   skb without checking the socket's mode:

	if (skb->protocol == htons(ETH_P_IP))
		return tcp_v4_do_rcv(sk, skb);

5. The skb really is IPv4, so the new ETH_P_IP check lets it through.

On a SYN-ACK in SYN_SENT, tcp_finish_connect() calls
icsk_af_ops->sk_rx_dst_set(sk, skb). tcp_rcv_established() makes the same
call before any sequence check when sk_rx_dst is NULL:

	if (unlikely(!rcu_access_pointer(sk->sk_rx_dst)))
		inet_csk(sk)->icsk_af_ops->sk_rx_dst_set(sk, skb);

After the restore, that callback is inet6_sk_rx_dst_set():

	if (dst && dst_hold_safe(dst)) {
		rcu_assign_pointer(sk->sk_rx_dst, dst);
		sk->sk_rx_dst_ifindex = skb->skb_iif;
		sk->sk_rx_dst_cookie = rt6_get_cookie(dst_rt6_info(dst));
	}

This stores an IPv4 rtable as sk_rx_dst and reads it as an rt6_info in
rt6_get_cookie().

Could later IPv6 segments then get this IPv4 dst attached through early
demux? ipv4_dst_check() ignores the cookie, so dst_input() could end up
calling ip_local_deliver() on IPv6 packets. I have not traced this last
step completely.

Before this patch, the socket kept ipv6_mapped ops, so an IPv4 skb still
matched them. With the restore on the normal disconnect path, an IPv4 skb
can now meet IPv6 af_ops, and nothing guards against that.

Would it be better to compare the skb family against the socket's
mapped/native mode? For example, ETH_P_IP skbs could be rejected on a
non-listening AF_INET6 socket whose icsk_af_ops != &ipv6_mapped.
Alternatively, the socket could be revalidated after bh_lock_sock_nested().

> +
> +	return ret;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103103633.2707416-1-zhiyuzhang999%40gmail.com
