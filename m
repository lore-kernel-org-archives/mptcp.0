Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C42D31F98E
	for <mptcp@lists.linux.dev>; Fri, 14 Aug 2026 01:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786672085; cv=none; b=Fle5USYsijAxZ2Rpl/ztO3xw0p5Utw8p+kid2txsa3FkGObqklh1BK1sKBiVnhF4j7+7JmLxHgaK1E6evnnkgc0htFnSzMy9zjk1LsiLFjoBVzWHQ//oLL2eKeIC91jCuSa7m4QRGeyGRbVeaSkjL/vMQVZCFf5sK9aJ5drtycg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786672085; c=relaxed/simple;
	bh=jbesiX7U93dOUZMW7NAXaqpbdayV8W8EbQDoctvs4J4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IrBnHC1DzzSVb0KgpG7F4CM9S0r/E5eLfLbnid2f9ICpjzDrTLbxTeFGc8jLGaal1P37ozuJSBInZlG+z91d8kPnZ9/xjraGcqn+1/2Xl7Bfbr3wa+zV/T0qRsoKldAVhv+487o5701ZqEA9WZsRl8I1H3UHuQDPNM6TMykibOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmlAQAOx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmlAQAOx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BFC1F000E9;
	Fri, 14 Aug 2026 01:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786672084;
	bh=3VOoWPO8FoL2kBeSPr7I2SCFgKsLmcKzgJGAU40WwPY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=GmlAQAOxpcuMdlcnKExaMtw7e8yyRWVRnBdZck6hVbWN589nvroOG6e9GiQsfdf36
	 D/v+6dnfbmOcziyZoHpvLyIOMRFKmStPwmDuWJ760Vk7Kv4h/LFU5yssh++omPqGHP
	 e76m24cfsQhTuNuKGdJKUJc+Fi20LwyvWyVzwqWLyEnHNvhEoa66zUjvl/fO9/HlFu
	 pDpON7UqPfGxxbogMROdSdoPpNPXBA+2nFZIsdYQzE/Bnj3lnGPpGv3urzIyahCqOQ
	 UApXGtuMJ4kgMbEdJZV4Tr69MR4tkrdkXSNZQByg6oXmU9vTBSgKF5Hj8wBJ70SeEr
	 ZpE/ucM6Xe1Zw==
Date: Thu, 13 Aug 2026 18:48:03 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
cc: MPTCP Linux <mptcp@lists.linux.dev>
Subject: Re: [PATCH mptcp-net v2] mptcp: options: handle MPC data + csum reqd
 + no csum
In-Reply-To: <20260805-mptcp-opt-mpc-csumreqd-no-csum-v2-1-dbb52e01a36d@kernel.org>
Message-ID: <20f3ef05-aebd-84b0-55a6-8ed35c79d07b@kernel.org>
References: <20260805-mptcp-opt-mpc-csumreqd-no-csum-v2-1-dbb52e01a36d@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Wed, 5 Aug 2026, Matthieu Baerts (NGI0) wrote:

> Before this modification, a remote peer could send an MP_CAPABLE with
> data, with the checksum flag set, but without adding the actual 2 bytes
> of checksum. As a result, uninitialised bytes could be used for the
> 'csum' field.
>
> That was not a critical issue, because this 'csum' field is only used to
> compare with the expected one, if previously negotiated in the 3WHS.
> Worst case, the checksum is likely wrong, a fallback is done without a
> reject if the negotiation was done earlier. That's OK.
>
> Yet, better to take the expected path with this case: only look at the
> checksum flag for MP_CAPABLEs not carrying a data-len.
>
> Such packet can be seen as a 3rd or 4th ACK. The RFC8684 mentions [1]
> that the 3rd packet should have the checksum flag set. When an MPC + ACK
> contains data, the checksum flag is redundant with the checksum field.
> It is not clear what should be done for the 4th ACK, nor if the flag has
> to be set if the checksum field is set.
>
> Therefore, it seems fine to only look at the presence of the checksum
> field, not to break the interaction with stacks that were not setting
> both.
>
> Fixes: 208e8f66926c ("mptcp: receive checksum for MP_CAPABLE with data")
> Link: https://datatracker.ietf.org/doc/html/rfc8684#section-3.1-23 [1]
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664%40kernel.org?part=1
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
> Changes in v2:
> - back to my pre-version, only set CSUMREQD for non MPC + ACK + DATA
>  with a longer explanation about why it is OK. (Sashiko)
> - Link to v1: https://patch.msgid.link/20260805-mptcp-opt-mpc-csumreqd-no-csum-v1-1-cb2ad0b9feac@kernel.org
> ---
> net/mptcp/options.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index e1b38fe5faf8..73cec164d8bd 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -93,7 +93,8 @@ static void mptcp_parse_option(const struct sk_buff *skb,
> 		 * In other words, the only way for checksums not to be used
> 		 * is if both hosts in their SYNs set A=0."
> 		 */
> -		if (flags & MPTCP_CAP_CHECKSUM_REQD)
> +		if ((flags & MPTCP_CAP_CHECKSUM_REQD) &&
> +		    opsize < TCPOLEN_MPTCP_MPC_ACK_DATA)
> 			mp_opt->suboptions |= OPTION_MPTCP_CSUMREQD;
>
> 		mp_opt->deny_join_id0 = !!(flags & MPTCP_CAP_DENY_JOIN_ID0);
>
> ---
> base-commit: 064fb643fcfcdddbad6da71da8f1ab206f018af7
> change-id: 20260805-mptcp-opt-mpc-csumreqd-no-csum-3f145fa19c4d
>

Yes, this looks like a good tradeoff between not breaking interaction with 
other stacks while avoiding an invalid checksum.

Reviewed-by: Mat Martineau <martineau@kernel.org>
