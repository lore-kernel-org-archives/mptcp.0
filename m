Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874752C82
	for <mptcp@lists.linux.dev>; Fri, 19 Nov 2021 17:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1637341893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ewqttHNSUu4MXADPwSdcMLgleHd9rCii9NHDwbjtjFE=;
	b=BSEWDlt7PVKVEmpWjJvEfmiLQoLoU1lIiXgOj1hqdt+1yvNvBh1DcZk+4/vEHpZj3R3QlF
	aDsou4YDcdrzB2JEQOXAyNhzg310l0fLQQrfZP7DqESYvKDnaqbekBVtzppMnkwovmPzAE
	grkq2TsVoW+ziKKZFUxdzT/VoeOTaAg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-Go5Ldpd0MYS-lAoQPt-oRA-1; Fri, 19 Nov 2021 12:11:31 -0500
X-MC-Unique: Go5Ldpd0MYS-lAoQPt-oRA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3438910144E1
	for <mptcp@lists.linux.dev>; Fri, 19 Nov 2021 17:11:30 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.42])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 99AC95DAA5
	for <mptcp@lists.linux.dev>; Fri, 19 Nov 2021 17:11:29 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH iproute2-next v2] mptcp: add support for fullmesh flag
Date: Fri, 19 Nov 2021 18:11:24 +0100
Message-Id: <3cf6dedcf575552e4c28f153b5b59ba4ac606953.1637341866.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

The link kernel supports this endpoint flag since v5.15, let's
expose it to user-space. It allows creation on fullmesh topolgy
via MPTCP subflow.

Additionally update the related man-page, clarifying the behavior
of related options.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
 - included Mat's suggestions
 - extended ADD_ADDR_ACCEPTED_NR description
---
 ip/ipmptcp.c        |  3 ++-
 man/man8/ip-mptcp.8 | 61 ++++++++++++++++++++++++++++++++++-----------
 2 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 0f5b6e2d..433fa68d 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -31,7 +31,7 @@ static void usage(void)
 		"	ip mptcp limits show\n"
 		"	ip mptcp monitor\n"
 		"FLAG-LIST := [ FLAG-LIST ] FLAG\n"
-		"FLAG  := [ signal | subflow | backup ]\n");
+		"FLAG  := [ signal | subflow | backup | fullmesh ]\n");
 
 	exit(-1);
 }
@@ -53,6 +53,7 @@ static const struct {
 	{ "signal",		MPTCP_PM_ADDR_FLAG_SIGNAL },
 	{ "subflow",		MPTCP_PM_ADDR_FLAG_SUBFLOW },
 	{ "backup",		MPTCP_PM_ADDR_FLAG_BACKUP },
+	{ "fullmesh",		MPTCP_PM_ADDR_FLAG_FULLMESH },
 };
 
 static void print_mptcp_addr_flags(unsigned int flags)
diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index 22335b61..5a486ad1 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -53,6 +53,8 @@ ip-mptcp \- MPTCP path manager configuration
 .B subflow
 .RB "|"
 .B backup
+.RB "|"
+.B fullmesh
 .RB  "]"
 
 .ti -8
@@ -103,22 +105,41 @@ is a unique numeric identifier for the given endpoint
 
 .TP
 .BR signal
-the endpoint will be announced/signalled to each peer via an ADD_ADDR MPTCP
-sub-option
+The endpoint will be announced/signaled to each peer via an MPTCP ADD_ADDR
+sub-option. Upon reception of an ADD_ADDR sub-option, the peer can try to
+create additional subflows, see
+.BR ADD_ADDR_ACCEPTED_NR.
 
 .TP
 .BR subflow
-if additional subflow creation is allowed by MPTCP limits, the endpoint will
-be used as the source address to create an additional subflow after that
-the MPTCP connection is established.
+If additional subflow creation is allowed by the MPTCP limits, the MPTCP
+path manager will try to create an additional subflow using this endpoint
+as the source address after the MPTCP connection is established.
 
 .TP
 .BR backup
-the endpoint will be announced as a backup address, if this is a
-.BR signal
-endpoint, or the subflow will be created as a backup one if this is a
+If this is a
+.BR subflow
+endpoint, the subflows created using this endpoint will have the backup
+flag set during the connection process. This flag instructs the peer to
+only send data on a given subflow when all non-backup subflows are
+unavailable. This does not affect outgoing data, where subflow priority
+is determined by the backup/non-backup flag received from the peer
+
+.TP
+.BR fullmesh
+If this is a
+.BR subflow
+endpoint and additional subflow creation is allowed by the MPTCP limits,
+the MPTCP path manager will try to create an additional subflow for each
+known peer address, using this endpoint as the source address. This will
+occur after the MPTCP connection is established. If the peer did not
+announce any additional addresses using the MPTCP ADD_ADDR sub-option,
+this will behave the same as a plain
 .BR subflow
-endpoint
+endpoint. When the peer does announce addresses, each received ADD_ADDR
+sub-option will trigger creation of an additional subflow to generate a
+full mesh topology.
 
 .sp
 .PP
@@ -136,17 +157,29 @@ ip mptcp limits set	change the MPTCP subflow creation limits
 .IR SUBFLOW_NR
 specifies the maximum number of additional subflows allowed for each MPTCP
 connection. Additional subflows can be created due to: incoming accepted
-ADD_ADDR option, local
+ADD_ADDR sub-option, local
 .BR subflow
 endpoints, additional subflows started by the peer.
 
 .TP
 .IR ADD_ADDR_ACCEPTED_NR
-specifies the maximum number of ADD_ADDR suboptions accepted for each MPTCP
-connection. The MPTCP path manager will try to create a new subflow for
-each accepted ADD_ADDR option, respecting the
+specifies the maximum number of incoming ADD_ADDR sub-options accepted for
+each MPTCP connection. After receiving the specificed number of ADD_ADDR
+sub-options, any other incoming one will be ignored for the MPTCP connection
+lifetime. When and ADD_ADDR sub-option is accepted and there are no local
+.IR fullmesh
+endpoints, the MPTCP path manager will try to create a new subflow using the
+address in the ADD_ADDR sub-option as the destination address and a source
+address determined using local routing resolution.
+When 
+.IR fullmesh
+endpoints are available, the MPTCP path manager will try to create new subflows 
+using each 
+.IR fullmesh
+endpoint as a source address and the peer's ADD_ADDR address as the destination.
+In both cases the
 .IR SUBFLOW_NR
-limit.
+limit is enforced.
 
 .sp
 .PP
-- 
2.33.1

