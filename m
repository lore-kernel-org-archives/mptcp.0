Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94559283FCF;
	Mon,  4 May 2026 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777888319; cv=none; b=SvJKTNYsf3Glv4j271TBL3YSf120mlN6PLDC6qw266mbcVB+Z+Jzg1FrnUAdGpahBJjn+apN6yqwaTqDOeA9FM2DMmLamS5ropae4ngIjNmOjW3dqkLVVUMiQ6ynhmsVIXzNQSwt91jrisN6s++HMUzdfCZT5qf3MR1VkTIk06w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777888319; c=relaxed/simple;
	bh=S5cf9/E9C4bvHrpvqQ7Fnx33EqDMw0al7kzY6fuZAf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xi297bNM8nYFTyDQViEtUyJvk2B0r2ftdEsoNErxbQ+IgTywKE9Uw9Uc8T7z9lYXX2tIig1EJ/lpYcDVht+2NX9aBb0RXytf7FAPrDuIKWN/2xrDQ7IkxSweZ9/nMki7J6ErAtbHGE1dEFNQYvTsHsMKNOkIcxmQ641VwxWVb6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlGv4TUo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlGv4TUo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86F2C2BCB9;
	Mon,  4 May 2026 09:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777888319;
	bh=S5cf9/E9C4bvHrpvqQ7Fnx33EqDMw0al7kzY6fuZAf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HlGv4TUohlBqRjXFj9boGXxPWlXHTJRV4W9S5uSGiyHqlt6sC9Z0/9GZ1AtOcFYKf
	 T9XRIYHOFCYYaxX0CcdkxhEU5egSJsgI81xSXbE25jLVSXgTAAKmOQyVV/qpe7qAWi
	 KMCNm1mLvW3rYPIArAU4kI9ilHQnU3jG+ZoxvFI7bf+c3te5Lwgbiqsk71D/fbRXGn
	 owh4YX3LkCctbIjRMWmVq2mPIR0rqvdPOxLw6FqplZJoIEnEG9wjWUKCt6WPz5OuIL
	 Hi8cxpCS7WVBB5LtP8MmxVk9wuxLXFTs+cRZRXk3uctq76xbjwj7BEaP7TKEs97giB
	 FvH+yyHOLbxuQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	syzkaller-bugs@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mptcp: fix KMSAN: uninit-value in mptcp_established_options
Date: Mon,  4 May 2026 11:51:02 +0200
Message-ID: <20260504095101.852039-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <69f44505.050a0220.3cbe47.0008.GAE@google.com>
References: <69f44505.050a0220.3cbe47.0008.GAE@google.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1098; i=matttbe@kernel.org; h=from:subject; bh=S5cf9/E9C4bvHrpvqQ7Fnx33EqDMw0al7kzY6fuZAf4=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJ/5LD9f/Jf6Wsjj9m7Fk3jQznvSvTObryyhCEx+j3rL J64DPuqjlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgImcCGdkODOj5b+pxy2NQxW6 fN6SM+wKGKbHnu9ymfT/Xu3cL/+rUxn+6QvH+aezxixWlc8IF7nN86bveYRi893uhZf1jx9bpqP CBAA=
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Just to let syzbot testing it.

See Paolo's suggestion from [1].

Link: https://lore.kernel.org/6d342ef2-d480-4be6-afad-a3841cf205a8@redhat.com [1]
Fixes: cfcceb7a39fc ("tcp: shrink per-packet memset in __tcp_transmit_skb()")
Reported-by: syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/69f44505.050a0220.3cbe47.0008.GAE@google.com
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: syzkaller-bugs@googlegroups.com
Cc: linux-kernel@vger.kernel.org
---
 net/mptcp/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8a1c5698983c..24903a12a4e0 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -583,6 +583,8 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 				map_size += TCPOLEN_MPTCP_DSS_CHECKSUM;
 
 			opts->ext_copy = *mpext;
+		} else {
+			opts->ext_copy.use_map = 0;
 		}
 
 		dss_size = map_size;
-- 
2.53.0

