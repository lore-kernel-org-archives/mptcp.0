Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A747FBBD
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529547; cv=none; b=aDrH4wg6korZeyGKNIyD9MvXsIGUtqhuiR3JNPdmlZKac3OvCaIzBYkFoCU9CrpL1ql/hYdjLm2xFpIlpJ5s+qY5kB94/z8TKrB9Ck85PwxELMAVa+HnrDTur5lCLcT2V1IDaGaTjTVX927vHYabOHy1aIDGAXWU8VyaHgxlvag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529547; c=relaxed/simple;
	bh=jQygkMFX8gMo3IZ7cVvZNeh3bPlRmnN+VSIiCAgzXWA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lxo3s27it8AAPbffsj4HMYV/agJPiGpb1/BcFS1ALRtsyQla7MLQxpcOyPHtuK3ib1ad0M6tvkJU9F3g01Y5Be+51Ag01OjEYoEgwbDXoa6T5pQdrnJfZlY8bVnk99j2jAfgOBVwC6Ur5H8JMUJHCLQqk2ZhQl7Rav0/KiuBzqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iWKLixnw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWKLixnw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708529543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t6WBK7hHYcQn/A0mFp9mCSNpT1ZzOc+HaTy8s8VigsM=;
	b=iWKLixnw6gqLG12SvI5ET+Sx8F19Lh/RJWzbjiy/fGutx+L4y31oasCC2VCEvcTzdfGa4m
	t9II4SQDowfvz0zGghyjYTUBcEfB9HWclW0MMBYx5ThIH0XXtw/k1qoe0Q9IPLkujZ9Mty
	leZM7fozOInMFRY/qngo6dxCbmWHplo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-LiOSocRVNTCDJk5GZcZDCA-1; Wed, 21 Feb 2024 10:32:22 -0500
X-MC-Unique: LiOSocRVNTCDJk5GZcZDCA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CAD1868A01
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 15:32:22 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.94])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C4824492BD7
	for <mptcp@lists.linux.dev>; Wed, 21 Feb 2024 15:32:21 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-net 0/2] mptcp: fix another deadlock issue
Date: Wed, 21 Feb 2024 16:32:15 +0100
Message-ID: <cover.1708529444.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Eric reported and diagnosed another possible deadlock problem with
the MPTCP diag code. The first patch address the issue, and the second
adds self-test coverage for the relevant codepath, to get lockdep help
to catch future similar issues.

following-up with the netdev fiasco, sending on mptcp only

v1 -> v2:
 - fix (avoid) feature detection in patch 2/2 (Matttbe)

Paolo Abeni (2):
  mptcp: fix possible deadlock in subflow diag
  selftests: mptcp: explicitly trigger the listener diag code-path

 net/mptcp/diag.c                          |  3 +++
 tools/testing/selftests/net/mptcp/diag.sh | 24 +++++++++++++++++++++++
 2 files changed, 27 insertions(+)

-- 
2.43.0

