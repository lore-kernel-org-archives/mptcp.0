Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741886;
	b=DAnfG4cbw861ruMkkOmW6Lf12IE+I7T0bKsrYW81TDCtWx1+nApB/MWllDhPUiIsWe4u
	 1NFRwx/ecoXgRpYgeYQgt833lMhnk55NOJt9ojtdJ9PjKYUQilZ2kTmGnoM+tn9T06k+8
	 V3EKqGCJsfMUWGwAb4S2hLoHpCn5h27XCHxsq5ZxD1pF0oD0JtWcleTWrxLOf8oSiV2G6
	 eLCKfU8FU5jth6mWGjpsMU2RkpMjrqjd283zHXRGrmKT2sSLLCjGKWLrX4vlKNnK+pfzU
	 NE5vfYVjtOvQOo9X37qQydBaIfInvLTQYsVrpynSOc3kEtjvFpwyicIihJMTdQf0g+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741886;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=V0jZpNRgfyM4S6HujGRZUQQH6VN4jrKq+NmC0BZso4U=;
	b=OLGlYUFVyY50XsiU2TCkWr96y8LQNyAAwus0f52LHp3pLz7C2OkBjn0yLBPbLvoqqCi9
	 xk209Q9xDfQXEj6+J8SPj2PBOAiCVrK82/ReHvZXbnWwX9kPRIA7jaqixfQKQeGsSRjyz
	 ZmfaHKBdDoUlDQTqjvkuv/rMoRI/b600GVSeup/SCbiGtEjWNKZczqgsRh7hi+Mm98QPI
	 Oi3qzDjgsIyWfvLy/U7LWzKg8WsDAJJ8pB8Q/cgD8JNIGeyw24K6n43mHGeotvYDpxGCk
	 BQQ6NMnBW4A4VVmbykPXPzFli3x2Nh0CwclDPvDhzZtw6elC2whnEF3EsSemw9hdqwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJuEyAnJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F379B606A335;
	Tue,  3 Nov 2026 21:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJuEyAnJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE1E1F00A02;
	Tue,  3 Nov 2026 21:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741885;
	bh=V0jZpNRgfyM4S6HujGRZUQQH6VN4jrKq+NmC0BZso4U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iJuEyAnJJ2gsXvsBkrQuweQKj+FH5d1q11FTCkY2BVUoRBanzqGMlEd+0U4SgHKex
	 IRLugICuaTmhWMO3uVljk+AkcEBtoors19sI9MWwqya7M2rfn7hhDT0LP/+SQfPLMB
	 urtYM0JenjKyut84aVkMBtr4kbOW1xLt6JAvyqEXgzXDwQUUCeOn9Yz6HqxjHf5Wx6
	 NzUIiD9F8+rGPq4k3tjpCraae8IuSyJqnYD9SE5bQVM+TSVnMkP73XUX0vHiR1W8nG
	 M53zlfLN+kldgJHxa/+rpOT8QrvX0BIi55k12G+JlyLzgMaLco0vfI1Nw0SsNXE1sI
	 h/6zg+/wXB06w==
Subject: Re: [PATCH bpf v2 14/15] bpf, sockmap: Keep the rest of the cork
 after a redirect
From: netdev-bot+sashiko@kernel.org
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, kuniyu@google.com, willemb@google.com, matttbe@kernel.org,
 mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com
Date: Tue, 03 Nov 2026 21:38:04 +0000
Message-ID: <179374188416.488855.8465787275984951547@kernel.org>
In-Reply-To: <20261102072112.4160195-15-alexei.starovoitov@gmail.com>
References: <20261102072112.4160195-15-alexei.starovoitov@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 (1) · High: 0 · Medium: 1 (3) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The fix is incomplete: the cork tail is still lost when
  another sender installs a new cork while the lock is dropped.

Pre-existing issues:
- [Critical] This problem wasn't introduced by this patch, but the
  SK_PASS branch of `tcp_bpf_send_verdict()` pushes a message that is…
