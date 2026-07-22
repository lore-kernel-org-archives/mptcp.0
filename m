Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2A34BCAC9
	for <mptcp@lists.linux.dev>; Wed, 22 Jul 2026 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784714476; cv=none; b=R0U2Z3bV2vibyCEqa/FJtVCuUd5JKBXm6QxQeTyhGitXhAlpKwT4cgTd21ayqIel2cnttfwTxikCZBGaYY1AXCEPZVUt+dkdNV26evN4Uesf4C/3bVlocVO1h2sJpesOmBaE3YJeKKGp1owdp7sNWAfDwMuWNVeFCCZC71RVqL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784714476; c=relaxed/simple;
	bh=wkNFlhqtTqEVne7ZZFFOXvI6D3+hmGpHKYGWgeSnQgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MU9XE+5n0K3TidBmPKc/Dlaq0QNxpeKG/r3ciSJILYNWu28RGKzw+fdEJt5e9Jl4qLR43g2dpKTF8pxvSuXzstOyddnvnFeDx/bQHISblnlaItS4UTNWreRkTIPMKOlUq4oMGWttRZpjtjo6u79n+GXpep5HeT55IL6Id31fp58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+HJ0qI+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+HJ0qI+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A62E1F000E9;
	Wed, 22 Jul 2026 10:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784714473;
	bh=9Pq1QrxZLvVdZLKUqTn1+mr2dsECbgun9SGiw0W/748=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T+HJ0qI+GYMvlcFwscJSpaCxOxSjz48bfYL/7aTjrF9tHgVlSXEgCZr527RVEiw75
	 aTbS62dT1rZXy4wU5pgPTCw7ekcv01Ut9xzxDQaqCLek7wSB1nSUYagrzZ4c3pB9JP
	 avqe3C/w2hZKOTTy/NcBlobTWmyQRg6V3gbHON7ypzfvC9lmgGE8CdK+2x7aPoVJfv
	 6JFqq+OX8dD4FKL7MaB7l5E+jFOLNkAwYplEwVgsSF2TkMxpW1XC3nqxpABmSz/vtL
	 CYZ01vI0WJDSpRmEpbsZY+6i3zAb0nN+LntOh4KZJSz+Gkg37KQ7Rh23ikWHexZn+Z
	 sTSfRpXVwfB2w==
From: Geliang Tang <geliang@kernel.org>
To: pabeni@redhat.com
Cc: mptcp@lists.linux.dev
Subject: Re: [mptcp-next,v5,07/12] mptcp: sync mptcp skb cb layout with tcp one
Date: Wed, 22 Jul 2026 18:01:04 +0800
Message-ID: <20260722100104.1241778-1-geliang@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <8acd04596a44fa0a03e39f9f3d10a2e301b52763.1778446731.git.pabeni@redhat.com>
References: <8acd04596a44fa0a03e39f9f3d10a2e301b52763.1778446731.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Paolo,

Patches 6 and 7 turn out to be very helpful for simplifying my MPTCP KTLS
support implementation.

To let KTLS obtain an skb's sequence number, I had defined a get_skb_seq
operation in [1]. The TCP implementation was:

static u32 tcp_get_skb_seq(struct sk_buff *skb)
{
      return TCP_SKB_CB(skb)->seq;
}

and the MPTCP one was:

static u32 mptcp_get_skb_seq(struct sk_buff *skb)
{
      return MPTCP_SKB_CB(skb)->map_seq - MPTCP_SKB_CB(skb)->offset;
}

After Patch 6 removes the CB offset field, the MPTCP implementation collapses
to simply:

      return MPTCP_SKB_CB(skb)->map_seq;

And after Patch 7 changes map_seq from u64 to u32, the get_skb_seq operation
is no longer needed at all. The two control blocks now expose the sequence
number identically (same type, same offset), so I can define a single
TLS_SKB_CB accessor that works for both TCP and MPTCP without any
per-protocol dispatch:

struct tls_skb_cb {
      u32 seq;
};

#define TLS_SKB_CB(__skb)     ((struct tls_skb_cb *)&((__skb)->cb[0]))

static_assert(offsetof(struct tcp_skb_cb, seq) == 0);
static_assert(offsetof(struct mptcp_skb_cb, map_seq) == 0);

The static_asserts guarantee at compile time that both layouts keep the
sequence number at offset 0, so TLS_SKB_CB(skb)->seq reads the correct
value regardless of the underlying protocol.

I have reworked the entire MPTCP KTLS series on top of patches 4-8 of this
series. Building on the removal of the CB offset field, I also added a patch
that trims the duplicated skb head at receive enqueue. With that in place,
KTLS can retrieve the record header via skb_copy_bits() directly, so there
is no longer any need for a dedicated MPTCP helper like the
mptcp_skb_get_header() I introduced in [2].

Looking forward to your next version of patches 4-8. Happy to help out with
them if that's useful.

Thanks,
-Geliang

[1] https://patchwork.kernel.org/project/mptcp/patch/eacfe3e5929c07d35d08cab6663c61d40fac8649.1782123118.git.tanggeliang@kylinos.cn/
[2] https://patchwork.kernel.org/project/mptcp/patch/447fc4384ba0d4b0f78c452239dbb3e87e021578.1782123118.git.tanggeliang@kylinos.cn/
