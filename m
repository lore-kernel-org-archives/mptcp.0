Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AAC18B463
	for <mptcp@lists.linux.dev>; Tue,  7 Jan 2025 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269794; cv=none; b=Td+Rho9gT3jqwrQ3i4iLplQ4BvPJ64f6zJ4UmE1DDmWtyqy9W5DxC/8HNDCenlWGSNoqZvSw4x5Ol7t8U9EMpkBp+IlUHDanMcXffdCLNkYRW/hwnNMY1vNjDRgOA4tes0Yk9EQgpkpK7OtyxTzmnuq4pTbhiWrsCdKVv7UQrUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269794; c=relaxed/simple;
	bh=OGogxkh2ZFJv8Sp442Ci2eB+LbfNvn47S+GYz8hrJEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f+Ya4nwfS1W2UrRM4ns6N1AVHaMhHhsy0mTPox9TUBZSFfPOgZ/VhRpXtj5bKpHsXguWvjJV4vUb2tGqcpSNy+P76U6m87+LyvuBgPkU+gWxGrWA5sKNt9MkyOaXhrcsLoB2IZj8tkz7rD4OxwoYrnO1r0FUDELZI0JmAKhKSiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBlLnNKi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBlLnNKi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B818C4CEE0;
	Tue,  7 Jan 2025 17:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736269793;
	bh=OGogxkh2ZFJv8Sp442Ci2eB+LbfNvn47S+GYz8hrJEA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PBlLnNKi7w8Qh0B1nTzeGvaVD883jErwDwnM0qMMAz86x21aS83SE8fiMGmB9uwWy
	 Ilp+rgC4ib6qnkdmvHl/oeKmeXCCZq9hDcJnJeG0KEmB7CgJ+cN1N9NGbz31ted9cr
	 OwDuam35vxeNm2mUtfiBURoFUkofl67dfoC2co6HSQJLMDqm2UfDxt4ggqmFnizCxL
	 y+Z3UXw0ew9kF/4pd77ygoN+PoDLOT/KyGAz6CYWW2cpXxWiz39JaK0AoD1Pm2E1dg
	 f/RYjSMV0X+wLvpzZ1toxlhl8AVIaNq0RCOVGppOIi47AsUL8rwVPDu46pG9dt1mNV
	 uEzQ9p2AY/eKg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Tue, 07 Jan 2025 18:09:30 +0100
Subject: [PATCH mptcp-net 6/9] sctp: sysctl: auth_enable: avoid using
 current->nsproxy
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-mptcp-sysfs-netns-v1-6-2fa7075d9970@kernel.org>
References: <20250107-mptcp-sysfs-netns-v1-0-2fa7075d9970@kernel.org>
In-Reply-To: <20250107-mptcp-sysfs-netns-v1-0-2fa7075d9970@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1619; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=OGogxkh2ZFJv8Sp442Ci2eB+LbfNvn47S+GYz8hrJEA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnfV/aNUu6LuHZbD5MGLHH8H9eMT6nOh0faV1VJ
 w4juxHmRaaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ31f2gAKCRD2t4JPQmmg
 c8E0EACuPC24Q5Hd9H3kVtDbAnDoYWi+B2esnwlh3axwTu32KNjROrJPYGMYoeeGtKyrULVflCe
 Ps905Y/kMUNTWsHovo6bQAwP/MEhlNOK8NqgITp+98q8rqq+01cEUmSVnyrNnFdO1O6JWJTSo2o
 uzAdJEpTHTcfbBtze55o8NZp5mzUqwKgzgONLG+N3IwJmz0MXiTnRrmYdosOgfmbeZgbul7yJVl
 rirHJlljASpPxhFT3O7cl1PsX6h6rx4PUdO+9VyPaGvh2Gp/yzng2rk0jZAAcj/cgbWCG9/EhIp
 3JkH8u89X+wZh5iO5LJQtpus7O9FsY6xIre9rjXkge6jXxhdBp5SFfDuT8LwXs5LUXOCp8MV4dM
 9LVyN0fmXvaM5Fc3DeUhxpLBPqQcy0WgcNY+032KmCszZoNWuvTGpGP4P5HHvrm2npLO4UjZhVo
 nV5mEA1nlwoUNTyMEskZQu1V677poDkIeEa41ch6oT+0o5xOClBLHbvpvgA4P0YBHzjCZlNSU7U
 MMbR5xJKxOje4a5h+r0hLZdZe6PeajcmP0VGnHdUk+S6kbZYrLmoK8KuAlhotS8C1FlAzg9l8XQ
 73qdjBWhKRfGNv9Mup+aKhGpLHsvhF4Xz2WotH6OZyv6Zd56DUvBsCl9PAEhdWurlRXWIiTKWYu
 rS4/w9BvCkOOzOw==
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

Fixes: b14878ccb7fa ("net: sctp: cache auth_enable per endpoint")
Link: https://lore.kernel.org/67769ecb.050a0220.3a8527.003f.GAE@google.com [1]
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/sctp/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index a5285815264dfa9d88d1d71244f309448e97a506..9d29611621feaf0d2e8d7c923601ab374515563b 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -499,7 +499,7 @@ static int proc_sctp_do_alpha_beta(const struct ctl_table *ctl, int write,
 static int proc_sctp_do_auth(const struct ctl_table *ctl, int write,
 			     void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct net *net = current->nsproxy->net_ns;
+	struct net *net = container_of(ctl->data, struct net, sctp.auth_enable);
 	struct ctl_table tbl;
 	int new_value, ret;
 

-- 
2.47.1

