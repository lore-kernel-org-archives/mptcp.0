Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792936010;
	b=EwPee/opxA2IkrgA3jFIxgIDHUD7tgF6h9E/QHw9MsVyRBqojOGoV9AHvwJS0MSAfywQ
	 jiPTyM+61KAZ0qvQSKX0XrC3a2sxnxU/1XLzTHaPhtelI3t/5T2fCn60dW67D9oA4J+s4
	 /XuXr0Nu2QG6JofBmossLmhhTSeTcZZwjc3KjSuEmHpGEeonh8wbsLrFBnjExYSiz7KxT
	 cgvMX1b+BZVUw4PN2bXO/SPcwyRE4+YWUG7WrcE0cV2ObYlTgY3aWHkM1CF+wy/IfRnIN
	 hbh+DRzhbuF+mein8Jn2VRPSujhO1L/S8NcKHARfZ9pxLnPDsO2+72Rb8lIO87fGP5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792936010;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=cx6dGKGts5a4ECzllu2cm9X5N/ItzNgzInSQaVF5syM=;
	b=LqY3d+TGb3MDWsDdB/C8SBQ8CeiVbe7vlSywWLBK+IAmL8DL1BeQV0vbZbfEKUaHJk/w
	 8luoSux1JfYLVL1r0MoMx0iJEOi33tBuUR+Aqdcvq61a5XWU8yq6v3veRM9HA4UnNAYeY
	 TlQV9m/K0WLpAaZDg6ujbXqlid4QnSoqz8ENfmFinl2WSWzrSzTAXkUFaB1CVW3XUI6ok
	 lu2Wlw4bH2MvCOZihXwlh/qulDAYK1/r3CjQBypXfZZPgnruRvnbdb4gBUhUiDRUt3n+D
	 L+z7l5V+Kjg3P41B6eY0gqu01Y3ziBTwW3nRd+SlPpwGD+M5qb6KyohZLi2V1JV4Guw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=miSgyoKY;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D38606A31A
	for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 13:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24D38606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=miSgyoKY
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-18cdcfc05ffso2603275c88.1
        for <mptcp@lists.linux.dev>; Sun, 25 Oct 2026 06:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792936009; x=1793540809; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cx6dGKGts5a4ECzllu2cm9X5N/ItzNgzInSQaVF5syM=;
        b=miSgyoKYlDYRkb2l14/ik0J710ixVn//HNghROkNEDSAQonw+V+omJvvhxGIUIC9gA
         7QeKXUzsRTn66U6M0B+RXpEyAJl7nyusBJfFiuVF1d/JaeyyFbUPvfA4nicAALLvFGua
         jvB34wJCy9jw36Uava5HeNeuZxSFuSfJHhtUbZhFz8b5XDK3B7kM5En7l6B/+Zd78zlc
         K5rqRf/kYEIAh+XH1pelerms3spH9sOe1PjHprvif84BGymBUwQv//ioWlNRNFZKCa5c
         3sjZbm85X6M1B7V2G9JL3OCCXVsIbA9hwfVMtfqDKPuVUsgQqbOtotCA8+td4TcFeE0e
         A1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792936009; x=1793540809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cx6dGKGts5a4ECzllu2cm9X5N/ItzNgzInSQaVF5syM=;
        b=eLGFNdF43stdEeEicPIXvRX8BwpAlELYqdPBFx8UK9Z5Ad0NHYqTVw/FbNVFvIF1jw
         LTGYKjnT3OK5zsH+gPGONMW4ieMal5ld6np/IsmlMHEZv+LZGAc97YEnKIQIJdYbXcRu
         rJgjZzZ6YNDkXNyEAUGZZmHzckn0Ti+y7aMEc3CwLKHIsl4SraXZPNY3/uKtyuY2epBJ
         PagrDhRxrSKGuipEHeeA6l4fqa2UUwDXbx2OG4JzxSDIcyDvIiTrHFnM3rclybOytvyl
         mcTtFie+2EsjDNTwAAdkWVARcwbM1nZ1MT1HHRmssEqCquOrbWk9LmPSzhvr/6+ogbqf
         A6/g==
X-Gm-Message-State: AFq9FYI6qkg1C6kVl8ldiRHx5GrQjEXVNcAEN7/ZfOFeWRDUWhjkq0nV
	1Q8IUk6r9fu6H/hfCwTBJqVhpLdwB/gW+q5zaSxauLbU6JowWRos62vFob6mWw==
