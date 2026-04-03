Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9E0374730
	for <mptcp@lists.linux.dev>; Fri,  3 Apr 2026 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775227985; cv=none; b=aEpchPiRJwOVdcZ/sVqhcQ4m0puniNF+jKIlxHLCklwtSE4iIhLFBQinxETenGt0qGnZxl2EixiNj3L+J7Qy6grpbnsOFHLvqEnG97QTdTLuENzyaF3qtTzYtSuNIrbYmMHqYX763cHE8g95N6wEqY7CKpxwk/y2Aix0haYk6mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775227985; c=relaxed/simple;
	bh=6radEouhmeoVgq+L0fCM/yv5qfQPodf4KBgaG6ooW5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryNG+g1RmnyCS9C/B/44n2CgbTemgp9vvysju3CASe0ewKoRBFudaFWXtfhrqbFgL0GHIGSxHKGzfpLuBSStwXhH5Z8bjDPiNujsW2qy4shcF7uNTvKZrPVSp8qsVMYYohC3tLKzW8RUGoZb2dkUkCJDgyKiXFzqID47E0gFjs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sx05Nz0U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sx05Nz0U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE63DC19421;
	Fri,  3 Apr 2026 14:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775227985;
	bh=6radEouhmeoVgq+L0fCM/yv5qfQPodf4KBgaG6ooW5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sx05Nz0UJ80HQY5SdSFBSUkNXEU/jTuSvdpEWQc5MIy1KTF5wd4rK44VaynyQcVPA
	 /9pylZ5pznEgwzgCjaguq06OJvVW96xyaN+BDCzVmKi0XXRW02xLpIq1RaVLCgZn+X
	 wXhoVM7at6QsNgfQ3qRm95vEtZTfSUOULkTKHqs4z1swyxrZfWgfTRssdPh6o3Bpnq
	 WcfOV6x3xM51bTWjclusajG1B/oTx1ViHe3Ej4R39+ZAqZZeXoFMonOpFFc29Lb8Hk
	 cLrvLvxSg8bSHDs2o0l8+bJpRDiC6rWFRR1upJLoVdJ7ZEFo5Q7Ql7QJJrBBvtZdlb
	 gdKn1YEGmco5A==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [RFC mptcp-next v13 13/16] selftests: tls: increase nonblocking data size for mptcp
Date: Fri,  3 Apr 2026 22:51:31 +0800
Message-ID: <ee1cf4fabad7c50a3b85e976efe146867b192751.1775227717.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1775227717.git.tanggeliang@kylinos.cn>
References: <cover.1775227717.git.tanggeliang@kylinos.cn>
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
index 55d5942b9ecd..ced333c9abcf 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1407,6 +1407,9 @@ TEST_F(tls, nonblocking)
 	int flags;
 	int res;
 
+	if (variant->mptcp)
+		data *= 4;
+
 	flags = fcntl(self->fd, F_GETFL, 0);
 	fcntl(self->fd, F_SETFL, flags | O_NONBLOCK);
 	fcntl(self->cfd, F_SETFL, flags | O_NONBLOCK);
-- 
2.51.0

