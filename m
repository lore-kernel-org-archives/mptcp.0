Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1E06FA1
	for <mptcp@lists.linux.dev>; Mon,  3 Apr 2023 16:23:54 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id m8so6541613wmq.5
        for <mptcp@lists.linux.dev>; Mon, 03 Apr 2023 09:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1680539033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O0VIT8TZ6PUqENiB0PP2YTFEcbQqLs8d7zTBwgh+XTk=;
        b=elnCELaSFuXK7yQWz3Paf/eINw2dgDZyfnQT8ZKYrr8N1smCeAHdFhw96SJZVaILTH
         xUMUanNqKktx8pznls2/BHD+0l3h8ki/zHPel6WOVHeYFQptHYSin6ixIWQaHGiunnNA
         i94NNXizaMEYgqS7oYspnANoq1aNrw/lq+2WOuQ13Fx2vPbp38JADSkil14J/+LOplQD
         5sTSs8yhQ++ItEt7iif0uWD7scYzgRQpSjoT2b3LUTndSzMVs8npKG4qt51nzgvDRCcu
         v8taopgWDKHutDCDkHvXfVwKVdwpTyJVeM3HeHHKAkMzglUWrhqKgByfmWpYqMK1x0ZN
         hBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680539033;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0VIT8TZ6PUqENiB0PP2YTFEcbQqLs8d7zTBwgh+XTk=;
        b=4sXOEQJFcSvqye7m6qWhpRchV32yovaGYU2wrPSIWP1yvl7OSllcKtlM4awvlUxCBe
         LtBXz8S58QeTlysNuEolCOM3GnjjDgaMYqsfl6J16agEis+O96dT3y6p+lynoHS7e3/l
         m+jhqTqoz7ihmx9WCXqdn0sm9NWe4L69Y5sWDHMnf2ldmbTnXS/pG2bkR7iaK0Wf7Ihk
         t12P9hJ03gu0IDXMhQEV8YmT4I7FUpz/SR/rRCFr1/l7eiJu7SKHofGNAeko0qo+VdaS
         481rU8gjs/7xBGbW0XJe0RRCnqwdX3DTYkawnQeeD/jWtcvj3CU/Jdl66IkSszV23rlr
         LgHw==
X-Gm-Message-State: AAQBX9f0QRElmUS9qaUy7yacVaN2dsL9Q/HjQOnid9IAQVs1ipUCFuAR
	m5crIbaVC0zTvRVHHpGjPwAIcw==
X-Google-Smtp-Source: AKy350Zef7TDmoPw72330n03SFPB4JVw89DOpuM+8CG4miZgSV+7+xPDIYHsg8fjVRcaTnU3VL4ZBw==
X-Received: by 2002:a1c:ed0d:0:b0:3f0:46ca:f204 with SMTP id l13-20020a1ced0d000000b003f046caf204mr91834wmh.3.1680539032898;
        Mon, 03 Apr 2023 09:23:52 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id s7-20020a05600c45c700b003ee2a0d49dbsm19829116wmo.25.2023.04.03.09.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 09:23:52 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Mon, 03 Apr 2023 18:23:48 +0200
