Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5644E72
	for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 07:58:38 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id l19so16715703pjz.0
        for <mptcp@lists.linux.dev>; Tue, 27 Jul 2021 00:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ILtYiU70BEcQ5rGiFqRTWS4xoybjP0cjfByRLsh1n10=;
        b=bcPRSHBHVxpS/zdCqNzRoqRu898xrBLpd71u//6tkm6cLqXmHll6QRZkklSTME8OLS
         CNmY5Q4HiRFH6ZAwVIWCW8ChGCrznlUaPTPeUQc2tqOGmKQ2FvYKY+E5iHnijBYYB6zi
         YUWuDwxNdL0zwZN9n4goTJXdXA/4C35314z93yg1iJkqKqVIBVThvE3W/2oPf9MuKPXO
         HwGLt0rIQyJR1s80VckCPrlh08fjwRGXCAPBaMw5Wmpe6jUBftpLZS0F9W5j2SgQJTKH
         zXXdhqOTdZfSeQOiSMSYH3zm4YqRbFoYMEMuoKjVXXBuWXGumySSXFO8z92TIrjcxSeJ
         iCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ILtYiU70BEcQ5rGiFqRTWS4xoybjP0cjfByRLsh1n10=;
        b=ulCYAV/p5uCrdq+LPiDQRKEeUSB89ET9hypZNcDdJ3wKjc8nvjGYyBys+E+svdSfdT
         znIJX3V35/eIgE0kgHqxV8NbFpOcCJZXY2kfNfa6NbNVEvOwzCoV0HBGObnf1OXEg3Z+
         eJfDqtXLY1U4AkBDqBNpJZcxWB8VnmSCjEuWT0OR5zsk71h09EKl28P3ChbUEOQGVSeu
         jYwcvuGkBGjOsQtxyAaVlEBIC+1Rb5oEjhFVT4YrU/UnUxGLCzacQjVILsliIaBgTaqQ
         62wcZsePRjOlIgs6esI/3a0WMVcZIuApiYFVxmOCwutHQbm7fiSIW8RSxEpe1iU4h6LZ
         emDA==
X-Gm-Message-State: AOAM530U98Vcc9gVJ1guKcszIhdGsRT+aIT5PcFGLRrr94Pf8g6Hfjfz
	1xRR0ykh4G2m5lPQEIWqzHvYiN5JbKw=
X-Google-Smtp-Source: ABdhPJyrLqvxauzoZ8kiDkWY4sCftvfHSJVg+2Zd6wgCFS5ZDRRBzill0bNzamEI2MwaPkNk7nnLbQ==
X-Received: by 2002:a17:90a:dc15:: with SMTP id i21mr21697109pjv.139.1627372717888;
        Tue, 27 Jul 2021 00:58:37 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id v9sm2544537pfn.22.2021.07.27.00.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 00:58:37 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev,
	geliangtang@gmail.com
Cc: Geliang Tang <geliangtang@xiaomi.com>
Subject: [MPTCP][PATCH v5 mptcp-next 5/5] selftests: mptcp: delete uncontinuous removing ids
Date: Tue, 27 Jul 2021 15:58:22 +0800
Message-Id: <0e5e3e180f352cb7ba875e30f94b0d81c789ca72.1627372396.git.geliangtang@xiaomi.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <78d86feae19ea4efd7061a9e92b81475ed035323.1627372396.git.geliangtang@xiaomi.com>
References: <cover.1627372396.git.geliangtang@xiaomi.com> <b8af3a77da2fcd8e16e8b5d6b63c7c8386abcbac.1627372396.git.geliangtang@xiaomi.com> <bde1048019780ecc5f2e553bbb4eb21213f76ba7.1627372396.git.geliangtang@xiaomi.com> <69eb44fdf9899ec5eab342fa1f3b62d12ab2598e.1627372396.git.geliangtang@xiaomi.com> <78d86feae19ea4efd7061a9e92b81475ed035323.1627372396.git.geliangtang@xiaomi.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <geliangtang@xiaomi.com>

The removing addresses testcases can only deal with the continuous ids.
This patch added the uncontinuous removing ids support.

Fixes: f87744ad42446 ("selftests: mptcp: set addr id for removing testcases")
Signed-off-by: Geliang Tang <geliangtang@xiaomi.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ca19762b9c6e..3d906792e963 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -344,17 +344,18 @@ do_transfer()
 		let rm_nr_ns1=-addr_nr_ns1
 		if [ $rm_nr_ns1 -lt 8 ]; then
 			counter=1
+			pos=1
 			dump=(`ip netns exec ${listener_ns} ./pm_nl_ctl dump`)
 			if [ ${#dump[@]} -gt 0 ]; then
-				id=${dump[1]}
 				sleep 1
 
 				while [ $counter -le $rm_nr_ns1 ]
 				do
+					id=${dump[$pos]}
 					ip netns exec ${listener_ns} ./pm_nl_ctl del $id
 					sleep 1
 					let counter+=1
-					let id+=1
+					let pos+=5
 				done
 			fi
 		elif [ $rm_nr_ns1 -eq 8 ]; then
@@ -392,17 +393,18 @@ do_transfer()
 		let rm_nr_ns2=-addr_nr_ns2
 		if [ $rm_nr_ns2 -lt 8 ]; then
 			counter=1
+			pos=1
 			dump=(`ip netns exec ${connector_ns} ./pm_nl_ctl dump`)
 			if [ ${#dump[@]} -gt 0 ]; then
-				id=${dump[1]}
 				sleep 1
 
 				while [ $counter -le $rm_nr_ns2 ]
 				do
+					id=${dump[$pos]}
 					ip netns exec ${connector_ns} ./pm_nl_ctl del $id
 					sleep 1
 					let counter+=1
-					let id+=1
+					let pos+=5
 				done
 			fi
 		elif [ $rm_nr_ns2 -eq 8 ]; then
-- 
2.31.1

