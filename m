Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6CC2F23
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 17:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1644426948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BztjXPpTzaaFluHSreLlewojZzpXcIprVaNBTThvabo=;
	b=eswQHktVyXZj0ZDfm3+D6Ca+kD05vuxtfcGGqvWbh3XPcjNdfR7U/FtAatnWBDpp9bNAsn
	Vxx1Tsa2yz+ka6qWR0eZqMyLBP+9g6PJ/MNXvbOFpl5CyiXd2dYnmRt1feS7pAlJaw7/4K
	t2QvbR1AYnRlct7YDGdz0Z2YChqGtHI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-UTwvKKWhO8KkCs2gebsShA-1; Wed, 09 Feb 2022 12:15:44 -0500
X-MC-Unique: UTwvKKWhO8KkCs2gebsShA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AF378144E1
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 17:15:43 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.181])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D0C9A2C1BF
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 17:15:42 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] selftests: mptcp: be more conservative with cookie MPJ limits
Date: Wed,  9 Feb 2022 18:15:29 +0100
Message-Id: <d3aaf62f955697daa23859487bfaa5f1a777b29d.1644426852.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

Since commit 2843ff6f36db ("mptcp: remote addresses fullmesh"), an
MPTCP client can attempt creating multiple MPJ subflow simultaneusly.

In such scenario the server, when syncookies are enabled, could end-up
accepting incoming MPJ syn even above the configured subflow limit, as
the such limit can be enforced in a reliable way only after the subflow
creation. In case of syncookie, only after the 3rd ack reception.

As a consequence the related self-tests case sporadically fails, as it
verify that the server always accept the expected number of MPJ syn.

Address the issues relaxing the MPJ syn number constrain. Note that the
check on the accepted number of MPJ 3rd ack still remains intact.

Fixes: 2843ff6f36db ("mptcp: remote addresses fullmesh")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
this fixes for me some rare failure I observe in debug build:

072 subflows limited by server w cookies syn[ ok ] - synack[fail] got 2 JOIN[s] synack expected 1
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 66ac990415e6..9bcb3653f78b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -822,6 +822,7 @@ chk_join_nr()
 	local ack_nr=$4
 	local count
 	local dump_stats
+	local with_cookie
 
 	printf "%03u %-36s %s" "$TEST_COUNT" "$msg" "syn"
 	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinSynRx | awk '{print $2}'`
@@ -835,12 +836,20 @@ chk_join_nr()
 	fi
 
 	echo -n " - synack"
+	with_cookie=`ip netns exec $ns2 sysctl -n net.ipv4.tcp_syncookies`
 	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinSynAckRx | awk '{print $2}'`
 	[ -z "$count" ] && count=0
 	if [ "$count" != "$syn_ack_nr" ]; then
-		echo "[fail] got $count JOIN[s] synack expected $syn_ack_nr"
-		ret=1
-		dump_stats=1
+		# simult connections exeeding the limit with cookie enabled could go up to
+		# synack validation as the conn limit can be enforced reliably only after
+		# the subflow creation
+		if [ "$with_cookie" = 2 -a "$count" -gt "$syn_ack_nr" -a "$count" -le "$syn_nr" ]; then
+			echo -n "[ ok ]"
+		else
+			echo "[fail] got $count JOIN[s] synack expected $syn_ack_nr"
+			ret=1
+			dump_stats=1
+		fi
 	else
 		echo -n "[ ok ]"
 	fi
-- 
2.34.1

