Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE4B1773F
	for <mptcp@lists.linux.dev>; Tue, 20 Jun 2023 16:24:54 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-3f900cd3f69so33674185e9.0
        for <mptcp@lists.linux.dev>; Tue, 20 Jun 2023 09:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687278293; x=1689870293;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KZiePvQp+al3FKzqRXjxppdYvMnDeS6krGk8yswyq9Q=;
        b=fI/g/+kKD47r49rMcbAbcJPR+NnnqJfKICsB7eL0o5deyMZKztnVC73myKB9iRtztC
         4Hn0BVeTuQP5t3t6Vd1k5jHM9yZshtNWIibtlQifw+lCLjHcFVxKe/CwbIas9yv1JI1I
         /o3pXsIVNndYYnHcL7rJwHZsviZxCM0bBIpwOyDEQcD9zkAgliutLs9JkDOgX9k4hQg9
         PcdKCdRclYGW14VSRigyA/7ZedsVpVK0dpw0ck6Kq/qXcnM+dB4tt/yJ2ypTgsPovJi+
         FB3kPB9w4ebf29536naaOnUlPMIS6Pm3IaMBt8Z0GobnS7irhx2wkgg5JppHa6/vNgU7
         7S9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278293; x=1689870293;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KZiePvQp+al3FKzqRXjxppdYvMnDeS6krGk8yswyq9Q=;
        b=JzOKNcdWwj8Q90ejJ44bgsqjmsWI2/Yy7tjt8Q4AQ8dLoW9L+sujMJTMtVl33yDRbH
         E3zyt5gfZUZzKWoljIliSGZh/Izb+jQqA8JfyhMGRnPrCbJDZ58I5/Ct12Z58O/sLtNe
         UVaEO775d1+ZuCkfrX2GobtetOJt62T4M3VUVNaXeIUVHt8qSss7oYgeFWaQYAtm5RJy
         iG6i6rv1P8RRXRjJh4BSJStmvF6OGqu77HuVqPRNh7xrAebVGSEgMmSk8U9+LCYBG+MO
         gdAIr+Goo+W3FljI88wAkXhwKnwfc8LBrCnU8GCJmN9Xeru27IGMVKXhW3M+7BH1McXB
         tNww==
X-Gm-Message-State: AC+VfDx77qpII18tWsw57QcLK25cYabG3ze4aHMk9VsTieieZY6120Ht
	hmadBzRdZMIKYsfHfxhBmO1bFg==
X-Google-Smtp-Source: ACHHUZ4X++gNkgkYQ9NR8U6rUE/PLbEipynm2A8AZLg+tAv7RRPTrtOeK0PvfcP4WlkHktxcCRMyGQ==
X-Received: by 2002:a1c:4b0c:0:b0:3f9:b0c2:9ffb with SMTP id y12-20020a1c4b0c000000b003f9b0c29ffbmr4371716wma.27.1687278293150;
        Tue, 20 Jun 2023 09:24:53 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c511300b003f8fe1933e4sm15753056wms.3.2023.06.20.09.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:24:52 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH net 0/6] mptcp: fixes for 6.4
