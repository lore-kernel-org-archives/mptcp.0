Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848E63AE1B9
	for <mptcp@lists.linux.dev>; Thu, 28 May 2026 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779960469; cv=none; b=Z2HuWMlqh5bj10mP8NaCLVmpVRl+SlwWPvB1EYsYWOgkFRGCJ5LNPD4aWhTxfeq/eh1TOanJQFwtTZ9yVRuNuLjh57RxvBFgjOCvsD/niwWZj2U5zMQgxn5TjAhQx/RSOQ5vqPvvnNPB//W5DiSd1kcEDHp/3Drw7W/haLcHIPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779960469; c=relaxed/simple;
	bh=C8Alr9wHDA1wyvNjYB2Q8LN7wGjGU3z/KZAEUgOKn0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVdOndwyxqte6Gknoc6d1uDHJw/ffQ/uujRYJq3jI07gmMnveYeVN0UTNA+tam8y+VgrGFnXX8rx05uLF2c+PPi8ReIOwsAl6IibI2aPO6w25GuS8tt6qsQKqBQEqgi8kz9Yup/zrYpln4I4IA696RUCbzQPhoVCNO5UsCE5pag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrmDfg9G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrmDfg9G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509961F00A3C;
	Thu, 28 May 2026 09:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779960466;
	bh=WEViAPywuZzQo7Al26/ts5tn23+npYf3//x6bxmYZBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WrmDfg9Gj0X9GiRIhSDibcHDkYHFpa+cyV9jDnqZIzMzyrLmuXVX7tTsDDsTAc6Pw
	 f1WXtn0PmQKiIisKjAf629slFTJFb2azWl7msoGG4lW5QTJ/kV/WRON9tfJkmkwhp8
	 P+C6CeUsS0iCRgo0/rj6l0bKmf4cZxRh/wzXoXENu0xFlc50uS2pJFKN2LpANhj7Dd
	 dMZilRvQoXI4JYb/Gr7ZP74YRGGRwAxa7r1XhvjvWFRQc120OqgSC7extD1cWCSDcF
	 YLRJY66QaJggSTDNLrlUVIQ5uJznQwaUx7xwhgUGKJMrzSKp11VYiK5NRcNV2mmB7c
	 wGhX1aCUaGV3A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v21 14/18] selftests: tls: increase nonblocking data size for mptcp
Date: Thu, 28 May 2026 17:27:05 +0800
Message-ID: <01994f816b9a3d5bf46a3b70748b024cbee58abc.1779959644.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779959644.git.tanggeliang@kylinos.cn>
References: <cover.1779959644.git.tanggeliang@kylinos.cn>
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

