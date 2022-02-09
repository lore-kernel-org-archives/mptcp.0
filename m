Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED022C80
	for <mptcp@lists.linux.dev>; Wed,  9 Feb 2022 21:25:48 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id o24so3550231wro.3
        for <mptcp@lists.linux.dev>; Wed, 09 Feb 2022 13:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=50xBgF1MpcCvK3Ot0TteYG/Lyw8DZctL9HEz3sQuzrM=;
        b=rPsg3jSi6mzqDGZXt+D7x13LZhUVEkXJS5Dr9QJHQK0MIl3UaejFq8g0M92DQJpHhx
         4cfjE6iW74sCHDUh3mPjbtiCn2kGznvfJA29yDuScZl7tm8wCidhgrcN34dJ7LCXzb7O
         SXA1XsG9Aklvz5T/vHTo1/r6VjYTebXADKqzXDnx5ZQgQGDDP0aQ7WC54jTpTFVC4nnP
         QyyYsDG3EDjgvrvvq2yqDho714+55gxCAsczm9euEZDONn3tZH/Z+V9NnPBs4o4FBSaX
         0JjMVt63PGkzphj4JyMw6FZSglemr+v/DdYT1htl0PDeFitEU9kRRzaNeCOCRHieqmJd
         GErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=50xBgF1MpcCvK3Ot0TteYG/Lyw8DZctL9HEz3sQuzrM=;
        b=IUfycJ6EkdwNMfo4+lh0R3e4EDFefPnttvKcm7hU+8dYawNPswoV2W/tZ/XJkBbtyI
         kfVHXoz+jBQR9NtGgk9Dd7luMwV4TCle1QuwFY+fDNx8Kiqa1/OTgg1bWRzeffoc6xa/
         xAPoDvzQFBNeKxrdEdVDu1c0nbv22kXnyKNvGKavrzdTfVE476caeG/xeyyHcQ0oO13/
         j9aE/oYzbUiiXexbxqU07dqSSEUOselriS4rlNsJiFrkNynb7i6vgRSljHNvRgJb76Tq
         uTCy1ne/ToEf539G+e5rMSOvEQJXcAFeo8EOJHYDtd9ydZPJC2pDhqk1O5IQ2cE47bKv
         efAQ==
X-Gm-Message-State: AOAM531YWFu96CXXMifNmydKsK8eZWoEoY4nOhBJW3vUW2BBwm2nZP8g
	URV41MHhG0vi8aRTa8Hv67o3hBRuhuQxsRxy
X-Google-Smtp-Source: ABdhPJwMFyBONebBIaPQjZTCufvftA4F56274X+TeTEIxnOhP63BKvTpRdHcNvO3CfyAvkjTQB8Vzw==
X-Received: by 2002:adf:eec2:: with SMTP id a2mr3567806wrp.557.1644441946871;
        Wed, 09 Feb 2022 13:25:46 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id p14sm18500730wrr.7.2022.02.09.13.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 13:25:46 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next 2/9] selftests: mptcp: join: exit after usage()
Date: Wed,  9 Feb 2022 22:25:13 +0100
Message-Id: <20220209212520.2989291-3-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209212520.2989291-1-matthieu.baerts@tessares.net>
References: <20220209212520.2989291-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With an error if it is an unknown option.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9bbb95837f73..327f4ace5153 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2194,8 +2194,14 @@ all_tests()
 	userspace_tests
 }
 
+# [$1: error message]
 usage()
 {
+	if [ -n "${1}" ]; then
+		echo "${1}"
+		ret=1
+	fi
+
 	echo "mptcp_join usage:"
 	echo "  -f subflows_tests"
 	echo "  -e subflows_error_tests"
@@ -2217,6 +2223,8 @@ usage()
 	echo "  -C enable data checksum"
 	echo "  -i use ip mptcp"
 	echo "  -h help"
+
+	exit ${ret}
 }
 
 sin=$(mktemp)
@@ -2308,9 +2316,12 @@ while getopts 'fesltra64bpkdmuchCSi' opt; do
 			;;
 		i)
 			;;
-		h | *)
+		h)
 			usage
 			;;
+		*)
+			usage "Unknown option: -${opt}"
+			;;
 	esac
 done
 
-- 
2.34.1

