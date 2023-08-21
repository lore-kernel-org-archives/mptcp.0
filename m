Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049FD79F1
	for <mptcp@lists.linux.dev>; Mon, 21 Aug 2023 15:27:35 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-317716a4622so3157128f8f.1
        for <mptcp@lists.linux.dev>; Mon, 21 Aug 2023 08:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1692631653; x=1693236453;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/WTqaO6kZcRzLug6Tf19WjfywSVMkwELLnlSRyjAmT8=;
        b=HuXGne+v1bhfv2zaH7za8t8+CVu3R4UMuEpn/BhiprI9cS0WPJiG6qV4z0r6GIsqKy
         Bki4aASOSKfpzgIKguKvyqyrmuE/5nk8qLvvnsJc7MKOyUDT4GbaanrfYi1GKUBOPd8Y
         KWnjyR7gcMuYBJvxFdUK2UzNlCD18IZB/MjpG2wxX/dOoIA9O4AQu4nm/IuIU0omDFtQ
         KI1GtZ5urvYLnSzEnrSpfeEL9afi9NmRHUdbmMvQ4HPf5q+ARSIBiH+5yKqwDveFFZKg
         LZWsh2eBvor73coddxVxVnEU/GfuIPycfKbKLMrkYZQW94LVdEcs5LdpLe/P+6SGEGMI
         AP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692631653; x=1693236453;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/WTqaO6kZcRzLug6Tf19WjfywSVMkwELLnlSRyjAmT8=;
        b=M/X6pbhoqEEjwcRxZEzbjlTcg9GA4QGmKJPzLO980wiU9TEmQy2cYDo0R/lJNY8Tkq
         nl2mgyfa1ili8vyw4dxfwImNRxQlL6lzhCQpoM/KtsVEp0GAcS5FKPAKmr0KQDd36H/1
         /VHdnePCs1I0gvGWcrfS3OswcD9ZxmTa7/RV5BnVAHdbacqRIOBNTsniUuUwdUz5tgFV
         2nois2j240lZKLq7C6X0PFM4RRAa2ibAIsZGzEPPBYQ6OoN/gU99fHrRhqSzxKzi+Qd7
         5gMf6r99vb5gCJgWFwhPfj6an85WInjp+jbgGjGXzX3z4wEiZiCbmJMBwuqfGV+ahheT
         qAiw==
X-Gm-Message-State: AOJu0YxXKqcQrRQ6gVJEYwblN741AabWfWRg2mSmQYfbIkaR4r2XUKki
	Lsq0OxtBAQF5TXhbXEHF2SEJLg==
X-Google-Smtp-Source: AGHT+IG1n5PqYBrVZTqpUcv7azWA59iiu+01Rq+hEdaJTtR+e6t/3rmyje6cqLwT6sjpw+VGQgyjEQ==
X-Received: by 2002:a5d:61c8:0:b0:313:f783:262b with SMTP id q8-20020a5d61c8000000b00313f783262bmr4802936wrv.26.1692631653564;
        Mon, 21 Aug 2023 08:27:33 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id a19-20020a5d4573000000b003143add4396sm12803959wrc.22.2023.08.21.08.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 08:27:33 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-iproute 0/3] ss: mptcp: print new info counters
Date: Mon, 21 Aug 2023 17:27:25 +0200
Message-Id: <20230821-mptcp-issue-415-ss-mptcp-info-6-5-v1-0-e5d91ad566ca@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF2C42QC/zWNywqDMBBFf0Vm3YFMbOzjV8SF1YnOoknIqAjiv
 zeUdnkuh3sOUM7CCs/qgMybqMRQgC4VDHMfJkYZC4M1tjZ3uuE7LUNCUV0Zr+RQ9T8FH7FBh4+
 x8b0jS/5loPykzF72b6OFn5tyXBeG7jw/y+f19IIAAAA=
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=843;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=mrTQOYKjFM5k46RLNtxLCH35W5EqtHG3by5H9fu5f2M=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk44Jk6YM/bnn4VgO2S7UYoAVsuEgraYPXir/UO
 RwXowO2uU+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZOOCZAAKCRD2t4JPQmmg
 cy2dEACSBfHgZwN7zRVQTmByj5IjdCWV3p3Of8A7RDgSgrekvpGTAEQ+I2RcbzgQuuKxx/U0FQc
 qjFCCkHBRX8BRgA2Ea2txj4+wjVZ9FOHg9lZbNvW6r/Iu6tkDOYCQByuulOLN0nks0zT7h/I5Ms
 VilKMLB0RlBemtNTVl5BZQucN7DpIvgF2SLid0Gz5TB2+JYRSmctV3kmE8nKwacFIdplkA3k5fi
 KvyNmdPXrABJig/N4m2JCsfKSqatSnsc15ks0fJFSP4qetMBjN2rDwLUQDTGVO1wIyDOu0jpvGD
 WynBqR7NnZ1ei4XGnA28LtjB7wlZzzf3y9e+ORTy7HhvSsMdszEAc4zePn6jdsSJOBLgrjbNyf4
 R2XsHfxN1P/Rznsr7gtqIyg5aHHp0BuhygfcESsIku8HcTXZRkoABxmycXup7ttpOSRiG/l61X+
 6jBmn5MOps+YN1ZchplNkZLP+sK/BeZhgsdOpFEQtwnXfWzw0KYf0c8fV7/Jj+L08ASGdiBIUL2
 Fn/rIXap3G2ou57WJb6ZnvuxRAjGhAyuwUKeI9lkvEPdkn2AAZARw8PHMI4ebvFKIj7hqG0e1Mb
 Y5/dxFgubZBtyn0w6E4P4/Gl88NRhiaNx9qTmdUQhxHrXpltoP37krlrqhjh8a+A7CWSViDJt1d
 tTNtHnQXQ97a0pA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Some MPTCP counters from mptcp_info structure have been added in the
kernel but not in ss.

Before adding the new counters in patch 3/3, patch 1/3 makes sure all
unsigned counters are displayed as unsigned. Patch 2/3 displays all seq
related counters as decimal instead of hexadecimal.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Matthieu Baerts (3):
      ss: mptcp: display info counters as unsigned
      ss: mptcp: display seq related counters as decimal
      ss: mptcp: print missing info counters

 misc/ss.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)
---
base-commit: 872148f54e35cb13aa6c9e48e52306cd469aaa53
change-id: 20230817-mptcp-issue-415-ss-mptcp-info-6-5-9d6fa5121fb0

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

