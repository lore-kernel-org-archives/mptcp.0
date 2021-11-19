Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5372A2C82
	for <mptcp@lists.linux.dev>; Fri, 19 Nov 2021 17:13:26 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so8030600wme.4
        for <mptcp@lists.linux.dev>; Fri, 19 Nov 2021 09:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CdoRGe7QzQf4GJF65efRVKXx9/UiDMH6cLZkmHp5PPI=;
        b=i6R61xy9qHvj/D2h6PLKRVNoOeV9/27r6zOg0+RtPWV2INlRoO3nmN8CdmwBw9lLhX
         m/2Hqw4Qm/8FyTQb2sfdV3DVHMYnIl5llNSJWPyTWU561Rub61u5D8xXovjsNV+iDj5n
         KavXmTbso0QV+hcF3U/qnm+McPQcrNhwFGn3YqaLmxb7c+fRvrQJYd4KuiEu8igBniha
         nHgkKYZxpMDvT+3KwGMlkFDwelnPlqXaUjwVxdjE+GN2W4DZ3SzqrZEpJqc8dDtLFJ7h
         /vie1PGj0xPch3leJHo4MkXUI/ksvFk5G2icC9TDFdCp1KBoSlW1cGXoCPDNgnBhz4Le
         syvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CdoRGe7QzQf4GJF65efRVKXx9/UiDMH6cLZkmHp5PPI=;
        b=CE00IOnU/di1S39bzCOWKeacP2edAlS6aSgDgW6aqlr3priyfpFCFM0dnBKxURSQ2T
         E18RtqcCdmmigz7WUQS+dtP2OQd5rrFCT3x2V03c8yTQ3a5ggU57kbry03FYOi0nKLL0
         LUc/cKj/2fa19QCrFOR4NClDFkYbY1OEQLiftRsR3mdlMoXazyocXwjjvi64Orao41P4
         JA1yfy4AxXkyPkPCDo8RhdolMNYt+IyqRI9we4e5MKgX48LbXU3IkT/rN1V8m2u0IPiv
         GLILG151VCzL+c59SbENGe834gD8drammI8qllNmU24YktCHPWw7RxsPANN3LtzaFOJK
         oUKQ==
X-Gm-Message-State: AOAM533e2XVG0RWo8BQtpSbxKSMoimsKMo12sorLzFLFJv5c39wTnvh/
	jHj8dQUEjRY1QnirhYAiYk+fqKbKY4CuGgTQ
X-Google-Smtp-Source: ABdhPJw2ikVit45WUjZZ/eHcyvXV0ByEgo0vpAvai7cdHA1anjOkD59xUkQ6zyvwVECN1Mr6YyDh5Q==
X-Received: by 2002:a1c:1d48:: with SMTP id d69mr1395411wmd.143.1637342004502;
        Fri, 19 Nov 2021 09:13:24 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id q8sm285882wrx.71.2021.11.19.09.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 09:13:24 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next] Squash to "mptcp: add TCP_INQ cmsg support"
Date: Fri, 19 Nov 2021 18:13:04 +0100
Message-Id: <20211119171304.4028221-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can remove this old comment now that its support has been added.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    to be squashed in "mptcp: add TCP_INQ cmsg support"

 net/mptcp/sockopt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 0295d6d9207e..11cda8629993 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -569,7 +569,6 @@ static bool mptcp_supported_sockopt(int level, int optname)
 		/* TCP_FASTOPEN_KEY, TCP_FASTOPEN TCP_FASTOPEN_CONNECT, TCP_FASTOPEN_NO_COOKIE,
 		 * are not supported fastopen is currently unsupported
 		 */
-		/* TCP_INQ is currently unsupported, needs some recvmsg work */
 	}
 	return false;
 }
-- 
2.32.0

