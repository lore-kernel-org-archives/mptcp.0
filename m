Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71601BA3E
	for <mptcp@lists.linux.dev>; Tue,  4 Apr 2023 14:56:17 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so22006820wmq.4
        for <mptcp@lists.linux.dev>; Tue, 04 Apr 2023 07:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680620175;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S2sEwaYGottZRmqEbV+5Hg+2qoGyhyKxaDX0GIJikbk=;
        b=f9f39qw1S2TCVjLdh+hs3JecPt2WRPjvB513OHdMavkkbk84LdQofkEUg7z3zH1ZW8
         5pgqwPGFFhWRwkb74qyo86L29w/NMV4GFxnw5vx2bA3tTyLzXc8CTKQ7r7XtlWqy9KsP
         EKoA2vcdJwf1gNEiGO2jxfCDtzshvFBPLLGTpeVE1HZG/W6HIbQQnAempX8yi0tQZ+c3
         DVJVh/26RZIlLdXt72qU6PHajvqTd2KUthm25ZPEWuPULr52ZYPQ0JaBmQ+I7WvoGac/
         KnUIwajlYvBX5vQ30Vf0nL45z0OHbW5pns/jVwvjFSSCOX3Icj8cfSab+7RT8j2UOXzT
         cy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620175;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S2sEwaYGottZRmqEbV+5Hg+2qoGyhyKxaDX0GIJikbk=;
        b=CXCKA+VgCeNI544OH8cZwuDzJyocRWJQkrayeIwm2JmCxtzU6xPAHWW0Jw5k9eEa1j
         /G3qdhnuZZwWSdpky//tFqII5w35IFJD4GtEYqBB9byeEYQRDKV3RFRDcymYpe/9H7FQ
         9iChR+DyBY7Yesy/46UmJ1URlCWnywujInVFPpmhVZ89kG5pwYiX4kfQz3QQWYsVisT4
         d0bxQSG1iYQtok4x06223/Lx1McwineErAQs78umL9IsCsXHUB253gLW36bemCN+WjBF
         wGFk8GG9gScwTlQoAaSdAXXls7d1Na5da5hdoXd7xrFoALYxO2k8jA5/lTOR7+rp01ZI
         R5EQ==
X-Gm-Message-State: AAQBX9fQyB/GozEDP8AHeIi9DQkoikiIcwchnam+OMviOXKlS85FJhcY
	eC6Xym8Pm5/+GRjEY1JwAHO1zw==
X-Google-Smtp-Source: AKy350bf5yczBYUf9xl+6i2IJ8vHJ0BlWOMvUt1dAZ1ixvHM0bw7JIDqZ3d4j4tLPV3e9AJGSI1G0A==
X-Received: by 2002:a1c:f208:0:b0:3ef:5fe3:c57c with SMTP id s8-20020a1cf208000000b003ef5fe3c57cmr2443975wmc.23.1680620175288;
        Tue, 04 Apr 2023 07:56:15 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c228300b003ed2384566fsm15413333wmf.21.2023.04.04.07.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:56:14 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 0/2] mptcp: selftests: join: support BusyBox and
 ShellCheck
Date: Tue, 04 Apr 2023 16:55:58 +0200
Message-Id: <20230404-mptcp-selftests-join-busybox-shellcheck-v1-0-65892428a951@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH46LGQC/yWOQQ6CMBREr0L+2h8RWKBXMS7aMrVVKE1/IRjC3
 QVdvkzy3qwkSB5Ct2KlhNmLH8MOl1NBxqnwBPtuZ6rKqi6bsuEhZhNZ0NsMycKv0QfWk3z0uLA
 49L1xMG+GqeqrbbsGraXdppWAdVLBuMOXz1OUnKCGY4wJ1i+/G3f6FwKWTI9t+wIXQ4NaogAAA
 A==
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=pelmj0AHRvxOa/bR+QyZlCRB5bkE6m+LSsSsTaqf/sc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkLDqOTqZC8Ur79nV70/vFyLdWQl1KW0PVc6MdN
 HMBtZAN/byJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZCw6jgAKCRD2t4JPQmmg
 c386D/9uWW0oIE3exPa02cZM1QbHQIHdTHwXRaxpXkfNDlmlTUkTSdACak1i20yLx3p7L2ypuY0
 4NOm+aezvNeZZEY5Tn+X5SxmYvox8Q3hOltdP5NXNO9YxOHTnBjmn8+GkHGgUlhzUtf+kAElJGw
 yXHuF0AgO04t83iCFrFr9LTQ6hLspfJUEWprZmDAByhfZuUhDXWdA9M0GdDZnXb1gCGlsvdBtKB
 sN3dcvh5dB6fLnglUFL708qtGVg1GaGF67FH1W2eR86raq8Rk3K08Dp3Nfycz+73YYZvhtgUpzW
 DF3b52c3hUnFxDWuatq2ua/UfDmTNhvo9s9gwUIpSzW6r899dCqBJDWDSGZS3GTY0gR18Sm35zX
 JNWGXu4J1H9YDeLdRbb3e5IuYvZqrBYZTJRU90981OYzHM+UFKgz/MjsRaptX3t+VG8ouoFMGF1
 DPG21+fsclwbugXAMQ0BDUhwF7zcQBK1Z/gDoTz+POp9OHbJcYdoWV3tAh5ezsrU+mlk/uGHOZ8
 lcijiajY0OoPZQb4PHGoLltPcwWxzeUWU1vAdGqSghVWjyhsCmrtzCGKU9iWN8gDJTgss5q2X2Z
 2vDvU4WLOSZWulBQ6qrNEMOBuPuf1iTNaL5Pl996skAIpgbBLqbyVLnpOgFxlAz4CDRhQqHICcm
 /7x9gtEQXR8txLQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here are two simple modifications, not really fixing anything for us but
fixing issues for those using BusyBox like LKFT.

At least the first patch fixes a bug they have. They might switch to a
different version of cmp at some points but it doesn't seem easy. So
probably best to have this patch flagged as a fix to have it backported
in order to detect when other mptcp_join.sh subtests are failing.

The second patch fixes ShellCheck warnings: it was reporting issues for
most lines of the script. Best to fix these warnings to easily spot new
warnings that could be linked to real issues. But no need to backport
this one I suppose.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Matthieu Baerts (2):
      selftests: mptcp: join: avoid using 'cmp --bytes'
      selftests: mptcp: join: fix ShellCheck warnings

 tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)
---
base-commit: 73fd52db48d9eff550fef735066f742acc2bf0e6
change-id: 20230404-mptcp-selftests-join-busybox-shellcheck-ec239f8d4e8f

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

