Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB28E7F7FD
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529548; cv=none; b=EJvDT8Dr/h4JXMzYifZ93BZEEFooOJ6qi+aWyrYcJRhhsdXQ5lZqQ/cqQxYj8qolO89GWjR+XVJptx1ibvZiB4tqYkxW3iuI0d1iCODhSAasdML0A6otIMyTrlDd1MCjmabaKaSHNRPKtNtGLt6SMI/KZLCDSo/iZz4KY902UVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529548; c=relaxed/simple;
	bh=0QRvSeroLkeJAwlqqkMvCIRyJS6sqRirMjYrqgXIr5U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lx1I5SZuEmleafO/MGtHS13FcB4V9jKg37Q9MRGweOxGcDlHix3gHRbJ4g707oOs5J6B2KgOsMRp5xxzuO3YHwOvVUE33W1qW3OON9JyX7fu8gcYaSBj7TQrW9mt8TlglyDWYp99ASJjE7Nh751y0XaXcFa0kCBxHiQlC6hsHzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y7Xaglv8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7Xaglv8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708529545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vcLaHCG6y05YdNmGoIJp4DQJyz6FcavN8ax3H019LeU=;
	b=Y7Xaglv8t1h+7OrEwYJiUkQQLq5yAKjMSPsEOl8oZom3+UF6zlVQrskpsUT5u6DLbhtFUB
	y46zlBA2MY93vR961x8Z67UTdE4U3hejC2px+re78W8Li72l6E9msN8YDH2prm7vrgqWx1
	wj8LEpUUrJuLfqhScxpsemWzKMv4jjk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-4FRDA7UHOJ6oYafCvjLo0A-1; Wed,
 21 Feb 2024 10:32:23 -0500
X-MC-Unique: 4FRDA7UHOJ6oYafCvjLo0A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B276A282D3C4
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 15:32:23 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.94])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4166A492BE7
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 15:32:23 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-net 2/2] selftests: mptcp: explicitly trigger the listener diag code-path
Date: Wed, 21 Feb 2024 16:32:17 +0100
Message-ID: <6bf1e9da6cb4ec0c6de1acd37995137b74dcc8bf.1708529444.git.pabeni@redhat.com>
In-Reply-To: <cover.1708529444.git.pabeni@redhat.com>
References: <cover.1708529444.git.pabeni@redhat.com>
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

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 tools/testing/selftests/net/mptcp/diag.sh | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 60a7009ce1b5..e3c28479b5a4 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
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
@@ -279,5 +288,20 @@ flush_pids
 chk_msk_inuse 0 "many->0"
 chk_msk_cestab 0 "many->0"
 
+chk_listener_nr 0 "no listener sockets"
+NR_SERVERS=100
+for I in $(seq 1 $NR_SERVERS); do
+	ip netns exec $ns ./mptcp_connect -p $((I + 20001)) -l 0.0.0.0 2>&1 >/dev/null &
+	mptcp_lib_wait_local_port_listen $ns $((I + 20001))
+done
+
+chk_listener_nr $NR_SERVERS "many listener sockets"
+
+# gracefull termination
+for I in $(seq 1 $NR_SERVERS); do
+	echo a | ip netns exec $ns ./mptcp_connect -p $((I + 20001)) 127.0.0.1 2>&1 >/dev/null
+done
+flush_pids
+
 mptcp_lib_result_print_all_tap
 exit $ret
-- 
2.43.0

