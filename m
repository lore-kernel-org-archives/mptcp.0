Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6B5154AC
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:17:01 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f6dfc4e01fso60169315e9.0
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542619; x=1688134619;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzOqcrpp1aBwEdVLatY2wRCqPf2hNfs2AEQzf9ECYWE=;
        b=UuwKxaKY4ZxxrjNdPGKduu2Y609ParjA0TMpgk3I7emPnJk1Tf9ds5K/ieDJdFOkUE
         NnSUoZ/fHKodZXOGExthp7G4iMPbOMMDcclY1rrK7IQNbWD/eKmQzb3UhuqhYb9uB3zJ
         3AJeM8wchWO2zPLMm9IkTcShSPTvoRXm8r1ZMCmhizyLsARxzRe2oifV2FI8/UGvES51
         l/A/Z/T5Z+6soBUG2kM/Fwitman4632ovwWmXhhKzE+I3edWduRZ/cPXjQEUYEOONSQz
         dry/ds1jM5MUvuYSIaICia2e7iPmbGB/piW5OGB2kOKpUJZWoMhZUa2NW2ytb+zk3v61
         v+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542619; x=1688134619;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BzOqcrpp1aBwEdVLatY2wRCqPf2hNfs2AEQzf9ECYWE=;
        b=dFa4yCVltEZwDiTieOQr19aAaobtpHkFs3y2ja/Kyu0DUUeW+DOVL9z9/HNigMHfQU
         EofALZXWNMv3KUu/VHSBx+Piuu0jWrX21AweJ7XRO1Q2t1TwwL9maxIsCNhDz7p7JNLj
         xG/t7sujzCEIyhFKTKgasPhlDn6dIggUFb9+eLI4j2+1Q/8KV+dv0bS03G8iKPvdk/8C
         DMz9wxbz5G+DyF8rStV4gTXdfA9umeqh1VLoX4PHJjzCB8l4yDS40VJ0oCauhE4EAW1k
         jF2S1vGEq42ILo9ihrj8sVyibhVP1M5nKCkV0Zz6p0uQ22vvVnTXfZNo1pzvLfMQAqPN
         bTTQ==
X-Gm-Message-State: AC+VfDwd+a1GS5xvVxAJ5dWbYjVZNSJpUxDq4b03hoOO1U0FJl0w2unD
	hhXJ3tL2FvH4jS+G8uITj+xyzg==
X-Google-Smtp-Source: ACHHUZ5f/SFg4NHoy3oHdd/sxh6fAwVaUXPddpdPuEDGcGJx82pCcV9+199g29FB41DzMS/a5TP6aA==
X-Received: by 2002:a7b:c5c1:0:b0:3f6:2ae:230e with SMTP id n1-20020a7bc5c1000000b003f602ae230emr5249953wmk.3.1685542619463;
        Wed, 31 May 2023 07:16:59 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:59 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:50 +0200
