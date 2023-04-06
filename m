Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509ECAD38
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 17:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680802342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8pAD0brmolSfS3bAeB2RILy7PcAjCQ4RwieUL5GtsVY=;
	b=HqIsxBl39c2YnNkFbKlaKl6BlpG8Rv3/SMSn7V38pQHx539giDzZ2imSKPPIT+PrOL8/+4
	QkaVC64IV1d0t/M/FdF85HHyBXUAZEtBOGh9Nc1YM5CBfrU+oC7Ufo0g4OOnt4Rh68AyGG
	e5UzJhPVTbds5lLz4UdKUtekNa8VLzo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-hScUCdLFMiyrn_-Fd7bJuQ-1; Thu, 06 Apr 2023 13:32:20 -0400
X-MC-Unique: hScUCdLFMiyrn_-Fd7bJuQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 76DAF85530D
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 17:32:20 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.137])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1321F2027062
	for <mptcp@lists.linux.dev>; Thu,  6 Apr 2023 17:32:19 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH RFC mptcp-net-next 0/5] YAML template for MPTCP netlink API
Date: Thu,  6 Apr 2023 19:32:00 +0200
Message-ID: <cover.1680801697.git.dcaratti@redhat.com>
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
Message-ID: <20230406173200.r2OSSyB4-lMtah_kMK84OINZM04dBR-CZRCq5p_-O48@z>

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

