Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996D7110B
	for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 10:18:14 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id kw15so37335264ejc.10
        for <mptcp@lists.linux.dev>; Wed, 28 Dec 2022 02:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6E6SLEzYpkMhImNY09/lPTYQtXlDI04cgDyI9gS+K4=;
        b=4yEnUQIhr6bMHWinDDUG91t7ajSNiRxoDxZc6OTbC1dWlnBxaHbu3j5raimLz6FiMW
         WW9kJPN05R5xeUjGZZucfaZYVur9qITtvPYo42wiaqLVzVMUKSESoHUa2mVauy/scyn/
         jiBeAz/6zvekGU8X+bao3hSoTmI6C52mpfV0U2OwaanJGtAuVOjiq6pw3EqGwZYWQFt5
         0nVyMQxDKGIKxfpeUbZYMs50gqSTXlgHVlg62xmGB889n4y7vzm0oeThiz2bYl3jMXKq
         4EzL4YWDQR9I64y/LqNsAxzIesvB03WAagJHw7FXjKj1vP4o66wEt2vcOiY9UjHpmpAq
         8I2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6E6SLEzYpkMhImNY09/lPTYQtXlDI04cgDyI9gS+K4=;
        b=o1L/En3XnH91C7cw7hM1Bo7DDgEX1csowm3pOlHZfItfiUhPbO1HAazUDeu+0HiLHs
         xlD2FkQdWmoHJs+Gt20pPw1ODjGZzICxfyJjIiZpR2r4um0tNRaujaLQxBmfpOpEzdqb
         Zi/UTmuTFtMxtG1IXDDDRzpMk14PWDbfYZ2oFoI2Ysnn/h+piOICyYs9aIfZ7ZnIMvzy
         4GrAO5LHREUhLckutf8CoBlZpBNMz6S7tLJ6fUh8v5HdDVIlAHkWI5lPBjC4WIFzyMmK
         nDGVdWTuxPoIszVXtefl1C0VOTsvF3YncKrpbT34Ffo3RB9cQsZpS2f63M8gSSy9YWgg
         jcqw==
X-Gm-Message-State: AFqh2koHUAbV/du4Oh84e9WVPIl9C0jP1GhQsBdpyy1z1ZrFHNi7oBtH
	MVpb6swe1cRAxFAs7XKMR/WaE7bkVUokh/9YWGI0qQ==
X-Google-Smtp-Source: AMrXdXteCXAFXd8D0hQBqQnDq82pBzjv0j/8uwvLk34oFJqxX9I6w3w6IBGmx3zJKC7ZWEjYrERMeA==
X-Received: by 2002:a17:907:7094:b0:844:1d1d:1fa with SMTP id yj20-20020a170907709400b008441d1d01famr20745729ejb.23.1672222692603;
        Wed, 28 Dec 2022 02:18:12 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090676ce00b007ad94422cf6sm7174127ejn.198.2022.12.28.02.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 02:18:12 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v4 08/12] mptcp: userspace pm: use a single point of exit
Date: Wed, 28 Dec 2022 11:17:44 +0100
Message-Id: <20221228101748.2518303-9-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221228101748.2518303-1-matthieu.baerts@tessares.net>
References: <20221228101748.2518303-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=X6mqozSm9v09ThbI9m6Y8WiJzcaWWHTPW/GoY6CoJDo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjrBe/qFgL4NLpdLS1LTBJ9+x/e6ExedvLDzWRLObe
 Cf+N4dqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY6wXvwAKCRD2t4JPQmmgcx7UD/
 0XSCt/FhrTM58FRHMIGcmKFhZ6hOoCSjrpEMr/pAOXI3KOnUuVB5esTnM+jnOV7547TjfGA3WSlNhJ
 lrc/+rjiJKW1IvigxYerCLHgbff1XaPK1yyz9HmzLLsVP9HtGZmqvhN4mk2ZB6or+CVrpGSwt+iBHY
 DRfZ7pksxf/5cGpVNAS+iySnt5/2vLKU8CsdrvAUnfTmZylndgxAGg4eJN/xwMtjixlhjsv/HJZboB
 zkSJbweX9UIXyZMxlmumue1SZHWvp9fidzgIVKDMBdEno0g8kwDiFcX4t8cPwFGE3ZN/axKrqEZlRu
 3OH3NXK15av8GyvQL9tGMA5fy3RtAzUw6zmzBZnP63/xqNucSlb5GV/FP/ghf4nVMTTbji0GaBfQme
 Zw4Trs9OK2dSgNOLjyEmR9cwNlmZcLdQJ5lVj7s3KJy8/fkD0vq6Q4kg/j0rjUDcheYo8Zzu0JF2lG
 Gw0UmO5qZ9jqb1bRRlMQvVTASNEOQYCl+5dA8ctWLnzVMKtD2HcGqjDMerteI2K/rlXSBdVvjwS7fw
 wQTUdG/zbiSsbRLpglT+PBhJ7JiQoP/3f9wgtxPe140a1foT+SNk/I5xDl/L4LOgmhGQnA+ixesTHq
 xQlQCW5mvYH/z+vdt5VOejgD2epdNO8IRSfTOMTKdKREU3D2aKLoIdgLXNuQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

Like in all other functions in this file, a single point of exit is used
when extra operations are needed: unlock, decrement refcount, etc.

There is no functional change for the moment but it is better to do the
same here to make sure all cleanups are done in case of intermediate
errors.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/pm_userspace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index be389dad3f0a..27badb5a5820 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -59,8 +59,8 @@ int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		 */
 		e = sock_kmalloc(sk, sizeof(*e), GFP_ATOMIC);
 		if (!e) {
-			spin_unlock_bh(&msk->pm.lock);
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto append_err;
 		}
 
 		*e = *entry;
@@ -74,6 +74,7 @@ int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 		ret = entry->addr.id;
 	}
 
+append_err:
 	spin_unlock_bh(&msk->pm.lock);
 	return ret;
 }
-- 
2.37.2

