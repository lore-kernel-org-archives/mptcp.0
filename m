Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744BD15495
	for <mptcp@lists.linux.dev>; Wed, 31 May 2023 14:17:00 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-30ae5f2ac94so4252450f8f.1
        for <mptcp@lists.linux.dev>; Wed, 31 May 2023 07:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1685542618; x=1688134618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FosYugMc1vHCoZRWt/IlbtAVQADqr7cjqn4iBHt+GUs=;
        b=TQD8NpRGa+mm27D6kV84P0jhXrf5jUurB40TVU5QdfFHaVoCeAB0xaYRgWl7y4cxnq
         MTILLpx4J4FZfWyLDhu36Ill3QiYL7YmTFI1/Of+mczqTvnkeYP1j92mK+PE7qiMhcPG
         +TWHWLP1C8EdXaXOOXEk4aStunLhkXCtoH3dPb5JaX1ehN+R0UgyPTegLF1/7AMkO4CG
         L3UxTrufyav0heOVCO9r2q/8KI3CtW/lmVWmkG2tWhXcc0Rh2y1vECAy8csplZjIyVmD
         D/kgk1r4/ZKrEvkK/Rx1bl2MUWexQpPMNndq6s0Akczxnbd9tGmGnAK8dOEbn81LpFyn
         cM0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685542618; x=1688134618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FosYugMc1vHCoZRWt/IlbtAVQADqr7cjqn4iBHt+GUs=;
        b=S28u23XK2u/KUsNyurKPHNT0b+6xa6wSmMdISiGyiYxpZ/oJvq6fdyJyN9r764ov+7
         bJoyI7vaZyVQ6yChs3zq7o9PD9/qlfSObOfA50v/Gn+EVwP731h6E37ftChUnNfweOzh
         8ZXE9LW/amqPXaOw4u1E3FqoBTd2laygXEp00d69sFNsFRGq0/Fu/lp5c3svltuqvr+3
         hDylHVAksDdRWiQMIFVS6acIYRuXWWONVEaQW/22JLfN5gBmJNNJH25aimOjTRC23UTZ
         mx+iwBUTtLL2c8mX0vxoq35bYy2BnmEje5cTQ0GBR1YfJi0UDUyuUxnQMbfd/Uy0/cRV
         344g==
X-Gm-Message-State: AC+VfDy3PFCBx051or1nMcXeNfEvChG4lQbcm58MNpiDbLY7IVhBm/oH
	rRigpvoNBTZGSXAC8YtNJkVBPw==
X-Google-Smtp-Source: ACHHUZ6MqlBbxPUg3wR+b7gTMYzphb0OFBH3ZorZXXjony8VgP41iHHPXcAYMewgZaaUnPGy7IcaCA==
X-Received: by 2002:a5d:510b:0:b0:30a:e589:689a with SMTP id s11-20020a5d510b000000b0030ae589689amr4307853wrt.18.1685542618777;
        Wed, 31 May 2023 07:16:58 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b003f4283f5c1bsm4242215wmb.2.2023.05.31.07.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 07:16:58 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 31 May 2023 16:16:49 +0200
Subject: [PATCH mptcp-net v3 29/32] selftests: mptcp: join: skip PM
 listener tests if not supported
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v3-29-a1f05258292b@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v3-0-a1f05258292b@tessares.net>
To: mptcp@lists.linux.dev
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1296;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=SRpEfaXAZT5at9Jost+GuTwzhMqHEhirGcMcsnW5Uvc=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkd1bEENSoGFK4m4SGkP4UD9SVUMt+5ls2Y4Hsd
 3jp8YG0aTqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZHdWxAAKCRD2t4JPQmmg
 c98KD/oCGLdPJfSHxa6WmlN4528PE87ylnWxIyt4xWjUZQ2sOli1dDdPGKUWFMUOBQfFG49/7qg
 oEi8+Ad9rmkJ0yo7C8BuXF85JD7+ko1raQzScqdDGWmmL8dg0PDBAsfkJMZSdB8VGvvf+oxvcsE
 YrQSjNSN5JpnE2vBvFu9gME/pL4Yh0PksHJsRLmUKjkCftZhXMH4qOScvAqGWqvvmtS90/k42ys
 kEKmwV6/CEoDH+Do82E+YY9VSg2kEln9TeYtJpV8uQ1zEY/gZ8AvnV/QOsofkUcD2dWFJXOVOl9
 dkfZc5i67u9FyMsz+b7tkozStieTrGcwMz+jWkqF6A46jLTsjSsy41gisVDL2fRRCJXGE69GZCp
 7hMp07SkU2/uH3Rm8+SX7XuZbsmG4sYRCH3iYGhveLh+XZdX9v1xkwk+oVVcz6ykCdYUs2sszWZ
 R/eGdHqxZRUiixYhjUQT/i7Yr+9JwZAJKMSZU+7eq9Ca/5YMXni9a4qNVM32MhTwJCsgeaEfskf
 boj1RiF4R0iCbFwjyD2egrIY0ByQOAxFZWe6te+PL5AIkUWDkn8jlvbFOQrzMmyaQ2FZPqfvSp6
 eZIuIEzrYF6rTU814tCKsq3mNo6ZZlP3g48bvRi10g3p51QK0q4n0w2y0AZrK9eLFZ6QVJSyWWS
 Ry6Sh3AdGbqCRPw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the support of PM listener events introduced by commit
f8c9dfbd875b ("mptcp: add pm listener events").

It is possible to look for "mptcp_event_pm_listener" in kallsyms to know
in advance if the kernel supports this feature.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 178d023208eb ("selftests: mptcp: listener test for in-kernel PM")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/mptcp_join.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 82281d59ac10..9d6c4c1ecff1 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -2783,6 +2783,11 @@ verify_listener_events()
 			$e_saddr $e_sport
 	fi
 
+	if ! mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
+		printf "[skip]: event not supported\n"
+		return
+	fi
+
 	type=$(grep "type:$e_type," $evt |
 	       sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
 	family=$(grep "type:$e_type," $evt |

-- 
2.39.2

