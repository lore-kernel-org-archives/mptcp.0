Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13421C68A6
	for <mptcp@lists.linux.dev>; Fri, 28 Jun 2024 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719590062; cv=none; b=E+5Q9k/RTM9EGkSkhvZ5EPxo4ILtWsr7g5KCYyWhw0AqlVkb3EoX4M7ypM0wNn+6aWXHgtfdXqyknDBA+PjbKVkJ4iH6mHa6bt/AIe1UPZer9FkFfSKYHwNCIe3xtDAxbh+AoYtFr9bPJusxD66A5uxY/axTVT0rSnb951lbvEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719590062; c=relaxed/simple;
	bh=1q5gRW494o41NC7mPAMznR5FgIiKlFgFZZ1VcbtxJis=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oz7x+Iv7Nuly2Xifm//y13+2GG3YMlQQfMKmSrT74K3EpYGfx2u1m7wCjAWDN7Sr8KBapBI23Ac3oNR4gnxebo0IOjuBFXbXWCYqBtUS6/sG7/ua2QwOoD28gMaVjlL7o1FOXApPZYAgIdzgdk0jerArM8DG0y7e1ev0kP+sXOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V3B5VKjC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3B5VKjC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719590059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u14D78JHQEAfOXXEzPqBEXThxDbmbq3TnCXtAfw5HrU=;
	b=V3B5VKjCXdjnS+QHDORD0ZrFxmxWnir4GpxwLNQ59vJkCQclwj7U0aeNzYT7CH3/Vkmtr0
	BTtNlBg5A9jUZ0tGTyLsIMPKj2EodnKpikO7+7PuUJAtniViQGN3bQ8dTwgZi22TLreKD3
	vpGjJhwd9QfWwt/BO0z4l5exUnm8yIc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-ArzpeemiPMik_OZABcFQaw-1; Fri,
 28 Jun 2024 11:54:17 -0400
X-MC-Unique: ArzpeemiPMik_OZABcFQaw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8B4F1944CCA
	for <mptcp@lists.linux.dev>; Fri, 28 Jun 2024 15:54:16 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.34])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B173019560B2
	for <mptcp@lists.linux.dev>; Fri, 28 Jun 2024 15:54:15 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 0/3] mptcp: fix signal endpoint readd
Date: Fri, 28 Jun 2024 17:54:05 +0200
Message-ID: <cover.1719589916.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Issues/501 showed that the NL PM currently don't add corectly removal
and re-add of signal endpoint.

Patch 1/3 addresses the issue, patch 2/3 introduce a related self-test,
and the last patch address a pre-existing buglet in the self-test infra.

Paolo Abeni (3):
  mptcp: fix announced address accounting
  selftests: mptcp: add explicit test case for remove/readd
  selftests: mptcp: fix error path

 net/mptcp/pm_netlink.c                        | 27 ++++++++++++-----
 .../testing/selftests/net/mptcp/mptcp_join.sh | 30 ++++++++++++++++++-
 2 files changed, 48 insertions(+), 9 deletions(-)

-- 
2.45.1

