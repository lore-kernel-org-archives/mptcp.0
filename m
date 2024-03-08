Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D7928DD8
	for <mptcp@lists.linux.dev>; Fri,  8 Mar 2024 05:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709877470; cv=none; b=VZKT5E8rj10APysBUQ2bXsF1+NT7P/9L/g6cziHy80tj+QvsRISFTNBdzfn2iASuvv3v1/LtWAT4kcQWqWTkNPCHPTpqi/qsb3nVnPffh30OdlzRaMSkIEJRjpr4eEcIfypogydsVrJUK513e2ZLTQUvQRO8x88W2O1zgPtIZrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709877470; c=relaxed/simple;
	bh=iVZpIiTrtKmAMo20+IlE3Qc/HKa2V0dZaajdvjPQZHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RuZYF6VqnHnDQCXs9+xMNBSH3ZV7l+a4Xw2aRAkmDdvoy9fbZgqy6GT8HXmt6OcsZMuEgzbravRpoMZWP3gq+UniKzisWWWH4nuf3Yyl/LIP2ErfsYf5UolXiQXZPq6jCc8FNbESmDBrFjqZs9+W3TrCarKlXowYRVrxGfmwtKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pw17YkW5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pw17YkW5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F69C433F1;
	Fri,  8 Mar 2024 05:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709877470;
	bh=iVZpIiTrtKmAMo20+IlE3Qc/HKa2V0dZaajdvjPQZHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pw17YkW5u3ayIoW3EMpmwN6XCIZkB931vMC3e6nPrtomIQC7J1IT1oQuPxa1GZqY6
	 6Vy8U9v2ISeOsmhlQRPDN3GNX8uMqCzKPW+6qPFSZFSbRkofreJCdXl/FTob2MN3Sn
	 dYjsNuWVHHcfWeIkEE6oNwPFwyhXaWf3bhXUaQ8GI1hJLCPcZTtkTgKfDE947CT/ga
	 ah5ph/ckIXU52lpxi8Ga0ZXAzyTcQry1nlIRRk48hux0hFufHXshgz9VwsdOanScRX
	 MlPrFOZqCw+fVCLTF4t4i7AqUN6O3xPMVlVLKEyUGIgk00DSYFkowTnIIFc3UDzBAY
	 THYGDUOol8IMQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v2 4/7] selftests: mptcp: add mptcp_lib_verify_listener_events
Date: Fri,  8 Mar 2024 13:57:37 +0800
Message-Id: <4676dcb821323288c4cc6317f053ac5bef403f20.1709876991.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1709876991.git.tanggeliang@kylinos.cn>
References: <cover.1709876991.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

To avoid duplicated code in different MPTCP selftests, we can add and use
helpers defined in mptcp_lib.sh.

The helper verify_listener_events() is defined both in mptcp_join.sh and
userspace_pm.sh, export it into mptcp_lib.sh and rename it with mptcp_lib_
prefix. Use this new helper in both scripts.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 21 +--------------
 .../testing/selftests/net/mptcp/mptcp_lib.sh  | 26 +++++++++++++++++++
 .../selftests/net/mptcp/userspace_pm.sh       | 21 +++------------
 3 files changed, 30 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 7392fc9f5ea1..84eb01a16fb8 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2794,15 +2794,9 @@ AF_INET6=10
 
 verify_listener_events()
 {
-	local evt=$1
 	local e_type=$2
-	local e_family=$3
 	local e_saddr=$4
 	local e_sport=$5
-	local type
-	local family
-	local saddr
-	local sport
 	local name
 
 	if [ $e_type = $LISTENER_CREATED ]; then
@@ -2820,23 +2814,10 @@ verify_listener_events()
 		return
 	fi
 
-	type=$(mptcp_lib_evts_get_info type "$evt" "$e_type")
-	family=$(mptcp_lib_evts_get_info family "$evt" "$e_type")
-	sport=$(mptcp_lib_evts_get_info sport "$evt" "$e_type")
-	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(mptcp_lib_evts_get_info saddr6 "$evt" "$e_type")
-	else
-		saddr=$(mptcp_lib_evts_get_info saddr4 "$evt" "$e_type")
-	fi
-
-	if [ $type ] && [ $type = $e_type ] &&
-	   [ $family ] && [ $family = $e_family ] &&
-	   [ $saddr ] && [ $saddr = $e_saddr ] &&
-	   [ $sport ] && [ $sport = $e_sport ]; then
+	if mptcp_lib_verify_listener_events "${@}"; then
 		print_ok
 		return 0
 	fi
-	print_fail "$e_type:$type $e_family:$family $e_saddr:$saddr $e_sport:$sport"
 	fail_test
 }
 
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 44491f18ed17..a977a722fb3d 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -468,3 +468,29 @@ mptcp_lib_check_expected() {
 
 	return "${rc}"
 }
+
+# shellcheck disable=SC2034 # Some variables are used below but indirectly
+mptcp_lib_verify_listener_events() {
+	local evt=${1}
+	local e_type=${2}
+	local e_family=${3}
+	local e_saddr=${4}
+	local e_sport=${5}
+	local type
+	local family
+	local saddr
+	local sport
+	local rc=0
+
+	type=$(mptcp_lib_evts_get_info type "${evt}" "${e_type}")
+	family=$(mptcp_lib_evts_get_info family "${evt}" "${e_type}")
+	if [ "${family}" ] && [ "${family}" = "${AF_INET6}" ]; then
+		saddr=$(mptcp_lib_evts_get_info saddr6 "${evt}" "${e_type}")
+	else
+		saddr=$(mptcp_lib_evts_get_info saddr4 "${evt}" "${e_type}")
+	fi
+	sport=$(mptcp_lib_evts_get_info sport "${evt}" "${e_type}")
+
+	mptcp_lib_check_expected "type" "family" "saddr" "sport" || rc="${?}"
+	return "${rc}"
+}
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index e9aea44edee5..1e0b39e5525c 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -835,26 +835,11 @@ test_prio()
 
 verify_listener_events()
 {
-	local evt=$1
-	local e_type=$2
-	local e_family=$3
-	local e_saddr=$4
-	local e_sport=$5
-	local type
-	local family
-	local saddr
-	local sport
-
-	type=$(mptcp_lib_evts_get_info type $evt $e_type)
-	family=$(mptcp_lib_evts_get_info family $evt $e_type)
-	sport=$(mptcp_lib_evts_get_info sport $evt $e_type)
-	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(mptcp_lib_evts_get_info saddr6 $evt $e_type)
+	if mptcp_lib_verify_listener_events "${@}"; then
+		test_pass
 	else
-		saddr=$(mptcp_lib_evts_get_info saddr4 $evt $e_type)
+		test_fail
 	fi
-
-	check_expected "type" "family" "saddr" "sport"
 }
 
 test_listener()
-- 
2.40.1

