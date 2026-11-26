Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795735801;
	b=tgkwBPJT8CB7zgaBAO2kPbeoZpEpdNgQBvIp2LsVWUXiHsSYDqKZbdRzxabYmUjy6rcn
	 ggdcbfF9QjXuPRapX4L2YpCFzq2xngGyMxY2vrTt5Kz+W8NVeMvsrSwNPBwK3NFNQLQBh
	 40+fWYV/eYBw1aKaQMiet7mXa7PH4QeGIu6WB/DmJKKx9n1iyiJfPGY4mUksJ2REyMfuH
	 NzfLSG93cNA5DRJszIfLYNFWBBnxY4IuN2YV1FVZLni9xybQ0qYyEL4LARVN+qZMU+DZC
	 gbpjcaiLVXmRGP0KEmlKdkyNC8H6PqbcrxZ2Pwk+nCSfsTYNAHUVHapJ7YsiS+t5gPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795735801;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=VpCpCO+C7SnL+1IpbQu6SCpuw3cLABlt6jpGnPBXfPA=;
	b=GnPXU55ZXYQYuRZrdaDJzP/wVl9DlMRVvV06GGG+zSX037khGXFty3SNYnUzTZsvpAN5
	 9jKFuog8Zt4yyjo4xOwZFTesdFos7mXEAAIWRRuh79kYiD/85oJSB2O0rMGVe+VwflcmP
	 bEA3g8/iqjVvcEVLLHAqqPGKG8dj56pTL0HSge7NP4LJI2DjppM89Odbx4Cc2o4nVUbfs
	 46hf9PboHNA7kvplt388bt564SWGXzEYOB3Tcrtu5a7ZeB6bQjqBqqRPU+XP4Pj30bb7d
	 BFqlosGaGTRpP9e9lptqdXt0qfjmgVRTT+6q5sRbq1XDioWPlLqliGYmG1tdbMpqRrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TiBkYa8I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65386606A31C
	for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 23:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TiBkYa8I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864A61F00896;
	Thu, 26 Nov 2026 23:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795735800;
	bh=VpCpCO+C7SnL+1IpbQu6SCpuw3cLABlt6jpGnPBXfPA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TiBkYa8Ivyn1MKfXpiF/zKd/9KbmAybwh+FMKMyYC6LyczSrCKYfL82VostqBxigy
	 7BRJEjMw7g+gW1CSiTMddHxuuygwP1B17ZY0PlnsTutOVyNBkot8TE6vDDKhDI6A32
	 e73WW06FxfCISe7PnayGLH+4J2VrcnOlV/HfZK8NstJJ8GUO1vv1f/03+x2dbgaKW1
	 SQgOsDOelXSMijsQQtBYlIENdPH3v6iAt39ku4hfIu6pbAiHwYKTqtmM5KcFTfrFFc
	 ticcGqA+nT1bn3T2sDAglEftcpO4y9nxFF6uuSFR9QeSx2m/Z0yq1VxrDTgIQzZv+S
	 xYylHn975pbhw==
Subject: Re: [PATCH RFC mptcp-next mptcp-net v3 50/50] mptcp: reset when the
 DSS disappears after a DATA_ACK
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: mptcp@lists.linux.dev, kuba@kernel.org
Date: Thu, 26 Nov 2026 23:29:59 +0000
Message-ID: <179573579993.3133.10747290585204924101@kernel.org>
In-Reply-To: <20261124-mptcp-cmason-fixes-v3-50-416c0920c73f@kernel.org>
References: <20261124-mptcp-cmason-fixes-v3-50-416c0920c73f@kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch is incomplete: after a DATA_ACK confirmation, an skb
  that runs past the end of its mapping still makes the receiver fall…
