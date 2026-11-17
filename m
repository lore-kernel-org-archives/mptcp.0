Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955273;
	b=JmTT+N2Qsqi/nGhXazuRHFghCVUqu+e3mwo8GwXU9dRWL49DJBblm9PBs3exgWOpmW0D
	 u64Y0RLU6baHXKVlkTn1Or/hwIoD3XQdjWnQ/fVtgkTJhWWYRPPHYkrDljlmAuiMCrF66
	 Cj9QBEaGCvz6yI+6orHOkSAEfIqq6TEXnO2Mcf3H+yUA9U8DY1mZ/xYXPx/C/hbshOLwy
	 dD59k+ibigq4Y1XbnqgzOywmlQxZtOA/xOf2rA84jXCPRYsesLXdOP+k6SYJ9kbmSeK6y
	 vjIV5ddGSykK5hzFJ0v7E/f8XuLSNB7u0iJADXmcKQ11l3X77sINJmS6gMCL+Pz92Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955273;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Fn0ePfXQKRs89uF6+Uvl3EWeIPtV9Nx3Rm8SyZ+N064=;
	b=T895Dv4ygYy2vgajVYh9UrJpDP3qCKNa+XMC6pzdrT14GdyEVyUao64IYG8M5JAuJX9I
	 3/S5c3gQYTZxuy6VSDDJ19BeeUQ7KaCyHhb4spi7A4C7MVoTriBZHWF6HWLz9HRYd/MxC
	 XjZ4OgBdz1DpwdfImpK9/ybb+5ys0a/Ll35Ugr9kZr7vvH+wIW8stSum2N52xVosy5LIM
	 8dT2Bceeypd0TzvDVJQOBiOCmfNZH8wP3yXA8rNZ3/0rg7WRjYA5ZPmt6mAwBEX3KCcOR
	 GDJA0gSBC43lR/YPNNyKcItScK7qLPX7tCv+yuqlxhwsSALCtm/RyUw1KmCgUTspA9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Byt3UxGQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB21606A31C
	for <mptcp@lists.linux.dev>; Tue, 17 Nov 2026 22:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Byt3UxGQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA8A1F000CA;
	Tue, 17 Nov 2026 22:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794955273;
	bh=Fn0ePfXQKRs89uF6+Uvl3EWeIPtV9Nx3Rm8SyZ+N064=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Byt3UxGQ+NWN7ArfdSvQIXC7UNVBUR/1B0XjujFc89jc+gTS18SulYbB2ePQsaCGM
	 UpTaF9fJuhu6Svps8iGSqu0JmmaWF9gHBnp93m3WFYBpmMevwDXHf18Dyy68T4fntm
	 +THga1FhvbZ0TlE2KHc1RxfN1hTR268OPIHYq/FAAe1CSdJv3irpYRkl8yfJ3e5Y0S
	 P0I3h3p+F2KzW6PzB0VA/dlx605h8pfbuf2wn8n/greiBPkeL9PTpvUZD3HxWDBgxu
	 Mc4e5Fp7jcd858Ks0vAgltj5BnXmbJlk8UzHZibAoDDXaVZTRGdSMh/MLDv7mzipYa
	 QuwhnbfiuN0ug==
Subject: Re: [PATCH mptcp-next v28 08/11] mptcp: remove CB offset field
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Tue, 17 Nov 2026 22:41:12 +0000
Message-ID: <179495527291.3133.13448636552615197386@kernel.org>
In-Reply-To: <5776098385a6bce64c3952164408cdc39eccfef0.1794810809.git.tanggeliang@kylinos.cn>
References: <5776098385a6bce64c3952164408cdc39eccfef0.1794810809.git.tanggeliang@kylinos.cn>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message of "mptcp: remove CB offset field" claims
  work this patch does not do, and leaves out two changes it does make.
- [Low] The title says "remove CB offset field", but the per-skb offset
  is still stored in the CB, now implicitly.

--

mptcp: remove CB offset field

This patch drops the per-skb offset field from struct mptcp_skb_cb and
tracks consumed bytes with a new msk->copied_seq field, similar to TCP.
The skb map_seq now encodes the consumed prefix, and mptcp_dsn() and
mptcp_end_dsn() are reworked to derive the DSN from map_seq, end_seq and
skb->len. __mptcp_recvmsg_mskq() now takes a seq pointer (copied_seq or a
local peek_seq) instead of the copied_total offset.

> In mptcp_init_skb(), map_seq is computed as mptcp_subflow_get_mapped_dsn()
> minus offset, effectively encoding the consumed prefix into the sequence
> number. When offset > 0, the MPTCP_SKB_CB_F_OFFSET flag is set to mark
> the skb as having a consumed prefix.

