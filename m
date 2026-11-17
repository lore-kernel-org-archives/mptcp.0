Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794957224;
	b=ou42mKj3IdZ1Tu/IZZf+MVnlIONcH6ysR/mmoOaIfTC23H7CN8xoVvxFKUTThr6vaB+U
	 vQdzWl3EBTA68BPkeoAYnhlRCi+TW7I5GmU/H0QiqhX061TAWN1wsLoZlk2xXwdJOlXdT
	 Sbqjvrgu4YTQBksOzgv+o+2ec6LzAJ3otYn6nn/FCT8c9Edua+cZQHrLseCojzrKIYWYo
	 kjo2tEhsdITDyV3U59htVa/RF/xe+dLomzLWjmPZFCF01Jns9UveGBTGPPpeYjc4RfRSN
	 ox+gwfZVGNmZ+/RCS76NkEgk5zQlXZExi8Dfe1BcWd/Nqq6UTvmzChPl7rYwxkaizVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794957224;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=VZD4fnz+MBI7wNe1F25oErHnBEzwVlRvaRke2jDsMWI=;
	b=ruYUVKjyCiZzukgMDLWNJwbrJ5UOSNtNQ1HkBFzTzraqr8JpsuARKuN+COYbUKcB/vGD
	 GSgEkWd3fJmPw+gY8b5mIMFOZE030KX0xv52fTPJE0zYirEh9dM1kBtFwM4Yi4w3vY/XH
	 xgN22TRQk2HtWrjCQkvBEF1oiu/+ruT/kPsxXZpQdRgg3lQlE9kXgyuHqsYg1Rj9T/dQW
	 UQIPMqeDI+arNQVKB5WmXtdG+7hQ/tXBN8re2mVnu22+jq4e2YKWadbQrFVIQqybsWUTX
	 3uw/5p1Mi+eFV8DB+K1XwZu1KB57IuquCIiMYruyOAYTccQpZ7/b9ZGAuEmimxP07AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dw9QGPr+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875CD606A335;
	Tue, 17 Nov 2026 23:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dw9QGPr+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD96F1F000C5;
	Tue, 17 Nov 2026 23:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794957224;
	bh=VZD4fnz+MBI7wNe1F25oErHnBEzwVlRvaRke2jDsMWI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Dw9QGPr+ms2+pirrchgzRF/4CQUSdxAuRT0ByxnBXWkjP31i+md37a48SD968Mq2u
	 ivHZJIzY+fpIbskInt+Ds3S29RctGLgh+153kWU3r27HHl7vhm41O45eI5mrylme5g
	 nCuAvsK8YCMfLbOvGo4JPCNirAeCYgljMABOKBiefm93oUIPLQLICjk1wSMGcMsxLD
	 hfl7bnK1I/TlqHjqjJ8BeyKVddx49mQj85hmlPJx3JmeRURPXpM8SHQA7ksul8sQvo
	 wgxc2NaYGgSD77EK70cakVdjaSsEQt5QG5KB7lVhA0HCExRXOpytzD6BrAqXStoRFs
	 YhwjneusIKn3w==
Subject: Re: [PATCH v2 net-next 7/7] selftest: packetdrill: Add test for
 tcp_collapse().
From: netdev-bot+sashiko@kernel.org
To: kuniyu@google.com
Cc: edumazet@kernel.org, ncardwell@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, matttbe@kernel.org, martineau@kernel.org,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 mptcp@lists.linux.dev
Date: Tue, 17 Nov 2026 23:13:43 +0000
Message-ID: <179495722334.3136.9959346022100767379@kernel.org>
In-Reply-To: <20261116230555.2305867-8-kuniyu@google.com>
References: <20261116230555.2305867-8-kuniyu@google.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] tcp_rcv_collapse_bloated.pkt cannot catch a regression in the
  high-density/unread-bytes check, tcp_collapse_skb_bloated(), even…
- [Low] The last step of tcp_rcv_collapse_bloated.pkt claims to 'verify
  data integrity', but `read(4, ..., 300000) = 279900` only checks the…

--

selftest: packetdrill: Add test for tcp_collapse().

This adds a packetdrill test, tcp_rcv_collapse_bloated.pkt. It queues a
mix of high-density and low-density skbs, shrinks SO_RCVBUF to trigger
tcp_prune_queue()->tcp_collapse(), and then checks TcpExtTCPRcvCollapsed
to confirm that exactly 30 skbs were collapsed. It also changes
ksft_runner.sh to skip any script whose PAGE_SIZE define does not match
getconf PAGESIZE.

