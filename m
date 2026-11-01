Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793562685;
	b=PhnE6dVc47/w5Nizpap9nFDa8K6wpyrQ4GgEru/EfPjJJuSCOsCgsSEbDZfIF4tQJbhi
	 U55wegYPr7xeBudK33Q+f/dGuMHyjEUeNT1wBFKFu9x4XhuPlgnTSt98QxX9mB2LKHRIN
	 KxuYv8zgPjpJ1PMNixENr8+nfJ4iBPNbXxzQYKqRssOJiivb48Wff4yGTD/lmi4ZpE+p0
	 1c56wstqmey0B0/0dFgO6SNb2iMD7o5btp8nj/jykuv3d9Nq+0Sioech0ayp2JhYDfk35
	 RuLSRI7F0I+JCwomYcvCUVNvxHEJr8mS7D6JdWfhYMy+jbugIx6cijwOf1WVGta/y2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793562685;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=iokjdG797FeXAQ+3Wfvw3+QOdB4W3f5YjOsI6N9Kb0Q=;
	b=vMq1KKTHxk5qjQyxEXtV1sZtRvHDLrGqr9vRRh7nS6N0GM/38AwmjIByBGoz1rXR2/pS
	 rP+4WQuyv1jvpOh1xZsC7h8MOi+V+yi5+1qibbBPGIntuj5OAf2NbDPaXQmM4oNuMw1Ss
	 SMRELR9x+o13RNfQebRDSn9ErM2SWVDhINBvdz6cr60HKbTK/Ds1oxHB4g31fPFBovhGE
	 3PBihEFmWNZpLU+/V5igA5cmy+i6WNH3k0yhoPkykhP94YYJM0/qHwimMDiF5Q54akOR5
	 tqo3RLmUvLk6i8P/5wUx8OyKD7tH17kuGJjtdeXbb2omI73RXuw57M1xr3z47k26JzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A7O0MnEH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1782606A324;
	Sun,  1 Nov 2026 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A7O0MnEH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFA31F000C1;
	Sun,  1 Nov 2026 19:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793562684;
	bh=iokjdG797FeXAQ+3Wfvw3+QOdB4W3f5YjOsI6N9Kb0Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=A7O0MnEH04CJBIzfVp5dIwmgAKMysCUExppUil1YQyVi2ft4BI4Sj115oIJRvmSaE
	 hou19H38rZA3oX5DP8le1v5MxyzcrP/Wwfj467kMUxp86TgHnKyue5/UtzypyNIzDs
	 MVP2osV/Hdyr3KgSofc4+Pz/jWm/559fA0ncphg00E4FyLewOfuG7NZnLhYzg2LGSu
	 2bjRvknPt0YYCnEs4SEhLpuYaaXgwax242463Y+Q14qAwP7B9edw/ElnB7JgZ8BKct
	 0ZG1+lVs3NB4X+TEOzkAmHFzPWNES8fDickrxJPCRyd7VTSCEUO6cHUsAbY+iqAM2U
	 hXrspO/HHixfA==
Content-Type: multipart/mixed; boundary="===============6389611518320040191=="
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Message-Id: <052f66e46ffaaf2f61af6d5b54b9b3f817ae40f75f1d623ff49e46544411bd82@mail.kernel.org>
In-Reply-To: <20261101192057.2296489-4-alexei.starovoitov@gmail.com>
References: <20261101192057.2296489-4-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 03/15] bpf, sockmap: Don't let an SK_PASS verdict cover the next message
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,john.fastabend@gmail.com,jakub@cloudflare.com,jiayuan.chen@linux.dev,davem@davemloft.net,edumazet@kernel.org,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,kuniyu@google.com,willemb@google.com,matttbe@kernel.org,mptcp@lists.linux.dev,mason@kernel.org,josef@toxicpanda.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  1 Nov 2026 19:51:24 +0000 (UTC)

--===============6389611518320040191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, sockmap: Don't let an SK_PASS verdict cover the next message

