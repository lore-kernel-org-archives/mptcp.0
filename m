Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795563042;
	b=G/Rik6sU06QH8R5GQqG+EuJYrFRwOO8WmRwsX1EXBiRNgbho5aRcW45qddpsgyOZLaQH
	 qndKk5qIUtr4wl98CM1gMAaPooCSkBMFypKkhwPK5r09/nmziaMD3wARSgMBNXI1GCXfj
	 ZhVnhRvG5/E6FHGP/2kn3UVmGvwl8umeQpjHCCcWK+LR+HtAVv8WVBHytHe5QVXzv1eou
	 xkN3TlAmNunrkwr24I/sTRkJFYWJG3qLTRQVZazOF1ATvbgpS4SftvYMD1zVd7M1yOJAD
	 vI7xQC0xUHvCiACVfBibzxGly1ec2pvNeaHxOmNan5qj5/z6+sFurCxmLJPi3gnPlZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795563042;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=+yXU3gyvxnsCBLQFxc7hi7GyVJg2UEG6995FK4KckLQ=;
	b=OMlaeZ4Q21/UDPQD52P7c9WWft5A93gUOCCR+7LSaS+oen9XfAYnx0F6CmZNzybKXnFn
	 /AV8G8EsmucW35EWKUf3gVbdi8lwvkumJhtTKY7xLFUj+EcWVLk/jYn4yBVFwAP+CtyyN
	 H7hsHDp8ctwRloDEfgBYhEqcLa30NeXw4eyoAyw+H12SKPrUEJEC3xWUuS0lCDvP8FGPV
	 HISx4+/xJHdp/ZDZSm/ILJYf1N3qvEtIPgYB1xRlHF9qPyeIABf8xb7E/cueeZFd7nuTJ
	 izMtYeLZ9xWyYHTD8v8CqBT92xf2o7KCpRR2tR+NI86D2N1EZAARgNLRpBun71zAr9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y8CiawDD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAC0606A33E
	for <mptcp@lists.linux.dev>; Tue, 24 Nov 2026 23:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y8CiawDD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AA51F000D1;
	Tue, 24 Nov 2026 23:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795563042;
	bh=+yXU3gyvxnsCBLQFxc7hi7GyVJg2UEG6995FK4KckLQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Y8CiawDDgwcaX7E8Jrzs0S8sdFc/i3GOAZaVKvj13djvZwPd2cwGvMq0sgoxGvy4U
	 c3j18CN1zGhvHPpGBhrruQE2pfdNekAXwL+zHz/UjhsvL13H6OeYeTIMNwu+cYUsSf
	 fYJ18vADi2ce0s02iLy72lkcWF5RSUTlUR0UKO4brNhbtLOplYQ4bNl4unBgOHpY2c
	 gvtd7joe4a7HV2ZCCeDc2q01RxmSVv3g60Kd3rew0dD+p9GOrJGqt5M/1Tr0S5ne6e
	 U6Yis2SeJdVXG+balpjKH9966c3GlHtyopv3xI/U5nb5KrOkfKoknQIhgYCC4TqVD3
	 Q59V1U6mWSm3w==
Subject: Re: [PATCH mptcp-next v8 4/7] mptcp: add MSG_ZEROCOPY support
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 24 Nov 2026 23:30:41 +0000
Message-ID: <179556304139.3133.296848158995571353@kernel.org>
In-Reply-To: <3f30ee2209176e73f716ad379bb6385145b05fa8.1795421388.git.tanggeliang@kylinos.cn>
References: <3f30ee2209176e73f716ad379bb6385145b05fa8.1795421388.git.tanggeliang@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 5 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] On 64K-page kernels (arm64 with 64K pages, ppc64le by default),
  mptcp_sendmsg_zerocopy_iter() in net/mptcp/protocol.c has an off-by-…
- [Medium] mptcp_poll() never reports EPOLLERR for a non-empty
  sk_error_queue, but MSG_ZEROCOPY completions for MPTCP are queued on…
- [Medium] A MSG_ZEROCOPY sendmsg() can return success without being
  assigned a notification ID.
- [Medium] mptcp_sendmsg_zerocopy_iter() leaks a page reference when
  iov_iter_get_pages2() returns 0.
- [Medium] mptcp: missing DEFER_CONNECT check for MSG_ZEROCOPY in
  mptcp_sendmsg()
