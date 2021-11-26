Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF3E2C81
	for <mptcp@lists.linux.dev>; Fri, 26 Nov 2021 09:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1637919540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=22uKMLk5ru8NiCA69I+UkGT3TFshywp6xMNN2oiEOIg=;
	b=DIiRLC5yd3i2HT/QZejyax4/aSZFSOPJFdTmrjOHlx+OVfMUvRuuDzyb6pM7I88WcpgNu3
	qx9J/di2bNV3TG82HWsLznR77UTWm820eFWRi9PknopqjJNDvIis01pvBlSCRnZqk/nV5A
	mQmNeguMLah1cUf1KRiO9zZsrDTX3KE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-FNKZuNjEPw6rR4xEbddnag-1; Fri, 26 Nov 2021 04:38:57 -0500
X-MC-Unique: FNKZuNjEPw6rR4xEbddnag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70493874981;
	Fri, 26 Nov 2021 09:38:56 +0000 (UTC)
Received: from dcaratti.station (unknown [10.40.194.151])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6CAB55F4F7;
	Fri, 26 Nov 2021 09:38:55 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH iproute2-next] mptcp: add support for changing the backup flag
Date: Fri, 26 Nov 2021 10:38:18 +0100
Message-Id: <c63ef7fb7a391f88af7ded03c1e0cb21e38472f0.1637918976.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dcaratti@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"

allow setting / clearing the 'backup' bit on existing endpoints.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/158
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 ip/ipmptcp.c        | 20 ++++++++++++++++----
 man/man8/ip-mptcp.8 | 16 +++++++++++++++-
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index 0f5b6e2d08ba..bae27c3e8c6a 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -25,6 +25,7 @@ static void usage(void)
 		"Usage:	ip mptcp endpoint add ADDRESS [ dev NAME ] [ id ID ]\n"
 		"				      [ port NR ] [ FLAG-LIST ]\n"
 		"	ip mptcp endpoint delete id ID\n"
+		"	ip mptcp endpoint change id ID [ backup | nobackup ]\n"
 		"	ip mptcp endpoint show [ id ID ]\n"
 		"	ip mptcp endpoint flush\n"
 		"	ip mptcp limits set [ subflows NR ] [ add_addr_accepted NR ]\n"
@@ -45,6 +46,8 @@ static int genl_family = -1;
 	GENL_REQUEST(_req, MPTCP_BUFLEN, genl_family, 0,	\
 		     MPTCP_PM_VER, _cmd, _flags)
 
+#define MPTCP_PM_ADDR_FLAG_NOBACKUP 0x0
+
 /* Mapping from argument to address flag mask */
 static const struct {
 	const char *name;
@@ -53,6 +56,7 @@ static const struct {
 	{ "signal",		MPTCP_PM_ADDR_FLAG_SIGNAL },
 	{ "subflow",		MPTCP_PM_ADDR_FLAG_SUBFLOW },
 	{ "backup",		MPTCP_PM_ADDR_FLAG_BACKUP },
+	{ "nobackup",		MPTCP_PM_ADDR_FLAG_NOBACKUP }
 };
 
 static void print_mptcp_addr_flags(unsigned int flags)
@@ -95,9 +99,9 @@ static int get_flags(const char *arg, __u32 *flags)
 	return -1;
 }
 
-static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n,
-			 bool adding)
+static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n, int cmd)
 {
+	bool adding = cmd == MPTCP_PM_CMD_ADD_ADDR;
 	struct rtattr *attr_addr;
 	bool addr_set = false;
 	inet_prefix address;
@@ -110,6 +114,11 @@ static int mptcp_parse_opt(int argc, char **argv, struct nlmsghdr *n,
 	ll_init_map(&rth);
 	while (argc > 0) {
 		if (get_flags(*argv, &flags) == 0) {
+			/* allow changing the 'backup' flag only */
+			if (cmd == MPTCP_PM_CMD_SET_FLAGS &&
+			    (flags & ~MPTCP_PM_ADDR_FLAG_BACKUP))
+				invarg("invalid flags\n", *argv);
+
 		} else if (matches(*argv, "id") == 0) {
 			NEXT_ARG();
 
@@ -182,7 +191,7 @@ static int mptcp_addr_modify(int argc, char **argv, int cmd)
 	MPTCP_REQUEST(req, cmd, NLM_F_REQUEST);
 	int ret;
 
-	ret = mptcp_parse_opt(argc, argv, &req.n, cmd == MPTCP_PM_CMD_ADD_ADDR);
+	ret = mptcp_parse_opt(argc, argv, &req.n, cmd);
 	if (ret)
 		return ret;
 
@@ -298,7 +307,7 @@ static int mptcp_addr_show(int argc, char **argv)
 	if (argc <= 0)
 		return mptcp_addr_dump();
 
-	ret = mptcp_parse_opt(argc, argv, &req.n, false);
+	ret = mptcp_parse_opt(argc, argv, &req.n, MPTCP_PM_CMD_GET_ADDR);
 	if (ret)
 		return ret;
 
@@ -530,6 +539,9 @@ int do_mptcp(int argc, char **argv)
 		if (matches(*argv, "add") == 0)
 			return mptcp_addr_modify(argc-1, argv+1,
 						 MPTCP_PM_CMD_ADD_ADDR);
+		if (matches(*argv, "change") == 0)
+			return mptcp_addr_modify(argc-1, argv+1,
+						 MPTCP_PM_CMD_SET_FLAGS);
 		if (matches(*argv, "delete") == 0)
 			return mptcp_addr_modify(argc-1, argv+1,
 						 MPTCP_PM_CMD_DEL_ADDR);
diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index 22335b6129ae..6e7f8269a4f8 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -34,6 +34,13 @@ ip-mptcp \- MPTCP path manager configuration
 .BR "ip mptcp endpoint del id "
 .I ID
 
+.ti -8
+.BR "ip mptcp endpoint change id "
+.I ID
+.RB "[ "
+.I BACKUP-OPT
+.RB "] "
+
 .ti -8
 .BR "ip mptcp endpoint show "
 .RB "[ " id
@@ -55,6 +62,13 @@ ip-mptcp \- MPTCP path manager configuration
 .B backup
 .RB  "]"
 
+.ti -8
+.IR BACKUP-OPT " := ["
+.B backup
+.RB "|"
+.B nobackup
+.RB  "]"
+
 .ti -8
 .BR "ip mptcp limits set "
 .RB "[ "
@@ -118,7 +132,7 @@ the endpoint will be announced as a backup address, if this is a
 .BR signal
 endpoint, or the subflow will be created as a backup one if this is a
 .BR subflow
-endpoint
+endpoint.
 
 .sp
 .PP
-- 
2.31.1

