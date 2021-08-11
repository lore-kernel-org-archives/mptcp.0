Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AD570
	for <mptcp@lists.linux.dev>; Wed, 11 Aug 2021 09:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1628673964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K15lGdc2EeIJ2BdynVX/j9yXUrityDcmsc8eZjoRAw4=;
	b=MV0D8B2aeHUgpoDzuBX1TL0ttaq/bnBA55qXYKrWXslheX/cUq7J28eOkTZJIYLbGRub6R
	TyQJ81kWnJpic7q92r/mRVJOFxLMQViHH7OGT7q5RyuhXBS6JFULRYRnrY6MPneHa526Kq
	YvlAqZfmmEfdSZE1xcvqkrXALzWpNds=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-W36GtZlzPJmuAyqieSnnYQ-1; Wed, 11 Aug 2021 05:26:03 -0400
X-MC-Unique: W36GtZlzPJmuAyqieSnnYQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C03087D541
	for <mptcp@lists.linux.dev>; Wed, 11 Aug 2021 09:26:02 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.194.5])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A4D085C1B4
	for <mptcp@lists.linux.dev>; Wed, 11 Aug 2021 09:26:01 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 0/2] mptcp: some self-tests fixup
Date: Wed, 11 Aug 2021 11:25:50 +0200
Message-Id: <cover.1628673891.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

The 2 squash-to patches try to address issues/221, at least
for the root cause reported in the github tracker.

Note, I can still reproduce some self-test failures, on other
link_failure test case, but with lower rate and different
cause - to be investigated.

Paolo Abeni (2):
  Squash-to: "selftests: mptcp: add testcase for active-back"
  Squash-to: "mptcp: move drop_other_suboptions check under pm lock"

 net/mptcp/options.c                             | 4 ++++
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 8 ++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.26.3

