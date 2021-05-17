Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4759170
	for <mptcp@lists.linux.dev>; Mon, 17 May 2021 17:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1621272143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xNle17lkHpENg7Id/SrnK/JOG3r/lEzMlbNbpxJghAw=;
	b=R0cScMnk7InYvcU68E9LUKhxssZWxf9M9R0OFqZRUapRWOF4Ivpzz6OxXM7l7MdC8hhsOq
	lR7lbqDdAG96NRl8ZSqPX8M9YmfBb2xQ77JRavqUiMZTtTwiJ1QEcRfb0VtiuQuz3QBJh9
	O65xbaBAEe6ZczgDf2xarGVQ+5vhZWI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-o99QL99IOsy76iNR_rYi1w-1; Mon, 17 May 2021 13:22:21 -0400
X-MC-Unique: o99QL99IOsy76iNR_rYi1w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A44D107ACCA
	for <mptcp@lists.linux.dev>; Mon, 17 May 2021 17:22:21 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-112-188.ams2.redhat.com [10.36.112.188])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 76C9360C04
	for <mptcp@lists.linux.dev>; Mon, 17 May 2021 17:22:20 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-net 3/2] mptcp: update selftest for fallback due to OoO
Date: Mon, 17 May 2021 19:22:12 +0200
Message-Id: <5b2f9bfc043eaf79986301b9391abb2f3d484226.1621271812.git.pabeni@redhat.com>
In-Reply-To: <99f56765d4939e6f21c3950ed2ee3b54369e6d5b.1621270518.git.pabeni@redhat.com>
References: <99f56765d4939e6f21c3950ed2ee3b54369e6d5b.1621270518.git.pabeni@redhat.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

The previous commit noted that we can have fallback
scenario due to OoO (or packet drop). Update the self-tests
accordingly

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 605b8b929f72..69351c3eb68c 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -512,6 +512,7 @@ do_transfer()
 	local stat_ackrx_now_l=$(get_mib_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
 	local stat_cookietx_now=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesSent")
 	local stat_cookierx_now=$(get_mib_counter "${listener_ns}" "TcpExtSyncookiesRecv")
+	local stat_ooo_now=$(get_mib_counter "${listener_ns}" "TcpExtTCPOFOQueue")
 
 	expect_synrx=$((stat_synrx_last_l))
 	expect_ackrx=$((stat_ackrx_last_l))
@@ -529,10 +530,14 @@ do_transfer()
 			"${stat_synrx_now_l}" "${expect_synrx}" 1>&2
 		retc=1
 	fi
-	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} ]; then
-		printf "[ FAIL ] lower MPC ACK rx (%d) than expected (%d)\n" \
-			"${stat_ackrx_now_l}" "${expect_ackrx}" 1>&2
-		rets=1
+	if [ ${stat_ackrx_now_l} -lt ${expect_ackrx} -a ${stat_ooo_now} -eq 0 ]; then
+		if [ ${stat_ooo_now} -eq 0 ]; then
+			printf "[ FAIL ] lower MPC ACK rx (%d) than expected (%d)\n" \
+				"${stat_ackrx_now_l}" "${expect_ackrx}" 1>&2
+			rets=1
+		else
+			printf "[ Note ] fallback due to TCP OoO"
+		fi
 	fi
 
 	if [ $retc -eq 0 ] && [ $rets -eq 0 ]; then
-- 
2.26.3

