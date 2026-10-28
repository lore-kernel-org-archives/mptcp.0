Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793227269;
	b=4XHVw3Ys8e6iyZRgXS+pBJ02GkKENFXDyjaW6xnywhYkgAw/gbwg2qd8a6vO7X3sb///
	 ajQ+MXNy5C+4PUv58GXdmbAyN+9ZVhoPQWShMFPxnCLyFuI1kYab+l01/bMR7VIevMQZm
	 g2J5yzzLCk/1vlA3TNLsTuXyhHo3glF/AIJiD1YeRjHjCoOGREnGg/VwrYyLgyO3Em9PN
	 rwKYfq7NC2fS8hV9eZ8Z5DI18ilYRvLGE6fprpjqioanrc4jJrzLO7vDvSxdIuDbvdN+W
	 8BBwuxP0nADB63GBYbH9GTs2ZXGO2PTB8bJLV8hkylzkLZosXElYkmdWFSH1ZpHy7vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793227269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ce2Gk8fOgQe1PhUjV+bQcuP/zG1jBfhOuNYtP5PlP2k=;
	b=M2/UIs//BOsq8Nn2XEkglKOzbFQuEvO5uYF7KCo+tK9VPD9UKkLYc/z26K1tgvmvoqQC
	 WdB65JOSxZCdVYXXZty/jDgegXIKP5KqPXIOt6XLkkRwGXpLhHBix1aM5ma6ilrzt4dFk
	 3ibUAv4ihbi+cBDu6wtpt4NdEVB/nTuyZEwywfwCjyhut/4AEocYowArSMOusIVeUb+Vd
	 IbDyvfmOWz2FBJMOjO8lUfnqA6gQtFiuBvke876LZJmfLypmnj9J7/4D/IrEaxnSrBzuf
	 AgRN+mT0MJ4JkOJcboxa5pffqy8oNOrnUxfWiFvoalj8/zjzZ1xZI18hm8cR3ds5diQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="pMcp/jn9";
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED69E606A31C
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 22:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED69E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pMcp/jn9
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-369f3e9e431so108170eec.1
        for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 15:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793227268; x=1793832068; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ce2Gk8fOgQe1PhUjV+bQcuP/zG1jBfhOuNYtP5PlP2k=;
        b=pMcp/jn9yvqC/r0dPNwp9H4OTAVHCAvWENyoTzr1S+2IUE6b9bYv4edD8Bm3H1YHAx
         KBBsLh+qIEnKcZSD3Z4+5u5RoRslojDs4k/CvWgfhD5iMt3vITPq/Z87JzyRnEJrW+b0
         Fa5jIJZY9pz4JUSVGnoKyOeYNN+i8Nt3iBCuDAfjhoyfz7A9vbsB77s11QdlVCCu39+p
         DudcUVQKcT5dQ1/27BE0b537ZOu70h8I7DSQtA0YA0pNebv/6oXAe+egm8bswc0zkE/m
         5Rkn0n74pAaJnb4SEFhXR0L99ahatChiF0WFFEvEI7hewXxqKb+a69hHE9KaxM9x+Ot9
         n/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793227268; x=1793832068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ce2Gk8fOgQe1PhUjV+bQcuP/zG1jBfhOuNYtP5PlP2k=;
        b=PCWy+fB3U1oItl70CspO8V8ol38q0RsOljUooU4dHloL/eDVM4xQfrFFbR3e4vfp+L
         HLrAAV1b8sC8/kTJ8fA1pxjx2+sS2bV2fFE8r2CSbJWfR5p5QD+0c/ZPNGcyx73u2F8U
         76MIecaG09tjYaA/O9Y46hL6HsRCMkV1MKoCoTd/B+UHHM+cnwOTPXmfM7Bl7BbocNox
         UZbcKl0mrw7RFn5KIyBJ/6XxKnkpPwNM54R+qMXeu78HWaV3bsnL16p18pFON8UmzriS
         y5sBvd91sxKu6Pl+NvwGYn4tZe5NrQMlL2YRgRKkMnOgqcdaq1pcPZpwAaPPGjnX/uof
         RMUA==
X-Forwarded-Encrypted: i=1; AKwUvBwlUwVrf1fLuHSlYLoV4fOdcBCiQbBS1mj+h5nVIkB70dMgREQdCLyji+TwwKGL04SHpwKTzw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLSfljOO//mi8jsYcrxjWziMvKxY3m7pdoshmgIIsoml7/fk7f5
	kmtIzxBPpeW2AOfbEFczEJtk05H4BEWNtp1v5JRWNPzUmA/qtgG96xFX
