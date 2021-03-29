Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2589A5F
	for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 10:41:44 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id h3so9581238pfr.12
        for <mptcp@lists.linux.dev>; Mon, 29 Mar 2021 03:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z+nS8NS0KjPy6BEVAX+1RaribBZtTUnh8WIyqflfypg=;
        b=sNACFfP0JiKCP3sm04bn7+u4eaQM2OtGZT9ef+oFTIYTyP12VVDxiUDJE9UvK6aWDw
         ltB9Vikxe9O55azsjXl3CqrTrweVrpwSq5qh6l6KR0Jn4udtjBsAtcYuKRPx7ntzAFQP
         c4gPDUWa6pm9rGKOHzMJrXJyTnN6N+qivp9+yQqDVqlzGNqhYhCvZ+H2k9z60o1ryj5O
         9+FKwvGRSXqql/TbVBd0ZLb2L3G1yrt8pNXAr6eX9uLPZ2RIvAkWDOm2udExVWJI0GqS
         nRJITBM4Js8gZ+U9GWcMk01G40saiahRBD5kco0oBpmgtCPNGhCd7hk8DyID5AmXmk0O
         XJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z+nS8NS0KjPy6BEVAX+1RaribBZtTUnh8WIyqflfypg=;
        b=fDBi3JnlK+B97BqD2nYvdZq8NV7pj4nWgWB2JJbaXWVI0SieCwjkIkWTfp/p5KVxl5
         sHFulSxnTgyABKSUW0Zm/AcDPbKUIaRYhUyyE8PfjA0uL2nPP1lG7ZAPb3z1gSlZoaZG
         H5LiIQC/NoFzL+uGDVmnOFVT8vDrdT+++WRoeor4XUrIKkYxnH8VktFYyKA6ScOysr0Y
         cx5gsnrrKtxfGwrbncr/C94d34DvAES14slghKFuDxNrq5rYp8SGcTWm/PJNMHA6rikb
         UZrtGis9HHgStV4s9A/cQFfRoNJyFSBeMtElnayJCLB4Q4SIHg93YsiFDwTk7XWp1cCu
         v+gQ==
X-Gm-Message-State: AOAM533hWO6X/6TSoEz19hErbuA5bXpAsGHJ0IV9FpiAigyXrUORhWdV
	lsZZ2+Gb4aBObduASK0y7M4/jViBtlBEGg==
X-Google-Smtp-Source: ABdhPJx112ac78kRYohFmLxT34pUZL6w7cyPR5DHJBOOiETXDSY6MQveGBshjyLQJhrTVIaE2m2Whw==
X-Received: by 2002:a62:8857:0:b029:203:4d7a:ae8d with SMTP id l84-20020a6288570000b02902034d7aae8dmr25360409pfd.16.1617014503363;
        Mon, 29 Mar 2021 03:41:43 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id s15sm16626567pgs.28.2021.03.29.03.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 03:41:42 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 15/16] selftests: mptcp: enable checksum in mptcp_connect.sh
Date: Mon, 29 Mar 2021 18:40:46 +0800
Message-Id: <fa2e5e2e8eee03798175cc42e73810518b47d29b.1617014019.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <c231d3aa6b38374c1e28709e4d4b94e179c6e13c.1617014019.git.geliangtang@gmail.com>
References: <cover.1617014019.git.geliangtang@gmail.com> <ee1d26bf90397d9cbec5e4a165fc369ffab60d3e.1617014019.git.geliangtang@gmail.com>
 <26ccf630ac9be0aee87f4ccfcefc46515c9d61e8.1617014019.git.geliangtang@gmail.com>
 <a138746729a11cf08e8236d2c8cdf91226936690.1617014019.git.geliangtang@gmail.com>
 <14b6923c9fd052b140d5af261dfd2575d94b3e05.1617014019.git.geliangtang@gmail.com>
 <08ab4ce9f13e954b45d24c9e7842f7a6a9798d54.1617014019.git.geliangtang@gmail.com>
 <d8a242cfe08b2ab0ccb4752a15c8ea8ef0226ac1.1617014019.git.geliangtang@gmail.com>
 <1c0a240472edcc1afbcb822bd9af3cf03800759e.1617014019.git.geliangtang@gmail.com>
 <4c7e346e9d1005e8838dd8cf742d8324ef7553c0.1617014019.git.geliangtang@gmail.com>
 <4a289b981d90fcfda872ade12ec94d27d47bc01f.1617014019.git.geliangtang@gmail.com>
 <07856073b42a0343f81e6b6e468d6965b693fc5d.1617014019.git.geliangtang@gmail.com>
 <95dff6615e84496cab649de3d74917790f6a571f.1617014019.git.geliangtang@gmail.com>
 <44262de5d6a76c02e585ba148117af9b81355d0d.1617014019.git.geliangtang@gmail.com>
 <5364f608199436bf7125d8f89a4fefcaad2b5eb3.1617014019.git.geliangtang@gmail.com>
 <c231d3aa6b38374c1e28709e4d4b94e179c6e13c.1617014019.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added a new argument "C" for mptcp_connect.sh script to
set the sysctl checksum_enabled to 1 to enable the data checksum.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index 385cdc98aed8..c769f1e962bd 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -3,7 +3,7 @@
 
 time_start=$(date +%s)
 
-optstring="S:R:d:e:l:r:h4cm:f:t"
+optstring="S:R:d:e:l:r:h4cm:f:tC"
 ret=0
 sin=""
 sout=""
@@ -22,6 +22,7 @@ sndbuf=0
 rcvbuf=0
 options_log=true
 do_tcp=0
+checksum=false
 filesize=0
 
 if [ $tc_loss -eq 100 ];then
@@ -47,6 +48,7 @@ usage() {
 	echo -e "\t-R: set rcvbuf value (default: use kernel default)"
 	echo -e "\t-m: test mode (poll, sendfile; default: poll)"
 	echo -e "\t-t: also run tests with TCP (use twice to non-fallback tcp)"
+	echo -e "\t-C: enable the MPTCP data checksum"
 }
 
 while getopts "$optstring" option;do
@@ -104,6 +106,9 @@ while getopts "$optstring" option;do
 	"t")
 		do_tcp=$((do_tcp+1))
 		;;
+	"C")
+		checksum=true
+		;;
 	"?")
 		usage $0
 		exit 1
@@ -200,6 +205,12 @@ ip -net "$ns4" route add default via dead:beef:3::2
 # use TCP syn cookies, even if no flooding was detected.
 ip netns exec "$ns2" sysctl -q net.ipv4.tcp_syncookies=2
 
+if $checksum; then
+	for i in "$ns1" "$ns2" "$ns3" "$ns4";do
+		ip netns exec $i sysctl -q net.mptcp.checksum_enabled=1
+	done
+fi
+
 set_ethtool_flags() {
 	local ns="$1"
 	local dev="$2"
-- 
2.30.2

