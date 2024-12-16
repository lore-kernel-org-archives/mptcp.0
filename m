Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B741C07D1
	for <mptcp@lists.linux.dev>; Mon, 16 Dec 2024 10:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734345602; cv=none; b=f0a73ztFNZ/G7DUa6DwtKtnqeGLmb0Wua4MZT3nK2opvsiz0ILejnU5Tl5jJp8ouwSWG1iFSNsGemv9eFLLkb7ed65E0gpPzIuOjk9OhgXiz0dA7WTZ3gTqZDfy9Rc2fUZe1XGdPnVV/HWIYfAkEvRR+SF4Q8lKAzNcDVP5CwgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734345602; c=relaxed/simple;
	bh=Dd1FACokDMBbW+30zaKlNXYWsmffBUIGHRug3y/gLzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C2ufcaaYdFOI34msBhhPExW9lxyL0aWHKY47XwlZHhVe+KKZAs9NtWAgbm5RT6/jhnb5dbJKbDs4aDb1Iyskeik4C7PvdvqBnCq+RM6mhP50X81IM/tBKSATGSOuAdMkS3pdKFAWwMpWACJ57N6zkH6J4NXwBLbWsPod51bjnhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErJZWn8Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErJZWn8Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F033CC4CED3;
	Mon, 16 Dec 2024 10:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734345601;
	bh=Dd1FACokDMBbW+30zaKlNXYWsmffBUIGHRug3y/gLzY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ErJZWn8YrnryxBCWNzWjnY+POqXFPMNX2Q/GGg9QNLzghwMAF5cn77i48IaFmBkAD
	 o1Xry3s9jVXZ8WPHOQKAV/VIHls9h4tAhhIao7bgnIqm38hKKY3JFKECbK3+cZK1pF
	 AimJ4r6TVpQ5mMA7NVq+s4YGyTkSdhVFfKKO7DIrcQ/fX79zedRdrW4xhm8QSJQ181
	 eyenDCtHAu7rLmey8yztvB0G8K5RwPZHjSjvfhlG4IfsMas8E1L7YpgEVrRimPzJ/N
	 Z0NfdYE4wMZAVu0OwIWUzt0cG29Y1LYkpN2KB+Q0fRK7Xz28m3D7O9U5WGG42iS8IM
	 XyC929/1A8XBg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 16 Dec 2024 11:39:56 +0100
Subject: [PATCH mptcp-net v2 1/3] netlink: specs: mptcp: add missing
 'server-side' attr
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-mptcp-pm-nl-spec-doc-attr-v2-1-68807f55d42c@kernel.org>
References: <20241216-mptcp-pm-nl-spec-doc-attr-v2-0-68807f55d42c@kernel.org>
In-Reply-To: <20241216-mptcp-pm-nl-spec-doc-attr-v2-0-68807f55d42c@kernel.org>
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1478; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Dd1FACokDMBbW+30zaKlNXYWsmffBUIGHRug3y/gLzY=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnYAN/LEjGaHdtiDlUtFrrGb+Ayc8uFAjhL1QcY
 DDK39ZQjfeJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ2ADfwAKCRD2t4JPQmmg
 c9cbEADJKOFpoJjX9HcToLDX5FF3cuhnAXA6+cuhruOy9v76Ts9sZ4GnBKvOwzR9IDpXxo9zxKT
 XeZnopiAZAmfC3K1pM6KPLs/dVPBVIBfOSPgz0U2M/EYQRllzay4ykt3EOSyJHx23EOkgeznJNM
 GsueGyZNu6OWU/FI0pPXFYsJyrMqZoDOm5FmaAQsqMDNu4l8mMF0LGp0Msr2SFc73oR0cvCxvVa
 euFkYfQiLWoRRDkcMFyR4e1/EmCoPPYLQPUMjsnJUuBoGI/EvI5mxpB0ajMUW3eTsexTvb8h46d
 S010judGOeIINP9eezyUl+2GIkqsCqqTEtuGH1ikPJqdz2a5YqpNOMpTULSAWxXNnAZQHMW3Ogc
 ZZ4hC54PbucDKeCTTNicatupY/Nl0v8HynTqGbiBNP0kGHD7n25WBy4Qtm+nkAF1VJiuXR/vLhn
 nrltalfZLns7grmqw9Ej2449Dn/NWN96nNI1hndVElYVeR2U1bLXlpazbEZkt4yXK7tPdAqLSZQ
 VCkvC93AhEZlSXQ1KBD6Lq/sipq7Z93RHMhkxAbQ0oz7oinu8nshVGbLM7QGNZGJMxyAJSHVKnF
 5wuC9ZaIGZb2oOkwlNxi9awZ4HhAl/82lHvNlsx+nIzyQHJIrFlFP2TPsFMfGGdwOH9m/W03HjN
 r78AjA/PTr5zRAg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This attribute is added with the 'created' and 'established' events, but
the documentation didn't mention it.

Fixes: 41b3c69bf941 ("mptcp: expose server_side attribute in MPTCP netlink events")
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 Documentation/netlink/specs/mptcp_pm.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/mptcp_pm.yaml b/Documentation/netlink/specs/mptcp_pm.yaml
index dc190bf838fec6add28b61e5e2cac8dee601b012..fc0603f51665a6260fb4dc78bc641c4175a8577e 100644
--- a/Documentation/netlink/specs/mptcp_pm.yaml
+++ b/Documentation/netlink/specs/mptcp_pm.yaml
@@ -23,7 +23,8 @@ definitions:
      -
       name: created
       doc:
-        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport
+        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport,
+        server-side
         A new MPTCP connection has been created. It is the good time to
         allocate memory and send ADD_ADDR if needed. Depending on the
         traffic-patterns it can take a long time until the
@@ -31,7 +32,8 @@ definitions:
      -
       name: established
       doc:
-        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport
+        token, family, saddr4 | saddr6, daddr4 | daddr6, sport, dport,
+        server-side
         A MPTCP connection is established (can start new subflows).
      -
       name: closed

-- 
2.45.2

