Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAC363A2
	for <mptcp@lists.linux.dev>; Fri, 23 Jun 2023 12:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687522820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g+YLjgQG+mnsMl5jt1EwmR0auNXs/ucKGgshILNvFCM=;
	b=MsK4yZlIp0T3qmFLbC6FiS87nnZsovVUi5xG+NFeW7qqwycQzdQT+DMUB6qAOw1WCSDX9Q
	0qREg8oE11NWf2T/n6Nfp2JzLhJZ6XcoC6P0ySiOleywtLbj7RqSlVD9kYtdTQ17uw0hzC
	ifxdF/emyOe+DnwKKkBmJ5MfUMSPPO0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-15FJr4JFOou1mthlFi653Q-1; Fri, 23 Jun 2023 08:20:16 -0400
X-MC-Unique: 15FJr4JFOou1mthlFi653Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 475341C06EE8;
	Fri, 23 Jun 2023 12:20:16 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.194.186])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2D5A0422B0;
	Fri, 23 Jun 2023 12:20:14 +0000 (UTC)
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
Subject: [PATCH net 0/2] selftests: fix mptcp_join test
Date: Fri, 23 Jun 2023 14:19:50 +0200
Message-ID: <cover.1687522138.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5

This series fixes two mptcp_join testcases.
- '001 implicit EP' fails because of:
  - missing iproute support for mptcp 'implicit' flag, fixed with
    iproute2-next commit 3a2535a41854 ("mptcp: add support for implicit
    flag")
  - pm_nl_check_endpoint expecting two ip addresses, while only one is
    present in the iproute output;
- '002 delete and re-add' fails because the endpoint delete command
  provide both id and ip address, while address should be provided only
  if id is 0.

Andrea Claudi (2):
  selftests: mptcp: join: fix 'delete and re-add' test
  selftests: mptcp: join: fix 'implicit EP' test

 tools/testing/selftests/net/mptcp/mptcp_join.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.41.0