[ ... ]

> Throughout the receive path, direct accesses to MPTCP_SKB_CB(skb)->map_seq
> and end_seq are replaced with calls to mptcp_dsn() and mptcp_end_dsn().

[Severity: Medium]
Do these two paragraphs describe this patch, or the earlier ones in the
series?

In this diff, the line in mptcp_init_skb() that sets
MPTCP_SKB_CB_F_OFFSET is unchanged context:

    MPTCP_SKB_CB(skb)->flags = offset ? MPTCP_SKB_CB_F_OFFSET : 0;

It looks like that came from the earlier "mptcp: add flags field to
mptcp_skb_cb" commit.

The mptcp_dsn() and mptcp_end_dsn() call sites are also already in the
parent tree. They were added by "mptcp: encapsulate CB DSN field access
with helpers", whose message has a nearly identical sentence. This patch
only changes the helper bodies.

Some direct accesses are also still there after this patch, for example
in __mptcp_try_coalesce():

    if (MPTCP_SKB_CB(from)->map_seq != mptcp_end_dsn(to) ||
    ...
    MPTCP_SKB_CB(to)->end_seq = MPTCP_SKB_CB(from)->end_seq;

and in __mptcp_move_skb():

    u64 copy_len = MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq;

The message also leaves out a change that the patch needs, in
mptcp_fastopen_subflow_synack_set_params():

    -	MPTCP_SKB_CB(skb)->map_seq = -skb->len;
    +	MPTCP_SKB_CB(skb)->map_seq = -(u64)skb->len;

skb->len is unsigned int, so without the cast map_seq would get
2^32 - len. msk->copied_seq is now seeded from map_seq. After the IASN
resync, copied_seq - map_seq would then be 2^32, and
__mptcp_recvmsg_mskq() would treat the whole TFO payload as already
consumed.

The message also does not say that end_seq changes meaning (see below).

Could the commit message be updated to cover what this patch actually
changes, including the fastopen cast and the end_seq change?

> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 755d524ef6b7f..0c7c58b51f61c 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -133,7 +133,6 @@
>  struct mptcp_skb_cb {
>  	u64 map_seq;
>  	u64 end_seq;
> -	u32 offset;
>  	u16 flags;
>  	u8  has_rxtstamp;
>  };

[ ... ]

> @@ -1386,12 +1386,13 @@ static inline bool subflow_simultaneous_connect(struct sock *sk)
>  
>  static inline u64 mptcp_end_dsn(const struct sk_buff *skb)
>  {
> -	return MPTCP_SKB_CB(skb)->end_seq;
> +	return MPTCP_SKB_CB(skb)->map_seq + skb->len;
>  }
>  
>  static inline u64 mptcp_dsn(const struct sk_buff *skb)
>  {
> -	return MPTCP_SKB_CB(skb)->map_seq;
> +	return MPTCP_SKB_CB(skb)->map_seq + skb->len -
> +	       (MPTCP_SKB_CB(skb)->end_seq - MPTCP_SKB_CB(skb)->map_seq);
>  }

[Severity: Low]
This isn't a bug, but the per-skb offset still seems to be stored in the
CB, just implicitly in end_seq. mptcp_init_skb() now does:

    MPTCP_SKB_CB(skb)->map_seq = mptcp_subflow_get_mapped_dsn(subflow) -
                                 offset;
    MPTCP_SKB_CB(skb)->end_seq = MPTCP_SKB_CB(skb)->map_seq + copy_len;

copy_len is skb->len - offset. So for an skb with a consumed prefix,
end_seq is end DSN - offset rather than the end DSN, and mptcp_dsn()
gets the offset back from end_seq - map_seq.

Some raw users of end_seq remain. __mptcp_try_coalesce() copies
from->end_seq into to and logs it as "new end seq". __mptcp_move_skb()
uses end_seq - map_seq as the count of new bytes. These are correct only
because the MPTCP_SKB_CB_F_OFFSET check in __mptcp_try_coalesce() refuses
to coalesce skbs that have a prefix offset.

Nothing documents that dependency: there is no comment and no
DEBUG_NET_WARN, and the field keeps the end_seq name. If a later change
coalesces offset skbs, or reads end_seq as an end DSN, wouldn't
mptcp_dsn() and the OFO ordering silently break?

Would a comment on struct mptcp_skb_cb, or a rename of end_seq, help
here? The same encoding is still used at the end of the series, after
"mptcp: sync mptcp skb cb layout with tcp one".

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794810809.git.tanggeliang%40kylinos.cn
