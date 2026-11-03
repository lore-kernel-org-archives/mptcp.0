Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793677628;
	b=Q0hVUafXDkCE0LIVSrf5NqYf32pMk5jk+9blVuopPxGp7AgVff7CW0oPJssbFvr2erIi
	 Sz9aF6PO9yruDSInlwWVbHvotAczo0evR+aVHcv2GiJZJX6uBVR1xq2PkiGBDDoklsUB0
	 vhXxqueAOunoReECvr7ufIxqyRiQ5/rlTcGo308BMgNJZgTgMF2xQzIshY1TZavOsgdMS
	 eZIsebiMFFSMbF4wiilxa3N84zxjNYUX1fQgfUjHaeQGtiMt9uU0CQykG/BE7gYkKHgKZ
	 as3J+CTP6BlpNE/hn+VQ9SGepDh1g40BgBerctdg7xphn3JiWfOAnMn4+RR4u+tHRag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793677628;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=maHIkboEgnzx/EAsKH1mh6xQ0d4cEjjdI99L5Mt/MBo=;
	b=FxVoqrbohyBBNJsPgT93ucuJtNrfi6eYiQ3uppEM205h+bZUfP9ogt5Vi0xdO1YvyHhE
	 e4hZMbm4nUKxel1ubhvPxm1mlXgxg7CgLy2nEUsc1Gel3rPp6dKhXqJOpy5PR1EY38GnJ
	 PZ5z6K4K6y71Bdzsu13vz8PcpOqq91FktHKSP+PqtBRFOLgDf/TbyqiOnBLURA0yNI6ZY
	 FE8cPrY8/JkAntL/zWQx17bH7R1hVp1aXsIfedn+lo7IaHKKh8AK8oerS1+dQ2cj+12IK
	 21Xt3dtFdAu2Noy2Wbrl9SykVrS1EdmqAH953dV6NuUbvuI2VdEc0PPB4vP5vv5h/Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SdNQrCn9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D47F606A324;
	Tue,  3 Nov 2026 03:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SdNQrCn9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22A41F000C1;
	Tue,  3 Nov 2026 03:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793677627;
	bh=maHIkboEgnzx/EAsKH1mh6xQ0d4cEjjdI99L5Mt/MBo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SdNQrCn9rj2xTe8ObujI4uLByGhJrmcx0aejtqUovCDyVqWNzi3yTNxiFlG462FgN
	 +ugeIwBiCi6XTMaKuUhNWjWk3kdYe65P+MEcyTHde937eYFBpP48KAPzX96thKdJh1
	 LeEhnyT5pAHd5siZvnXI3T7R1ZnL1Pei7hNeqYHKJunqUYhgRTPIODdWMRBA/U6oPH
	 x9PgyyvbS7UMMqxjfcWFxq+sIqImENi0R28UYK6ZrNwEK9cvOcgAD8Vg+tmmLfAwcM
	 615Zd4g3MffRfexnyt1oflGhyRJOxikjAgoetIE3cwsO+aNVaZhSxLuY5n2Ila/+V5
	 aU586KudvjBmw==
Subject:
 Re: [PATCH net] tcp: restore IPv6 af_ops on disconnect of a v4-mapped socket
From: netdev-bot+sashiko@kernel.org
To: zhiyuzhang999@gmail.com
Cc: edumazet@kernel.org, kuniyu@google.com, ncardwell@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 lyutoon@gmail.com, tpluszz77@gmail.com
Date: Tue, 03 Nov 2026 03:47:06 +0000
Message-ID: <179367762613.488856.7087052675164086918@kernel.org>
In-Reply-To: <20261030032314.1978575-1-zhiyuzhang999@gmail.com>
References: <20261030032314.1978575-1-zhiyuzhang999@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch does not fully close the bug class it targets: an IPv6
  skb handed from the socket backlog to tcp_v4_do_rcv(), which then…

--

tcp: restore IPv6 af_ops on disconnect of a v4-mapped socket

