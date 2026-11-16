Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794800668;
	b=2LH1WJxJ8nH/U0R7awj+qj36zJffueZWqMfwgiOzErDqCHCZ9Tr9LNWVG60KyywSrrl6
	 D9ybK7kooBlLcCb4hbxdZCUrKlYsjHYpZBrGhndUlC9SFQ0qtUzA7QiDDCQncMYCQetWd
	 uDWCizQzghRAXYd65F5Bq4PZs7EMPBVHHK9WAZzb61+oQw6mpbcIux/5/nBxmQyAoOrNX
	 DX1qUdRU3NF/Fg5a3V7sYwrtjbDOq9VOFASjNZxFNWcl7+5uOIB1R1hdhV6rwpfTqFn0n
	 u8f197cECTRsKz26gnCm1+kiljHv7w2OJwuVJKD/ED6diYed4vVI7xhlRMwFg4uVaFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794800668;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=XiZLhiFFfGTENYl+DbaRP8pQINI0LXElgMzJrkISORc=;
	b=r4zbaYXO97sF357UuwGe0whSuLhfVsXdLgj5tSMMjV6GRmKU/KdBdhher1TQPOl0Nzg/
	 set3q3QeA168LPrI/V2s/AgrYe54PHnZJ/DJtAAUnB8YnJyBt6Inrg4ql1sksD/1f3t5e
	 Dl3zbZJrHTPPEeRc/RP3W3ss1nFjXIx404bad50/qD/Ax/UKK90tMr6G/XZ739S7GW6jL
	 azPGkZXBOLtDLyMrIoTPTaR4wjS9BUpxe5BWWjcHkDFXrFE5chmWupozg8pBplu8UbpQG
	 bApivgj/tFbpAmAAkixHuousRprqsjv0B3ZvmJEQDtqdeTRWUippUr13VwoQ9Mg/yhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LirT322E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571CE606A31F
	for <mptcp@lists.linux.dev>; Mon, 16 Nov 2026 03:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LirT322E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF3F91F000CD;
	Mon, 16 Nov 2026 03:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794800668;
	bh=XiZLhiFFfGTENYl+DbaRP8pQINI0LXElgMzJrkISORc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LirT322ElG/zu47YjjP9z+DyMcUsx41jx6aY/LtPhSVuo3ZGwZZFbPJ2i8fqjnrG/
	 fKYHG4kkQ02tnaYxdu4TAmHdqXDsdjQDLTobODV45b2xh2E6ppd29UnPwZKZe9Rvjo
	 bgi5erJcVnXGeYljQFAw5cz9fYNX0VRZ0lVglLz7IafRpGkOBfL0EV3dAxd55U/69V
	 h5ori7rTefo1nbEc03l9ZkQyKNfuu1sfnVUD0ccc6MlsnWZymYW8pgG7GTEy7sZrGI
	 QpWvXfuDeHqYnEGfS/9HFb+itVYRTvvmpQ9jS7IUPtipWuHbyF077WBo+P8cu5tQLD
	 o/v0MzwnKglQg==
Subject: Re: [PATCH mptcp-next v27 6/8] mptcp: remove CB offset field
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Mon, 16 Nov 2026 03:44:27 +0000
Message-ID: <179480066751.3133.13797616529803421975@kernel.org>
In-Reply-To: <879f04c4a89da0b3e8bcc7fd484744be5851f17e.1794663678.git.tanggeliang@kylinos.cn>
References: <879f04c4a89da0b3e8bcc7fd484744be5851f17e.1794663678.git.tanggeliang@kylinos.cn>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Incomplete conversion of the MPTCP CB sequence fields mixes
  two different keys in the out-of-order (OFO) queue.

--

mptcp: remove CB offset field

This patch replaces the per-skb CB offset field with a new msk-level
copied_seq, which tracks how far the reader has consumed data. In
mptcp_init_skb(), map_seq is now stored as the mapped DSN minus the
subflow offset, and skbs with a non-zero offset are tagged with
MPTCP_SKB_CB_F_OFFSET. New mptcp_dsn() and mptcp_end_dsn() helpers
compute the real DSN range for receive path users.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 41fc2429d2fed..f4ab3bdd368f2 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c

[ ... ]

> @@ -305,8 +306,8 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
>  	u64 seq, end_seq, max_seq;
>  	struct sk_buff *skb1;
>  
> -	seq = MPTCP_SKB_CB(skb)->map_seq;
> -	end_seq = MPTCP_SKB_CB(skb)->end_seq;
> +	seq = mptcp_dsn(skb);
> +	end_seq = mptcp_end_dsn(skb);
>  	max_seq = atomic64_read(&msk->rcv_wnd_sent);

