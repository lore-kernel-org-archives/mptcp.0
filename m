Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6503AD5A
	for <mptcp@lists.linux.dev>; Sun,  3 Mar 2024 09:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709459596; cv=none; b=Ujs1NYjoY9J3s83nTWsGkixPlRTzuOIduT1rxAvqBpdevSSb4v2Y7b1Aja7bV8zgJtfzU4BIf+wjSAYuevgk87FOYN47bz/WzcSfCW/qP/Z5DX3LLbqynsVe99RJw23XkJrrvZ/Hvb20LnMQ8Lse0a0MCpWhsG8IU6smN0QDsVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709459596; c=relaxed/simple;
	bh=m/ng5Hmom9GXRQpBtfcUC4cEsGR6YaD99kANdvrQIG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k1Fy4n02JAhsx2JAti4tpQJhXFs2/RhsczGau5xn2dBHN0ZMeIhxVR4Y6eojPAjwf/4PStfHEF0wFrPecwIXmDvKzy8LGWcdqxV8Fgsvy7WFTtbA8F6YPiLvlvpYJy3udEOl0aZzXdU6r9JBDim3JCOjZlIP3SDtjEravrBFmmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gP5q6Zhz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gP5q6Zhz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C35FC433C7;
	Sun,  3 Mar 2024 09:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709459596;
	bh=m/ng5Hmom9GXRQpBtfcUC4cEsGR6YaD99kANdvrQIG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gP5q6ZhzCSwuF9HIb+ehZBxRclzRfbrLuOhWGjADQXMAKg17zn85V9syyRHDu2Iac
	 ZjtUC5fZzlwCdqVvvYx9WdklV2ySAtk+JPhKTP6+IQnJWHjYHhiY4r7D5mKmmMAtVI
	 aZCDuaRM1OWvsjapIn5mnnXGpIUcilR8vwLEyMkmdiBcpaVQ0WNj7IyQsnSlBesVfl
	 eYUltwFQFvr/EsBpo5pwERrZFnzy/ReXxoYv5/T2mmcctfDwkC23SwJQgJ1hT4AEZe
	 2qHTiUVE+Y7BxhV4/7FtXKnrJpiXLciMkI353WvOMW4aljCP58m9bKgoTYAKRuXMdx
	 cykT6dVrxsUiA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v10 2/8] selftests: mptcp: connect: add dedicated port counter
Date: Sun,  3 Mar 2024 17:52:22 +0800
Message-Id: <b810e5d5afb5821caab1c309898b93da909f11cf.1709459360.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709459360.git.tanggeliang@kylinos.cn>
References: <cover.1709459360.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patch adds a new dedicated counter 'PORT' instead of TEST_COUNT to
increase port numbers in mptcp_connect.sh.

This can avoid outputting discontinuous test counters.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 679e366c8f6b..30f44900ad38 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -33,6 +33,7 @@ do_tcp=0
 checksum=false
 filesize=0
 connect_per_transfer=1
+PORT=0
 
 if [ $tc_loss -eq 100 ];then
 	tc_loss=1%
@@ -314,7 +315,7 @@ do_transfer()
 	local extra_args="$7"
 
 	local port
-	port=$((10000+TEST_COUNT))
+	port=$((10000+PORT++))
 	TEST_COUNT=$((TEST_COUNT+1))
 
 	if [ "$rcvbuf" -gt 0 ]; then
@@ -710,7 +711,7 @@ EOF
 
 	echo "INFO: test $msg"
 
-	TEST_COUNT=10000
+	PORT=10000
 	local extra_args="-o TRANSPARENT"
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP \
 		    ${connect_addr} ${local_addr} "${extra_args}"
-- 
2.40.1

