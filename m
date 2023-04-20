Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2E18C1E
	for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 16:20:07 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3010889c6ebso471523f8f.2
        for <mptcp@lists.linux.dev>; Thu, 20 Apr 2023 09:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1682007605; x=1684599605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmc1OFWQxJ5WWDOe2A3aVSpZm+mFWexOYU77x72mdcM=;
        b=zNzdMycUhQmGimWavn5BVTIu76yQ25Bz1Wup25bV70SRp5lA64M/pGn0WkzymRAN21
         29VhU48IxwcjZY0a9Ubsxgowk1LQMtRmP/nCD9PRLPfFBsd/08L4WgRElAOgUgyX5Ldd
         ITCuf1TEms7sIiPFfEE4NG7hF0oxevkC5CxNJsdCNThEcuQlCxHabjENEhCfwNo3hJFh
         0QFheBO3kWCocHE55dTW/1pO7cnCrKsvzWE41zGJDbtPthhUmZd7Up61OLTPE1QbzYeX
         VIywGGoQOum+JKFk6r3gmcPiM1xxxvc04C2xdyQ33SejxfffZFTYysS2Nu0YyHYHkzA9
         hiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682007605; x=1684599605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmc1OFWQxJ5WWDOe2A3aVSpZm+mFWexOYU77x72mdcM=;
        b=kVHEhC/T9luVnz06b6TIrsCHJCVeu2SkJHDnb6Ru7r3S+qtmrzxt3/e6qvyAxqVT5p
         tyze64TrABX7YKscPIZKGk+1GxTOAJg5Oc49ORIYryFPHPsm5ua9ElDWw2X9OqQcDwqf
         l9dAeaexbippBe/mjohwPO9GbmaZ/odKSTRDWHMj/Jcoxm3r+yhPfRllwez5nkYPsKTe
         gFS8Xq/CqEDLOH8Vfpxv0oXyMLbfvcpo0IFVrwjz2T0EVTV8RyHRAbROoqILUaIouV2E
         EoV6MeTowVmpZmuCnXEfdA1UuxnQWL8t3fv+OWlXyBtLpWYIBWRjmAt06iTULQf9gFEc
         zv1w==
X-Gm-Message-State: AAQBX9dc+UtWR1YvtnulFy2NxiIzHCawHjHv26BYiUkR9tt+I6c991rc
	T20MjV+TLKhFYm1a+2y/WnotHQO/jQDErkDPrLUhcV43
X-Google-Smtp-Source: AKy350YioaCFIV4/4+Y+bDYkqdMxzfE1kR9jqHSdlUGyVphKxK2gdyOY3tseKWDORfsyDffRIy3JlQ==
X-Received: by 2002:a5d:5492:0:b0:2f8:e652:dc04 with SMTP id h18-20020a5d5492000000b002f8e652dc04mr1652070wrv.45.1682007605128;
        Thu, 20 Apr 2023 09:20:05 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z18-20020adfe552000000b002f3e1122c1asm2371335wrm.15.2023.04.20.09.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 09:20:04 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>,
	Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 1/2] Squash to "security, lsm: Introduce security_mptcp_add_subflow()"
Date: Thu, 20 Apr 2023 18:19:56 +0200
Message-Id: <20230420161957.664328-2-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420161957.664328-1-matthieu.baerts@tessares.net>
References: <20230420161957.664328-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3466; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=AbeWQv/vWOYHG6h4nhNbE71gFXykFrjcPzvAYtLzWEU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkQWX5CUIpP+xhfLMawNp6tiqYjaLTmkxSCxy2M
 mO6tje+xpCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZEFl+QAKCRD2t4JPQmmg
 c0YwEADHwLHnIjDn17+fodL4FIaGZ/mdxiq+hOow8qPfiV3v8rnII28l5tYuG5BEeEDFpfihbkS
 4KVlaUfHxJKfNBK3k0zgap1SJW6SNS1HMgNYITRTpyhS62hDcIwsxTHtbZE1eUjDzXvvRdgOcbt
 3sLQnY6okrnbCoAHsJBPQPZh9EegdUdttPXqQsjmlHh3Y8uTn6wQpuDuwTKjDsgMAw4lPXTE3Su
 RDdMGKH7LNTsda5TVM4l6ESY4z1zIQgSwfiiizj/WPyETBZdcFfWP1azP0NG35tZpv/aap0QULk
 ZmOpZnng92XGkA7hkYi9OiAjiDaMlKQacXAZGC8f7EYJM/0XOQsPcVLfkV46z7uEBiSvEZLtT6+
 3GLBiiiQWDqdoCPKGCL7xkKHuzk9fv30LvvLhERSX0amRrOA9OmraY3Cm4N7nXkg5lqFKKBvIax
 S+83oRQELUjz5iCiox292Tnb7WMYaw6xlANTfsBLX7SP1Y1QbHMy3qCySHeLTduvcKWkdd0fWnN
 dy4QyOfiJJzDWTpoyJc6lWj/Gfp3oZ6wyO8y/qGIK57Ci8bLeMgnS6muBdGQb77edMTVRLEM2/S
 /e3rXzpxrUxrBn41f95vAS/lOEgd72LWOoeXMQvZ0CAUtlw/37wI8yrAJy5JXoQKlastfj+BkH6 0vgh43lQ+kBttyQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Apply Paul's comments from [1].

