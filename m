Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CB29445
	for <mptcp@lists.linux.dev>; Thu, 30 Mar 2023 18:13:49 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id j24so20033047wrd.0
        for <mptcp@lists.linux.dev>; Thu, 30 Mar 2023 11:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680200028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2pcuoehiPvGyehUI4bF839lUv51fj3SAdGORffoe55w=;
        b=AL19jyQDpXSIL97ebF8N6roZDjqqZ58JaDJ+a22kaBzvp0UeYTNwsP3ZrjU8naMj0V
         PyfbKCnH4RN7ZGwsCHfoAL5WmWlRu2w5imZcn4+H8inw9ZdoNpx2Xlx8fHwauzBjpAtO
         zsZog50xCUpJxXr9uq4YLZUXyFADB62kXqUbAx4glHPggEt9w9bGroTD4RgRX6a9mArR
         fbyPr6Z4gm6CNzpCP/lcbyxcMqqC2E/3xCYCXOLwWrLRt8KkvWqZ6awi5ySj+ZwKj5Qs
         WjXHFdJfcuVd3M36W8Lh0WsERMEAKn6lNkMcWIuI5aW6i92vpAMswIkcEUI+ymPFfU9h
         BapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680200028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pcuoehiPvGyehUI4bF839lUv51fj3SAdGORffoe55w=;
        b=LYeN9WRAHxqJ0kq9lRCO6XK5QQ+ekzatq5g9y5W8UI3UDswotbd4zQHwt0n6lbu2TM
         2R403gw+eMGMIEIrCfkKPUGpWdti0a09u618uAQLCgbqZLmmVZvOoK7u4O6odx3Su++k
         2otjFjiLmiE6+YN/zSBwDlUDCOUvgMEHDtJbew14LYkmecZUYj1imNbuI4scQRq4YrQv
         YIqkceFX9LamdOYz5nGg4EpOQAHzmgIseSmiWyHt5Ss9Rxujl5102tHFjV0zcNec0DRW
         MJGqm6/SJXi9g/sEgQcsSE/0mc25TTr9lBYMTtpZo6NfDe2/OlgLM3FHZN+TDQg8Q74X
         G6ug==
X-Gm-Message-State: AAQBX9eV+smB//Wu12zK34/RwbZFr+dQOW3P6sCbzGXaCm8FvfpPMev2
	V3JULF9GzSo2sGjjw1O2iWcUhw==
X-Google-Smtp-Source: AKy350YzU7wPKjANBCuoa0d1SuYlj3kkszREhmdvT7pjdImaboEpN1UAurUNdi2TP/Voo5hlSVe9wQ==
X-Received: by 2002:adf:cc8f:0:b0:2d8:cacd:797e with SMTP id p15-20020adfcc8f000000b002d8cacd797emr19190788wrj.10.1680200028130;
        Thu, 30 Mar 2023 11:13:48 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id e18-20020a056000121200b002d24a188b64sm33459741wrx.112.2023.03.30.11.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 11:13:47 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Thu, 30 Mar 2023 20:13:26 +0200
Subject: [PATCH v3 4/4] checkpatch: check for misuse of the link tags
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230314-doc-checkpatch-closes-tag-v3-4-d1bdcf31c71c@tessares.net>
References: <20230314-doc-checkpatch-closes-tag-v3-0-d1bdcf31c71c@tessares.net>
In-Reply-To: <20230314-doc-checkpatch-closes-tag-v3-0-d1bdcf31c71c@tessares.net>
To: Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>, 
 Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
 =?utf-8?q?Kai_Wasserb=C3=A4ch?= <kai@dev.carbon-project.org>, 
 Thorsten Leemhuis <linux@leemhuis.info>, 
 Andrew Morton <akpm@linux-foundation.org>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
 Bagas Sanjaya <bagasdotme@gmail.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, mptcp@lists.linux.dev, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1260;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=4mEcP5uVl3gASvU4Xov+GjgFA2y/DSnWoQCQNXocbFA=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkJdFWAiRwpGTmZ3UksCrrvVVsadaDQyEH6ttlf
 xxeioGUWaiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZCXRVgAKCRD2t4JPQmmg
 c+FYD/0QL8eSGtX66aGfn4VRo4nKjkBYeiz17dcwDxp+NOHSIrjUHDK2Qeq8pz+BpJIrV67/bNJ
 8MhzhaNILYp+AjzLuRkW84TbGMi7o7LdOiLYZxo/Ija+64oRf4vvmftrxrUJwu8uAy947w1yvHk
 x0bmZIsBKQ+9hgXQ6wWuYYPbeyQwPp2FSyzO6N/OQr/0aSgs47n2IY02IU6QsDi3e2lzdIMIFI2
 W2LXk4KVDgiXD1Veoza94/lVWLw/uYSa2C1lZhm1pqTNOadKwrgtedxsgaK1rN901KhsA5fKnkt
 HMMfbu72dNEp9LCBO72pHW99u0ejQrk96QzZF045hPU0MRR5oZ/sKdol+NKmLvIQDAFsaU1eHxB
 xHeXPSfskzfbSmNCfu2iXbH5Xrn7+qcXmL1LlDm5hsGye9N6cKGqtg6/6Ri6+ydi103F2QohLyT
 HVZA/QymXSExliDxXnHo8nYS1eQGXMwIgrJI93/qUtmoKqQyqqPtmdI/EfW1K13d/dg3Y0NwqA7
 lZoqqRjZR8/TtAUbRagTAYdQc4gQrsMwTDgr8aRtKKunFHJJN64Jj0L1QdPo+3YY35qpGXdpdy1
 hBzhevHe0CZPzD/KQL3v/RkD+Bw90Sh+fblGKQFOQYlO9n3Gsq4EG00rbtlgzf45L33chHqdYOj
 fIHOulDCJF2UKCQ==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

"Link:" and "Closes:" tags have to be used with public URLs.

It is difficult to make sure the link is public but at least we can
verify the tag is followed by 'http(s):'.

With that, we avoid such a tag that is not allowed [1]:

  Closes: <number>

Link: https://lore.kernel.org/linux-doc/CAHk-=wh0v1EeDV3v8TzK81nDC40=XuTdY2MCr0xy3m3FiBV3+Q@mail.gmail.com/ [1]
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
v3:
- new patch addressing Linus' concerns.
---
 scripts/checkpatch.pl | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index ca58c734ff22..e3cafd2cb77a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3292,6 +3292,17 @@ sub process {
 			}
 		}
 
+# Check for misuse of the link tags
+		if ($in_commit_log &&
+		    $line =~ /^\s*(\w+:)\s*(\S+)/) {
+			my $tag = $1;
+			my $value = $2;
+			if ($tag =~ /^$link_tags_search$/ && $value !~ /^https?:/) {
+				WARN("COMMIT_LOG_WRONG_LINK",
+				     "'$tag' should be followed by a public http(s) link\n" . $herecurr);
+			}
+		}
+
 # Check for lines starting with a #
 		if ($in_commit_log && $line =~ /^#/) {
 			if (WARN("COMMIT_COMMENT_SYMBOL",

-- 
2.39.2

