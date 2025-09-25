Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0679C279907
	for <mptcp@lists.linux.dev>; Thu, 25 Sep 2025 09:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792972; cv=none; b=KXOYrTXIBpviCpsD7knmX1HnYGXbVSOWwe4uqI0c7mYySeb9cW3o61BWmTxmA0YlfeVVi7U4OZ+D/0f+J56U7weOO3f5sEOAkcc7421jKTIh7snd6UrvxDG6FkkWUxnkOZyMFNWrjLXZSAwY5z4iNz4dDtwhnSpBVyTr+FrO3sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792972; c=relaxed/simple;
	bh=rvmn/9fNBwLXiR/naWUZlKBH+/yw0HMGHd9myyptFrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JB5eZtFs+NcPeK7J0QzVOqVmNSF1Qyz8+sp8jCKYfRK2nfEiq9teGu7pB8kYhhyFFlJIdwNDDrfMQduQ2QOfH0Dby8MxQDhbIKp3Y99XI88Si1oyKbI1ZjRvPO5GzjDu8U7RW4rt1qqEctJVLREPPnGsQvl6JMzI9cJP0e1PLSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rw1JlTjg; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw1JlTjg"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-633b4861b79so88996a12.1
        for <mptcp@lists.linux.dev>; Thu, 25 Sep 2025 02:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758792969; x=1759397769; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JrLk5BVUfi64hDu8MSXp4iRz7KC+EB7RrIoytg966TM=;
        b=Rw1JlTjgHRow3179Tcq5c1phNduA8lv6I5FcE3k/L4DHWDovP1QsM/pbNjIn+Hul8+
         Khl4rHjIOXKFU1zhKCC6UW9jLZcHdTETmRc7WB26tDSi0Z80w/rp059Ab1F/LSRi5QNY
         jh1w7YSFFlN6ZqF4gFr2ff3yPpfN32juwL7tz3gya/+YyTVOLhKCp2KPXeHTkd20uPCC
         PE9SGFVgAwUi8U0d1U5FfQhMuUIyaVxQD2Kflosh456gtDi8OPmROf1X6qLXlnnAN7eL
         10mi/cyV2Y8nGDqE0OpW1gYBtNIMK4YMBel1Kn1DD01TM2/bmwGEezPKHr0W03OfyLwO
         49Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758792969; x=1759397769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrLk5BVUfi64hDu8MSXp4iRz7KC+EB7RrIoytg966TM=;
        b=fuEZX8AJVT2K5bySZ5gi4clzapL6Q8ruHmZnxcknQTScEo8heZXdziTJ/60sJ6DRpa
         v5LinpWBr1ET93Y8Jm+svPW5vfsuXnf9npWOy/1WGnYtbVDMiL1Bfwz0a/uucIi0WFBG
         g0kSz8G0ogc23EMNjrQol3Ij5pnA8DLovH0Ra17PZPBwbMuW/L3v7iddTO1Xdmx9/cP3
         Q2KMtIwO4yvZhwzQOrDdX8zenWvwtvqw3dM/sMzpnxljFhhrMBbrW6YpKhfWSE+hW6ii
         DfrcwyaH5/uFbXrR4l5lcvYoJcxM7zk3GFFOLaL2MW+pYSrp7VRww42oPPgC+2sA8+s3
         BjYg==
X-Forwarded-Encrypted: i=1; AJvYcCVjary8d/0Gh/Fq6uy9lKhhY5VEcoElwcHf3O8SaOMnJb12cMMBemxT5n8EI7ZdjOpYeyZ26g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqWJgR9dStjesVXal+ZXa0WkON8hsDXFHGC4AfsJKiruI+TEcE
	FJ0CRG5FgY8F/RYE/TOw/ZCcv/tTEHWClk3gwwdPA226tYjXpPBw7ThV
X-Gm-Gg: ASbGnctSFNpnH1kDnmRPZ40AOl+rFvudLnGD4PrKyAqWJ45A74Qq89gwAUzOunUdUtL
	F32AI8DQgOAx9iI9UeAv7ugX+86xNY66UsISxi3GnRyWMVfv2xZQLgOajGInbfMimOrmCifrXFq
	Ih1zaPKgN8d/ucjT5J6ISgN0lFEh+pRDvVO7R4LJMv/ndXx19LKhcd5n8Fq5fIDtUC5yFIBrCqU
	ukkddCJgW1CEJtJjm9msm1UGtA5j9D9rEgtoVlPVZ1a0bWb8kvtDDj7494f1RQoVPFq7AJgbD7g
	Vv95qd+cr5Z/jPDBxqjeaKUlWQneX9VXKwtqdcyOJ5jqS6dQNMjWOrYrE52gPvyxhnbv3e7WJy2
	f1dJxU5tg0VR/viMxsdU8dixtPR5qCkMU9QTssA==