- [Medium] mptcp: unbalanced sk_wmem_schedule() in
  mptcp_sendmsg_zerocopy_iter()
- [Low] Documentation/networking/msg_zerocopy.rst still says 'The feature
  is currently implemented for TCP, UDP and VSOCK (with virtio…
- [Low] The commit author is 'Geliang Tang <geliang@kernel.org>' but the
  only Signed-off-by is 'Geliang Tang <tanggeliang@kylinos.cn>'.

--

mptcp: add MSG_ZEROCOPY support

This commit adds MSG_ZEROCOPY support to MPTCP sockets. It pins user pages
with iov_iter_get_pages2() and stores them in a separately allocated
mptcp_data_frag that holds a reference on the ubuf_info. Subflow skbs are
marked with skb_zcopy_set() and SKBFL_PURE_ZEROCOPY, the same way TCP does
it.

> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>

[Severity: Low]
The Author is Geliang Tang <geliang@kernel.org>, but the only sign-off uses
a different address. checkpatch.pl reports a From:/Signed-off-by: email
address mismatch for this.

Could the author and sign-off addresses be made to match, or could an
explicit matching From: line be added?

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index be8432e12bf8c..8bbb123bd240f 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -1998,22 +2023,110 @@ static void mptcp_rps_record_subflows(const struct mptcp_sock *msk)
>  	}
>  }
>  
> +static ssize_t mptcp_sendmsg_zerocopy_iter(struct sock *sk, struct msghdr *msg,
> +					   struct ubuf_info *ubuf,
> +					   u32 copy_limit)
> +{
> +	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct mptcp_data_frag *dfrag;
> +	struct page *pages[1] = {};
> +	size_t pg_off = 0;
> +	ssize_t pg_len;
> +
> +	pg_len = iov_iter_get_pages2(&msg->msg_iter, pages,
> +				     copy_limit, 1, &pg_off);
> +	if (pg_len < 0)
> +		return pg_len;
> +	/* pg_len == 0 means the iterator is exhausted */
> +	if (pg_len == 0)
> +		return -EFAULT;

[Severity: Medium]
Can this leak a page reference? Every other error exit in this helper calls
put_page(pages[0]), but this one does not.

For ITER_BVEC iterators, __iov_iter_get_pages_alloc() can take a reference
and still return 0. Take a current bvec segment with zero length and a bv_offset
that is not page aligned:

  first_bvec_segment() caps maxsize to 0
  want_pages_array() still returns n = 1, because *start != 0
  folio_get() is called on the page stored in pages[0]
  maxsize = min(0, ...) = 0 is returned

It isn't clear whether any real in-kernel caller builds such an iterator.
Even so, would something like this be safer?

    if (pg_len == 0) {
        if (pages[0])
            put_page(pages[0]);
        return -EFAULT;
    }

> +
> +	if (pg_len > U16_MAX) {
> +		iov_iter_revert(&msg->msg_iter, pg_len - U16_MAX);
> +		pg_len = U16_MAX;
> +	}
> +
> +	if (pg_off > U16_MAX) {
> +		iov_iter_revert(&msg->msg_iter, pg_len);
> +		put_page(pages[0]);
> +		return -EFAULT;
> +	}
> +
> +	if (pg_off + pg_len > U16_MAX) {
> +		size_t len = U16_MAX - pg_off;
> +
> +		iov_iter_revert(&msg->msg_iter, pg_len - len);
> +		pg_len = len;
> +		if (WARN_ON_ONCE(!pg_len)) {
> +			put_page(pages[0]);
> +			return -EFAULT;
> +		}
> +	}

[Severity: Medium]
Is this sk_wmem_schedule() balanced anywhere?

When sk->sk_forward_alloc is smaller than pg_len + sizeof(*dfrag),
__sk_mem_schedule() grows sk_forward_alloc in page units. It also
charges tcp_memory_allocated and the socket memcg. The copy path in
mptcp_sendmsg() consumes that with sk_forward_alloc_add(sk, -total_ts),
but nothing here calls sk_mem_charge(). On the release side,
dfrag_uncharge() now skips sk_mem_uncharge() for zerocopy dfrags, so
sk_mem_reclaim() is not reached from that path either.

Take a socket that only does MSG_ZEROCOPY sends. The forward
allocation from the first schedule can be up to roughly 17 pages on
4K page kernels, since pg_len can be close to 64K. It stays charged to
the protocol and to the memcg until another path reclaims it or the
socket is closed.

This also makes zerocopy sends subject to the protocol memory limits.
Under tcp memory pressure __sk_mem_schedule() can fail. The -EAGAIN
return then sends mptcp_sendmsg() into wait_for_memory, even though
no socket memory is actually charged for this data.

The commit message says these pages bypass kernel memory accounting.
tcp_sendmsg_locked() likewise skips tcp_wmem_schedule() for pure
zerocopy skbs.

Should this call be dropped, to match TCP and the dfrag_uncharge()
change? Or should the dfrag be charged with sk_mem_charge() here and
uncharged normally in dfrag_uncharge()?

[Severity: High]
On 64K page kernels, can userspace trigger this WARN_ON_ONCE()?

With maxpages == 1, iov_iter_get_pages2() gives pg_off + pg_len <=
PAGE_SIZE, which is 65536 here. For a page-aligned buffer, the first pass
gets pg_off = 0 and pg_len = 65536. The pg_len > U16_MAX check caps that to
65535 and reverts one byte.

The next pass then gets pg_off = 65535 and pg_len = 1. The pg_off > U16_MAX
check is false, but pg_off + pg_len > U16_MAX is true, so:

    len = U16_MAX - pg_off;    /* 0 */
    pg_len = len;
    if (WARN_ON_ONCE(!pg_len)) {

The warning fires and -EFAULT is returned. The same thing happens for any
chunk that ends exactly at the end of a 64K page, because that chunk gets
trimmed by one byte.

In mptcp_sendmsg() this becomes a short write when copied > 0. When the
remainder is retried (copied == 0), the zerocopy request is aborted and the
data is copied instead. With panic_on_warn, an unprivileged user with
SO_ZEROCOPY set can crash the system this way.

Is the stricter bound needed? In __mptcp_clean_una(), dfrag->offset only
grows by delta < data_len, so pg_off + pg_len == 65536 seems to still fit
both u16 fields. Would checking against U16_MAX + 1 be enough here?

[ ... ]

>  static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  {
>  	struct mptcp_sock *msk = mptcp_sk(sk);
> +	struct ubuf_info *ubuf = NULL;
>  	struct page_frag *pfrag;
>  	size_t copied = 0;
> +	bool zc = false;
>  	int ret = 0;
>  	long timeo;
>  
>  	/* silently ignore everything else */
>  	msg->msg_flags &= MSG_MORE | MSG_DONTWAIT | MSG_NOSIGNAL |
> -			  MSG_FASTOPEN | MSG_EOR;
> +			  MSG_FASTOPEN | MSG_EOR | MSG_ZEROCOPY;

[Severity: Low]
This isn't a bug, but Documentation/networking/msg_zerocopy.rst still says:

  The feature is currently implemented for TCP, UDP and VSOCK (with
  virtio transport) sockets.

Should MPTCP be added there, along with any MPTCP-specific behaviour?
Documentation/networking/ is not changed anywhere in the series.

>  
>  	lock_sock(sk);
>  
>  	mptcp_rps_record_subflows(msk);
>  
> +	if (msg->msg_flags & MSG_FASTOPEN || !sock_flag(sk, SOCK_ZEROCOPY))
> +		msg->msg_flags &= ~MSG_ZEROCOPY;
> +
> +	if ((msg->msg_flags & MSG_ZEROCOPY) && len) {
> +		ubuf = msg_zerocopy_realloc(sk, len, NULL, false);

[Severity: Medium]
Does MSG_ZEROCOPY also need to be dropped when DEFER_CONNECT is set?

The downgrade here only tests MSG_FASTOPEN. The fastopen branch just
below is also entered when inet_test_bit(DEFER_CONNECT, sk) is set.
After setsockopt(TCP_FASTOPEN_CONNECT) and connect(), a plain
sendmsg(MSG_ZEROCOPY) therefore allocates ubuf with zc = true and then
goes through mptcp_sendmsg_fastopen().

mptcp_sendmsg_fastopen() passes a NULL uarg to tcp_sendmsg_fastopen().
The bytes placed in the SYN are copied, but the ubuf is never attached
to the SYN skb and uarg->zerocopy is never cleared. When that call
returns -EINPROGRESS with copied_syn > 0, we jump to out: and
net_zcopy_put(ubuf) drops the last reference. The completion is then
queued immediately, while the SYN data is still unacknowledged. It is
also reported without SO_EE_CODE_ZEROCOPY_COPIED, even though every
byte was copied.

The user buffer was copied, so reusing it is not unsafe. Still, the
application gets a wrong report for this send. This also doesn't match
the commit message, which says zerocopy is downgraded for fastopen.

TCP hands its uarg to tcp_sendmsg_fastopen() for this case. Would it
be simpler to add the DEFER_CONNECT test to the downgrade condition, or
should the ubuf be passed through the MPTCP fastopen path the same way
TCP does it?

[Severity: Medium]
Zerocopy completions are now queued on the msk sk_error_queue. Does
mptcp_poll() need to report EPOLLERR when that queue is not empty?

msg_zerocopy_alloc() allocates the notification skb with sock_omalloc() on
the msk. __msg_zerocopy_callback() queues it on sk->sk_error_queue and calls
sk_error_report().

mptcp_poll() only checks sk_err:

net/mptcp/protocol.c:mptcp_poll() {
    ...
	if (READ_ONCE(sk->sk_err))
		mask |= EPOLLERR;
    ...
}

tcp_poll() also checks the error queue:

net/ipv4/tcp.c:tcp_poll() {
    ...
	if (READ_ONCE(sk->sk_err) ||
	    !skb_queue_empty_lockless(&sk->sk_error_queue))
		mask |= EPOLLERR;
    ...
}

Documentation/networking/msg_zerocopy.rst says poll() blocks until a
notification is outstanding and then sets POLLERR. Its example uses
poll(&pfd, 1, -1) with events = 0.

On an MPTCP socket the completion does wake the waiter. The recomputed mask
has no EPOLLERR, though, so the waiter goes back to sleep.

The comment in mptcp_recvmsg() also looks stale now:

	/* MSG_ERRQUEUE is really a no-op till we support IP_RECVERR */

The selftest in this series polls with a 200ms timeout and drains the queue
again, which hides this.

> +		if (!ubuf) {
> +			ret = -ENOBUFS;
> +			goto do_error;
> +		}
> +		zc = true;
> +	}
> +

[ ... ]

> @@ -2052,6 +2165,25 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
>  		if (!copy_limit)
>  			goto wait_for_memory;
>  
> +		if (zc) {
> +			ret = mptcp_sendmsg_zerocopy_iter(sk, msg, ubuf,
> +							  copy_limit);
> +			if (ret == -EAGAIN || ret == -ENOMEM)
> +				goto wait_for_memory;
> +			if (ret == -EFAULT) {
> +				if (copied)
> +					goto do_error;
> +				net_zcopy_put_abort(ubuf, true);
> +				zc = false;
> +				ubuf = NULL;

[Severity: Medium]
Can a MSG_ZEROCOPY sendmsg() return success here without being given a
notification ID?

When mptcp_sendmsg_zerocopy_iter() returns -EFAULT with copied == 0,
net_zcopy_put_abort() ends up in msg_zerocopy_put_abort():

    atomic_dec(&sk->sk_zckey);
    uarg_to_msgzc(uarg)->len--;

As a result, __msg_zerocopy_callback() frees the uarg later without queueing
a notification. The loop then carries on through the copy path. If the copy
succeeds, sendmsg() returns a positive byte count with no ID and no
completion.

Documentation/networking/msg_zerocopy.rst says "Each send call with
MSG_ZEROCOPY that successfully sends data increments the counter."

TCP only aborts the uarg on its out_err path, where nothing was sent. When it
falls back to copying on a successful send, it keeps the uarg and reports
SO_EE_CODE_ZEROCOPY_COPIED.

This path can be reached on 64K page kernels on every retry after the short
write described above (pg_off == 65535). On 256K page kernels it can be
reached through the pg_off > U16_MAX case. Applications that count
successful sends and wait for the matching completion IDs would wait
forever.

The commit message describes this -EFAULT only as signalling iterator
exhaustion:

  When iov_iter_get_pages2() returns 0, the function returns -EFAULT
  to properly signal iterator exhaustion.

It doesn't mention the silent downgrade to copy. Should this path keep the
uarg and clear uarg->zerocopy, the way TCP does?

> +			} else if (ret < 0) {
> +				goto do_error;
> +			} else {
> +				copied += ret;
> +				continue;
> +			}
> +		}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795421388.git.tanggeliang%40kylinos.cn