TL;DR: In tcp_bpf_send_verdict(), if a failed push races with another sender,
the new apply_bytes subtraction may reach 0 with eval still set, so the next
message could skip the BPF program.

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index d90bcc911b36..072ffd8347a6 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -457,8 +457,14 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>  
>  	switch (psock->eval) {
>  	case __SK_PASS:
> +		/* The push may sleep without the socket lock, and it may fail */
> +		if (!psock->apply_bytes)
> +			psock->eval = __SK_NONE;
> +		origsize = msg->sg.size;
>  		ret = tcp_bpf_push(sk, msg, tosend, flags, true);
>  		if (unlikely(ret)) {
> +			/* A part of it may have gone out */
> +			sk_msg_apply_bytes(psock, origsize - msg->sg.size);
>  			*copied -= sk_msg_free(sk, msg);
>  			break;

Can this subtraction bring psock->apply_bytes down to 0 while psock->eval is
still __SK_PASS?

The break skips the tail of tcp_bpf_send_verdict(), which is the only place
the __SK_PASS path resets eval once apply_bytes reaches 0:

    if (likely(!ret)) {
        if (!psock->apply_bytes) {
            psock->eval =  __SK_NONE;
            ...

With a single sender this looks fine, since a failed tcp_bpf_push() sends
fewer than tosend bytes and tosend <= apply_bytes.

However, tcp_bpf_push() can drop the socket lock in sk_stream_wait_memory(),
and eval is deliberately left at __SK_PASS during the push when apply_bytes
is not 0.  Another sender can lower psock->apply_bytes in the meantime, so
origsize - msg->sg.size is subtracted from a stale value and
sk_msg_apply_bytes() clamps the result at 0.

Example with a prog that calls bpf_msg_apply_bytes(msg, 1000) and returns
SK_PASS:

  Thread A: sendmsg(4000), prog -> SK_PASS, apply_bytes = 1000, tosend = 1000
            eval stays __SK_PASS (apply_bytes != 0)
            tcp_bpf_push() queues 600 bytes, then blocks in
            sk_stream_wait_memory() and drops the socket lock
  Thread B: sendmsg(500), eval == __SK_PASS so the prog is not run
            push succeeds, sk_msg_apply_bytes(psock, 500) -> apply_bytes = 500
  Thread A: wakes up with a signal or SO_SNDTIMEO expiry, push fails
            sk_msg_apply_bytes(psock, 600) -> apply_bytes = 0 (clamped)
            break, eval is still __SK_PASS
  Next sendmsg(64K): eval == __SK_PASS, so the prog is not run
            apply_bytes == 0, so tosend = msg->sg.size
            the whole sk_msg is pushed without a verdict from the prog

Before this patch the failure path did not touch apply_bytes, so it stayed at
500 after the same interleaving.  Only 500 bytes of the next message escaped
the prog, then the tail reset eval and goto more_data ran the prog on the
rest.  With this patch the whole next sk_msg escapes, which is the situation
the commit message says it is meant to prevent.

The new early reset also seems to open a second way in:

    if (!psock->apply_bytes)
        psock->eval = __SK_NONE;

While A sleeps, B sees eval == __SK_NONE, runs the prog, and installs its own
verdict V (pass, redirect or drop) with apply_bytes = M.  If A's push then
fails, A subtracts its sent bytes from B's apply_bytes.  If that reaches 0, V
is left in psock->eval with apply_bytes == 0, and the next message is passed,
redirected (psock->sk_redir is still held) or dropped whole without the prog
running.

On A's success path, the existing sk_msg_apply_bytes(psock, tosend) and the
tail reset likewise cut B's verdict short by A's bytes, which B's verdict
never covered.

Should the failure path reset psock->eval (and clean up psock->sk_redir as
the tail does) when apply_bytes ends up 0?  Or could it skip the subtraction
when this thread already gave up the verdict before the push?

No later patch in this series changes the __SK_PASS failure path.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41341848185
--===============6389611518320040191==--
