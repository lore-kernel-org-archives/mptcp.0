Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73698F40
	for <mptcp@lists.linux.dev>; Thu, 18 Jan 2024 06:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705558343; cv=none; b=T/rdp/HU9aeq48cpZWBpAI1/qH8FtDDrnjUqp3L7xWglXsWLagimF2uylvHraJ8E3aJaOYdqgxKXSrbQ4hIXRJoFWFKnv383JHd3FS7G5zl/Y/esYpc1aryQoa5Jt6YmugFtw5SrFmOsb20LKh5IaxKhQI50PIClWt5uY4GBIBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705558343; c=relaxed/simple;
	bh=3fKvukoQ+7FVQf5NasRfHkCE/Po8JfVoKycNgzHFYnQ=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=JaHyatebkTR7hX/w7unZCKryqcRZq8dJUySQnfIVq+F6iZPO/hezTKLocNtbtTaeZLdO2Nngev8cRZlCaRzYvhPf6MGah46VUs8QFgNq+GBcuj5NamvmjrPuBsxqPxmNQpJHu0oNSUDcJZGiZMmblzFUua4oGUVTcn2S7a+efVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MumpKQzY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MumpKQzY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7EFC433B1;
	Thu, 18 Jan 2024 06:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705558342;
	bh=3fKvukoQ+7FVQf5NasRfHkCE/Po8JfVoKycNgzHFYnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MumpKQzYQRCrd+rs458t3FG4HdadGgcdgLbUhv9HDE9zZEKVnscKN0HZtFIEdpw5O
	 Auu8rMMRfgdtVBsFwiSoO+Q+KcXEzM0mblmAbqi1gMrthbp+2whAwL/SqSHviQ6Y8I
	 7zVi7l1HmYhwTzATMEn7sSA5KavCyjgA9/dUQJuJYH+ntOJXPIo6XCylri2pZ2mbz9
	 mIoV+VxukfsbXBtrq+FEsbab44mXOcsdbMQh+bhK3Fa1D5isKwRxmJ9mFLkOmXqy2K
	 Y/u/tB5Yg3fw5467fthfoNwBImn2lrhRh4XxOVRbLc9Br7miK51X9C/vuE3L+i7Cbx
	 TtQ41Il421mSg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 10/23] mptcp: check userspace pm subflow flag
Date: Thu, 18 Jan 2024 14:11:50 +0800
Message-Id: <8df3db253cf4e880813e2b499b12887904474736.1705558030.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1705558030.git.tanggeliang@kylinos.cn>
References: <cover.1705558030.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Just like MPTCP_PM_ADDR_FLAG_SIGNAL flag is checked in userspace PM
announce mptcp_pm_nl_announce_doit(), MPTCP_PM_ADDR_FLAG_SUBFLOW flag
should be checked in mptcp_pm_nl_subflow_create_doit() too.

If MPTCP_PM_ADDR_FLAG_SUBFLOW flag is not set, there's no flags field
in the output of dump_addr. This looks a bit strange:

	id 10 flags  10.0.3.2

This patch uses mptcp_pm_parse_entry() instead of mptcp_pm_parse_addr()
to get the flags of the entry. Add MPTCP_PM_ADDR_FLAG_SUBFLOW flag check
in mptcp_pm_nl_subflow_create_doit().

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index f1582f40f70e..ca0d6e1dfade 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -361,11 +361,18 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	err = mptcp_pm_parse_addr(laddr, info, &addr_l);
+	err = mptcp_pm_parse_entry(laddr, info, true, &local);
 	if (err < 0) {
 		NL_SET_ERR_MSG_ATTR(info->extack, laddr, "error parsing local addr");
 		goto create_err;
 	}
+	addr_l = local.addr;
+
+	if (!(local.flags & MPTCP_PM_ADDR_FLAG_SUBFLOW)) {
+		GENL_SET_ERR_MSG(info, "invalid addr flags");
+		err = -EINVAL;
+		goto create_err;
+	}
 
 	err = mptcp_pm_parse_addr(raddr, info, &addr_r);
 	if (err < 0) {
@@ -379,7 +386,6 @@ int mptcp_pm_nl_subflow_create_doit(struct sk_buff *skb, struct genl_info *info)
 		goto create_err;
 	}
 
-	local.addr = addr_l;
 	err = mptcp_userspace_pm_append_new_local_addr(msk, &local,
 						       !mptcp_pm_has_addr_attr_id(laddr, info));
 	if (err < 0) {
-- 
2.40.1

