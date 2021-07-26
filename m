Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F8372
	for <mptcp@lists.linux.dev>; Mon, 26 Jul 2021 04:12:34 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id e5so8111267pld.6
        for <mptcp@lists.linux.dev>; Sun, 25 Jul 2021 21:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ueH4mR10oY5t4bH5CTOhXfq5LPEO8MCnIaYt6/RHtkM=;
        b=g2bOnJqCSBiQTegiWuoqrc7uC3VJqFrg911hc8EWizpNpvCFlIBNowgmtS2kFr5ara
         qbA7FHkvbWG2CYqb0iAb2YjPLPRpUBOFthVaPR/1goZ9Q0Xjy2IqPK7f/GaOajFOqBcW
         07hbUEgvXgMQQrSFANGex1DrQSRZb7GcHXNysAutlB41vXPdt+/cZ5nzmG70cu7eSdnt
         bUp+NkkZtQoa4H3YsKYMIEnx8pYZ29YZwKVTFeaBAKGCjS3dHprvRF7Iwh4W9CurVoqy
         Kkuc9OB7eVslQG3YRj9OBNdc+mVzgkZ07gnzDcQ322zQZ9IzMUT1IjoxvfJt4fKtCG1f
         W12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ueH4mR10oY5t4bH5CTOhXfq5LPEO8MCnIaYt6/RHtkM=;
        b=pl6RMtAWo5JkBnbmDybuX9F62G7QvodX5ceSxeerYlhjCtkYpEq23AbKkV27FbUtIl
         d5dgS09PIqcqG7/g38wWpsq7FpqKDe/33ZZH3Bct9WNf/t3Bym3rtRkrfbfI/ZuyW7BH
         oxOB4j6XIzmyatLrzCFyrmYX4fwLX3DMfqU1t/QSCco2OuZDdrwBlCmj4Ap41haEtOly
         ovL9Kzxe6cJ0iCgsnpwKu3oGcW/JhEb826xpuQPw5pDLuIb5GEicOQ9SfUopogatoIg9
         gHoGAJBQ4H/0t8W958V88KlxTQfkYEbZFG4SaG8tv0+sNzrbf8Dm+5rz46zyVbKw9OO/
         OYzQ==
X-Gm-Message-State: AOAM533Wuw6TMrMziafSaAYzNUF2JXcPHy31Jw5rpco7iMwVP/wkgu72
	1fHzeYfKFXU9x8yoFZS/+kgfeQx1vPAvng==
X-Google-Smtp-Source: ABdhPJx0vDJiqP78Dl97TitZ6KpwSNtB1/WEIRzQvpe60NMEGTrxi27LVDxsbYP9aRhrazVbAnL5dw==
X-Received: by 2002:a63:ef4c:: with SMTP id c12mr16415447pgk.441.1627272753574;
        Sun, 25 Jul 2021 21:12:33 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id f3sm2608543pfe.123.2021.07.25.21.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 21:12:33 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v3 mptcp-next 0/5] fullmesh path manager support
Date: Mon, 26 Jul 2021 12:12:23 +0800
Message-Id: <cover.1627272435.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

v3:
 - the in-kernel fullmesh path manager has been dropped from this
   patchset, only keep the fullmesh flag support code.

v2:
 - Implement the fullmesh mode as an extension to the netlink PM, not a
   standalone PM as Paolo suggested.
 - drop duplicate code.
 - add a new per endpoint flag MPTCP_PM_ADDR_FLAG_FULLMESH.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/193

Geliang Tang (5):
  mptcp: remote addresses fullmesh
  mptcp: local addresses fullmesh
  selftests: mptcp: set and print the fullmesh flag
  selftests: mptcp: add fullmesh testcases
  selftests: mptcp: delete uncontinuous removing ids

 include/uapi/linux/mptcp.h                    |  1 +
 net/mptcp/pm_netlink.c                        | 81 +++++++++++++++++--
 .../testing/selftests/net/mptcp/mptcp_join.sh | 59 +++++++++++---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 11 ++-
 4 files changed, 136 insertions(+), 16 deletions(-)

-- 
2.31.1

