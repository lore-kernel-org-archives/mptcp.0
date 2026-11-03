Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741879;
	b=Wwn/0yTJEx/vxlswl53v2sxhJoo3V7P6eAJcjfP13nxj7m5M4zpKxOg4U5c6XpXcPYtP
	 4T+t8UCgstZcWi2+3LIMFxicLoJzOLbyJT+Jiyv3UzO5TPywptny7gF/M117M8ZCCs2eI
	 c1A3S3ZiWLbxk98BFqK4BbPk+aFfAIoDTZLDa5OESSfXalbXLxF3KcKFyCf3QSCvAkYyn
	 lcYIKuf2AA18kwlbzySgirpP2VeVwu9COUSfWcv6O1R8DBbihosF4JgsqdQWCI+9SRAxJ
	 WMun4zYe60NxEcV0crAA/rh+vJqmi12JZEpQFm8STZmRXKf49V54CHrR2j5dvHh9rXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741879;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uyJDo7OV7DfHD/HxsDJJ2zC/feoJdSr9R7W6gWr18ck=;
	b=XeOeCm6QX6AZGBqzUzmZJVevU5yRDntIqMrxFkcEsuicldtf6jPpzzN52KrEL+s9eR0l
	 BfpL+kupRIKDBD+nl8bjkOYgrL1fx+pKiwrrMnwElmz/+Wf0NiWuF2FUalptniXnMow2Z
	 SMTwegw8QbcO2ve0jaNfMbvsHe9/HHTWJMhohVWR03RqI9b4vckcaHx5zGQwWvLfQ1pYF
	 5CX0sb7KYQavkxe2lcPqhYnL3QHdhMq3sTyFqDRIPoT2Ovo2elJCQTzZz1HQbIBWdT8Jo
	 xxlUtz4lOPZ8726nelxh7KhRxsL/779jxx0O1KamgjiTxiDaHmoYxOgVoNhYs1bJ8YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hIJArRi2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9512606A31B;
	Tue,  3 Nov 2026 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hIJArRi2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB691F000C1;
	Tue,  3 Nov 2026 21:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741878;
	bh=uyJDo7OV7DfHD/HxsDJJ2zC/feoJdSr9R7W6gWr18ck=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hIJArRi2YVu09RgrD/mUwF8RfI9DkQ9kkT6QVdGMxl/dlcT/A8K/spx2KN5HGHyP9
	 iGkLckfXrhuhi3aLIgNRuGPoAkZDPNkEtmNmZSD4oOHrbExzJxlZk/DeSMgxbF6eU1
	 SUnRvoqOYDNKJCc273KMtIUj2Idk5zjf8L5JN2tpymzlIdATbZfJZ7GGDGLVCJ+8LI
	 BhEVijWe0vNrBCF7yYojkNzCAV+SwSb3PofPuCBbN/NSG5FLsNBFXQi8EJNKX4+Hug
	 mL4ZBUb+iLKPyHjzCiVqC/7Gmgp1FU4NMo+FN+J+Uc9c7ilZIvAxOLKflKL0ImkyzK
	 lCGf2wqKmUxnw==
Subject: Re: [PATCH bpf v2 03/15] bpf, sockmap: Don't let an SK_PASS verdict
 cover the next message
From: netdev-bot+sashiko@kernel.org
To: alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, kuniyu@google.com, willemb@google.com, matttbe@kernel.org,
 mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com
Date: Tue, 03 Nov 2026 21:37:57 +0000
Message-ID: <179374187706.488855.8366350890804573396@kernel.org>
In-Reply-To: <20261102072112.4160195-4-alexei.starovoitov@gmail.com>
References: <20261102072112.4160195-4-alexei.starovoitov@gmail.com>
X-sashiko-severity: Critical
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 1 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] Use-after-free of psock->cork.
- [High] The fix is incomplete when the verdict has a byte budget
  (psock->apply_bytes != 0).
- [Medium] The patch resets eval early, which lets one sender's bytes be
  charged against another sender's verdict and end that verdict early.

--

bpf, sockmap: Don't let an SK_PASS verdict cover the next message

