Received: from mail-oi2-f25.google.com (mail-oi2-f25.google.com [74.125.231.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0E0282F09
	for <mptcp@lists.linux.dev>; Wed, 23 Sep 2026 03:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.217
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790134067; cv=pass; b=Iq6QFAyTH/JFomO/44io9i7d9TxIW/OI78oC1MUTFn2Vh+rwrTnKPoRDDzSSeg2f6H4ArOW4scSgOQEDGSQk+K7V86tM4QdbsUeHWGfMSyIMfscteWO/5LEjElnq/cdYz14UV/2trPifRpkTt+chk9lvXJ3QcmukOlKe3sw1UzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790134067; c=relaxed/simple;
	bh=7FP7Br//y1OOm2baAYLNpxwI3u+e9bB1wze46mmvCg0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=C0Wwd5ORTEQ4aW0fsigNWUyH4SX77qlwhhYK6wvu/0mvn9UrhLoQLgmqbffT9DQgEwv7HWdxm3aNzDmVY+pgkVFYmtP2OC+bLDgph8+3z2MAL71XIymCCuyn9GT434hQjTX6xbQeeIvs/ER8tnwqvgDRlwjiLDEZSdE8MZ7mNJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/kY7BGv; arc=pass smtp.client-ip=74.125.231.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/kY7BGv"
Received: by mail-oi2-f25.google.com with SMTP id 46e09a7af769-7f4f0d37dccso297151a34.3
        for <mptcp@lists.linux.dev>; Tue, 22 Sep 2026 20:27:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790134065; cv=none;
        d=google.com; s=arc-20260327;
        b=EGf14PJLLcZ6uDlTzWk74LpBbflPMCfwN9VbqaXx6eY60+aikSpYVGGOCx6OKwoBSd
         ClpEY0xiGb6n6B7dfxFtbxoZV++FhAeWA/poCdEzRvrlAs+jZPIEHlY5ybckLphrbLHg
         8FBT7XorgCaFzf4we3ba3yJY30++CiTQOoCFbbVT8+m/gIINfxN9xDpTWrVHDzRE9ikX
         LC/15t8q6v71piVhmGAdTLj7zNLsDri7fFjYco0FHO8y3xx0N9Ptp1ILDp/kVqziHA1L
         bc/AzCs/hciDbRZiM6UCAeer+hQl1zVMTp3ZJwMkqdV6aQMIY4h16as5Gr2UU/TyfDlg
         ey+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=96P6D85zwHV8yU/GixC0P2RdXOLb8VnCg7/SMO2S1SY=;
        fh=CvSqaocBEoKwS/W97vIZmwWTW98uaDI4X7e8tx5r/ZI=;
        b=KP3ZLk0kwKLT+uSlqbPTuBk+JTFgv5B8DmQMvYLqyYDspFrCxgD+JT+JZ0f3vKU3Cq
         Gy02g8B9P7HnRMD5UgrvBqNXrCc7GQF7qfDbG3ixlo8qjy/MdVgx9q1yDhwoYqs4lFcr
         inLnKmffS5BYyEqnJIOVYq9gvDI1YXNL9CLjkGaraBO5cEKatO64nBTjRi24tWH0Pf1A
         +srVlKOCA/uwBZ7Vg+VpXwzFtDsj5duzsPnJjZMkP8uzRTBFGVsrfA4ZXBd2N4nu1XP2
         f95PIuZ8agKVRrgeu9+eOho1QSQZyRaK1hqLtUhMWzGImTtBgeP4578XksUWuu0f5rkJ
         4HFQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790134065; x=1790738865; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=96P6D85zwHV8yU/GixC0P2RdXOLb8VnCg7/SMO2S1SY=;
        b=h/kY7BGvtPouQE+RoWQUDFPsGNENfg/fceXwH2jrSjG7r07YPPJE8HHS9eI1YfcPEk
         OwQq8W44bemAdxzysyupTnMn7tPBm2ufVQoP7IZoeQ/YytYJrRlmkEypiqSdCOJbLxlo
         zjeoba64AXH1HhbdrZj6Dx21+AcLLqYSg9MD8zTd56WuKGfX7YjTzRW9KFL/F2E7BKzP
         0FA5KO8962PnTY/BQSrv2s4N9qJFtSwjVuRg8qMU4C6JklXJghTAC57sm1ewSPesd44m
         hn5ZuFYUd/58i5g85Sw0oCiZX4Db+/Zygq7lQeISNpKTPyBLhtovRQ1N2QY8UYrec+aH
         rw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790134065; x=1790738865;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=96P6D85zwHV8yU/GixC0P2RdXOLb8VnCg7/SMO2S1SY=;
        b=jplH1E8HFSBZA+t2rhHNdDXRLy3Mk5O2YS70C3dGVe0OBqQCqJ6phL/4THAuXhu7NF
         liBpHlU+RbOj9OJkHpJ1sVTJ1CJ1b3NA5JidOQCtczYXHnYLuesy13Gp6tEPu8zC7Dvc
         /o3srxpZ2qTqeYujkelMb6Lf3OtnCpmpolTIgrrpM/Rnhq98pD5uz8XS4DgeI9h9nXi2
         D2N8vLfLZPhfnJ8ulTSC8Oig75W60R+x02tLPb6CZpNxT9CQ3crxOA68Oun1u2tZCTip
         P63FWHor4dhL9sY5psEAyYF4iOxByYLDmk5sHzLTtyA1gvw3pYvtK3LTb3NCNwK/OXVs
         TZpQ==
X-Gm-Message-State: AFuF++mzA3c38ksAgH3m6boXabdBq/1ygO3dMC2SxB4cWPrBxMBHTlls
	GQzJD4LQVBMwmcY/by2WSWSYYvVOD1c5DlYNR3ykqGak8fRCbjJ6qYVvejUrIYkOGqKWPA4oEBP
	PhLALFA356jKQPNzcukkRYnhY57Y+WWntacIlm5I=
X-Gm-Gg: AYBFou0W2W72O6xGJpqP1mRm5dxoQyL2KlgjH6+aHw4WXlzdmoJXy3g7gJo2TnMCdrE
	T6AluDdw2fqmxiZJzLIxwrIByg8u/mECC/hVsLRlzvCyanvCMsY8+a0T1qpvigSK0ldEEoBtijc
	2IrI+mD4iSwB+Nob/dH80h/uYu4bCkc7Evmc4lFTh0HQw1Q0fjVzpOI1PYxja+BcLjqWnQJxsVk
	DxWlgn1P09K1uUWwkbljt05clyrNQQQ1DxWnWIDCAQNqsZpl2Rpd7hTR/lfStiVT+o0iUxL2AWp
	gXTW6E9EwS5D6PF0mApvobYFmYfEYNSj/ug4b6NljW86/38WElOYInP9arnDl0kn9Atv5jIfI1A
	+OrDyJyU9J3URJ5skErAi
X-Received: by 2002:a05:6820:4cc1:b0:6cd:3fec:de78 with SMTP id
 006d021491bc7-6d2d350d966mr1047244eaf.78.1790134064688; Tue, 22 Sep 2026
 20:27:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: David CARLIER <devnexen@gmail.com>
Date: Wed, 23 Sep 2026 04:27:33 +0100
X-Gm-Features: AcwNN1WWogDInF68pGbNd4hj-4--ZF2HIxwLhgGz2PE-1J94fAfY9w2GodXlg0E
Message-ID: <CA+XhMqwA+x8kd4VjV_N7S9S7mCtAhr7FBc0ByKDQOTyU-PQr=g@mail.gmail.com>
Subject: [RFC mptcp-next] mptcp: TX timestamping at the msk level
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: Matthieu Baerts <matttbe@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi all,

After Paolo's comment on the MSG_ERRQUEUE series [1], I started looking
at msk-level TX timestamping. As far as I can see nobody is on it, so
I'd like to check the direction with you before writing code.

Today nothing arms tx_flags on the skbs built by mptcp_sendmsg_frag(),
so MPTCP data never gets a TX report. Roughly what I have in mind:

- keep the tsflags and the key (data seq of the last byte) on the
  dfrag, since the actual push happens after sendmsg returns;
- arm the subflow skb covering that byte, keeping its tskey in
  subflow seq space (tcp_fragment_tstamp() and tcp_ack_tstamp()
  rely on that);
- when forwarding SCHED/SND reports to the msk, rewrite ee_data to
  the msk key. I'm not sure yet how to do the mapping. The easiest
  option I see is a small per-subflow list of (subflow seq, data seq)
  pairs for armed bytes;
- emit ACK reports from __mptcp_clean_una() on DATA_ACK rather than
  forwarding subflow ACKs;
- seed the msk sk_tskey for OPT_ID the way TCP does.

The one I went back and forth on is reinjection: the same bytes can
leave on several subflows. Plain TCP already reports again on
retransmit, so reporting each transmission seems acceptable to me, but
I'd like your opinion.

Geliang, your MSG_ZEROCOPY series [2] touches the same spots (dfrag
layout, coalescing in mptcp_sendmsg_frag()). I'm happy to build on t
of it. Do you know if it's still moving?

Cheers

[1] https://lore.kernel.org/mptcp/d6cdbc83-86a6-4c2a-ad99-29cdb83566
[2] https://lore.kernel.org/mptcp/32bac661bcae143f7e63905dfb781c98e95cdde5.1784260668.git.tanggeliang@kylinos.cn/
