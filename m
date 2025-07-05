Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC67319DF4A
	for <mptcp@lists.linux.dev>; Sat,  5 Jul 2025 07:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751700301; cv=none; b=WMfixyQg1gtfE1gShKN50tGxLyaHkNjf/+7XK9JBwge2ZwK3E5BF5DRNvlBI+XsqVJ9Tn3miJZHBmDYl//HSHtGmGzlBJ5hLMYtSVgJI8mio2hdtz/aozbWTsfsKNJzk2S8NwfNYl+sVE9H7yh2kDrrGgTclHTdR1AGgDZODJ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751700301; c=relaxed/simple;
	bh=Go5L/WT/sUVi77TFFQUsUbF8pRDi1t38VFGUAiSF8pQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=MJOckcgH3IYGAu2WJiUP+OMaekkn3frPx87Sd6sRETiayLeP8gvpaE9zn5iHpP4KKXpynZ41nHqGkvTUI1LxynosEmEnLp0jyIJbUOZT+xG5d4JfJCymoVe5uDH0O6GvD3k6XLqbUP3yyTXaxnqCz8TJQEIHVAQbdEManui6Ks8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GNuFtEq6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNuFtEq6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751700298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TCIatqVjd2w8j1JpZu2HBiiOru9aRzZUIt6MxLY34CQ=;
	b=GNuFtEq6tTh928qe64KjYroC27BCup7NwDERrWdEtiVDgLa5Fv/OLrnmDGRGVJZPbt+w08
	RFpUdoOr7fsCiv63XINaVN/bBKdr4V8skZgTHJDDp9DU9SorYHMOXv3hHYk05aEKKFllnJ
	lPGm1P6DqwUaCMGNdgGIxgzMRQqXsik=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-1zLblfsDPnm8evK17pmVBA-1; Sat,
 05 Jul 2025 03:24:57 -0400
X-MC-Unique: 1zLblfsDPnm8evK17pmVBA-1
X-Mimecast-MFC-AGG-ID: 1zLblfsDPnm8evK17pmVBA_1751700296
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6C17C1944A82
	for <mptcp@lists.linux.dev>; Sat,  5 Jul 2025 07:24:56 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 594B1195608F
	for <mptcp@lists.linux.dev>; Sat,  5 Jul 2025 07:24:54 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net v2 0/5] mptcp: fix fallback-related races
Date: Sat,  5 Jul 2025 09:24:44 +0200
Message-ID: <cover.1751699999.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UsPdPXBtqvp64klv-InBdh4iOBHJ1kFuhv3LUO0kCCo_1751700296
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This series contains 3 fixes somewhat related to various races we have
while handling fallback and 2 small follow-up likely more suited for
net-next.

The root cause of the issues addressed here is that the check for
"we can fallback to tcp now" and the related action are not atomic. That
also applies to fallback due to MP_FAIL - where the window race is even
wider.

Address the issue introducing an additional spinlock to bundle together
all the relevant events, as per patch 1 and 2.

Note that mptcp_disconnect() unconditionally
clears the fallback status (zeroing msk->flags) and that may race with
operation still running on the (closing) subflows.

Such race is addressed in patch 3.

Patch 4 cleans up a bit the fallback code, introducing specific MIB for
each FB reason, and patch 5 drops the, hopefully now redundandt
pr_fallback().

Paolo Abeni (5):
  mptcp: make fallback action and fallback decision atomic
  mptcp: plug races between subflow fail and subflow creation
  mptcp: fix status reset on disconnect()
  mptcp: track fallbacks accurately via mibs
  mptcp: remove pr_fallback()

 net/mptcp/ctrl.c     |   4 +-
 net/mptcp/mib.c      |   5 ++
 net/mptcp/mib.h      |   7 +++
 net/mptcp/options.c  |   4 +-
 net/mptcp/pm.c       |   8 ++-
 net/mptcp/protocol.c | 126 +++++++++++++++++++++++++++++++++++--------
 net/mptcp/protocol.h |  35 ++++++------
 net/mptcp/subflow.c  |  35 ++++++------
 8 files changed, 164 insertions(+), 60 deletions(-)

-- 
2.49.0