Subject: [PATCH mptcp-net v3 30/32] selftests: mptcp: join: uniform
 listener tests
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-30-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3211;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=YeEsUgrX8hLox1KFJNTucCReLP+W1L9fRF0FBuTfe0Q=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bELCDAB5kZtMmoGr2VSKMKmREONwG3TCXoN
 M5Dc7tqZjCJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWxAAKCRD2t4JPQmmg
 c5n1EAC7W5C1wphqEDJR7HjFGfA7ieVUIH+oS/lzD5JQEkKI66j5AsZ0195AOXW0xzYhdsL43wf
 dI/W2Gq3uyArVzc2dNdV2KRmuybZEDVio9KBpLwk7Zi36cd7caR5bD53gszsdlMHgj15dlID46V
 vU5qcGK/oKemubAZq2bZneeTbrzJB0wFqRGsnz7BX4sUuYvwdjzii5T5zUIh1XSUodVvz/DWiek
 aEeOHigIFiTpVrKgHWywe4OkipI82cSPM2Yk1+Njjyo4Cr+hBOnWTbl+22pgSmBPCi98lgJz/p+
 ON8Ig4vJufw7l4tlXbeLzgxS2cEPiaceAKgIAfCB/OmioJ3iULE0rp0M9k4YNgSInwP5PQOUJ72
 IHFEwdi4y6MMd5rP73fNEjjKhCyfMfmDM2Naxmu+Dk0bhCGe1vyvllF6TGLz0REWumnYK4i94zq
 bKN7lWaJVTXT2oxcPO7jxTMXWoR3WwEtRPJYDyDYxaXNqdJtwOIzCY9jKfMXXAZYsCRe07sCq9i
 Ku5CTbZvxRYCnXtr2z7QD4MUNV6GOld0qM3G6mWe4QD0Qwy+F0g/ECUdjvTCe0r3NjvrHgnKdnU
 BPGMTbfDRp2BH7wTumOEhik7JfuB8vQwPWSTB6DNdOMAmrdYt/pK1+PwEGLnMed5kVZGhlbH8I/
 oEALsuOGh9oa+bw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The alignment was different from the other tests because tabs were used
instead of spaces.

While at it, also use 'echo' instead of 'printf' to print the result to
keep the same style as done in the other sub-tests. And, even if it
should be better with, also remove 'stdbuf' and sed's '--unbuffered'
option because they are not used in the other subtests and they are not
available when using a minimal environment with busybox.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 178d023208eb ("selftests: mptcp: listener test for in-kernel PM")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
v3:
  - new patch, initially to fix the alignment but while at it
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 30 ++++++++++++-------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 9d6c4c1ecff1..26721ed7b797 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2774,43 +2774,41 @@ verify_listener_events()
 	local family
 	local saddr
 	local sport
+	local name
 
 	if [ $e_type = $LISTENER_CREATED ]; then
-		stdbuf -o0 -e0 printf "\t\t\t\t\t CREATE_LISTENER %s:%s"\
-			$e_saddr $e_sport
+		name="LISTENER_CREATED"
 	elif [ $e_type = $LISTENER_CLOSED ]; then
-		stdbuf -o0 -e0 printf "\t\t\t\t\t CLOSE_LISTENER %s:%s "\
-			$e_saddr $e_sport
+		name="LISTENER_CLOSED"
+	else
+		name="$e_type"
 	fi
 
+	printf "%-${nr_blank}s %s %s:%s " " " "$name" "$e_saddr" "$e_sport"
+
 	if ! mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
 		printf "[skip]: event not supported\n"
 		return
 	fi
 
-	type=$(grep "type:$e_type," $evt |
-	       sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
-	family=$(grep "type:$e_type," $evt |
-		 sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
-	sport=$(grep "type:$e_type," $evt |
-		sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	type=$(grep "type:$e_type," $evt | sed -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
+	family=$(grep "type:$e_type," $evt | sed -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
+	sport=$(grep "type:$e_type," $evt | sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
 	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(grep "type:$e_type," $evt |
-			sed --unbuffered -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+		saddr=$(grep "type:$e_type," $evt | sed -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
 	else
-		saddr=$(grep "type:$e_type," $evt |
-			sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
+		saddr=$(grep "type:$e_type," $evt | sed -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
 	fi
 
 	if [ $type ] && [ $type = $e_type ] &&
 	   [ $family ] && [ $family = $e_family ] &&
 	   [ $saddr ] && [ $saddr = $e_saddr ] &&
 	   [ $sport ] && [ $sport = $e_sport ]; then
-		stdbuf -o0 -e0 printf "[ ok ]\n"
+		echo "[ ok ]"
 		return 0
 	fi
 	fail_test
-	stdbuf -o0 -e0 printf "[fail]\n"
+	echo "[fail]"
 }
 
 add_addr_ports_tests()

-- 
2.39.2

