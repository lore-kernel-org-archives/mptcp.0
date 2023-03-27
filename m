Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64721A5E
	for <mptcp@lists.linux.dev>; Mon, 27 Mar 2023 10:24:18 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id s13so4724137wmr.4
        for <mptcp@lists.linux.dev>; Mon, 27 Mar 2023 03:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1679912656;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y2s1w7wyWLGSvVLo9qSwfebzvJxleDF9wqQ5C6Mg9+0=;
        b=LAF+KhObcnPSGk1LwRdXy8N4PC2vgDedgGiRBOR1hBBUl7DIpXAI7fho5KPs1QwKTU
         wJn6mksjiFARUA01QQ+ENDAJZRTf9++WX7OH1F7mboN24oOKW0PFPTatS1iqVaefGfF5
         dOUfxHfazQUSllOvq/XUUnGzVr9QkEIU0E5XxRXLZF+OO+QX1BhOST50dToAhZHEW5u4
         2l8Z4WpsNcb4+h1lwKqgW75CYpm0L2hGH7wRYXlGI9X36yp6vKJFr/kRkdrAi2MBwa5K
         UWKvsn3tLprXOCpkVghL7N0v96SqaS+J9D/axf2c0JJ9VB0DXePop4HvMGZdxmJGImUb
         Geww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679912656;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2s1w7wyWLGSvVLo9qSwfebzvJxleDF9wqQ5C6Mg9+0=;
        b=vVVnZRns/8z9HDcNkha+GxS+abtrvQJuWxqLg25snTSWkO5/H5XWricOT5+oXlLHd8
         hbl1nWqHMbJiwl116OVjkl8+EqQLi6anaOq4xIGyYt8Pj9Vd1PBHAW/OdhriyVsMxIEP
         euprLu5eupCQy4LuAw1Adn9lwjBsXthlmBkJzZryoNxj1iksdItK6G3vfTSABf5fWb6k
         G+NT7P9h7J3Y7PY/iqD9OjG7ir6arceVTiplbfpus7a3psGATLrmq4lNu4OqFdOMZJ/V
         q4CFMvSmON/Q9E8mR4OZKTuwXtyZ9Wq/KMsMIDHPOMppc6xj+FdMb3lrGJKkfJlR7W86
         EAdw==
X-Gm-Message-State: AO0yUKWTaaO1VcZb3bUeBIMyBvz+NxkjhHUeDbLdbBnl1dSjWOQ1n/I2
	QmE2sWo7rAIBFyiIySL4+a0edA==
X-Google-Smtp-Source: AK7set/pzYlg/+7Fq+SVSTmW3jcwaKOzDitHq/JWY8bzCbE9+Nqwaq4psDBS40wQVwF7HednUgF8Ig==
X-Received: by 2002:a05:600c:3150:b0:3ed:1fa1:73c5 with SMTP id h16-20020a05600c315000b003ed1fa173c5mr8822288wmo.27.1679912656567;
        Mon, 27 Mar 2023 03:24:16 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id p5-20020a05600c358500b003ef6f87118dsm2220615wmq.42.2023.03.27.03.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 03:24:16 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 27 Mar 2023 12:22:23 +0200
