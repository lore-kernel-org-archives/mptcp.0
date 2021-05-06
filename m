Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CDA72
	for <mptcp@lists.linux.dev>; Thu,  6 May 2021 07:49:07 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id c17so4522285pfn.6
        for <mptcp@lists.linux.dev>; Thu, 06 May 2021 00:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iVn4dzlJEKbjpbacKb+mDd7blDkAv2g0zvw+999tyZQ=;
        b=OvhKenrkFfRjQnpMQdfsmvrUBGOot90LRbaLrT+UEB1f3VdF2IB9FcH93lh6VDnLgg
         tGgbQzJjqbGalM7Xr/k1Oi2MV7SdbH8NR6MKF5q8n4pZ8kBfSGwYIoAlmAlz5SHOO6L6
         u49Yz98dwavQEZ6cZm4tsj28D4wPORBXWTT1ahrDAgc+mqb11f1jIt64Ab7+7938XE/j
         slzB56XCaRVhoJrOnmA3hunZUfThjM04MwZd3XtxGj4R54x3uBng9aannHZAzcnFERDp
         jqsoaHH6Q5tbvJqsQMWSxORR3LSSgIsfjwUq+GwPDmVCLjGReWyU7dIwlPFTOdZr4stF
         PPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iVn4dzlJEKbjpbacKb+mDd7blDkAv2g0zvw+999tyZQ=;
        b=KQAALnKRJfSTbI4dcgwificlHSlnC6ew7PkcuR6GKAj4cXuqh7dcv8THeHqsh7bmeL
         6g3mnOH43JTWFwL+vQrChJQGh6zNoNvna9wGmKAQul/wTWuqlx+HLex93ro5fokDmVlz
         tL7fXZNSWgAst/YKc4W8GoQ7XHGc0wv8SHcgPy8Cjq56VQId1v3oeMnDkYCqVNBP7T2p
         myM7NllOTG/B+YRewe3zZxt5VzOgzdCi07jv1ag6syCofOo7SJo+bmekGTA2/SxVwd3b
         QRp0TW6J6kvVbtFyBz1f9DZt81LToDTk3InVd4JJSxGU8LppbsHhut0VxzKGjLI7LF9Z
         3oqA==
X-Gm-Message-State: AOAM531tMgKGQ0thoxE/4JOAQA9n223Ui6XX/g5SGPDMfeQY9o3HsXkK
	KisaWaTtnujZ2mYv6fqr/+4Vb4yr1wQ=
X-Google-Smtp-Source: ABdhPJw4P1a0RmTPk9t3SOhrsKwm+9P2uDDTUdnOAzIwy+3h4XjoXW4Ll4102P5Ngh/jjSwkComBNg==
X-Received: by 2002:a62:b412:0:b029:21f:6b06:7bdd with SMTP id h18-20020a62b4120000b029021f6b067bddmr3215410pfn.51.1620287346660;
        Thu, 06 May 2021 00:49:06 -0700 (PDT)
Received: from localhost ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id e2sm1335166pjk.31.2021.05.06.00.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 00:49:06 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 5/5] Squash to "selftests: mptcp: enable checksum in mptcp_join.sh"
Date: Thu,  6 May 2021 15:48:46 +0800
Message-Id: <b102c15f040c9573ee28803f5e77665139ef8e54.1620286893.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <af98fe46c5b1d2737f02868fddb6d08e84d220c3.1620286893.git.geliangtang@gmail.com>
References: <cover.1620286893.git.geliangtang@gmail.com> <1ca01996cdfd7e70967d7895776e3ec3014c55cd.1620286893.git.geliangtang@gmail.com> <093b409c7678032f8639402cf9f13025d2c65965.1620286893.git.geliangtang@gmail.com> <0e4f818d6894959b07da34e2d190ec2a7aaba51e.1620286893.git.geliangtang@gmail.com> <af98fe46c5b1d2737f02868fddb6d08e84d220c3.1620286893.git.geliangtang@gmail.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename MPTcpExtDSSCsumErr to MPTcpExtDataCsumErr.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index ef8341c851f7..523c7797f30a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -503,7 +503,7 @@ chk_csum_nr()
 		echo -n "  "
 	fi
 	printf " %-36s %s" "$msg" "sum"
-	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtDSSCsumErr | awk '{print $2}'`
+	count=`ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
 	[ -z "$count" ] && count=0
 	if [ "$count" != 0 ]; then
 		echo "[fail] got $count data checksum error[s] expected 0"
@@ -513,7 +513,7 @@ chk_csum_nr()
 		echo -n "[ ok ]"
 	fi
 	echo -n " - csum  "
-	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtDSSCsumErr | awk '{print $2}'`
+	count=`ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}'`
 	[ -z "$count" ] && count=0
 	if [ "$count" != 0 ]; then
 		echo "[fail] got $count data checksum error[s] expected 0"
-- 
2.31.1