- [Medium] This problem wasn't introduced by this patch, but the selftest
  `test_txmsg_cork_hangs()` in…
- [Medium] This problem wasn't introduced by this patch, but when
  `tcp_bpf_sendmsg_redir()` fails for a cork in…
- [Medium] This problem wasn't introduced by this patch, but in the
  __SK_REDIRECT branch of `tcp_bpf_send_verdict()`,…

--

bpf, sockmap: Keep the rest of the cork after a redirect

When a verdict covers only part of a cork after bpf_msg_apply_bytes(),
the SK_REDIRECT branch of tcp_bpf_send_verdict() used to free the bytes
that were left over along with the cork. This patch puts the cork back
into psock->cork when bytes remain, unless another thread installed a
new cork, so the sk_msg program runs again on the rest.

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index b1071b0960cf5..788ce08eef4d7 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -544,6 +544,14 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>  			if (!cork)
>  				*copied -= free;
>  		}

[Severity: Medium]
This is a pre-existing issue, but what happens when tcp_bpf_sendmsg_redir()
fails for a cork here?

The ret < 0 path frees the whole sk_msg. It skips the *copied adjustment
because cork is true. The new restore check is then skipped because
msg->sg.size is 0, and the if (cork) block runs:

    sk_msg_free(sk, msg);
    kfree(msg);
    msg = NULL;
    ret = 0;

tcp_bpf_sendmsg() then returns copied > 0 ? copied : err with copied
unchanged. So sendmsg() reports success for bytes that this call put into
the cork and that were then thrown away. A non-cork message with the same
failure lowers *copied and returns the error.

Failures that can get here include -EPIPE when the target has no psock,
-EINVAL/-EPIPE from tcp_bpf_redir_allowed() in tcp_bpf_push(), -ENOMEM
from bpf_tcp_ingress(), and errors from tcp_sendmsg_locked().

