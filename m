Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795200111;
	b=s1FkklWCXBNy83mDfNtd2W6PMpb3x7ZEXEzTDavtbKpdIofGlUzkiG4AYFQtNrJsGy3W
	 6BdZpP/twK3TCsvwJN2FBz3GXPm9yZvTLGxMY9NqLdsQ6memD0LlkTv7h3UNGFgm0twrg
	 VEOFfRoFBYe/5xwrj6ISKpt4P+oJhzxnN0dKMksGhoG1lfPUfidzGUZqZI+UAvS8CqZZV
	 WBMVxUxRvoFFQ7DCBsOaYiyLj2finLkp5O1FsmpcKB3JB37FYi4nJoSHnumi4kVXUDCQy
	 puKSOSc6xTQMwRszB6SHWj5D8PbDP6HOXqBTS1GfKi11g43HqU72LRmx9mtn4DEAgmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795200111;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=+n2ybfzFoSzhI5NZKMpYloy6kTM/NAdhQ83d6aapkHU=;
	b=ugJeSZOXObwaffr6RjEdIOQJQFl9DcYQUJEBpfA1NZyHMhmvAUphnhMStd9J3GaREVWD
	 133ZoHnFX26wF87gSvv3VD1hyMB4xmAsP/zX5X3ep0haGUjP/rtOQDzD3VT9K7KLTUhpd
	 9gTGwwSwuUeQOoX8pwWzalTvb4ywqpHdECYV4vZlLHvTzHJsi3LvcG4aY6L3juuP15Lqs
	 dfWGL0CCEzzxcaDud2U6yo18r/vagg9a4Drnw8WjQKX/xbdEc+g149WUrePB6D8pUtW2J
	 A7DqatU/Oxh/1MhYdHYxKMzCEsTVI3Khs/AU5RU5eMI/hHbwHbi3H1byXjALfV2/FSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FaDjM94a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA9660A260C
	for <mptcp@lists.linux.dev>; Fri, 20 Nov 2026 18:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FaDjM94a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780FE1F000C0;
	Fri, 20 Nov 2026 18:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795200110;
	bh=+n2ybfzFoSzhI5NZKMpYloy6kTM/NAdhQ83d6aapkHU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FaDjM94a9neRHNgOb6j/kjx1+oJUZzE7FsFP5+EOmFutmoShdgl2pBcV3Ejl6pGqw
	 jXhjd74CZ2RHzQesG9hsjR4jbk+2xvwZjsofTmLzzHTKPHazAv5Yoi4Tc9NAOTuWvV
	 9bVSRynXwIvsyXvu1RFblsZ/XM7TfTInluxiAGoTkcalbDUJKrTVvsQU0x23SHhzb0
	 cm1d0pwlf3oZtP/tpu3gQkg6OrJlEeWIjAWT0SffvJi2tWW4R/d6YdHJxwQ38MgzNR
	 GfcuNPDHzIVAeGmBo7DYwjOTxkylQds8aok7rP63aSseToqW/YRNsCF7GE9dfnkrcD
	 nmt53X/ZZCeVA==
Subject: Re: [PATCH mptcp-next v29 4/8] mptcp: drop the cant_coalesce CB field
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Fri, 20 Nov 2026 18:41:50 +0000
Message-ID: <179520011006.3133.16319687060684256580@kernel.org>
In-Reply-To: <d93502137d925de91e85c9b4c41ef492f70aa7e9.1795063943.git.tanggeliang@kylinos.cn>
References: <d93502137d925de91e85c9b4c41ef492f70aa7e9.1795063943.git.tanggeliang@kylinos.cn>
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

- [Low] The commit message for "mptcp: drop the cant_coalesce CB field"
  has three problems.

--

mptcp: drop the cant_coalesce CB field

This patch removes the cant_coalesce field from struct mptcp_skb_cb. The
passive TFO skb is no longer blocked from coalescing. Instead, its map_seq
and end_seq are rewritten from the IASN (stored in msk->tfo_iasn) before
any further skb lands in the msk. When the msk is owned by user space, the
update is deferred through the new MPTCP_SYNC_SEQ cb_flags bit.

> mptcp: drop the cant_coalesce CB field
>
> Such field is used to ensure in-sequence processing in case of fastopen.
> Instead let's perform synchronization of the fastopen skb sequence
> when the IASN becomes available with the 3rd ack.

[Severity: Low]
Does this describe the removed field accurately?

Before this patch, the only reader of cant_coalesce is
__mptcp_try_coalesce() in net/mptcp/protocol.c. There it stops new data
from being merged into the passive TFO skb, which carries the dummy mapping
(map_seq = -len, end_seq = 0).

The field plays no part in the in-sequence, out-of-order or old-data
decision in __mptcp_move_skb(). That decision compares the incoming skb's
mapping against msk->ack_seq.

Commit f03afb3aeb9d ("mptcp: drop __mptcp_fastopen_gen_msk_ackseq()"),
which added the field, says it prevents "collapsing to the first skb of a
fastopen connect". Would similar wording be clearer here?

The message also doesn't give a reason for the change. struct
mptcp_skb_cb uses well under the 48 bytes of skb->cb, so space doesn't
explain it. To replace the one-byte field, the patch adds:

  tfo_iasn and rcvd_dummy_seq in struct mptcp_sock
  the MPTCP_SYNC_SEQ cb_flags bit
  a per-skb branch in __mptcp_move_skb()
  new checks in mptcp_move_skbs() and mptcp_release_cb()

If this prepares for the later "mptcp: remove CB offset field" and "mptcp:
sync mptcp skb cb layout with tcp one" patches in the series, could the
message say so?

Finally, there is a change in behaviour that the message doesn't
describe. After __mptcp_sync_rcv_sequence() sets the TFO skb's end_seq to
tfo_iasn, the next in-sequence skb (map_seq == ack_seq == iasn) passes
this check in __mptcp_try_coalesce():

	if (MPTCP_SKB_CB(from)->map_seq != MPTCP_SKB_CB(to)->end_seq ||
	    MPTCP_SKB_CB(from)->offset ||
	    ...

skb_try_coalesce() can then merge it into the TFO skb, which cant_coalesce
used to prevent.

The new behaviour looks correct, because tfo_iasn - len + offset keeps
map_seq - offset consistent across partial reads. Could the commit message
mention this coalescing change?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1795063943.git.tanggeliang%40kylinos.cn
