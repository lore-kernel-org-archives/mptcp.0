Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9DEAD52
	for <mptcp@lists.linux.dev>; Wed,  4 Jan 2023 17:16:01 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id fc4so84150159ejc.12
        for <mptcp@lists.linux.dev>; Wed, 04 Jan 2023 09:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6E6SLEzYpkMhImNY09/lPTYQtXlDI04cgDyI9gS+K4=;
        b=LCtgZWzhavy0ytKRZRFi3RzuEq4ufT2VVMA18RaQCpTFrnUSTs6LETmr/M561C7Hu4
         bDzCijoELI6qeYIcn8Y2gvDCY0ZucnFPBiOhPtLO51xV3sMxn4EhHmrkuJp2uhOp/yZJ
         AjBlifNodIMQM6PJQJzOm68IWyuey8JSvPORB5Gy0pPLhzTLC5nlBoSEHzi419SO1uCr
         mJnIbWScxky0i8/E3CCxpbOE2F0KR+VKdhQQRfw/GFUDYI2KOmSPi8/DBxDam4vymySW
         zQeBNLaAYEuiKaCgv0cKyPy86I5pE5aj1xTK1VDYWn8UTv1ltVyu2cMxIumnSr4HjjuE
         fw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6E6SLEzYpkMhImNY09/lPTYQtXlDI04cgDyI9gS+K4=;
        b=pw2yLI36A6WcjxxPH40XIAQjB9JpLT/SG11QEwRWkPCKRb0s6E4avI39yPF721pVlM
         wo5xyJh2ySoYFKknxxFEtWNgqUVGCKPAthkSZC2cw9c5lWJSR9Qq14jUP2owgZHcL6Wn
         t6N7N2Frqw6C/BnMNR4p+9jhc2qDfgfQdgvy1wVeL2pw3N9seJy07P7T0pB1L2NptxWM
         LXAXHWzvwgvPmnJu5ENw8zYl7xOc/Ra0YXBKhXVJcN+3JZjxXh6ew5P2IqQXt0QUHBks
         noFPYADMHDSVckH7OSdFUZJVlx79hpRaiWfDB5xH3uuCWF/u+NJLILMtAneIBGgY4aM+
         DHwA==
X-Gm-Message-State: AFqh2ko2JdDvhO1MeHxgvgfWM8FZ4H8SH7X+2/MiYSVeayyxqhCb+Qo0
	H+SYxUCWq/JEmykj50GWjk9ObKSKdv+qX7tlhwo=
X-Google-Smtp-Source: AMrXdXvCXSLUi6gmndrwP6U7MWxByhL5GWNc77tU2ece/BFV4HzYjxQIClTUmXiZxi7knnK+irLK6A==
X-Received: by 2002:a17:907:3e05:b0:84c:eca0:5f67 with SMTP id hp5-20020a1709073e0500b0084ceca05f67mr5683030ejc.54.1672852559653;
        Wed, 04 Jan 2023 09:15:59 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m11-20020a50cc0b000000b00487fc51c532sm9258074edi.33.2023.01.04.09.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 09:15:59 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v5 08/12] mptcp: userspace pm: use a single point of exit
Date: Wed,  4 Jan 2023 18:15:22 +0100
Message-Id: <20230104171526.1416746-9-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
References: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1113; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=X6mqozSm9v09ThbI9m6Y8WiJzcaWWHTPW/GoY6CoJDo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjtbQIqFgL4NLpdLS1LTBJ9+x/e6ExedvLDzWRLObe
 Cf+N4dqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY7W0CAAKCRD2t4JPQmmgcz6iEA
 DTdYM+8bZ0GyTVlukTwlwnkBhEZMm57KcUQRORK5Y532VvPNqE1G6MBmpF9/+4aHmVrkYo+9Z5EQTl
 gY19scPMGqdO8TRCKkSD5CC49oj7Za6mzkOxYkeePs6cH/NAHojmiQPos2071vHoswqdULLNqIlHCo
 fkXinApBHVccxaRj/QRTKXCJcWMTdj6uLJ/UOU0DusXFIvbC+dn71/tl/15GJqPCtfkVP028/U6YcB
 oF0vLYoL0v73C4Z0vdtD9u9xv/KyAYYkIXoQ/IC5MsvWsRbTKEfaulgyRLXhgxQWrK/8LnLVKfDvDp
 WhMG7M8KDSnsTbJUZZ5B2jnSjAeYIqIYkEPrh7kBlNPnhRgtOm5vmTLH9Rgv2NGET78awLWXoQHV+6
 TFkceDbrANSeYDYkdsrjtIXjzTwV0kfWVhb26blpaiaHVgv7ThuhsVRWVlgSBncuZYgIB1JIvLWDVH
 ukV5oRWh5Z4SZ57XVZL7yp7t5RTnqOM5G+SABO0O5dfBNnQ6nlI9w6Ut0CvQJDwpTfoNnER6/Gxa/9
 cc/pSRdTiNSo5KNpBJihVaUutyQiAOloaRhH/8Ie2YspOPeEDC0uLpAvsnbxpW8uAdxar8CS5p57Dv
 tH1jV/fErg73IZ5bVxEsiU6hp9NWUB0jv1qe0X1Jpt/KyrK7KNKUX+bIIV1Q==
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

