Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [193.142.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249057C
	for <mptcp@lists.linux.dev>; Tue, 29 Mar 2022 11:35:47 +0000 (UTC)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@breakpoint.cc>)
	id 1nZA8X-0004uv-Ae; Tue, 29 Mar 2022 13:35:45 +0200
From: Florian Westphal <fw@strlen.de>
To: <mptcp@lists.linux.dev>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next v3 4/4] selftests/mptcp: add diag listen tests
Date: Tue, 29 Mar 2022 13:35:23 +0200
Message-Id: <20220329113523.19793-5-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329113523.19793-1-fw@strlen.de>
References: <20220329113523.19793-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check dumping of mptcp listener sockets:
1. filter by dport should not return any results
2. filter by sport should return listen sk
3. filter by saddr+sport should return listen sk
4. no filter should return listen sk

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 new in v3.

 tools/testing/selftests/net/mptcp/diag.sh | 38 +++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index ff821025d309..9dd43d7d957b 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -71,6 +71,43 @@ chk_msk_remote_key_nr()
 		__chk_nr "grep -c remote_key" $*
 }
 
+__chk_listen()
+{
+	local filter="$1"
+	local expected=$2
+
+	shift 2
+	msg=$*
+
+	nr=$(ss -N $ns -Ml "$filter" | grep -c LISTEN)
+	printf "%-50s" "$msg"
+
+	if [ $nr != $expected ]; then
+		echo "[ fail ] expected $expected found $nr"
+		ret=$test_cnt
+	else
+		echo "[  ok  ]"
+	fi
+}
+
+chk_msk_listen()
+{
+	lport=$1
+	local msg="check for listen socket"
+
+	# destination port search should always return empty list
+	__chk_listen "dport $lport" 0 "listen match for dport $lport"
+
+	# should return 'our' mptcp listen socket
+	__chk_listen "sport $lport" 1 "listen match for sport $lport"
+
+	__chk_listen "src inet:0.0.0.0:$lport" 1 "listen match for saddr and sport"
+
+	__chk_listen "" 1 "all listen sockets"
+
+	nr=$(ss -Ml $filter | wc -l)
+}
+
 # $1: ns, $2: port
 wait_local_port_listen()
 {
@@ -113,6 +150,7 @@ echo "a" | \
 				0.0.0.0 >/dev/null &
 wait_local_port_listen $ns 10000
 chk_msk_nr 0 "no msk on netns creation"
+chk_msk_listen 10000
 
 echo "b" | \
 	timeout ${timeout_test} \
-- 
2.35.1

