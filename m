Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDBEC958
	for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 23:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1D7C4339B;
	Tue, 18 Apr 2023 23:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681859646;
	bh=+Mu6h9kentylkzQiOvIdx431yxQ3VK2fh5umXPmH9qg=;
	h=From:To:Cc:Subject:Date:From;
	b=a4q1mWIB07iNIPhDHszP0SFFHV5q/L0+X15Pg+haHPACEjFmeitjINdYp8ICytNY8
	 fVPOj0RHGUUMlEYWgs6FxjIYsSrYj5iHGczPXQ9zJ9c5Lmp9wC0N4Wq1lvCoy5+/am
	 sdzvcXgt3NHWsowUW+Xm1ue7u/Wy7BWFU/9LLJliO2maWf8rankOeuf5xLiHvPnh/Y
	 JpsonKMFs8oLP5jmyVK9f4WMjU1JRxY5gfsFnP9qKo9KR5/WKtVSgvXnsO/B0qVI0o
	 k5xa4DeuampveLaGdvM8wvj9e2dF8t3irtaSUWz8krOTF9SxchtTc3vhAFqF3RktnR
	 lKseNkAmvMp3g==
From: Mat Martineau <martineau@kernel.org>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com
Cc: Mat Martineau <martineau@kernel.org>,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH net-next] MAINTAINERS: Resume MPTCP co-maintainer role
Date: Tue, 18 Apr 2023 16:13:18 -0700
Message-Id: <20230418231318.115331-1-martineau@kernel.org>
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

Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Link: https://lore.kernel.org/mptcp/af85e467-8d0a-4eba-b5f8-e2f2c5d24984@tessares.net/
Signed-off-by: Mat Martineau <martineau@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4fc57dfd5fd0..e5ff4687d3f5 100644
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

