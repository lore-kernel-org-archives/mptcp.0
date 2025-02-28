Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38BD1E4A9
	for <mptcp@lists.linux.dev>; Fri, 28 Feb 2025 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740749517; cv=none; b=VSJtVvocR0g5T0nfXEy0h2O5Vt/bqpSgoRHTqEONvMbSbMYUZ3CuJ4wGBx25bxGxmrUBXHr8mErAj9ciuV6wpINiLdeCgZ9M0T/wDE2V62AHi5NnEKdt9NaxMoKSU4kijJwHEmLnLdKYi0P8V9UqRkHXXhzeCqHlJ5RXW0lCRqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740749517; c=relaxed/simple;
	bh=BL/lActL4XF6LBK6g/whdamA357n++BDmX+BFnKxjx0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ofugEN4l9L8ZT9llnO2xP8tnDXUPg2KdoTio/m1mLL9lhPq49IkX9Ldel5F3gLensctAO2TTaDof2mrD15tegF+4cjjqKsy7Y454QSDaWZPbptX59eNNDe2xF2Q33el1TwKYsaPTsXBjCnKh6gyL43VoOrsKy5taAgq07Y6NI+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3sxotu3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3sxotu3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A3CC4CEE7;
	Fri, 28 Feb 2025 13:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740749517;
	bh=BL/lActL4XF6LBK6g/whdamA357n++BDmX+BFnKxjx0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l3sxotu3s2kZxBiSoDzilkiUSJzF5OCIlN4R8Cum6dpa4tnJynxcB3yZLdd3FCbvB
	 N5etsLjVpYuEk05uCQJQu0sPtX0eLfXxiIAj1wclMw3bCH8aF2PEq5Dd7DiTrsoVe/
	 klUf2ctTmgsmX/XpnOgNm2+NKEAJ4DCIWdUEkuymRz8IH9LWPr5X4uafniDsr2EV7d
	 vmJpcsxxa9MSyrgP0TTiy2O48x7RUXb2GICKNRWJ46DEJM3pgsQRBmaLm/9gIJ+sSz
	 glpJg7zZG1XcK9OQpDQyw7gqrdHWYJZn6eGFTFe5cVazP/QObsstMQCTLNUenYpWor
	 blVRlHEdLxoow==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 28 Feb 2025 14:31:34 +0100
Subject: [PATCH mptcp-next v2 14/14] mptcp: pm: move Netlink PM helpers to
 pm_netlink.c
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-mptcp-pm-reorg-code-v2-14-fa8b2542b7a5@kernel.org>
References: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
In-Reply-To: <20250228-mptcp-pm-reorg-code-v2-0-fa8b2542b7a5@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliang@kernel.org>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9735; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=BL/lActL4XF6LBK6g/whdamA357n++BDmX+BFnKxjx0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnwbq6wp7lq2olX/LmLr7/K7+FLJuDNJIyNXW3S
 53xjce8AROJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ8G6ugAKCRD2t4JPQmmg
 c+CqEADdSoIvGZI6eYI6VuKaUF3e1CKZNVA2Tx5OEzQzRwx8PNqO6girHOp/AenlzweXP1SkSdE
 EGKvJz451n1N7PIayxh3M44j6bSld2yHxqGeeDC0hGU1bdk+70Xb43qF6WtTj1+m3WihnbCCsdR
 TTB9MuG1fNduaeoLrzB6fQIlsVNXYYisO00Hd5Mjw8fpv1bv9qYlVUPZUVPzgzmES5H4UjVVLz+
 arlqR5Q+ZlDNXx/CfI/2XDkEG1UqhZlx62vi7Zv2xeMMVhGuR2gFS23VQrNRTIDEbgO576rImEN
 HjWmhfOpalKPJdktkvZ1sel+SJm6h5zgtd5a+YMeQ3/OXftaUDCOryx/eL6U05dMxcQOXRYzzat
 uYm07fiqZPiJEToLSAMUr/y5o+vfk+aNScTWg4RXSISDoSVpE/+KV2s5RO8ZkVJ5Y+qGb11OmFg
 N6x52tPI7m/JA/pZMGGLb77FNyCSDEgIMGd9rGnEu0iZVAN9SYagK79Lp2nEDLj+rJNPhyP/O5f
 i/l8yLC+X/lY4w6T7iBoDVV6tXKbiHbg6OohoFcvkxE4mnHBCAmBg2Jo2T1LMwFa8/88+q68PuQ
 I6q0W1dfrBFaLSvlnNxqEhHkwG9WFJwUDeXnWgcvhV0PwybtQTWfWottNE7o2rrJj1HTktIDffm
 sPFaxtluTHr8Sng==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Before this patch, the PM code was dispersed in different places:

- pm.c had common code for all PMs, but also Netlink specific code that
  will not be needed with the future BPF path-managers.

- pm_netlink.c had common Netlink code.

To clarify the code, a reorganisation is suggested here, only by moving
code around, and small helper renaming to avoid confusions:

- pm_netlink.c now only contains common PM Netlink code:
  - PM events: this code was already there
  - shared helpers around Netlink code that were already there as well
  - shared Netlink commands code from pm.c

