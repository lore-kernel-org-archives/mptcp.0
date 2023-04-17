Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C5C848E
	for <mptcp@lists.linux.dev>; Mon, 17 Apr 2023 17:25:22 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f16ecaadd1so14966705e9.1
        for <mptcp@lists.linux.dev>; Mon, 17 Apr 2023 10:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681752320; x=1684344320;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qmdlx0Insi5qsn8IlqW/sEvShkVrHm8jLPyZ+IOjK9w=;
        b=8C/okMchMmE8j2FEJAvLREYs+Sa2O1CQCK8qH61WHcp2UJKKwFWECQymtULR2IRuOi
         3h+qNcyAnFOZy0MO8tr4OnF7ZvcYCv1E7RYZ4hF3S7QYRSpYlLEPZI2QxKLWSBROsy/T
         imlAFQh7JPSQ5RqXX9cx1YTw3PVt+cbcLjIU3OLwQlbKbaPH/8yjBfv3Y76JC/jeAq4y
         leE+cnpak+z1CfeKVeH3I40HbssGdPmKtLn0UIJdYm1Qu3bDrCgxhPvalVzrlwyKEwbZ
         P8pfo+VLSJen+4a1zLSxRRQKW5peVHMJ0/MMYSHwv7lvXcO7HwrRJpKOoSLwID4JrODh
         4Arw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681752320; x=1684344320;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qmdlx0Insi5qsn8IlqW/sEvShkVrHm8jLPyZ+IOjK9w=;
        b=jOTykbqpMycP5ueh75maBKyscRZuu5ppGCgz/2kWw/MIh7fWcMJpB7igI3md+QIcTY
         ftgXcMXpDJBe5nQNjDcfU0vC2ntpqJXiKrmI4mAHGeOZ+jgkFSsowdwvPR5yxs6IAxD1
         AyHQYhu4mUSAerzfsHzkrGQcAfO/4awYJs2qlk1r47UTOegwPBAUFjGlnRslOrGep2iJ
         scjUmO8YnOmJSLtuaAzaQfNKIlRfxk04u8OL/JaWLtLVa+RpkpLcb+NIek7OVHDwpPhj
         VMIvspM4tLQS3+dxAe52UauwS0Oxa6D8ObwFvXGO+y1+GkkNC7pD5w4Wi5W53BU8CBLF
         lQZA==
X-Gm-Message-State: AAQBX9dk7jN21kNmsmzhdAvCyqTAlRJDmvN1jqrbqSD/Icycer7DZnO9
	TUWhqJBnkFBZIGtnSyFiB0LiLg==
X-Google-Smtp-Source: AKy350YRMnpis5lTScTbJfhTbTD5P91+OWpnhypiRejipvbIJaVBIBeqsaOJ5vGd4D6iArkCE/BU/Q==
X-Received: by 2002:a5d:6201:0:b0:2ce:a8e9:bb3c with SMTP id y1-20020a5d6201000000b002cea8e9bb3cmr6711423wru.15.1681752320518;
        Mon, 17 Apr 2023 10:25:20 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003ee74c25f12sm16240877wms.35.2023.04.17.10.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 10:25:20 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 17 Apr 2023 19:25:05 +0200
Subject: [PATCH mptcp-next] mailmap: add entry for Mat Martineau
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230417-mptcp-mat-alias-v1-1-abe486377b02@tessares.net>
X-B4-Tracking: v=1; b=H4sIAPCAPWQC/yWNQQrCMBBFr1Jm7WCSClWvIl1M4mgHTAyZKIXSu
 zfV5ePz3l9AuQgrXLsFCn9F5Z0a2EMHYaL0ZJR7Y3DG9eZkB4y5hoyRKtJLSNGFIXhnL4bPHpr
 lSRl9oRSm3avHT9ZamOI+5sIPmX93N/iXEs8VxnXdANAqBweKAAAA
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>, 
 Mat Martineau <mat@martineau.name>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=UT5rm4zocoAsxZdRCE02ET+W9s5sZfjIDnMeRMAfLFI=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkPYD/IDVI1Y3ygY5I7jJO/IQrytxLK5RbnHzof
 IqRGZKlE/qJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZD2A/wAKCRD2t4JPQmmg
 c4f+D/9mkLJB6GG2UhzHU9a4QTYbsbKtVvFsF+UeziVcT7fIsYXyBNxc0EIatYf5iNiZQrxrmag
 h55ZQJa+zEJsfVYGNhCQLTOchxDJxyPOTXaQJdW1D+MNmpxdkJIPNrVg8ULea71Q3PCkMXzy5UB
 yzAxJ1pOMT41tPi0BUlgMis3gxZIKpfZGB1CEBGxOMnh0bLWyXHPIqP386Zl3svrBVzF35Yu259
 lz3RgHihEcW1CKpNRRkh7ZuazHRqquPkMd0AdGBSeV/GElAyG0tlxvAuhfgbwfAefGxJFllLEw9
 qYPoTmqDt2W7VYGuVr4b2QaoSP+kiYTSg3BhpwsuAws7qCZQvcB5FY/k2/PwcMcGgKSZ5kxad+7
 Yr0oqM1cweIVTrIYhLcu2U0VPnS+Brlxq9F1hJiVFIH9Cu2yOj21wIFWi9RwVUn55D+YkYmdksQ
 4362dAFrEKrQxZ7PlmxYonrAR7vhCbZVmJbiF8wn6mOm6IhUmTu+Jxbt9lm/USZZ3vhQi2H99JS
 P7JmzZhCse4fzlLtI8scUonUpivkXB3hIAkRJ7tyYymxkm8IzxlIuQMD8LgxyvCj3i19fL3lrO1
 Wlc5WItYg1jslmq2I5lm9YlBdIPl0zUADsLGRcFNU7vuN2n+WNKjohHC/gsn+I1InmMRq8Hb9Z5
 /MJi0BuS/3ANkqw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Map Mat's old corporate address to his kernel.org one.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Mat's address is still being used because get_maintainers.pl will look
at the Git history.

@Mat: still OK to use your kernel.org one?
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index e42486317d18..ad1d3c166e64 100644
--- a/.mailmap
+++ b/.mailmap
@@ -297,6 +297,7 @@ Martin Kepplinger <martink@posteo.de> <martin.kepplinger@puri.sm>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@theobroma-systems.com>
 Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com> <martyna.szapar-mudlaw@intel.com>
 Mathieu Othacehe <m.othacehe@gmail.com>
+Mat Martineau <martineau@kernel.org> <mathew.j.martineau@linux.intel.com>
 Matthew Wilcox <willy@infradead.org> <matthew.r.wilcox@intel.com>
 Matthew Wilcox <willy@infradead.org> <matthew@wil.cx>
 Matthew Wilcox <willy@infradead.org> <mawilcox@linuxonhyperv.com>

---
base-commit: f43ad21ca73772d3a95ceb8f20bbf1caebfd3fb5
change-id: 20230417-mptcp-mat-alias-2c7cb2190e8b

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