X-Gm-Gg: AYBFou2lYUuxrgUWEAj7zOeRiuW2iyxHaI1ONbrUu0Evbi/Wwrbt9sa9etQ3v2zuTaq
	oHwJmqV9utRJN/anVZ8HUD+ZnkJ1ln9ipzWpnSO1OYeNYYUrSfKk9r9msd0R722DWHIYEKYK157
	pnczeoN/hXVn1PprN/bK7qWILUb0gGrh+AKbzZYsQy+TYZi3j2pNMJpkPko4Mxvp00MYpSBZSNJ
	6NGUfT4JTqa/9WM+lGAbjvC1lQBQVnZ0yZiRS5yStePtQ49RXu+neMyyBTa2AVCAEUrDg5fppGG
	CdfOXjyJCQ1ishG9Htyg89PLQr4/hqTwdiEBnAGSv1R9SbchjsWHlXAtDy9UvZiogb+9LGOVsTx
	vXAwUEIjYSB15qiaYRzVLPEWlB7xJMxkAeU/nEI4OGhI/bUhL7sjqIuin8hfNLCVgztzfVEDQP/
	cuR/ZZ1AkwhKoYPaugGGBbESqkXq+ItxYux5SSTnBKmm2iMP3wC9Uz2B55fpl8B8Ar6TfK7VGuI
	thLM5UQbxeudMTopKXXmNLoUgzB/9xXyYTvPN8I9SLL46uiMAl8eiFKKoNsZX2s09X8Cuo9VJlh
	bf/KdCqz66dFl/hjRqANA9HSE0qUUJXxipd7lMSBG1SrmC0tStL9doM=
X-Received: by 2002:a05:7301:e0c7:b0:369:f1ca:5b24 with SMTP id 5a478bee46e88-36a2fd55b12mr973282eec.6.1793227267907;
        Wed, 28 Oct 2026 15:41:07 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a239d3073sm11937005eec.29.2026.10.28.15.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 15:41:07 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: Shardul Bankar <shardul.b@mpiricsoftware.com>
Cc: Matthieu Baerts <matttbe@kernel.org>,
	mptcp@lists.linux.dev,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Gregory Detal <gregory.detal@gmail.com>,
	janak@mpiric.us,
	kalpan.jani@mpiricsoftware.com
Subject: Re: [RFC PATCH mptcp-next 0/1] mptcp: opportunistic reinjection on an idle subflow
Date: Wed, 28 Oct 2026 22:40:59 +0000
Message-ID: <20261028224059.3657607-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6ac6cd6f5c7d67c598ae34bbf3bcf6a0edd0e983.camel@mpiricsoftware.com>
References: <20261025134643.1537069-1-w453y.me@gmail.com> <5e0ccd66-205f-4055-8ab3-4d300e83fd48@kernel.org> <20261025155848.1745712-1-w453y.me@gmail.com> <6fbbeca8-836c-46cf-a8de-73ecd127b932@kernel.org> <6ac6cd6f5c7d67c598ae34bbf3bcf6a0edd0e983.camel@mpiricsoftware.com>
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

Hi Shardul,

On Wed, 2026-10-28 at 11:59 +0530, Shardul Bankar wrote:
> I have not started on it, so please go ahead. I am happy to review the
> series as it comes.

Thanks, I will take it over.

> mptcp_oppr_blocked() treats an empty send queue (mptcp_send_head() ==
> NULL) as "blocked". first_pending is NULL once everything the
> application has written so far has been handed to a subflow, which
> happens when the send buffer is full, but also when the application
> simply has nothing more to write at that moment.
[...]
> Requiring the msk send buffer to be (nearly) full on that branch, i.e.
> sk_wmem_queued >= sk_sndbuf as __sk_stream_memory_free() tests, would
> separate the two.

Right, it also fires when the app has nothing to write, and the commit
message doesn't say that. I tested that case before changing anything.

Same netns setup as my v4 report, download, BBR, 5 runs. The client
asks for 1 MB, reads it, waits 100 ms and repeats for 20 s. p95 time
per request, in ms:

                         export   RFC   RFC + your check
  40M/10 + 2M/250 5%      2396    317    1448
  400M/10 + 15M/120        530    104     528
  40M/10 + 5M/100          530    305     473

A paced stream (64 KB every 50 ms) shows the same thing. With the
check it's back to about the export numbers. The end of each burst
waits on the slow subflow while the fast one has nothing to send, and
that's where most of the gain comes from. The copies cost 1 to 3% of
the bytes, and nothing on two equal paths.

The check also lowers the bulk result on the 40M + 2M pair from 33-38
to 26-31 Mbit/s, because sk_wmem_queued drops below sk_sndbuf as soon
as a DATA_ACK frees space.

So I'd keep it and fix the commit message. In the scheduler series I
can pass the reason (window, send buffer or app limited) to the
scheduler, so it can skip the app limited case if it wants.

> One more observation: #345 and this work both act on "this subflow is
> slow", one by halving its cwnd and the other by copying its data
> elsewhere.
[...]

Agreed. I'll base the series on your v5 and look at that then.

Thanks,
Abdul Wasey
