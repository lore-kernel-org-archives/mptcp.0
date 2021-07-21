Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAF72FB6
	for <mptcp@lists.linux.dev>; Wed, 21 Jul 2021 14:31:55 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id k20so2055157pgg.7
        for <mptcp@lists.linux.dev>; Wed, 21 Jul 2021 07:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nqNbQ4/Fda2bKndbUrmT79/EO9BGS0qtWM/xUR7NMlg=;
        b=WpT7H6qPUdCKjHO3AZWI8TWCJPaKuZpzWh/QIjvglrbbkkx3VbwzscnMhAR/taP5Le
         IcmgkQRc1WzyW4mjo2BtUW7nXGb0d1Fq8m7lbvI21G08wPzxFF8EU6ABTRm3fLwgonB2
         ImJiRKFuWiZwvrs7ppFBplVj3F3duhWtTCQKkDJHH6Zq/wTzUJIlq1MFx/nmxkJzvwT4
         dP2Hs7HbCtIz2nDhmE4ol479LDm7ikeDM4yYXJyZu0BvNaYE2A6S3KauTFrrdViUdenS
         3/hwOhKbFqM2iVBQo+s1+Zt+nAVjNIhRFA59M4cjkz3mZiDlQ3f6BfxPmA0S5sRLS9fO
         UvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nqNbQ4/Fda2bKndbUrmT79/EO9BGS0qtWM/xUR7NMlg=;
        b=dcosomUzeuAdouYIdslG7TaAGlp4WUsX58HPbfVSwiC/wH5JS4leXx6SzLD6EQCtHg
         aRxSWs63NMC0ZBPKUb6yPa3r/yse0T6O/unnoOJOCmG4XN6a2SgSahVQprskEYMSXchH
         mR39WTHxoJbGCU72JR1aKjU2vfmBLXJGEgOzsFzsRsrXtZvKJ0xAASPgxlNUlAQpT+Ef
         3ruzdvgd8jYmngrQv0gXU97A9DLeV1tiSbTLADSFUgXSUQqgN3q+ziugEYvBgszci6rH
         WxTooiwZeF6ben/xXtYfVxsiJWDNM8jkoahTZzv031WKt3cXHjQYWpgPbOMdRNO4JkGS
         sdbQ==
X-Gm-Message-State: AOAM533jN0hYAOgYE87WHesSiT6G7uxG3Ew75ACpE+D82Fu3+rcFqPTX
	ZEvBL+v0qrOAbAotIGCzRxpO6P5anTBi2A==
X-Google-Smtp-Source: ABdhPJyuhKl8sJ2+72xfyW9bxOlm78u1vLwJzELJFX6kX1HtJoLRt1/uZpSmXlcgm6oVDaYzwhDVig==
X-Received: by 2002:a63:1126:: with SMTP id g38mr36105594pgl.452.1626877915053;
        Wed, 21 Jul 2021 07:31:55 -0700 (PDT)
Received: from MiBook.. ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id i6sm21723147pfa.44.2021.07.21.07.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 07:31:54 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 09/10] selftests: mptcp: add fullmesh testcases
Date: Wed, 21 Jul 2021 22:31:33 +0800
Message-Id: <b2634ea97c51cdad4f50dd10ef9b8b6dfb267f81.1626877655.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <66797ed318830e28cdbabf59011c0da39b9f6cce.1626877655.git.geliangtang@gmail.com>
References: <cover.1626877655.git.geliangtang@gmail.com> <b5f63eb4ad680a99fc806d2406968a6a5f272f01.1626877655.git.geliangtang@gmail.com> <0000f0168f0d8d1cd34bbe5463aed721225446e2.1626877655.git.geliangtang@gmail.com> <93ffe9fbfda6d2efdbab73373b6efbbce3a36b00.1626877655.git.geliangtang@gmail.com> <f1175761821947749ac9724deb3009b9b2747bbd.1626877655.git.geliangtang@gmail.com> <e9de213a59a066c6beaba2895a7c60412b654601.1626877655.git.geliangtang@gmail.com> <149236d46fe59a177a2f36a5c6e45941a1e0c2fd.1626877655.git.geliangtang@gmail.com> <d40b7b32bc427e5d43fce298b60e1040398977ac.1626877655.git.geliangtang@gmail.com> <66797ed318830e28cdbabf59011c0da39b9f6cce.1626877655.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch added the net device UP and DOWN testcases for the fullmesh
path manager.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 .../testing/selftests/net/mptcp/mptcp_join.sh | 81 ++++++++++++++++++-
 1 file changed, 80 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 220154cb92a7..823300986459 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -160,6 +160,27 @@ reset_with_allow_join_id0()
 	ip netns exec $ns2 sysctl -q net.mptcp.allow_join_initial_addr_port=$ns2_enable
 }
 