- pm.c now no longer contain Netlink specific code.

- protocol.h has been updated accordingly:
  - mptcp_nl_fill_addr() no longer need to be exported.

The code around the PM is now less confusing, which should help for the
maintenance in the long term.

This will certainly impact future backports, but because other cleanups
have already done recently, and more are coming to ease the addition of
a new path-manager controlled with BPF (struct_ops), doing that now
seems to be a good time. Also, many issues around the PM have been fixed
a few months ago while increasing the code coverage in the selftests, so
such big reorganisation can be done with more confidence now.

No behavioural changes intended.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm.c         | 119 -------------------------------------------------
 net/mptcp/pm_netlink.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++-
 net/mptcp/protocol.h   |   2 -
 3 files changed, 117 insertions(+), 123 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index d02a0b3adfc43e134cc83140759703ce1147bc9e..833839d7286e717599579356af3117f70e39de0a 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -5,12 +5,8 @@
  */
 #define pr_fmt(fmt) "MPTCP: " fmt
 
-#include <linux/kernel.h>
-#include <net/mptcp.h>
 #include "protocol.h"
-
 #include "mib.h"
-#include "mptcp_pm_gen.h"
 
 #define ADD_ADDR_RETRANS_MAX	3
 
@@ -888,121 +884,6 @@ bool mptcp_pm_is_backup(struct mptcp_sock *msk, struct sock_common *skc)
 	return mptcp_pm_nl_is_backup(msk, &skc_local);
 }
 
