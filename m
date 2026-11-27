Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791871;
	b=rTc/iGpMGX8UjsDc7/Sb9X3Ht6OBngv5ETadvoR+DZbbVJZWO1ayQ7BoB/A5lOz94cvO
	 rvx//5b/pmOjvMwZAVgfsbsE+WP7O3Rd+FVw2BdpImsGXJK+AF0js+WUjEUDGiu5oKIUW
	 mCUYc5lcPpPM2AR5w3k/J6R1LBqNxxSOFAQBGWxpcGGtbZuJsH1WQnkQab00SmeWaCueX
	 WCpOmEYj6e323Vbb2fiFKC7qxLP5r678kTUV/Jgy5PqDhuYUT7WS625nB5lmKM0WIazAe
	 jQnTOdpLAab0iv9uLYN1xAKheynbbQIUK/34eGcZWdjVjOVcmZgINFR1U9vSvmCd6TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=evZv5hVWWdGZaCGpsWgw0bSasbGvdKzP09x7/rjAc+Y=;
	b=ovyiOFbnyF7gLFGM5jijmfaLdIFiir3iio0KBOx6W4KzhxjiGDlyimQ5w0dmehepTWsx
	 UY0oZhOu1iNLyNC9v/iwzkpP0h/kUZkzfDmHpopo9C37gkzVxP+x/nDFyuVNKVH3dZwc5
	 dMEuoG7tJmBaJ7TC04WMYHi9+puzQua9fFYJQVXxkjCmQRf/ZcFIyntyPSH0a9XmEs3DQ
	 eCQXvMd2sRpOsd+EfylLHdngN1fiN/0mEcagvpIDys947X4xRnpa55Atpr8MC7umIBTof
	 MU4bLGQPXYRdhJQfERrAt4JhY2rpSnNMJIjAVRH+Q+W6VkMrnG/p8P/W2Kky4faiZGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sBS+Kwv1;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A99C606A31E
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 15:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A99C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sBS+Kwv1
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3863db981d4so11545518eec.0
        for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 07:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795791870; x=1796396670; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=evZv5hVWWdGZaCGpsWgw0bSasbGvdKzP09x7/rjAc+Y=;
        b=sBS+Kwv1apsr0sXvwSxl9Yf43o85aG5Jq+OMMSW040A5eQu/SmemhPtgBZpXXbznfX
         0DNYrXB1110BlbMiro4ySva9yo8jn4wWofa/nOS23rwTEaegsVEOytv5+iXgaV3/5/hy
         IAkOMttgYskE68cPq6jp0Gz9e06dmQgWSJrZfBMEm4yBYeKWHVfxTj+dowbp4K+xDIIt
         DqskPuWGxHXA9PmhbrdKkHjbvCsSTz0lxW1eH5nfb0mnYqIhfCpf1761FKcg068bMMe4
         BCDQSTDVVgyFr3fnaGofqbVKhjiDPJ+R1VB6KGwdhrj+gF3jtv3PVZeURSnKhrbcbuYk
         yl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795791870; x=1796396670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=evZv5hVWWdGZaCGpsWgw0bSasbGvdKzP09x7/rjAc+Y=;
        b=fmnzlh2pkDpqhddEGvQsskhQhPh/VTb9/DWzraCQTXkAcS0+4VFPPLYwBQxDe+KOpD
         bxc70VxHmSNmDJ9StWBF9NN7DYYouIVsH9TQci1jw5T25NUYUrbH4wTHZ/U0U6/DHVbM
         omk8BST49ql47EDxH60VjBT71f2jVt6O5Ic4aCKxBiHF38WJRc5JPgn8FrsG+FX5uXFe
         11/DX9KonrphDxFqePSIgfCTgiM8m3JQRyORXtPy9z7cLQ+WCERgsQdk0+w11fqPFTCI
         w1z5+R1gz0apZcxjhrTjBSx9y7rVSf9V/fNtMYY8dA6X4j+5e2I/6TH1Afg3xp9S0t5r
         DUxQ==
X-Forwarded-Encrypted: i=1; AL+hErGW/EiNJUCrg1QqgpXglrlVwgwsWsHX4/tlRa3urrVDyalI5PRmR4XuUXajOEavbD5CCUk9Gg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9POsPF5IO3yPZNkHcXOpOcT7AST8HmqVpHbrTkrsLDw8TOGA0r
	Fdv8Zqee+GXXFHeicBUPCeWC4oJ16QBpSAe9NLdsTGEQ2ulnTiP1odKml+dG2/7N06ncHg==
