Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B76A2FB7
	for <mptcp@lists.linux.dev>; Wed, 26 May 2021 16:08:42 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id z12so3359310ejw.0
        for <mptcp@lists.linux.dev>; Wed, 26 May 2021 09:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QzEaCbME0vL9z8gysu4UW6QXI9jijCA3f0/m/3S1jQs=;
        b=lFVOQRy+bYgHck7LFcmy3inTf8GKB+n260XeChzfOsIPBSSKR0zL+4/al1temjRhjL
         SggE+3Gtltg3ELHxj2zbconSS59WSdlW5ONt+WTvjKuN3RMQcSPBGqbqP0cKphim6Wcy
         Uu8+AzV9uPsHqr/UH2frIjV/UmgfYKxM/uTqpzqtDBHKGJwfs8p8P6BLhfGFBLPa7DzX
         4Y5mlJWwZLTgQcWPlBBIwETFHcmTkmO5McW35QZUX65yji+iWc2ang0SIoK0JCXYxQ6I
         m6mTOjsOO9t3av0c1ocqWYpyl1FYCfTnCfvtGs6ukFg3w+EGG9GRyZUrvyXwbYpfZgPs
         uX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QzEaCbME0vL9z8gysu4UW6QXI9jijCA3f0/m/3S1jQs=;
        b=sQJj2lV5cE2N2ylugXiFpl+k4q1aQ1HFljz5Y90PQj1M97ZsGfJaKcMi2TtJVv3Akk
         +9XNkRlDrVYdw1EgFH+KlKyitGxKIySgu72upuoJ/41rx5/baC7aDQNn73EaPq5E6TGG
         PO9DfDaw0pZyrDIAH0RpcnkzYdPDEOv6lhlnOHrsgmbhW/miQQKsJOdcmzWO2vBLVlFO
         M61KoRppRk/I+xrgLFJGsnA/el+zCj9g6KutR7dCiF/FbgmE7XizSdw6aCQdUlqYFqds
         s/ZP0abUvCiHO9EWr5lLEtUh6U39ukUNgYYj02Lup8dzEj1UqksgelHbIVzSodw+m1mg
         VyCw==
X-Gm-Message-State: AOAM532DHMlkg1/gBXkRsIZ/eYyMeAftwCjU1MoSZIqFCk+fQknbk5Cl
	UFm8e0RTwXdtF1hUNj6I7R5TZrdVBtVLE30H
X-Google-Smtp-Source: ABdhPJwUp8tT6bN6w//rje319mlj2Ia097KODFZNmsNztKmsd/qWC8FXZNmS7LcBIzNJlUcB1rVRAg==
X-Received: by 2002:a17:906:aac8:: with SMTP id kt8mr33476733ejb.402.1622045320613;
        Wed, 26 May 2021 09:08:40 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id j7sm931655ejk.51.2021.05.26.09.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 09:08:40 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [RESEND] [MPTCP][PATCH mptcp-next 3/3] mptcp: send out MP_FAIL when data checksum fail
Date: Wed, 26 May 2021 18:08:13 +0200
Message-ID: <f46dabaf1055b87b5613b126372d9e506c178264.1620282930.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210526160813.4160315-1-matthieu.baerts@tessares.net>
References: <20210526160813.4160315-1-matthieu.baerts@tessares.net>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20210526160813.L4l1DzKShRoGq0ToaN7HN8-Qkz3M01gh0eYSeqKMCtQ@z>

From: Geliang Tang <geliangtang@gmail.com>

When a bad checksum is detected, send out the MP_FAIL suboption.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/subflow.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 659b8842ae3b..efd84ff61015 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -906,6 +906,8 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
 	csum = csum_partial(&header, sizeof(header), subflow->map_data_csum);
 	if (unlikely(csum_fold(csum))) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DSSCSUMERR);
+		subflow->send_mp_fail = 1;
+		subflow->fail_seq = subflow->map_seq;
 		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
 	}
 
