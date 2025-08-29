Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AD12727EA
	for <mptcp@lists.linux.dev>; Fri, 29 Aug 2025 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756458633; cv=none; b=no9y0AAsCzylQM5X9GTwZli1AQyuR3koll2PBqZ1VA54WkVAe4SqR60ZKVskSgNGez2BBJ6IdCoO90Vq0ktdTO6/1FZ13pp99j25m/Wm3M2G05JCRA+/Lh98q4k4THMrqPNc2QO/dkfNIEgwJ2xkPy0CP8RsVbuMIv0p1JFCFw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756458633; c=relaxed/simple;
	bh=VACcF3IqbT0KbR4SH3lYZ4CVra4Oy286Mm9koaJteek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVrtTeGyQT9tGvg5YKIEbT3T7GcG6Tqoj9C9MDbSeV7SNHDK2xI79L0at5K5H5UfW9w123TDK3GCxuW6IKxiL6vLgB+sDHIuAc8UpXTbcDwC+sWu3qk6jWbjrzXl3Vz38sa8WPh5DtwJTfI54k9nHpru17l3x0XHvBltNHnU2Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugHB/Zxw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugHB/Zxw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37791C4CEF0;
	Fri, 29 Aug 2025 09:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756458631;
	bh=VACcF3IqbT0KbR4SH3lYZ4CVra4Oy286Mm9koaJteek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ugHB/ZxwC6mTbdSVjpabPQb2sOK0eWc2gHkfBO8s7hUoOHCpkL79SQ/bZLVqvq1sP
	 w9qwSPbkPUv8sgPKd/Q4JaIFdRuaj58265LrVifls3jOLZlLrzGNu8tMSSkD++eNGz
	 vQun78f6fUB7ttPhNdze5vGp74dTSgYc/lvFUy4v6h2RE/AYyDYy2TLRqzyj2BSoDg
	 h8bjbc559siYMA8awwUjL5qUHiezjPJG7yPVy79owbI5pKckD5V74mTKzr1oBgFdzp
	 pLWxnPmy0J98d9QjLUjEWNQ3/j7g8sdpRAjSRILWxzHD3Egugcu38mtf+dyDn0+NvI
	 zIk/LTop7sB9w==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 2/2] Squash to "selftests: mptcp: connect: cover splice mode"
Date: Fri, 29 Aug 2025 17:10:07 +0800
Message-ID: <523de3cb2e2b40e4b6e6560095d711ae8b648ac1.1756458375.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1756458375.git.tanggeliang@kylinos.cn>
References: <cover.1756458375.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Update subtest name.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh b/tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh
index 77fe240ecf8c..241254a966c9 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect_splice.sh
@@ -1,4 +1,5 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-"$(dirname "${0}")/mptcp_connect.sh" -m splice "${@}"
+MPTCP_LIB_KSFT_TEST="$(basename "${0}" .sh)" \
+	"$(dirname "${0}")/mptcp_connect.sh" -m splice "${@}"
-- 
2.48.1

