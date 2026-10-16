Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52203524B18
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 16:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166975; cv=none; b=HZqJhfxXjdJuM7wOjpDfBsN1Eegghdr841m9JLnCPlxONYZa3oywlIdagKqoqq4CBIbzMRc0kfz9UiowQrYOoB4+AnkIWHSq5n+s4YsQ3RtHNhssGpPYc6A4oAUwTwbeYw7KwGCOq5t/bupsNZfK6uaMyedL5CHtITUgc84dvC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166975; c=relaxed/simple;
	bh=4yZQxNYWC1jYzkr3W46Gverb7mFl5MUGqsS9isUwzL8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ahIY2LlOfS8geuzor3hfBS+fD/8cCxtWpnbWkNIdCB93QyVFjTU7FmXO8eEpdoRlxml5n9eq49scZFsMJ0rVwDRgufUF733FjZMcZlYMuF5PTwGXh6I7Ck1iv1dl3OVjfc3x+WBVgCgDfUQjON4u/Ao8LIUPiRQRfyB3zkqTYVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njWDEP5x; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njWDEP5x"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-35b2c599f43so83280eec.0
        for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 09:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792166971; x=1792771771; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cE8uAnWODePVZZCjg8c4m31B+CwfkAubSny3s/GaEhA=;
        b=njWDEP5x/Egn/9lxBrxTtpvJcwTq76FU6cgUUWHOBjtsHAZ7dLHB3HKz9HE9e9QXSh
         ZAkZz94YkqpWokrVH6iDvCHDa2YY2Zwfs1q75C09aBQcfIlFHGJhydZGcpmTgAGz/tXZ
         KyTKL6NTOo3VEp+xZrgDF68Lu15JKLWZo0ryDHU+YguxiEk/rQVyy8p/0e/6ulDJ1QUO
         oZUkYa4/97uyl3WMFdsRc1p+Mv3LhfEx3zLz6g7TRxLMcBmLQMmblBkEt1h4N1el5h4m
         AXHuY8crwnn69m+lzFVS7iK1e64NXLK/WM/xBPwKs9wSS6ZWKAaaIUmu7ZOQDeAsHbM7
         OYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792166971; x=1792771771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cE8uAnWODePVZZCjg8c4m31B+CwfkAubSny3s/GaEhA=;
        b=rhX2QE2+hxT51TOkMY77IHWMkCIsjplUILpaHfAM8SrBLXJP20Abn1xyfh4FEIjacL
         Ot7V6hC1yC31ULnO8icHDeojIg2UlfQdsY4VrCn2dPWL9uIqTxuwkh8iKnrQwHV9duR+
         +xedLJYDDgeFdwV5jvzaVnVRUFDmxYNV7Vexwn1G/m4v6WnwrYjpZkTai5TLQwdB2dTo
         nxrZxQQyK69uk69jVgFRX4akAXLkNTcNJYNNdqy7P/B4xOJHj+5EhYgwfId3jjriZuqj
         u22W1knMcB1xF7D7faVmoM+x6KLJ4ItLwotTKSQMmI1LdgRypjKgfs2+ZwcCn79B1+em
         U3Iw==
X-Gm-Message-State: AFq9FYLYDSLLQyUtUE3j25JUCD93YzBTCfQ54Jc8dBB/0QMR/mn+bol1
	+JIjfqei8vDr83MMGIWQCeLETXImGM4Enm1Pdqa7AGfJjejHdrDDrrpBrhJiWg==
X-Gm-Gg: AYBFou16Q7ya+DJcLzBw29KFHfYHD4AoKEvNDanGjpEX7S5PyVMRioQ0eUCAut78qLf
	8HPIPvqzNNqyKXWn9IUopQnAuo0SaUkfNext+Tz2suHukbKtKvpU2DJA6xryMjjKyPJt+KTXnE6
	Q4DFs8hrxANN56JIOYOW0Dmvq9Kfu9Q8ZCFBjER5n9uTFEW2j0Kyp6tEwHgj0ykG3za0TItwxgw
	carIzYKfdOgBd2/Y2pxQxmhblcyfFqBgelB92eyNRtJlki8Dd6Gv+QwhrXOUf6vVlItRnXrvAlW
	1/NhNx9sqZ0FUy46JY1tWY2fANsdL3M+lE6AxwuLcM0EsZpPtbZatd7BWJvdpvEwdv4AgYCvR0n
	UfR5POgJaPuhy+i7NJmchohJTXpxKZ2RjeqMcFkd9FltgF12LpaCHrOLoiecNlMOSCwpyTvOwOY
	iVUd1WYZ+6VryhSx3VIMqYb11EO0PbglazQxV59HXS5SpG8uGLd1ILFrFTZOJ2lF/U4YY13L6CO
	TrB9u8LJNv67ZmWPMMYKTkmXUu4YFj9E/U4X3FElk0kGOHXWA1Bqw6Wrcjb7sfqc2qFWDiH8JUL
	Oz6RZF3+5MVsCCroQgSlGzbOkqLXEnKh18AZAHtJ1kQ=
