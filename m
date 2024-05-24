Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70B911720
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 06:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716533349; cv=none; b=nRwpdx0Hwh+IDQ+xzL7WPfl1AXmRA+jDlpevGNylIxpNUe51mEMLdo3z8LdwvSx7icL7iz8Ue2+qL8ZJ5G7pRTY/CJQ4t5YE8Zg3aE3j71H+9RSRQdmfs7ulhfB+170O+ELuRQGDaQdakFqDPfY8R63Yboxqz6KpqNO3TCUg+N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716533349; c=relaxed/simple;
	bh=l3vrUnQlYhO7CnIVJzFaFVZl346RR7h2rJH1bKwi7OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eO4wvaZ391gLOHECdastmK5eZKjAa3bQqh3mpBK8ahuFuVxJsKIl9vXvbTqEdAyieK+YkOMzZ1Yl32KOggvmDRrUiwMWCR/oUzWDRAAlvxwBrJX0oJlLin0VxPLwU+fEJFh/XqIEuHSbibg27Iu+hJjBoiaVfQ37fMLmUIWv8vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=so8H77fD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="so8H77fD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEE5C32786;
	Fri, 24 May 2024 06:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716533349;
	bh=l3vrUnQlYhO7CnIVJzFaFVZl346RR7h2rJH1bKwi7OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=so8H77fDhS6YGLLQGOV5KRcXOtliyrS1Yp+gC/OxOhn+v0HkldG9TWy3UrWeXlnkL
	 iFG0/T/M+oadRduBuysSqyaZA4Oe0qWyItvU+wLzO3AHw9aNiqxDFblrtwN0P0wp2B
	 xUsetkCSDI1CKopVyYqvbK326J7iPTwzYFkUHcyOnh+xSQ/RV9uUdjexPEqyESU0qi
	 IOYTpCc5g0e9A9FlmwZaIzir5jhB8yREKe3FU00Qnc0Ns9mvMsjh0iLBsvceQzaoFF
	 jd//QNOWuzmKi68DXyR38WRqGhkT9KxwxxavYaprgYaav4i6GWLQVGwxKIrPdqfHtj
	 gXqYPtVCYEuiw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v4 5/6] selftests: mptcp: join: print title after init_partial
Date: Fri, 24 May 2024 14:48:50 +0800
Message-ID: <4716cd1f4f594b2cc68e9e6692898eb725de8ce5.1716533107.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716533107.git.tanggeliang@kylinos.cn>
References: <cover.1716533107.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

init_partial may fail sometimes, in that case, titles shouldn't be
printed out. So the patch moves mptcp_lib_print_title from the front
of init_partial to the back of it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 2b66c5fa71eb..d20a053eee8f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -269,8 +269,6 @@ reset()
 		return 1
 	fi
 
-	mptcp_lib_print_title "${TEST_NAME}"
-
 	if [ "${init}" != "1" ]; then
 		init
 	else
@@ -279,6 +277,8 @@ reset()
 
 	init_partial
 
+	mptcp_lib_print_title "${TEST_NAME}"
+
 	return 0
 }
 
-- 
2.43.0

