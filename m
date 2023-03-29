Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E36D1C2B
	for <mptcp@lists.linux.dev>; Wed, 29 Mar 2023 13:18:29 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id r11so15669396wrr.12
        for <mptcp@lists.linux.dev>; Wed, 29 Mar 2023 06:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680095908;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=44fGbCY24u87wLjYoFExhS5EC3vDBtvXOh8a554nITU=;
        b=NH+6akN1k+mAR7IZeGfjqwcCrqdjeJQKmIxyVRY6qQFNrN4wsjqBEv4k5Yc7qJgfVU
         fHbKa/AzRlgAcJBhiL9XxLt1XY8Lu+E1EO9T1Gv9iCAf8DMokGI8iiT7GeT+V0MOzQeY
         XEbE4megxlnyNl5tD5xyi3OKPuF7S68ZiYZiAyYz+upcB8dmPVEqH+4lMbvOkyPrdrTe
         SnNTVZKcX/zp7rHfzFqKx+tCLo0SjxWzGJ8m+gq/WNZ8lwxSR5HP6VUFtVo1inXxy6dv
         ykC0EZW9DGFdY9NssSo2fYYRGPWr1nANM5si3cElTjTh2VFVwOxX4DRgbzjPAyefFHE0
         Q07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680095908;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44fGbCY24u87wLjYoFExhS5EC3vDBtvXOh8a554nITU=;
        b=sKg+1eak2uNcIJt2nUhRKOf//B06cxKE/z1DlRjmclXTXhAKF/EGm99T2AruZEMmZv
         gZejk7vuP+7LeHneEzu40CEABnZ4P7UX1lBiz1ZBCFVv12uHoYjJwBTpChe+1zXwgJb7
         LjgCyuYcTVtwepJxalJIIhgvIOfBxwxZ3P0BMYHfiRosLJ+e1/w+Fm0ZmOTOIaBAEdfY
         EAB3/lSS50Z4Nyo4RaXrd2CCOZ33ZrcoCmkrAu5DdgQ2nqXKXvdBC8ltv1L/TK8pyaUf
         7MMtNil2S9hjuTpx4rOqFvLvrN+faDJkaU8EC9I/6RfWGtCkBial9VtblX9ReiDbeG7y
         Chfw==
X-Gm-Message-State: AAQBX9ey37bsOP0DGGIwVanqKNLpGR7bmjy5IIJzcBXfUFVEJ8HxeFdH
	99DMydFoVNvvtV+Eom7IkvDkjiJ4X4FLLjadogZV3w==
X-Google-Smtp-Source: AKy350ZOvzn7az3Zu7S1OEiCgVJPdK7IxF3SyDRaTZWtViRHJwSxDFIhGWPXb4JlWF2UkjnndmuFeg==
X-Received: by 2002:a5d:4349:0:b0:2de:ffec:e48a with SMTP id u9-20020a5d4349000000b002deffece48amr9715881wrr.29.1680095908102;
        Wed, 29 Mar 2023 06:18:28 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e13-20020a056000120d00b002d7a75a2c20sm22933678wrx.80.2023.03.29.06.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 06:18:27 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Wed, 29 Mar 2023 15:17:56 +0200
Subject: [PATCH mptcp-next 1/3] MAINTAINERS: add git trees for MPTCP
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230329-mptcp-misc-cleanups-v1-1-a839001f0b05@tessares.net>
References: <20230329-mptcp-misc-cleanups-v1-0-a839001f0b05@tessares.net>
In-Reply-To: <20230329-mptcp-misc-cleanups-v1-0-a839001f0b05@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=786;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=5DaZrzUJOO/c9rIfCNG4YTRDYuBszWkhQlenGgUtZVY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkJDqingks2CYUo7HcgbjE2nmCCJAem8AToepTn
 NYJO7gTYj+JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZCQ6ogAKCRD2t4JPQmmg
 c+8HEADcV9a514GOyWu0LUZYF5o6pEzxE+JbmPtvp6DeHy6m2c2Iql/TtSNmlNnN0XqkIhgFe3g
 66QzCXF2kPPdPZlvmstOKBF1cxZcyiYNTmR31NTf4rhgdcK7Pdc2NaHA8ObYPcthe/pr//cvclD
 gSQKjek4QInrPHt/EXfqeys8v0TTlsVcYgybFcvO+qQoQrv4PcaL6YnJbumh/W5iY+9xVfxU3nn
 DOzzeRJBdHbQdwng25i+28ifwoJ8Px4WqBLTZbh6bPgydbsyjuFWUsH71H/cK3DWpdPb4ZB2c4v
 cqRvhM8Vv8Je9DOfcoX4ZF9MJI8yS0ePeA48+lMhe6DVvB8RaGL4qblv6bDcuwP6PBfLauXsCiX
 ewGrUVJdL+JmS8YtHUj6XQ6IfaroL4PJdLiwJWCJuuR4/HDWDygwRvdG+lVN9gcCQEdOrQlSUQc
 D3ni25uKdWIly/ioH3nEer9iUGdQlWMMlpMS9NjUTXmJMxWCmVXvyhFWZlSffEJDIYUuJWFcmvj
 I7NJmdMmZDghTrSqzOqsgdKJl6iXhCroInhso3NNg8BqAp0oKyHpXkhTIruFtc43zlMaFTUGzr8
 R/wgCojazr1OXoJX8NO8IgQqwdN1cqj8s9UENfNGIYOJOVEKg/TICZBZSaMAAoT7AipWm2bL9Q7
 bkR4CuFnlG7iHRQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This will help occasional reviewers to find our git repo without having
to look at the wiki.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 45fe6d7e918a..1b45ba8a1536 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14607,6 +14607,8 @@ L:	mptcp@lists.linux.dev
 S:	Maintained
 W:	https://github.com/multipath-tcp/mptcp_net-next/wiki
 B:	https://github.com/multipath-tcp/mptcp_net-next/issues
+T:	git https://github.com/multipath-tcp/mptcp_net-next.git export-net
+T:	git https://github.com/multipath-tcp/mptcp_net-next.git export
 F:	Documentation/networking/mptcp-sysctl.rst
 F:	include/net/mptcp.h
 F:	include/trace/events/mptcp.h

-- 
2.39.2

