Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741882;
	b=XvZ6hTrdAex3q+4KaBQGOJp2QTmvGgFZkKMDEJYEVZNS30focfZ4iJyG/62KlRkUUCys
	 zbluTtvMwsNUXHaWW6dSycFXlcKdz2y12tdPonnoS9dBOTU9MUdoREogw9iGF0hCcjLSj
	 PqkpfDsfy2Iu1atrJ7lVLZj5nOktjA//MtZutKVcBmihWe73goY8svqmkBzGyY5GgrPpl
	 vLsXhKbRg4zuSNWGpgAh8aBBQlNZos39IkTA0DVK25je5+kU2k5YFM5w5g+hXEisGIvQT
	 50MK4PPjjw4m+wwhMDVVUWbQz69UD03SORRCWxGdNpgx7osa4DTbBca6DWaJEEDz08w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741882;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=qT2LBx85XctbDsC5iPBV6BjNvzAGZkSFB96TXC2ej8Y=;
	b=kxjzc7fsMwh0RfCVZiCcjaozowv2q2J36R9+LOLZ38G40YR5KXvCrFZahy6qw5L6RdL0
	 6sZPsMA66pe5yzWm+8HglemRNooFI/+ghBzwWJ36w45Kw9lhfGjaHlkJhDTiZgT3qf3Zw
	 2km9WWAzSpf8EHy0mtroOTryIqQDwVqGvpZkL5LxCIY83Tdknp9yiJBqnluhBuzUdyrLd
	 2CU5EtsDcJD4kvHeOkRDZiozr28SMP4pxMJ4YLeLCHOAEVCMwzZ2SQ1nr5ABymitBe6kn
	 FHeOQPRvhfnT+yJ1RlqKZp/MblT/JM4h5l4QbPuyCA45EEt2n2SisBeTD4k4iFcPW/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hc7YS2us;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80482606A329;
	Tue,  3 Nov 2026 21:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hc7YS2us
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE881F000C1;
	Tue,  3 Nov 2026 21:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741882;
	bh=qT2LBx85XctbDsC5iPBV6BjNvzAGZkSFB96TXC2ej8Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hc7YS2usCDXg+HZI0HNVy6w1PHaBMOjd5GZC5J5F/0w63jXcBILQdfy62z5h8SAbp
	 svWQrn7PJ+l+vGcOWTzcDaZtO0NlGXW+keU6nT5vNKYXDZIzADtqiRGwmLgyq8ecoz
	 NWhVLmi08uH0wBJHpukxhQBfRKlYCD0FCzzSl7iMFLirwVe/LhDufmndhez3Qcg9h+
	 PoErElIo7yZ4f95LlQnglrPGmQVptjkoQYS6Vrm17luYvfroL05Ta9d+QZGpz0ND0n
	 4cxEOGZC3S5oQNGhwDOt1G+sPGDSil6MvK8hyCGxn6K2O3wZa/ArPXKlcNqYWLZoBr
	 Mj5pALxLkigJw==
Subject: Re: [PATCH bpf v2 07/15] bpf, sockmap: Check the target of an egress
 redirect before each send
From: netdev-bot+sashiko@kernel.org
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, kuniyu@google.com, willemb@google.com, matttbe@kernel.org,
 mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com
Date: Tue, 03 Nov 2026 21:38:00 +0000
Message-ID: <179374188061.488855.10389706003415159913@kernel.org>
In-Reply-To: <20261102072112.4160195-8-alexei.starovoitov@gmail.com>
References: <20261102072112.4160195-8-alexei.starovoitov@gmail.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (2) · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The claim: tcp_bpf_redir_allowed() runs only before
  tcp_sendmsg_locked().
- [Low] Non-blocking egress redirects to a connecting target now fail
  with EINVAL instead of EAGAIN, and the commit message does not say so.
- [Low] The claim: tcp_bpf_sendmsg() strips MSG_FASTOPEN for every psock
  send, including __SK_PASS to the sender's own socket, while the…
- [Low] The comment in tcp_bpf_sendmsg() is now inaccurate.

Pre-existing issues:
- [Medium] An egress-redirect sender sleeping in sk_stream_wait_memory()
  on a target's wait queue is not woken when the target's owner closes…
- [Medium] tcp_bpf_push_locked() (and bpf_tcp_ingress()) call lock_sock()
  on a redirect target that may be a child still in a listener's accept…

--

bpf, sockmap: Check the target of an egress redirect before each send

