Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6222F4EB55
	for <mptcp@lists.linux.dev>; Mon, 27 May 2024 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716815878; cv=none; b=lCKVj82hSNre1YftmONgP5bOWqpJPezjAFA9E7Xexbiv+WXZ/kXybxns7M4gRanNaZQuLVFoGslwiu1VI8ubTkuq/O5kwQkEf2alUt5SaqbKT5KVzYScBjZT2qScOAq9D8MaYtVa5QY+YabtxoLAH2vHdTnSO74K9xqoYeu/aps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716815878; c=relaxed/simple;
	bh=PyAZDVLFtlElDD1T73D2X8vusE4Xnx93oRalmQoR0fA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FSdnqNCs+BBxZSt4Fmd+EGw7UGndUriVVIovxmK8eiLY0v9MBlr8BPUE7XyPMvDVt1wBVUMaifIVhNPYRC4y3F+L/2QHOxv05Phpungpe2rz4ToizqKLUK4UBx6pnQ4mFqbjPyNt1I7V1jfqWZ+MunzV8UVHz2GNDHnlfuny/Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwhu3GEb; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwhu3GEb"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5786988ae9bso2626645a12.3
        for <mptcp@lists.linux.dev>; Mon, 27 May 2024 06:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716815875; x=1717420675; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2GGvUHHy5naZ9KldGRBmA1h3nqMUojb2YUPaRf5OvIo=;
        b=fwhu3GEb1mcz7zOPJUAYPtAnl7lJdj9pGNp3KNG5Sm6Cu5T9O2Cuz+SRVakuvcd/uL
         29pY4BWHpH+ERgiitiSAT+dPSD3nYNIOtvcPME8r4ndG8B5M/mJodUx9fREtzLsOlQ9P
         +Pyv8jm+cOLNLDRR2o0eWA+SZPCOct0xWyWSdwXy/1usYWQ4/gYeSUzk+1BRNegupAGK
         LodlNFahTQu0YNFAup9tz71UwZ7YyPFBsSVSyNRPm5JNGRknzEoWZkUBqpv/AIgD26AY
         +MEg6tvwCaxTPBvgeN9dAAB049JIasX+3+T5SwNOOUiSZVMzvzP3J9tbFz3miLyloYKO
         nkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716815875; x=1717420675;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GGvUHHy5naZ9KldGRBmA1h3nqMUojb2YUPaRf5OvIo=;
        b=Qkp3iSTSzK8CivH0lJZ4OtRERh1G2Omj+zk2VgRpt+JeEnbMg93RLtDSos5blQE+5U
         tBGu1wpE1oSmNcvOV1qr9BkkY8C7mNKmbtoQ49128HvH3BrU5Xk6KHjfm5IDzJkqa1kq
         abytPx+GJ0g25j9cZXlo8XEr4vjoxWtCUnIg/d0NdDBx2JbJxZtciARJCigwQsU/zPkX
         xAVFEmSYsfVIQ+7+K0vDqPojPtStHbNa/lMiGjbJylghc8aoR43Y/CVJNsE3Bldbrqed
         Dqj93V3s6jU5UrUHtnw9LTl1CJ+Gf/N9koJqlFiA6T81ADqs3zRoTsQuGcXE7wODkOmk
         hZ9Q==
X-Gm-Message-State: AOJu0YxBaTeB+kUtsKuO+5iGrcj2ky/fiV/z3U/C4pOEFAc+KbN9qpB8
	Q2Mr72VJJ4U2C7JTb6nOsvS/lAesTQHpBAM9MpJA047+N8EG8LV4SGspJJMD
X-Google-Smtp-Source: AGHT+IHW8AxA/6LLyVpWNnqs6MYg8SWXOwTLckSwQoj9il6qtvHgu3TtDGMAKmMfQ6VdUQZBuiNttA==
X-Received: by 2002:a50:a402:0:b0:573:5c4f:27a8 with SMTP id 4fb4d7f45d1cf-57851a1ed5emr7102591a12.35.1716815874381;
        Mon, 27 May 2024 06:17:54 -0700 (PDT)