X-Gm-Gg: AYBFou264ykNLzGecFEw6kP1udEDHheQWK6Z8+wSdroGfFRMEWV0Gu1jSx0z3dRzKsK
	/+ULsmrkR7HxlA7NFJ+91YvWarmGiiTjASD6+Wg+AJJb2HTRWB2JF0aCuArz18LCZWr5G4lTKNQ
	i/CunLemX6inn/JAsE47vyHdNc17PzW0hSkmO/eLn0TVjF1GvJUf3JQgX2Vg6OMsz+d6PRRKaoR
	qgtolHl4lM3rTxHjJ5oVRg+YwQmvrr/ndGLS+6fuE+WqNL8gpR5IUI24Gx/Eh7PwS30gceWLOPN
	easwSxEczTZDgH/4hu+K6HbNPvAS3tICAmF0B6BRq8R3e1NRFmjFek5PIorHR+A/lLrJIbYPDAg
	HCaFBj+euavl5vYZ/oDPreaqtnytgcCVjnEYOupiZxce5zj0bOBExgadmUYz6aovt23rmG3uKSq
	hGsEkgofjcm28SMT3ZQ5JUC8L5gwLLgHaf5HNY/AFYsnd+ZKaXJ5bhu1PIk/jQDCIMycLAEdnNB
	EGrBYVWzB8dd78GT8/iY/PUIgmDvUIACHhj14pFNQ2wuJ+U2vVPRqZp2x+pBfiOhYbpDETtR/pm
	h6PbPA==
X-Received: by 2002:a05:701b:42c6:20b0:166:9e0d:3b50 with SMTP id a92af1059eb24-19937da2744mr6444366c88.42.1792936008869;
        Sun, 25 Oct 2026 06:46:48 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee5asm14740436c88.8.2026.10.25.06.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 06:46:48 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [RFC PATCH mptcp-next 0/1] mptcp: opportunistic reinjection on an idle subflow
Date: Sun, 25 Oct 2026 13:46:41 +0000
Message-ID: <20261025134643.1537069-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
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

This is an attempt at issue #332, the "opportunistic retransmission" of
section 4.2 of the NSDI 2012 paper, which the out-of-tree kernel had.

I found it from a multi-WAN router: a fast link next to a slow one gets
much less than the fast link alone, because data sent on the slow link
holds back the DATA_ACK until the receive window or the send buffer is
used up. With the default tcp_rmem, a 400 Mbit link next to a
15 Mbit/240 ms one gave 67-82 Mbit in total with BBR, and 30-142 with
CUBIC. With this patch it is 320-345, and uploads gain the same.

When a DATA_ACK shows that no new data can go out and an active subflow
is idle, the data the slower subflows hold is resent on it: the ranges
from the DSS mappings in their queues, not everything from snd_una. It
only does so when the copy can arrive at least one RTT of the idle
subflow sooner, and no more than the idle subflow can send in that time.
Without these limits it cost about 1% on simult_flows.sh's unbalanced
cases, and even waking the worker for nothing showed there, so the
decision is made before scheduling it.

A subflow that had a retransmission timeout and no progress since is
left alone: the copies would keep the MPTCP-level timeout from firing,
and with it the stale detection (mptcp_join.sh's "multiple flows,
signal, link failure" caught that).

Tested in netns on the current export, against the same kernel without
the patch: nine 2-path cases with BBR and CUBIC, 6 and 32 MB tcp_rmem,
uploads and downloads, 3 runs each and 16 for the slow lossy path.
mptcp_connect.sh, mptcp_join.sh (twice) and simult_flows.sh (16 runs)
pass as they do without the patch. The 2-path cases, mptcp_connect.sh
and simult_flows.sh also ran on a KASAN + lockdep kernel, with no
report, and on a KCSAN one, whose reports are the same data races in
mptcp_subflow_get_send() and mptcp_subflow_active() that it shows
without the patch.

Questions, since this is an RFC:
- It is in the core, for every scheduler. Should it rather be a
  scheduler hook (#344), with the default scheduler using it?
- The rules (slower, one RTT of gain, budget) come from my tests. Is
  there a better signal to use here?
- mptcp_oppr_check() runs on each DATA_ACK and reads the other
  subflows' queues and RTTs without their locks: is that acceptable as a
  heuristic, or should it be done differently?
- I could not find a short simult_flows.sh case where the stock kernel
  is clearly slower: the stall needs a few seconds of traffic to build
  up. Would a counter based test (OppReinject moving on a lossy slow
  path, with the data checked) be enough?

Abdul Wasey (1):
  mptcp: opportunistic reinjection on an idle subflow

 net/mptcp/mib.c      |   2 +
 net/mptcp/mib.h      |   2 +
 net/mptcp/options.c  |   1 +
 net/mptcp/protocol.c | 291 +++++++++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.h |   3 +
 5 files changed, 299 insertions(+)

-- 
2.43.0

