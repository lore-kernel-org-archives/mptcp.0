Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368A3154B1
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:16:54 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3f60804faf4so43298575e9.3
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542612; x=1688134612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rDRrmhl3LUqtgzY9FZl0YYoNHglP6z9UU++uOVVlMp0=;
        b=3rRXYe9V99LKQeGqY0qdcv0+I6ou+qhwPhhRNWg/0TWqx+v7jzw3fQX6Eo8txXmeha
         Z+cMKQcFzA3AABEIbWd9yETc+6P4Q4SFiid7vJrCZNx3+Qo1Xvw/gA1qj7+2Dz/W7H8r
         4tL5fJ+9djJq7+5cX+iAw41AKyxGSNcvbKVQ/Tp0l9xuarWEvIRrRl6f1ugvs8XzCNg6
         H5ZxWOZFzbuaC3DVLvq6rfdz223iFvIaqkBQrhpCgqmnQUmcJ2N9/Fi2CyskqHqMxJWj
         ymcm7SX6gbKueZFIsdiRhlrRP/zfeF4Ogr/F27p6GuU97VKxJD8Y8N1Mm81zmBzx0Kvu
         TtlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542612; x=1688134612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDRrmhl3LUqtgzY9FZl0YYoNHglP6z9UU++uOVVlMp0=;
        b=bi6EwV+qMu+YJCyvzYVfHpPatDVKNQ7Z4TdH25xd0Mn/nBw5hCDDxUJEgwQVJZcHdW
         hEHs86qYirkbfX3XlI6JVMv3+j+zYDrCzqPHnmNBysoz1Mpzf8GYeyxCdaNkZIAgAwoe
         Tb+ZTiApwL2ORjUGNwQ+r/O9kGnguN2PHhFykKIxQyC65pSnT8Vo0lEo8FKa2WEicrr3
         1M8K/7QgotuGqcOapsunaIUvIkzE2qxINjmcdKmcFlQerMiZcFeLHtmLZe8UirCBmccV
         LgKqt3iWtqDNFsYDdHWxbpUM7MktN2qVHLURdVS13NhReCa4MLryo2eP3uFrCTSde6HN
         zFpw==
X-Gm-Message-State: AC+VfDwClETBgBdjTNEbtWl9l+8vM8+jdCGK2GneJdC31JCYzoPjHGPP
	JVPZGLUUTCKbdJi6XPckk4H36Apg+/Z2mt21eYNEaKY+
X-Google-Smtp-Source: ACHHUZ7yVuj3UzRwtNUhTQJZpaUUuc/tnQuW45J2pP0YBbDMbR6cttCDCCyzUZxAcTtyef7HEvDdOw==
X-Received: by 2002:a1c:f710:0:b0:3f6:d2f:27f7 with SMTP id v16-20020a1cf710000000b003f60d2f27f7mr4392208wmh.17.1685542612463;
        Wed, 31 May 2023 07:16:52 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:52 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:41 +0200
Subject: [PATCH mptcp-net v3 21/32] selftests: mptcp: join: skip Fastclose
 tests if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-21-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1916;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=O2FQn4sQ+mT5J3YqyH6jh80X2sVp+Q+KIMHsdQuRbnU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bDDiGyjHdJTV99Rn4DqqciYKHFzhxW514uy
 CRD0KZaA7CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWwwAKCRD2t4JPQmmg
 czmED/9ecppqnn1ETjT4Y9Rw3+ENfVIORX00le/RwIBioaLup1eWEmmP+MlRUeG8a5io6HnGcnO
 nR4Qn0rTB9dfQ2+vrTpc1bnajg5T65slOD9dQ19wMwyabuHCFdU0w3ond73GgyvhIwulrGRANSp
 hX2yy9QrN/Xk8+jX/rbWA14P0hjWMWHyg4EXgZWaYmYqftwTgdcYIeFoPSUvBGI3eCCnpB3rPdy
 mpJgwTzipxEzX3p/flpPMXXQBpmAasHdHD3Cov8ptGCf2SwufEnCLwLVC8G3xmQWQRfgYAvLNdy
 ISNcTiitpovof6+7ldplW5ieEATUoc0xiUuM/RYF1Tk1T4rO3zn1p7VN19BuxGoLN/4ZqNb18aZ
 hVmluL7pRC8o8b9smE5wm2IQHNN8+BQysjM1ke49rDLjZDqcFovnd2jkV1zmwfYyoRYA3YrsH7E
 7p1y/F6R1jkH5LOONpZ2207SYg+mVFPDOh0Wbt8chUz2eFalGgl7OHYdSithRH4bno9kfNKI/AV
 EJnWcewuplKUCLqFQ+zUPdPxHczirDkJ2Hn+9ggB8nx2B+pjikYS+fYMjc7XnSEZkx2O5RN89KK
 vQkqTjictgqjokwnoev3iWfSJdNIcEI6SiQDwrv6EooI9UCzngTdOZqE2rlYONORbqc1mZy9jHd
 +l2O1xWD+/c+iRw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the support of MP_FASTCLOSE introduced in commit
f284c0c77321 ("mptcp: implement fastclose xmit path").

If the MIB counter is not available, the test cannot be verified and the
behaviour will not be the expected one. So we can skip the test if the
counter is missing.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 01542c9bf9ab ("selftests: mptcp: add fastclose testcase")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 443a186e536a..a2455d0e2abe 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -263,6 +263,19 @@ reset()
 	return 0
 }
 
+# $1: test name ; $2: counter to check
+reset_check_counter()
+{
+	reset "${1}" || return 1
+
+	local counter="${2}"
+
+	if ! nstat -asz "${counter}" | grep -wq "${counter}"; then
+		mark_as_skipped "counter '${counter}' is not available"
+		return 1
+	fi
+}
+
 # $1: test name
 reset_with_cookies()
 {
@@ -3130,14 +3143,14 @@ fullmesh_tests()
 
 fastclose_tests()
 {
-	if reset "fastclose test"; then
+	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
 		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_client
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1
 		chk_rst_nr 1 1 invert
 	fi
 
-	if reset "fastclose server test"; then
+	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
 		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_server
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1 invert

-- 
2.39.2

