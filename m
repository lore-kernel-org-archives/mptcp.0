Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8BA23B5
	for <mptcp@lists.linux.dev>; Mon,  4 Jul 2022 09:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1656926091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t2FFbPi6tp1e88jktF1i9GYzaYK+ErVR1BhKXSDnm2c=;
	b=PQ2L7Oq7DOsjX9JtTzDrogRZXopu8HIFEQTJgFyroBjks4y8WeBTEdLD5JtJYAOIgfzP3Q
	FoQu+3AGDQT1VoC4FLS9yYNYhH10rF4ZlJA47UZ2IvFK0GUlEr25N3GVJcuiU86e0kES0y
	zdy9glyf0O15JCYTa8PoCh7JQojLj30=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-aYmHb2t7PKyUlQbjeA_Kmg-1; Mon, 04 Jul 2022 05:14:50 -0400
X-MC-Unique: aYmHb2t7PKyUlQbjeA_Kmg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13D1F3C01D91
	for <mptcp@lists.linux.dev>; Mon,  4 Jul 2022 09:14:50 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.94])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 988E22166B26
	for <mptcp@lists.linux.dev>; Mon,  4 Jul 2022 09:14:49 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 0/5] mptcp: support for MPC prio exchange
Date: Mon,  4 Jul 2022 11:14:31 +0200
Message-Id: <cover.1656925387.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

This series introduces the ability to control the MPC subflow for
the in kernel PM.

patch 1 && 2 refactor a bit the endpoint lookup and MP_PRIO generation
code, to simplify the next patch.

patch 3 introduces the new feature quering the backup status of the
endpoint used by the MPC subflow and eventually generating the needed
MP_PRIO option.

Patch 4 is a related cleanup.

v1 -> v2:
  - rebased, and omitted old patch 1 which should go through -net

Paolo Abeni (5):
  mptcp: introduce and use mptcp_pm_send_ack()
  mptcp: address lookup improvements
  mptcp: allow the in kernel PM to set MPC subflow priority
  mptcp: more accurate MPC endpoint tracking
  selftests: mptcp: add MPC backup tests

 net/mptcp/pm_netlink.c                        | 128 ++++++++++--------
 net/mptcp/protocol.c                          |   2 +-
 net/mptcp/protocol.h                          |   2 +-
 .../testing/selftests/net/mptcp/mptcp_join.sh |  30 ++++
 4 files changed, 104 insertions(+), 58 deletions(-)

-- 
2.35.3

