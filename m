Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039316FDE
	for <mptcp@lists.linux.dev>; Mon,  3 Apr 2023 16:23:56 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so549712wmb.3
        for <mptcp@lists.linux.dev>; Mon, 03 Apr 2023 09:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680539035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1cnPk/9AEptXAjDqAXnPNZVq3fipWv8RDKGe+Nooncw=;
        b=bY/nVj3tvufRZC2aBKdYwGx6iARCUJjXkVNxp+oE/oG3ue8sZ0wK3wDYThVFVn/YZp
         1BecYJHvgUHReHKT78+3DcLkwE17o2ziPNWrNsMiVyRpsvOShCyJr4n8wYITWFFsymyO
         CIPZtlWuUixZIILH8yY/D+rFwMuasQKHpesU1fJGSnk7BKUm73VcaZG3IHq+wRr+3fLe
         sAgJ3j5n9Ic7mDawcKIqSZxwxE35SSF/eTYKHVqrjfH69XtthMgO8jR9ZIrsDh0mQ2Mk
         +SfTl+AbAygGPD0TOKP6S8FZXmP5s4D2ErdIhqltjwG3HuESuD4JSYBGuWBMBEPHecpQ
         Aa0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680539035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1cnPk/9AEptXAjDqAXnPNZVq3fipWv8RDKGe+Nooncw=;
        b=SrY8ABhDKq7NfYatD/xO5iKCt/J2WgWHwGL73LPwE/L+PN/wBfM+0pZ0RDdT3T8sbO
         2l443l5RkFOVzOUcs+wZFnBQEjXLOIxsoDmeH79Y72MdrcUNovVtYUIbb4UOHchyBSYy
         mRGKPEgnrqXNWuckPAa4eNQayOf/w8DKHR6bNQx75CiaQi75DI+KJH/QjymSKVKUDvT6
         lyItddppeXmu2Cx7Ch5cSla6EVJ1MeyShKNUFvYy8l1OeXUcJdi0Xs9PYMDkjw2V82Dm
         ltrU/m/w2pmgOD/vj14BMYvb3zd05LFbajd7w6Iqd3Y611NQv37EIFRN56bOf+8EFFRU
         DlJg==
X-Gm-Message-State: AAQBX9d6LZpp5BrZID1i8QBY5J/b/5Ro2WBiH1DYYuxk0n0LYaQ2uOhB
	ALTxd0uRVfLdFAlX5hegRbCNIk3NSZ6KXwvzirH4dQ==
X-Google-Smtp-Source: AKy350aDvEUBTCOJO2eqLa0fd0WCWd6eUFzvxCfrzuKP6KrlGxHl8jGFVTbsKPFP9b/3iu7Fs6ESjg==
X-Received: by 2002:a05:600c:2205:b0:3ed:fc8c:f197 with SMTP id z5-20020a05600c220500b003edfc8cf197mr27400wml.29.1680539035250;
        Mon, 03 Apr 2023 09:23:55 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id s7-20020a05600c45c700b003ee2a0d49dbsm19829116wmo.25.2023.04.03.09.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 09:23:54 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 03 Apr 2023 18:23:50 +0200
Subject: [PATCH v4 5/5] checkpatch: check for misuse of the link tags
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230314-doc-checkpatch-closes-tag-v4-5-d26d1fa66f9f@tessares.net>
References: <20230314-doc-checkpatch-closes-tag-v4-0-d26d1fa66f9f@tessares.net>
In-Reply-To: <20230314-doc-checkpatch-closes-tag-v4-0-d26d1fa66f9f@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2132;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=t+lMrvt0On4Mxp3JcNKwbfZAV8NHmHJODiLaTsQGeTo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkKv2UP2J95HDGOy6GcObMoPKAxDPMjFQma0ptP
 YDEho8OsPWJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZCr9lAAKCRD2t4JPQmmg
 cwtZD/wP797mT8e5Jwc0WcO3sS51zfy4ZGWVmeOkMdhMlXA+/JyEiFXu8ymEfqAPvI7mtMpnLyJ
 Jshl7CMySAjSk/aHtzfBkzG+TvNTgmHHOBgFgCe8VR2XzyaXCAXD5ydOXsn+wS7HdZYpnAL7Jk6
 9RKRVTWhVt9qxEtNjsS+CNLkeen04AoWpIVc1o/gXxBhiHYQCWn4u6cJHFaZQsFfwKafTI+7FeB
 /4FoJrcDEw8JrcboiW43TiKfhvvnVqCdktlcbDl+lZvYH+DHi84N/bhSKl/RaTPqCRPvzqRT1W0
 VeHq2BdEodmYC9QPVtMymqrT24MALuBAtCok3FMuTxl4lGbaN7Onfcq1MeIOeoIUMSNDLupcWj7
 jgSsfeSeeSjLeni1lVKPTiWfaGsa291OmbyzocRa0AgsK9A7yoabDnCDuR9o9LxFLi5WvXMoItY
 DYyPYnap2vEOLeXcZosOQ+BqTLo40S9HvpddhyZNTe/1pIdUXdXzjHhuZ9BxU8qhpsZbFS68PhL
 J06bbGPyi82TSeV0ZSAxbQQJAW012371gfzb0jFystjLvFNuMdnNg+F+43UHeYoEO3sqLsu0C+z
 i9IZMhOPffkaLmYdH7F/HPtaJrwcyRRKQf2NpZXbbwf3t2TRBVtFEGIC1uiTfsIXqZLcFGRurI7
 54xM8BrgjFZJcNA==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

"Link:" and "Closes:" tags have to be used with public URLs.

It is difficult to make sure the link is public but at least we can
verify the tag is followed by 'http(s)://'.

With that, we avoid such a tag that is not allowed [1]:

  Closes: <number>

Now that we check the "link" tags are followed by a URL, we can relax
the check linked to "Reported-by being followed by a link tag" to only
verify if a "link" tag is present after the "Reported-by" one.

Link: https://lore.kernel.org/linux-doc/CAHk-=wh0v1EeDV3v8TzK81nDC40=XuTdY2MCr0xy3m3FiBV3+Q@mail.gmail.com/ [1]
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
v4:
- Relax "Reported-by being followed by a link tag" check
- Check for "http(s)://" not just "http(s):"

v3:
- new patch addressing Linus' concerns.
---
 scripts/checkpatch.pl | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f8a57f400570..6d602c61d72a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3179,7 +3179,7 @@ sub process {
 				if (!defined $lines[$linenr]) {
 					WARN("BAD_REPORTED_BY_LINK",
 					     "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . "\n");
-				} elsif ($rawlines[$linenr] !~ m{^closes:\s*https?://}i) {
+				} elsif ($rawlines[$linenr] !~ /^closes:\s*/i) {
 					WARN("BAD_REPORTED_BY_LINK",
 					     "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
 				}
@@ -3292,6 +3292,17 @@ sub process {
 			}
 		}
 
+# Check for misuse of the link tags
+		if ($in_commit_log &&
+		    $line =~ /^\s*(\w+:)\s*(\S+)/) {
+			my $tag = $1;
+			my $value = $2;
+			if ($tag =~ /^$link_tags_search$/ && $value !~ m{^https?://}) {
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

