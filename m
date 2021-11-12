Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678CA2C82
	for <mptcp@lists.linux.dev>; Fri, 12 Nov 2021 10:42:38 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id r9-20020a7bc089000000b00332f4abf43fso7024491wmh.0
        for <mptcp@lists.linux.dev>; Fri, 12 Nov 2021 02:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+0Lw12uV/fKrS7/Uhy7Z+cRjX/PrgsjjIMSN2nKh4ao=;
        b=gaR3TDHwcaiu65mhF67X0tKhVbBDdfEiKI3wCee+6jy9izw1NQAbmCEuf4buGB1yQ1
         eBaVPoZWi63F3vHe5nbTsT75AKfMBM7XAhOGNJ5zi76FNSFHifRbD4Y9JmWqb9Hu7kHu
         Njur6DlM+wl1q0ZI0R2bDS+Dkahi8C9MU3ujQA/mzhuqgdugHINgiHk5zPmRd5F0bZR1
         1C5DwwjPpsjkUOeSP0lJnAmFI/TEoRflmsBt3inrtB1wl7kIM84ckhpQojOFAMiqSdBi
         oWlTVIAclKWzjKpwdMx6wWL8faNQgbqlqlX8khEM0v10++myKASuoMo8l0c8tKnI4I4U
         yh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+0Lw12uV/fKrS7/Uhy7Z+cRjX/PrgsjjIMSN2nKh4ao=;
        b=woYgNxEfcY/ry1PjUP65bwctlV9slFh03r4B5n/LW2K4HNj7oHG6kI0VoKtUu5S8Fz
         vOyVWOaYnEOjNJGpkzkrb+09hwfzOxOjH/zIW/4axGG2UJm9TtNIF6KUGBYqROOZHuT5
         lLrzLKSwygBrgXiB9iWofFZU6aZCwpaDAwyOFoyUpbljuROuvbU7sfT2xfdr31nctP1U
         IMf+bksI/oS5EigbBpFSY7TTii+4O7q4JL+MtTF1ENtbPLctF5o3Ikhy1umSHDke9ure
         Bw0JDOOW2Z3cPxEY9eSEcXv5AdB3+HZyZOjsXt3k4CNv3p1LoiShALvsYvTx0tIURbgp
         HXPg==
X-Gm-Message-State: AOAM531pUtD43it+Zd8AA4osiqN8veQmZibEF5DT0sDYl+EKKtmMH7/1
	bTD+HhF1RWDk9VYXCWIRE6xVDJAKfCTd6UHo
X-Google-Smtp-Source: ABdhPJziK6C7CW9i7oNxQ4FcyVZtZBKOg75sQsKKAgsCy6R0AcsyEicdmUl0FYqZgl2hi+h2d1VIAw==
X-Received: by 2002:a05:600c:1c07:: with SMTP id j7mr34758682wms.12.1636713756115;
        Fri, 12 Nov 2021 02:42:36 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id d1sm5056321wrz.92.2021.11.12.02.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 02:42:35 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH mptcp-next] Squash to "mptcp: sockopt: add SOL_IP freebind & transparent options"
Date: Fri, 12 Nov 2021 11:42:09 +0100
Message-Id: <20211112104209.1991721-1-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.32.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intel's kbuild found this warning:

   net/mptcp/sockopt.c:625:9: note: initialize the variable 'ret' to silence this warning
           int ret, err;
                  ^
                   = 0

We don't use 'ret' at all in this function, we can then remove it and
use '0' instead.

Fixes: 222f62c8bcf7 ("mptcp: sockopt: add SOL_IP freebind & transparent options")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/sockopt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index b818e91f2e09..fb43e145cb57 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -622,7 +622,7 @@ static int mptcp_setsockopt_sol_ip_set_transparent(struct mptcp_sock *msk, int o
 	struct sock *sk = (struct sock *)msk;
 	struct inet_sock *issk;
 	struct socket *ssock;
-	int ret, err;
+	int err;
 
 	err = ip_setsockopt(sk, SOL_IP, optname, optval, optlen);
 	if (err != 0)
@@ -653,7 +653,7 @@ static int mptcp_setsockopt_sol_ip_set_transparent(struct mptcp_sock *msk, int o
 
 	sockopt_seq_inc(msk);
 	release_sock(sk);
-	return ret;
+	return 0;
 }
 
 static int mptcp_setsockopt_v4_set_tos(struct mptcp_sock *msk, int optname,
-- 
2.32.0

