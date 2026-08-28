Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116A8232395
	for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 04:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787890718; cv=none; b=lSxAGaN2IwjKdY2/VkInHrK8/nQ+tjM1ufoaZdS4Z575z4vHoCZ31IY9/f+AyGG7v9k31FfL/gRhDXkZtXkFPkyhQ1/6bpE/O1KFb/vLsfN7GUeL0NHdoenjynUMs4z87z8VTWxNrqjQ+k9BlsFAEgOBhMSXk2ZjLX1Zi1t1BgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787890718; c=relaxed/simple;
	bh=1uvI92t8mUN9TrFUVSWv5CrwtqcjyRMZIggnEtqW7Ws=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b/eYx9V4f2OVOe3vXwh8ZagcJgtQoAAEnVxZ8pSoqYbbLGvnARgn8gGD1wATc/Ah6v/S4wrYaECwCkRk9VoAdoVM/CDC1hWN/1O7TC7yeKachZtv44bk/qruNkxH+DhQ/Vutw0Bg5dGbKa6M6ruMpuDKvBbIXKMzp+eL8Fw8faM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHko5+S6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHko5+S6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736CE1F000E9;
	Fri, 28 Aug 2026 04:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787890716;
	bh=Tmy28aWd1rucuQvwAFaCS76WiPm7tIHBib8XcZmjuO8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XHko5+S6s6m+0CukBbAYUkU8a0unxfiRfJXANoItYytvVEm4PzRkGDKum1IiS0+Wo
	 2hGLKcIHQJE9Iz44rzOUn4YKHTdO4hHfosR5Nhee3ZAZ+k+ex8ng6OJ1TM+hqNCtTt
	 sM3cfq+GzRESIcOvzEpfeteeHSkJFjSWrObarnKU6lRYSSTwr21G7CYhxqCDC58KQo
	 1QzYLDhHlEmVcxALALLaZm0SXxRe9vnNjkkw72/7OzfZ7ilNnxp3qhBRrupwhRDzFM
	 kdgIJdqJTQS0IYX82ohoKp4sC0imBfDAanEJdAO6MbjMv8Oj6DY+ICuLu+wKxSxxH8
	 6Er729Q5d0B5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH mptcp-next v10 2/9] mptcp: drop the cant_coalesce CB
 field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: mptcp@lists.linux.dev
In-Reply-To: <e444cb860c2b880a1db6cdea3ddfa98a55163760.1787888115.git.tanggeliang@kylinos.cn>
References: <cover.1787888115.git.tanggeliang@kylinos.cn>
 <e444cb860c2b880a1db6cdea3ddfa98a55163760.1787888115.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 04:18:35 +0000
Message-Id: <20260828041836.736CE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] A race condition in `__mptcp_move_skb` causes premature consumptio=
n of the `rcvd_dummy_seq` flag and a stale read of `msk->ack_seq`, permanen=
tly corrupting the fastopen SKB sequence mapping.
--

commit 4b77d7da2be72a2e1f480d6176376b2e639e2faa
Author: Paolo Abeni <pabeni@redhat.com>

mptcp: drop the cant_coalesce CB field

This patch removes the cant_coalesce field from the MPTCP SKB control block.
It replaces synchronous updates at 3rd ACK time by synchronizing the fastop=
en
skb sequence when the IASN becomes available, before the next segment enters
the msk receive queue.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 7421b44934f05..0a90bed02b412 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
[ ... ]
> @@ -446,6 +464,12 @@ static bool __mptcp_move_skb(struct sock *sk, struct=
 sk_buff *skb)
> =20
>  	mptcp_borrow_fwdmem(sk, skb);
> =20
> +	/* Be sure to sync the eventual fastopen dummy mapping before any other
> +	 * skb lands into the msk.
> +	 */
> +	if (unlikely(msk->rcvd_dummy_seq))
> +		__mptcp_sync_rcv_sequence(sk);
> +
>  	if (MPTCP_SKB_CB(skb)->map_seq =3D=3D msk->ack_seq) {

[Severity: High]
Does this execute the sync logic unconditionally without waiting for the
MPTCP_SYNC_SEQ flag or a memory barrier?=20

If a concurrent mptcp_release_cb() processes the backlog while the 3rd ACK
is being processed, could this lead to a stale read of msk->ack_seq?

Since __mptcp_sync_rcv_sequence() reads the uninitialized ack_seq and clears
rcvd_dummy_seq, it appears this might permanently corrupt the fastopen SKB
sequence mapping, leading to data loss or connection stall during TCP Fast
Open.

Could this be triggered remotely by sending an MP_JOIN SYN and data before
the 3rd ACK of the initial MPC connection?

[ ... ]
> @@ -3895,6 +3919,13 @@ static void mptcp_release_cb(struct sock *sk)
>  			__mptcp_error_report(sk);
>  		if (__test_and_clear_bit(MPTCP_SYNC_SNDBUF, &msk->cb_flags))
>  			__mptcp_sync_sndbuf(sk);
> +		if (test_and_clear_bit(MPTCP_SYNC_SEQ, &msk->cb_flags)) {
> +			/* Ensure we see the updated ack_seq after seeing
> +			 * the flag
> +			 */
> +			smp_rmb();
> +			__mptcp_sync_rcv_sequence(sk);
> +		}
>  	}
>  }

[Severity: High]
While the correct synchronization with the memory barrier is placed here,
is it rendered ineffective because the rcvd_dummy_seq flag was already
prematurely consumed by the unguarded call in __mptcp_move_skb()?

Since __mptcp_sync_rcv_sequence() skips processing if rcvd_dummy_seq is
false, the proper sequence mapping might never occur if the flag is cleared
early.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787888115.gi=
t.tanggeliang@kylinos.cn?part=3D2
