Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD8D2CA7
	for <mptcp@lists.linux.dev>; Mon,  6 Mar 2023 18:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1678127429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nxfkKWv+B338MRbqmD0M4qzsCi0iVLyInM4YikWIUe8=;
	b=NsuEAiorvRrlPllASmVHtTCQ7+aiE2ZkO5DoZhnHxjMS51wp+Nzm56laFWkj9AzU90BsrV
	c3i0KkmdyxPCdbP+LVoZVBVif5ep4rQ6eGpo8QKRefFXzRbwFaWPdxxdDXeKzR/s4/RIba
	a0axX5aSh+ltfB2YQDKp1mx2RoCttrY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-QXajkexEN6Gh-mEmvoViUQ-1; Mon, 06 Mar 2023 13:30:28 -0500
X-MC-Unique: QXajkexEN6Gh-mEmvoViUQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E88FF28004EB
	for <mptcp@lists.linux.dev>; Mon,  6 Mar 2023 18:30:27 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.195.34])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 773FD175AD
	for <mptcp@lists.linux.dev>; Mon,  6 Mar 2023 18:30:27 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 0/2] mptcp: a couple of cleanups
Date: Mon,  6 Mar 2023 19:30:19 +0100
Message-Id: <cover.1678122760.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

After the recent fixes we have both a good changes and some
needs to simplify subflow_syn_recv_sock().

A couple of patches in that direction, also addressing a long
standing feature issue.

Paolo Abeni (2):
  mptcp: avoid unneeded address copy
  mptcp: simplify subflow_syn_recv_sock()

 net/mptcp/subflow.c | 40 ++++++++++------------------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

-- 
2.39.2