X-Gm-Gg: AZFdTZfq7NJNyhn2K2CKEzp8KbARwMT3VS2/9O2CBg+YeavVnsKnrKQyBiwtmfw/Y9A
	blvH6JhPSUlVTH7p7Intx88JGreCaUY+vvMbERmFKQc9ksOIzlMsEiRaoHsihz77WgdIMjKtOhv
	IyT9I6dWpVVw5nDgn5l+hUStcT9Gnr8w+Hr8eFSrxYl8Fm4rxclTVvd6qNvrzQNU3f3aoEJJQM/
	ZtlVfaltuz7mroFel/HqZP6idkhcd+NH0n2Db9KzOwX/bv4eckpmuP03FUlVRjZ4c9bDEhysuUR
	88b9KAfCyDXLFBquVHVQkwqfTih+s+1CO+TDI/qQxLjFt2Rb0SwbeARy5pFMETHkeWZjGN4Er3D
	S6+3JizSTcwqdbCt90hleRtj+wHo9RXTcDQ4cuyDwEORmNe90FwqkRGUKAmDD6c2V1aORYZsweJ
	aHZK0dssQRpUPXMppE+0U/2RZms69THhZ07rlh4r1hKImVgF+6ysMBEKfvPRVMX83QWMkAhb2/T
	0HIksNx66+08yORUFgAPhkrvHg53IWH67TZ6VgLPH1JiAgdajSpQuyW1j7pcD9vYyeihpTwMZx1
	voB/9uavLrjFcc2h8S22MaGKol16YYC+oPJMsISYWweOvw==
X-Received: by 2002:a05:7301:929:b0:376:37a2:87f3 with SMTP id 5a478bee46e88-38570f25262mr22505837eec.31.1795791870034;
        Fri, 27 Nov 2026 07:04:30 -0800 (PST)
Received: from localhost ([2605:52c0:1:e99:982a:f6ff:fe2e:6e83])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385665f21aesm87628909eec.4.2026.11.27.07.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 07:04:29 -0800 (PST)
From: Lin Lei <llleigoing@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	llleigoing@outlook.com
Subject: Re: [PATCH net 2/3] net: bound receive window predictions before narrowing
Date: Fri, 27 Nov 2026 15:04:25 +0000
Message-ID: <20261127150425.1393380-1-llleigoing@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAL4WiiqM1E9wzfjCzHcOy2SN6j0CjN6r94JYdPNt=RoLLDL5hw@mail.gmail.com>
References: <20261117052200.1507847-1-llleigoing@outlook.com> <20261117052200.1507847-3-llleigoing@outlook.com> <CAL4WiiqM1E9wzfjCzHcOy2SN6j0CjN6r94JYdPNt=RoLLDL5hw@mail.gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Eric,

Sorry for the late reply -- it took me some time to put together clean
WAN reproducers and check the tracepoints carefully before getting back
to you.

Reading your comments on patches 1 and 2, I realize my v1 changelogs
did not explain the failure mode clearly and conflated two separate
issues:

  1) an implementation bug where 32-bit wrap coupled with the
     unconditional rcvq_space.space update can leave sk_rcvbuf stuck at
     its initial value across subsequent steady in-order streaming; and
  2) the pre-existing overshoot of the slow-start heuristic itself on
     burst or backlog samples.

I think it is clearer to look at them separately. Replies inline below.

On Thu, 19 Nov 2026 08:56:32 +0100, Eric Dumazet wrote:
> What happens today: this round gets a smaller sk_rcvbuf increase than
> the formula asked for (or none). sk_rcvbuf never shrinks here, and
> the next measurement has a sane @oldval. So we lose one step.

Looking closer at tcp_rcvbuf_grow(), it seems this can lose more than
one step -- once @rcvwin wraps, sk_rcvbuf can stay stuck at its initial
value across subsequent steady in-order RTTs (barring an OOO packet
hitting tcp_data_queue_ofo() or another multi-RTT stall).

In tcp_rcvbuf_grow(), tp->rcvq_space.space is overwritten with @newval
at the top of the function, even when u32 @rcvwin wraps and
sk->sk_rcvbuf (and therefore tp->window_clamp) is not updated:

  void tcp_rcvbuf_grow(struct sock *sk, u32 newval)
  {
          ...
          oldval = tp->rcvq_space.space;
          tp->rcvq_space.space = newval;   /* updated unconditionally */
          ...
          rcvwin = newval << 1;
          ...
          grow = div_u64(((u64)rcvwin << 1) * (newval - oldval), oldval);
          rcvwin += grow;                  /* wraps in u32 */
          ...
          rcvbuf = min_t(u32, tcp_space_from_win(sk, rcvwin), cap);
          if (rcvbuf > sk->sk_rcvbuf) {    /* false after wrap */
                  WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
                  WRITE_ONCE(tp->window_clamp,
                             tcp_win_from_space(sk, rcvbuf));
          }
  }

