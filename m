Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F91351C2A
	for <mptcp@lists.linux.dev>; Thu, 30 Jul 2026 01:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785374116; cv=none; b=ILfaJphX+DiiTVPGuDQAHqMf2lR5Q1N9fPlJZ04Brynj7iPCtU4SupdeqJODEc1xW+TmpphSO94lH1OsRLr1p98HwCcIwJqM6OaXfFA0DDggP8302ncUkitbXr1x/prVik884izFYeOHGY09tONH1xK7Jr3H5BMK3L/4FXC2umo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785374116; c=relaxed/simple;
	bh=7NCupILRP1evVzCZW3SZEndx/i0gI9YYaRejpi5mWLw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=peIMN1Dc+iF+ds+QvVIjVGcIk9GxehHaU3+uGizlLSCei8BbdIi5nwSuN0kmKtFzhIAnTl8II0OVyKH7KLpsdu5PD8u9hZjHnY//dQChxYCGWAmQn9st42ZcooYTS5bkPpFXNEeZG4t6jXXNRsXadFUGAkGOO3DK6W4uuMAhgLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVF235ZV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVF235ZV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EC81F000E9;
	Thu, 30 Jul 2026 01:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785374115;
	bh=8xltEswJkCzJiYw6L/cttcf2Lg1K7zSyQQ8bZhYPWDM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kVF235ZVrBwS55YuK0Kc+z6ZWs/kBJ3ElGYywVyQsOENImcWu713cKTt2fpV3sdRj
	 +zxvmjiT/9WM3X40K0HShaZ26xFrRQY85SC65ANbnBYQCeTDRhr9WWlAPbuNKjCvhN
	 K0ygJZ66EIE9wVrYwGu9BNpGS4GSPGGS/47/fut2AuM1S/r1h21CDTdD7bNY3bQAIn
	 A0ULmpHaULL6IcbhTrp/R9udQKYXD8NKv5d7S2yHJRJyPFk+kMP6SL1T/qyFyxGS8W
	 xldf1JIC/TZGC5N47S/ViKfQDGI7Nl8FhV+euWZB7jwwb6LP8C/84RvCdZM0X+Kg7N
	 Q5MTnTxeXJU7w==
Message-ID: <4651fc61637f8be39654decec137010ffcd81991.camel@kernel.org>
Subject: Re: [PATCH mptcp-next 5/6] mptcp: trim the duplicated skb head at
 receive enqueue
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Date: Thu, 30 Jul 2026 09:15:11 +0800
In-Reply-To: <15adac30-7d7f-4637-91b7-3310f64cdb13@redhat.com>
References: <cover.1785150300.git.tanggeliang@kylinos.cn>
	 <81bd1e2fa9c959927bf0d1cae718a9da72164b5b.1785150300.git.tanggeliang@kylinos.cn>
	 <15adac30-7d7f-4637-91b7-3310f64cdb13@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi Paolo,

On Wed, 2026-07-29 at 10:08 +0200, Paolo Abeni wrote:
> On 7/27/26 1:29 PM, Geliang Tang wrote:
> > The linear readers (recvmsg, read_sock, read_done) cope with that
> > by
> > computing a per-skb offset = copied_seq - map_seq and skipping it.
> > But
> > consumers that treat the receive queue as a single contiguous byte
> > stream cannot: the TLS strparser builds an anchor whose frag_list
> > is
> > the receive-queue skbs and reads it with a plain skb_copy_bits(),
> > which
> > has no per-skb offset knowledge. A record spanning such an skb
> > boundary
> > then reads the duplicated prefix and gets corrupted.
> 
> The above raises a question.
> 
> AFAICS, the critical skb layout is also possible with plain TCP -
> possibly is just less likely. How does TLS deal with that? I read the
> above as the TLS stream get corrupted, which sounds suspiciously too
> fragile to me?!? Or did I miss something?

My description was inaccurate. This only occurs in the MPTCP out-of-
order scenario. It does not happen with TCP.

> 
> This change adds a lot of complexity to the rx path, we want to avoid
> it.

I agree with you. This helper mptcp_trim_dup_head() does not need to be
called in __mptcp_move_skb(). It only needs to be called when
overlapping data occurs in __mptcp_ofo_queue(). This way, it won't
affect the efficiency of the rx path.

static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
{
    struct sock *sk = (struct sock *)msk;
    struct sk_buff *skb, *tail;
    u32 seq_delta, ack_seq;
    bool moved = false;
    struct rb_node *p;

    p = rb_first(&msk->out_of_order_queue);
    while (p) {
        ... ... 
        seq_delta = MPTCP_SKB_CB(skb)->end_seq - ack_seq;
        tail = skb_peek_tail(&sk->sk_receive_queue);
        if (!tail || !mptcp_try_coalesce(sk, tail, skb)) {
            int delta = ack_seq - MPTCP_SKB_CB(skb)->map_seq;
        
            /* trim overlapping prefix, if any */
            pr_debug("uncoalesced seq=%x ack seq=%x delta=%d\n",
                     MPTCP_SKB_CB(skb)->map_seq, ack_seq,
                     delta);
            if (mptcp_trim_head(skb, delta)) {
                    mptcp_drop(sk, skb);
                    continue;
            }
            MPTCP_SKB_CB(skb)->map_seq += delta;
            __skb_queue_tail(&sk->sk_receive_queue, skb);
        }
        msk->bytes_received += seq_delta;
        WRITE_ONCE(msk->ack_seq, msk->ack_seq + seq_delta);
        moved = true;
    }
    return moved;
}

This helper is actually a mirror of the tcp_trim_head(). If we could
export and reuse TCP's __pskb_trim_head(), this helper would become
much simpler:

static int mptcp_trim_head(struct sk_buff *skb, int delta)
{
        int eat; 

        if (skb_unclone_keeptruesize(skb, GFP_ATOMIC))
                return -ENOMEM;

        eat = min_t(int, delta, skb_headlen(skb));
        if (eat) {
                __skb_pull(skb, eat);
                delta -= eat; 
        }

        if (delta) {
                __pskb_trim_head(skb, delta);
                skb->len += skb_headlen(skb);
        }

        return 0;
}

Would this implementation be better? Please give me some feedback.

Thanks,
-Geliang

> 
> /P
> 