The commit message says this stays unchanged ("If the redirect of a cork
fails, sendmsg() still returns success and frees it."). So does the earlier
patch "bpf, sockmap: Check the target of an egress redirect before each
send".

Should the cork case also subtract the freed bytes from *copied and keep
the error?

> +		/*
> +		 * The verdict was for tosend bytes. The rest goes back, unless
> +		 * another thread made a new cork while the lock was released.
> +		 */
> +		if (cork && msg->sg.size && !psock->cork) {

[Severity: Medium]
Is the tail still lost if another sender installs a new cork while the lock
is dropped?

Earlier in the __SK_REDIRECT branch, the cork is detached and the lock is
released:

    if (psock->cork == msg) {
        cork = true;
        psock->cork = NULL;
    }
    release_sock(sk);

A second thread in tcp_bpf_sendmsg() on the same socket then sees
psock->cork == NULL and uses the on-stack tmp. The first thread's call to
sk_msg_apply_bytes(psock, tosend) used up apply_bytes, so psock->eval was
reset to __SK_NONE and the prog runs on tmp. If the prog calls
bpf_msg_cork_bytes() with a size larger than tmp, the top of
tcp_bpf_send_verdict() allocates a new psock->cork.

When the first thread takes the lock again, this check is false. The
if (cork) block then frees the unsent tail with ret = 0 and does not reduce
*copied, and tcp_bpf_sendmsg() returns the positive copied count.

That is the symptom the commit message describes ("the rest is lost, and
sendmsg() reports it as sent"). The prog also never runs on those bytes,
although bpf_msg_apply_bytes() says it should.

The commit message acknowledges this ("If the psock has a new cork after
lock_sock(), the kernel still frees the rest"). The earlier patch "bpf,
sockmap: Check that the redirected message is the cork" also says corks are
not safe for two senders.

Is this case meant to stay out of scope, or should *copied at least be
reduced by the freed tail?

> +			psock->cork = msg;
> +			cork = false;
> +		}

[Severity: Critical]
This isn't a bug introduced by this patch, but putting the tail back here
adds a new way into a race that already exists in the SK_PASS branch. Can
a restored cork be freed while tcp_bpf_push() is still using it?

After this code runs, we reach more_data with psock->cork == msg. If the
next verdict is SK_PASS:

tcp_bpf_send_verdict()
    case __SK_PASS:
        if (!psock->apply_bytes)
            psock->eval = __SK_NONE;
        ...
        ret = tcp_bpf_push(sk, msg, tosend, flags, true);
            tcp_sendmsg_locked()
                sk_stream_wait_memory()
                    sk_wait_event()  <- drops and re-takes the socket lock

The cork stays in psock->cork during the push. A second sender in
tcp_bpf_sendmsg() can take the lock and pick it up:

    if (psock->cork) {
        msg_tx = psock->cork;

psock->cork_bytes is 0 and psock->eval is __SK_NONE, so the second sender
runs the prog on the shared msg:

- On SK_REDIRECT it detaches the cork, redirects it without the lock, and
  later calls kfree(msg).
- On SK_PASS it pushes the same element, then calls put_page() and
  sg_init_table() on it.

The first thread then wakes up in tcp_bpf_push() with stale sge, page, off
and size locals, and runs:

    msg->sg.size -= ret;
    sge->offset += ret;
    sge->length -= ret;
    ...
    if (!sge->length) {
        put_page(page);

Could this cause a use-after-free of the kfree()d sk_msg and a double
put_page(), and send the same bytes twice?

The earlier patch "bpf, sockmap: Check that the redirected message is the
cork" already says "a cork is still not safe for two senders on one
socket".

Would it fix this to detach psock->cork in the SK_PASS branch before any
push that can drop the lock, and attach it again under the lock afterwards,
as the SK_REDIRECT branch does?

[Severity: Medium]
This is a pre-existing issue, but now that the tail goes to more_data, can
some of the restored bytes get a different verdict than the program asked
for?

In the __SK_REDIRECT branch, the whole planned tosend is charged before
the redirect runs:

    sk_msg_apply_bytes(psock, tosend);
    if (!psock->apply_bytes) {
        /* Clean up before releasing the sock lock. */
        eval = psock->eval;
        psock->eval = __SK_NONE;
        psock->sk_redir = NULL;
    }

bpf_tcp_ingress() can move only part of it. Once one element has moved, a
later __sk_rmem_schedule() failure breaks out with ret == 0, because copied
is not zero:

    if (!__sk_rmem_schedule(sk, size, false)) {
        if (!copied)
            ret = -ENOMEM;
        break;
    }

For example, take an 8192-byte cork with apply_bytes 6144 where only the
first 4096-byte element moves. The prog run at more_data then decides all
4096 remaining bytes, including 2048 that the redirect verdict covered.

Non-cork messages already have the same accounting problem. Should
sk_msg_apply_bytes() be charged with the bytes actually sent rather than
tosend?

>  		if (cork) {
>  			sk_msg_free(sk, msg);
>  			kfree(msg);

[Severity: Medium]
This is a pre-existing issue in the selftests, but is there a test that
would catch the data loss this patch fixes?

The third case in test_txmsg_cork_hangs() in
tools/testing/selftests/bpf/test_sockmap.c reaches this path:

    txmsg_redir = 1;
    txmsg_apply = 4097;
    txmsg_cork = 4097;
    test_send_large(opt, cgrp);

With txmsg_cork set, msg_loop() waits only 300ms per select(). An
incomplete receive becomes errno = -EIO. The rx child in sendmsg_test()
then hides that error:

    if (err && err != -EDATAINTEGRITY && txmsg_cork)
        err = 0;

So the test passes both when the cork tail is freed (before this patch)
and when it is put back and sent (after this patch).

Could a test be added that checks how many bytes the peer receives?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102072112.4160195-1-alexei.starovoitov%40gmail.com
