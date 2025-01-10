Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5813814A08E
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 07:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494256; cv=none; b=BjVep9n81+qnSpGp9lGmaABCiic5SadaWsi4fQZwxxbYOFPwIEHaGtyhJ+mwyWR1ZVBusDDfHN+sYUuVxf8NkONcfLcoyEi3foOW1qS7bAxb7PfKg5NBBxfmsi0nKARYbnr8dY5d7xPOs/um5IlvXhNzqUhom1HcMwpCkAHvN8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494256; c=relaxed/simple;
	bh=Bs2qqRlQwp4MNUE9DrajrFyHEaBIDfBm4ktap5SzAYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EoBk6HzIo7DyOi+Aa7h0wsY5idOfERIadmVaD/B3VbwLuuVh81/t9H2+urZpl8c45OF42oJz6XL+OJ6/8qfAANReX1U9L8lXFUuCjpI/nAa1lx+iMBAEB2j+EPFmHPNHHBFsBuVWt/9hYH/eWhtj0BiOCKpCqVY9PAv//mZmPhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jt0nFbbG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jt0nFbbG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0053EC4CED6;
	Fri, 10 Jan 2025 07:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736494255;
	bh=Bs2qqRlQwp4MNUE9DrajrFyHEaBIDfBm4ktap5SzAYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jt0nFbbGGF6Kg//4J7tOu4Kyhdp+p/YldW9/Y0WSghFw85Mm9oUx+VDG6dTE3AP57
	 WPpEYL6YLJ3d9GeMwCQvenUP09yQ/KN0h7BIElTDpBLnjwNbDeRmgoR9zVT4tf4W2q
	 tVvCObz2ivI191A1IbsJuHpdJVxuZ7IlivGVSnbxD6Y8HX+TBWLm3aJrJe6bNL1Hj1
	 ZCBARCTPwu85PjsvUpcsZEnhgPZK7Ren+Yvd1IxeW7ehraO+sUw5XOMbUrKcas4gsj
	 FtL6eJdkQjj5ikMBs2vf5SabUPGVOeuyQB3sxpCGMi/r9GmZkAVcqQnp9mZRI4et86
	 nNBmwhYWDN+jg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next v9 4/8] mptcp: pm: improve error messages
Date: Fri, 10 Jan 2025 15:30:38 +0800
Message-ID: <43c16e82cdcf607e8dc8ebc19d033bbc364e06f3.1736493803.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1736493803.git.tanggeliang@kylinos.cn>
References: <cover.1736493803.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>

Some error messages were:

 - too generic: "missing input", "invalid request"

 - not precise enough: "limit greater than maximum" but what's the max?

 - missing: subflow not found, or connect error.

This can be easily improved by being more precise, or adding new error
messages.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: add a comment in mptcp_userspace_pm_set_flags().
---
 net/mptcp/pm_netlink.c   |  6 ++++--
 net/mptcp/pm_userspace.c | 10 +++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 98ac73938bd8..a60217faf95d 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1875,7 +1875,9 @@ static int parse_limit(struct genl_info *info, int id, unsigned int *limit)
 
 	*limit = nla_get_u32(attr);
 	if (*limit > MPTCP_PM_ADDR_MAX) {
-		GENL_SET_ERR_MSG(info, "limit greater than maximum");
+		NL_SET_ERR_MSG_ATTR_FMT(info->extack, attr,
+					"limit greater than maximum (%u)",
+					MPTCP_PM_ADDR_MAX);
 		return -EINVAL;
 	}
 	return 0;
@@ -2003,7 +2005,7 @@ int mptcp_pm_nl_set_flags(struct sk_buff *skb, struct genl_info *info)
 	if (addr.addr.family == AF_UNSPEC) {
 		lookup_by_id = 1;
 		if (!addr.addr.id) {
-			GENL_SET_ERR_MSG(info, "missing required inputs");
+			GENL_SET_ERR_MSG(info, "missing address ID");
 			return -EOPNOTSUPP;
 		}
 	}
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index cdc83fabb7c2..e350d6cc23bf 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -190,7 +190,7 @@ static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *in
 	}
 
 	if (!mptcp_pm_is_userspace(msk)) {
-		GENL_SET_ERR_MSG(info, "invalid request; userspace PM not selected");
+		GENL_SET_ERR_MSG(info, "userspace PM not selected");
 		sock_put((struct sock *)msk);
 		return NULL;
 	}
@@ -428,6 +428,9 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 	err = __mptcp_subflow_connect(sk, &local, &addr_r);
 	release_sock(sk);
 
+	if (err)
+		GENL_SET_ERR_MSG_FMT(info, "connect error: %d", err);
+
 	spin_lock_bh(&msk->pm.lock);
 	if (err)
 		mptcp_userspace_pm_delete_local_addr(msk, &entry);
@@ -552,6 +555,7 @@ int mptcp_pm_nl_subflow_destroy_doit(struct sk_buff *skb, struct genl_info *info
 	lock_sock(sk);
 	ssk = mptcp_nl_find_ssk(msk, &addr_l.addr, &addr_r);
 	if (!ssk) {
+		GENL_SET_ERR_MSG(info, "subflow not found");
 		err = -ESRCH;
 		goto release_sock;
 	}
@@ -625,6 +629,10 @@ int mptcp_userspace_pm_set_flags(struct sk_buff *skb, struct genl_info *info)
 	ret = mptcp_pm_nl_mp_prio_send_ack(msk, &loc.addr, &rem.addr, bkup);
 	release_sock(sk);
 
+	/* mptcp_pm_nl_mp_prio_send_ack() only fails in one case */
+	if (ret < 0)
+		GENL_SET_ERR_MSG(info, "subflow not found");
+
 set_flags_err:
 	sock_put(sk);
 	return ret;
-- 
2.45.2

