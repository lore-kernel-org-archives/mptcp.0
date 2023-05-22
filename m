Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CCD134B0
	for <mptcp@lists.linux.dev>; Mon, 22 May 2023 16:38:28 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3f605d8a8a9so11272885e9.0
        for <mptcp@lists.linux.dev>; Mon, 22 May 2023 09:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1684773506; x=1687365506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hlWfw88eYnHZQLPYDvP0JzIhuYT6IbliwX/cY1enyT4=;
        b=4BopQGhItDmqI1i2zwL4NgwyistT3pMmBkciTZU7HKR1qPSBMKB44oNidfhNO0Q1ET
         65YP/0QE8Bcgp2XLGUzEnppFn4Dmhx0R7M4QnatdUEomfsevBEUDazJn2CaNpY0oVeSe
         C5thGzs1Z9XmI27wP6lmk7/PGHI1p57LajUMBIMV8rhPm4rZwA0NJ7/1sGApFFLkU124
         6oTzeMmvO3iACsIkX+1eWbteqPkFxFuIbObbrpNMIYEwX6zDpCy3ApjGINQ5pcSWXmLW
         GCS3HdBt0LU67YiwCm/7qwI9sVCpYOGWAkrGcsa6e0ORw85oUFijhGai3+mYaJ5oMkvm
         wf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684773506; x=1687365506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlWfw88eYnHZQLPYDvP0JzIhuYT6IbliwX/cY1enyT4=;
        b=AG/zTYKJ6YIy6qLLiMjuSLL3hHBlHAphTH5JoJkbMBAUJ4eHwH+ZL2cSPUFJI0aF7R
         JBGCHgl9xuh0RgAkiC+Wo2ZOSzh6syZhmPOetTg5I4iuhjzfmWcbuPe5qSC6AK+fYprr
         QMaVwsYo+qhLi6C+H0w988j62J8SVW97UhseRnx4GXonNt20kVHFSiZLz0r/A7EsM0dv
         5U/Neghktxqgtl9uxgtdrWSmFqpvbuu/hbE4eKIOMw9V0AcgKJGjPHZfT6jIWPn0N2Qa
         A2sGhBkXmjomT+pcWHwHmJrwvPTearuhCeD8tDNU3ywDgLGRzTEyX/PSWNqJ1sf1lHab
         52rQ==
X-Gm-Message-State: AC+VfDw3mkBLfO06XrAQPb+5iKv/xxiDksYBiDH0cCj2/rxTyIAH+nqq
	8S5apLp6JtA5NAt0Gu97A1QZ4w+nCUOk4T5YT9kxWw==
X-Google-Smtp-Source: ACHHUZ7S8uU4MxNs0/aBnJMvlce5McbouOD7hdFsXPxTk74YnBnqvNF4aDXPrspUuCoNweYN2Iu4OQ==
X-Received: by 2002:a7b:ce0e:0:b0:3f5:1bca:345a with SMTP id m14-20020a7bce0e000000b003f51bca345amr7849200wmc.21.1684773506543;
        Mon, 22 May 2023 09:38:26 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003f4ecf1fcbcsm12028808wmk.22.2023.05.22.09.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:38:26 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 22 May 2023 18:37:54 +0200
Subject: [PATCH mptcp-net v2 22/37] selftests: mptcp: userspace pm: skip PM
 listener events tests if unavailable
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v2-22-50313e4f83ab@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v2-0-50313e4f83ab@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1621;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=wo1JLrvXXpEhA/1pGr2BkFQUY2u/ZSynFAbghLPp0/k=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBka5pwBbMy7JUsdVVFJyghdyXeV7UlsaP6NMGgm
 S/9Irr/B0iJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZGuacAAKCRD2t4JPQmmg
 c+8QEACQJPsYLmQxjRzSB/Hw+1NuTyvXj0vCcEgu0afxSZeyJfBPtGC1HVP7Aj3kFjsG1zjgWuF
 rQqvVa605guQ6jLUVqGp94GiyLZDUS6xFP+OXg74X+SZSv9+SGZN7hjhokVa44r5JMNPscNLkaf
 cQVf+INqbBB+JjX7/qxV+gcmiISnZwqN7UrA2FFYzaVtBBUaor/SEs9wJfW5bV3pSKYCaLuJ0vu
 g75j5a0FEzM4CaStHsYs29SfP+BYrCh6DgqCXs1pfjugJkdOh10Jyqm5BqfYACqXr6LhxOgTwpX
 oG5St03ey24SlWZlvzcmfI+6k834ZaUAIOqOaN78UO3vHdkVSmmbCSPHp+0gzHt+aSxHMQjN4hX
 Zci0zAQDhfLuT6XGMzsXVf9Wl+KlKn4T/Brw6FtUzbO4BXqUgwmL28rHTQypZQdXIkJaeyh48wl
 2MBFSaEu6zZOTb52Kbfv2PH9vzC+UyyGE6JIsfffIr4HHe8rR9272FJzzV9xXTpL1LvFa+cCQAf
 gpc3IIjjKZPz2hYz9lmA9Qe5OHAJHi0N7ylau96SrbHGRNj1w2gIy81qA65grpNsxDFlG8OWjAT
 m93hxDzYZvRlYNTRJ3FALVvRlEAlFLZPJidw7mILbDeRWLoNF5B9Jmt2DX6+zCbNVtZn1GV+FJM
 IttLcdyJypb7D3A==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the new listener events linked to the path-manager
introduced by commit f8c9dfbd875b ("mptcp: add pm listener events").

It is possible to look for "mptcp_event_pm_listener" in kallsyms to know
in advance if the kernel supports this feature and skip these sub-tests
if the feature is not supported.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 6c73008aa301 ("selftests: mptcp: listener test for userspace PM")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 38a1d34f7b4d..98d9e4d2d3fc 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -4,6 +4,7 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 mptcp_lib_check_mptcp
+mptcp_lib_check_kallsyms
 
 if ! mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 	echo "userspace pm tests are not supported by the kernel: SKIP"
@@ -914,6 +915,11 @@ test_listener()
 {
 	print_title "Listener tests"
 
+	if ! mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
+		stdbuf -o0 -e0 printf "LISTENER events                                            \t[SKIP] Not supported\n"
+		return
+	fi
+
 	# Capture events on the network namespace running the client
 	:>$client_evts
 

-- 
2.39.2

