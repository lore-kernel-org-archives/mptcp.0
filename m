Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793812595;
	b=xZDPRt58+kZZOLT8wzKm29BwUz1OodvLyXQn8nS0yrGw1Xzn9BOvq6hCq6P7aRZqCKWq
	 ZYoh07D6qRd+dQWLz3GN/YvIifW39EiCEiPei7c5R+nzr1fBNowISb+y1O66bKDvqtTX/
	 Y459KfoFJa9OaHwpjmjENdTgmHXLPBe2FiXIRD3jFHCgjbTr4z+seBhq1xdUIYpbcY8eO
	 4vEJm19Ftfif7ol4PUMwf296MUTX/Eb/QymL5QUA1MITjibApG7+bztzZlMlDtTJe5xcd
	 Oh2EraSTj5XL3w/Hvm7jtrbSb4TfbycG7cyNgQjoix69OxNAIsabS+mDHwzUXIGjj9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793812595;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=EtC9BAovXvbpIUzYqXLDGjzbaCHksPMgZRoHS0i9mhE=;
	b=CgCyh7attYxwqWECmasjdBjhFr0lXL3N16Nz0f3IWTJbQ0ttXWTWoHIeFTnMmPWYoCXX
	 A5iE61rHmy5sUKSz0GpxKheag6OghsxyGeOEUI3zEU1zjPDZOETMq6lzoVcmvtVXJ5RFz
	 ImX+A5TdRoL4SvNmCc1TjMX9FHa+WZRznEaKseyHBpjVZvuBsf7EcX5EUvAZ+ETMMNtXN
	 fJ+yKy8ykoy8OZr4WiCYo2jVDkFd1mBeUy/JlCosiY9aJ0NvaiAsc6VgSu7+ctgyvPWM+
	 u0lbAKzF8JmmhYXJXNIlCXEHgUJRW4oKjqVzyU+GRA/72GmiOsUOhiqZiDAfIK7Bc8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRnLJ3Ad;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF2D606A31B
	for <mptcp@lists.linux.dev>; Wed,  4 Nov 2026 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRnLJ3Ad
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1BC1F000C1;
	Wed,  4 Nov 2026 17:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793812594;
	bh=EtC9BAovXvbpIUzYqXLDGjzbaCHksPMgZRoHS0i9mhE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jRnLJ3AdeJxzo/bSc8SYcqMuMVPXH9c1gi7WADHkuYX8kp7ZQf25rbIIz556SaiCG
	 0pnN2qRUnyuy/6Ailf6/VTHURpGtAl1xyHDx+IDXRaL17nEY6zWwpwTyMTzR3OIs7h
	 6xooh9hgKFNgIRALjoGiIxY/osoi/JX/hjKC1jzuRwREq8f81qghsXhn4PqbckSKrT
	 s1sppsfO6JQMwaINaiqQ1otL2wuuiCGxVyAM2I06RV5OJ6J0wGYH76n/h8V9hJ+mFZ
	 g96VCODGJ6CZPHePNzg2oebsUaG5wukapHmVbTihKZaZgut0D1s+e+ZlHLLtzZZWuJ
	 IJtEiT+iEMHNg==
Subject:
 Re: [PATCH mptcp-next v5 2/7] mptcp: use mptcp_data_avail in mptcp_inq_hint
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, kuba@kernel.org
Date: Wed, 04 Nov 2026 17:16:34 +0000
Message-ID: <179381259415.488855.12809260822038100854@kernel.org>
In-Reply-To: <ccd9f70eddb3df2c311b75f559d9acea3233295f.1793676064.git.tanggeliang@kylinos.cn>
References: <ccd9f70eddb3df2c311b75f559d9acea3233295f.1793676064.git.tanggeliang@kylinos.cn>
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

- [Medium] This patch fixes a real, user-visible regression, but the
  commit message describes it as an alignment/consistency change that…

--

mptcp: use mptcp_data_avail in mptcp_inq_hint

This commit changes mptcp_inq_hint() to compute the available bytes with
mptcp_data_avail() (bytes_received - bytes_consumed). Previously it
subtracted the head skb's map_seq from msk->ack_seq. The hint value of 1
for closed or shut-down sockets with no pending data is kept.

> This change aligns mptcp_inq_hint() with mptcp_inq() and provides more
> consistent behavior across different connection types, including passive
> TFO connections where the TFO skb has map_seq set to -skb->len (data
> before IASN). Using mptcp_data_avail() avoids potential overflow issues
> when ack_seq is set to iasn.

[Severity: Medium]

The code change looks correct. Is "potential overflow issues" the right
description, though? This seems to fix a concrete regression on passive
TFO sockets.

mptcp_fastopen_subflow_synack_set_params() queues the SYN data skb with:

    MPTCP_SKB_CB(skb)->map_seq = -skb->len;

When the third ACK arrives, subflow_set_remote_key() does:

    WRITE_ONCE(msk->ack_seq, subflow->iasn);

Before commit f03afb3aeb9d ("mptcp: drop
__mptcp_fastopen_gen_msk_ackseq()"), __mptcp_fastopen_gen_msk_ackseq()
added msk->ack_seq to the queued skb's map_seq and end_seq at that point.
Since that commit, the old mptcp_inq_hint() computes:

    READ_ONCE(msk->ack_seq) - MPTCP_SKB_CB(skb)->map_seq

That value is iasn + len, which is almost always >= INT_MAX, so the
function returns INT_MAX.

As a result, SIOCINQ/FIONREAD through mptcp_ioctl() and the TCP_CM_INQ
cmsg in mptcp_recvmsg() report INT_MAX, and mptcp_rcv_space_adjust()
subtracts INT_MAX from copied. This lasts until the TFO skb is fully
consumed, because partial reads only advance map_seq by the copied
amount.

The selftest later in this series ("selftests: mptcp: connect: check TFO
SIOCINQ overflow") checks for exactly this case, where mptcp_inq_hint()
returns INT_MAX for TFO connections.

Should this patch carry the following tag?

Fixes: f03afb3aeb9d ("mptcp: drop __mptcp_fastopen_gen_msk_ackseq()")

Could the commit message also describe the actual symptom, so the patch
can go to net and be picked up by stable kernels that contain
f03afb3aeb9d?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793676064.git.tanggeliang%40kylinos.cn
