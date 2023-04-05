Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4F7322A
	for <mptcp@lists.linux.dev>; Wed,  5 Apr 2023 22:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680734869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=daWn78dXiHaUfC7M1p/w27gyAhmy+65lLx4UYZOgWsM=;
	b=JP1ZdksjET5P4O2s7o0Ay+5mYKBMndQDgSHbRxzDVVgMO80paS4wpWfJiFPvI/cMn1C/yr
	JIwwRIoHf+omrKid7nfyZfaQ4oHlOLzNnZsXnPSKLecQ67M1oPPAX5F9p6o5uvmjBbvS/B
	TczD28uDKKUz5OngsBBv4dP7b+rMNpI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-529--uV_GVO_MR24ltvqt8iCAA-1; Wed, 05 Apr 2023 18:47:46 -0400
X-MC-Unique: -uV_GVO_MR24ltvqt8iCAA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16AC685C069;
	Wed,  5 Apr 2023 22:47:46 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.138])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 74D7A140EBF4;
	Wed,  5 Apr 2023 22:47:45 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Christoph Paasch <cpaasch@apple.com>
Subject: [PATCH mptcp-net 0/2] mptcp: a couple of fixup
Date: Thu,  6 Apr 2023 00:47:36 +0200
Message-Id: <cover.1680733942.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Hopefully addressing for good issues/371

There are actually several different problems that pop-up in random
order with the repro from such issue.

@Christoph: could you please have a spin in your testbed?

Paolo Abeni (2):
  Squash-to: "mptcp: fix accept vs worker race"
  Squash-to: "mptcp: stops worker on unaccepted sockets at listener
    close"

 net/mptcp/protocol.c | 13 +++++++++++--
 net/mptcp/subflow.c  |  4 ++--
 2 files changed, 13 insertions(+), 4 deletions(-)

-- 
2.39.2

