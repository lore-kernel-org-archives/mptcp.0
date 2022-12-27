Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F8563A5
	for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 18:21:42 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id gh17so33628859ejb.6
        for <mptcp@lists.linux.dev>; Tue, 27 Dec 2022 10:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drNb1S9tj9maCJICCjpsuyCFdKnsYG7mF64cROKJf/w=;
        b=L/wmeKgZWm1sMByRqIElyvhQkAGr89JBMfmCuBltRRf6qyPQY6Dl8izfAZlIX+cNEh
         roNZDVSHVIGuEkwx7wbD/J+hRHxGfk8F6+owjQxDI0zK+qi+yalfz3SxqS6IkLrCGuvt
         q3TcX8uV+rtl6cOrrzYUrpvDore+GW39IY4aVl38LxWC+BDFp1y+KBWw0YlHdmuQJ+mD
         IHVI1+8BnCxz70wNMFErtXAwg7d/HyUId/MI2VfZCt+alH0TxLvylDee0LLDCFMr0YUB
         EBDU8JQp1PvtVM3fRA20XHOQ+WNSDTryd9vnPQ5hBSuGbZeL6bOd7BLVATdXQ/yMuoGY
         cKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drNb1S9tj9maCJICCjpsuyCFdKnsYG7mF64cROKJf/w=;
        b=Za4LGiYw2xHpCn8EQubISa3F28nFo9QXbw4NO15w5TURlmcwD7NhY9xMTO9U7aCs22
         +eBX4A+MvreMfRAaDECQLawzmyF/jPGkqonphXGXZKAf0QQzstUP4pELKI3YVTBc7/jj
         oIzyJr1OxaSrFyDNHUExEJe7tJxowFz9xlADOMsi6Z93GN4xBJr+hEW2MRyj1koD9U4o
         2xoYj1XcckHxrz0PjzegSURIuVZfslPxiMjIi4TlpTHrjUZKyd16Padh5tdEF/6V8Doq
         nowd995JMtnr8JAUgwzVPzoK+ype0HsIsgKzesZYZOcDMTkOMwptJYsMSedgpkx/fpeR
         8UQg==
X-Gm-Message-State: AFqh2kpq1j6jvgKM07UEWF/iuE3ol8gRDUFEhw6Ldt6FrApzgWnqtuOY
	L3xq4OhfSQFUfSxVjBP5vdhKsUwY+35g8xSxrr/DYA==
X-Google-Smtp-Source: AMrXdXtbqXbecQix53KEXIuuhPSYEEC89tXSM1ZnN4RmlPiu5+aci3HP2ZPIbmlEP7nij6OAX2tkZg==
X-Received: by 2002:a17:906:b108:b0:843:a9fe:f115 with SMTP id u8-20020a170906b10800b00843a9fef115mr18922543ejy.32.1672165301036;
        Tue, 27 Dec 2022 10:21:41 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id o17-20020a1709062e9100b007bd9e683639sm6336612eji.130.2022.12.27.10.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 10:21:40 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v3 07/11] mptcp: remove assigned but unused value
Date: Tue, 27 Dec 2022 19:20:53 +0100
Message-Id: <20221227182057.2288816-8-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221227182057.2288816-1-matthieu.baerts@tessares.net>
References: <20221227182057.2288816-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=653; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=uZ1GtsrShc9C2g5MMHxhX8M/nNp+YYPJg4WshuQZCy0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjqzd6zdwNwhX5GIi12lg2zt1E/c6//XWQ04V9HwzN
 HqFhr5CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY6s3egAKCRD2t4JPQmmgcwSdEA
 DmG29nqOwmE2TtMeXgRSwfVtBePJbuGdC3h9Ukyc/RNTonYvd1xjty4ntDI+S0JTFcwzd9Lq4rTV8s
 aYrCa57D21bMVFgtfGtrpL0wjtOZIrn6batlMhN+PO/C/yIaOEK8OD8KukbxIONZ4+b657qgSfeSoc
 3xJ/5RBzsO7g0rEzcvZUwIxN1cQ1NdbtjBprpkWrPsrV5HN2+zD1vKHzhZrKKMHD4BBxP1dXQ2Uaeg
 6aeqLL1eook8xYnr4rBRJNSC0s+Fb2A5a3NKTi3TVzL4RAXm7hNFCWji1VBkFSUWf2ILc8vH1uh0wU
 jQ/qiOb+TLEjUf2UyMmWM3P/5oOfQeKEWtqctYkw3E0bV7JN/eDipDRoizxBtlxVOpsf/zwcEtVqzL
 SRfYknj0o4vcMHhMITQsMMCezC2IOwCCxG55yP2OFPzijx62ZTCN2MN1CHwYAUvUtZi3pI/f2V8CaN
 i64pmTSawqX0V2OUvNli1FFDSykhdi7LZCHNhIY5G4XQBoB93hBb4XjtZEAQs488XiVFXi29Qdm9VK
 1ORIJQMhiPB5FOvdyx1WkVEIt3qNlxNjELsWcjLMd83MAynJMsvICpWEbIE6c/2vRSO7vTu4HYPPsp
 00SkU696RlD+q+KE2SORW/q7/1C7AS8H8I+Zsw+ZTIjfRVYrGsUtixAsuEPA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp; fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
Content-Transfer-Encoding: 8bit

'ret' is always set later before being used.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/pm_userspace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index ea6ad9da7493..be389dad3f0a 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -34,7 +34,7 @@ int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	struct mptcp_pm_addr_entry *e;
 	bool addr_match = false;
 	bool id_match = false;
-	int ret = -EINVAL;
+	int ret;
 
 	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 
-- 
2.37.2

