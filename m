Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794006428;
	b=UMiCBLAq9RcmioAiE8BoMgAU2kT/YpB/PxSkPXiQxDo2fU10Q5XmhY7VNbUKZpm48QtT
	 7SwW7MaTwJap2aqyb0xWEOBEueqCkrEG0LSVp8jQNF4aVGDooXq7V6QdF3/sFnAnhl9Mg
	 fBRsY2swdd2pbs/e5Q/zBVpvGyy0HLmdks34ZFWm7KrZTKfJuuBGqNgNXt/MRwW5t9hHj
	 k9VhzS8LYxloaHava1oR/1Y4WKq6NwkCVjiJgc+FsELGSMyI2lrPuitWrfMWX/KORvTUc
	 8vdGPImeq1gcWv8GFaCAr74AJsDI7JbmB3BhaNrvOF8cQDylqNwWOnw72fkUPOLW45w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794006428;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=DU4zorIhvQ2VweNBSnnMX2aSAw1OafuLdTrwrNXUqTE=;
	b=nrBTGD1EooUjy03SQzMYxt+kAEhS6Wa/rtz6uVEDXGKSSREHBYd9xsz3HlCYVT4rrxox
	 NQcqWXjAXagX5AB0cxrlgsiJJXIaVCkg9w8Ag+AFVVfUJUKxen/0yJoEi443/yoYbiMzW
	 0d+OaIIyeJDQ1VPbw7HmUJrvPxfuSUauUAkNHZ55TjpfyEvJyIdunOdV7Rsc1TCEO/Rnj
	 sNL7mh6Ty9gLMtG9ovq/2WWzwaVg2OucFAefgptV3hpLl4ehPmtC/AJP8UyJdf7x4GY0C
	 tXRS0N9ddqImbk12/y1tYWgSgbqPoPff0L46Xh0SUpqwxlQbJj9U50ta0a5+CXfyPSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kPuqkfqR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73105606A326
	for <mptcp@lists.linux.dev>; Fri,  6 Nov 2026 23:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kPuqkfqR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 057051F0089F;
	Fri,  6 Nov 2026 23:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794006428;
	bh=DU4zorIhvQ2VweNBSnnMX2aSAw1OafuLdTrwrNXUqTE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kPuqkfqRQwBiYkkrP5ggWoJp3Q2tCCsGZ9ZHn3cS2JqpE86wX43YjErk3BFXDJ7YX
	 NvMEFbcqfSdh27BkF7ZLKXYjN0KL77hDLNAIwaO3hlLQH0fTWuCYb31+Pk37K0YaTI
	 MpH1b7Y4P2O5Mr1/ALZvBfccBWJbocrLlXphvj8sFjnUPaxMP7N54PjBV1obSXpHfv
	 lHzlmf/jNNQcWw4BpUiLFP43Co9aWXIdMtQ2uGShzoK/8EI/xJ8tWhcISlNFMDcDIs
	 rszC9daOuVv02+AbSnTR2wkXF0h9CbYq2AmmrpGzV9VqpMuIEBd8bdiAXgN9VimITg
	 eHQxaailxzQ6Q==
Subject: Re: [PATCH mptcp-net v21 3/9] mptcp: fix TFO map_seq sign extension
 in fastopen
From: netdev-bot+sashiko@kernel.org
To: geliang@kernel.org
Cc: mptcp@lists.linux.dev, tanggeliang@kylinos.cn, pabeni@redhat.com,
 kuba@kernel.org
Date: Fri, 06 Nov 2026 23:07:07 +0000
Message-ID: <179400642753.488855.12799140902151687721@kernel.org>
In-Reply-To: <46b31cc96bd3ed1cd5afd2c3e0e7a5f1581d16a5.1793870710.git.tanggeliang@kylinos.cn>
References: <46b31cc96bd3ed1cd5afd2c3e0e7a5f1581d16a5.1793870710.git.tanggeliang@kylinos.cn>
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

- [Medium] The commit message of "mptcp: fix TFO map_seq sign extension
  in fastopen" describes a user-visible bug that cannot happen in the…

--

mptcp: fix TFO map_seq sign extension in fastopen

This commit changes mptcp_fastopen_subflow_synack_set_params() in
net/mptcp/fastopen.c so the TFO skb's map_seq is set to -(u64)skb->len
instead of -skb->len. The value then becomes a proper 64-bit negative
offset from an assumed IASN of 0. The commit message says this fixes
mptcp_inq_hint() returning INT_MAX before the MPC 3rd ACK.

> This causes mptcp_inq_hint() to return INT_MAX before the MPC 3rd ACK
> arrives. On a passive TFO msk, msk->ack_seq is still 0 until the 3rd
> ACK. Without the cast to u64, the computation 0ULL - (u32)(-len)
> underflows and clamps to INT_MAX. This incorrect value is returned to
> user space through SIOCINQ/FIONREAD in mptcp_ioctl(), the TCP_CM_INQ
> cmsg in mptcp_recvmsg(), and also affects receive buffer auto-tuning in
> mptcp_rcv_space_adjust().

[Severity: Medium]
Does this description still match the tree this patch applies to?

An earlier patch in this series, "mptcp: fix TFO SIOCINQ overflow in
mptcp_inq_hint", already rewrote mptcp_inq_hint() in net/mptcp/protocol.c:

static unsigned int mptcp_inq_hint(const struct sock *sk)
{
	const struct mptcp_sock *msk = mptcp_sk(sk);
	u64 hint_val = mptcp_data_avail(msk);
	...

That function no longer reads msk->ack_seq or the head skb's map_seq.
The 0ULL - (u32)(-len) calculation described above is no longer in the
code.

The other readers of the TFO skb's map_seq don't depend on its absolute
value either. The skb has cant_coalesce set, so __mptcp_try_coalesce()
rejects it before it compares map_seq or end_seq:

	if (unlikely(MPTCP_SKB_CB(to)->cant_coalesce) ||

The only remaining accesses are map_seq += count on partial reads and
pr_debug() output.

The cast is harmless. It looks like it only becomes necessary later in
the series, once msk->copied_seq is seeded from map_seq64 and tfo_iasn
is added to it.

Could the commit message describe that dependency instead of the
SIOCINQ/TCP_CM_INQ symptom, which the earlier patch already fixed?

> Fix by casting to u64 before negation: -(u64)skb->len. This ensures
> proper 64-bit two's complement representation, so the hint correctly
> returns skb->len before the 3rd ACK.

The only tag here is Fixes: 36b122baf6a8. Could this mislead stable
backports into treating this patch as the fix for SIOCINQ returning
INT_MAX?

Take a tree that has f03afb3aeb9d but not the mptcp_inq_hint() rewrite.
There, this patch alone would only cover the window before the 3rd ACK.

After the 3rd ACK, ack_seq becomes iasn while the TFO skb's map_seq stays
at -(u64)len. So ack_seq - map_seq = iasn + len, which would still clamp
to INT_MAX.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1793870710.git.tanggeliang%40kylinos.cn
