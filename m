Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582DA482C1
	for <mptcp@lists.linux.dev>; Fri,  6 Sep 2024 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725642916; cv=none; b=PhGduIIMo0l3EJPWYlEwVKt9LEe5zCUkSOd7iZGisPmh88uEP8hE4rQVNzvOiQ8ol8Gi4Vg5KoVpjMSWySfRHU1r8T7VnRxYFHyj20Ayg/wswFeYJ5HbSCBvGKt1iJeubN3ytL/Z+skB0izbrJfeIOTDu9bLbO2MmBtCqATzRvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725642916; c=relaxed/simple;
	bh=xd3/KxZcW9pUIRMfszf/MyagQ4l3HvuQgPMdxlZylOg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MnggmA4yMQmOdiChnUf3jrshba7MYxJrTtFxda6ZaxC/HG1iBxogI/yT1CxrwPfT161cJNByDOJYHTs6F/OJwrpdeTr0ct6YCEtZPDsNw3o2MCT6aXBIC6uYy/CuTLMDVaLCStzxFe1qABo7EEEYo/0oOrtBlXE6vgxs3bYrCA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJXYolyP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJXYolyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E50C4CEC4;
	Fri,  6 Sep 2024 17:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725642915;
	bh=xd3/KxZcW9pUIRMfszf/MyagQ4l3HvuQgPMdxlZylOg=;
	h=From:Subject:Date:To:Cc:From;
	b=oJXYolyPknglhz9OWrXMd0C/z1BB0SYv18o/eLC1SozDNdxhtdcN652lV71FMyclC
	 +X0vbBafKO+7ZG8KRea01ZQw8vVPytsgRZOaFNSUwKKSHhiXX2sBWg5Sbu19Sjn6iQ
	 /zlgWvJ4trd4DqOj9peqOCyy2A0dN14VTao8jpJABaiZHCztge4alJCbNmUEDJAMk0
	 59WkzVwtqpFGjHgMKdcBaDACnczTfFxLjVmMowgXl9YJX3UJ/DL4/5Vxw/ZbuiLJBR
	 Cgat0SbLpdURRXktwRAgFA1Beu/NR356Kef/V8Es3l+orxdVMAXAY1KH2Aez67p4MS
	 U4nNL9JaUKB1w==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/2] selftests: mptcp: add time per subtests in
 TAP output (part 2)
Date: Fri, 06 Sep 2024 19:15:06 +0200
Message-Id: <20240906-selftests-mptcp-trailing-ws-v1-0-03421b02c48e@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJo422YC/yXMQQrCMBBG4auUWTuQBgnVq4iLkPytAzWGzKCF0
 rsbdPnB4+2kaAKl67BTw1tUXqVjPA2UHrEsYMnd5J0/u4sLrFhng5rys1qqbC3KKmXhj3IOPmG
 KeRpjoH6oDbNsv/uN/nnBZnQ/ji9bhVYmeQAAAA==
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=884; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=xd3/KxZcW9pUIRMfszf/MyagQ4l3HvuQgPMdxlZylOg=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBm2ziilB9TSzMX2TYM2p+LYXAb9SRLe58Ik9AZ2
 9/Di3ACNUGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZts4ogAKCRD2t4JPQmmg
 c2xOEADjFnNiMKmD2fFsBxvjcFdyFngz9EvSIxcil7n5jNrn1W/46zdstW7jkTB53N3dhkaCrj4
 3nYOG220nNMnodPBGjtYsgUUnOFwk9S4BksisL+MQUS6DnnQ7lKSGB4EBYz5vAiopMfHiztmmSb
 /697SYBi8g87UAGEkQ+ZR6azylGWdQnK3uzTdsb5kk1d11VjLWiNlcJvB/9OPMKSQYsLeZmfsil
 MSdCRzc92mMqnN0ZB4kdIcQIn/J9HJQqMaT8r0/riYbF2Bj/nPJcpH9IvPHlc9Gw9lwksv/M7at
 9VZvHj0HqmwjqIijX2Km50mbntyc9DuQf7cnOXUYoOecj+GKd++ButBINHdR2+fh+IUkLN1ecFk
 V3NwwTz7XyRbIw0oln0Hn31OpVlYJUJ8e5xV+Ii/VqrZQKsIkQhNpzPBfNi1IHTWLC67H36IZW9
 dkY+90RTFALK+UV6QZ5SLQRVPUT1EI9TF4D8thsU00nQl7F+PvYVKXPRSshNA8mcjilOcAn+w2Q
 xtGeY2B79eGn81N59rzuEEsS6gSBxui9fdauoSx+0TiP+CTUDZbkcQdqHh2HAzvSuoYJkzJPJhh
 cpe30bsjQG9/A5iSzKPNhhzLc4E+97kR/+VUWKItD9jjM44abYGDngWlK5pLfHt50kADWssd2Y6
 UF4ZGBo8WjcoQow==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

After having sent the series with the same name to Netdev, Jakub
realised the TAP parser was not properly handling the spaces around the
directive delimiter (#).

This has been fixed [1], but still better to avoid them.

Link: https://github.com/linux-netdev/nipa/pull/38 [1]
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (2):
      selftests: mptcp: diag: remove trailing whitespace
      selftests: mptcp: connect: remove duplicated spaces in TAP output

 tools/testing/selftests/net/mptcp/diag.sh          |  2 +-
 tools/testing/selftests/net/mptcp/mptcp_connect.sh | 14 ++++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)
---
base-commit: f876b6643a4a01e34ef370da4e15d7c644585d55
change-id: 20240906-selftests-mptcp-trailing-ws-d62ce8ad81a6

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