X-Google-Smtp-Source: AGHT+IEn+TRY3f3rNpLqKcwo/IFO0X1TqRBrGc61qVTD+XlR37lk96NhcpagZXDaWeHbktL+5wxb3A==
X-Received: by 2002:a05:6402:4389:b0:628:d1b5:d207 with SMTP id 4fb4d7f45d1cf-6349f9d26b0mr1238596a12.2.1758792969099;
        Thu, 25 Sep 2025 02:36:09 -0700 (PDT)
Received: from bhk ([165.50.112.244])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3ae321csm941225a12.24.2025.09.25.02.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 02:36:08 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	linux@jordanrome.com,
	ameryhung@gmail.com,
	toke@redhat.com,
	houtao1@huawei.com,
	emil@etsalapatis.com,
	yatsenko@meta.com,
	isolodrai@meta.com,
	a.s.protopopov@gmail.com,
	dxu@dxuuu.xyz,
	memxor@gmail.com,
	vmalik@redhat.com,
	bigeasy@linutronix.de,
	tj@kernel.org,
	gregkh@linuxfoundation.org,
	paul@paul-moore.com,
	bboscaccy@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com,
	mrpre@163.com,
	jakub@cloudflare.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH v3 0/3] selftests/bpf: Prepare to add -Wsign-compare for bpf selftests
Date: Thu, 25 Sep 2025 11:35:38 +0100
Message-ID: <20250925103559.14876-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is preparing to add the -Wsign-compare C compilation flag to
the Makefile for bpf selftests as requested by a TODO to help avoid
implicit type conversions and have predictable behavior.

Changelog:

Changes from v2:

-Split up the patch into a patch series as suggested by vivek

-Include only changes to variable types with no casting by my mentor
david

-Removed the -Wsign-compare in Makefile to avoid compilation errors
until adding casting for rest of comparisons.

Link:https://lore.kernel.org/bpf/20250924195731.6374-1-mehdi.benhadjkhelifa@gmail.com/T/#u

Changes from v1:

- Fix CI failed builds where it failed due to do missing .c and
.h files in my patch for working in mainline.

Link:https://lore.kernel.org/bpf/20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com/T/#u

Mehdi Ben Hadj Khelifa (3):
  selftests/bpf: Prepare to add -Wsign-compare for bpf tests
  selftests/bpf: Prepare to add -Wsign-compare for bpf tests
  selftests/bpf: Prepare to add -Wsign-compare for bpf tests

 tools/testing/selftests/bpf/progs/test_global_func11.c       | 2 +-
 tools/testing/selftests/bpf/progs/test_global_func12.c       | 2 +-
 tools/testing/selftests/bpf/progs/test_global_func13.c       | 2 +-
 tools/testing/selftests/bpf/progs/test_global_func9.c        | 2 +-
 tools/testing/selftests/bpf/progs/test_map_init.c            | 2 +-
 tools/testing/selftests/bpf/progs/test_parse_tcp_hdr_opt.c   | 2 +-
 .../selftests/bpf/progs/test_parse_tcp_hdr_opt_dynptr.c      | 2 +-
 tools/testing/selftests/bpf/progs/test_skb_ctx.c             | 2 +-
 tools/testing/selftests/bpf/progs/test_snprintf.c            | 2 +-
 tools/testing/selftests/bpf/progs/test_sockmap_strp.c        | 2 +-
 tools/testing/selftests/bpf/progs/test_tc_tunnel.c           | 2 +-
 tools/testing/selftests/bpf/progs/test_xdp.c                 | 2 +-
 tools/testing/selftests/bpf/progs/test_xdp_dynptr.c          | 2 +-
 tools/testing/selftests/bpf/progs/test_xdp_loop.c            | 2 +-
 tools/testing/selftests/bpf/progs/test_xdp_noinline.c        | 4 ++--
 tools/testing/selftests/bpf/progs/uprobe_multi.c             | 4 ++--
 .../selftests/bpf/progs/uprobe_multi_session_recursive.c     | 5 +++--
 .../selftests/bpf/progs/verifier_iterating_callbacks.c       | 2 +-
 18 files changed, 22 insertions(+), 21 deletions(-)

-- 
2.51.0

