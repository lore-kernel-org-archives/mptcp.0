Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795735791;
	b=ut2f4UVHoO9Ua/Rw7bAioYNu5OuqoXYseIzKkXp9gGn/6LwmdfOM3TQK9iHkp7cdtarA
	 xQCEmZQlHfEuKT8Hse3/iew8GnRUIHPGnujBBT4paJsqYkdTzNA4oo9Bw+esejoNzv/Oq
	 YRIEEKBjhbkWsis0NYK/VZ2wIHgC6OqSddDKGnNmr9rXo3Sjl0F7CcRX3fcFkQCa8k2Kg
	 nRvmYVaiHPr0Vv6V5jGLdAeeM8zCrLtp5i/VqpwDyX0engwR7MfG0RvzCEr0Pn2pncXpH
	 Het/eYTeu/HO9XG9rocJDqiWpQyen+EAyTSWhz0adLcRVcopKrs3MFFc2n6wfO0+Ylw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795735791;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=12i8dKsnoW/JuaRNawT4/uXE+7vUNBQwd58NOQBPnLM=;
	b=jo/LCfWjWkHr6SEmGgFcyNsaBcnvR7/dUR+At7CEm32TgGFYdHf3UFZQgbUyxW4WVaTY
	 T374nAPF4Pz0sQYHuBBtGFfoU3cAsWbmSbft5ca9pwWKlmjEnmI4ZCFYmIXZ9WSFl2HoI
	 0OplkrWO6hmiVU2BjFalICzSnkoTTHO612uE2uBOLgmz5QZMIswnikrNUpHVoB755Kx67
	 uxH5nsYHyIR7fVqnQnC8IJ1g3iDsHtUei0++H3sa/wPG7dfjBOBe0I8WiYq83nZsxtebB
	 A8U3jco8jDMDhqZ/fmq60eEo2KDVv0MnDOf6dtLi2KqHWoJcFK1QS16muMyCWP472Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ot3uz5tQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E58606A31C
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 23:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ot3uz5tQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0E41F00897;
	Thu, 26 Nov 2026 23:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795735791;
	bh=12i8dKsnoW/JuaRNawT4/uXE+7vUNBQwd58NOQBPnLM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ot3uz5tQnhvyrPJQuSulWtdDf/3rPwb3osCZ7Qr5HwHuGHYMMAnqoAzQGcaLLAn8g
	 QtHI1CfSHNII4MRwAZYCO70AoAQC3Hv4g89F5g8ivVsL2tVyV0LXQ0LhDu4cPSTaIx
	 0GcTsrgtxJY0Ji4AOypdlh/inOGsdaRa/alm8fNIxzqVV2bOeeZaUchQY29RaDAOpn
	 YacnqsWBXTq70k+Hfvj1YHkwLCb/zphJG9UGi+I5KNxwHH6COZP4RBLEJRaJqRAxaf
	 VkxWoYQ/Q81XGtxJteKP5rLVdwHPOVgKYL1WdrmiWqPZ7gVFKjtN8+BWJgKNhWf15u
	 i3h1Mbt8Mn0kQ==
Subject: Re: [PATCH mptcp-net v3 26/50] mptcp: keep room for infinite map
 after fallback
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 26 Nov 2026 23:29:50 +0000
Message-ID: <179573579047.3133.1366405625682103965@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-26-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-26-416c0920c73f@kernel.org>
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

- [Low] The comment in mptcp_sendmsg_frag() (net/mptcp/protocol.c) is now
  misleading in the very case this patch fixes.

--

mptcp: keep room for infinite map after fallback

After an MP_FAIL, the msk can fall back to TCP before the infinite
mapping has been sent. The next skb was then sized without room for
the DSS option and ended up larger than the MTU. This patch keeps the
DSS room in the MSS computation while send_infinite_map is set, until
the skb carrying the infinite mapping has been created.

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 736e55532296b..6b1a3994fb494 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -891,9 +891,11 @@ int mptcp_established_options(struct sock *sk, struct sk_buff *skb,
>  	opts->suboptions = 0;
>
>  	/* Force later mptcp_write_options(), but do not use any actual
> -	 * option space.
> +	 * option space, except for an infinite mapping still to be sent.
>  	 */
> -	if (unlikely(__mptcp_check_fallback(msk) && !mptcp_check_infinite_map(skb)))
> +	if (unlikely(__mptcp_check_fallback(msk) &&
> +		     !mptcp_check_infinite_map(skb) &&
> +		     (skb || !subflow->send_infinite_map)))
>  		return 0;

[Severity: Low]

This isn't a bug, but does this change make the comment in
mptcp_sendmsg_frag() in net/mptcp/protocol.c misleading?

net/mptcp/protocol.c:mptcp_sendmsg_frag() {
    ...
	info->mss_now = tcp_send_mss(ssk, &info->size_goal, info->flags);
	copy = info->size_goal;

	/* After the fallback, the MSS no longer includes the DSS option of the
	 * infinite mapping: send it in a single segment.
	 */
	if (unlikely(mptcp_subflow_ctx(ssk)->send_infinite_map))
		copy = info->mss_now;
    ...
}

With this patch, the MSS path (skb == NULL, via tcp_send_mss() ->
tcp_current_mss() -> tcp_established_options()) keeps the DSS room
after a fallback as long as send_infinite_map is set.

Take the early fallback case from the commit message, where the msk
falls back after receiving data without DSS while the infinite mapping
is still pending. Here info->mss_now does include the DSS option, even
though the msk has already fallen back.

The single-segment cap is still needed, but for another reason. Once
mptcp_update_infinite_map() clears send_infinite_map later in this
function, later MSS computations no longer include the DSS room. That
covers tcp_write_xmit(), tcp_current_mss() and retransmits. The comment
does not say this.

The code under this comment is the same at the end of the series. Only
"&& !old_data_pending" is added to the condition.

Could the comment be reworded, for example:

	/* Once the infinite mapping is sent, the MSS no longer includes its
	 * DSS option: send it in a single segment.
	 */

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124-mptcp-cmason-fixes-v3-0-416c0920c73f%40kernel.org
