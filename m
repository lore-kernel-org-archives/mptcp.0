Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8741E57A
	for <mptcp@lists.linux.dev>; Thu, 27 Jul 2023 11:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690456157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jc5SdYdxpzuKFYzToxTFdPWnJCk2eZhbw6vjfqFXFVA=;
	b=b94/mJivbNEitcIroVILpB/7zau0GLDl7hYQpsg14+0cl95nBf8dxnzY7yYsycGsWbTpYY
	ysmX7f1xpRSYNeyK45GM7kHXMA7uYQ8YQMDCE5OQVRpDu2C3Nq4L5Q6xsfEHg9qkEzCOtk
	o6XRwgMxyXqduW26CmtGfx4i/5Vxy4o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-652-7Sj17URVNASWI8UZMf6sig-1; Thu, 27 Jul 2023 07:09:14 -0400
X-MC-Unique: 7Sj17URVNASWI8UZMf6sig-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E4CC858EED;
	Thu, 27 Jul 2023 11:09:14 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.193.76])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CE513492C13;
	Thu, 27 Jul 2023 11:09:12 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Mat Martineau <martineau@kernel.org>
Subject: [PATCH mptcp-next v2 0/2] selftests: fix mptcp_join test
Date: Thu, 27 Jul 2023 13:08:53 +0200
Message-ID: <cover.1690454072.git.aclaudi@redhat.com>
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

This series fixes two mptcp_join testcases when using ip mptcp:
- 'implicit EP' fails because of:
  - missing iproute support for mptcp 'implicit' flag, fixed with
    iproute2-next commit 3a2535a41854 ("mptcp: add support for implicit
    flag")
  - pm_nl_check_endpoint expecting two ip addresses, while only one is
    present in the iproute output;
- 'delete and re-add' fails because the endpoint delete command
  provide both id and ip address, while address should be provided only
  if id is 0.

Changelog:

v1 -> v2
- Clearly state test fails only when using ip mptcp, i.e.
  ./mptcp_join.sh -i
- Remove test numbers from commit messages
- On endpoint delete, continue to provide $addr when id is 0.

Andrea Claudi (2):
  selftests: mptcp: join: fix 'delete and re-add' test
  selftests: mptcp: join: fix 'implicit EP' test

 tools/testing/selftests/net/mptcp/mptcp_join.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.41.0

