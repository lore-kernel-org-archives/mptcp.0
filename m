Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4A7173
	for <mptcp@lists.linux.dev>; Tue, 17 Aug 2021 15:18:57 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id i22so13300008edq.11
        for <mptcp@lists.linux.dev>; Tue, 17 Aug 2021 08:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=86F7Qo542SXNMYSd8+mRVtu6j9iNIdk+nzDQ6c9pi4Q=;
        b=dBDRRNQooigYXJjb5reM/75rtSfzR1UY7fbPAlyHKQ4HqEeJbFgUFGtUMt0WrasBfC
         xj9a4SA75du8s1HD5lJvnBpK6W/+SkMe7/yMHKs7gNhRpLGjKqJUZu9svdXHbIOpGhoe
         Hi5hTjGvulMNKQv9RYxgr7w+DXGuwN2pca4nKo20zU9TSR6VDK0VTx8FbcD0+F9l8aX6
         fJtxhAHy/4oDb7OwUXiB4CoDFlxmgOJ2JF9KJG0QbqCltcMHDW8//4ukcEZYGv9UpNFv
         H3E/KvTrnjFTAHJXWOz942W+0q1pwFPM5JDfpIPA+Ic4riLVezJyYoVsbi3lyQMmJJg3
         PX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=86F7Qo542SXNMYSd8+mRVtu6j9iNIdk+nzDQ6c9pi4Q=;
        b=hjMGiC3BaX4RDDf3av+TOymfiWah1d8Y9gDNiERWLqfzOVTNaZSb0nt2GFYzH4Zp3r
         RkffR/tZWH8jO6zoMpogUb39nMkKpyuozv/pA9h4kAD7fYkRFUDm5abMN4oeo7Vmdy7w
         SUiZ2rs3HrlG96t0U/Vcy7A6Mp9FvLW6ZeHvEQw1eRO5YEC4UEZQhsf+89g/DUhhkjwT
         QId+IufYqwYtYoKdLhBGNMa12/RRPnfCkYmy/U5GdHDqshgG/2p0GBmLOsnU13ymV3Kc
         jiAnX+nUKc3MxMuL8H9mgh2bKYWE/yGOaQ8WfhfYz96rtosEJR7/o5hfEFKUldFJ1Z7t
         KN1w==
X-Gm-Message-State: AOAM53280w20lDevyOeWL8u1/G6nxG1Fi82hW69EpPjzm+c4i6c1b5xT
	wu/+C9jH3rUOkBn74kRZit4OJbKH0AODjf8W5gE=
X-Google-Smtp-Source: ABdhPJzDZnYxzztom2Rdqy+n4ZT6/o8kqlZMIrhFVA7aFwuBPdch9FmVl2ibK6JUQpu8JMGC6JVTDA==
X-Received: by 2002:a05:6402:288b:: with SMTP id eg11mr4706182edb.241.1629213535713;
        Tue, 17 Aug 2021 08:18:55 -0700 (PDT)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id n15sm1205669edw.70.2021.08.17.08.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 08:18:55 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v3] mptcp: full fully established support after ADD_ADDR
Date: Tue, 17 Aug 2021 17:18:38 +0200
Message-Id: <20210817151838.3187999-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If directly after an MP_CAPABLE 3WHS, the client receives an ADD_ADDR
with HMAC from the server, it is enough to switch to a "fully
established" mode because it has received more MPTCP options.

It was then OK to enable the "fully_established" flag on the MPTCP
socket. Still, best to check if the ADD_ADDR looks valid by looking if
it contains an HMAC (no 'echo' bit). If an ADD_ADDR echo is received
while we are not in "fully established" mode, it is strange and then
we should not switch to this mode now.

But that is not enough. On one hand, the path-manager has be notified
the state has changed. On the other hand, the "fully_established" flag
on the subflow socket should be turned on as well not to re-send the
MP_CAPABLE 3rd ACK content with the next ACK.

Fixes: 84dfe3677a6f ("mptcp: send out dedicated ADD_ADDR packet")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    - v2: reword the commit message not to mention "valid" content (Mat)
    - v3: squash the two patches together and update the commit message (Mat)

 net/mptcp/options.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index d94ff50c29b3..bec3ed82e253 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -945,20 +945,16 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 		return subflow->mp_capable;
 	}
 
-	if (mp_opt->dss && mp_opt->use_ack) {
+	if ((mp_opt->dss && mp_opt->use_ack) ||
+	    (mp_opt->add_addr && !mp_opt->echo)) {
 		/* subflows are fully established as soon as we get any
-		 * additional ack.
+		 * additional ack, including ADD_ADDR.
 		 */
 		subflow->fully_established = 1;
 		WRITE_ONCE(msk->fully_established, true);
 		goto fully_established;
 	}
 
-	if (mp_opt->add_addr) {
-		WRITE_ONCE(msk->fully_established, true);
-		return true;
-	}
-
 	/* If the first established packet does not contain MP_CAPABLE + data
 	 * then fallback to TCP. Fallback scenarios requires a reset for
 	 * MP_JOIN subflows.
-- 
2.32.0

