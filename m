Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF938AD55
	for <mptcp@lists.linux.dev>; Wed,  4 Jan 2023 17:16:00 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id c34so42917184edf.0
        for <mptcp@lists.linux.dev>; Wed, 04 Jan 2023 09:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drNb1S9tj9maCJICCjpsuyCFdKnsYG7mF64cROKJf/w=;
        b=M8MGYGDhrj9hUPus0aFmSok7kuENx1WCbKhd/f3swPgCFKThcqwyHqGH6QOsQ2oTvJ
         EwFRpwAJ/VCAMT4CtqcdritDySdJqoChBbe7GaqC2kMb0hG4wdL+kATWvrpjlExmSChx
         v92llnjuTu3gTEU672mjP8HgyCWgmomSLaDDZvNy/Hst6IjTrkV1gTv3oeO1fz44ZiGQ
         BTDhKOM08tTnzAjLG897aiC7Gd1HGVRP9z+se76zAg6a5V9iOFQavoVgADlOUj0rQfFA
         JtPHdOhNuvLHTPGdXNrZcf3A/Uff9WPYIvFawQBi8R3NRuP88mGnvJZSyGtOg34A4ajp
         e6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drNb1S9tj9maCJICCjpsuyCFdKnsYG7mF64cROKJf/w=;
        b=knmZESVypgK4URwtr8edkri0LXJGmJl8wq+7zNA1PvXDbcNA+F6tef9uBpvk0ZU4PO
         FwrFhMdieC8levhzEYSuX4KBiikwImDqV7ix7ppjCYEo/capmLS8ghVBmO0nLwKY9QzU
         XIZYoPue4qe2c4bbD8232X7gVnxaHBYkNZLc8DGRDNxGdLyw2XeLf0VjxXlwWERmggdt
         db38cJ0aqN8eGmJR697dlsotK6e8kVfsTLNYYwsxlpkKsF4L122DLEOX4Q6ush+1RaG8
         A0g7k4+uc/AWL5lEMvrlwpPeSV7y6Mpr4rpnWStylke+We61ULg9tsES6awV7wUrTRhE
         MmAw==
X-Gm-Message-State: AFqh2kqtxyqs4+CccoWhsaMzKM+ndu2n/6Un9BIXkexQJ9Du4jJDKsqS
	6i7HuT/CgkSt897DmmQexaM021sl4Eu3OW78s7c=
X-Google-Smtp-Source: AMrXdXsbe6+xvNe9zibfi1m0hIZIneIruXZVF0bauI+ZE1KHItNXFOd2k7x6cuWZE0xCCic8iiqLgg==
X-Received: by 2002:aa7:c69a:0:b0:461:aeeb:9ce1 with SMTP id n26-20020aa7c69a000000b00461aeeb9ce1mr40172699edq.32.1672852558863;
        Wed, 04 Jan 2023 09:15:58 -0800 (PST)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m11-20020a50cc0b000000b00487fc51c532sm9258074edi.33.2023.01.04.09.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 09:15:58 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v5 07/12] mptcp: remove assigned but unused value
Date: Wed,  4 Jan 2023 18:15:21 +0100
Message-Id: <20230104171526.1416746-8-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
References: <20230104171526.1416746-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=653; i=matthieu.baerts@tessares.net;
 h=from:subject; bh=uZ1GtsrShc9C2g5MMHxhX8M/nNp+YYPJg4WshuQZCy0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBjtbQIzdwNwhX5GIi12lg2zt1E/c6//XWQ04V9HwzN
 HqFhr5CJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCY7W0CAAKCRD2t4JPQmmgc/nOEA
 DPAX/fBkXtLtxuJElM067fNwt7SM40jeYwAcBMLYylDVF0EJa0+txyss2uIVolIfbLnSb0RmBQD+wF
 QwjbzLSKyToiXVaGbaiShOR87a/raEzVvCd+h68XXdnXgkTuph6jIW1c6cOxzQWEW+HXTO7C8CPiFZ
 kiEhvgjaybdKarZWTb2sfse737ZrKgLwhlnMQ8nP5KGUJwyhxCwrL7gshYsFmOUfdPCUPC8tO2MXMY
 kCTBDaCVjCfIHk5Q/89dzp3COQrnMwSNeXC/ZDiLXHZN+4ShGdCkC1oIvfkRqBZ3C2b3siEPHWfK/D
 6erWOe5tAcgGU0cpzFplnAt0A93Xq2wUzfGqUIlFy6b4/DyX9AaEUnd74JKx8mcUw0pZ2uJ1jZpTaq
 f6lGX8plZdbnn5Vi/97/izXiE7qmFGnRTAfvvRDQBFrV6PyX0IaOc3ZXkF6EQPTmlLUwNmPVDAi8AL
 llOqysrP+1AaamgS+l30mt2+RcVqgdtLE4U7N7a9XfTOr12i1N2iVMRvBI4RTZoqkM+wvK5qDlUZpj
 ji0eBUCxckLFxoYpsS4gC1wNBq0uQsvdd3W/m9p35jHrAowa+E52XS3WbP6w8gFyDatHazBt9X5tB6
 M+O7GlEbSNYbx5lFcC+arQ9NGWW2ptXyvGaaW5WywV71SCcCXeSGbpVq9aqg==
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

