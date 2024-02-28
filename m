Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40A924B2C
	for <mptcp@lists.linux.dev>; Wed, 28 Feb 2024 07:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106249; cv=none; b=LL/BnAgF5xXq1PR+NQd4Ng0S+arzQlXvklXIPE/M/LodWeobduBg6I3NXsGGFRetk+328vQdcPTTamt8vhsKa3O9j9kj+2e8mNpvEMJWI0eXmEiDkNst7oYnhdwtsNF9HbTt0oljfEBxx1xKvq2RkxFskdR4n4gVnJ2E5jPQXko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106249; c=relaxed/simple;
	bh=y56OYk7r207VtC35oOIi6PNy6gOdf5bqLAg7WNjD/IY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DCCFui01Ihgo7xIPYLFesFuc0wJlSqbwMXi+6oVxKsgF1DkhMOmlggSizj+89It6cUVDCaERGYuA5j4DSNL+aWHKHGx9jMjjW07NWk020G0YLcyh2hoKSyv3LvJOfzEm61td1IV2XyVYfRFv2iwKhf4KF76NDMV9+xMxNNkiWs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=panZKRQJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="panZKRQJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F603C433C7;
	Wed, 28 Feb 2024 07:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709106248;
	bh=y56OYk7r207VtC35oOIi6PNy6gOdf5bqLAg7WNjD/IY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=panZKRQJ7lOTn799kOiq8YGEaxU7MqiBT5nEKUFiwJXesQe8kyPV68pG30SE3kVC9
	 OdLF8zrifsKA/HeCK+8/AGUtXJ8nrdyjTxcibnwkiNBhTneevUAnypR5N42nKETufg
	 2+jUza8CrG2Hz58RhyXxtUE7JRNx8sufErpRsc9u9fiQe3/TILC1LvYn3uxrMcbVWh
	 acvYVZ56+j56IozWLkKHOr3ZaBLNkhripILhHgACfLpW1M6ymRpiCVyTBj5CQR1Rr3
	 MV5h6mE1bEkfHLQqL+MwDKuXQkhW9b5fI5YTq+91axSPp1YVM6MW6WQzAXc/X5Nd1X
	 L4o3gw1IyF5jw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v6 8/9] selftests: mptcp: connect: add dedicated port counter
Date: Wed, 28 Feb 2024 15:43:46 +0800
Message-Id: <ee42578324aa785e0289b4bc76616e8211acc4b3.1709105922.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709105922.git.tanggeliang@kylinos.cn>
References: <cover.1709105922.git.tanggeliang@kylinos.cn>
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
index bb0c7bf5b368..818625b5e605 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -33,6 +33,7 @@ do_tcp=0
 checksum=false
 filesize=0
 connect_per_transfer=1
+PORT=0
 
 if [ $tc_loss -eq 100 ];then
 	tc_loss=1%
@@ -323,7 +324,7 @@ do_transfer()
 	local extra_args="$7"
 
 	local port
-	port=$((10000+TEST_COUNT))
+	port=$((10000+PORT++))
 	TEST_COUNT=$((TEST_COUNT+1))
 
 	if [ "$rcvbuf" -gt 0 ]; then
@@ -718,7 +719,7 @@ EOF
 
 	mptcp_lib_pr_info "test $msg"
 
-	TEST_COUNT=10000
+	PORT=10000
 	local extra_args="-o TRANSPARENT"
 	do_transfer ${listener_ns} ${connector_ns} MPTCP MPTCP \
 		    ${connect_addr} ${local_addr} "${extra_args}"
-- 
2.40.1