This commit changes the __SK_PASS branch of tcp_bpf_send_verdict(). When
psock->apply_bytes is 0, it now resets psock->eval to __SK_NONE before
tcp_bpf_push(). When the push fails, it subtracts the bytes that went out
from apply_bytes and ends the verdict if apply_bytes reaches 0.

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index d90bcc911b36b..b016aa419fb2d 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -457,8 +457,22 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>  
>  	switch (psock->eval) {
>  	case __SK_PASS:
> +		/* The push may sleep without the socket lock, and it may fail */
> +		if (!psock->apply_bytes)
> +			psock->eval = __SK_NONE;

[Severity: High]

When psock->apply_bytes is not 0, eval stays __SK_PASS during the push.
The budget is still debited only after tcp_bpf_push() returns. Can a
second sender on the same socket still get past the prog here?

This call chain releases the socket lock:

tcp_bpf_push()->tcp_sendmsg_locked()->sk_stream_wait_memory()->sk_wait_event()

While sender A sleeps there, sender B can enter tcp_bpf_send_verdict(). B
sees eval == __SK_PASS, so the prog doesn't run, and B computes its tosend
from the budget before A's bytes are taken out:

	tosend = msg->sg.size;
	if (psock->apply_bytes && psock->apply_bytes < tosend)
		tosend = psock->apply_bytes;

A's bytes are subtracted only later, by sk_msg_apply_bytes(psock, tosend)
on success or by the new sk_msg_apply_bytes(psock, origsize -
msg->sg.size) on failure.

If both pushes succeed, a verdict that bpf_msg_apply_bytes() limited to N
bytes covers up to 2N bytes. If A's message alone uses up the budget, B's
message is the next message, and it passes without running the prog.

The commit message says:

    When apply_bytes is not 0, eval stays __SK_PASS during the push, and
    the prog does not run for another message, as today. The verdict must
    still cover the bytes that a failed push does not send. But such a
    message also lowers apply_bytes.

But B's message is sized against the budget before A's in-flight bytes
are removed from it. Would it be better to reserve the budget before the
push? That means debiting tosend, and ending the verdict when the budget
reaches 0, before calling tcp_bpf_push(), instead of subtracting after a
failure.

The __SK_PASS branch also looks unchanged at the end of the series.

> +		origsize = msg->sg.size;
>  		ret = tcp_bpf_push(sk, msg, tosend, flags, true);

[Severity: Critical]

Can another sender free msg while this push sleeps?

msg can be psock->cork here. tcp_bpf_sendmsg() picks it up with:

		if (psock->cork) {
			msg_tx = psock->cork;

The __SK_REDIRECT branch detaches psock->cork before release_sock(). The
__SK_PASS branch leaves it attached during tcp_bpf_push(). tcp_bpf_push()
keeps sge and page pointing into the cork's sg ring across
tcp_sendmsg_locked(), and that call can sleep in sk_stream_wait_memory()
without the socket lock.

With this patch and apply_bytes == 0 (the default), eval is __SK_NONE
during that sleep. Sender B can take the lock, reuse the same psock->cork,
append to it, and run the prog on A's partly sent cork. If the prog
returns SK_REDIRECT, B's __SK_REDIRECT branch does:

		if (psock->cork) {
			cork = true;
			psock->cork = NULL;
		}
		...
		if (cork) {
			sk_msg_free(sk, msg);
			kfree(msg);

When A resumes, tcp_bpf_push() writes into the freed struct sk_msg:

		msg->sg.size -= ret;
		sge->offset += ret;
		sge->length -= ret;

It may also retry with, or call put_page() on, a page that was already
released. If the push failed, the new failure path reads msg->sg.size and
calls sk_msg_free(sk, msg) on the freed object.

If B's prog returns SK_DROP instead, sk_msg_free() in the __SK_DROP branch
drops page references that A is still using.

The shared-cork problem with two PASS senders already existed. The kfree()
variant used to need a third sender to end a byte-limited verdict. The
early reset makes it reachable with only two senders.

The later commit "bpf, sockmap: Check that the redirected message is the
cork" also says that "a cork is still not safe for two senders on one
socket". The __SK_PASS branch is unchanged at the end of the series.

Is it safe to reset eval here while psock->cork is still attached and
being pushed?

>  		if (unlikely(ret)) {
> +			/* A part of it may have gone out */
> +			sk_msg_apply_bytes(psock, origsize - msg->sg.size);
> +			/* Another sender can use up the rest during the push */
> +			if (!psock->apply_bytes) {
> +				psock->eval = __SK_NONE;
> +				if (psock->sk_redir) {
> +					sock_put(psock->sk_redir);
> +					psock->sk_redir = NULL;
> +				}
> +			}

[Severity: Medium]

With the early reset, can sender A's bytes be charged against a verdict
that another sender installed?

When apply_bytes is 0 on entry, A's tosend is its whole message. eval is
now __SK_NONE while A sleeps in tcp_sendmsg_locked(). Sender B can take
the socket lock and run the prog, which installs B's verdict:

net/core/skmsg.c:sk_psock_msg_verdict() {
    ...
	psock->apply_bytes = msg->apply_bytes;
	if (ret == __SK_REDIRECT) {
    ...
		psock->sk_redir = msg->sk_redir;
		sock_hold(psock->sk_redir);
    ...
}

If B's apply_bytes is larger than B's message, B's verdict (PASS, DROP or
REDIRECT) stays active with some budget left. When A resumes, it
subtracts its bytes from B's budget, even though A's own verdict had no
byte limit. On success that happens through the unchanged
sk_msg_apply_bytes(psock, tosend). On failure it happens through the new
call above.

If that brings apply_bytes to 0, either this new block or the common block
at the end of tcp_bpf_send_verdict() sets eval to __SK_NONE and drops
psock->sk_redir:

	if (likely(!ret)) {
		if (!psock->apply_bytes) {
			psock->eval =  __SK_NONE;
			if (psock->sk_redir) {
				sock_put(psock->sk_redir);
				psock->sk_redir = NULL;
			}
		}

That ends B's verdict before it has covered the bytes B's prog asked for.
Later bytes that should have been dropped or redirected get a fresh prog
run instead.

Before this patch, eval stayed __SK_PASS during A's push, so this needed a
third sender. Could A record locally whether its verdict had a byte limit
on entry? Then it would touch psock->apply_bytes, eval and sk_redir only
when that is true and the verdict is still its own.

>  			*copied -= sk_msg_free(sk, msg);
>  			break;
>  		}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102072112.4160195-1-alexei.starovoitov%40gmail.com
