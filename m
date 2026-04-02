Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0B533A717;
	Thu,  2 Apr 2026 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151197; cv=none; b=oX2dCNyqnp0/VikJ4hqQS/5E9ZXuyAD4bWj6GNAcrJKEgMC1LMh7mQc7eIC/K+7UNoy1qTPR+t5KIWKFHAS/BYXUki8oKTGWaf57T1+5M9hfKXRLC+IQM8jXNokhDNchxBhVHo9xO+xK+mkJGwICWTLcH51X+r50IIgUTMbFA4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151197; c=relaxed/simple;
	bh=yxfdXK/LTBJVclklv7YGvcFJyuNvBVzz1NKUG59G/ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GimhGM0qMihqev0naMoaxjJnDJKAYDp7jWkLdLxR58ib3CXEL/fATOTtU80vvy1mlzkmpuKCaIRngSzeAytB7m9WfH6klu2yRxB/lYLz1umoDIzTXmYwu+8y+mygYXqO5Hdz5DhyjNBZHZE4GCpZAmvRpcWqENhMeBxByZ+kaV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPHpuTqD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPHpuTqD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D6DC116C6;
	Thu,  2 Apr 2026 17:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775151197;
	bh=yxfdXK/LTBJVclklv7YGvcFJyuNvBVzz1NKUG59G/ZU=;
	h=From:To:Cc:Subject:Date:From;
	b=cPHpuTqDsDlgCKNLjjTq0C2Q7tAVbxVLH68DHqznXNWfjz5+GKELGgRJr052JOrpL
	 3JI6yxgbcKqsAOwcGMxbYV8LoeJf+SOGJ4oCwCPu9CdSzB3yhIl3L2VgEKoRYNMUsp
	 zsfKzQgdn4Mx01XXVldvoip+txA55Z+9qXInltsROTSBDFJBNQo/sS6PoO8QPPyJ/a
	 ORLeBSHAgfE/TsG8rYfdY8ujcuHPl4gxBXrp+UpQnrckClARwLpHgT/nDS/YFwMwOi
	 9r1gV3yEFd76ekyZyKatwgKFqKYKUM/nabCySENOAFFyrJhD2F9Atv3POyKl3tqJ4I
	 6pf7dqaoIIDdQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: MPTCP Upstream <mptcp@lists.linux.dev>,
	Li Xiasong <lixiasong1@huawei.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y] MPTCP: fix lock class name family in pm_nl_create_listen_socket
Date: Thu,  2 Apr 2026 19:33:10 +0200
Message-ID: <20260402173309.3282169-2-matttbe@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1483; i=matttbe@kernel.org; h=from:subject; bh=/d1D1WgCUoilfQ6VeZW1nsWfrobqt74hE8IqWiljUqc=; b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDLPrQhVnznv3IkaNp4pucsiJh9OUDeWW8dzc8se9ibLi H9+sa/COkpZGMS4GGTFFFmk2yLzZz6v4i3x8rOAmcPKBDKEgYtTACZi+YDhn9nW6dsatfe+jpWb xe8hurlmgYu4dMeXdYoRH3crybtZ32P4wyVQ5vxRoqPsyufT3Wt+q7yYZnZ89eUsFq77+z4aa+z ezAwA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

From: Li Xiasong <lixiasong1@huawei.com>

commit 7ab4a7c5d969642782b8a5b608da0dd02aa9f229 upstream.

In mptcp_pm_nl_create_listen_socket(), use entry->addr.family
instead of sk->sk_family for lock class setup. The 'sk' parameter
is a netlink socket, not the MPTCP subflow socket being created.

Fixes: cee4034a3db1 ("mptcp: fix lockdep false positive in mptcp_pm_nl_create_listen_socket()")
Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260319112159.3118874-1-lixiasong1@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Conflict in pm_kernel.c, because commit 8617e85e04bd ("mptcp: pm:
  split in-kernel PM specific code") is not in this version, and moves
  code from pm_netlink.c to pm_kernel.c. ]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index c847335ffab9..38e17f2f15d0 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1186,7 +1186,7 @@ static struct lock_class_key mptcp_keys[2];
 static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 					    struct mptcp_pm_addr_entry *entry)
 {
-	bool is_ipv6 = sk->sk_family == AF_INET6;
+	bool is_ipv6 = entry->addr.family == AF_INET6;
 	int addrlen = sizeof(struct sockaddr_in);
 	struct sockaddr_storage addr;
 	struct sock *newsk, *ssk;
-- 
2.53.0

