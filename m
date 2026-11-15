Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794739994;
	b=p4/WKpRTygOAE4z3SjlXsZWHzXegVCuGUzrtEZ9v87rGa2IcfnGKWKR2ClFC+ghJRD8d
	 OT/iUCFVooKXZB64M6TdCzEClgCTn6ycgWmClZWWBh6mKDhFNYuK7Z7GyHNdXdq2M5MvF
	 gq8tbd2i0myYeqO0kZK4hMTy1FBfM6OPVoYFPrbgd/FTIlrmyO7PZQTkmVefNNRF/UKOz
	 M4rdpYoS2YlpVfwPa1nHpDAgZJgeeaaLpe/avhMz8KkTInQDWDGSMWFoIqsdBDSlG2NHE
	 U5sj7KsDx0aVMhWbAfeHgCatNslHvcTUbkMfeIcFX4q1/h6kTW6kD6ihUgUlU+XCuIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794739994;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=KbQ6rOX3dd66aLBll3DcLedoKFf24tiVXx/AEK//lBw=;
	b=bJzInvBpZT7rzE0vEP4Jo+aTUQI03fjRZc2O/dnTiyYiClVpf1Qpp74cOwJ83y/OyLj6
	 qYLeBXN0LUByL0m/jhCpY+xNsEuzToZ7bbf1pNm24Wg9Vcr6ozvn9w0qerhwGIU329nz3
	 e0DPYxnm26i/4uJNV4vfO6YWmAhIoj8gp05iP+WBpseZeFYQXV+e7lpkf3y0qAzMLIRiY
	 MAr+Fjlf+2A2V2B2Px6jiH+Sdi655gcIpduod8c2BNofina0QJ1pOnZtOG9JQAB9tbwWe
	 Xxd83RYtGO68jyyuM75lj54Bmnj1BfynHmPXn/zznBhBvrDhWRO4Mv72uyuotzlDmaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IKpz/JLJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC540606A329
	for <mptcp@lists.linux.dev>; Sun, 15 Nov 2026 10:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IKpz/JLJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D6A1F000CC;
	Sun, 15 Nov 2026 10:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794739993;
	bh=KbQ6rOX3dd66aLBll3DcLedoKFf24tiVXx/AEK//lBw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IKpz/JLJPOgR8g0HDLwrFrwtmY966K7HOV9AlXfD0De+AxNXdwejXK3xtldjCMtch
	 8U3NmodFGJCyQ+aKzpN4QQUITVYYSBkJ6Lzu4+QGsYn7mREIW6bEayakpDTkNvX5I7
	 aJsBmC9mnJB0zMudrPvA8fMq4vzEO+WJ++PCBkmCBJgqUnOPz+2n3zOqj4BER4zb6q
	 uCoNGYQM/lqnTYpkR9E7/i1JKoWDEnNL64KMnlCgGjGYyF6l9Z+yAPAR9WbViGTnl3
	 Fm90lD/TW5VSGdqPVBdj1FkvTEs5z9G72Eblewcu+ucyDFmWNgfDL55dIReDQzzBGY
	 6GAIVTBk99lDA==
Subject:
 Re: [PATCH mptcp-net 33/34] mptcp: continue the last mapping after a fallback
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc:
 mptcp@lists.linux.dev, mason@kernel.org, pabeni@redhat.com, kuba@kernel.org
Date: Sun, 15 Nov 2026 10:53:13 +0000
Message-ID: <179473999309.488855.6325364258827719226@kernel.org>
In-Reply-To: <20261113-mptcp-cmason-fixes-v1-33-9205b77e9a2f@kernel.org>
References: <20261113-mptcp-cmason-fixes-v1-33-9205b77e9a2f@kernel.org>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] After a fallback that only the receiver makes,
  net/mptcp/subflow.c:subflow_check_data_avail() hands the sender's…

--

mptcp: continue the last mapping after a fallback

This patch tracks two values per MPC subflow. dsn_base is the DSN - SSN
offset of the peer's last mapping, and dsn_end is the highest end of the
peer's mappings so far. After a fallback, the dummy mappings are built from
dsn_base instead of iasn. mptcp_try_fallback() now refuses to fall back
while the peer's last mapping ends below dsn_end.

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 64e8f5c36415e..728b27be1ad04 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c