- [Medium] The MAPPING_INFINITE exemption ('but not for an infinite
  mapping, the fallback signal from the RFC') does not work when the…

--

mptcp: reset when the DSS disappears after a DATA_ACK

Following RFC 8684 section 3.7, this commit resets a subflow when it
receives data without a DSS, or with an invalid mapping, after a DATA_ACK
on that subflow acknowledged sent data. The exception is an MP_FAIL
exchange in progress. ack_update_msk() sets a new dss_confirmed flag, and
infinite mappings get a new MAPPING_INFINITE status so they still fall
back.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/519

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 41eb39968a9a6..e561143dd1219 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c

[ ... ]

> @@ -1356,8 +1359,8 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
>  	/* we can't wait for recvmsg() to update the ack_seq, otherwise
>  	 * monodirectional flows will stuck
>  	 */
> -	if (mp_opt.use_ack)
> -		ack_update_msk(msk, sk, skb, &mp_opt);
> +	if (mp_opt.use_ack && ack_update_msk(msk, sk, skb, &mp_opt))
> +		subflow->dss_confirmed = 1; /* MPTCP opts pass both ways */
>  	rwin_update(msk, sk, skb);
>  
>  	/* Zero-data-length packets are dropped by the caller and not

[Severity: Medium]
What happens if the peer sends its infinite mapping on a zero-length
segment? For example, a pure ACK could carry a DSS with data_len == 0 and
a DATA_ACK that acknowledges our data.

dss_confirmed is set here, before the zero-length check that comes next
in mptcp_incoming_options():

	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq) {
		if (mp_opt.data_fin && mp_opt.data_len == 1 &&
		    mptcp_update_rcv_data_fin(msk, mp_opt.data_seq, mp_opt.dsn64))
			mptcp_schedule_work((struct sock *)msk);

		return true;
	}

No mptcp_ext is attached in that case, so get_mapping_status() never
returns MAPPING_INFINITE for this segment. The peer's next data, sent
without a DSS, then gives MAPPING_NODSS.

Without a prior MP_FAIL, allow_subflows is still set. So
subflow_nodss_is_fatal() returns true, and subflow_check_data_avail()
resets the subflow with MPTCP_RST_EMIDDLEBOX instead of calling
mptcp_try_fallback(). Before this patch, the same sequence fell back to
TCP.

Linux itself only attaches the infinite mapping to data skbs, after an
MP_FAIL, so this depends on how other implementations send it.

Should the MAPPING_INFINITE exemption described in the commit message
also cover this case?

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 190c75311ff69..efbd3efd379ed 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c

[ ... ]

> @@ -1523,7 +1542,9 @@ static bool subflow_check_data_avail(struct sock *ssk)
>  			return true;
>  		}
>  
> -		if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSFALLBACK)) {
> +		if (((status == MAPPING_NODSS || status == MAPPING_INVALID) &&
> +		     subflow_nodss_is_fatal(msk, subflow)) ||
> +		    !mptcp_try_fallback(ssk, MPTCP_MIB_DSSFALLBACK)) {
>  			/* fatal protocol error, reset the subflow and let the
>  			 * worker close it
>  			 */

[Severity: High]
Does this cover all the invalid mappings that the commit message
mentions? The message says:

    The same is done when a mapping is invalid, e.g. when it does not cover
    the received data after a resegmentation by a middlebox, ...

validate_mapping() only checks the start of the skb against the mapping:

	u32 ssn = tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
	...
	if (unlikely(!before(ssn, subflow->map_subflow_seq +
				  subflow->map_data_len))) {

Take an skb whose payload runs past the end of its mapping, for example
two segments merged by a middlebox that keeps only the first DSS. It gets
MAPPING_OK here, and with checksums disabled (the default) it is
accepted.

The mismatch is only caught later, in __mptcp_move_skbs_from_subflow():

			if (unlikely(map_remaining < len)) {
				DEBUG_NET_WARN_ON_ONCE(1);
				mptcp_dss_corruption(msk, ssk);
			}

mptcp_dss_corruption() still falls back without looking at
dss_confirmed:

	if (!mptcp_try_fallback(ssk, MPTCP_MIB_DSSCORRUPTIONFALLBACK)) {
		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCORRUPTIONRESET);
		mptcp_subflow_reset(ssk);
	}

The non-FIN branch in __mptcp_move_skbs_from_subflow() calls it in the
same way.

On a single subflow with allow_infinite_fallback still set, can the
receiver then fall back on its own after the DSS was confirmed in both
directions?

That is the late receiver-only fallback this patch is meant to remove. An
older sender keeps resending data at the MPTCP level, and the receiver
delivers it as new data.

Commit e32d262c89e2 ("mptcp: handle consistently DSS corruption") notes
that buggy peers can send corrupted DSS options that hit these paths. So
they look reachable from remote input.

The note after the --- marker already says that mptcp_dss_corruption()
still falls back after a DATA_ACK, but that note won't be in the
committed changelog.

Should mptcp_dss_corruption() also apply the dss_confirmed check? Or
should validate_mapping() reject an skb that extends past the end of the
mapping?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124-mptcp-cmason-fixes-v3-0-416c0920c73f%40kernel.org