X-Received: by 2002:a05:7300:ae22:b0:35d:cce9:5ab with SMTP id 5a478bee46e88-361a126eb87mr323822eec.10.1792166970733;
        Fri, 16 Oct 2026 09:09:30 -0700 (PDT)
Received: from ramen-dev-security-2.asia-south1-c.c.ramen-dev-345017.internal (90.156.200.35.bc.googleusercontent.com. [35.200.156.90])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6791sm9099098eec.6.2026.10.16.09.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 09:09:30 -0700 (PDT)
From: Anil Kaushik <anilkaushikwireless@gmail.com>
To: mptcp@lists.linux.dev
Cc: Anil Kaushik <anilkaushikwireless@gmail.com>
Subject: [PATCH mptcp-next v5 0/7] mptcp: pm: in-kernel: retry subflows closed after an error
Date: Fri, 16 Oct 2026 16:09:19 +0000
Message-Id: <20261016160926.1155262-1-anilkaushikwireless@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A subflow closed after an error is never re-created, even once the path
is back (#440).

When TCP closes a subflow we created because of an error, the in-kernel
PM now creates a new one to the same addresses. Its SYN retransmissions
space out the attempts. Their number is set by a new limit,
subflow-retries: 15 by default, about 20 minutes, 0 disables it.

Patch 1 fixes a selftest tool issue seen with the new test. Patches 2 to
4 add the new limit, patch 5 the retry, patches 6 and 7 the selftests.

Changes in v5, after Matthieu's review: the retry patch is split, the
limit is also in struct mptcp_info, pm_nl_ctl supports it, a re-created
subflow still connecting is closed with the socket, and the test waits
for SYN retransmissions instead of sleeping. Details in each patch.

v4: https://lore.kernel.org/mptcp/20261016055010.980819-1-anilkaushikwireless@gmail.com/
v3: https://lore.kernel.org/mptcp/20261014143349.768138-1-anilkaushikwireless@gmail.com/
v2: https://lore.kernel.org/mptcp/20261013025653.523755-1-anilkaushikwireless@gmail.com/
v1: https://lore.kernel.org/mptcp/20261012171740.464517-1-anilkaushikwireless@gmail.com/

Anil Kaushik (7):
  selftests: mptcp: connect: retry write() on EAGAIN
  mptcp: pm: in-kernel: pass the maximum value to parse_limit()
  netlink: specs: mptcp: add the subflow-retries attribute
  mptcp: pm: in-kernel: add the subflow-retries limit
  mptcp: pm: in-kernel: retry subflows closed after an error
  selftests: mptcp: pm_nl_ctl: support the subflow-retries limit
  selftests: mptcp: join: validate subflow retry after link failure

 Documentation/netlink/specs/mptcp_pm.yaml     |   9 +
 include/uapi/linux/mptcp.h                    |   2 +-
 include/uapi/linux/mptcp_pm.h                 |   1 +
 net/mptcp/mptcp_pm_gen.c                      |  10 +-
 net/mptcp/mptcp_pm_gen.h                      |   4 +-
 net/mptcp/pm.c                                |  20 +++
 net/mptcp/pm_kernel.c                         | 157 +++++++++++++++++-
 net/mptcp/protocol.c                          |  23 +++
 net/mptcp/protocol.h                          |  19 +++
 net/mptcp/sockopt.c                           |   2 +
 .../selftests/net/mptcp/mptcp_connect.c       |  17 ++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 152 +++++++++++++++++
 .../testing/selftests/net/mptcp/pm_netlink.sh |  42 ++++-
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c |  34 +++-
 14 files changed, 469 insertions(+), 23 deletions(-)

-- 
2.25.1

