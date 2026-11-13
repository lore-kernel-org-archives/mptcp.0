Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600543;
	b=Iq2vr1gIfovIysH9iguKcBYgW8HvNoT0jY+OtO5yZh4/qkabDdDjtSj/r920wNWUlMXT
	 yU3Np8SYlRBm0btuvx9MN5CckTzQY/i/WP90yjjNOTJyhDKx6X9hSMCMUI5fpAer4wDpt
	 JDY/+S1yfoV4AWgJxXZ6EV4lmB8kOCFERrEzUMJcG/qVxdV6UOl6D4ssrgYOeQzBMHyas
	 +/fOv8tqMydxBOkRzMELOHfa7qYgVhjS7pxmfOXnxWfdZuHPq1oK87VAvxG9Es+lks5Um
	 4I3N+2YGp4vxbDbF8+9tN45nosMasZU31Ej8vxxI/fQb61HosxMfXW+ew1pftvz3cvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600543;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7kzwSSLXuXQxsvNZCFJAdvJ/NOpZiwmegi2MqUHBXFE=;
	b=OKVDq9U9M23846YgdlcBwRD6grSCMUGPSoSa1KBhTJGJmv7Yz5HtISD31OqDicY64gAQ
	 LFh98rVbezPxQFxn4p3aptnUsdrRlAFgrfFb7hVIAXXs1tLqIgwH7nFZWF5yzjArbKAIa
	 tgWIqix/4vUuckN4QoIfmT9yJxmk75rTxiEZIrMbYSPdTbk+i2dKUJuB5UWUZUmrHY8aN
	 yn+AhlveQyJ/bqr3qxwtt5VmplRm/mxEyMt6eQQSf+iVBwCQpFIug1hzc4SIRWl4SwtGZ
	 9Awb0v7TrWyTfUquJiq3Q8dNCZ3MpVhZIRGG0BYewvVYz6rgS7TZxn4RAfVRrmBwnyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PDweu/OR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A01606A891
	for <mptcp@lists.linux.dev>; Fri, 13 Nov 2026 20:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PDweu/OR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263991F000CB;
	Fri, 13 Nov 2026 20:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600543;
	bh=7kzwSSLXuXQxsvNZCFJAdvJ/NOpZiwmegi2MqUHBXFE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=PDweu/ORW758JdonUirWm8kUga8NnBlgpS7GiRH3DIwb0ykMpaebbQrHgof3rXzYK
	 hMHg8UypSJbNpktENigfgYwv6kJFhv2bFS98UIU5bRBR+en9tkwWUOkZrqonestblX
	 6fI7t5SQcQMeDshd5YL4IYlXNOskfrsI0mmX7vvwOtFp33GnqFTWjIykvcKmrlduG8
	 sew13oABXfw4KC+Mn4Ryy4JCrnWeW11a07mlbTalKBRj0gK/JkUzspMXi6+qyqXri0
	 d4nLlsa9/nNWhhZx1R9+M789b4fC+tCmTzchiP8KruSMVokXD9EizyYSw1k4vcySR8
	 kpk4XvsQ//rfQ==
Message-ID: <sashiko-outbox-213616@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-net 08/34] mptcp: force the charge for the first
 skb of a subflow
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWF0dGhpZXUgQmFlcnRzIChOR0kwKQ==?= <matttbe@kernel.org>, "MPTCP
 Linux" <mptcp@lists.linux.dev>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-8-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f@kernel.org>
 <20261113-mptcp-cmason-fixes-v1-8-9205b77e9a2f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:09:02 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] mptcp: cross-subflow state leak in __mptcp_push_pending()
  [1]
--

commit 045933b0c1ae73b56c16499f1fb80d8244a44751
Author: Chris Mason <mason@kernel.org>

mptcp: force the charge for the first skb of a subflow

This commit forces the memory charge when allocating the first skb on an
empty MPTCP subflow and uses tcp_wmem_schedule() to bound the payload copy
when charging subflow write memory in mptcp_sendmsg_frag().

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index dc8cdda31a984..8d6ed293f6e58 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
[ ... ]
> @@ -1449,6 +1453,7 @@ static int mptcp_sendmsg_frag(struct sock *sk, stru=
ct sock *ssk,
>  	bool reuse_skb =3D true;
>  	struct sk_buff *skb;
>  	size_t copy;
> +	int avail;
>  	int i;
> =20
>  	pr_debug("msk=3D%p ssk=3D%p sending dfrag at seq=3D%llu len=3D%u alread=
y sent=3D%u\n",

[Severity: Critical]
This problem wasn't introduced by this patch, but can __mptcp_push_pending()
leak stale info.mss_now and info.size_goal across subflows [1] when
mptcp_sendmsg_frag() returns early?

__mptcp_push_pending() shares a single struct mptcp_sendmsg_info across its
subflow loop without resetting it when switching subflows:

net/mptcp/protocol.c:__mptcp_push_pending() {
	struct mptcp_sendmsg_info info =3D {
				.flags =3D flags,
	};
    ...
		mptcp_for_each_subflow(msk, subflow) {
			if (READ_ONCE(subflow->scheduled)) {
    ...
				if (ssk !=3D prev_ssk) {
					if (prev_ssk)
						mptcp_push_release(prev_ssk, &info);
					lock_sock(ssk);
				}
    ...
				ret =3D __subflow_push_pending(sk, ssk, &info);
				if (ret <=3D 0) {
    ...
					continue;
				}
    ...
	if (ssk)
		mptcp_push_release(ssk, &info);
}

After mptcp_sendmsg_frag() populates info.mss_now and info.size_goal for one
subflow, a subsequent subflow can fail in mptcp_sendmsg_frag() at
!__tcp_can_send(ssk) before tcp_send_mss() overwrites those fields.  When
mptcp_push_release() runs for that second subflow, it sees the first
subflow's non-zero info.mss_now and calls tcp_push() with the wrong
mss_now and size_goal, causing tcp_write_xmit() to segment queued frames
with another subflow's segment size and exceed the path mtu.

[1] https://sashiko.dev/#/bug/linux-3f08f285-058d-4038-8cd3-6d287fea7814

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-mptcp-cmas=
on-fixes-v1-0-9205b77e9a2f@kernel.org?part=3D8
