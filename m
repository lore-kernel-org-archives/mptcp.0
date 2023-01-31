Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5020E20F8
	for <mptcp@lists.linux.dev>; Tue, 31 Jan 2023 11:23:54 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id bk16so13861938wrb.11
        for <mptcp@lists.linux.dev>; Tue, 31 Jan 2023 03:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hUgQeK3fvqfAupOFuXWFrVHPMCd2NNNxc+S0EXuCEcg=;
        b=b+E2V4WHC2MoM5nVoSzseGtWYkF7iCTBX87818kiIDY14WQdtUw6VNPuEzamChlgfB
         hPAOXqb0fr0XVcvyYfhmfBKQ/gL3qRW7AMFwDzvSd+U2XOtRUEuUxM0rZSJtKlps4u0I
         CWRFfkXmAyVIQ+zuyM5CF8sD43OWM10MeTS/1XVIFmCuFLnapRqKHdyyy+nsigMuZ3J8
         9FLnNnMrjtekF84qsHumZHoTzRPxtPdd49cQUI3bPiMx7OMYIhSXdf8mpT6rcutmvYhR
         o3poS4J4Uw+JP4ECSbcrrRaAeO4h9K0qS0Tx7OnGLDThIWFqyCdbLqrEXPvVTJ6ZVVB5
         +Rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUgQeK3fvqfAupOFuXWFrVHPMCd2NNNxc+S0EXuCEcg=;
        b=ew8+CQWsl5CHtecZNb9EMhCK/7IKNICHyB8T3EN/pLKTa7cxx0uFE8v7+tOD2ZdIMV
         vPB6T85QHNk8+MLX3q5Lt26NGq7h5AygToESs/1AbhaQl/sf0hutZFJ9zpOPfkyiBpAe
         I9iuf42VB8fGULkOKsF0glHCHpRd7BtEb9lG0Mw+e4c1gY7WPP03DTaXGSEAyb05xl/9
         rvVW19Ewt2h0O4iGchIWPMs8FAP9DCK3GertmDjgN6WpRL7LhNG8S3U+UKXl8LevOvSz
         D0rU0Jtl5BpBYpqc8E9yrk1y+mWaQiVlvcgw4sXT7X7iJL6+nfQoCjUNGIlaRsCr/z+Z
         uRmA==
X-Gm-Message-State: AO0yUKWR2mecYphA98HKgL1/LX3MzaZma/ccAHZo2AdQW7NpKEeCnvCY
	+DqItAJtFMHmArGDipCRyORctHegara+YUXief8=
X-Google-Smtp-Source: AK7set9IqImnHENmGKfttNiag5dyJdaNq26zT8vS2STYNA26RU4K1Kz2YuDGpghIwuFsamb+bA1mzA==
X-Received: by 2002:a5d:45c6:0:b0:2bf:bfb7:2fde with SMTP id b6-20020a5d45c6000000b002bfbfb72fdemr19017322wrs.30.1675164232350;
        Tue, 31 Jan 2023 03:23:52 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o1-20020a5d4a81000000b002882600e8a0sm3140503wrq.12.2023.01.31.03.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 03:23:51 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 31 Jan 2023 12:23:29 +0100
Subject: [PATCH mptcp-net v2 1/2] selftests: mptcp: allow more slack for
 slow test-case
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230131-mptcp-issue-323-join-delete-re-add-v2-1-8de2421163c9@tessares.net>
References: <20230131-mptcp-issue-323-join-delete-re-add-v2-0-8de2421163c9@tessares.net>
In-Reply-To: <20230131-mptcp-issue-323-join-delete-re-add-v2-0-8de2421163c9@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>, 
 Paolo Abeni <pabeni@redhat.com>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1891;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=eKlBHTZfX33dERk04tQloaPko+YrgAKJmCUgq1hSJNc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBj2PpGn417c+V3Vhse1t6hsHuUZ2PEbL+te/MeK
 p3jX+85FpqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY9j6RgAKCRD2t4JPQmmg
 cwCLD/wJ3GKSXV4gag1AIuIppev0T8o2pcrHcUJcD49XSzh0xI2sxrCue02V4KVg62YWTwE8gxk
 H56ibeKC7e/az77kUherjy/s8gMPUfSz6PVIfbjNrNqvxZZkq5jjz5VZ1LhXsqit9lAmK8aa3Ed
 s90p5ZA838kb+9YLOmVGg1Hq+n+KvG/PtgT8KgRU+ZpOzn+TlcUu/dSD6J20GsOYi+3t2jyTXdL
 amf8V8tOgWEQqJ57mEkKM9E3OqlXHP7zaRfZyjb86Q+6+QPegqUyduNG3OWT9iceeMN3PON39Ej
 vSWfEkQLDqW2BGT/oXiJoeCf8r7Gl6c1q+ypQo9t4vw9ULf2Yi/ecUh36R183zlNwkR/1zWNoBy
 T9PDudBeXQXQoBm8tOvsSJp9o5rwxJHsLHuCdER1d7VHqUxATdbTp1FZGCYnBFrtWF+m4XrSr1G
 KZJpR1uGCfiBSu/XxEtV2ba2m8p6oaDG/X4AiLlOjdgVuAQ0sEr5HMsKLiJAuwTHXZytC4z94KM
 QoZP27ZuLpXFBfJHacjL0vu3Z+kzXLuumzwCj7V0HR9zIJxFrgngniEVrG87wvlLzYFwIMtcYIq
 qyYb2B2TkUI6OINtFXDX0BiaT2ohs11Wn254tDiV9ybZTf1zp/wCjiZPnCUP/aMwV4mx5HXMGSJ
 w+5woXhiLgmiLyg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

A test-case is frequently failing on some extremelly slow VMs.
The mptcp transfer completes before the script is able to do
all the required PM manipulation.

Address the issue in the simplest possible way, making the
transfer even more slow.

Additionally dump more info in case of failures, to help debugging
similar problems in the future.

Fixes: e274f7154008 ("selftests: mptcp: add subflow limits test-cases")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/323
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 387abdcec011..52484a7c286a 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -1687,6 +1687,7 @@ chk_subflow_nr()
 	local subflow_nr=$3
 	local cnt1
 	local cnt2
+	local dump_stats
 
 	if [ -n "${need_title}" ]; then
 		printf "%03u %-36s %s" "${TEST_COUNT}" "${TEST_NAME}" "${msg}"
@@ -1704,7 +1705,12 @@ chk_subflow_nr()
 		echo "[ ok ]"
 	fi
 
-	[ "${dump_stats}" = 1 ] && ( ss -N $ns1 -tOni ; ss -N $ns1 -tOni | grep token; ip -n $ns1 mptcp endpoint )
+	if [ "${dump_stats}" = 1 ]; then
+		ss -N $ns1 -tOni
+		ss -N $ns1 -tOni | grep token
+		ip -n $ns1 mptcp endpoint
+		dump_stats
+	fi
 }
 
 chk_link_usage()
@@ -3103,7 +3109,7 @@ endpoint_tests()
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
-		run_tests $ns1 $ns2 10.0.1.1 4 0 0 slow &
+		run_tests $ns1 $ns2 10.0.1.1 4 0 0 speed_20 &
 
 		wait_mpj $ns2
 		pm_nl_del_endpoint $ns2 2 10.0.2.2

-- 
2.38.1

