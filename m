Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8FA363C51
	for <mptcp@lists.linux.dev>; Fri,  5 Jun 2026 01:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622678; cv=none; b=es3Kf4VcQAJ+mAt0stR/HvXuXvt1nHDLI3BDJ5rkKAbJw3zd01+1zYPIMHsWang/LozCE6UwxhOhpsdVe/zzs3dIZLvWbBPAPBgtlp8GY3/QQaak63diEL9NKTBf+5CU52ExXjTZUt38F63N1m9l/j6JKZRNfQJLi7w057QXJMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622678; c=relaxed/simple;
	bh=C8Alr9wHDA1wyvNjYB2Q8LN7wGjGU3z/KZAEUgOKn0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCOw2MzxgCej+4AqIM5Ko80EmfmAvQ2OBX1biTrtswkDN0anFKliEwpWBhwLSxMSHZV1jTQyEP2FFY4cIjvKINKd/U/FCUShgSRigafGBJLyo+vU4U45uZcd87RqyJNoZjIoqnslhnczDI293cP63Mh6qkq1Iv/Kc6OvxlMVNaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=keaLkcG4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="keaLkcG4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D0D1F00898;
	Fri,  5 Jun 2026 01:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780622671;
	bh=WEViAPywuZzQo7Al26/ts5tn23+npYf3//x6bxmYZBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=keaLkcG4hLY9D2I+ATL+lRfOoJSUUb9NKqhKnvXLxE54MY4FDW73svkjq/RIBwZpX
	 5PFs2Kz0MFGC6Q69by21s13j5qQxGZMgsU8tVTyGo4ucUIYC4A80XPOlemoVFkbP7X
	 OO2W66ud4gVZTxGkqbGwdE7oCEmcnJp7IdRmHDn53ookhVDx8MWg3zsII1MjWLArfF
	 c5SEDrHyLqP/G17LXDV2TrMpeTG7a72Q9EnizCpRuQHOrIisE3x2Xrju/Z2wRM6w/L
	 k46gkJjmVlp3SywXLGdBFR+rTZHyb8Q7QCScvgNZHv1Y/R9/UPyMHUXlGaqB3oXXQa
	 8DgGqZdp0jzJg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev,
	yangang@kylinos.cn,
	qiang.zhang@linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [RFC mptcp-next v24 14/18] selftests: tls: increase nonblocking data size for mptcp
Date: Fri,  5 Jun 2026 09:22:54 +0800
Message-ID: <1a1d342ccf9c0ed50b4bd133531d60912cc42bb9.1780621326.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1780621326.git.tanggeliang@kylinos.cn>
References: <cover.1780621326.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Increase the data size in nonblocking tests to accommodate MPTCP's
multi-subflow behavior and ensure sufficient data for testing,
avoiding the following errors:

 #  RUN           tls.12_aria_gcm_mptcp.nonblocking ...
 # tls.c:1534:nonblocking:Expected 0 (0) != eagain (0)
 # nonblocking: Test failed

Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/tls.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 5a6c5ee2757f..64aad661a1b4 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1468,6 +1468,9 @@ TEST_F(tls, nonblocking)
 	int flags;
 	int res;
 
+	if (variant->mptcp)
+		data *= 4;
+
 	flags = fcntl(self->fd, F_GETFL, 0);
 	fcntl(self->fd, F_SETFL, flags | O_NONBLOCK);
 	fcntl(self->cfd, F_SETFL, flags | O_NONBLOCK);
-- 
2.53.0