Subject: [PATCH net-next v2 3/4] mptcp: do not fill info not used by the PM
 in used
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230324-upstream-net-next-20230324-misc-features-v2-3-fca1471efbaa@tessares.net>
References: <20230324-upstream-net-next-20230324-misc-features-v2-0-fca1471efbaa@tessares.net>
In-Reply-To: <20230324-upstream-net-next-20230324-misc-features-v2-0-fca1471efbaa@tessares.net>
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2359;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=JfdjdMtHAEFzYfeXcaHNW3DRPcyI4L+/oekuAAfyZL0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkIW7NFRcWNN10fSzOtOUO6cbgTxR7MiXA2aLpw
 +TRtDG05AiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZCFuzQAKCRD2t4JPQmmg
 c6SwD/0QIS76wpqDMw+3rNY9G3+AO/b97AfQHuKrlEb7y+m0XRbjzohdgP4amTudpmWvVEmE9Nf
 mapCXfegDllIN0RkSstCzizM3A15MRBXvouG7hkQXUWAFDczkvhQpfmGEJphl9YbYP8Tv7YNSr3
 pq5eBCmPNVfnIOf+507u6JyQZsvLuPdhQHc0RqdT9J+VkV9G6pe1HmT6+hwS2nO76Z+DWuKunwR
 CpS8QyLd3pdumT4npIreYdluWywbkzLmR2i4bGLeQvvZV1Of9143C0TY3QRrUjXjbqgZO6bs9Cn
 Nx8PSDzFiEmDWMushaPYBAVCElo5uM81kuCXVWr/PxVKluKI/io2c8HQqPBIFDfzDezQfqY25zc
 cRKoz7oh4MiSIbAHGbLy7M0kiyWq+w8wnUbIkYXT15W0qID59Swh1b9v/46FPn4eIBmUr4P5L9e
 ZggGFSCeDF4+JOb/UjJvYQAEOGKdJj0xCpfV9qnRK4wS9S2s+I/qZFsS7BuyHL8HRGdqYb6lDMq
 Jg9M+2q3mTAM5mNfdZcGHdyziulxkDFwtWKlZ2jI/IIj1jNefeun8zsKB/zR25XtCWBBJUaQP6x
 5c+Zb20KD4VKxeGw9fpnNfpc95V2D5xriwoPKGKR5Emull30BokxcJr+iDTCt9U7Jwyzij3FtLk
 poCWPPfH8Sx+EGA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Only the in-kernel PM uses the number of address and subflow limits
allowed per connection.

It then makes more sense not to display such info when other PMs are
used not to confuse the userspace by showing limits not being used.

While at it, we can get rid of the "val" variable and add indentations
instead.

It would have been good to have done this modification directly in
commit 4d25247d3ae4 ("mptcp: bypass in-kernel PM restrictions for non-kernel PMs")
but as we change a bit the behaviour, it is fine not to backport it to
stable.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/sockopt.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 5cef4d3d21ac..b655cebda0f3 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -885,7 +885,6 @@ static int mptcp_getsockopt_first_sf_only(struct mptcp_sock *msk, int level, int
 void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 {
 	u32 flags = 0;
-	u8 val;
 
 	memset(info, 0, sizeof(*info));
 
@@ -893,12 +892,19 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	info->mptcpi_add_addr_signal = READ_ONCE(msk->pm.add_addr_signaled);
 	info->mptcpi_add_addr_accepted = READ_ONCE(msk->pm.add_addr_accepted);
 	info->mptcpi_local_addr_used = READ_ONCE(msk->pm.local_addr_used);
-	info->mptcpi_subflows_max = mptcp_pm_get_subflows_max(msk);
-	val = mptcp_pm_get_add_addr_signal_max(msk);
-	info->mptcpi_add_addr_signal_max = val;
-	val = mptcp_pm_get_add_addr_accept_max(msk);
-	info->mptcpi_add_addr_accepted_max = val;
-	info->mptcpi_local_addr_max = mptcp_pm_get_local_addr_max(msk);
+
+	/* The following limits only make sense for the in-kernel PM */
+	if (mptcp_pm_is_kernel(msk)) {
+		info->mptcpi_subflows_max =
+			mptcp_pm_get_subflows_max(msk);
+		info->mptcpi_add_addr_signal_max =
+			mptcp_pm_get_add_addr_signal_max(msk);
+		info->mptcpi_add_addr_accepted_max =
+			mptcp_pm_get_add_addr_accept_max(msk);
+		info->mptcpi_local_addr_max =
+			mptcp_pm_get_local_addr_max(msk);
+	}
+
 	if (test_bit(MPTCP_FALLBACK_DONE, &msk->flags))
 		flags |= MPTCP_INFO_FLAG_FALLBACK;
 	if (READ_ONCE(msk->can_ack))

-- 
2.39.2