Concretely, taking the values from the TCP trace below (rtt_us = 100000,
ooo = 0, scaling_ratio = 158):

  1. Initial sk_rcvbuf = 6,382,000 gives tp->window_clamp = 3,938,890,
     with initial oldval = 14,480.

  2. After an initial receiver stall, a measurement sees copied =
     3,987,000 and inq = 39,096, so net @newval = 3,947,904:
       - tp->rcvq_space.space becomes 3,947,904;
       - the unnarrowed prediction is 4,297,614,134 (2^32 + 2,646,838),
         which wraps in u32 @rcvwin to 2,646,838 -> rcvbuf = 4,288,547;
       - since rcvbuf < sk->sk_rcvbuf, neither sk->sk_rcvbuf nor
         tp->window_clamp changes.

  3. Now tp->rcvq_space.space (3,947,904) exceeds tp->window_clamp
     (3,938,890) by 9,014 bytes. (tcp_measure_rcv_mss() clamps
     rcvq_space.space down to window_clamp only when scaling_ratio
     changes.)

  4. Across the rest of the 64 MiB steady in-order transfer with
     continuous reads, each ~1-RTT sample stays below 3,947,904, so
     tcp_rcv_space_adjust() keeps taking:

       if (copied <= tp->rcvq_space.space)
           goto new_measure;

     no further tcp_rcvbuf_grow tracepoint fires, and sk_rcvbuf stays
     at 6,382,000.

A similar lock-in happens in mptcp_rcvbuf_grow(): once
msk->rcvq_space.space is set to 3,963,800 (with oldval = 14,600,
wrapping 4,296,650,602 to 1,683,306 -> rcvbuf = 3,215,868 at
scaling_ratio = 134), sk_rcvbuf stays at 6,553,600 (whose full-budget
window at that ratio is ~3.43 MB) throughout steady streaming.

> For TCP, the slow start branch is only taken if the RTT is above
> tcp_rcvbuf_low_rtt (1ms by default). I guess you had to change this
> sysctl to get this result over loopback ? Please describe the full
> setup, including tcp_rmem[1].
>
> More importantly, reaching tcp_rmem[2] after a single 4MB burst is
> not a goal. What is the user visible problem here ? Do you have
> numbers (throughput, drops, rcv window) for a real flow ?

Yes -- my v1 loopback test for TCP had lowered tcp_rcvbuf_low_rtt
(MPTCP has no low_rtt check). To test without touching that sysctl, I
reran over a simulated WAN on 7.4.0-rc2 (mptcp_net-next commit
800508bf1ccd, keeping tcp_rcvbuf_low_rtt = 1000 us and tcp_timestamps =
1 at defaults, with tcp_wmem raised so the sender is not
send-buffer-bound):

1) WAN reproducer setup and results:

   I tuned tcp_rmem[1] and the initial write size here specifically to
   land inside the narrow (~1.8 KB on TCP, ~1.6 KB on MPTCP)
   non-growing wrap window and verify whether the flow recovers on
   subsequent RTTs; I do not have data suggesting this narrow window is
   hit frequently on mainline.

   Trigger conditions:
     - Path: two netns over veth + tc netem with 100 ms RTT and
       1 Gbit/s (BDP = 12.5 MB), MTU 1500, TSO/GSO/GRO disabled.
     - Budgets: tcp_rmem[1] ~ 6.1-6.25 MiB, tcp_rmem[2] = 64 MiB,
       tcp_wmem[1] = 16 MiB on TCP / 8 MiB on MPTCP, tcp_wmem[2] =
       64 MiB.
     - Traffic: Phase 1 queues an initial burst before draining so that
       the resulting sample lands in the first 4 GiB wrap window (on
       Phase 1's drain for MPTCP, and as Phase 2 starts for TCP);
       Phase 2 streams 64 MiB with normal continuous reads.

   Results (Phase 2 application goodput over 64 MiB):
     - Plain TCP (tcp_rmem = "4096 6382000 67108864"):
       * unpatched: SO_RCVBUF stays 6382000 -> 6382000 -> 6382000;
         trace_tcp_rcvbuf_grow fires once (time=113917 rtt_us=100000
         copied=3987000 inq=39096 space=14480 ooo=0 scaling_ratio=158
         window_clamp=3938890); 64 MiB takes 1.823s (294.4 Mbit/s).
       * with v1 patches 1+2: SO_RCVBUF reaches 67108864 and 64 MiB
         takes 0.767s (699.8 Mbit/s).

     - MPTCP (tcp_rmem = "4096 6553600 67108864"):
       * unpatched: SO_RCVBUF stays 6553600 -> 6553600 -> 6553600;
         trace_mptcp_rcvbuf_grow fires once; 64 MiB takes 2.019s
         (265.9 Mbit/s).
       * with v1 patches 1+2: SO_RCVBUF reaches 67108864 and 64 MiB
         takes 0.815s (658.8 Mbit/s).

   Standalone reproducer scripts for TCP and MPTCP:
     https://gist.githubusercontent.com/llleixx/5201855b015831b5377a02478f843949/raw/repro_tcp_lockin.sh
     https://gist.githubusercontent.com/llleixx/5201855b015831b5377a02478f843949/raw/repro_mptcp_lockin.sh

2) Original workload (your question on patch 1): I first ran into a
   stuck receive buffer on an Ubuntu 6.8 kernel with default tcp_rmem
   ("4096 131072 6291456") on MPTCP over a high-jitter path; in a local
   6.8 reproduction of that setup, sk_rcvbuf stayed at 131,072
   alongside msk->rcvq_space.space = 16,282,074. (On 6.8,
   mptcp_rcv_space_adjust() kept rcvwin in u64 but narrowed at int win
   in __tcp_space_from_win(), and its older msk rtt_us caching could
   allow a longer sampling interval.) While auditing current mainline
   from there, I noticed the u32 @rcvwin wrap above as well.

