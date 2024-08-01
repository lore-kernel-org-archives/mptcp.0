Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF35D18B482
	for <mptcp@lists.linux.dev>; Thu,  1 Aug 2024 09:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504115; cv=none; b=PGgrJ99e+bdxam905oSfYyQQuUdteyvX4xmtKU2pCUXye9VO1IC6xQiMHvN5r7DhO2Eo2Fygw4seA5k98rOnE3fKt8xSnYrnqPRXDDwi5iVZxh9EIxdDnC52AxUVBxS1iSKrmBG/Fy1NYmAjH08Eb5Px9CyW4CyZbxP/+evP2N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504115; c=relaxed/simple;
	bh=OOVR7U8Kupf1czJSoIYGIhCynIGRjvm1gIqEQ0iKxMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQAyV7Ra9GgEmpatIl0XjWI5+XwW7lfBwMA+AZ+DRdcmtE3s0urgfybXjMmVohXy45YCFctzDhfvD9JudG15bsTZ22pH1mym9l/dUtq/NfvjrNtRyolbL0O7pblvDbJmT4Lqx5AoNys86PaI2oxye+BeW8l9ajb/wp80SXStBp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvpDSbAg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvpDSbAg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC368C4AF09;
	Thu,  1 Aug 2024 09:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722504115;
	bh=OOVR7U8Kupf1czJSoIYGIhCynIGRjvm1gIqEQ0iKxMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gvpDSbAgnSYlfDdI2NtlJS6B1PE5VBsULaJO1DBx4VbW0PG01tfemyl/8s3pjEGqM
	 JwN2ATFs/YAOHDrXnP2UUbQGYx6QQL3V5DSCbkeK2MyMwaA9u3/BPexWh8FYRxySJK
	 ziFEfkdLyxOOqIWFcRDf+uI+ROib2ZEj8mi577CUYuCpz31NwYS1YblDIvLx1Majot
	 7JHIlGKPd470dPv0wldXpYxx5RP+lrhms5TJieO0BAJCFdEOwViD5qYoiRUirAhko5
	 CmSiaatJ8ISc/a333IM/RV55czpRnqIDHCmYTFVL/BQb0XrNjM63hjs3IyusWq89dZ
	 2lDJvI0zNjoZw==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next 4/4] selftests: mptcp: join: add io thread tests
Date: Thu,  1 Aug 2024 17:21:42 +0800
Message-ID: <30fbc6cffaf0617640cd1dbb0afd8b056dcab684.1722502941.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722502941.git.tanggeliang@kylinos.cn>
References: <cover.1722502941.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This io thread mode is used in BPF selftests bpf_tcp_ca and MPTCP, and
it is not very stable for MPTCP sched tests. This patch adds them into
mptcp_join tests (-T) to make sure this scene is also covered.

These tests only run in ns1 for 100 times. The failed output looks like:

 001 io thread tests
 recv 2884500 expected 10485760
 send 8005500 expected 10485760
 Failed in thread_ret -11
 Test no. 12 failed.
       syn                        [FAIL] got 12 JOIN[s] syn expected 100
       synack                     [ OK ]
       ack                        [FAIL] got 12 JOIN[s] ack expected 100

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 01c1e0871aca..ecba07aac776 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -3663,6 +3663,24 @@ endpoint_tests()
 	fi
 }
 
+io_thread_tests()
+{
+	if reset "io thread tests"; then
+		local nr=0 max=100
+		mptcp_lib_pm_nl_set_limits $ns1 8 8
+		mptcp_lib_pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
+		while [ $nr -lt $max ]; do
+			nr=$((nr + 1))
+			ip netns exec $ns1 ./mptcp_connect -l 10.0.1.1 -m "thread" -O 3000
+			if [ $? -ne 0 ]; then
+				echo "Test no. $nr failed."
+				break;
+			fi
+		done
+		chk_join_nr $max 0 $max
+	fi
+}
+
 # [$1: error message]
 usage()
 {
@@ -3711,6 +3729,7 @@ all_tests_sorted=(
 	F@fail_tests
 	u@userspace_tests
 	I@endpoint_tests
+	T@io_thread_tests
 )
 
 all_tests_args=""
-- 
2.43.0

