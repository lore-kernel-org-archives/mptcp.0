Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FCD72
	for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 11:20:17 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id s15so73761721edd.4
        for <mptcp@lists.linux.dev>; Wed, 28 Apr 2021 04:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=APNa8DhB0fLhS7Eu5J+mPPrOhvuvA3ruUrRrJII3Ukg=;
        b=G5fGYhU9QZrZem8wjo9oJ7fZe4Hlmu/rAW8pMolqdd3aCOK7zLa5LD0FdZRyoj2Zuq
         S45rUjk5RJhWS624lrSmfgJf6+96ZenwxBg/2dkEpNYa54bRtAUfXHODX/bg6E5qWSzV
         Mr+IpqtVYh/vVP5mSkadlePbcXGD2uedDOKb5BwYBTvM12+FHbjyOlRK9HIow8CxYmaU
         1M78PzVdZgcqq/Sz/E2cxXydbKKyCcI+uhPfgP0sSGA+JCVfHF+AyF3QBrRgUoRJNwf0
         wWMZBziui6MsdHZR9y2nG+Zc3EkJtcpCCxkudcjYmuTTCudhDKLJhMfQAl7DLXJKjTZG
         m0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=APNa8DhB0fLhS7Eu5J+mPPrOhvuvA3ruUrRrJII3Ukg=;
        b=eNCnCTT9/mlCQimtufOO3OCjuPVTqGmyLbV17V07UfAtCVRoUySpm3eFt+BCYTLvwi
         UVnxh0ozr8eyeRnfEC6EjsHInVHE53z7MfDIcMnUvjGeDGkbcY/hNfbFXOLs4Vm0dECU
         o3Vxezk7Wg87vug7AEuWJxo4W3Lo2+vD/VIRfhb5Khyfr69NP5GVFIochPG/gPaGNsDD
         Dl4oZpxX4oVSc3GRliYqXEJolTe+rjB+ofSvUNIMNqwpXTfoDmMYWuAHYJXq5Zlu8/iy
         bGFEdvAeokpkNcD2lyocsOQSfSH3oV/jvN11+tDnqebJKB2xQ9wQDLBSlXpwfGGyzWLG
         q5oA==
X-Gm-Message-State: AOAM533QuuTvVKY8G1C1d3BWZXJ4BYMqh7htv1XfWtPn5galVYpYoiB/
	zLcpK2uXMvn96xnArMzZbvKACIUxLswHTMm4
X-Google-Smtp-Source: ABdhPJzjAyQP9Mnn9g6ZIr5tRCB0frDUVFPoH+5oPgEKK+Vc1MjqtUr0NZ5d3n3d74zzqTYL35UHew==
X-Received: by 2002:a05:6402:4390:: with SMTP id o16mr10438814edc.14.1619608816079;
        Wed, 28 Apr 2021 04:20:16 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id l3sm4787627edr.2.2021.04.28.04.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 04:20:15 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH mptcp-next] mptcp: restrict values of 'enabled' sysctl
Date: Wed, 28 Apr 2021 13:17:37 +0200
Message-Id: <20210428111737.3611480-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.30.2
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To avoid confusions, it seems better to parse this sysctl parameter as a
boolean. We use it as a boolean, no need to parse an integer and bring
confusions if we see a value different from 0 and 1, especially with
this parameter name: enabled.

It seems fine to do this modification because the default value is 1
(enabled). Then the only other interesting value to set is 0 (disabled).
All other values would not have changed the default behaviour.

Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 Documentation/networking/mptcp-sysctl.rst | 8 ++++----
 net/mptcp/ctrl.c                          | 8 +++++---
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/mptcp-sysctl.rst b/Documentation/networking/mptcp-sysctl.rst
index 6af0196c4297..3b352e5f6300 100644
--- a/Documentation/networking/mptcp-sysctl.rst
+++ b/Documentation/networking/mptcp-sysctl.rst
@@ -7,13 +7,13 @@ MPTCP Sysfs variables
 /proc/sys/net/mptcp/* Variables
 ===============================
 
-enabled - INTEGER
+enabled - BOOLEAN
 	Control whether MPTCP sockets can be created.
 
-	MPTCP sockets can be created if the value is nonzero. This is
-	a per-namespace sysctl.
+	MPTCP sockets can be created if the value is 1. This is a
+	per-namespace sysctl.
 
-	Default: 1
+	Default: 1 (enabled)
 
 add_addr_timeout - INTEGER (seconds)
 	Set the timeout after which an ADD_ADDR control message will be
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 96ba616f59bf..08c152199b89 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -17,7 +17,7 @@ static int mptcp_pernet_id;
 struct mptcp_pernet {
 	struct ctl_table_header *ctl_table_hdr;
 
-	int mptcp_enabled;
+	u8 mptcp_enabled;
 	unsigned int add_addr_timeout;
 };
 
@@ -39,12 +39,14 @@ unsigned int mptcp_get_add_addr_timeout(struct net *net)
 static struct ctl_table mptcp_sysctl_table[] = {
 	{
 		.procname = "enabled",
-		.maxlen = sizeof(int),
+		.maxlen = sizeof(u8),
 		.mode = 0644,
 		/* users with CAP_NET_ADMIN or root (not and) can change this
 		 * value, same as other sysctl or the 'net' tree.
 		 */
-		.proc_handler = proc_dointvec,
+		.proc_handler = proc_dou8vec_minmax,
+		.extra1       = SYSCTL_ZERO,
+		.extra2       = SYSCTL_ONE
 	},
 	{
 		.procname = "add_addr_timeout",
-- 
2.30.2

