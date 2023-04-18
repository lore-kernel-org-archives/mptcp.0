Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03AEAFE6
	for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 18:57:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A130C433EF;
	Tue, 18 Apr 2023 18:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681844260;
	bh=pvhh1HBF2ZpOHH24X5AqKQ6tayz4pTahSUgPTUbeW5k=;
	h=From:To:Cc:Subject:Date:From;
	b=FwUp8xCQRqj5Z90J/QV7b8uJIVjwUVCzytL4PjDMavAstZWEicp87b72HmwquB+MA
	 dmvdVEED+yOJ+02W/FQwvDjrql1YfYJ7D0GTLfPJhpEIS8QD8Y6B3GnRKsSmVnutn4
	 mkVB4BDXAm/SJsoqEWwfkJBrbevYqV1kAzTM5wg/WdQOeh2EX+tN05j2ycxRfVv6Qj
	 Kn0NXeq4WjvTgveK2GYQGvqz8xa5w4maQz5V/laAruQDmZISR9VZmC/xMYlse8Wxx6
	 y3Kakeo5b0sj14LbQoVxPLj57u7fi2N3AalypaUR1aR7VZ4YXnf2hbM8Xf/ObOXCBD
	 08LCyXYLzWQww==
From: Mat Martineau <martineau@kernel.org>
To: mptcp@lists.linux.dev,
	matthieu.baerts@tessares.net
Cc: Mat Martineau <martineau@kernel.org>
Subject: [PATCH mptcp-next] MAINTAINERS: Resume MPTCP co-maintainer role
Date: Tue, 18 Apr 2023 11:57:30 -0700
Message-Id: <20230418185730.40775-1-martineau@kernel.org>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I'm returning to the MPTCP maintainer role I held for most of the
subsytem's history. This time I'm using my kernel.org email address.

Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c09473685b1..6841ef90cb0e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14612,6 +14612,7 @@ F:	net/netlabel/
 
 NETWORKING [MPTCP]
 M:	Matthieu Baerts <matthieu.baerts@tessares.net>
+M:	Mat Martineau <martineau@kernel.org>
 L:	netdev@vger.kernel.org
 L:	mptcp@lists.linux.dev
 S:	Maintained
-- 
2.40.0

