Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591AB6D18
	for <mptcp@lists.linux.dev>; Tue,  4 Jul 2023 16:21:39 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-307d20548adso6403828f8f.0
        for <mptcp@lists.linux.dev>; Tue, 04 Jul 2023 09:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1688487698; x=1691079698;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EyHu++cEhaPCp3VvyjGuTARDtjcZgL8aNYiTavJYg/g=;
        b=lrJGQG3dP76bOpqIXZdaSJJVpaAHPwcGtC+yHxFlNIgjkGaJEBmJ5uePYzYTy9nuVq
         fSXZ0lkslD4+4xJNMfzgs4lRNder1Z6TrH6MxjvTnUVhq69Bi1wxnNcI0YGJz1TAKLbg
         XbEHcMvXHFUFjQP9/hkMoMEWC82qFZuIOv0BJRDCxh0b6Odr2ljYxJYKHaCbx4NTZgHe
         gnJmKEyaSkLKzzcwU5qTLWHmhg7hWigE5mVB1PnGMWeWjS4RA1tRLqZ/L4sfKeCb+AfT
         tbNp2JTJKbpLRCdvR3syCxCflpClxd/xggmnwomAjFeqEsRBHq/HbXVmCqCTdnpHQJQ5
         ALjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688487698; x=1691079698;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EyHu++cEhaPCp3VvyjGuTARDtjcZgL8aNYiTavJYg/g=;
        b=G8clYzKBFfC/P3aICctGjRQglYZ+WrTzzgGUza8Qh9yACbRfcj9gSZMnVhZxwyJ8iP
         alJgVSh8+ik4J/eIls1mQ2phS14EFnhdsY5Y6TPaGlkpOJOjM5W/FIv7P2qka+g2Lx2/
         2KVH7BJNFlNE1Z78JsadzioG9FiJGixH6rVsJwDWY2+t+owT2ZsGVZVEMEwIMt80S04o
         QHQQnkbz+umg5fImpZv9lfXcA02ENOEdX1nrT42EnixZWzrWMHXNJDT6+NgmmLKDKuGa
         LDmHmzEE7j8Ffek1mWxAZ3jbN4fLRjQm2EmO+5MU7TZPvwutQY38Mfwuw9KKaN2S9uLK
         W6oA==
X-Gm-Message-State: ABy/qLaYEJWfh7g1KQaVLyYU56U/Xt42C+PXaZcY9OX20UDxoYeYg1sK
	ocSvjSO4bRHLr3eurg+xcFeqNxOuCUYTmsRxZ2BwFg==
X-Google-Smtp-Source: APBJJlEeU0XoQNr42nYcvquzPvkBDOF3o5gSUb/OVNsi1fTlT9HenBYyZiXJsIOncogAwNdQZ555MA==
X-Received: by 2002:adf:f504:0:b0:30f:be04:5b5e with SMTP id q4-20020adff504000000b0030fbe045b5emr10730249wro.37.1688487697768;
        Tue, 04 Jul 2023 09:21:37 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id f12-20020a7bc8cc000000b003fbbe41fd78sm15225326wml.10.2023.07.04.09.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 09:21:37 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 04 Jul 2023 18:21:26 +0200
Subject: [PATCH mptcp-next] selftests: mptcp: pm_nl_ctl: fix 32-bit support
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230704-mptcp-issue-368-selftests-32-bits-v1-1-f4262dc1b07b@tessares.net>
X-B4-Tracking: v=1; b=H4sIAAVHpGQC/yWNQQrCMBBFr1Jm7UCclLZ4FXGh6Y8OaAyZKIXSu
 zfo6vEW7/+VDEVhdOpWKviq6Ts1OR46Co9ruoN1bk7ixLvR9fzKNWRWsw/YDxMbnrHCqrEXvml
 jiGOIkHkavFDbyQVRl9/Hmf55wlLpsm07U8tzlH8AAAA=
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3167;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=c1ZDFJJMDafxgcCOpuFzAE0nBAufpK+1d2IHqkeLcCQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkpEcRdLAi7Zuscxj+bxmOqrBkG3l9ZE4N+ziVx
 tjVX9fOX9iJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZKRHEQAKCRD2t4JPQmmg
 cwyKEADUJTLBRI9AXnq5zDY/TERttv2Voj60FToY6whpeZvmtXhlk3YmTbmaAip7qDk30Wu3eDk
 8pzRTLRbX5jBnxOWWMoX/xWMai0euujFBoLz1ScPWkLnSCijzenoK1zWobgFOxoaJHCzfaBzKgH
 t01mX0eiKDsAmxLXdkzF2eA9ZxAX9fMu5QMy+fEtOmcFOkezx9hGxos9NhSrM+qGqKVar/Qc67p
 7QVpxZJgFMQL0EZTNaJDD5B3gfqhJ0SzX1CxCFFNniGG2K9ZR6/f8rbBuPT6rVQA0gKdWxvPqME
 MPX/BRDBU7O0hJKO82tGGBXBoMjoDhccC1tqVJW67OrkfOAvUV+g/4oivowfA8XadyNGKB5wNd2
 mtdw7E3OpY/pvjURViwgOXP9td7GI4ncGOyqHYd0rqFzY9n6HBLybq3gNrzLwrT+x1/8NyO/6sX
 uXkXQzdrbWiQ/PM+QOEndqeuhpBIRgm7bwa09yntcQbl/ukQCvbWF1S01aLcRC9uJoapL5SsbZu
 mHirWnfG3/SGPd0GoA4fwt4vtwPkV2EYl2XpWFn+tH7JKZfPit1iU++v4Q78fTTEZ22cYQSwi7V
 tPixLb6MHrgCZajaoEQW1JfA5qcN+XagshnJBfHmDKRHMQOfY+OHmxNaDtcxcgIYpZ+Q3Yfn8tX
 pwkuUkgK9lrBNZg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