[ ... ]

> @@ -1434,6 +1436,17 @@ static bool mptcp_subflow_fail(struct mptcp_sock *msk, struct sock *ssk)
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
> +	if (!subflow->map_old)
> +		subflow->dsn_end = end;
> +}

[ ... ]

> @@ -1528,9 +1544,8 @@ static bool subflow_check_data_avail(struct sock *ssk)
>  	subflow->map_data_len = skb->len;
>  	subflow->map_subflow_seq = TCP_SKB_CB(skb)->seq - subflow->ssn_offset;
>  	subflow->map_seq = __mptcp_expand_seq(subflow->map_seq,
> -					      subflow->iasn +
> -					      TCP_SKB_CB(skb)->seq -
> -					      subflow->ssn_offset - 1);
> +					      subflow->dsn_base +
> +					      subflow->map_subflow_seq - 1);

[Severity: High]
If only the receiver falls back, can this pass duplicated bytes to the
application?

Once MPTCP_FALLBACK_DONE is set on the receiver, get_mapping_status()
returns before it reads the mpext:

	if (mptcp_check_fallback(ssk))
		return MAPPING_DUMMY;

So every later skb gets a dummy DSN of dsn_base + SSN - 1 here. This
happens even when the sender has not fallen back and still put a valid DSS
on the skb.

Here is a sequence with a zero window probe:

1. The sender sends DSN [iasn, iasn + 1000) at SSN 1..1000.

2. The sender sends a probe at DSN iasn + 999, SSN 1001.

3. The receiver handles the probe map as MAPPING_OK. In
   subflow_update_dsn_base(), dsn_base becomes iasn - 1. The probe ends
   exactly at dsn_end, so map_old = before(iasn + 1000, iasn + 1000) is
   false. The probe byte is dropped as a duplicate. The receiver's ack
   still carries a DSS, which clears old_data_pending on the sender.

4. A middlebox strips the DSS from new data at DSN [iasn + 1000,
   iasn + 2000), SSN 1002, and the receiver gets MAPPING_NODSS.
   subflow_nodss_is_fatal() returns false because dss_confirmed is 0, for
   example on a unidirectional flow. mptcp_try_fallback() passes both the
   map_old and old_data_pending checks. The dummy DSN here, iasn + 1000, is
   correct.

5. The receiver now acks without MPTCP options, so the MPTCP rtx timer
   fires on the sender. __mptcp_push_retrans() resends DSN iasn + 1000 at
   SSN 2002. Because old_data_pending is 0, mptcp_sendmsg_frag() does not
   reset the subflow.

6. The receiver maps SSN 2002 to dsn_base + 2002 - 1 = iasn + 2000. That
   equals msk->ack_seq, so __mptcp_move_skb() takes the in-sequence path:

	if (MPTCP_SKB_CB(skb)->map_seq == msk->ack_seq) {

   The application then reads the same 1000 bytes twice.

The subflow is only reset later, the next time the sender tries to send
old data from mptcp_sendmsg_frag(). A reinjection whose map ends exactly
at dsn_end appears to follow the same path.

Before this patch, the dummy DSN after the probe was one too high. The data
stayed in the out-of-order queue and the reader stalled.

The commit message acknowledges this:

    One case is left: if only the receiver falls back after a zero window
    probe or a reinjection, it now delivers the first MPTCP-level
    retransmission of data that was new when first sent, as new data, before
    the sender resets the subflow

Should silent duplication in the byte stream really replace the stall
here?

The later patch "mptcp: reset when the DSS disappears after a DATA_ACK"
only covers MAPPING_NODSS when dss_confirmed is set. Unidirectional flows,
and fallbacks caused by MAPPING_INVALID, still look exposed at the end of
the series. Could the receiver keep using the DSS on retransmitted data
after a receiver-only fallback, or reset the subflow in that case?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-mptcp-cmason-fixes-v1-0-9205b77e9a2f%40kernel.org
