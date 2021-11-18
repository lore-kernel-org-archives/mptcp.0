Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D8B68
	for <mptcp@lists.linux.dev>; Thu, 18 Nov 2021 12:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1637238696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6w3oL6uqLGyeAGEohe6FtRqd8YJ/NkldKwZz64ohDHk=;
	b=ca8SaIbOOF5UAXfTdGsB+lSbydaCEYM/GTjx7T5RbU9spJlXfscq1i2W3BovxtS7Osnlyp
	3rtX/waHcR886y7bzw2jug5VRRLrwzDjseezDbmFUP4+JrhGYpTYssEs6Z2JFXl1CODspS
	kSjhbRjf0czQatwV3GJJACGEnihjgbM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-_xh_oI2LMpaZwkMDmbFWpg-1; Thu, 18 Nov 2021 07:31:35 -0500
X-MC-Unique: _xh_oI2LMpaZwkMDmbFWpg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3029310168F4
	for <mptcp@lists.linux.dev>; Thu, 18 Nov 2021 12:31:34 +0000 (UTC)
Received: from gerbillo.fritz.box (unknown [10.39.194.63])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8D982608BA
	for <mptcp@lists.linux.dev>; Thu, 18 Nov 2021 12:31:33 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH iproute2-next] mptcp: add support for fullmesh flag
Date: Thu, 18 Nov 2021 13:31:15 +0100
Message-Id: <e82f1c57baf4bab35018177cf82de224655fcb8b.1637238533.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
notes:
- currently sent only to mptcp ML, looking for "editorial" reviews :)
- as a side doc-update effect, this could possibly close issue/237

---
 ip/ipmptcp.c        |  3 ++-
 man/man8/ip-mptcp.8 | 47 ++++++++++++++++++++++++++++++++++-----------
 2 files changed, 38 insertions(+), 12 deletions(-)

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
index 22335b61..367ecc64 100644
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
@@ -103,22 +105,36 @@ is a unique numeric identifier for the given endpoint
 
 .TP
 .BR signal
-the endpoint will be announced/signalled to each peer via an ADD_ADDR MPTCP
-sub-option
+the endpoint will be announced/signaled to each peer via an ADD_ADDR MPTCP
+sub-option. Upon reception of an ADD_ADDR option, the peer can try to create
+additional subflows, see
+.BR ADD_ADDR_ACCEPTED_NR.
 
 .TP
 .BR subflow
-if additional subflow creation is allowed by MPTCP limits, the endpoint will
-be used as the source address to create an additional subflow after that
-the MPTCP connection is established.
+if additional subflow creation is allowed by MPTCP limits, after that the
+MPTCP connection is established, the MPTCP path manager will try to create
+an additional subflow using this endpoint as the source address.
 
 .TP
 .BR backup
-the endpoint will be announced as a backup address, if this is a
-.BR signal
-endpoint, or the subflow will be created as a backup one if this is a
+if this is a
+.BR subflow
+endpoint, the subflows created using this endpoint will be backup ones.
+Backup subflows are used only when all non-backup subflows are unavailable.
+
+.TP
+.BR fullmesh
+if this is a
+.BR subflow
+endpoint, if additional subflow creation is allowed by MPTCP limits, after that the
+each MPTCP connection is established, the MPTCP path manager will try to create
+an additional subflow for each known server address using this endpoint as
+the source address. If the peer did not announce any additional address via
+ADD_ADDR MPTCP sub-option, this has no additional effect compared to a plain
 .BR subflow
-endpoint
+endpoint. Otherwise, this will create an additional subflow for each received
+ADD_ADDR, generating a fullmesh topology.
 
 .sp
 .PP
@@ -143,8 +159,17 @@ endpoints, additional subflows started by the peer.
 .TP
 .IR ADD_ADDR_ACCEPTED_NR
 specifies the maximum number of ADD_ADDR suboptions accepted for each MPTCP
-connection. The MPTCP path manager will try to create a new subflow for
-each accepted ADD_ADDR option, respecting the
+connection. When and ADD_ADDR suboption is accepted, if there are no local
+.BR fullmesh
+endpoint, the MPTCP path manager will try to create a new subflow towards the
+address specified by the ADD_ADDR option, using as source the local address
+obtained by the routing resolution. Otherwise, the MPTCP path manager will try
+to create a new subflow for each
+.BR fullmesh
+endpoint, using the fullmesh endpoint as the source address and the address
+specified by the ADD_ADDR option as the destination. In both cases the MPTCP
+path manager enforces
+the
 .IR SUBFLOW_NR
 limit.
 
-- 
2.33.1