Received: from [127.0.1.1] ([2001:41d0:700:80a3::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5785240d1f9sm5799272a12.51.2024.05.27.06.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 06:17:54 -0700 (PDT)
From: Gregory Detal <gregory.detal@gmail.com>
Subject: [PATCH mptcp-next RFC 0/4] mptcp: update scheduler API
Date: Mon, 27 May 2024 13:17:51 +0000
Message-Id: <20240527-sched_per_packet-v1-0-09a41d405f7c@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP+HVGYC/x3MQQqDMBBG4auEWTeQ2lhCt4UeoNsiIsmvDmI6J
 KEI4t0NXX6L93bKSIxMD7VTwo8zf2PF9aLIz0OcoDlUU2Maa1pz09nPCL0g9TL4BUWHO6x1Dq2
 Fo5pJwsjbf/mhVYoXHbEV9X49qTuOEw4lUeByAAAA
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Matthieu Baerts <matttbe@kernel.org>, 
 Gregory Detal <gregory.detal@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716815873; l=3139;
 i=gregory.detal@gmail.com; s=20240430; h=from:subject:message-id;
 bh=PyAZDVLFtlElDD1T73D2X8vusE4Xnx93oRalmQoR0fA=;
 b=bCqLXUtGVqOLFjB2AXo9Ri3bxL8hDd4G4qKmrXnk+VTYsCoB1QE0CJyEVZMnPLD3xzbu7UtUI
 w8W+zP9GSPLCgUJBDd7fS5yPjeE60n7jtm8rtqCa1xnsmCjXwG+gQ/p
X-Developer-Key: i=gregory.detal@gmail.com; a=ed25519;
 pk=TziJDop3YEG3Ywr6io7U9Iy2jaAY3l0hTh8KdwDKXQM=

This patchset proposes an updated API for mptcp schedulers to provide
more flexibility for future scheduling strategies. This does not change
the current behavior of get_subflow. It adds an optional hook to control
scheduling behavior after selecting a subflow in get_subflow.

The main idea is to provide a way to perform a scheduling per-MSS or per
chunk of data. To demonstrate this, the mptcp_bpf_rr scheduler has been
modified to send one MSS per subflow in an alternating fashion.

The other potential application of this API could be to define a
scheduler that will proactivelly reinject data on available subflows
based on some heuristics (eg. when one subflow RTT increases when moving
away from WiFi AP). It could also allow to limit the usage of a specific
subflow, eg., in the case of high BDP.

I am mainly looking for feedback to see whether this design make sense.
Matthieu already did a quick pass on it.

The API introduces a push() function (name TBD) that takes the subflow
and data chunk (sequence number and length) as arguments. The scheduler
can then control packet scheduling by:
- Setting data transmission limits (e.g., per-MSS on a subflow or per window).
- Setting flags associated with the data. Currently, only
  MPTCP_SCHED_FLAG_RESCHEDULE is defined, forcing the scheduler to call
  get_subflow after sending the chunk.

I am envisioning another flag MPTCP_SCHED_FLAG_REINJECT that will ensure
that chunk of data can be rescheduled directly on another subflow.

I've written some packetdrill tests to validate the update RR scheduler
the test are available on my fork:

https://github.com/gdetal/packetdrill/tree/mptcp-net-next/gtests/net/mptcp-bpf/round-robin

Open questions:
- Is the current API for setting flags and limits appropriate? What are
  eBPF best practices to pass back information to kernel ?
- should get_scheduler and this new API be merged somehow as to provide
  a single way of scheduling data ? Eg. could pass chunk and return
  flags, limit and subflow to send this data to.

Co-Developed-By: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Gregory Detal <gregory.detal@gmail.com>
---
Gregory Detal (4):
      mptcp: add push sched callback
      mptcp: use new push callback to schedule chunks
      mptcp: bpf: allow to write to mptcp_sched_chunk
      selftests/bpf: mptcp RR: send 1 MSS on each subflow

 include/net/mptcp.h                              | 29 ++++++++++++++++++++++++
 net/mptcp/bpf.c                                  | 25 ++++++++++++++++++--
 net/mptcp/protocol.c                             | 14 ++++++++----
 net/mptcp/protocol.h                             |  9 ++++++++
 net/mptcp/sched.c                                | 20 ++++++++++++++++
 tools/testing/selftests/bpf/progs/mptcp_bpf.h    |  1 +
 tools/testing/selftests/bpf/progs/mptcp_bpf_rr.c | 18 +++++++++++++++
 7 files changed, 110 insertions(+), 6 deletions(-)
---
base-commit: c98f8dc106a6d6c4424f2e612762821e1be14bf0
change-id: 20240503-sched_per_packet-d6e4488e54e8

Best regards,
-- 
Gregory Detal <gregory.detal@gmail.com>

