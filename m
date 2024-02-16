Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A981CD1A
	for <mptcp@lists.linux.dev>; Fri, 16 Feb 2024 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077060; cv=none; b=qUb/630RH8yXxhyDuJuLoBsixqt8DuTivbUWFCkzaqJsgeOGbiegQJQUTvCbkgpF7gB5jLfclS4Fjo1B0M8zwyvS9e7tNMksx64FO4u8tW8JndQu5IytPy1kqRKYe9kUESKqVeRPou5dcuvINuotSskKhWo0Zynou5oigwBeGVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077060; c=relaxed/simple;
	bh=dk1KkwX+Ty+WG64JuEontnoxsdAzIGSeUoFVGvovSfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WSEPe5mUN14Bji4WJC1P0tUmMqToJOvm7fXRD1x+UovBXMp/3jb7lva/VSi/q+qk/Z2t5T8gkunsnXuVHnVLX2xmR5qBOxdXqRXr9pUGiKBbVts63iyUUkJwaQv8SxTnKETCFmqUj0nU87KeAzMvVx9VFkuOzYTM8aa3/rloSV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bG1OuBrm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bG1OuBrm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA9AC433C7;
	Fri, 16 Feb 2024 09:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708077060;
	bh=dk1KkwX+Ty+WG64JuEontnoxsdAzIGSeUoFVGvovSfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bG1OuBrmEOiDOkbYOhLt8hlsZocGp2twj5kGRUdBSXJ0+EpkjW6cOk8SpPfT+SlSD
	 kXud6zockiElYG64yiQqrVzRWRA4pT2yt7XLcnbxiLq/U6kRUmPYfpcn4epM9Ectqa
	 VcLRYAbajcHZSHX+RKp2Hg3zrOIx2AU+4WYfItJenhWp+kCsSEVWnlKEqSBP40OO1D
	 V4a7SN0WvohIhEL5MKPZESJpzbh62KX+pLTGADZY/Mhoiho2+18+bRon5S13TwLD8R
	 Y9YaBTIkB5ok6F//M0LoroIqv8IkmSPgEoR1J5XvSSzOXKOW0qJsNPW4nzSL/eOW4e
	 Hbz0aNjwK+Fgg==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 6/7] selftests: mptcp: add ss mptcp support checks
Date: Fri, 16 Feb 2024 17:50:34 +0800
Message-Id: <2d8dc3ee982371cf9fd8a2c050dec0d0bfb34ff7.1708076886.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1708076886.git.tanggeliang@kylinos.cn>
References: <cover.1708076886.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Commands 'ss -M' are used in scripts mptcp_connect.sh, mptcp_join.sh,
and mptcp_sockopt.sh to display only MPTCP sockets. So it must be checked
if ss tool supports MPTCP in these script.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 5 +++++
 tools/testing/selftests/net/mptcp/mptcp_join.sh    | 5 +++++
 tools/testing/selftests/net/mptcp/mptcp_sockopt.sh | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 7898d62fce0b..eb811d257cab 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -154,6 +154,11 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
 
+if ! ss -h | grep -q MPTCP; then
+	echo "SKIP: ss tool does not support MPTCP"
+	exit $ksft_skip
+fi
+
 sin=$(mktemp)
 sout=$(mktemp)
 cin=$(mktemp)
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9b35a16a7c8b..34a8d5ab185c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -159,6 +159,11 @@ check_tools()
 		exit $ksft_skip
 	fi
 
+	if ! ss -h | grep -q MPTCP; then
+		echo "SKIP: ss tool does not support MPTCP"
+		exit $ksft_skip
+	fi
+
 	if ! iptables -V &> /dev/null; then
 		echo "SKIP: Could not run all tests without iptables tool"
 		exit $ksft_skip
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index 722b0872f00d..988042912c7a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -94,6 +94,11 @@ if [ $? -ne 0 ];then
 	exit $ksft_skip
 fi
 
+if ! ss -h | grep -q MPTCP; then
+	echo "SKIP: ss tool does not support MPTCP"
+	exit $ksft_skip
+fi
+
 if ! iptables -V &> /dev/null; then
 	echo "SKIP: Could not run all tests without iptables tool"
 	exit $ksft_skip
-- 
2.40.1

