Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3E97481
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 17:07:03 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id r29so42764967wra.13
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 10:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680887221;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RWiCxDHHz6LUYCJ4tdY+XiUquNVgoQTsyvjrOYA+HmA=;
        b=Igle3DLqG/eP27NcZPNMBCR1tWThn1ZzUzDWK1PwKH2xrrEaIjHBl+LX1GWU3yfS3I
         JAW8uRwIbUwFqgnbQTcl1hCUqF08OA+1/+M25TR4h/O40CF4tQanROQHGWkZa1MpPTO5
         1Q5PzX6vjefxplwONi8TiA3yhbeoZizlpr8m3VyCtRw4zf6IbigYHz1+wS913Tnfnvza
         pbwaIqZEWpJ70EzcpRj6b7ozm1m2grnKPag27GGOCRiv7mfykGs3mcLtO9mYTtzzYVep
         Gtgd4zg6YzSWeMuAPzxAcse0b33DPDVMXnEMEeEZLIkFN5tHjvVlqfGpeXxx70j3ioo/
         vF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680887221;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWiCxDHHz6LUYCJ4tdY+XiUquNVgoQTsyvjrOYA+HmA=;
        b=nFYthuQbWl8EIxxwaECrS1h/EMjYe1TjDZu0fgYcPGUPJ/jD7g9p+9wzlJVq9F7v6S
         v449ZOBabdbFALppkSHuc8gYlr0khmgn45EGWk03zrxyTZWVFXgNOyGfD6ZUTkC9JDqy
         vJUpjFVV0tDG2tqQeq3UV2xflJFroI7zTHUaeTk1tNjuiGUSWms/dBWMt7O8HqaaP0bZ
         NMUA+58QONXJWMPU0v+zGHJzwoI7vLLGAgYBZdtTa+JT7sDZp9tcQoYEQnhWbowvaPUF
         Rbo53Ff8fKVy/M7c2oo1o36iPHgjE7HaHnn4wMCDCCBc3+BU5S7/0Wl3KRfDQyWUb9HX
         wzhw==
X-Gm-Message-State: AAQBX9fexhWQVQQthlvXrh20R1Zgj8pQTvv0AC7D1uehDTLvFIUi+maG
	7PXQB6T+gCfPmKueV0CGgQqQ9+kQlO11ulxf5DNxxQ==
X-Google-Smtp-Source: AKy350b9k8EAtSXzvcxX0Gsl8Mg+SgR01gjXo3su/gemxyA7kvhdsu7IaZqt2qbyClJRvIaq3fShtw==
X-Received: by 2002:adf:dd07:0:b0:2e9:d9a8:1a19 with SMTP id a7-20020adfdd07000000b002e9d9a81a19mr1758965wrm.5.1680887221407;
        Fri, 07 Apr 2023 10:07:01 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id t5-20020a5d6905000000b002efb4f2d240sm908360wru.87.2023.04.07.10.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 10:07:01 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 07 Apr 2023 19:06:46 +0200
Subject: [PATCH mptcp-net 12/13] selftests: mptcp: userspace pm: skip PM
 listener events tests if unavailable
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-mptcp-issue-368-selftests-old-kernels-v1-12-246ac567724d@tessares.net>
References: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
In-Reply-To: <20230406-mptcp-issue-368-selftests-old-kernels-v1-0-246ac567724d@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1108;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=TEFu/15eR5xA13pwqlWNOYVg4ZYhyZXdeDA5Jy5/ZDE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkME2rwlx65Sl8jCYu2ZQPn1xl9IvjU+XZBED1K
 ToPjZxinEGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZDBNqwAKCRD2t4JPQmmg
 cyczD/9d2Tv8VhKU9SrLx6mZ9Tu7Ob+XW1EUI4A0hwFKVMB7Ghl6i5Yn/5a6xqylSxCIMt4lVaS
 2puIcqcwcaKYnTKFvEOCf1DSU4+IW3R7dP9m5Lo3+hutuYFScM/4BNfLBhK6lyBKoUOoRACwXoz
 qlDKbkiGm4aabcP0j8TvZZqkGfGFJSPJ8ebrFYnbyfKSpa5S7KlFjMQIQcQ+MBtHpE4ITa+7KsM
 KYO6Y+8B68VfrCtOWMPYTdZH0FRTRMGwZ9nfr8UZI+TM7vUlkMgVWLwQbvSM6emYnN7EITrFv2I
 ywp6BA2rlQsNkV00C4X/GNfKgx3KzczQ6xkJ+Qh8BwPVoj1rf67JB5mceL4rWMe9ChxuANZU4QT
 2EDmusVKTz5d8BJf76zIuh4xfydl+99RnLlIpIJx7OqA4kk3tcT4ECrDfakltSXzqvpS06QW3Qj
 4hThJ21E3jc565YQ16YZP82BHyblD5Ds32ukDVdYxA8tyJAz6WzJctupauRKWRd/QvfJEpzEIf+
 8T8PaWwdd6yvshVyinBr8/LVWb7rETR8inrSF74HJnmilPRmxaPshtHHkIJ8YQL4bIIQW8eUKms
 fzn///9GUHFz5cB8E3Xy7YE5PHYLvRsUkT6YLsvGIidjSexMoUPhf+lyCGtiLfmJ6AQL7QYZib2
 8urboga9UjtwKaQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Selftests are supposed to run on any kernels, including the old ones not
supporting all MPTCP features.

One of them is the new listener events for the PM. We can skip these
tests if the feature is not supported.

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/368
Fixes: 6c73008aa301 ("selftests: mptcp: listener test for userspace PM")
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 tools/testing/selftests/net/mptcp/userspace_pm.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 12556051a72a..015319b705a0 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -915,6 +915,11 @@ test_listener()
 {
 	print_title "Listener tests"
 
+	if ! mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
+		echo "SKIP: PM LISTENER events not supported"
+		return
+	fi
+
 	# Capture events on the network namespace running the client
 	:>$client_evts
 

-- 
2.39.2