For the commit message:

  > Let's introduce a new LSM hook to allow the security module to relabel
  > the subflow according to the owing process.

  "... according to the main MPTCP socket."

  You might also want to stick with a consistent capitalization of
  "MPTCP" in the commit description, but that is being *really* nitpicky
  on my part ;)

  There is a suggestion for some additional comments in the hook's
  description below, but otherwise this looks good to me.

And for security/security.c:

  > + * Update the labeling for the given MPTCP subflow, to match the one of the
  > + * owning MPTCP socket.

  I would add a sentence at the end making it clear that this hook is
  called after the socket has been created and initialized via the
  security_socket_create() and security_socket_post_create() LSM hooks.

Link: https://lore.kernel.org/mptcp/CAHC9VhQsbSO5o+hVT-Tae-HyWMTjh2ffqQvz+pQQXkrMty7NYQ@mail.gmail.com/ [1]
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---

Notes:
    to be squashed in "security, lsm: Introduce security_mptcp_add_subflow()"

 .topmsg             | 15 +++++++++++----
 security/security.c |  4 +++-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/.topmsg b/.topmsg
index f3241d814f47..cfd5349a3238 100644
--- a/.topmsg
+++ b/.topmsg
@@ -2,18 +2,25 @@ From: Paolo Abeni <pabeni@redhat.com>
 Subject: [PATCH] security, lsm: Introduce security_mptcp_add_subflow()
 
 MPTCP can create subflows in kernel context, and later indirectly
-expose them to user-space, via the owning mptcp socket.
+expose them to user-space, via the owning MPTCP socket.
 
 As discussed in the reported link, the above causes unexpected failures
 for server, MPTCP-enabled applications.
 
 Let's introduce a new LSM hook to allow the security module to relabel
-the subflow according to the owing process.
+the subflow according to the owning user-space process, via the MPTCP
+socket owning the subflow.
 
-Note that the new hook requires both the mptcp socket and the new
+Note that the new hook requires both the MPTCP socket and the new
 subflow. This could allow future extensions, e.g. explicitly validating
-the mptcp <-> subflow linkage.
+the MPTCP <-> subflow linkage.
 
 Link: https://lore.kernel.org/mptcp/CAHC9VhTNh-YwiyTds=P1e3rixEDqbRTFj22bpya=+qJqfcaMfg@mail.gmail.com/
 Signed-off-by: Paolo Abeni <pabeni@redhat.com>
 Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
+---
+v2:
+ - Address Paul's comments:
+   - clarification around "the owning process" in the commit message
+   - making it clear the hook has to be called after the sk init part
+   - consistent capitalization of "MPTCP"
diff --git a/security/security.c b/security/security.c
index 1e99200ed0c9..d1d72a95e445 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2500,7 +2500,9 @@ EXPORT_SYMBOL(security_sctp_assoc_established);
  * @ssk: the new subflow
  *
  * Update the labeling for the given MPTCP subflow, to match the one of the
- * owning MPTCP socket.
+ * owning MPTCP socket. This hook has to be called after the socket creation and
+ * initialization via the security_socket_create() and
+ * security_socket_post_create() LSM hooks.
  *
  * Return: Returns 0 on success or a negative error code on failure.
  */

base-commit: fba46e506c37047424ec7f331564dc502098cd15
-- 
2.39.2

