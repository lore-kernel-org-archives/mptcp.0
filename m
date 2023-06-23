Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EC26AA0
	for <mptcp@lists.linux.dev>; Fri, 23 Jun 2023 12:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687522822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mX02EQjfhnvNS52lhiZUHESdDzM2wywpph+bQHFJGEw=;
	b=HqVTrwztXwG4lQUBOjmAWzwUhi46EzCGtNzQG18PF6BcB7RS0IaweddhYst3G7RM5yKT9v
	e7bDXN00Lwi+oIh/J7loIwhrvZlYsq6huWvwuXFCi2ozvfyDxZ4XcfE19R9OT6SeOCjdE3
	YL9XXsozbtTAOSOrf4C/LZEgYcZygwI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-ic0HvJDqMSC6QC2RFc0Bxg-1; Fri, 23 Jun 2023 08:20:19 -0400
X-MC-Unique: ic0HvJDqMSC6QC2RFc0Bxg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C7141C06EE2;
	Fri, 23 Jun 2023 12:20:18 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.194.186])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9E3E3422B0;
	Fri, 23 Jun 2023 12:20:16 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mptcp@lists.linux.dev,
	matthieu.baerts@tessares.net,
	martineau@kernel.org,
	geliang.tang@suse.com
Subject: [PATCH net 1/2] selftests: mptcp: join: fix 'delete and re-add' test
Date: Fri, 23 Jun 2023 14:19:51 +0200
Message-ID: <927493b7ba79d647668e95a34007f48e87c0992a.1687522138.git.aclaudi@redhat.com>
In-Reply-To: <cover.1687522138.git.aclaudi@redhat.com>
References: <cover.1687522138.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5

mptcp_join '002 delete and re-add' test currently fails in the 'after
delete' testcase.

This happens because endpoint delete includes an ip address while id is
not 0, contrary to what is indicated in the ip mptcp man page:

"When used with the delete id operation, an IFADDR is only included when
the ID is 0."

This fixes the issue simply not using the $addr variable in
pm_nl_del_endpoint().

Fixes: 34aa6e3bccd8 ("selftests: mptcp: add ip mptcp wrappers")
Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0ae8cafde439..5424dcacfffa 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -678,7 +678,7 @@ pm_nl_del_endpoint()
 	local addr=$3
 
 	if [ $ip_mptcp -eq 1 ]; then
-		ip -n $ns mptcp endpoint delete id $id $addr
+		ip -n $ns mptcp endpoint delete id $id
 	else
 		ip netns exec $ns ./pm_nl_ctl del $id $addr
 	fi
-- 
2.41.0