This adds tcp_bpf_redir_allowed() and calls it in tcp_bpf_push() before
each tcp_sendmsg_locked() call made for an egress redirect. The redirect
fails with -EINVAL when the target has no struct socket or is still
connecting, and with -EPIPE after close(). It also clears MSG_FASTOPEN in
tcp_bpf_sendmsg(), so a redirect cannot enter the target's connect code.

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index fd443350f9b81..ef2e15de0fe3b 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -88,6 +88,24 @@ static int bpf_tcp_ingress(struct sock *sk, struct sk_psock *psock,
>  	return ret;
>  }
>  
> +/*
> + * The target of a redirect belongs to somebody else. A child that nobody has
> + * accepted yet, and an orphan, have no struct socket and no wait queue.
> + * tcp_sendmsg_locked() needs both. See sendmsg_locked() in skbuff.c.
> + * The sender holds no reference to the file of the target, which can be closed
> + * whenever tcp_sendmsg_locked() sleeps. sk_stream_wait_connect() and
> + * inet_wait_for_connect() go back to the wait queue when they wake up, so the
> + * sender must not wait for a connect.
> + */

[Severity: Medium]
This isn't a bug introduced by this patch, but the comment mentions
unaccepted children as redirect targets. Can tcp_bpf_push_locked() hold
the lock of such a child while the listener tears it down?

A sockops BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB program can put a child that
is still in the accept queue into a sockmap. sock_map_sk_state_allowed()
accepts TCP_ESTABLISHED:

    return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_LISTEN);

The redirect sender then does:

tcp_bpf_push_locked()
    lock_sock(sk);
    ret = tcp_bpf_push(sk, msg, apply_bytes, flags, uncharge);
    release_sock(sk);

If the listener is closed in that window, inet_csk_listen_stop() does:

    bh_lock_sock(child);
    WARN_ON(sock_owned_by_user(child));
    sock_hold(child);

Then inet_child_forget() disconnects, orphans and destroys the child
without waiting for the lock owner.

Would the sender's release_sock() then run __release_sock() and
tcp_release_cb() on the torn-down child?

bpf_tcp_ingress() takes lock_sock() on the target in the same way. This
patch makes the egress window shorter, because the lock is now held only
long enough to find sk_socket == NULL and return -EINVAL. The race itself
seems to remain.