> This needs @newval to be ~256 times @oldval between two consecutive
> measurements. The "allow the sender to double its rate" logic was
> never meant to be meaningful for such a sample: a 4GB prediction
> out of 4MB copied to user space is garbage, wrapped or not.
> [...]
> What happens with your patch: a single sample like this sends
> sk_rcvbuf straight to tcp_rmem[2].
>
> This is the kind of sk_rcvbuf inflation we have been trying to avoid
> lately, see commit aa251c84636c and the tcp_rcvbuf_low_rtt logic.
> I am not convinced this is an improvement.
> [...]
> If there is a real case where growth is too slow, I would rather
> discuss the heuristic than the type of @rcvwin.

Agreed -- a 4 GB prediction from a 4 MB read makes no sense, and
jumping straight to tcp_rmem[2] on a single burst is undesirable.

It seems this overshoot is inherent to the current formula rather than
caused by widening @rcvwin: even on unpatched mainline, with
oldval = 14,480 and scaling_ratio = 158, a burst or OOO release of
~382 KiB already yields rcvwin > 39.5 MiB and sends sk_rcvbuf straight
to a 64 MiB tcp_rmem[2] (~342 KiB already reaches ~51 MiB). Around
~3.95 MB, the u32 wrap turns that overshoot into the lock-in above.

Following the comment above the formula ("slow start: allow the sender
to double its rate"), one option (with u64 @rcvwin) might be to cap the
growth ratio (newval - oldval) / oldval at 1:

  grow = rcvwin << 1;
  if (newval - oldval < oldval)
          grow = div_u64(grow * (newval - oldval), oldval);

That leaves rising samples up to 2x unchanged while bounding larger
jumps to a 6 * newval window (~3.6 MiB rcvbuf instead of 64 MiB for a
382 KiB burst, though a 3.95 MB burst still yields ~36.6 MiB). Since
genuine slow-start samples can exceed 2x slightly (e.g. ~2.2x in commit
aa251c84636c's trace), this would still need to be evaluated against
the slow-start workloads from aa251c84636c to check the ramp-up vs.
peak-budget trade-off.

> If you send this again:
>
> - net-next, no Fixes: tag, unless you can show a real regression.
>
> - Please split TCP and MPTCP changes. One patch with a "net:" prefix
>   touching both, with a single Fixes: tag pointing to a TCP commit
>   is not right for mptcp_rcvbuf_grow().
> [...]
> Same remark about the Signed-off-by: than for patch 1.

Understood -- for any follow-up patches, I will target net-next without
Fixes:, split TCP and MPTCP, and fix my From:/Signed-off-by:
consistency. On patch 1, I also agree with your point about huge
best-effort SO_RCVLOWAT values.

To summarize:

  1) The 32-bit @rcvwin wrap coupled with the unconditional
     rcvq_space.space update is an implementation bug that can leave
     sk_rcvbuf stuck across steady in-order streaming on both TCP and
     MPTCP, rather than only losing one step.
  2) Jumping straight to tcp_rmem[2] on a burst is a separate
     limitation of the current unbounded slow-start extrapolation,
     which could potentially be tamed by bounding (newval - oldval) /
     oldval (e.g. at 1, subject to slow-start benchmarking).

The above is just my personal take on these issues -- I would really
appreciate your thoughts and advice.

Thanks,
Lin