+reset_fullmesh()
+{
+	reset
+
+	ip netns exec $ns2 sysctl -q net.mptcp.fullmesh_enabled=1
+
+	for i in `seq 5 8`; do
+		ip link add ns1eth$i netns "$ns1" type veth peer name ns2eth$i netns "$ns2"
+		ip -net "$ns1" addr add 10.0.$i.1/24 dev ns1eth$i
+		ip -net "$ns1" addr add dead:beef:$i::1/64 dev ns1eth$i nodad
+		ip -net "$ns1" link set ns1eth$i up
+
+		ip -net "$ns2" addr add 10.0.$i.2/24 dev ns2eth$i
+		ip -net "$ns2" addr add dead:beef:$i::2/64 dev ns2eth$i nodad
+		ip -net "$ns2" link set ns2eth$i up
+
+		# let $ns2 reach any $ns1 address from any interface
+		ip -net "$ns2" route add default via 10.0.$i.1 dev ns2eth$i metric 10$i
+	done
+}
+
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Could not run test without ip tool"
@@ -364,6 +385,16 @@ do_transfer()
 		elif [ $rm_nr_ns1 -eq 9 ]; then
 			sleep 1
 			ip netns exec ${listener_ns} ./pm_nl_ctl del 0 ${connect_addr}
+		elif [ $rm_nr_ns1 -eq 10 ]; then
+			local addr
+			local i=5
+			if is_v6 "${connect_addr}"; then
+				addr="dead:beef:$i::1/64"
+			else
+				addr="10.0.$i.1/24"
+			fi
+			sleep 2
+			ip -net "${listener_ns}" addr del $addr dev ns1eth$i
 		fi
 	fi
 
@@ -412,6 +443,16 @@ do_transfer()
 			fi
 			sleep 1
 			ip netns exec ${connector_ns} ./pm_nl_ctl del 0 $addr
+		elif [ $rm_nr_ns2 -eq 10 ]; then
+			local addr
+			local i=5
+			if is_v6 "${connect_addr}"; then
+				addr="dead:beef:$i::2/64"
+			else
+				addr="10.0.$i.2/24"
+			fi
+			sleep 2
+			ip -net "${connector_ns}" addr del $addr dev ns2eth$i
 		fi
 	fi
 
@@ -1683,6 +1724,39 @@ deny_join_id0_tests()
 	chk_join_nr "subflow and address allow join id0 2" 1 1 1
 }
 
+fullmesh_tests()
+{
+	# fullmesh add
+	reset_fullmesh
+	ip netns exec $ns1 ./pm_nl_ctl limits 8 8
+	ip netns exec $ns2 ./pm_nl_ctl limits 8 8
+	run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
+	chk_join_nr "fullmesh add" 4 4 4
+
+	# fullmesh add IPv6
+	reset_fullmesh
+	ip netns exec $ns1 ./pm_nl_ctl limits 8 8
+	ip netns exec $ns2 ./pm_nl_ctl limits 8 8
+	run_tests $ns1 $ns2 dead:beef:1::1 0 0 0 slow
+	chk_join_nr "fullmesh add IPv6" 4 4 4
+
+	# fullmesh del
+	reset_fullmesh
+	ip netns exec $ns1 ./pm_nl_ctl limits 8 8
+	ip netns exec $ns2 ./pm_nl_ctl limits 8 8
+	run_tests $ns1 $ns2 10.0.1.1 0 0 -10 slow
+	chk_join_nr "fullmesh del" 4 4 4
+	chk_rm_nr 1 1
+
+	# fullmesh del IPv6
+	reset_fullmesh
+	ip netns exec $ns1 ./pm_nl_ctl limits 8 8
+	ip netns exec $ns2 ./pm_nl_ctl limits 8 8
+	run_tests $ns1 $ns2 dead:beef:1::1 0 0 -10 slow
+	chk_join_nr "fullmesh del IPv6" 4 4 4
+	chk_rm_nr 1 1
+}
+
 all_tests()
 {
 	subflows_tests
@@ -1698,6 +1772,7 @@ all_tests()
 	syncookies_tests
 	checksum_tests
 	deny_join_id0_tests
+	fullmesh_tests
 }
 
 usage()
@@ -1716,6 +1791,7 @@ usage()
 	echo "  -k syncookies_tests"
 	echo "  -S checksum_tests"
 	echo "  -d deny_join_id0_tests"
+	echo "  -m fullmesh_tests"
 	echo "  -c capture pcap files"
 	echo "  -C enable data checksum"
 	echo "  -h help"
@@ -1751,7 +1827,7 @@ if [ $do_all_tests -eq 1 ]; then
 	exit $ret
 fi
 
-while getopts 'fsltra64bpkdchCS' opt; do
+while getopts 'fsltra64bpkdmchCS' opt; do
 	case $opt in
 		f)
 			subflows_tests
@@ -1792,6 +1868,9 @@ while getopts 'fsltra64bpkdchCS' opt; do
 		d)
 			deny_join_id0_tests
 			;;
+		m)
+			fullmesh_tests
+			;;
 		c)
 			;;
 		C)
-- 
2.31.1