> diff --git a/tools/testing/selftests/net/packetdrill/tcp_rcv_collapse_bloated.pkt b/tools/testing/selftests/net/packetdrill/tcp_rcv_collapse_bloated.pkt
> new file mode 100644
> index 0000000000000..90e8be86968f8
> --- /dev/null
> +++ b/tools/testing/selftests/net/packetdrill/tcp_rcv_collapse_bloated.pkt
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Test that tcp_collapse() only collapses bloated skb runs, skips leading
> +// and trailing high-density skbs, skips isolated bloated skbs when collapsing
> +// them would not shrink truesize, and properly recovers receive buffer space.

[ ... ]

> +// 1. Queue two high-density 62,000 B segments (each adds 15 pages of frag
> +// truesize with enough margin across NET_SKB_PAD, L1_CACHE_BYTES, and
> +// MAX_SKB_FRAGS configs).
> +// Read 100 bytes from the first one so before(skb->seq, tp->copied_seq) is true.
> +   +0 < P. 1:62001(62000) ack 1 win 65535
> +    * > .  1:1(0) ack 62001
> +   +0 read(4, ..., 100) = 100

[Severity: Low]
Can this test catch a regression in the density check itself?

The header comment says the test checks that tcp_collapse() skips
leading and trailing high-density skbs. The partial read here is meant to
cover the copied_seq case. However, every high-density skb is 62,000 B.
That is already larger than TCP_COLLAPSE_MAX_TOTAL_SIZE, which is
16 * 3776 = 60416 on 4K pages.

Because of this, two other checks in tcp_collapse() settle the outcome
for these skbs, whatever tcp_collapse_skb_bloated() returns. First, the
second loop stops any run from extending into a 62,000 B skb:

net/ipv4/tcp_input.c:tcp_collapse() {
    ...
		if ((list || !before(TCP_SKB_CB(n)->seq, sub_end)) &&
		    (TCP_SKB_CB(n)->end_seq - start >= TCP_COLLAPSE_MAX_TOTAL_SIZE ||
		     !tcp_collapse_skb_bloated(n, sub_end,
					       TCP_COLLAPSE_SCALING_RATIO)))
			break;
    ...
}

Second, the truesize comparison always skips a single 62,000 B skb:

	if (old_truesize <= new_truesize) {
		start = sub_end;
		skb = n;
		goto restart;
	}

Here new_truesize = 16 * SKB_TRUESIZE(3776) + compute_skb_truesize(~1.5K)
= 69632 + 2304 = 71936. That is above the roughly 65792 truesize implied
by the rmem figures in the test.

If tcp_collapse_skb_bloated() is forced to always return true, the walk
over the queue looks like this:

  skb1 (start = copied_seq = 101): breaks at skb2 because
      124001 - 101 >= 60416, then the truesize check skips it
  skb2: breaks at the isolated skb (63000 >= 60416), then skipped
  isolated skb: breaks at skb3 (63000 >= 60416); old 2304 <= new
      compute_skb_truesize(1000) = 2304, so skipped
  skb3: breaks at the first small skb, then skipped
  30-skb run: collapses, then breaks at the trailing skb
      (92000 >= 60416)
  trailing skb: the truesize check skips it

That still gives exactly 30 for TcpExtTCPRcvCollapsed, so the test
passes. It would also pass if the old before(TCP_SKB_CB(skb)->seq, start)
trigger came back in the first loop. In this test, the
!tcp_collapse_skb_bloated() break in the second loop never ends a run.

The test does catch the pre-series behaviour. But would a later
regression in tcp_collapse_skb_bloated(), or in the copied_seq-based
unread computation, pass this test unnoticed?

One option is to use high-density skbs small enough that a run stays
under TCP_COLLAPSE_MAX_TOTAL_SIZE, and where collapsing them would reduce
truesize. Then the density check would be what decides the outcome.

[ ... ]

> +// Read all remaining queued data to verify data integrity.
> +   +0 read(4, ..., 300000) = 279900

[Severity: Low]
Does this read() actually verify data integrity? With the "..." buffer
form, packetdrill only checks the return value. The injected payloads are
also all identical zero-filled bytes.

Suppose the copy loop in tcp_collapse() used the wrong offset or source
skb:

			int offset = start - TCP_SKB_CB(skb)->seq;
			...
				if (skb_copy_bits(skb, offset, skb_put(nskb, size), size))

or reordered bytes inside the collapsed range. read() would still return
279900, and the test would pass.

Should the comment say that this step only checks the byte count? Or
could the test send non-uniform payloads and verify their contents?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261116230555.2305867-1-kuniyu%40google.com
