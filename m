Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABC3184
	for <mptcp@lists.linux.dev>; Fri, 15 Apr 2022 10:46:23 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id e21so10223576wrc.8
        for <mptcp@lists.linux.dev>; Fri, 15 Apr 2022 03:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f6EwJIv5WdinK7ANFVBXH7fW4eXLa6wK1WP6i/QNT3g=;
        b=4VWZEV0gI0sJXU6TpOSemNrCWjGj8HHcf9SrgNmIn+j4orKFBzgcsU2oND+oX+uUA6
         8JvQEx/qTUHxNSv2jdAeca9Cuvs9wV2Cs17dHLUw5dJ0siv7KU0S9oBvWNqzl+qHpbP3
         2GxKZu2Z9Ot6ntCUE42EMdCT2XntZPHJkh5ipm/n4l+PBMEoXsC4Xx1anJGDLrrq69IH
         DfZZ7WdMzgZCT4LmLKmhTh1/OlFQL0NdaWAORt2zY3XExhLTrB7c8gCQQc5a91q7mNFF
         6D0b6FhmyWD1IBG1fWp2n2qFovdvYY7VxVuoj4DKHOyhCIFW2DLgtrQALP6PmRQQJVvW
         8QOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f6EwJIv5WdinK7ANFVBXH7fW4eXLa6wK1WP6i/QNT3g=;
        b=gfnytNJsgDAcTeyH5xY/rCjasXK/QXZZt9cbWSqKMIqN48dqZJNWqK0Ve1u0iUHESN
         TnZGx8I9BTAkxe0uAwmVBU+KXcreDWLVD2TDYvkLZ5/3c7ffASQZbMqQgOc4XrGHQXyT
         2fVSUYZS7+JJDZU1qeiQzQvS+II+hzi7sj5y8V5KLL9x78Hxm6HZsKm0j5cnVOCyGQAx
         VJFKgfpC4dpaZ2NWYfVPwBQcfhnLumTQeltl6ZToARXzJpCB7X1tCR7lMo0PI0Q7ZzWL
         8XCm8mvSMgQu6liRO5rSLkL4+YH8i1hb0MO5wRRMqZz4UZ6Me8MIKuOAoFuQmoiatG3k
         xILw==
X-Gm-Message-State: AOAM531NzjSzJiEdtr6JDxGJUfjSlOdpeKscLjqtPe6RPOK2WUCvv4JK
	/WGRO5VRGe4WmJSEPxNaOjlE4xOmtVceTOHi
X-Google-Smtp-Source: ABdhPJyx1zXlO7W3XBoPhdLiGZTfbY9UGCMdZQ0oGoBoUw17qxSJn5rCHxxlqHSbUu9Q9wKDm8TUCQ==
X-Received: by 2002:adf:fb0b:0:b0:205:dfbd:8601 with SMTP id c11-20020adffb0b000000b00205dfbd8601mr4934871wrr.527.1650019581837;
        Fri, 15 Apr 2022 03:46:21 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id l41-20020a05600c1d2900b0038ec7fcb979sm8704329wms.26.2022.04.15.03.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 03:46:21 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next] Squash to "mptcp: handle local addrs announced by userspace PMs"
Date: Fri, 15 Apr 2022 12:45:50 +0200
Message-Id: <20220415104550.1037339-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move mptcp_pm_addr_entry structure to protocol.h as this commit exports
a new function having a parameter using this structure.

This was causing the CI to complain about this commit (and the 2 next
ones). Fixing it here instead of modifying the CI not to complain about
that.

Note: compared to what Kishen did in commit "mptcp: netlink: Add
MPTCP_PM_CMD_ANNOUNCE", I moved the new structure with other mptcp_pm
ones.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    to be squashed in "mptcp: handle local addrs announced by userspace PMs"

 net/mptcp/pm_netlink.c | 8 --------
 net/mptcp/protocol.h   | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 92d47e8e8983..9d515c3e0b16 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -22,14 +22,6 @@ static struct genl_family mptcp_genl_family;
 
 static int pm_nl_pernet_id;
 
-struct mptcp_pm_addr_entry {
-	struct list_head	list;
-	struct mptcp_addr_info	addr;
-	u8			flags;
-	int			ifindex;
-	struct socket		*lsk;
-};
-
 struct mptcp_pm_add_entry {
 	struct list_head	list;
 	struct mptcp_addr_info	addr;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 40dabf9462a8..f41089e54555 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -229,6 +229,14 @@ struct mptcp_pm_data {
 	struct mptcp_rm_list rm_list_rx;
 };
 
+struct mptcp_pm_addr_entry {
+	struct list_head	list;
+	struct mptcp_addr_info	addr;
+	u8			flags;
+	int			ifindex;
+	struct socket		*lsk;
+};
+
 struct mptcp_data_frag {
 	struct list_head list;
 	u64 data_seq;
-- 
2.34.1