-static int mptcp_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
-			     struct genl_info *info)
-{
-	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_get_addr(id, addr, info);
-	return mptcp_pm_nl_get_addr(id, addr, info);
-}
-
-int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	struct mptcp_pm_addr_entry addr;
-	struct nlattr *attr;
-	struct sk_buff *msg;
-	void *reply;
-	int ret;
-
-	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
-		return -EINVAL;
-
-	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
-	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
-	if (ret < 0)
-		return ret;
-
-	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	reply = genlmsg_put_reply(msg, info, &mptcp_genl_family, 0,
-				  info->genlhdr->cmd);
-	if (!reply) {
-		GENL_SET_ERR_MSG(info, "not enough space in Netlink message");
-		ret = -EMSGSIZE;
-		goto fail;
-	}
-
-	ret = mptcp_pm_get_addr(addr.addr.id, &addr, info);
-	if (ret) {
-		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
-		goto fail;
-	}
-
-	ret = mptcp_nl_fill_addr(msg, &addr);
-	if (ret)
-		goto fail;
-
-	genlmsg_end(msg, reply);
-	ret = genlmsg_reply(msg, info);
-	return ret;
-
-fail:
-	nlmsg_free(msg);
-	return ret;
-}
-
-int mptcp_pm_genl_fill_addr(struct sk_buff *msg,
-			    struct netlink_callback *cb,
-			    struct mptcp_pm_addr_entry *entry)
-{
-	void *hdr;
-
-	hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
-			  cb->nlh->nlmsg_seq, &mptcp_genl_family,
-			  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
-	if (!hdr)
-		return -EINVAL;
-
-	if (mptcp_nl_fill_addr(msg, entry) < 0) {
-		genlmsg_cancel(msg, hdr);
-		return -EINVAL;
-	}
-
-	genlmsg_end(msg, hdr);
-	return 0;
-}
-
-static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
-{
-	const struct genl_info *info = genl_info_dump(cb);
-
-	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_dump_addr(msg, cb);
-	return mptcp_pm_nl_dump_addr(msg, cb);
-}
-
-int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
-				struct netlink_callback *cb)
-{
-	return mptcp_pm_dump_addr(msg, cb);
-}
-
-static int mptcp_pm_set_flags(struct genl_info *info)
-{
-	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
-	struct nlattr *attr_loc;
-	int ret = -EINVAL;
-
-	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
-		return ret;
-
-	attr_loc = info->attrs[MPTCP_PM_ATTR_ADDR];
-	ret = mptcp_pm_parse_entry(attr_loc, info, false, &loc);
-	if (ret < 0)
-		return ret;
-
-	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
-		return mptcp_userspace_pm_set_flags(&loc, info);
-	return mptcp_pm_nl_set_flags(&loc, info);
-}
-
-int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
-{
-	return mptcp_pm_set_flags(info);
-}
-
 static void mptcp_pm_subflows_chk_stale(const struct mptcp_sock *msk, struct sock *ssk)
 {
 	struct mptcp_subflow_context *iter, *subflow = mptcp_subflow_ctx(ssk);
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 530b2362a5a35c5ef44d3bf495c8103bdfa08cff..b2e5bbdcd5df920887ffbd9b6d652f422b32d49e 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -127,8 +127,8 @@ int mptcp_pm_parse_entry(struct nlattr *attr, struct genl_info *info,
 	return 0;
 }
 
-int mptcp_nl_fill_addr(struct sk_buff *skb,
-		       struct mptcp_pm_addr_entry *entry)
+static int mptcp_nl_fill_addr(struct sk_buff *skb,
+			      struct mptcp_pm_addr_entry *entry)
 {
 	struct mptcp_addr_info *addr = &entry->addr;
 	struct nlattr *attr;
@@ -166,6 +166,121 @@ int mptcp_nl_fill_addr(struct sk_buff *skb,
 	return -EMSGSIZE;
 }
 
+static int mptcp_pm_get_addr(u8 id, struct mptcp_pm_addr_entry *addr,
+			     struct genl_info *info)
+{
+	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
+		return mptcp_userspace_pm_get_addr(id, addr, info);
+	return mptcp_pm_nl_get_addr(id, addr, info);
+}
+
+int mptcp_pm_nl_get_addr_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct mptcp_pm_addr_entry addr;
+	struct nlattr *attr;
+	struct sk_buff *msg;
+	void *reply;
+	int ret;
+
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ENDPOINT_ADDR))
+		return -EINVAL;
+
+	attr = info->attrs[MPTCP_PM_ENDPOINT_ADDR];
+	ret = mptcp_pm_parse_entry(attr, info, false, &addr);
+	if (ret < 0)
+		return ret;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	reply = genlmsg_put_reply(msg, info, &mptcp_genl_family, 0,
+				  info->genlhdr->cmd);
+	if (!reply) {
+		GENL_SET_ERR_MSG(info, "not enough space in Netlink message");
+		ret = -EMSGSIZE;
+		goto fail;
+	}
+
+	ret = mptcp_pm_get_addr(addr.addr.id, &addr, info);
+	if (ret) {
+		NL_SET_ERR_MSG_ATTR(info->extack, attr, "address not found");
+		goto fail;
+	}
+
+	ret = mptcp_nl_fill_addr(msg, &addr);
+	if (ret)
+		goto fail;
+
+	genlmsg_end(msg, reply);
+	ret = genlmsg_reply(msg, info);
+	return ret;
+
+fail:
+	nlmsg_free(msg);
+	return ret;
+}
+
+int mptcp_pm_genl_fill_addr(struct sk_buff *msg,
+			    struct netlink_callback *cb,
+			    struct mptcp_pm_addr_entry *entry)
+{
+	void *hdr;
+
+	hdr = genlmsg_put(msg, NETLINK_CB(cb->skb).portid,
+			  cb->nlh->nlmsg_seq, &mptcp_genl_family,
+			  NLM_F_MULTI, MPTCP_PM_CMD_GET_ADDR);
+	if (!hdr)
+		return -EINVAL;
+
+	if (mptcp_nl_fill_addr(msg, entry) < 0) {
+		genlmsg_cancel(msg, hdr);
+		return -EINVAL;
+	}
+
+	genlmsg_end(msg, hdr);
+	return 0;
+}
+
+static int mptcp_pm_dump_addr(struct sk_buff *msg, struct netlink_callback *cb)
+{
+	const struct genl_info *info = genl_info_dump(cb);
+
+	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
+		return mptcp_userspace_pm_dump_addr(msg, cb);
+	return mptcp_pm_nl_dump_addr(msg, cb);
+}
+
+int mptcp_pm_nl_get_addr_dumpit(struct sk_buff *msg,
+				struct netlink_callback *cb)
+{
+	return mptcp_pm_dump_addr(msg, cb);
+}
+
+static int mptcp_pm_set_flags(struct genl_info *info)
+{
+	struct mptcp_pm_addr_entry loc = { .addr = { .family = AF_UNSPEC }, };
+	struct nlattr *attr_loc;
+	int ret = -EINVAL;
+
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_ADDR))
+		return ret;
+
+	attr_loc = info->attrs[MPTCP_PM_ATTR_ADDR];
+	ret = mptcp_pm_parse_entry(attr_loc, info, false, &loc);
+	if (ret < 0)
+		return ret;
+
+	if (info->attrs[MPTCP_PM_ATTR_TOKEN])
+		return mptcp_userspace_pm_set_flags(&loc, info);
+	return mptcp_pm_nl_set_flags(&loc, info);
+}
+
+int mptcp_pm_nl_set_flags_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	return mptcp_pm_set_flags(info);
+}
+
 static void mptcp_nl_mcast_send(struct net *net, struct sk_buff *nlskb, gfp_t gfp)
 {
 	genlmsg_multicast_netns(&mptcp_genl_family, net,
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index c57b9f380a9c1a0ef1df169c6fb320940d131623..9bdfd915d62f52feb8e3f29f6f429dfa837f5f2b 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1062,8 +1062,6 @@ bool mptcp_userspace_pm_active(const struct mptcp_sock *msk);
 
 void mptcp_fastopen_subflow_synack_set_params(struct mptcp_subflow_context *subflow,
 					      struct request_sock *req);
-int mptcp_nl_fill_addr(struct sk_buff *skb,
-		       struct mptcp_pm_addr_entry *entry);
 int mptcp_pm_genl_fill_addr(struct sk_buff *msg,
 			    struct netlink_callback *cb,
 			    struct mptcp_pm_addr_entry *entry);

-- 
2.47.1

