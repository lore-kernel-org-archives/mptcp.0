Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C5A347A2
	for <mptcp@lists.linux.dev>; Tue,  3 Oct 2023 15:29:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392BEC433C9;
	Tue,  3 Oct 2023 15:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696346981;
	bh=3freshd18d+/685WHScSo2hlHcXePfoPaLhJWmIhqD0=;
	h=From:Date:Subject:To:Cc:From;
	b=f5B4WP9A7UCWdazekIAQ8oyZBpqVNeDQTcbT1HEnoUxlgEmQKF/AfoPhT2AXuuhgU
	 di0m+Mrp4+oNDG+e+yjhQ4lMxiz8+f/38wVU95YDBoLK7NI93N88QjJeWdnlTikT7h
	 kSuPK8VZs6fpVMgPn+BkA5vEuUZpvMXyaM7qK039btsvqeickI9E9WDk2d5V2UWXxL
	 eEjk6lGTOWMjYV5rzqVlL9J1Nq7Q3mmLseOc5i91KiPgtk8dfYCIxJX5nYb9joqv3S
	 YSXz3dwxj0Wra4DHpIDrkSqw72Pc0LW/gYOihQ3zSl5WYdzTtSGcptMM6BdMRaWgH5
	 GcThzUYrkzuvA==
From: Matthieu Baerts <matttbe@kernel.org>
Date: Tue, 03 Oct 2023 17:29:25 +0200
Subject: [PATCH mptcp-net] MAINTAINERS: update Matthieu's email address
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231003-mptcp-matt-email-v1-1-5d86d82f8c08@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFQzHGUC/yWMQQqAMAzAviI9W5gWhvgV8VC0asHNsQ0RxL879
 BhIckOSqJKgr26IcmrSwxdo6gqmjf0qqHNhaE1LjTGELuQpoOOcURzrjpaoE8Ns7UxQshBl0et
 bDvDbXjKMz/MCiH3plW0AAAA=
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>, 
 Matthieu Baerts <matttbe@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1506; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=3freshd18d+/685WHScSo2hlHcXePfoPaLhJWmIhqD0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlHDNkkvJ8/yp3AxWOdh404VT9APMVlswYfUiDR
 vstc7L80WuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZRwzZAAKCRD2t4JPQmmg
 c98vD/0ZOwKoAXE+vrdJrXneeEANGtiw/a9Hsxn/K6nlGUOR9hyHRS9blAYEkQ+cfDwVkOxQCyr
 PJPgRZja7rFK0YviecnIHd1dA8uAkvK440bcvDB1b9jlxE1cyuATQznPlfrl4mesBQNxgVBEjWt
 0dGw6TPmfj5jFGfZdAu9pLcaCjyGLywLFwK5ogf50WKq/gUvzGn/kPLu0XrT/QuvYvco7HElZmF
 vAqR+WF24IhCqSXxN+odogeCJLtYWhbygESXK0AnVT7LEyipGl0RwVTHr/rH/DoQyEUnrQoTxLG
 UOwOITR2grVQiz9U/n7i9uE2Gnx9S1Id6Ib7I5HLgyhz346fyFg/kwnH02eeMjOfZg2gJ0MhFNw
 eJw3CP5kimcL6LlQUfeOaZy/OUBXyrei7eas2YyIGGCnI3Bw9b3+x/v/epWsyklzB/OYcWU8mo/
 fDL4k8/ME30x+bWVGTvUGbo7fBFAaNrX2KZvS5M/UgxFidMwGunZyz6oRuI6kymtmPhOlOVf8BK
 dLzVRCB93BCKRij5P+60cZE+bv/W9Qs1jfCw+yRIEEy+hvbLHAglLsww8/G1PrYoCL55/5dy/3F
 19ZTslRNAfQuOQZyMx1VH1gEcZxLIrvnxEoH+p99dswHKCwifpMdIVtc5VRB08qgBKUOCAPCXNm
 rKIv+1WL+z5zubg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Use my kernel.org account instead.

The other one will bounce by the end of the year.

Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---


Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index a0a6efe87186..c80903efec75 100644
--- a/.mailmap
+++ b/.mailmap
@@ -377,6 +377,7 @@ Matthew Wilcox <willy@infradead.org> <willy@debian.org>
 Matthew Wilcox <willy@infradead.org> <willy@linux.intel.com>
 Matthew Wilcox <willy@infradead.org> <willy@parisc-linux.org>
 Matthias Fuchs <socketcan@esd.eu> <matthias.fuchs@esd.eu>
+Matthieu Baerts <matttbe@kernel.org> <matthieu.baerts@tessares.net>
 Matthieu CASTET <castet.matthieu@free.fr>
 Matti Vaittinen <mazziesaccount@gmail.com> <matti.vaittinen@fi.rohmeurope.com>
 Matt Ranostay <matt.ranostay@konsulko.com> <matt@ranostay.consulting>
diff --git a/MAINTAINERS b/MAINTAINERS
index 768e5cbd5868..51ba9d8a2dfc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14958,7 +14958,7 @@ K:	macsec
 K:	\bmdo_
 
 NETWORKING [MPTCP]
-M:	Matthieu Baerts <matthieu.baerts@tessares.net>
+M:	Matthieu Baerts <matttbe@kernel.org>
 M:	Mat Martineau <martineau@kernel.org>
 L:	netdev@vger.kernel.org
 L:	mptcp@lists.linux.dev

---
base-commit: 9de414b56675cd517b7ea3d523dd35737e89ee94
change-id: 20231003-mptcp-matt-email-6338e0aa66d3

Best regards,
-- 
Matthieu Baerts <matttbe@kernel.org>

