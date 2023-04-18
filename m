Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876971FA0
	for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 08:37:36 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id q5so15101709wmo.4
        for <mptcp@lists.linux.dev>; Tue, 18 Apr 2023 01:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1681807054; x=1684399054;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oMfE7rmp8en6Ue+2YarFEhjc2EXzKNSiQsK48tdZL3g=;
        b=q7WKHqtIjbd54gtbHNIcPAMTsyHS+emN/v9mq8RoK6YzY4S+q7p2kD3Bq+Srr552lD
         15+WzFY/3X+Ofc2r6ZEm1A+Jt3Hnm0/eGfoiy5yN/Cqd1ACwkB0SWiM2P3E90y3m46IB
         0e5gSbzR46qwLpFVEnMxgj4tcKdXUqeCAuEA9ep8Iq+caXPq9x3iuWQIcXQMglykQI92
         ZmzvIe+3zELTp6GIH/bcSV9lJTUGCbLjXAhlr1QSeozUDKKWjWXb8h2Uratc9y39GOlU
         2G76bMcwKZhngyzplk4jWwZIPS34yor6pac6Ir/ZemfNxN5qp+9GUjhImvq5t8+2iHyG
         Fglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681807055; x=1684399055;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMfE7rmp8en6Ue+2YarFEhjc2EXzKNSiQsK48tdZL3g=;
        b=JopbeXdm0lyIQZZoDFWmROv49JJz5bH9nMdhn+fHS8QqkDBJ3mCDwy4YMa9lNVmJBv
         IW2iUHMtEibs9zdvpnF9cWDrMFR0WSsp8nqXwJFKhqQZcJ5XjfZcXChyfWOoXCG7/p1j
         z0obZNRYI4CkQeJyAQYBtvyFbnqP53wtVjC7e8W7zuCF/imhcPht8ZrmJ75j1sKl+YWk
         2sOUlHW55YlLw5qfnlQpx7kS4dUhwsibvBXV1UfiXOjDwsernfEYn6/0M+9qcCzL2Ptp
         2fLDTkYFCtJ/v77EPuOQjxGJGKuCXmJxhI2mFaOaCrYImHSEgKK44IF0szytI7m6nnX8
         WYUw==
X-Gm-Message-State: AAQBX9cY24hhiz4sfJqA1iCeQfIJlYHMqjC3OXayg8vQIjSdv2NJJvGM
	X2Fba/77xfUHZ9I07yCpLXRyig==
X-Google-Smtp-Source: AKy350asbUvnrVe64GhyVH8OJKKgZQ86HpGyF8VsveMLyD/u+MKWKm8B6stB16HtRU2sl0v6krMsHA==
X-Received: by 2002:a7b:ce91:0:b0:3ed:e4ac:d532 with SMTP id q17-20020a7bce91000000b003ede4acd532mr14027831wmj.36.1681807054658;
        Tue, 18 Apr 2023 01:37:34 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c471500b003ef5bb63f13sm17904388wmo.10.2023.04.18.01.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 01:37:34 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Tue, 18 Apr 2023 10:36:59 +0200
Subject: [PATCH net] mailmap: add entries for Mat Martineau
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230418-upstream-net-20230418-mailmap-mat-v1-1-13ca5dc83037@tessares.net>
X-B4-Tracking: v=1; b=H4sIAKtWPmQC/z2NwQrCMBBEf6Xs2YU2VVB/RTxs4sYumBh2UxFK/
 920B0/DezAzCxirsMG1W0D5Iybv3GA4dBAmyk9GeTQG17uxPw5nnItVZUqYueLfJpJXotKyYnQ
 +8ng5UQgO2o4nY/RKOUzbUutttihH+e7Pt93d1/UH4eCUv44AAAA=
To: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mat Martineau <martineau@kernel.org>, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=DooUmpOSM3A9fZVXC1DAL5Lt7oTsYSx1ahnerLNxkYg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkPlbNq8A/WHHC/NZHHhVbVO2EAxIBydUCuNlXe
 NYNnC79l9aJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZD5WzQAKCRD2t4JPQmmg
 c92VD/96fI9l78DUXZovCVHtg5dAd2W4sHYnQyrC3uuSjOEml0vuaVgsGdm2XnQjnuz8+XUHjym
 fJCWQ9UHYnlfDN8nkOk6NlMr7OTJDbMTUkZ4egIIf6dMdGRDo+uqKAizmzg5Ji9hDOnYdjYanLj
 NcAo4KSrKOTwC1M9qShEXpv+Jksl9fOEOKRq3f7RJZIxJZB05U9dqiiclSMNMCSzibfMPG5rH6y
 42SMwyrrnQnwyBGE65obPEGf5TJhjmp0dO6NVKkShU2cctr+q0PWnJN4FWpNdq+uQLhAdyCjs4t
 oGiKjZ7OhVUpSFKi1hpeA+55CxPGAwShRLxPraYv3NVdYDD+oIK5UdnfonJpBP4XUTlU0tsYpj2
 p5wmVpP/BQTMLQO3MbNkVX2sxNSl99EYZFhiatiwikOp2INaI5yWloz7eu9gAafbsDbsAsXjIPj
 MDZUngML6+BOTJML3V77XOEB9+2rf9TbNWFNKFG2q8JpUnz9glGDandnspF6TRTtLgTecqWslhl
 +ZTXXKWLAwzf1lva3qrJydcXUbuoJOssWk53pOVg16fCCRwFQ59Niqhwb9nR3PB7YGGthRGqKn7
 vZtdq1BJfsyieELvZy3olbeUxitHwwfbbdWJwCdEKo7q9Gh+bGA2SnFzuTJ5NLPFbGyIMIe5O8H
 KmMy9k0Rfhp1miA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Map Mat's old corporate addresses to his kernel.org one.

Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index e42486317d18..69dae9b6ec95 100644
--- a/.mailmap
+++ b/.mailmap
@@ -297,6 +297,8 @@ Martin Kepplinger <martink@posteo.de> <martin.kepplinger@puri.sm>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@theobroma-systems.com>
 Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com> <martyna.szapar-mudlaw@intel.com>
 Mathieu Othacehe <m.othacehe@gmail.com>
+Mat Martineau <martineau@kernel.org> <mathew.j.martineau@linux.intel.com>
+Mat Martineau <martineau@kernel.org> <mathewm@codeaurora.org>
 Matthew Wilcox <willy@infradead.org> <matthew.r.wilcox@intel.com>
 Matthew Wilcox <willy@infradead.org> <matthew@wil.cx>
 Matthew Wilcox <willy@infradead.org> <mawilcox@linuxonhyperv.com>

---
base-commit: e50b9b9e8610d47b7c22529443e45a16b1ea3a15
change-id: 20230418-upstream-net-20230418-mailmap-mat-f2bfe395acc2

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

