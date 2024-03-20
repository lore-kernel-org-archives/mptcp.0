Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949C822079
	for <mptcp@lists.linux.dev>; Wed, 20 Mar 2024 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710923989; cv=none; b=QjpZzTVhG8gK+OldkKPizE3SC0jCW18Prf9nHIvRDTeVLFoL9GK4FbAg2ns5PJFcCeZCg+ylc8GBvARyC5cpoDTfDixwCcufnEOfoEcRW5YutPX6NPdB5pj06blgd4f309ZYAYTJK10EzePD6PIejF2qa+Gpj6aeG3CEmcDZXDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710923989; c=relaxed/simple;
	bh=yjQMWWuxylEwdj2MyhyPFtM/SRIxcef7MEOgYUcjNcM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HWu2Jv0UPggLhXd6cc7+wMrHIg1ki1CNKKVRsqUcOr85SGwI0wF5/LPs+mB1I0NehQA33xS1fV2+lB9JxDWf+lAF7gP/yIlgVMh/U1fu2OsPn6mLxp7Z9vAWWcPUkJhKquoDNT4Mbz2uaFpKGed7matGs/bVdm2hj5TYJ53prX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=epr0BHrS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="epr0BHrS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710923985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iNjiufJ8vEqXWFdygdudWflyxL4oIBUcvGVaLXYeX5A=;
	b=epr0BHrSdFsxYucE00xUu6cpodHVqEJYkOfju5NzhHiJxFIRleasI2mm0x/DAdyxXx9ILM
	/pDhUP7uKX98tWomrHXAhQO6IekVUkmLJLMGChu0CHUphFVp+/cRT7J03g2Yd6K5WpfzLk
	0bCW6HEaI8FfbVw1slMiLk2A27bsgy8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-TZpum8KJNi2PmAOWidXaKw-1; Wed,
 20 Mar 2024 04:39:41 -0400
X-MC-Unique: TZpum8KJNi2PmAOWidXaKw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EECA71C006A9;
	Wed, 20 Mar 2024 08:39:40 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.236])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1DDD92166B33;
	Wed, 20 Mar 2024 08:39:39 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>,
	mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v4] mptcp: don't account accept() of non-MPC client as fallback to TCP
Date: Wed, 20 Mar 2024 09:39:06 +0100
Message-ID: <054bcffde84b87f588f788b30dce2b702a532f64.1710923679.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Current MPTCP servers increment MPTcpExtMPCapableFallbackACK when they
accept non-MPC connections. As reported by Christoph, this is "surprising"
because the counter might become greater than MPTcpExtMPCapableSYNRX.

MPTcpExtMPCapableFallbackACK counter's name suggests it should only be
incremented when a connection was seen using MPTCP options, then a
fallback to TCP has been done. Let's do that by incrementing it when
the subflow context of an inbound MPC connection attempt is dropped.
Also, update mptcp_connect.sh kselftest, to ensure that the
above MIB does not increment in case a pure TCP client connects to a
MPTCP server.

Fixes: fc518953bc9c ("mptcp: add and use MIB counter infrastructure")
Reported-by: Christoph Paasch <cpaasch@apple.com>
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/449
Signed-off-by: Davide Caratti <dcaratti@redhat.com>

---
v4:
 - improve kselftest (thanks Mat + Matthieu)
v3:
 - fix typo in the if() conditional (thanks Matthieu)
 - rephrase commit message to target "-net" tree (thanks Matthieu)
 - add kselftest (thanks Matthieu)
v2:
 - fix reporter's name
---
 net/mptcp/protocol.c                               | 2 --
 net/mptcp/subflow.c                                | 2 ++
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 9 +++++++++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index cdf9ec67795e..556b3b95c537 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3937,8 +3937,6 @@ static int mptcp_stream_accept(struct socket *sock, struct socket *newsock,
 				mptcp_set_state(newsk, TCP_CLOSE);
 		}
 	} else {
-		MPTCP_INC_STATS(sock_net(ssk),
-				MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
 tcpfallback:
 		newsk->sk_kern_sock = kern;
 		lock_sock(newsk);
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1626dd20c68f..6042a47da61b 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -905,6 +905,8 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	return child;
 
 fallback:
+	if (fallback)
+		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVEFALLBACK);
 	mptcp_subflow_drop_ctx(child);
 	return child;
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 4c4248554826..4131f3263a48 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -383,12 +383,14 @@ do_transfer()
 	local stat_cookierx_last
 	local stat_csum_err_s
 	local stat_csum_err_c
+	local stat_tcpfb_last_l
 	stat_synrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
 	stat_ackrx_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
 	stat_cookietx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
 	stat_cookierx_last=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
 	stat_csum_err_s=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtDataCsumErr")
 	stat_csum_err_c=$(mptcp_lib_get_counter "${connector_ns}" "MPTcpExtDataCsumErr")
+	stat_tcpfb_last_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableFallbackACK")
 
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
@@ -457,11 +459,13 @@ do_transfer()
 	local stat_cookietx_now
 	local stat_cookierx_now
 	local stat_ooo_now
+	local stat_tcpfb_now_l
 	stat_synrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableSYNRX")
 	stat_ackrx_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableACKRX")
 	stat_cookietx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesSent")
 	stat_cookierx_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtSyncookiesRecv")
 	stat_ooo_now=$(mptcp_lib_get_counter "${listener_ns}" "TcpExtTCPOFOQueue")
+	stat_tcpfb_now_l=$(mptcp_lib_get_counter "${listener_ns}" "MPTcpExtMPCapableFallbackACK")
 
 	expect_synrx=$((stat_synrx_last_l))
 	expect_ackrx=$((stat_ackrx_last_l))
@@ -508,6 +512,11 @@ do_transfer()
 		fi
 	fi
 
+	if [ ${stat_ooo_now} -eq 0 ] && [ ${stat_tcpfb_last_l} -ne ${stat_tcpfb_now_l} ]; then
+		mptcp_lib_pr_fail "unexpected fallback to TCP"
+		rets=1
+	fi
+
 	if [ $cookies -eq 2 ];then
 		if [ $stat_cookietx_last -ge $stat_cookietx_now ] ;then
 			extra+=" WARN: CookieSent: did not advance"
-- 
2.44.0

