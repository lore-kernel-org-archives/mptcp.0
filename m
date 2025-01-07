Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124D318B463
	for <mptcp@lists.linux.dev>; Tue,  7 Jan 2025 17:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269795; cv=none; b=Dv7S2sehB5oZnb2R71UinzdhlIz0Mf8/yx/bXThI1UTfSBiU1GtcQybMu4Yfb5huO4eLE6V2V9Oh4RVFPlHxDoDwS8cs/VhCLwXaZG8eOcKYRH4Fgctx53rE7RXYo3dX17odzQm/L+CivKYx04RR8LpTTQffiHNTergRlqGflCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269795; c=relaxed/simple;
	bh=ufX6xedFdDfnkmJ9OsG1TuSM3+8UGK9PRhwEE5ldpt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QYEUcrKjcXdWOK/NKoEv5gYVOHLtqX0FGGydVJwFbIKC/LEcaCcYawwSra5FW9n6+lLhY4FRc895VFdxOn7Ftxg7BoQCqFce/20iyveawQQFMJWaUC5m7ciMr+ck555bOCD6Ri/SWVVmHIYpYQc5cqsZda66/dv5nZYUMPVlJNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adA3EEE5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adA3EEE5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C46FC4CED6;
	Tue,  7 Jan 2025 17:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736269794;
	bh=ufX6xedFdDfnkmJ9OsG1TuSM3+8UGK9PRhwEE5ldpt0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=adA3EEE5sBUYE0lAwUskHL2uCANzzcUdrQKi+CHOfzm7+/TNr/JbNIaZeVDYpOVPW
	 vpF1TZSvten7cEijQE3T1ywSWhp3o1ZmhEdzcsi55lA04keeSDthonUR3vgK7dfJ7K
	 a7wJnrhleGdWA/8aG5OErXbYZZXSx+wghjzzUz3FS6E0CkmZVEUzsyLKCYsPbm8tSM
	 jMcun74glK3FZ6TvlYln16yWPsUBXHzJNVR6iRWxzjYTCiud9UTzCFmNcNSVOUe0ad
	 1R5aKOYiJ6UlT+D2vUI1T5P2v4qtO8OzvIGj/0dNW7yz5/A7W04RwNvgKV/hpZcW1P
	 TaaKGFM2kSCZg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 07 Jan 2025 18:09:31 +0100
Subject: [PATCH mptcp-net 7/9] sctp: sysctl: udp_port: avoid using
 current->nsproxy
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-mptcp-sysfs-netns-v1-7-2fa7075d9970@kernel.org>
References: <20250107-mptcp-sysfs-netns-v1-0-2fa7075d9970@kernel.org>
In-Reply-To: <20250107-mptcp-sysfs-netns-v1-0-2fa7075d9970@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1680; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ufX6xedFdDfnkmJ9OsG1TuSM3+8UGK9PRhwEE5ldpt0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnfV/a9LpKmmi82OYNdHBWQxvkTNY3PJlqu68cb
 OP2oad1cj2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ31f2gAKCRD2t4JPQmmg
 c006EADR4Q2CMVhE4FUzn44SlWntsUtYPtM2D68QIxKr8xoBAxdB/T01UP5R71qA8/zIX9fuSBq
 8KILzYRBPuYkTxtT0h5iNJMLJPnwQxX4Vxdz8Xhl5oP8/AlTkcrFiHpvC2c0DBaw4EWvwKSI4It
 aJncO49s4LEfvVdKABSvdQdvwP3SPyelWLD712/Tl1fTNm5hR7+lJ2JV47Z6yWsdbWw1zVAca+1
 mNBa16K6XsmQltpiLYkHR8ZQNLDvQdmqyWDeiI2tx7gEA0dIlUuQmygkHduL6XLGVPABEiiT3qz
 J6ce+4+edhbvtBJ65cnRVArNstksxtFvIte8as/vqdguk+iPwq2Zt7/StW58ROKWnp8WT8lmgtC
 78nIjC2WHtVktMD9UjBZHTnZvsE7rjibHXGpmEAQqf88UnpdGhWRR45jbVT0RIoOavKVdSUGWuF
 Uj7uQP0N5T5YuRmMIfngM2ygh+Vd9xlP/GCMuYoAQ/Rdcrhcugw7BOkKp2a0YXQVFUl0Ejqsx7A
 qiG29DixPuahwDkdhomd/cU/0+MHuzbVqTJKf1v9gtk/GwzrVmFAcXGrIMutQFJbLc4QWnu+XCR
 jhFrDphCLK1FzQPeHo+hfhLM9afsWiGdwuujhYixNJnHFQ5eb2Ey3n/QIU9Sa1w3v0unQGDvpyt
 WcXs//Rn5v7ph+Q==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

As mentioned in a previous commit of this series, using the 'net'
structure via 'current' is not recommended for different reasons:

- Inconsistency: getting info from the reader's/writer's netns vs only
  from the opener's netns.

- current->nsproxy can be NULL in some cases, resulting in an 'Oops'
  (null-ptr-deref), e.g. when the current task is exiting, as spotted by
  syzbot [1] using acct(2).

The 'net' structure can be obtained from the table->data using
container_of().

Note that table->data could also be used directly, but that would
increase the size of this fix, while 'sctp.ctl_sock' still needs to be
retrieved from 'net' structure.

Fixes: 046c052b475e ("sctp: enable udp tunneling socks")
Link: https://lore.kernel.org/67769ecb.050a0220.3a8527.003f.GAE@google.com [1]
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/sctp/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index 9d29611621feaf0d2e8d7c923601ab374515563b..18fa4f44e8ec8c86f8415b1251ef8a2979c7f823 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -528,7 +528,7 @@ static int proc_sctp_do_auth(const struct ctl_table *ctl, int write,
 static int proc_sctp_do_udp_port(const struct ctl_table *ctl, int write,
 				 void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net = current->nsproxy->net_ns;
+	struct net *net = container_of(ctl->data, struct net, sctp.udp_port);
 	unsigned int min = *(unsigned int *)ctl->extra1;
 	unsigned int max = *(unsigned int *)ctl->extra2;
 	struct ctl_table tbl;

-- 
2.47.1

