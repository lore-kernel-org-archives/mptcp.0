Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C202459EA
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 07:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762845857; cv=none; b=GiXb2W+fSzS7CMbfcexT4fYNfRedueJVb7sJlBMYLpfGJyVc/yMrs2ijlmWYndEJY4C50fDek8Hp5u/GBJxidsO4uwIINDVb5LNEzU7vQJjbwltdvGsX57FpAxTuC7zRQE0Lj9zPXqElzNoxYO6ka8gpZ2+H5hpq3A/t6YzuFhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762845857; c=relaxed/simple;
	bh=7UJPYJKCxT3xVaUsfNDsxTwRQqfgy4p9KDZUa3qawVY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=WEc3/3AaAloZKMhYe/WXv6jINFKNSuU6Qwhv/bIVpmWnrxHP6G91X0k+v4EnCsqBNLKuGQi3QwjXM8hD/siOR3mvNQIelkAyn72NLXiPO45MaYiEPeRHcZ2OWwA7pEiIu6ktbwuRXs1zPJzO2ikXcFq8tNWmJtd8yyH0dBVAaUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IwPzX3mr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwPzX3mr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762845854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zBE103ts2jUAvEcogDb7ZSrvIgG1mheFD7OhxnBRkbs=;
	b=IwPzX3mrz5RjXhqPAy5De4p1BWzHeKUb+wOrQWI0POKVUbphmUNAdoDRZsHzQQIcK5Uyzl
	WO95FKY4yl1yJrrTU1ZvQojrKo5uj0Trt2JfEOK1d7sbL3DtUsGGjzgKu5ham51x4HmK3v
	XBVyMMauDOHC4ou0HjOXe743AtPxAG0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-r11vcCZiN9KcHb_r67AA1g-1; Tue,
 11 Nov 2025 02:24:12 -0500
X-MC-Unique: r11vcCZiN9KcHb_r67AA1g-1
X-Mimecast-MFC-AGG-ID: r11vcCZiN9KcHb_r67AA1g_1762845851
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 438B51956088
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 07:24:11 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.226.92])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 35C3F195608E
	for <mptcp@lists.linux.dev>; Tue, 11 Nov 2025 07:24:09 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-net 0/2] mptcp: a couple of fixes
Date: Tue, 11 Nov 2025 08:24:04 +0100
Message-ID: <cover.1762845791.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TWLEklKrB_3wbH9cSjwMQ1s62MwJZr8fgYKPRp74bYI_1762845851
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The first patch addresses a recently filed issue, 2nd one is due to
code inspection while investigating the mentioned issue.

v1 -> v2:
  - fix pktdrill failures due to missing rcv_wnd_sent initialization

Paolo Abeni (2):
  mptcp: do not fallback when OoO is present
  mptcp: do not drop partial packets.

 net/mptcp/protocol.c | 30 ++++++++++++++++++++++--------
 net/mptcp/subflow.c  |  3 ++-
 2 files changed, 24 insertions(+), 9 deletions(-)

-- 
2.51.1

