Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996C5AD2E
	for <mptcp@lists.linux.dev>; Thu, 27 Jul 2023 11:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690456157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDiAsbzbjZf6wAiEnCZDwZjTHosyn9ThNb8HBkBPfEU=;
	b=gLGW2b3zjtMz0kga3LlTlyJ9pFCGPkW86tutTiUg+S+rLUPksMBHCAYtdhgBtSkrSguLrl
	BQTZ2QfAo5rXVIL5crq0Xd38EbVBqbke3rbONdPa0n1dBWVHEowPN0C2AjzabF1Ds2O/IT
	OIXpqBspj2FAi3F7Im/dcRLDrOtSomI=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-hffDtHqQNrSBzmZsyQU7Ow-1; Thu, 27 Jul 2023 07:09:16 -0400
X-MC-Unique: hffDtHqQNrSBzmZsyQU7Ow-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBFB61C09A43;
	Thu, 27 Jul 2023 11:09:15 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.193.76])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C97E0492C13;
	Thu, 27 Jul 2023 11:09:14 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <martineau@kernel.org>
Subject: [PATCH mptcp-next v2 1/2] selftests: mptcp: join: fix 'delete and re-add' test
Date: Thu, 27 Jul 2023 13:08:54 +0200
Message-ID: <41253445a424229f014a521e9d9ade26b682bd3e.1690454072.git.aclaudi@redhat.com>
In-Reply-To: <cover.1690454072.git.aclaudi@redhat.com>
References: <cover.1690454072.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

mptcp_join 'delete and re-add' test fails when using ip mptcp:

$ ./mptcp_join.sh -iI
<snip>
002 delete and re-add                    before delete[ ok ]
                                         mptcp_info subflows=1         [ ok ]
Error: argument "ADDRESS" is wrong: invalid for non-zero id address
                                         after delete[fail] got 2:2 subflows expected 1

This happens because endpoint delete includes an ip address while id is
not 0, contrary to what is indicated in the ip mptcp man page:

"When used with the delete id operation, an IFADDR is only included when
the ID is 0."

This fixes the issue using the $addr variable in pm_nl_del_endpoint()
only when id is 0.

Fixes: 34aa6e3bccd8 ("selftests: mptcp: add ip mptcp wrappers")
Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 0ae8cafde439..b972feb9a3a2 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -678,6 +678,7 @@ pm_nl_del_endpoint()
 	local addr=$3
 
 	if [ $ip_mptcp -eq 1 ]; then
+		[ $id -ne 0 ] && addr=''
 		ip -n $ns mptcp endpoint delete id $id $addr
 	else
 		ip netns exec $ns ./pm_nl_ctl del $id $addr
-- 
2.41.0

