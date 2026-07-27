Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8E83939BF
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 11:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785152157; cv=none; b=OKRtZSf6tzd3pe4yf0T2nOnZJMPqvEz0w7ay+aCfgX7RwwPsmgEniOqwvOo+7lvzOK7Wwa5l06flPiPxQc/0c2rbvSiSI3w+EIAj6cSlmuuo/XdWT3wTp4cGKqhDlrJzQZuEPhSwzKbrHHrhzvM1AMOcxeSr7xilx6ga6gTfxoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785152157; c=relaxed/simple;
	bh=09DRvdUYO7NkfbfqjsSxAyxOgEspfP79IoUUIM+unoM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W9n1U3tn5GrZL+YZpuDFlmJW02WbuD3r2jmN98mCuOFZZC81JZzAaJ1vWlQxca26wMfl7ZlFzcepQdNk73yZJMo7WDwy8NRG82LA0WDB2+6xVzWwJF+O/knt82zARCb0LXaUFz+vjNrGXAp2VwwtarBIxYPMcj+xp0XMp+LHag4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNDV4pFC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNDV4pFC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9901F000E9;
	Mon, 27 Jul 2026 11:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785152154;
	bh=5HG4LqQb3GZebJsLGBi8jvvRnJOQYcBLbwp3YcZTz+4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bNDV4pFCEq68+rWaTEaRs0TQ/nvRWJtyE4zWuRDFf5Y1ImoJC5+P6YbQE+yTyIAyZ
	 XQCk6qJJTNVCf83+rDaoVySq+0YPjT3hOC8tQCQxPvkwQSbKczmMlGrdZYyzD0EQTu
	 A0xSHOgRo7gWFkq1nMG2PQUGFjadZaEdxkN0ek6WRMQaH7SHSNOZHipZQ0rfy586xy
	 3oxgqBPGRxM4X7pQg5+gagLKKBPjvs/8NHTiQuQE+hf9I6L9olmPGOaVfRAqJzJL2N
	 /kKPqah66dNcWd3Y6aX2VVKbqiOe1jR8BvBf/HmXZtpEWPLV1K2/a+4xtUaWU6dkm/
	 /2JF2rPq5P5nQ==
Message-ID: <e4734c66172f63a66e0013e67c87694d6c5328fd.camel@kernel.org>
Subject: Re: [mptcp-next,v5,07/12] mptcp: sync mptcp skb cb layout with tcp
 one
From: Geliang Tang <geliang@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>, Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Date: Mon, 27 Jul 2026 19:35:48 +0800
In-Reply-To: <6ffced08-a83a-4262-b6d3-f1e31599848e@redhat.com>
References: 
	<8acd04596a44fa0a03e39f9f3d10a2e301b52763.1778446731.git.pabeni@redhat.com>
	 <20260722100104.1241778-1-geliang@kernel.org>
	 <190a8af0-1a1c-4bb8-a129-c245511f54f1@kernel.org>
	 <6ffced08-a83a-4262-b6d3-f1e31599848e@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

On Mon, 2026-07-27 at 12:04 +0200, Paolo Abeni wrote:
> On 7/24/26 12:25 PM, Matthieu Baerts wrote:
> > On 22/07/2026 12:01, Geliang Tang wrote:
> > > Hi Paolo,
> > > 
> > > Patches 6 and 7 turn out to be very helpful for simplifying my
> > > MPTCP KTLS
> > > support implementation.
> > > 
> > > To let KTLS obtain an skb's sequence number, I had defined a
> > > get_skb_seq
> > > operation in [1]. The TCP implementation was:
> > > 
> > > static u32 tcp_get_skb_seq(struct sk_buff *skb)
> > > {
> > >       return TCP_SKB_CB(skb)->seq;
> > > }
> > > 
> > > and the MPTCP one was:
> > > 
> > > static u32 mptcp_get_skb_seq(struct sk_buff *skb)
> > > {
> > >       return MPTCP_SKB_CB(skb)->map_seq - MPTCP_SKB_CB(skb)-
> > > >offset;
> > > }
> > > 
> > > After Patch 6 removes the CB offset field, the MPTCP
> > > implementation collapses
> > > to simply:
> > > 
> > >       return MPTCP_SKB_CB(skb)->map_seq;
> > > 
> > > And after Patch 7 changes map_seq from u64 to u32, the
> > > get_skb_seq operation
> > > is no longer needed at all. The two control blocks now expose the
> > > sequence
> > > number identically (same type, same offset), so I can define a
> > > single
> > > TLS_SKB_CB accessor that works for both TCP and MPTCP without any
> > > per-protocol dispatch:
> > > 
> > > struct tls_skb_cb {
> > >       u32 seq;
> > > };
> > > 
> > > #define TLS_SKB_CB(__skb)     ((struct tls_skb_cb *)&((__skb)-
> > > >cb[0]))
> > > 
> > > static_assert(offsetof(struct tcp_skb_cb, seq) == 0);
> > > static_assert(offsetof(struct mptcp_skb_cb, map_seq) == 0);
> > > 
> > > The static_asserts guarantee at compile time that both layouts
> > > keep the
> > > sequence number at offset 0, so TLS_SKB_CB(skb)->seq reads the
> > > correct
> > > value regardless of the underlying protocol.
> > > 
> > > I have reworked the entire MPTCP KTLS series on top of patches 4-
> > > 8 of this
> > > series. Building on the removal of the CB offset field, I also
> > > added a patch
> > > that trims the duplicated skb head at receive enqueue. With that
> > > in place,
> > > KTLS can retrieve the record header via skb_copy_bits() directly,
> > > so there
> > > is no longer any need for a dedicated MPTCP helper like the
> > > mptcp_skb_get_header() I introduced in [2].
> > > 
> > > Looking forward to your next version of patches 4-8. Happy to
> > > help out with
> > > them if that's useful.
> > 
> > That's good if these patches are helping you, but I don't think
> > Paolo is
> > going to work on a new version for these patches. The attached
> > series --
> > mptcp: address stall under memory pressure -- has been applied, and
> > it
> > didn't need these patches at the end.
> > 
> > I don't remember why these patches were not needed, but I guess you
> > can
> > always cherry-pick them on your side, and modify them if needed.
> The goal behind that patches was to reuse for mptcp the tcp ofo queue
> pruning helper. Discussion with Eric pointed out that ofo queue
> pruning
> is actually a bad thing, so I just omitted that for mptcp and dropped
> the pre-req patches.
> 
> Patch 6 could have some merit on its own, as IIRC reduced the
> conditionals in fast-path and cleaned-up the code a bit.

Thanks for your reply. I just did a little cleanup on patches 4-7 and
sent them together with my two patches to the mailing list, under the
name "Reduce the differences between TCP and MPTCP for TLS usage".

Thanks,
-Geliang

> 
> /P