Date: Tue, 20 Jun 2023 18:24:17 +0200
Message-Id: <20230620-upstream-net-20230620-misc-fixes-for-v6-4-v1-0-f36aa5eae8b9@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALHSkWQC/z2MSQ7CMAxFr1J5jUVIByGuglikwaFeNK3stEKqe
 ndcJFi+P7wNlIRJ4VZtILSy8pQNLqcK4hDyi5CfxuCdr13nHS6zFqEwYqaC/3RkjZj4TYppElw
 7bLBtKTX11Sa+AfP1QQl7CTkOh7Gcf6qjnIW+d2vuYGp47PsHY5hLqJ0AAAA=
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>, stable@vger.kernel.org, 
 Christoph Paasch <cpaasch@apple.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2098;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=MNa5Zv2WFB2ZD/+VqaVhvs5aElxmpw5Mk5036ctzZRA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkkdLTrZXGyWJzsiM93UPDbxMayZGi+q+lQqlwQ
 lE9mY6wj3mJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZJHS0wAKCRD2t4JPQmmg
 cyhvEACAvM4cqa/ydDhDCawGPClVtar8UI4PjG6ao+G7lEP8B4oH7sP+TDEawGc4JM+1Wm9JEWB
 /suKJ6vMWwbL7i5lqpk8a6y35pfPVl184tth9q2Gtm2uRqWyfBAxesZHuCL+TuP/Ig/PAjmI87Z
 RqfLcg9JJgesS/cRlZfCehYRspt3IYkEUyPHW/Wemr7CkNgq4qHshmy53yTpkOVMA3ebvHHi2sB
 aKS8kLUOLOji9GNmLxE2CrURJHUjmLu8h2MXH6+32U7kDNlQIULT99mX8Y6ch4xedJZ3rcaceCh
 kKt8adyNx8aW+1l/2mS6N/hphYDJP73sVSclLiTM9MPWPz3qa3mGXieAatqjrHHJWP1o9PDZIcV
 EqG4w28G/z4AvQLP6r///6Un1qNhKfB9PXejE4riUT3UAYHmzNiHVl+HfwSHOBTSfPhDaryeAvC
 6PcztG2KdwEVTLDMshc29RC4uXC6QDvGL7TNrX76dChRcKC5wqSKwPSlYCmwMJmhx1fRtSmVsrf
 OyBM5p0aV5gXN25PjmfAMvbLCxjrGRC4hXTr0Fcokmqhr0ucWMDqGg1VIRbTR57UmBH/SntfJ6i
 M72B4ZuW1k3Zo0jzzhzsgt0lyQhOxfrvH4em7QehaDO7pFj1MbxPqQ0wvl+w3+WhOZDv/H4UuJf
 TJVoZyX5aifKV8A==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Patch 1 correctly handles disconnect() failures that can happen in some
specific cases: now the socket state is set as unconnected as expected.
That fixes an issue introduced in v6.2.

Patch 2 fixes a divide by zero bug in mptcp_recvmsg() with a fix similar
to a recent one from Eric Dumazet for TCP introducing sk_wait_pending
flag. It should address an issue present in MPTCP from almost the
beginning, from v5.9.

Patch 3 fixes a possible list corruption on passive MPJ even if the race
seems very unlikely, better be safe than sorry. The possible issue is
present from v5.17.

Patch 4 consolidates fallback and non fallback state machines to avoid
leaking some MPTCP sockets. The fix is likely needed for versions from
v5.11.

Patch 5 drops code that is no longer used after the introduction of
patch 4/6. This is not really a fix but this patch can probably land in
the -net tree as well not to leave unused code.

Patch 6 ensures listeners are unhashed before updating their sk status
to avoid possible deadlocks when diag info are going to be retrieved
with a lock. Even if it should not be visible with the way we are
currently getting diag info, the issue is present from v5.17.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Paolo Abeni (6):
      mptcp: handle correctly disconnect() failures
      mptcp: fix possible divide by zero in recvmsg()
      mptcp: fix possible list corruption on passive MPJ
      mptcp: consolidate fallback and non fallback state machine
      mptcp: drop legacy code around RX EOF
      mptcp: ensure listener is unhashed before updating the sk status

 net/mptcp/pm_netlink.c |   1 +
 net/mptcp/protocol.c   | 160 ++++++++++++++++++++-----------------------------
 net/mptcp/protocol.h   |   5 +-
 net/mptcp/subflow.c    |  17 +++---
 4 files changed, 76 insertions(+), 107 deletions(-)
---
base-commit: 9a43827e876c9a071826cc81783aa2222b020f1d
change-id: 20230620-upstream-net-20230620-misc-fixes-for-v6-4-55ef43802324

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

