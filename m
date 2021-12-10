Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26878173
	for <mptcp@lists.linux.dev>; Fri, 10 Dec 2021 23:24:41 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id x10so17155800edd.5
        for <mptcp@lists.linux.dev>; Fri, 10 Dec 2021 15:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k5S3SUj/OOI4UqpRFOWJDCv9zSY6mlat8akj1K847Q8=;
        b=PJxPjQ1kg5qZxmutioMQSWj47Awen0cDzIJxWT8LgGU1FNEcZ4o3WCuboVzD+KEseG
         MigJKeI5ugbFbjmqXQC+YGPB7JGk/bHbo+E47at3EycIY7YFPDQsp+YCfHGKsotsIsqb
         JrmBRXFM6B79Kil2oKikHtc43Bzh93ydcAqOh7UGdQrMTlLKflBLOz7P0ocAxM7XrsE4
         w5yvAMqNUH1jxsYG/xWNZQhmE90fLX4WWut5Z7UwfKik7oIq00LYvbT6yvnoDYXHS6E4
         13EDIRGVibVUz5nlakAoGW/vLiSwpuHlI7DKeulDxxESXIJ9iuOwc7xLCu9LPgaOtm39
         RREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k5S3SUj/OOI4UqpRFOWJDCv9zSY6mlat8akj1K847Q8=;
        b=A2cdmgrMtiLximwRhTBFyC4z5h8+TscebezcarxfTkPAJ7b81Mos6pn36Mj/wtCfoi
         kxfqmGKOwNAS0v0irFRUArdcBE7Ed6sd6gAJ1os/90stikfgYNseUgA8vY6gPnNQDaD1
         jNvEb2Rls7MhRZ+bcumWamoSW4BG6PdJyEGpA16f30cUVTtX2i3LrSdMQ+qsXWXBqqgq
         OXJbx8l1gZ/dpLfWqvVHwgDk8B5MJa4Gp8yho6PCcKLEqCrAcnpZwJYZCj35M4bpDujs
         RgCeDNTXKpca4AjU0j7iQ1JIv9nTbJE+fIi6vCtFILMRH6NVlSseXy+R8jdUGKJCG3h4
         jL/A==
X-Gm-Message-State: AOAM5319s1eSFQpqWN8wCewkm9BlFOMbzBbsCcRmGItYpyHaVJnzt6Ld
	+YlsYUBHHGB2ab2tE05/9ntvEGc1gRs=
X-Google-Smtp-Source: ABdhPJxqWUvHrayF51mlf3nfBss88hzhsLfoXM5b8OEIsc8i+IRGRa741qgQqV4qcd150Vek18Mkdw==
X-Received: by 2002:a50:e0c9:: with SMTP id j9mr43434321edl.336.1639178679481;
        Fri, 10 Dec 2021 15:24:39 -0800 (PST)
Received: from localhost ([185.220.101.166])
        by smtp.gmail.com with ESMTPSA id n16sm2039423edt.67.2021.12.10.15.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 15:24:39 -0800 (PST)
From: =?UTF-8?q?J=CE=B5an=20Sacren?= <sakiwit@gmail.com>
To: mathew.j.martineau@linux.intel.com,
	matthieu.baerts@tessares.net,
	mptcp@lists.linux.dev
Subject: [PATCH v2 net-next] net: mptcp: clean up harmless false expressions
Date: Fri, 10 Dec 2021 16:24:36 -0700
Message-Id: <20211210230245.342764-1-sakiwit@gmail.com>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jean Sacren <sakiwit@gmail.com>

entry->addr.id is u8 with a range from 0 to 255 and MAX_ADDR_ID is 255.
We should drop both false expressions of (entry->addr.id > MAX_ADDR_ID).

We should also remove the obsolete parentheses in the first if branch.

Use U8_MAX for MAX_ADDR_ID and add a comment to show the link to
mptcp_addr_info.id as suggested by Mr. Matthieu Baerts.

Signed-off-by: Jean Sacren <sakiwit@gmail.com>
---
v2:
(1) Use U8_MAX for MAX_ADDR_ID.
(2) Add a comment for link to mptcp_addr_info.id.
    Thank you, Mr. Matthieu Baerts!
 net/mptcp/pm_netlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 4ff8d55cbe82..35cc4c64c06c 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -38,7 +38,8 @@ struct mptcp_pm_add_entry {
 	u8			retrans_times;
 };
 
-#define MAX_ADDR_ID		255
+/* max value of mptcp_addr_info.id */
+#define MAX_ADDR_ID		U8_MAX
 #define BITMAP_SZ DIV_ROUND_UP(MAX_ADDR_ID + 1, BITS_PER_LONG)
 
 struct pm_nl_pernet {
@@ -822,14 +823,13 @@ static int mptcp_pm_nl_append_new_local_addr(struct pm_nl_pernet *pernet,
 		entry->addr.id = find_next_zero_bit(pernet->id_bitmap,
 						    MAX_ADDR_ID + 1,
 						    pernet->next_id);
-		if ((!entry->addr.id || entry->addr.id > MAX_ADDR_ID) &&
-		    pernet->next_id != 1) {
+		if (!entry->addr.id && pernet->next_id != 1) {
 			pernet->next_id = 1;
 			goto find_next;
 		}
 	}
 
-	if (!entry->addr.id || entry->addr.id > MAX_ADDR_ID)
+	if (!entry->addr.id)
 		goto out;
 
 	__set_bit(entry->addr.id, pernet->id_bitmap);
