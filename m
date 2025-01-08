Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EB92010F6
	for <mptcp@lists.linux.dev>; Wed,  8 Jan 2025 18:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736361654; cv=none; b=j9CPNZDKw6+zqNL62ZPznWASHwi5nGRjIaDtqZUW5soGPGWPrCb8wV5gby+ak3Jw7D6NMLKqhDjJ4rWYRAqryvNxwAr1XSewGfmwNr9zG4T8dPWtWYuGnDe4Co739ozRDYChvjlacXUxk3fORyi5nL7q7QQOgPEoHUXZaRPhl6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736361654; c=relaxed/simple;
	bh=ycmGt5JyUQGequhaveVetlbpGu3PFxdExfZ+jTLwQ0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J2TH6Wo9VwHjq/G3MT8o7Ktsq92XgDtI3bdS1oyEAiVJMNLOyGOA8n6/ci8JCpigsCx9mlHzkAqnLA39hxK5I44TZ+nyqyVJQhISYjn4otqb8tNrhJUSSoUf+u4ODeMxVtBrjfQsMNhJsG0DwiLzG759OetUgquk8kcxQ53JXjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvkO2nkI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvkO2nkI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19C7C4CED3;
	Wed,  8 Jan 2025 18:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736361654;
	bh=ycmGt5JyUQGequhaveVetlbpGu3PFxdExfZ+jTLwQ0c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EvkO2nkISIJFg0RX+2FJLOmSKQx0VYGNCVictagie3oxfrS2b3eWLaS+vgVr7I1Bg
	 s8E+52cUohWTYAdwBtZr02wXgnIk2AlhiGUiphWPDbcwQWsXFNjxOCTppLYmCiFeWA
	 akYKA1VfbOSnkT3mTQ5yVPCOBUXZhZ5mzioFBzJ2ifulayBE48OA7NM4aqTPkLnTd1
	 bsuMpgowiK6ITUsB014hwrCerra7tSbIq5Zt3YmjxzmzwC5bEJwWdF23UJSNPpYb0T
	 GoStnDuZ/AI31C0qoI34fO2ny0Ej8271rB4WXCbZEMMDK+yndaJGXCJEm4cLyQNhCt
	 TYJjyTMKRc/VQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 08 Jan 2025 19:40:41 +0100
Subject: [PATCH mptcp-next 5/5] selftests: mptcp: connect: better display
 the files size
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-slft-mptcp-conn-misc-impr-v1-5-bdfbdba48a1f@kernel.org>
References: <20250108-slft-mptcp-conn-misc-impr-v1-0-bdfbdba48a1f@kernel.org>
In-Reply-To: <20250108-slft-mptcp-conn-misc-impr-v1-0-bdfbdba48a1f@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1403; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ycmGt5JyUQGequhaveVetlbpGu3PFxdExfZ+jTLwQ0c=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnfsaw89FuMejbgD/qgEK7MIkAydae+wGWEj1fv
 vc4abx/v/KJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ37GsAAKCRD2t4JPQmmg
 c4WJD/4n87TMlm5weBfTO4heQV23KdJ2cssL3rWiJjZFWjRJaCy3uvgvBYNbZlOlvEPPF/21sf4
 eGLtf6rQMwnYDun9NMuK7uJi3ULvNyF/D2nbijsNHgzJ970Fb/Ck22qND4RA8GzFVRXqKR/Dilh
 it6rccnx4uHiWxwr3AiR3tLfh1mN5Do+PoF8bl5nwq77ZPwrfVPyZr7Dmni7kBTq56GUBrKpD+H
 HmC5YKIF+xVE1AMjypo0L4SM318/m2X4p6uX6DTENxy4AWbaMd/OVqmEB+Sykn3AswIzG6i2EXO
 S8OVSt9XkD1LvN+Uyekh1xzOHljMA8trKJf5UsrnkvHxo7TpfpiuLvgjcYR6nZ9KWGBVLlr3TEn
 46OOaZ0bd8/+zv/ehvfyOnG0vApKxyrkqiT6nWbzJkOwDziuG2g5o31IjtBUTArw9loE41aRVxI
 9bxwcz22gjxEyNCWpkdH4ODV6+H2rfb8RKrRkZiMiZYqJT09VkM/61sQ/VeTlAnh1tiYj8HMcre
 LwFjGo196R4TjysATwmpIC/MO4nVFZUlCgpyXay/7d5I68Gshw49TqOdpRYzCCj4sTVqA0NbCLc
 /ZmfXad2nByAFl7B3qDBc/6Byd5szle6GGau5bTgmIJ6rbrTEW/h1x0sTeOcJIRvoZTeCLF/55t
 mIlrjypT4WTh7UA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

'du' will print the name of the file, which was already displayed
before, e.g.

  Created /tmp/tmp.UOyy0ghfmQ (size 4703740/tmp/tmp.UOyy0ghfmQ) containing data sent by client
  Created /tmp/tmp.xq3zvFinGo (size 1391724/tmp/tmp.xq3zvFinGo) containing data sent by server

'stat' can be used instead, to display this instead:

  Created /tmp/tmp.UOyy0ghfmQ (size 4703740 B) containing data sent by client
  Created /tmp/tmp.xq3zvFinGo (size 1391724 B) containing data sent by server

So easier to spot the file sizes.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index e508d356fcdaebbfb95750bba0fa834a8463e32a..5e3c56253274a1f938d2ed9986c4290fcea8b96b 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -582,7 +582,7 @@ make_file()
 	mptcp_lib_make_file $name 1024 $ksize
 	dd if=/dev/urandom conv=notrunc of="$name" oflag=append bs=1 count=$rem 2> /dev/null
 
-	echo "Created $name (size $(du -b "$name")) containing data sent by $who"
+	echo "Created $name (size $(stat -c "%s" "$name") B) containing data sent by $who"
 }
 
 run_tests_lo()

-- 
2.47.1

