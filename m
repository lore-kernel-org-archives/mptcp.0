Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CAC1272B6
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 18:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539748; cv=none; b=Co5v0aPbA5vMTj8CZ9OVyGx5e9gNEYfRbLCB3CLWO0eOAJiuOexp2WdcLoSO/mOn44Yb8ZTN4HRsrcMU9kZ3uBH85VqAmQAz2hZ9LTBC9J8pIBRbKlHLC9N6ryHbUgjGxwdH42xTP127I0hgGbSxGHEZTjYRae5a5/qJ5qwvG0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539748; c=relaxed/simple;
	bh=2L0EX2f1S25v+hyiEnK5KAFLw3sIMoPBKDLAEE21kiI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GVqGJdy4tiXTMyAqirC/lBXZbj1EOsjXH3ns6wckaZggOPIZWh7QQbs1pO6eMEH+Uu6fLQz6y1IlgAfBx0uY5DLWlP4CTlOyXw6uecAydau+MLs6zh/y1lWTkoFgsn/LOEfubeYYZXvXKu6da7RWgNXqmRid4GyhG16VjpuNlcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZVuI6Vw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZVuI6Vw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708539744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdeetQQu06dyVnFVPf3xsBpvgWg8EL9hChFpq0iWd+o=;
	b=fZVuI6VwpKFZ07AS8yK2hImMUqOz5jAvjVXo63Ha3LBSpTPEDoXHaaVC7SUcBjlyiJXA5k
	nI4MVejgJmsX0QGf0QM4p5uQ5Jiqwj7oiswQdkUpH/TeiInYlgFz8DjbTqMltwszFOXTf+
	xqPnORhKXguuWEoux5GRd7c123H1Pqk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-LQZBplU4P1WYSkNh667uhg-1; Wed,
 21 Feb 2024 13:22:22 -0500
X-MC-Unique: LQZBplU4P1WYSkNh667uhg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51225386A0AF
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 18:22:22 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.94])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D4FE6492BD7
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 18:22:21 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v3 mptcp-net 2/2] selftests: mptcp: explicitly trigger the listener diag code-path
Date: Wed, 21 Feb 2024 19:22:16 +0100
Message-ID: <00b53a9b00cf4f35361806208f1214c030fad974.1708539640.git.pabeni@redhat.com>
In-Reply-To: <cover.1708539640.git.pabeni@redhat.com>
References: <cover.1708539640.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The mptcp diag interface already experienced a few locking bugs
that lockdep and appropriate coverage have detected in advance.

Let's add a test-case triggering the relevant code path, to prevent
similar issues in the future.

Be careful to cope with very slow environments.

Note that we don't need an explicit timeout on the mptcp_connect
subprocess to cope with eventual bug/hang-up as the final cleanup
terminating the child processes will take care of that.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
 - longer wait timeout
 - run all subprocesses in  background
 - wait for tcp ports after starting all listeners
 all the above should produce a lot of resilience wrt slow env.
---
 tools/testing/selftests/net/mptcp/diag.sh | 30 ++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 60a7009ce1b5..3896bb84ebf1 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -20,7 +20,7 @@ flush_pids()
 
 	ip netns pids "${ns}" | xargs --no-run-if-empty kill -SIGUSR1 &>/dev/null
 
-	for _ in $(seq 10); do
+	for _ in $(seq $((timeout_poll * 10))); do
 		[ -z "$(ip netns pids "${ns}")" ] && break
 		sleep 0.1
 	done
@@ -81,6 +81,15 @@ chk_msk_nr()
 	__chk_msk_nr "grep -c token:" "$@"
 }
 
+chk_listener_nr()
+{
+	local expected=$1
+	local msg="$2"
+
+	__chk_nr "ss -inmlHMON $ns | wc -l" "$expected" "$msg - mptcp" 0
+	__chk_nr "ss -inmlHtON $ns | wc -l" "$expected" "$msg - subflows"
+}
+
 wait_msk_nr()
 {
 	local condition="grep -c token:"
@@ -279,5 +288,24 @@ flush_pids
 chk_msk_inuse 0 "many->0"
 chk_msk_cestab 0 "many->0"
 
+chk_listener_nr 0 "no listener sockets"
+NR_SERVERS=100
+for I in $(seq 1 $NR_SERVERS); do
+	ip netns exec $ns ./mptcp_connect -p $((I + 20001)) \
+		-t ${timeout_poll} -l 0.0.0.0 2>&1 >/dev/null &
+done
+
+for I in $(seq 1 $NR_SERVERS); do
+	mptcp_lib_wait_local_port_listen $ns $((I + 20001))
+done
+
+chk_listener_nr $NR_SERVERS "many listener sockets"
+
+# gracefull termination
+for I in $(seq 1 $NR_SERVERS); do
+	echo a | ip netns exec $ns ./mptcp_connect -p $((I + 20001)) 127.0.0.1 2>&1 >/dev/null &
+done
+flush_pids
+
 mptcp_lib_result_print_all_tap
 exit $ret
-- 
2.43.0