Subject: [PATCH v4 3/5] checkpatch: use a list of "link" tags
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230314-doc-checkpatch-closes-tag-v4-3-d26d1fa66f9f@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2709;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=uNHgQP9fiZeAiaOLfX8aSeCRx0Lpr6GESKEpWun+wb4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkKv2UTb48iAU3x83x6niNom53FDOQfO9/KSjdL
 HaiCNpConqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZCr9lAAKCRD2t4JPQmmg
 cx74D/9dKhJje+7gSQaGaYypiZ60D9kMH014UKirg6BHlhT2CjZQjDYDnfBaIXZtLfLwGLCFgF7
 lP0s3YVGqgJX4ww7TfJigC1mqHvk+E73LZrqo6Uav17ljzLBdP1L3K2i6VZep8f5gw0sQL3puPz
 QkaZCuJXvoiIFtfLX0rSQ8PFyKJXIlACQHWfrPpkiRztb+kx2X6sPC50XfDd4QPnOK0thxOKhAa
 qzC9mrpRE5ToYutQm5zpAF+ED2pOEcWkMXrRoiFRLCasU+V4LKLPa7KA/KELd3Mj+e3nGD6hIS0
 qm/OdPNd3lawhGRH+D0RdDplpXqO4U0WOTp2pa56nHBe0Wcv9UwqWQYWheDKTw5gv91XbOWcoDz
 ABVDKCFyFXtHxIN6xAIMVEQswrCrPHS9aQ4fwPKwGDsLAFf1gJmOVcl2xhpI/1e/tKCdvl08l1b
 LiOtEFujaIlO2zOK0BGkA1rti4p5rzIKWcP1i/oM2kch/7kYaxCaj4X1uzXbA0rwGFSsRPNxJXZ
 Ki/WKJtWiSA4S6bc5KM8EwSjm/ryR96JerwIRLw+q/2gGll7glogis7JmvHy3EeYloyfnXIZ+r6
 kPdAPECcIY2NTmVGk4yvSiSZIBx6zEzuAGvE/pzRNYzQfdyudKgmo3jwB7Zrm7WUWxrH2KfZLOO
 IGaz17ksBRJrY+A==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

The following commit will allow the use of a similar "link" tag.

Because there is a possibility that other similar tags will be added in
the future and to reduce the number of places where the code will be
modified to allow this new tag, a list with all these "link" tags is now
used.

Two variables are created from it: one to search for such tags and one
to print all tags in a warning message.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
v4:
 - "Reported-by:" should be followed by a "Closes:" tag. (Thorsten
   Leemhuis)

v3:
 - new patch. (Joe Perches)
---
 scripts/checkpatch.pl | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index b170fc7ef258..1647ef72480e 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -620,6 +620,22 @@ our $signature_tags = qr{(?xi:
 	Cc:
 )};
 
+our @link_tags = qw(Link);
+
+#Create a search and print patterns for all these strings to be used directly below
+our $link_tags_search = "";
+our $link_tags_print = "";
+foreach my $entry (@link_tags) {
+	if ($link_tags_search ne "") {
+		$link_tags_search .= '|';
+		$link_tags_print .= ' or ';
+	}
+	$entry .= ':';
+	$link_tags_search .= $entry;
+	$link_tags_print .= "'$entry'";
+}
+$link_tags_search = "(?:${link_tags_search})";
+
 our $tracing_logging_tags = qr{(?xi:
 	[=-]*> |
 	<[=-]* |
@@ -3250,8 +3266,8 @@ sub process {
 					# file delta changes
 		      $line =~ /^\s*(?:[\w\.\-\+]*\/)++[\w\.\-\+]+:/ ||
 					# filename then :
-		      $line =~ /^\s*(?:Fixes:|Link:|$signature_tags)/i ||
-					# A Fixes: or Link: line or signature tag line
+		      $line =~ /^\s*(?:Fixes:|$link_tags_search|$signature_tags)/i ||
+					# A Fixes:, link or signature tag line
 		      $commit_log_possible_stack_dump)) {
 			WARN("COMMIT_LOG_LONG_LINE",
 			     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);
@@ -3266,13 +3282,13 @@ sub process {
 
 # Check for odd tags before a URI/URL
 		if ($in_commit_log &&
-		    $line =~ /^\s*(\w+):\s*http/ && $1 ne 'Link') {
+		    $line =~ /^\s*(\w+:)\s*http/ && $1 !~ /^$link_tags_search$/) {
 			if ($1 =~ /^v(?:ersion)?\d+/i) {
 				WARN("COMMIT_LOG_VERSIONING",
 				     "Patch version information should be after the --- line\n" . $herecurr);
 			} else {
 				WARN("COMMIT_LOG_USE_LINK",
-				     "Unknown link reference '$1:', use 'Link:' instead\n" . $herecurr);
+				     "Unknown link reference '$1', use $link_tags_print instead\n" . $herecurr);
 			}
 		}
 

-- 
2.39.2

