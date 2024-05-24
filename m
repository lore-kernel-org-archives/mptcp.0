Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D212574F
	for <mptcp@lists.linux.dev>; Fri, 24 May 2024 03:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716520317; cv=none; b=Ncplkqx0F+wt9MUOhDykeGgk4anaK8osdOWH71KZXAO6uFC7v7NlExFDMDQkYvhz9Ee6FFvN9UwGFCwB2TlClH08CSRCFua8C9VUz9FE0WRC6WjkkKFISQDZ637L51+FuqlkkzZQB1guawqI3GZt+R2F4B02IEc2CHCsv6pbw+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716520317; c=relaxed/simple;
	bh=bR6pK/1fSnwooVIbPtC3vMYoplbNJ37RZGfgJ3ff+48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFlr+9fHQJxEENp9v1k915gPvKfydhYxRPNmVLMz+rSZGp/4gj/tunAwy20j0aEve+vLbuWkiLEIfJptbTiqhw8VgtIpKB1DpUDmSNOfBmJxhlg8uzN+7QYoBRhYC8BvWWvG8lR0W159q458ZEvPwVarOmScvO8NSpztcvvhKDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fl8oaC2W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fl8oaC2W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F2EC32786;
	Fri, 24 May 2024 03:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716520317;
	bh=bR6pK/1fSnwooVIbPtC3vMYoplbNJ37RZGfgJ3ff+48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fl8oaC2WCfeO8kuE6CfwrzF1OyRAQxy6Ph2Ygnjy4Mg3ZMnJDux837V5GSCw34fP0
	 kun65/R/RyxVmBdGUG9YGr43KH5niWNh1+4Eh7V8dAz0dr2LOu+PCObHF/7gMCl/TS
	 wpokE43g68glRsn0sptkGsz+Hc3DVdzQ0Sq4HmPHp2YSoeHJt7fJtIJCGUSFTvBDsj
	 8z/doXKQZqQI8RNHSmZX1BW8nA7pVy5dd5rQO1+CTyXQhp7iybTGsSwadv3q9CnUlM
	 gck4lGeClZqi9g/cWafoTS/vD45Zw4nn0Q7UplFhBEqVYKO6HMn6DXZc5JqYOW+IZH
	 lkFo6NYPCeWkQ==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 1/4] selftests: net: rename ns in setup/cleanup_ns
Date: Fri, 24 May 2024 11:11:46 +0800
Message-ID: <f4ed6d4b9e04f700b1a3b147106d16517245becb.1716519897.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716519897.git.tanggeliang@kylinos.cn>
References: <cover.1716519897.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The helpers setup_ns and cleanup_ns don't work when a namespace named
"ns" is passed to them.

For example, in net/mptcp/diag.sh, the name of the namespace is "ns".
If "setup_ns ns" is used in it, diag.sh fails with errors:

 Invalid netns name "./mptcp_connect"
 Cannot open network namespace "10000": No such file or directory
 Cannot open network namespace "10000": No such file or directory

That is because "ns" is also a local variable in both setup_ns and
cleanup_ns. To solve this, this patch renames the local variable "ns"
as "_ns".

Also a ns_name valid check has been added to setup_ns. If "_ns" is
passed in as a ns_name, setup_ns helper exits.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/net/lib.sh | 33 ++++++++++++++++++------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index edc030e81a46..1401f5bf961a 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -128,7 +128,7 @@ slowwait_for_counter()
 
 cleanup_ns()
 {
-	local ns=""
+	local _ns=""
 	local errexit=0
 	local ret=0
 
@@ -138,10 +138,11 @@ cleanup_ns()
 		set +e
 	fi
 
-	for ns in "$@"; do
-		ip netns delete "${ns}" &> /dev/null
-		if ! busywait $BUSYWAIT_TIMEOUT ip netns list \| grep -vq "^$ns$" &> /dev/null; then
-			echo "Warn: Failed to remove namespace $ns"
+	for _ns in "$@"; do
+		ip netns delete "${_ns}" &> /dev/null
+		if ! busywait $BUSYWAIT_TIMEOUT ip netns list \
+		   \| grep -vq "^$_ns$" &> /dev/null; then
+			echo "Warn: Failed to remove namespace $_ns"
 			ret=1
 		fi
 	done
@@ -159,29 +160,35 @@ cleanup_all_ns()
 # setup_ns local remote
 setup_ns()
 {
-	local ns=""
+	local _ns=""
 	local ns_name=""
 	local ns_list=""
 	local ns_exist=
 	for ns_name in "$@"; do
+		if [ "${ns_name}" == "_ns" ]; then
+			echo "ns_name shouldn't be _ns"
+			cleanup_ns "$ns_list"
+			set -e
+			return $ksft_fail
+		fi
 		# Some test may setup/remove same netns multi times
 		if unset ${ns_name} 2> /dev/null; then
-			ns="${ns_name,,}-$(mktemp -u XXXXXX)"
-			eval readonly ${ns_name}="$ns"
+			_ns="${ns_name,,}-$(mktemp -u XXXXXX)"
+			eval readonly ${ns_name}="$_ns"
 			ns_exist=false
 		else
-			eval ns='$'${ns_name}
-			cleanup_ns "$ns"
+			eval _ns='$'${ns_name}
+			cleanup_ns "$_ns"
 			ns_exist=true
 		fi
 
-		if ! ip netns add "$ns"; then
+		if ! ip netns add "$_ns"; then
 			echo "Failed to create namespace $ns_name"
 			cleanup_ns "$ns_list"
 			return $ksft_skip
 		fi
-		ip -n "$ns" link set lo up
-		! $ns_exist && ns_list="$ns_list $ns"
+		ip -n "$_ns" link set lo up
+		! $ns_exist && ns_list="$ns_list $_ns"
 	done
 	NS_LIST="$NS_LIST $ns_list"
 }
-- 
2.43.0

