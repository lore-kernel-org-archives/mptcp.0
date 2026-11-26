Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795735793;
	b=n62M6rkDvAKsi7N3CegNu1i213tFI2AXXS//+Zq2ldV+97KZX3hcBwp++uq/EwM92KUH
	 wrZiS/twQyhz2DvfYNuN2h32iHLoyfc4vHZleajSKnLK6A7CnopoIStnkXZESnOAZoApY
	 jUS6fKjH7fO65rJF/bNY9vBZwztcyv3cc8abzd+xPTbcILZWVm3xOjQ9mp+TdScFziE8+
	 q4Gr/9aQ8tInTpAMQDu3Wcp5XcxKSfs+dylLTmfC38RKo4kdiGFDy4cQv7lEvvscAwDmU
	 79j5TRMLFpSxVRMYcqrsAES3ir7uWLQ1A7Sr70H6gyowmCaouAeNMW436CwLC8qIWKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795735793;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wOp1UgpKWba8CQ9RRDggBwaiTYjWj/PHOi8Q8ZdrBI0=;
	b=19U/Y3M5BFVEwQhLnTtno0zp4BPrQpz0wzTt22q7f06TqdHwGmo/fu9c9EGhpjPybwSA
	 yTy8VUz1jCyHoepS0othejhRVAVpPI56eFHWKzKWr6n9egqv7rGnbeDQIu23oySuLNPGv
	 Jn8tfJg/7FOH2ysX9KPWgnUMU66F9eV+XL5dRIi9LU/lRsBSN3j1Iq7eR7WrBoSL8slcz
	 IVjYRTcdEp2VZbAFU7MpQljnIFgKdivi9LNVK1XX+XCw+PyYKmjDJxWoNXmp+mJtODWFr
	 ctnBWOiKvT/UeudwWWzzrVjr/FLhs+AevkIN1LehzfohfGhRR6JZjRcyKxtCZVfYTOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FsdXnEx/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EA1606A31C
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 23:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FsdXnEx/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18FC1F00926;
	Thu, 26 Nov 2026 23:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795735792;
	bh=wOp1UgpKWba8CQ9RRDggBwaiTYjWj/PHOi8Q8ZdrBI0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FsdXnEx/X6z+7mjIB+gaFJq03wz1hyp2Nyydd2VaRvqqzoHdk9pMTF9bUTGy23udY
	 TqJ4YWd+bkRuQ1zkSk9QCT990OrPr0ck42VtIILY+t99j7gC/rJ1mHwzqhEwKME6K1
	 GQ5Bq9smF4b6z2m/QXcxO0Qk4mX6IIO51yAug1ZQn5y9k6EzZ199iDQs0iKTokmBpv
	 Z0FAbXvlXmbcHpzxbnwxypKRxyWCXzliJf9HsdOqR/52orJdFRfRUEWKdObkM8feiv
	 1262pOMyotEei24Q5WK/wv+ZcrPJWB+XtB6rhrzkxld/PugmC99eQaXtfKPbLzrUR+
	 9ocWO73t+dZMA==
Subject: Re: [PATCH mptcp-net v3 36/50] mptcp: continue the last mapping after
 a fallback
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 26 Nov 2026 23:29:52 +0000
Message-ID: <179573579223.3133.15918575004608443729@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-36-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-36-416c0920c73f@kernel.org>
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

- [Medium] After this patch, a dummy mapping always continues in a
  straight line from the last mapping that went through…

--

mptcp: continue the last mapping after a fallback

After a fallback, this commit builds the dummy mapping from the peer's
last valid mapping (dsn_base) and no longer from iasn. Zero window probes
and reinjections therefore stop pushing later data into the out-of-order
queue. It also tracks the highest end of the peer's mappings (dsn_end),
and mptcp_try_fallback() now fails while the last mapping ends below it.

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 3590c1207e88b..f73e4b8deca42 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c

[ ... ]

> @@ -1438,6 +1440,17 @@ static bool mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
>  	return true;
>  }
>  
> +/* Fallback: dummy maps go on from the last valid one, unless it is old */
> +static void subflow_update_dsn_base(struct mptcp_subflow_context *subflow)
> +{
> +	u32 end = subflow->map_seq + subflow->map_data_len;
> +
> +	subflow->dsn_base = subflow->map_seq - subflow->map_subflow_seq + 1;
> +	subflow->map_old = before(end, subflow->dsn_end);

[Severity: Medium]

Can a resend that ends exactly at dsn_end still get stale bytes delivered
as new data?

A zero window probe, or a reinjection of the stream tail, ends exactly at
dsn_end, so before(end, subflow->dsn_end) is false. map_old stays 0, so
mptcp_try_fallback() still allows the fallback, and dsn_base is rebased
onto the resend.

Now say the next resend of the same byte has its DSS stripped.
get_mapping_status() returns MAPPING_NODSS, or the infinite mapping
status, and subflow_check_data_avail() jumps to the fallback label. That
segment is never compared with dsn_end. Its dummy mapping is then:

    subflow->dsn_base + subflow->map_subflow_seq - 1

That value is msk->ack_seq, so __mptcp_move_skb() delivers the stale byte
in order. Using the notation from the commit message:

    data     SSN 1 to 1000   DSN iasn to iasn + 999
    probe 1  SSN 1001        DSN iasn + 999 with DSS, map_old = 0
    probe 2  SSN 1002        no DSS, dummy DSN iasn + 1000, delivered
    probe 3  SSN 1003        no DSS, dummy DSN iasn + 1001, delivered

Probes 2 and 3 carry the byte at iasn + 999 again, and the application
reads them as new data with no error. The old iasn + SSN - 1 formula sent
probe 2 to the out-of-order queue, so the reader stalled instead.

The commit message covers this with:

  "unless the sender resets the subflow before, as it does since
  "mptcp: don't resend data acked without MPTCP opts""

A fully patched Linux sender does reset first for a repeated probe, via
the check in mptcp_sendmsg_frag(). Older kernels and other MPTCP stacks do
not. Even a patched sender still allows the first MPTCP-level
retransmission of data that was acked with MPTCP options. After an earlier
probe or reinjection, that case also goes from a stall to a duplicate.

The last patch of the series, "mptcp: reset when the DSS disappears after
a DATA_ACK", only covers this when the receiver's own data was DATA_ACKed:
subflow_nodss_is_fatal() requires dss_confirmed. It also skips
MAPPING_INFINITE, and it has no Fixes: tag. A stable tree that picks up
this patch through its Fixes: tag would turn a visible hang into silent
stream corruption against non-resetting peers, without that mitigation.

Could the receiver also treat a mapping that ends exactly at dsn_end, and
re-maps data at or below ack_seq, as old? If not, could the commit message
say that this safety depends on the remote kernel or stack? Today only the
note below the '---' line mentions "e.g. with an older kernel", and that
note is dropped when the patch is applied.

> +	if (!subflow->map_old)
> +		subflow->dsn_end = end;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124-mptcp-cmason-fixes-v3-0-416c0920c73f%40kernel.org
