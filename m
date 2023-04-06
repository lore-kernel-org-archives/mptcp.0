Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189E9AD29
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 17:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680802338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8pAD0brmolSfS3bAeB2RILy7PcAjCQ4RwieUL5GtsVY=;
	b=fpmsfgkLFdYR0u2z5XKUhgWaFHacVNreO16i4eeAzeYUU5gODPX+2VyTpS1W6KHYBRuZVr
	ykb+5vTvwfXX/TK2iEWDPFN6z0jamH4EMucUizaeWptf16DPLWUAb80KJ+7qfrJ97Pjir7
	UhCB2mvOh5xVA3Ee1DTlRbIDkm2lvWw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-3wK52bAkM4-wGSjvk-pbUg-1; Thu, 06 Apr 2023 13:32:16 -0400
X-MC-Unique: 3wK52bAkM4-wGSjvk-pbUg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C3ED185A7A4
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 17:32:16 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.137])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DC5162027062
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 17:32:15 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH RFC mptcp-net-next 0/5] YAML template for MPTCP netlink API
Date: Thu,  6 Apr 2023 19:31:54 +0200
Message-Id: <cover.1680801697.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Related: #377

Notes:
- the attributes in the operation list is not really good, we probably
  need to specify better what parameters are used in the .doit() function
  (though the generated code is the same). Specifying 'remote_addr'
  either in 'request' or in 'reply' would  probably make patch 2/5 useless.
- I didn't add the multicast groups on purpose. ynl-c.py is not able to
  generate the operation list for genetlink-legacy, so all this part
  (including multicast groups) needs to be left unspecified in the
  template.



Davide Caratti (5):
  tools: ynl: add uns-admin-perm to genetlink legacy
  tools: ynl: fix bug in case of multiple nested attributes of the same
    type
  Documentation: netlink: add a YAML spec for mptcp
  mptcp: uapi: add header files generated from YAML spec
  net/mptcp: use netlink policy generated from YAML spec

 Documentation/netlink/genetlink-legacy.yaml |   2 +-
 Documentation/netlink/specs/mptcp.yaml      | 361 ++++++++++++++++++++
 include/uapi/linux/mptcp.h                  | 167 +--------
 include/uapi/linux/mptcp_pm.h               | 145 ++++++++
 net/mptcp/Makefile                          |   3 +-
 net/mptcp/pm_netlink.c                      | 107 +-----
 net/mptcp/pm_nl.c                           |  91 +++++
 net/mptcp/pm_nl.h                           |  39 +++
 net/mptcp/pm_userspace.c                    |   9 +-
 net/mptcp/protocol.h                        |   6 +-
 tools/net/ynl/ynl-gen-c.py                  |   3 +-
 11 files changed, 665 insertions(+), 268 deletions(-)
 create mode 100644 Documentation/netlink/specs/mptcp.yaml
 create mode 100644 include/uapi/linux/mptcp_pm.h
 create mode 100644 net/mptcp/pm_nl.c
 create mode 100644 net/mptcp/pm_nl.h

-- 
2.39.2

