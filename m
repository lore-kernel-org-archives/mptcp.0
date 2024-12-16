Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897E4171BB
	for <mptcp@lists.linux.dev>; Mon, 16 Dec 2024 01:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734313559; cv=none; b=o+ZSm3yHEK6x0kQVcvn/pwCv9WVSMgj6mRx9RKQszHowP5HvS3fQQI2KDKYkpJa0NnF3SzaQP1irOrSfFkTBQ31WZ3HUN337my63Mh6QtvPJ9ta+LtuYUuxCya+ZbiSYLKAXlymQx3gLO3i7GL0BkfT7aR2Kq7Q3/oT0h6jASJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734313559; c=relaxed/simple;
	bh=w7ulMK4W3EGtxVSJc/jLqSqdkVYaB0MBjw74FenfNkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dJlLJEbTqPbXwgQwPlPe2rawu1e83Q72SWwmMERrV7wl0k4V9gKchQP+chGNKS+WzOwwX2sxMOzGXD/G1QULv2g8qtqc7pUKYTUat7YGyEykaPT8c8rm5JtuINd9ekS8XS/lPT82e0uZi30MIkVU+iMf3oCdURByAILvjA9UZ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxywkEyH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxywkEyH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9105FC4CECE;
	Mon, 16 Dec 2024 01:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734313559;
	bh=w7ulMK4W3EGtxVSJc/jLqSqdkVYaB0MBjw74FenfNkI=;
	h=From:To:Cc:Subject:Date:From;
	b=HxywkEyHw5ZrSh7i6yHm1puU82IXkXzB0V+PLpaHWq+T/pjyCp/vOh6Bb2GwuevnK
	 HYCA6rsMol0LhLx9HzbxHE/PII9NOsDRe/m1AmVh/FuX5PcW2yWDc7o6Z+SxN6sHBc
	 silnNpIIufT8ZV/f6vXPNiE/heqi85Uk0las85DVfe2U2nB2+JOyENHtzo7tfy7Y4p
	 m+JUC60Usy9GYd7Vejy7U4wv739KQybGYI849G1iN+tZn9Wc7WtCVISLnlzuKW6oxl
	 UcU9Mb86p9iR+1WLyJNjd5tBIHsrUQTpV8kHQsbu81jD5LBdb6YRdtbYKA6WESXrfs
	 WU8id4967YoTA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH mptcp-next] mptcp: use GENL_REQ_ATTR_CHECK in userspace pm
Date: Mon, 16 Dec 2024 09:45:52 +0800
Message-ID: <3f7656f9232ac4a36017babc0eabf5059c283a63.1734313517.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In mptcp_userspace_pm_get_sock(), a more general way to check if
MPTCP_PM_ATTR_TOKEN exists in 'info' is to use

        GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_TOKEN)

instead of directly reading info->attrs[MPTCP_PM_ATTR_TOKEN] and
then checking if it's NULL.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 net/mptcp/pm_userspace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index 740a10d669f8..cc2b7c50d4d6 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -175,14 +175,15 @@ bool mptcp_userspace_pm_is_backup(struct mptcp_sock *msk,
 
 static struct mptcp_sock *mptcp_userspace_pm_get_sock(const struct genl_info *info)
 {
-	struct nlattr *token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	struct mptcp_sock *msk;
+	struct nlattr *token;
 
-	if (!token) {
+	if (GENL_REQ_ATTR_CHECK(info, MPTCP_PM_ATTR_TOKEN)) {
 		GENL_SET_ERR_MSG(info, "missing required token");
 		return NULL;
 	}
 
+	token = info->attrs[MPTCP_PM_ATTR_TOKEN];
 	msk = mptcp_token_get_sock(genl_info_net(info), nla_get_u32(token));
 	if (!msk) {
 		NL_SET_ERR_MSG_ATTR(info->extack, token, "invalid token");
-- 
2.45.2

