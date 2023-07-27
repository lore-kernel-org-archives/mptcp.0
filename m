Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348FFE57A
	for <mptcp@lists.linux.dev>; Thu, 27 Jul 2023 11:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690456161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=joz6eL6OZHSld/e+DBN0UOiAE0RuCst5jveOc18cRr4=;
	b=C+ixVCm61Dr3O6cCwIDXt8HuHFwkGxlB4Nff30p/tyUCo2VuItVJhncp73nVVAAoUURC00
	IA3vmCmOqRWsQBl49nvX5pxPg/At/Id4GYLz8YZH9yfMX6CCoFtR4a/gENXIHl5ZfpgNgU
	A+sK+SxbUnJz0CWIm7aogJRvkKkiOdY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-684-5hlR_UQtPeWXQCmsdhpBVQ-1; Thu, 27 Jul 2023 07:09:18 -0400
X-MC-Unique: 5hlR_UQtPeWXQCmsdhpBVQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0DDC38025EC;
	Thu, 27 Jul 2023 11:09:17 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.193.76])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7B812492C13;
	Thu, 27 Jul 2023 11:09:16 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <martineau@kernel.org>
Subject: [PATCH mptcp-next v2 2/2] selftests: mptcp: join: fix 'implicit EP' test
Date: Thu, 27 Jul 2023 13:08:55 +0200
Message-ID: <5c70132fb9512ecc42fea01c3118dc9a292791ab.1690454072.git.aclaudi@redhat.com>
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

mptcp_join 'implicit EP' test currently fails when using ip mptcp:

$ ./mptcp_join.sh -iI
<snip>
001 implicit EP    creation[fail] expected '10.0.2.2 10.0.2.2 id 1 implicit' found '10.0.2.2 id 1 rawflags 10 '
Error: too many addresses or duplicate one: -22.
                   ID change is prevented[fail] expected '10.0.2.2 10.0.2.2 id 1 implicit' found '10.0.2.2 id 1 rawflags 10 '
                   modif is allowed[fail] expected '10.0.2.2 10.0.2.2 id 1 signal' found '10.0.2.2 id 1 signal '

This happens because of two reasons:
- iproute v6.3.0 does not support the implicit flag, fixed with
  iproute2-next commit 3a2535a41854 ("mptcp: add support for implicit
  flag")
- pm_nl_check_endpoint wrongly expects the ip address to be repeated two
  times in iproute output, and does not account for a final whitespace
  in it.

This fixes the issue trimming the whitespace in the output string and
removing the double address in the expected string.

Fixes: 34aa6e3bccd8 ("selftests: mptcp: add ip mptcp wrappers")
Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index b972feb9a3a2..4938baa4c5fe 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -769,10 +769,11 @@ pm_nl_check_endpoint()
 	fi
 
 	if [ $ip_mptcp -eq 1 ]; then
+		# get line and trim trailing whitespace
 		line=$(ip -n $ns mptcp endpoint show $id)
+		line="${line% }"
 		# the dump order is: address id flags port dev
-		expected_line="$addr"
-		[ -n "$addr" ] && expected_line="$expected_line $addr"
+		[ -n "$addr" ] && expected_line="$addr"
 		expected_line="$expected_line $id"
 		[ -n "$_flags" ] && expected_line="$expected_line ${_flags//","/" "}"
 		[ -n "$dev" ] && expected_line="$expected_line $dev"
-- 
2.41.0