> +static bool tcp_bpf_redir_allowed(const struct sock *sk)
> +{
> +	if (!sk->sk_socket)
> +		return false;
> +	if ((1 << sk->sk_state) & (TCPF_SYN_SENT | TCPF_SYN_RECV))
> +		return tcp_passive_fastopen(sk);

[Severity: Low]
Does this change the errno that non-blocking senders see? Every target in
TCP_SYN_SENT is rejected, whatever the sender's timeout is. One example is
a sockmap member that disconnected and then reconnected.

Before this patch, a sender using MSG_DONTWAIT got timeo == 0 in
tcp_sendmsg_locked(). sk_stream_wait_connect() then returned before
add_wait_queue():

net/core/stream.c:sk_stream_wait_connect() {
    ...
		if (!*timeo_p)
			return -EAGAIN;
    ...
}

So this case never reached the remove_wait_queue() path. Now tcp_bpf_push()
returns -EINVAL before it calls tcp_sendmsg_locked(), so a retryable EAGAIN
becomes EINVAL.

The commit message says the redirect fails "when the sender has to wait
for the connection". A non-blocking sender never waits, though.

Could non-blocking senders keep getting -EAGAIN here? If not, could the
commit message mention the errno change?

> +	return true;
> +}
> +
>  static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
>  			int flags, bool uncharge)
>  {
> @@ -109,6 +127,10 @@ static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
>  		page = sg_page(sge);
>  
>  retry:
> +		/* Only a redirect sends data which is not charged to sk */
> +		if (!uncharge && unlikely(!tcp_bpf_redir_allowed(sk)))
> +			return sock_flag(sk, SOCK_DEAD) ? -EPIPE : -EINVAL;

[Severity: Medium]
This check only runs before each tcp_sendmsg_locked() call. Suppose
tcp_sendmsg_locked() sleeps in sk_stream_wait_memory() on an accepted
ESTABLISHED target, and the owner calls close(). sock_orphan() then clears
sk_wq:

    write_lock_bh(&sk->sk_callback_lock);
    sock_set_flag(sk, SOCK_DEAD);
    sk_set_socket(sk, NULL);
    sk->sk_wq  = NULL;

On wakeup, the loop in sk_stream_wait_memory() goes back to:

	while (1) {
		sk_set_bit(SOCKWQ_ASYNC_NOSPACE, sk);

Can this dereference a NULL sk_wq_raw when SOCK_FASYNC is set on the
target?

The commit message says so: "sk_stream_wait_memory() has this test, but
it can still use sk_wq after the sleep. This patch does not change that."

The next patch in the series, "net: Leave sk_stream_wait_memory() once the
socket is dead", adds this right after sk_wait_event():

		if (ret < 0 || sock_flag(sk, SOCK_DEAD))
			goto do_error;

After that, the retry check here returns -EPIPE. So the window exists only
at this commit, or in a backport that takes this patch without the next
one.

Could the series be reordered so that fix lands first?

The out: label also skips remove_wait_queue() for a dead socket, which
leaves the on-stack wait entry on the old queue. That skip predates this
series, and no waker was found that could still walk that queue.

[Severity: Medium]
This is a pre-existing issue, but it is related to the sleep above. Is a
redirect sender that sleeps in sk_stream_wait_memory() on the target woken
at all when the target's owner closes it?

In the default close path, __tcp_close() does:

    WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);

Then it calls tcp_close_state() and tcp_send_fin(), or tcp_set_state(TCP_CLOSE)
plus a reset when data was unread, and then sock_orphan(). None of these
wakes sk_sleep(sk). Only the tcp_disconnect() paths call
sk_error_report().

After sock_orphan(), sk_stream_write_space() does nothing:

	if (__sk_stream_is_writeable(sk, 1) && sock) {

tcp_done() also skips sk_state_change() for a SOCK_DEAD socket.

The sender would then stay in TASK_INTERRUPTIBLE until the target's
sk_sndtimeo expires (MAX_SCHEDULE_TIMEOUT by default) or a signal arrives.
All that time it pins the target sock (sock_hold() in
tcp_bpf_send_verdict()) and its psock (sk_psock_get() in
tcp_bpf_sendmsg_redir()).

The check added here runs before tcp_sendmsg_locked(), so it can't help a
sender that is already asleep inside it. The SOCK_DEAD exit added later in
the series only helps after a wakeup, so the hang seems to remain once the
whole series is applied.

> +
>  		msghdr.msg_flags = flags | MSG_SPLICE_PAGES;
>  		has_tx_ulp = tls_sw_has_ctx_tx(sk);
>  		if (has_tx_ulp)
> @@ -555,7 +577,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>  	int flags;
>  
>  	/* Don't let internal flags through */
> -	flags = (msg->msg_flags & ~MSG_SENDPAGE_DECRYPTED);
> +	flags = (msg->msg_flags & ~(MSG_SENDPAGE_DECRYPTED | MSG_FASTOPEN));

[Severity: Low]
This clears MSG_FASTOPEN for every psock send. That includes __SK_PASS to
the sender's own socket in tcp_bpf_send_verdict():

    ret = tcp_bpf_push(sk, msg, tosend, flags, true);

The fallback without a psock keeps the flag:

	if (unlikely(!psock))
		return tcp_sendmsg(sk, msg, size);

So the same sendmsg(MSG_FASTOPEN) on a connected socket returns -EISCONN
without a psock and succeeds with one. Is that difference intended?

The commit message does describe it ("send() with MSG_FASTOPEN sends the
data. Today it fails with EISCONN."). It also matches the behaviour before
c5c37af6ecad, when do_tcp_sendpages() ignored MSG_FASTOPEN.

tcp_bpf_push() builds its msghdr with no msg_name, so a fastopen connect
could never succeed on this path anyway. This may well be fine as is.

[Severity: Low]
This isn't a bug, but the comment above still says "Don't let internal
flags through". The mask now also clears MSG_FASTOPEN, which is a UAPI
send flag rather than an internal one.

The reason for clearing it is that the target's connect code uses
sk_socket and sk_wq without a file reference. That reason is only in the
commit message, and the comment on tcp_bpf_redir_allowed() does not
mention MSG_FASTOPEN.

Could the comment be updated to say why MSG_FASTOPEN is cleared?

>  	flags |= MSG_NO_SHARED_FRAGS;
>  
>  	psock = sk_psock_get(sk);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102072112.4160195-1-alexei.starovoitov%40gmail.com
