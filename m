Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ECF2CA7
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 15:57:34 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id b13so163815791edd.8
        for <mptcp@lists.linux.dev>; Wed, 05 Jan 2022 07:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eUDvi1snSI8RgS26pUudf/i3rGeVB0SFTUvO9vgaQEY=;
        b=GylllEw/0Ra4qtJvR/YAN2jqK0I2v6rXt5EtJDeg+ga8zfruCO9nNdzzZnPaSU+BQR
         mXQ1hnoW9Ner/3Caw/jWEuggCBlByf3z2T23YpItuF3k6v7njy0bny6xPfEYQiBWwDDR
         W3ETEvpeQ9jTKJcyGH6INITqz0pk0PEJ7p70c563yDrkXt+1mmcch2JmbimckKfZT032
         lybVZJ5C74SGmhcWGzfmPMtsh8kuTJumiKj1cy3RMlZXKOms+VAOIp+2N1o4k4jO507F
         Sf116AdWV5WkgzvnYykLvT593s1O/8tq73xSEKFSM5zzwEHnkQERTmyu8ZHYSO3boJe/
         qSiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eUDvi1snSI8RgS26pUudf/i3rGeVB0SFTUvO9vgaQEY=;
        b=nQP2Y8iShydxikEcYn90EEnTgPWPBAKb+C3PS72NMq42GB12DvVAhuHJ9iM5QY/CWL
         R6Rdf7gKJyp6KZVgVjls+4l/hDWOUyotkBLBP5jZuxH4y3Zd6sgg8Y5nlY2iP+xkXSB7
         JG7UupLusEds1u5ChKvve2orXjwDA4smUs+5GgS6290ya6OKk1jnTGHg4ybeMsUaQMlo
         p4Penl4HQavTAdc0RYqPcFMj3jWxNvufPfkO/Sa0iXEWhqQlnqA85J4gbNUI/Sl1yW2Z
         ZX8CIIVr3aZz+FU9YzGdmKZoVJhavZMvX6vQNxIjq9gpstovyyw6g08n9RmgnBQZqRuI
         166Q==
X-Gm-Message-State: AOAM531oNhGGo26hKipU0hUI85ddkgsiTI+YA/5INX+a8PUHh2Q4fKQq
	E5amTsZK5PXClkkkQkV3JN5ELL5ZeHIYTXXB5XE=
X-Google-Smtp-Source: ABdhPJwTURNcy/CZkkJPNV3usOOv+Y4X2FJ56n54edmrIjc8LsF6a82pG7vxv9v51g55LYoGB9dQ5A==
X-Received: by 2002:a17:906:974c:: with SMTP id o12mr42064770ejy.229.1641398252265;
        Wed, 05 Jan 2022 07:57:32 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id c30sm12399684ejj.190.2022.01.05.07.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 07:57:32 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v8 6/8] mptcp: allow sending both ADD_ADDR and RM_ADDR
Date: Wed,  5 Jan 2022 16:57:00 +0100
Message-Id: <20220105155702.165123-7-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220105155702.165123-1-matthieu.baerts@tessares.net>
References: <20220105155702.165123-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is mainly to be sync with what is done in mptcp_write_options()
where after having written the ADD_ADDR option, we check if the RM_ADDR
option also needs to be added.

But if we have room, it makes sense to write the two options in the same
packet. So best to remove the 'else'.

While at it, also mention that mptcp_established_options_add_addr() can
remove options.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/options.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 8553b928c5bf..06f64101d27b 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -864,11 +864,14 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 
 	*size += opt_size;
 	remaining -= opt_size;
+	/* Note: this can remove previously set options in some conditions */
 	if (mptcp_established_options_add_addr(sk, skb, &opt_size, remaining, opts)) {
 		*size += opt_size;
 		remaining -= opt_size;
 		ret = true;
-	} else if (mptcp_established_options_rm_addr(sk, &opt_size, remaining, opts)) {
+	}
+
+	if (mptcp_established_options_rm_addr(sk, &opt_size, remaining, opts)) {
 		*size += opt_size;
 		remaining -= opt_size;
 		ret = true;
-- 
2.33.1

