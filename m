Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1802F1DA631
	for <mptcp@lists.linux.dev>; Fri, 24 Jan 2025 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737702709; cv=none; b=GZQv6MaNH1UQGeDleWYA0X8LP1NPUQipgZ/tV0l/TkH/LhzjdOfhsf2vAldzwroKS4FtaTLDI0Jh20fSv8hn/SYjOyc+PuyV0S8jOrdmjryu+i2q40799YJ2zNQeqch68kmguKs9PL8aghW/5VSajPFUc9QLkub8ruSr/z2uFxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737702709; c=relaxed/simple;
	bh=LJIjAqPLZH22CYrcQu15fEySol2LxTuCVr5BLWZsiws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIsBtyLaZ+I41kjE80Fc+PVTpqfWKNdiqAoZQ74x65pg3nS7rBh/mn8tCniYo+D0T7w0DntLEq5N/NxelYQb0wEZpsUJtw6z+88/S8zf2fz1C+bg6ytUOu1v4qGq1bF4zENsMWFjy8z11r+llYdot+A6Qr6ICB0xG26E7RxjSAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjo2pzJD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjo2pzJD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E5EC4CEDD;
	Fri, 24 Jan 2025 07:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737702708;
	bh=LJIjAqPLZH22CYrcQu15fEySol2LxTuCVr5BLWZsiws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kjo2pzJD7tV7WI4SKELFHOODw7+br73/uuClS7uvCjPWuIJR7Aq9FBppIcIyz0w7a
	 /NBrRyoQKQMROQ5u2KK1KEPafqFOmNbsi1NxKGthc9cp2TfbKdbhl/QL6L6U8WuWtX
	 /PXWNdqtLbqQ3K5woiGzpgtyyIshswGulfKWQVMmmBXz04UvGS5wL/r5Xsu/66er1q
	 5GsNO74lItNfj/d041r+sXWpDN3gqrTofV/+kPI8Vv8FGodtgksVK3f63J38PiDgpQ
	 8OhTIY0fRDiZwhFP6kK3aDzn9J3DKSkvXP7Nr3o8HJLSKHmaZfX0ReJdoSclOn3K7f
	 S/sowREfC/BhA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH mptcp-next v5 4/5] mptcp: drop inet6_sk after inet_sk
Date: Fri, 24 Jan 2025 15:10:46 +0800
Message-ID: <6a0c6d7d0d2c3f5b8985b1a521f4d63dd3800ff2.1737702298.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737702298.git.tanggeliang@kylinos.cn>
References: <cover.1737702298.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In mptcp_event_add_subflow(), mptcp_event_pm_listener() and
mptcp_nl_find_ssk(), 'issk' has already been got through inet_sk().
No need to use inet6_sk() to get 'ipv6_pinfo' again, just use
issk->pinet6 instead. This patch also drops these 'ipv6_pinfo'
variables.

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
v2:
 - drop inet6_sk() in mptcp_event_add_subflow() and
   mptcp_event_pm_listener() too.
---
 net/mptcp/pm_netlink.c   | 8 ++------
 net/mptcp/pm_userspace.c | 4 +---
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 02e2945911df..1462dc7e886d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -2022,9 +2022,7 @@ static int mptcp_event_add_subflow(struct sk_buff *skb, const struct sock *ssk)
 		break;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	case AF_INET6: {
-		const struct ipv6_pinfo *np = inet6_sk(ssk);
-
-		if (nla_put_in6_addr(skb, MPTCP_ATTR_SADDR6, &np->saddr))
+		if (nla_put_in6_addr(skb, MPTCP_ATTR_SADDR6, &issk->pinet6->saddr))
 			return -EMSGSIZE;
 		if (nla_put_in6_addr(skb, MPTCP_ATTR_DADDR6, &ssk->sk_v6_daddr))
 			return -EMSGSIZE;
@@ -2251,9 +2249,7 @@ void mptcp_event_pm_listener(const struct sock *ssk,
 		break;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 	case AF_INET6: {
-		const struct ipv6_pinfo *np = inet6_sk(ssk);
-
-		if (nla_put_in6_addr(skb, MPTCP_ATTR_SADDR6, &np->saddr))
+		if (nla_put_in6_addr(skb, MPTCP_ATTR_SADDR6, &issk->pinet6->saddr))
 			goto nla_put_failure;
 		break;
 	}
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index a16e2fb45a6c..6bf6a20ef7f3 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -460,9 +460,7 @@ static struct sock *mptcp_nl_find_ssk(struct mptcp_sock *msk,
 			break;
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
 		case AF_INET6: {
-			const struct ipv6_pinfo *pinfo = inet6_sk(ssk);
-
-			if (!ipv6_addr_equal(&local->addr6, &pinfo->saddr) ||
+			if (!ipv6_addr_equal(&local->addr6, &issk->pinet6->saddr) ||
 			    !ipv6_addr_equal(&remote->addr6, &ssk->sk_v6_daddr))
 				continue;
 			break;
-- 
2.43.0

