Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706B6CA62
	for <mptcp@lists.linux.dev>; Mon, 30 Sep 2024 02:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727662487; cv=none; b=XRntL7LtIKFTNl8hWvM1MlcINASjz5JvYHtHxyoWled6TLI84UO4VeCPe3Q+85TIz82PYL0tREX0vhaAjdDioMtOZ1A3slbvAd8azDeBBHmogvPhqqYJA0LIGfeLDVOGVfUHWIViaBBdHSb+wPYaYAWncfHdV5tsQeguBvgiFyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727662487; c=relaxed/simple;
	bh=mvTO90Mm2JUmFAPKdBmbr8VTr0MRY/Z7XrEHDMhb9LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LOyXnytkKpzVIIH010kj8PmftyjWiueZKF2v+4uUpoiegYCfqKIsUN8eYJsW3mIJCmUBIEpFoOG9oLXoXAZwf6l/7PBgOgfcGwQ2GZaX/s9MZjMtYMMXAg/a0NNV5kjN5Rtc2l2s+R+tUcvihsIRdi6pdicxaJumY1qWevglRyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAzf+r6Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAzf+r6Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0440C4CEC6;
	Mon, 30 Sep 2024 02:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727662487;
	bh=mvTO90Mm2JUmFAPKdBmbr8VTr0MRY/Z7XrEHDMhb9LY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IAzf+r6QpaPJjUfxLWPI6lPzjVmwg/8xun2WrCdFcb+Nc56pAe3hs46IrRAwrSnGQ
	 Oslp4XM0aNmxLKiLTuUoj1nOIcFuDshPEorraGQ4hAL/LE6kkh6yEzEPUvxhOYFpb5
	 8d70XaMwMufI7I9srUU0MoSGjfQb8Nxn/XcvCiJOVPDEY4S4axtx43kQsa75lpT6Xj
	 kdK1nkLola7OWUooBbjxxgSoylthn7voY6k7h/Z6k1zjriTVBFy1lwcMMw2dhubj8p
	 Ye0+Ln4LtA/l61aQrs5vKY8QVKh1hiyzNeA4CyjuHtzmKqvrVgdmaxlPT/U3cuk+PN
	 Sc1qLHpgEjGlA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 4/8] mptcp: change remote as mptcp_addr_info
Date: Mon, 30 Sep 2024 10:14:29 +0800
Message-ID: <a31ad897cd5857710135914b9d1885087871903d.1727662123.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1727662123.git.tanggeliang@kylinos.cn>
References: <cover.1727662123.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Generally, in the path manager interfaces, the local address is defined as
an mptcp_pm_addr_entry type address, while the remote address is defined as
an mptcp_addr_info one:

	(struct mptcp_pm_addr_entry *local, struct mptcp_addr_info *remote)

But the set_flags() interface uses two mptcp_pm_addr_entry type parameters.
This patch changes the second one to mptcp_addr_info type and use helper
mptcp_pm_parse_addr() to parse it instead of using mptcp_pm_parse_entry().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 60cd35942ee5..5ae19b96bfd5 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -556,10 +556,10 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 {
 	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
-	struct mptcp_pm_addr_entry rem = { .addr = { .family = AF_UNSPEC }, };
 	struct nlattr *attr_rem = info->attrs[MPTCP_PM_ATTR_ADDR_REMOTE];
 	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct nlattr *attr = info->attrs[MPTCP_PM_ATTR_ADDR];
+	struct mptcp_addr_info rem = { .family = AF_UNSPEC, };
 	struct net *net = sock_net(skb->sk);
 	struct mptcp_sock *msk;
 	int ret = -EINVAL;
@@ -587,13 +587,13 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 		goto set_flags_err;
 
 	if (attr_rem) {
-		ret = mptcp_pm_parse_entry(attr_rem, info, false, &rem);
+		ret = mptcp_pm_parse_addr(attr_rem, info, &rem);
 		if (ret < 0)
 			goto set_flags_err;
 	}
 
 	if (loc.addr.family == AF_UNSPEC ||
-	    rem.addr.family == AF_UNSPEC) {
+	    rem.family == AF_UNSPEC) {
 		GENL_SET_ERR_MSG(info, "invalid address families");
 		ret = -EINVAL;
 		goto set_flags_err;
@@ -603,7 +603,7 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 		bkup = 1;
 
 	lock_sock(sk);
-	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem.addr, bkup);
+	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem, bkup);
 	release_sock(sk);
 
 set_flags_err:
-- 
2.43.0