When using pm_nl_ctl to validate userspace path-manager's behaviours, it
was failing on 32-bit architectures ~half of the time.

pm_nl_ctl was not reporting any error but the command was not doing what
it was expected to do. As a result, the expected linked event was not
triggered after and the test failed.

This is due to the fact the token given in argument to the application
was parsed as an integer with atoi(): in a 32-bit arch, if the number
was bigger than INT_MAX, 2147483647 was used instead.

This can simply be fixed by using strtoul() instead of atoi().

The errors have been seen "by change" when manually looking at the
results from LKFT.

Fixes: 9a0b36509df0 ("selftests: mptcp: support MPTCP_PM_CMD_ANNOUNCE")
Fixes: ecd2a77d672f ("selftests: mptcp: support MPTCP_PM_CMD_REMOVE")
Fixes: cf8d0a6dfd64 ("selftests: mptcp: support MPTCP_PM_CMD_SUBFLOW_CREATE")
Fixes: 57cc361b8d38 ("selftests: mptcp: support MPTCP_PM_CMD_SUBFLOW_DESTROY")
Fixes: ca188a25d43f ("selftests: mptcp: userspace PM support for MP_PRIO signals")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/pm_nl_ctl.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
index abddf4c63e79..1887bd61bd9a 100644
--- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
+++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
@@ -425,7 +425,7 @@ int dsf(int fd, int pm_family, int argc, char *argv[])
 	}
 
 	/* token */
-	token = atoi(params[4]);
+	token = strtoul(params[4], NULL, 10);
 	rta = (void *)(data + off);
 	rta->rta_type = MPTCP_PM_ATTR_TOKEN;
 	rta->rta_len = RTA_LENGTH(4);
@@ -551,7 +551,7 @@ int csf(int fd, int pm_family, int argc, char *argv[])
 	}
 
 	/* token */
-	token = atoi(params[4]);
+	token = strtoul(params[4], NULL, 10);
 	rta = (void *)(data + off);
 	rta->rta_type = MPTCP_PM_ATTR_TOKEN;
 	rta->rta_len = RTA_LENGTH(4);
@@ -598,7 +598,7 @@ int remove_addr(int fd, int pm_family, int argc, char *argv[])
 			if (++arg >= argc)
 				error(1, 0, " missing token value");
 
-			token = atoi(argv[arg]);
+			token = strtoul(argv[arg], NULL, 10);
 			rta = (void *)(data + off);
 			rta->rta_type = MPTCP_PM_ATTR_TOKEN;
 			rta->rta_len = RTA_LENGTH(4);
@@ -710,7 +710,7 @@ int announce_addr(int fd, int pm_family, int argc, char *argv[])
 			if (++arg >= argc)
 				error(1, 0, " missing token value");
 
-			token = atoi(argv[arg]);
+			token = strtoul(argv[arg], NULL, 10);
 		} else
 			error(1, 0, "unknown keyword %s", argv[arg]);
 	}
@@ -1347,7 +1347,7 @@ int set_flags(int fd, int pm_family, int argc, char *argv[])
 				error(1, 0, " missing token value");
 
 			/* token */
-			token = atoi(argv[arg]);
+			token = strtoul(argv[arg], NULL, 10);
 		} else if (!strcmp(argv[arg], "flags")) {
 			char *tok, *str;
 

---
base-commit: 619c3c3e5a9b93d2a5f62298a592919b245db5e3
change-id: 20230704-mptcp-issue-368-selftests-32-bits-cf7cfe2d8632

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

