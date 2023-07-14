Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364A06FC8
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689334198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=94bV/u5OxTub7IBTriDjbPCGM8ZZeFs5+2DHu+Ne6xY=;
	b=ILfIotCPQ6PJ35wqmUJuZOoh9USFutlCy8KRKEZw82Wu9UefFU2I7+Rj3p9UGfG8TAKj2V
	7Ui2wkB1lmejvfycvwxpVPT/j0aS+3GWwfy6dTqcTLQ0wsHa05YJxUIgf5fe5mtQlxc9sj
	4e9QF21S+bDiRmXWfBSZFOgXoyWq0Hs=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-pC-C82TOPoSy98wrv0tHdQ-1; Fri, 14 Jul 2023 07:29:57 -0400
X-MC-Unique: pC-C82TOPoSy98wrv0tHdQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34E621C05AAF
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:29:57 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BA9922166B25
	for <mptcp@lists.linux.dev>; Fri, 14 Jul 2023 11:29:56 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v2 mptcp-next 00/13] mptcp: get rid of msk->subflow
Date: Fri, 14 Jul 2023 13:29:31 +0200
Message-ID: <cover.1689334116.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The mptcp protocol maintains an additional struct socket per connection,
mainly to be able to use easily tcp-level struct socket operations.

That lead to several ill side effects, beyond the quite unfortunate/
confusing field name
- active and passive sockets behavior is incosistent, as only active
  ones have not NULL msk->subflow, leading to different error handling
  (and different error code returned to the user-space) in several
  places.
- active sockets uses an unneeded, larger amount of memory
- passive sockets can't successfully go through accept()/disconnect()
  accept()

This series address all the above finally getting rid of the blamed
field. The first patch is a minor clean-up, in the next 11 patches
msk->subflow usage is sistematically removed from the mptcp protocol,
replacing it with direct msk->first usage, eventually introducing new
core helpers as needed.

The final patch finally dispose the field, and it's the only patch in
the series intened to produce functional changes.

v1 -> v2:
 - dropped first patch (already applied)
 - a bunch of typos and comments, the only patches with code changes
   are 7/13, 9/13, 13/13, see the individual changelog for the
   details.

Paolo Abeni (13):
  mptcp: avoid unneeded mptcp_token_destroy() calls
  mptcp: avoid additional __inet_stream_connect() call
  mptcp: avoid subflow socket usage in mptcp_get_port()
  net: factor out inet{,6}_bind_sk helpers
  mptcp: mptcp: avoid additional indirection in mptcp_bind()
  net: factor out __inet_listen_sk() helper
  mptcp: avoid additional indirection in mptcp_listen()
  mptcp: avoid additional indirection in mptcp_poll()
  mptcp: avoid unneeded indirection in mptcp_stream_accept()
  mptcp: avoid additional indirection in sockopt
  mptcp: avoid ssock usage in mptcp_pm_nl_create_listen_socket()
  mptcp: change the mpc check helper to return a sk
  mptcp: get rid of msk->subflow

 include/net/inet_common.h |   2 +
 include/net/ipv6.h        |   1 +
 net/ipv4/af_inet.c        |  46 ++++++----
 net/ipv6/af_inet6.c       |  10 ++-
 net/mptcp/pm_netlink.c    |  30 ++++---
 net/mptcp/protocol.c      | 177 +++++++++++++++++++-------------------
 net/mptcp/protocol.h      |  15 ++--
 net/mptcp/sockopt.c       |  65 +++++++-------
 8 files changed, 181 insertions(+), 165 deletions(-)

-- 
2.41.0

