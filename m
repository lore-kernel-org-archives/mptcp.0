Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772111374
	for <mptcp@lists.linux.dev>; Tue, 19 Apr 2022 17:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1650388744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eVdLWTfbtNBd3TEFtmiqkLvoxJk9+8k+wCtc4CdxD5E=;
	b=GQn1/4xcZDRHufTUfiEEv7lR4hF9qOO4d9KOOsQVIbC9ID/qDc6d7KRwS5PdHtUiaOQgjB
	GWb38GK7CyitWVDRImLnCBS/hORMYqN4N6ndXJfHcgXV/KzcQQ/9HeoN2ViF446sbJetKH
	YB9+iHvYvzP7zgUYiZaFF8/gw8CSyOw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-GJBA5tKkMsaDCTq-yAF2UA-1; Tue, 19 Apr 2022 13:18:59 -0400
X-MC-Unique: GJBA5tKkMsaDCTq-yAF2UA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E4631802A1B;
	Tue, 19 Apr 2022 17:18:45 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.165])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CE50640146E;
	Tue, 19 Apr 2022 17:18:44 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <eric.dumazet@gmail.com>,
	mptcp@lists.linux.dev
Subject: [RFC PATCH 0/2] mptcp: never shrink offered window
Date: Tue, 19 Apr 2022 19:18:22 +0200
Message-Id: <cover.1650386197.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10

There patches are part of a somewhat largish series to implement
more strict RFC compliance for the MPTCP-level congestion window
handling, solving some tput instability issues.

The obtain the above we need to modify an existing MPTCP hook,
touching the TCP code (in patch 1/2), ence the RFC.

The later patch demonstrates the actual usage of such hook.

Paolo Abeni (2):
  tcp: allow MPTCP to update the announced window.
  mptcp: never shrink offered window

 include/net/mptcp.h   |  2 +-
 net/ipv4/tcp_output.c | 14 ++++++-----
 net/mptcp/options.c   | 54 ++++++++++++++++++++++++++++++++++++-------
 3 files changed, 55 insertions(+), 15 deletions(-)

-- 
2.35.1

