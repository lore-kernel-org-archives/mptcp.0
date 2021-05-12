Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC26D71
	for <mptcp@lists.linux.dev>; Wed, 12 May 2021 04:16:59 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id a11so11868135plh.3
        for <mptcp@lists.linux.dev>; Tue, 11 May 2021 21:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Jv0zqlNJi4uNNhhWUAM/LvCK7bMnYSBvAzGporKkTg=;
        b=A6DzXkS29rIsK//xstlabwItwxAPeNiLNxburT0eDtAKnFwxtktsS2K5cskAgxONaK
         +yFK5owOfefWlppG/qwXLhRLfgv4JahTYcOvIwcYY3ztPJobs6dDPfBbHScaAj6KVYD2
         pA9VyZkI9yGrBkhvak3HbbvrPW8672M0YHltt6MQyZa06RKtE4lQd0bJByG967bBUcHZ
         1NvWHXR9MGnN9HyUlbFWCUGA78xKsqS3h8Mg2a8WdE7XmTJp8VPxSeJV71XX5twiMw0d
         NwIeaZkyixC0TU7XuU+hUibERdIi+okG/hFwRhNn/7MwQSQ6dyzyUuB1JqnOuPI99DLN
         Ee9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Jv0zqlNJi4uNNhhWUAM/LvCK7bMnYSBvAzGporKkTg=;
        b=LVwpowPw29UdB/BWhnS93E/pI4gZyCt8E8s2nCDJAZoLgVNmgBJxq4xesl8DqQbEpX
         EYRenm6VV7QhuHhBhX2iiLljDQP92VOczY/zD0xm0i+q+J/M4OUD87kbucMfvhVVz55V
         hcNaQPGxyG3gBGjhUcIDULbTnnkhf+9mwRdUhOIkDPCaAsxYk+14COGi2873q8I2hrx9
         uVJ92/oHoNVvtKzl/41UYx2x1XkddsEO5crg3+/aolJag6feZvaxP17OcCpOTTioIqpt
         onlMgXDMK3XKsQXaqM1zHWwBRC+DEnxZqeY2LBJ/CrJXZGQcscUJaCYV2hX+wd0PJSSk
         epSA==
X-Gm-Message-State: AOAM533ib5Y2+ZJoQajk2mHrJixjqnWzN4VcSzgHAg86tQAkU/2u5Bx6
	L5LWR9eyIAuGy84K3g2w92Gneq5nAe8=
X-Google-Smtp-Source: ABdhPJwZzN6DJrVfPfC7kY9kYNLTOoK+gyVYJe+mpJhZBKgRDp8/oXJMSNRvwww6bUvoAz4GNYDSGA==
X-Received: by 2002:a17:90a:d78c:: with SMTP id z12mr8843459pju.106.1620793019330;
        Tue, 11 May 2021 21:16:59 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id v12sm3147710pgi.44.2021.05.11.21.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 21:16:59 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH mptcp-next] Squash to "mptcp: receive checksum for MP_CAPABLE with data"
Date: Wed, 12 May 2021 12:16:55 +0800
Message-Id: <894be7ae85244360c4dd5a250043086d3bbc8826.1620792920.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the csum_replace2 trunk as Mat suggested.

mptcp_make_csum() hasn't been called yet so the pseudoheader has not been
included in the checksum.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
Apply the patch (Squash to "mptcp: generate the data checksum") first.
---
 net/mptcp/options.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index cce90c16e47d..6b737ba1f941 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -547,11 +547,6 @@ static void mptcp_write_data_fin(struct mptcp_subflow_context *subflow,
 		 */
 		ext->data_fin = 1;
 		ext->data_len++;
-
-		/* the pseudo header has changed, update the csum accordingly */
-		if (ext->csum_reqd)
-			csum_replace2(&ext->csum, htons(ext->data_len - 1),
-				      htons(ext->data_len));
 	}
 }
 
-- 
2.31.1

