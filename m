Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EE036B936
	for <mptcp@lists.linux.dev>; Wed, 30 Sep 2026 04:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790741383; cv=none; b=XhBemozxEaKicJ5olBJUSaNgJeIBgmjs4avrG08BjRd6XMngSQ0OMzn7PvLJrP7k7DLD6hzATkdDChfDa62Ehi6Yo5h6H+0ROOz4YTM1jz4bpfld823PLi+6fBp6rVHSGNYypkC6+eYYr3LMqYEttbwnem3ZNkpDfSv12zw67Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790741383; c=relaxed/simple;
	bh=+yq8NlJAEiu9n1emE/3TntH4A+5lqP60DjkVvz9UulM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FhBPqoUnLPBAjaVJ5csYtSDVJXB3VggWNZkusUdQAX3HlqwJbsXNCRaI68yiBMUCZ8RoQKD2T3U57Z2xr6mHF13Ja9SCQoEbEfujk7Snj6gWH6F2NSmmf98LK6ps1+GPBd0T6QftxawVCYZnmurmd0/t9jSZcQ02vARvXnGZDx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKOSzKCj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKOSzKCj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E461F000FF;
	Wed, 30 Sep 2026 04:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790741382;
	bh=OyEy4fUc3PblvXrcTgS3XMHP5+UzDAaCYtUFfQjXmgc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VKOSzKCjTU/y02rMoC/T7gtNvUiogsX9z9WepkEx/LQAWhf9V7N7lcGwAXsJ+BJXz
	 icbtZhBNT1eu4NvIGTNjlgNUOPlpmkjaI/C4Z5cOf5+xVEXuf0UwMUIjzKdhJz5Vz5
	 LrqkjBUKbNMXZCyiy9T7Ze6cmE7gDrrI/la57Li8bwlrUZ59i8IP6dxGB7zsvPi094
	 u6nFalu6wyTUcxZzyBkA720mfpU9FGiMk4k6/7w6/NKZHWwys/cuFXG/2Cc5WlbYcM
	 MfiMseh7lOcXvBjdVBaNZJR58nklJKg8qxl1n4fMmkJDym1jT2zcE++emGNcIkfFtA
	 JMpCVpAJbppfg==
Message-ID: <90d9bf08ccc7c52cf7791654737509fffb149dfe.camel@kernel.org>
Subject: Re: [RFC mptcp-next] mptcp: TX timestamping at the msk level
From: Geliang Tang <geliang@kernel.org>
To: David CARLIER <devnexen@gmail.com>, MPTCP Linux <mptcp@lists.linux.dev>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>,  Paolo Abeni <pabeni@redhat.com>
Date: Wed, 30 Sep 2026 12:09:19 +0800
In-Reply-To: <CA+XhMqwA+x8kd4VjV_N7S9S7mCtAhr7FBc0ByKDQOTyU-PQr=g@mail.gmail.com>
References: 
	<CA+XhMqwA+x8kd4VjV_N7S9S7mCtAhr7FBc0ByKDQOTyU-PQr=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi David,

On Wed, 2026-09-23 at 04:27 +0100, David CARLIER wrote:
> Hi all,
> 
> After Paolo's comment on the MSG_ERRQUEUE series [1], I started
> looking
> at msk-level TX timestamping. As far as I can see nobody is on it, so
> I'd like to check the direction with you before writing code.
> 
> Today nothing arms tx_flags on the skbs built by
> mptcp_sendmsg_frag(),
> so MPTCP data never gets a TX report. Roughly what I have in mind:
> 
> - keep the tsflags and the key (data seq of the last byte) on the
>   dfrag, since the actual push happens after sendmsg returns;
> - arm the subflow skb covering that byte, keeping its tskey in
>   subflow seq space (tcp_fragment_tstamp() and tcp_ack_tstamp()
>   rely on that);
> - when forwarding SCHED/SND reports to the msk, rewrite ee_data to
>   the msk key. I'm not sure yet how to do the mapping. The easiest
>   option I see is a small per-subflow list of (subflow seq, data seq)
>   pairs for armed bytes;
> - emit ACK reports from __mptcp_clean_una() on DATA_ACK rather than
>   forwarding subflow ACKs;
> - seed the msk sk_tskey for OPT_ID the way TCP does.
> 
> The one I went back and forth on is reinjection: the same bytes can
> leave on several subflows. Plain TCP already reports again on
> retransmit, so reporting each transmission seems acceptable to me,
> but
> I'd like your opinion.
> 
> Geliang, your MSG_ZEROCOPY series [2] touches the same spots (dfrag
> layout, coalescing in mptcp_sendmsg_frag()). I'm happy to build on t
> of it. Do you know if it's still moving?

My MSG_ZEROCOPY series is still moving forward, but it will wait for a
while, since there are other series to handle first.

I found that I have a local patch "preserve the rx timestamp when
coalescing skbs", which I added while debugging some feature earlier.
It might be useful, and I'll include it in the next version of the
MSG_ZEROCOPY series too. Something like:

@@ -178,6 +178,13 @@ static bool __mptcp_try_coalesce(struct sock *sk,

            MPTCP_SKB_CB(from)->map_seq, MPTCP_SKB_CB(to)->map_seq,
            to->len, MPTCP_SKB_CB(from)->end_seq);
   MPTCP_SKB_CB(to)->end_seq = MPTCP_SKB_CB(from)->end_seq;
+
+  if (MPTCP_SKB_CB(from)->has_rxtstamp) {
+          MPTCP_SKB_CB(to)->has_rxtstamp = true;
+          to->tstamp = from->tstamp;
+          skb_hwtstamps(to)->hwtstamp = skb_hwtstamps(from)->hwtstamp;
+  }
+
   return true;
 }

Thanks,
-Geliang

> 
> Cheers
> 
> [1] https://lore.kernel.org/mptcp/d6cdbc83-86a6-4c2a-ad99-29cdb83566
> [2]
> https://lore.kernel.org/mptcp/32bac661bcae143f7e63905dfb781c98e95cdde5.1784260668.git.tanggeliang@kylinos.cn/
