Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CD4BE52
	for <mptcp@lists.linux.dev>; Mon, 17 Jul 2023 13:21:43 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso46376595e9.0
        for <mptcp@lists.linux.dev>; Mon, 17 Jul 2023 06:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689600102; x=1692192102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMYqkxWIYu5KTvAokD8pnktzM+OKKPedMmVuaO0OtT4=;
        b=NRPbI6f+4ikR9vYJqGEukPb/oBjg3npV7TBn/SG/vMRQOtIjiX0Jjc8qsxTcRXGkaU
         0Kt1MiaMGKwka5J//6+FgMXDKQ0kq3wM9Y3NHTBTeKDVv8A00aZM/iQMLHTfXgSJbhYN
         IpDRqaLlYnY4Hn275XzxqIK7Q5o5TbUq17ooxjF4DEIgUqSGDo8ZN+AbmOuVCqLf9ZhL
         PNrwlytnl6EADP3i08E06rHqOEo0O4RjPonUoYDV0FWRpH9T2DrAY5GcLKhKuKJIrp41
         zkY/o6DwI1g3138KXhhSAzUM5Y5gEj/oL36wKY9F/KxJ3GurduHqie6PtG61eF1W38Es
         nnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689600102; x=1692192102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMYqkxWIYu5KTvAokD8pnktzM+OKKPedMmVuaO0OtT4=;
        b=YfJ1Vxheh0F+M9qD8nH+tGQTBrOGgsp2sK4LLeTKjc8hHMObjydKNtV4PLTWS80ZE3
         s73J/fAQLScsOGTH0jgosu2Moygo7Nxz2jRje6dXGdQWukqcSJx0wBK2qeXRcd1CcY3H
         +9UKSsGNHkwKiCf+2SXKD/za7IB1WOnMCPrjrNSI64xs6ST7RM55/hY+kiQMAUp8Hjr9
         qtEjaRFYSQd5QvBpPkEB7eCgi3XhyXtOqiV/mZ/nWhvdkw/TaTNIgGru9xqucKMT9sMI
         0Ys17INxouvqE9h1eGlijYEvdACVuqJz9fGPTUNw44keCKD71AkHgCLR8ePcOxpm16kU
         /FfA==
X-Gm-Message-State: ABy/qLZwifZ4DMwI6Ve/wufq+1pKTY1HxhQwEcAdnBPgYBe9srsIthay
	YlHQvFBUm8D9wjhNX7cg1UOLUg==
X-Google-Smtp-Source: APBJJlGWXDewmTh2XPOoBWfj2m7agljI6siZePfZdGX5R1XjW4StXbCub27vjebnIBRek2PmFhBbrw==
X-Received: by 2002:adf:f746:0:b0:314:1e69:f4b3 with SMTP id z6-20020adff746000000b003141e69f4b3mr11103133wrp.63.1689600102234;
        Mon, 17 Jul 2023 06:21:42 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b0030fa3567541sm19249836wrx.48.2023.07.17.06.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 06:21:42 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 17 Jul 2023 15:21:28 +0200
Subject: [PATCH net-next 08/13] selftests: mptcp: pm_netlink: format
 subtests results in TAP
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-8-695127e0ad83@tessares.net>
References: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-0-695127e0ad83@tessares.net>
In-Reply-To: <20230717-upstream-net-next-20230712-selftests-mptcp-subtests-v1-0-695127e0ad83@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2242;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=YF5+l2Jr0Lpa0HjBD3ZjYiqWlLs2/NctDcK1fgz7k/4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBktUBd2OiEZ8xkjjR+HS2zL8y4EbaMpHDIxgrWe
 TaPAWqfPpKJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZLVAXQAKCRD2t4JPQmmg
 c2VkD/95ir2rvMg4n3iYaiyORQSKsIwGTjNKhBpO5RaKO3At8bKrW368AQgxbhZAMECTm8GlmNV
 lENKRCWlx+MyMn6BqLvsTDTE/nNYof3zDZWQWnWqp6SAI7T8A2M/GAnqBNEDB60vpv1ePttH14v
 ABojciSqKy3nutP5TmnAI6sa8YjNF5QTFt9HpCGQmSDBlafDTIqIWI2x17FgQhBG/uCIv5iUaJV
 h6zUM7x3yEz9TkAA9JwCiA6Zk6/OIJ6PD3RnmfVuZaUX4j10Jek0Apr1PQZ8YwsDv1pJB6oEeNm
 1ohiscbymwzXEVszRnEa1a055zvV0X8QW8h8Wz8XtM5yQq7eWV4Zw8SICnXKPMG8/uso3Zp+KWl
 qervoRArTG/zzntBHMo8t7ZYu7bS2MFbNBLoNcyljky4A63frK3lbOVAYSYDTd7cWH1irO+4eeS
 nxt4Js6qU/2b0LqZWl3pI9K8/jDYQUzahQjl0u4n+J+qlMP878PDvCqtyOHsoPwqskCZmgeXVnc
 iaTZb9F6XjZh7apR82t8xf5gPDRGs7MaJX6zJEcneuB26e2x1IchjcO8G/iKwTCp2oI1OSVhlVD
 X87JPyQHAo100VvK//B4NSfo/ncnskQ62LELx2r6dLWBFpyLNLOJ6KVa+xrUcMv21SEkVttZbLJ
 qXe6m9o+xA8Cruw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The current selftests infrastructure formats the results in TAP 13. This
version doesn't support subtests and only the end result of each
selftest is taken into account. It means that a single issue in a
subtest of a selftest containing multiple subtests forces the whole
selftest to be marked as failed. It also means that subtests results are
not tracked by CIs executing selftests.

MPTCP selftests run hundreds of various subtests. It is then important
to track each of them and not one result per selftest.

It is particularly interesting to do that when validating stable kernels
with the last version of the test suite: tests might fail because a
feature is not supported but the test didn't skip that part. In this
case, if subtests are not tracked, the whole selftest will be marked as
failed making the other subtests useless because their results are
ignored.

This patch formats subtests results in TAP in pm_netlink.sh selftest.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/pm_netlink.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index d02e0d63a8f9..f32038fe1ee5 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -58,16 +58,19 @@ check()
 	local out=`$cmd 2>$err`
 	local cmd_ret=$?
 
-	printf "%-50s %s" "$msg"
+	printf "%-50s" "$msg"
 	if [ $cmd_ret -ne 0 ]; then
 		echo "[FAIL] command execution '$cmd' stderr "
 		cat $err
+		mptcp_lib_result_fail "${msg} # error ${cmd_ret}"
 		ret=1
 	elif [ "$out" = "$expected" ]; then
 		echo "[ OK ]"
+		mptcp_lib_result_pass "${msg}"
 	else
 		echo -n "[FAIL] "
 		echo "expected '$expected' got '$out'"
+		mptcp_lib_result_fail "${msg} # different output"
 		ret=1
 	fi
 }
@@ -193,4 +196,5 @@ subflow 10.0.1.1" "          (nofullmesh)"
 subflow,backup,fullmesh 10.0.1.1" "          (backup,fullmesh)"
 fi
 
+mptcp_lib_result_print_all_tap
 exit $ret

-- 
2.40.1

