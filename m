Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D53AD38
	for <mptcp@lists.linux.dev>; Wed,  4 Jan 2023 15:09:28 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id l29so41893841edj.7
        for <mptcp@lists.linux.dev>; Wed, 04 Jan 2023 07:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T4D+o1PYyq71nSRP7PWoiW3VityPEOHMKSKWgajxf78=;
        b=mRixDFtFkx1NkNGymn3uKPsi0IDheJAFktETTDsR28OaUlvjc988cWQJd+xYVL5rJr
         bdb+5THjB07Wfq101kbmMwCWeMnk/aanG4N2NF7+CUQ7vM0PoD83Jas5EgsVjgxJ1GBy
         gU2Lk068Am7sVeMkpY0SuzQdwp88Zxc7P+7yAKodYfhrVEoKBk6kH+kH16XtTRc7PkWt
         myD51ohK1muPQfcghasHYdS5e1zejbtdyowH4D6rN+t58xCkurV9L+QcNEPSeytfo0do
         kmSmZjSInCmePTvNHqjrFW9tNNPXKnJvXCIDhJd2w6csSlQNwLci0Pl7EfQktK7WKzW+
         8Sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4D+o1PYyq71nSRP7PWoiW3VityPEOHMKSKWgajxf78=;
        b=74G2kDqsRvKAb8Cv+6t8gY6Jv4x6ZuZlXlom70QH4jpQC/d3B90b623YHP0q3kYrWh
         l+3b+pWYw4b50wr6813DGR8Kg2Gl61dAsKn88cq7T99oRPpm4t81SW8M9bxxV0dj4Tm/
         AgBX2dBzfTG6kJS/akuSNv5PscgfgVCPP4n3YusC6XZPQW9HoRzJfcWZMQAR2+x9pmRa
         ACRUYzepiQYob/sVPnHxURBBQ+VBz4Djdyl7WNKiGH5cjfCkfJ9Glm909uO8QQ2HlvaG
         XELePJoU33nyqXuCRO8Id4QbhtmTKqsISJiB1k2Wf5DP+TQnYakuTUoQzXTYm2qpJcc1
         AEsQ==
X-Gm-Message-State: AFqh2koO1OMylsZfuHHwZJdr5ZA7RhRcGFiVtsYXcT06V+7FtY6iMRQP
	sR7K29ueFJa95yGRQiCsh6Lw1Tcj3PfTaqHHXJw=
X-Google-Smtp-Source: AMrXdXsKNXG91FqDdErJTJftY+w9Ej/9HZi3m6nbS/acF9NtyB84f55vpu6MrlVBEsynLtQtrFSc5A==
X-Received: by 2002:aa7:d893:0:b0:47f:ab65:b3fe with SMTP id u19-20020aa7d893000000b0047fab65b3femr34994463edq.33.1672844966299;
        Wed, 04 Jan 2023 07:09:26 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id v6-20020aa7d9c6000000b00487e4d93863sm9156298eds.22.2023.01.04.07.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 07:09:25 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Geliang Tang <geliang.tang@suse.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>
Subject: [PATCH mptcp-iproute2-net v2] mptcp: add new listener events
Date: Wed,  4 Jan 2023 16:09:09 +0100
Message-Id: <20230104150909.1238738-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These new events have been added in kernel commit f8c9dfbd875b ("mptcp:
add pm listener events") by Geliang Tang.

Two new MPTCP Netlink event types for PM listening socket creation and
closure have been recently added. They will be available in the future
v6.2 kernel.

They have been added because MPTCP for Linux, when not using the
in-kernel PM, depends on the userspace PM to create extra listening
sockets -- called "PM listeners" -- before announcing addresses and
ports. With the existing MPTCP Netlink events, a userspace PM can create
PM listeners at startup time, or in response to an incoming connection.
Creating sockets in response to connections is not optimal: ADD_ADDRs
can't be sent until the sockets are created and listen()ed, and if all
connections are closed then it may not be clear to the userspace PM
daemon that PM listener sockets should be cleaned up. Hence these new
events: PM listening sockets can be managed based on application
activity.

Note that the maximum event string size has to be increased by 2 to be
able to display LISTENER_CREATED without trunking it.

Also, as pointed by Mat, this event doesn't have any "token" attribute
so this attribute is now printed only if it is available.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/313
Cc: Geliang Tang <geliang.tang@suse.com>
Cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    v1 -> v2:
      - print LISTENER_* instead of LISTEN_* and increase the limit to 16
        chars (Mat)
      - check if the TOKEN attribute is available before printing it (Mat)
      - edit the commit message to reflect the modifications from v2

 ip/ipmptcp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/ip/ipmptcp.c b/ip/ipmptcp.c
index ce62ab9a..beba7a41 100644
--- a/ip/ipmptcp.c
+++ b/ip/ipmptcp.c
@@ -454,6 +454,8 @@ static const char * const event_to_str[] = {
 	[MPTCP_EVENT_SUB_ESTABLISHED] = "SF_ESTABLISHED",
 	[MPTCP_EVENT_SUB_CLOSED] = "SF_CLOSED",
 	[MPTCP_EVENT_SUB_PRIORITY] = "SF_PRIO",
+	[MPTCP_EVENT_LISTENER_CREATED] = "LISTENER_CREATED",
+	[MPTCP_EVENT_LISTENER_CLOSED] = "LISTENER_CLOSED",
 };
 
 static void print_addr(const char *key, int af, struct rtattr *value)
@@ -492,11 +494,12 @@ static int mptcp_monitor_msg(struct rtnl_ctrl_data *ctrl,
 		goto out;
 	}
 
-	printf("[%14s]", event_to_str[ghdr->cmd]);
+	printf("[%16s]", event_to_str[ghdr->cmd]);
 
 	parse_rtattr(tb, MPTCP_ATTR_MAX, (void *) ghdr + GENL_HDRLEN, len);
 
-	printf(" token=%08x", rta_getattr_u32(tb[MPTCP_ATTR_TOKEN]));
+	if (tb[MPTCP_ATTR_TOKEN])
+		printf(" token=%08x", rta_getattr_u32(tb[MPTCP_ATTR_TOKEN]));
 
 	if (tb[MPTCP_ATTR_REM_ID])
 		printf(" remid=%u", rta_getattr_u8(tb[MPTCP_ATTR_REM_ID]));

base-commit: d0e02f35af33b8957cc9f52af07b0b81d557ad3b
-- 
2.37.2