[ ... ]

> @@ -362,8 +363,8 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
>  			p = &parent->rb_left;
>  			continue;
>  		}
> -		if (before64(seq, MPTCP_SKB_CB(skb1)->end_seq)) {
> -			if (!after64(end_seq, MPTCP_SKB_CB(skb1)->end_seq)) {
> +		if (before64(seq, mptcp_end_dsn(skb1))) {
> +			if (!after64(end_seq, mptcp_end_dsn(skb1))) {
>  				/* All the bits are present. Drop. */
>  				mptcp_drop(sk, skb);
>  				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);

[Severity: Medium]
The commit message says:

  "Throughout the receive path, direct accesses to
  MPTCP_SKB_CB(skb)->map_seq and end_seq are replaced with calls to
  mptcp_dsn() and mptcp_end_dsn()."

mptcp_init_skb() now stores map_seq as mptcp_subflow_get_mapped_dsn()
minus offset. Can the raw MPTCP_SKB_CB(skb1)->map_seq still be used as a
DSN in this function?

The end checks were converted to mptcp_end_dsn(skb1). The rbtree descent
and the partial-overlap test still read the raw field:

mptcp_data_queue_ofo() {
    ...
		if (before64(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
			p = &parent->rb_left;
			continue;
		}
		if (before64(seq, mptcp_end_dsn(skb1))) {
			if (!after64(end_seq, mptcp_end_dsn(skb1))) {
				/* All the bits are present. Drop. */
    ...
			if (after64(seq, MPTCP_SKB_CB(skb1)->map_seq)) {
				/* partial overlap:
    ...
}

When skb1 has MPTCP_SKB_CB_F_OFFSET set, its raw map_seq M sits offset
bytes below its real DSN D = mptcp_dsn(skb1). Take an incoming skb whose
seq S satisfies M <= S < D:

- If its end is <= mptcp_end_dsn(skb1), it is dropped as
  MPTCP_MIB_DUPDATA. skb1 never delivers [S, D), though.
  __mptcp_ofo_queue() only dequeues skb1 once ack_seq reaches D, and
  readers start at copied_seq - map_seq >= offset.

- If its end is past mptcp_end_dsn(skb1) and S > M, it is linked into
  skb1's right subtree even though S < D.

In the second case, __mptcp_ofo_queue() walks the tree in order and
stops at skb1:

		if (after64(mptcp_dsn(skb), msk->ack_seq))
			break;

With ack_seq in [S, D), the in-sequence skb behind skb1 is never moved.
Does the receive path then stall until an MPTCP-level retransmit fills
the hole?

This looks reachable. tcp_data_queue() queues partially overlapping
segments without trimming them, so __mptcp_move_skbs_from_subflow() sees
offset > 0 and mptcp_init_skb() sets MPTCP_SKB_CB_F_OFFSET. If
mptcp_dsn(skb) > ack_seq, the skb goes to the out-of-order queue. A later
out-of-order skb whose DSN starts inside [M, D), for example a
reinjection on another subflow, then takes one of the paths above.

mptcp_prune_ofo_queue() has a similar problem. It still compares raw
values, and each one is shifted by its own offset:

		/* Stop pruning if the incoming skb would land in OoO tail. */
		if (after64(MPTCP_SKB_CB(in_skb)->map_seq,
			    MPTCP_SKB_CB(skb)->map_seq))
			break;

Take an MPTCP_SKB_CB_F_OFFSET in_skb with real DSN D. Out-of-order skbs
with a DSN in (D - offset, D] look like they come after the incoming
data, so they are pruned under memory pressure.

Should both functions use mptcp_dsn() here?

The "Partial packet" guard in __mptcp_move_skb() also still reads the raw
end_seq, while the body uses mptcp_end_dsn():

	if (after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
		copy_len = mptcp_end_dsn(skb) - msk->ack_seq;
		goto insert;
	}

So an MPTCP_SKB_CB_F_OFFSET skb with
mptcp_end_dsn(skb) - offset <= ack_seq < mptcp_end_dsn(skb) is dropped as
completely old data.

The later patch "mptcp: sync mptcp skb cb layout with tcp one" changes
this guard to after64(mptcp_end_dsn(skb), msk->ack_seq). The map_seq
comparisons in mptcp_data_queue_ofo() and mptcp_prune_ofo_queue() are
still there at the end of the series, as before()/after() on the 32-bit
map_seq.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794663678.git.tanggeliang%40kylinos.cn
