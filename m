Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923382CA8
	for <mptcp@lists.linux.dev>; Sat, 22 Jan 2022 09:32:03 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id s5so6756888ejx.2
        for <mptcp@lists.linux.dev>; Sat, 22 Jan 2022 01:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wiKxGhVxsNISAMRH82PbmIbZTtNQt0gphY/DFBwNz2M=;
        b=l6LgnfcqWCeR0riv3Rw2Vi3dXfkI+I3ILjEKqhXZiVZq7AyQS3OEmpOGmyEouosIhY
         QVkKrR0vLXi45kb3uchn7JRk0WQmdtalzd8QI9JBYwofYrFIQCT9Sy3egSSccKiAmb9E
         kWqaSC4QFP/P/kWQWh9b1L4ySiGXeRE6lp3kmYlQrqRz/2dPGJCDUcIvONvBgUM3Spzb
         ZeVQY7ocq8f7f0Nsl2ShNTNv8U9fBpcFR3NIMN16hxnMzwwaQHrWstXpErvgBk6HLeaO
         KI17RE2QcDD0imVbqejGT45By4lNmYMoM+rKwNhuznrKEtHrr18+bR/lOyslC3AxHbhe
         Io9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wiKxGhVxsNISAMRH82PbmIbZTtNQt0gphY/DFBwNz2M=;
        b=Rcn1x44UEXbeh2C6d7AgA1rgXBn1F0H6L/EtxhPSay2l68zIq/ueZHFrfMbbwweA27
         GcL7dUfyng/R9omwMUwyURNBPoWwVqxwZpp7DLEmfix6p0ixrpxgRjJwG1DmpIDriUwh
         edRcTEATVDPuPgOnEiu8vqyoWEICJSoa/A2h+j3MAdvVefzzugxB3GT5yfApXQC4/1oN
         4x6JsqZdmUkXXx28v9+UTtZJmabFq7y6XpjXZaQvFoxjEeK60naNBOMn/yP4XQr+BWMj
         MFeQtEGGrRzlu2UqFhnQiTQE9VW5tAqTLelQ5ID5bY0qoJdc1VroED/uncd0Kzp+zkMX
         hP8w==
X-Gm-Message-State: AOAM5322KfguMJj2Z4XoJePUk5t51HS4gOjSkrQ5Cgx59bC/u3E8ERcu
	xAQpQZMu6CmuqvJ5nVNOL+a30Gjk6BPDZWWi
X-Google-Smtp-Source: ABdhPJzzktRcEu1i01Tj9QDXHQCXPBo1+eAUR6nG2PSycc+XxrYIvPIDaeksp96EvRXpEK4gqlgRLA==
X-Received: by 2002:a17:907:60d0:: with SMTP id hv16mr808347ejc.500.1642843921715;
        Sat, 22 Jan 2022 01:32:01 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id e28sm2776994ejm.94.2022.01.22.01.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 01:32:01 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-net 2/2] selftests: mptcp: add missing join check
Date: Sat, 22 Jan 2022 10:31:35 +0100
Message-Id: <20220122093135.4023846-3-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220122093135.4023846-1-matthieu.baerts@tessares.net>
References: <20220122093135.4023846-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function also writes the name of the test with its ID, making clear
a new test has been executed.

Without that, the ADD_ADDR results from this test was appended at the
end of the previous test causing confusions. Especially when the second
test was failing, we had:

  17 signal invalid addresses     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                  add[ ok ] - echo  [ ok ]
                                  add[fail] got 2 ADD_ADDR[s] expected 3

In fact, this 17th test was OK but not the 18th one.

Now we have:

  17 signal invalid addresses     syn[ ok ] - synack[ ok ] - ack[ ok ]
                                  add[ ok ] - echo  [ ok ]
  18 signal addresses race test   syn[ ok ] - synack[ ok ] - ack[ ok ]
                                  add[fail] got 2 ADD_ADDR[s] expected 3

Fixes: 33c563ad28e3 ("selftests: mptcp: add_addr and echo race test")
Reported-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 76c45c845d3b..67be3e1215d7 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1342,6 +1342,7 @@ signal_address_tests()
 	pm_nl_add_endpoint $ns2 10.0.3.2 flags signal
 	pm_nl_add_endpoint $ns2 10.0.4.2 flags signal
 	run_tests $ns1 $ns2 10.0.1.1
+	chk_join_nr "signal addresses race test" 3 3 3
 
 	# the server will not signal the address terminating
 	# the MPC subflow
-- 
2.33.1