This adds tcp_v6_disconnect(). When a socket that was connected to a
v4-mapped address is disconnected, it restores icsk_af_ops,
sk_backlog_rcv and af_specific to the IPv6 handlers. The connect() error
path uses the same helper, and the two MPTCP teardown paths now call
sk_prot->disconnect instead of tcp_disconnect() directly.

Closes: https://lore.kernel.org/netdev/CALf2hKvp0NPVLwr=a3+jUHtPohxbra8gox+aYAfWathJnn-J+Q@mail.gmail.com/
Link: https://lore.kernel.org/netdev/CAL4WiiqFJpmcV4=TWRpukCq6q=-729658FwGvieNcPXe97kLvQ@mail.gmail.com/
Link: https://lore.kernel.org/lkml/20261029054136.1174216-1-zhiyuzhang999@gmail.com/

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
Does this also cover the opposite transition? The check only restores the
handlers when going from mapped to native. Going from a native IPv6
connection, through connect(AF_UNSPEC), to a v4-mapped connect() still
looks like it can pass an IPv6 skb from the backlog to tcp_v4_do_rcv().

In tcp_v6_rcv(), the socket lookup, tcp_v6_fill_cb() and the TCP_LISTEN
check all run before the socket spinlock is taken. Once the lock is held,
nothing checks sk_backlog_rcv again:

net/ipv6/tcp_ipv6.c:tcp_v6_rcv() {
    ...
	tcp_v6_fill_cb(skb, hdr, th);
    ...
	bh_lock_sock_nested(sk);
	tcp_segs_in(tcp_sk(sk), skb);
	ret = 0;
	if (!sock_owned_by_user(sk)) {
		ret = tcp_v6_do_rcv(sk, skb);
	} else {
		drop_reason = tcp_add_backlog(sk, skb);
    ...
}

Can this ordering happen?

CPU1 (IPv6 segment for the old native connection)
tcp_v6_rcv()
  __inet6_lookup_skb() finds sk
  tcp_v6_fill_cb()   /* fills header.h6 */

                     CPU0
                     connect(AF_UNSPEC)
                       tcp_v6_disconnect()
                         /* sk_backlog_rcv is tcp_v6_do_rcv, no restore */
                     connect(::ffff:a.b.c.d)
                       tcp_v6_connect()
                         sk->sk_backlog_rcv = tcp_v4_do_rcv;
                         tcp_v4_connect()   /* SYN_SENT, still owned */

  bh_lock_sock_nested()
  sock_owned_by_user() is true
  tcp_add_backlog()

                     release_sock()
                       __release_sock()
                         sk_backlog_rcv() -> tcp_v4_do_rcv()

tcp_v6_do_rcv() redirects ETH_P_IP skbs, but tcp_v4_do_rcv() does not
check skb->protocol at all.

In SYN_SENT, a stale ACK carries an ack_seq from the old connection.
tcp_rcv_synsent_state_process() rejects it, so tcp_v4_do_rcv() ends up
here:

net/ipv4/tcp_ipv4.c:tcp_v4_do_rcv() {
    ...
	reason = tcp_rcv_state_process(sk, skb);
	if (reason)
		goto reset;
	return 0;

reset:
	tcp_v4_send_reset(sk, skb, sk_rst_convert_drop_reason(reason));
    ...
}

>From there, tcp_v4_send_reset() reads ip_hdr() of an IPv6 packet. It then
passes &TCP_SKB_CB(skb)->header.h4.opt, which actually holds h6, to
ip_send_unicast_reply() -> __ip_options_echo(). That is the same 40-byte
overflow the commit message describes.

The window is narrow. Hard irqs, vCPU preemption, preemptible softirqs on
PREEMPT_RT, or a socket filter run by tcp_filter() inside the window can
make it longer.

Is an skb->protocol check also needed in the mapped receive path, in
addition to restoring the handlers on disconnect? It could drop ETH_P_IPV6
skbs, or redirect them to tcp_v6_do_rcv(), like the existing ETH_P_IP check
in tcp_v6_do_rcv().

> +
> +	return ret;
> +}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030032314.1978575-1-zhiyuzhang999%40gmail.com
