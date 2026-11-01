Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793561950;
	b=WFAV/K+y8I3BurFnpka3eFON9RMGWsmDlzRDDvRBjaSAf64ibnZO4T5/hcot9nmYxN3E
	 wJdxogS0r5eaibaqqye1mjGUvxEVizMp0G+2y6OGeHm6uYe7tlYNPTOXzLpiBqU21PRFV
	 tQqBJYo5vKUm//Lg8RzC9QmGRxQ9g2Vq8ghikSD4814wsZW+6X7I6uD8TM+7dtVxIAe4c
	 DLRqDIhJInp9TFc9nUumW5u2+hn6DpXwdyMXg2ylRoFOycGyfD9Klt109/DffFe0a//u2
	 shsUxam34IxvazmPS5rpS5KDHPyDHYj/tM6RQAhJ6RbzPsVTC6OQTlb5j9Yi2hCRVZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793561950;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=eFd6KOabnWiebFmLCAzscPfD6b0ZJ8Xt/eedBcDRnj0=;
	b=gYWK8qcJcOUWctdNE7zNS9j+8YN25hPP576xYBQ/uiJV5hQENNaUFi77RsNMfXVSWRSc
	 ogxISmvnDeV4o3Zw4tZUQvx1j0QWYk3yUCS6d3QxU0pTCD0QC3i6ILmnfJU8jP0+KSrwp
	 DVuE8hPwk9CRUEuPFtRKnrrs5rPdwAv4Ek3hQMBlEUA3IKtU6ad88VC2TpWP3AlmoVm9b
	 rpWzSeykNlUJ/wVcE9y82kU9EUymvupudmMzzKiB5hFShNEFA373q9d0Pl/qRxqdDs2pa
	 +5eqCLsWFmbw6UXFc9E7VOLe2e3nzY8iKM2+2a+M73uybuEP1u0xu5ef736uLNWRVHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n1h8NX4d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7D3606A329;
	Sun,  1 Nov 2026 19:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n1h8NX4d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5601F00A02;
	Sun,  1 Nov 2026 19:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793561950;
	bh=eFd6KOabnWiebFmLCAzscPfD6b0ZJ8Xt/eedBcDRnj0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=n1h8NX4dijMw7k2N+JR33AFofCYVC62ewcoFeKBQJKIZRJkJ6JzhEC//C3fhD6PMS
	 XRxmBDH/UZzZs4FrEz3a2pDWa7ChswGMeZgplXJnBd+/x1YpN6xIfZxTRGYwtLidD2
	 jJNq1AuijIwgJ/1YvXrbOsTePXHm1muj9Bu0MAHy1R9Z6gCr2bpPkrDIqBApASH0cB
	 OF+631UAex3bUZ2wurH/Kga5hmMXLC7LaM8DKaS/gG82kyzO6/vqiB4zkgiZEVXy7k
	 sXOlh5z3wrb6xvMCOVDLOSGDHpwy++YHUS8aJQYe+QobDMRSkhrAb9lMVc0qk2w6PC
	 cB/M8C1mxqTag==
Content-Type: multipart/mixed; boundary="===============0240678656479494321=="
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Message-Id: <0dd29e75d62b7190a9808444743fc5dcebd3fd42ebff15602c7eef5a9313784f@mail.kernel.org>
In-Reply-To: <20261101192057.2296489-3-alexei.starovoitov@gmail.com>
References: <20261101192057.2296489-3-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 02/15] bpf, sockmap: Don't let an SK_DROP verdict stick
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org,netdev@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,john.fastabend@gmail.com,jakub@cloudflare.com,jiayuan.chen@linux.dev,davem@davemloft.net,edumazet@kernel.org,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,kuniyu@google.com,willemb@google.com,matttbe@kernel.org,mptcp@lists.linux.dev,mason@kernel.org,josef@toxicpanda.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  1 Nov 2026 19:39:09 +0000 (UTC)

--===============0240678656479494321==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, sockmap: Don't let an SK_DROP verdict stick

TL;DR: Resetting eval after an SK_DROP verdict may make sendmsg() return a
positive byte count instead of -EACCES for every dropped message; the fix is a
later patch, so should they be applied together?

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 8cf63a9e7fed..d90bcc911b36 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -509,6 +509,9 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>  	default:
>  		sk_msg_free(sk, msg);
>  		sk_msg_apply_bytes(psock, tosend);
> +		/* The verdict holds for apply_bytes, not for ever */
> +		if (!psock->apply_bytes)
> +			psock->eval = __SK_NONE;
>  		*copied -= (tosend + delta);
>  		return -EACCES;
>  	}

Now that an exhausted SK_DROP verdict resets psock->eval, the prog runs again
for each later message.  Does that make an older accounting problem in this
branch happen on every message instead of once per socket?

sk_msg_free(sk, msg) frees the whole message, but only tosend is subtracted
from *copied, and tosend is capped to psock->apply_bytes:

	tosend = msg->sg.size;
	if (psock->apply_bytes && psock->apply_bytes < tosend)
		tosend = psock->apply_bytes;

Take a prog that calls bpf_msg_apply_bytes(msg, A) and returns SK_DROP, and a
sender whose sendmsg() calls each carry S > A bytes in one sk_msg.

Before this patch:

- call 1 ran the prog (apply_bytes = A), set tosend = A and returned S - A;
- eval then stayed __SK_DROP with apply_bytes = 0, so calls 2..N used
  tosend = S, *copied went to 0, and tcp_bpf_sendmsg() returned -EACCES.

After this patch, eval is reset once apply_bytes reaches 0.  Every later call
runs sk_psock_msg_verdict() again, which sets psock->apply_bytes =
msg->apply_bytes = A, so tosend = A again.  Every sendmsg() then returns
S - A > 0 even though all S bytes were freed and none were sent.  Userspace
sees partial success on each message instead of -EACCES.

The subtraction itself predates this patch.  The sticky verdict hid it after
the first message, and this change exposes it on every message.  A backport
of this commit alone would change sendmsg() return values from -EACCES to
positive byte counts for such progs.

A later patch in this series, f54ec6a22738 ("bpf, sockmap: Subtract all
dropped bytes from the return value"), fixes this by subtracting the return
value of sk_msg_free() plus delta instead of tosend + delta.

Should the two patches be applied (and backported) together?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41341848185
--===============0240678656479494321==--
