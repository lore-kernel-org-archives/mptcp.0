Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB834359
	for <mptcp@lists.linux.dev>; Fri, 18 Feb 2022 03:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645153406; x=1676689406;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WbGXLDoYtJJu27wCa1qwhlZvWNzqWHDcYOCMw2OmxPg=;
  b=kpHgwyorPHy1LiRL1vqP9mMOst1AliAt86G3sfRXuG7HFTMJgyTsP3Lr
   xkLkoG90bsdWU/J4dI3aIwTFfILy8q5JKMwkyYYKnKHWTRvFTzbC69wWh
   lDVgtGm7GRqkkNHamo9M5hpMn5c4hHuzFY49Ga6DPbfr6b+Uf6mjSpJkR
   Eyx5ImpcHnGu7Q+ebT+m5gu9o1uYbnpGh1PaDLKGsy4QsfuLJHpfOV58L
   8pj+tX3y+iWwznKvqT1HjpQ3fuR7ZPPXPpZEN2s4qE3V39jPgmX1uwCCh
   5BtYv5bBpenxpqwjGPUX9b4Ii2KEGJHz0eEQVoECA6KMWf+KDM8ByO57m
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="231021638"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="231021638"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 19:03:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="635431898"
Received: from mjmartin-desk2.amr.corp.intel.com (HELO mjmartin-desk2.intel.com) ([10.209.101.109])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 19:03:17 -0800
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: netdev@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>,
	davem@davemloft.net,
	kuba@kernel.org,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH net-next 2/7] selftests: mptcp: simplify pm_nl_change_endpoint
Date: Thu, 17 Feb 2022 19:03:06 -0800
Message-Id: <20220218030311.367536-3-mathew.j.martineau@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218030311.367536-1-mathew.j.martineau@linux.intel.com>
References: <20220218030311.367536-1-mathew.j.martineau@linux.intel.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliang.tang@suse.com>

This patch simplified pm_nl_change_endpoint(), using id-based address
lookups only. And dropped the fragile way of parsing 'addr' and 'id'
from the output of pm_nl_show_endpoints().

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 37 ++++---------------
 1 file changed, 8 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 18bb0d0cf4bd..bbcacaaf81ce 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -240,16 +240,6 @@ is_v6()
 	[ -z "${1##*:*}" ]
 }
 
-is_addr()
-{
-	[ -z "${1##*[.:]*}" ]
-}
-
-is_number()
-{
-	[[ $1 == ?(-)+([0-9]) ]]
-}
-
 # $1: ns, $2: port
 wait_local_port_listen()
 {
@@ -379,16 +369,13 @@ pm_nl_show_endpoints()
 pm_nl_change_endpoint()
 {
 	local ns=$1
-	local flags=$2
-	local id=$3
-	local addr=$4
-	local port=""
+	local id=$2
+	local flags=$3
 
 	if [ $ip_mptcp -eq 1 ]; then
 		ip -n $ns mptcp endpoint change id $id ${flags//","/" "}
 	else
-		if [ $5 -ne 0 ]; then port="port $5"; fi
-		ip netns exec $ns ./pm_nl_ctl set $addr flags $flags $port
+		ip netns exec $ns ./pm_nl_ctl set id $id flags $flags
 	fi
 }
 
@@ -591,24 +578,16 @@ do_transfer()
 		for netns in "$ns1" "$ns2"; do
 			pm_nl_show_endpoints $netns | while read line; do
 				local arr=($line)
-				local addr
-				local port=0
+				local nr=0
 				local id
 
 				for i in ${arr[@]}; do
-					if is_addr $i; then
-						addr=$i
-					elif is_number $i; then
-						# The minimum expected port number is 10000
-						if [ $i -gt 10000 ]; then
-							port=$i
-						# The maximum id number is 255
-						elif [ $i -lt 255 ]; then
-							id=$i
-						fi
+					if [ $i = "id" ]; then
+						id=${arr[$nr+1]}
 					fi
+					let nr+=1
 				done
-				pm_nl_change_endpoint $netns $sflags $id $addr $port
+				pm_nl_change_endpoint $netns $id $sflags
 			done
 		done
 	fi
-- 
2.35.1

