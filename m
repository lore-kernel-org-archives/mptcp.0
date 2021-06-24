Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C192168
	for <mptcp@lists.linux.dev>; Thu, 24 Jun 2021 12:02:51 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id bv7-20020a17090af187b029016fb18e04cfso5359555pjb.0
        for <mptcp@lists.linux.dev>; Thu, 24 Jun 2021 05:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XDJgXtBkUY421fo7JUnByISUUbMYOQgruSA4ckDnvbM=;
        b=px+xpxDpYqfcE85Pu5ic1krHJKfOfzGvZCu68n48h+HwoE1rkupuTta1PeGLaA0lhW
         8sBNkHZWXxqJniMwegl9tkp/9JPKY2WJHhMvyWFyXbmJez7pdvdv8JoQe8bA4lHvC8Wa
         L77amcBYkKwNo5TEUNw3r6E4hXPYYWHzjDktr81S/9TF7dPRd6WsJihgT8kIAh/EMxi+
         HeSDy9A+/eRugczhgiDelQJ+aztZs70hrWPlI0LLaHw60oDnRGWsyRMOFe/pg9fUw0rb
         ldAaBGhmwRnWaJ1ueBqMgkcu6kGXAWwJ06zOeWsXuYIhr7tYgS8SrHTc0AH7xDsiHQU0
         eAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XDJgXtBkUY421fo7JUnByISUUbMYOQgruSA4ckDnvbM=;
        b=jVL0H5yW1pFLUJ09VDGDVsxAQmivm68WBfGr+GB4oVGTlt2KG8RTdiwsypHNU4hzR5
         coRkva90xcnjwPXvkNP5/LSVTNHPTjAQtYKVLIlqU+AS+sLpm70itW658aXIR3mrmWdw
         Y8w1zVcghQ4ygmZf9SJtJJpu4KFaVQNwD9Irw7ohYmbHDvjZswfKaq8FLvqXM3wNP5jV
         pmkTaa9e4shHeZk1eoRkalcskSlUMJuvRNpHCX2DDUYpMB63k9iLZrLdwIly+qzLhF4e
         w9gSTUKC6kl+Z1fsXkPpMcb26RfXQ4Nj+WM1hLr+fSV1prwd3qeidf3CftsWcJx9dzRq
         m25g==
X-Gm-Message-State: AOAM531hiEnXuFqSYWK4vNo3eLYCw4DzSSpEOg9Otj6SFsKbNWI+Liau
	fL6bKFSVdeAVPXeWYrewf1Zr4PiX+5Aw9Q==
X-Google-Smtp-Source: ABdhPJywSinii0cTkAY6r7jnASePdOSUnDc5rJaQzvHMKLv65jMzKX0y8P1i87HO18mcUfUvl6z4dQ==
X-Received: by 2002:a17:90a:d3d2:: with SMTP id d18mr15113684pjw.102.1624536171074;
        Thu, 24 Jun 2021 05:02:51 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id h24sm2863824pfn.180.2021.06.24.05.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 05:02:50 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 0/5] MP_FAIL support
Date: Thu, 24 Jun 2021 20:02:41 +0800
Message-Id: <cover.1624535761.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
 - MP_FAIL logic:
   * Peer B send a DSS to peer A, and the data has been modify by the
  middleboxes, then peer A detects the bad checksum.
   * In the multiple subflows case, peer A sends MP_FAIL+RST back to peer B,
  and peer A discards the data following the bad data sequence number. Peer
  B receives this MP_FAIL+RST, and close this subflow.
   * In the single subflow case, using the simple implementation, peer A
  sends MP_FAIL back to peer B, and peer A fallback to a regular TCP. Peer
  B receives this MP_FAIL, and fallback to a regular TCP.
 - apply: export/20210624T054331

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/52

Geliang Tang (5):
  mptcp: MP_FAIL suboption sending
  mptcp: MP_FAIL suboption receiving
  mptcp: send out MP_FAIL when data checksum fail
  mptcp: add the mibs for MP_FAIL
  selftests: mptcp: add MP_FAIL mibs check

 include/net/mptcp.h                           |  1 +
 net/mptcp/mib.c                               |  2 +
 net/mptcp/mib.h                               |  2 +
 net/mptcp/options.c                           | 63 ++++++++++++++++++-
 net/mptcp/pm.c                                | 14 +++++
 net/mptcp/protocol.h                          | 19 ++++++
 net/mptcp/subflow.c                           | 16 +++++
 .../testing/selftests/net/mptcp/mptcp_join.sh | 38 +++++++++++
 8 files changed, 154 insertions(+), 1 deletion(-)

-- 
2.31.1

