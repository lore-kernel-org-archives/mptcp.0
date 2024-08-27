Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC84A1C0DE9
	for <mptcp@lists.linux.dev>; Tue, 27 Aug 2024 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724765717; cv=none; b=aBQtfHD//y2pEIdBhsH5iIK1EhWqOM+XXn4utiUTjqeNLLDByELNYEZZeg39xXwZ08zJz8+XoXipb0wG/ocpVwUPyVGU2frw9V99aVKAO8vYZ4hT7Zr9wtw256FIK/N7YxfXp1WoieO3lbCsJm+NYsEPiyRbGXuhasLg0DAbk8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724765717; c=relaxed/simple;
	bh=T0nRLX07r05WHx8ejnftR79CZ0RktI2Ei/1vQk1Q4I4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lAeD53XG+ZHwNlBqum3uAMV75qHQJT8DTt4lf4yWeFPRqgvPNaBgQvsJd0IHsqxlIR6vNMT0BJT3GvBJkHQAtafxZd2NprIJm4d46jgA10rZpKFEnxV0ILIWLP9B2fRWX+7R7dKYuD2ESUxgAKT7ce6UjlsNhUV8GaJX1d8B2Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZaumBiq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZaumBiq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDEF0C61047;
	Tue, 27 Aug 2024 13:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724765717;
	bh=T0nRLX07r05WHx8ejnftR79CZ0RktI2Ei/1vQk1Q4I4=;
	h=From:Subject:Date:To:Cc:From;
	b=NZaumBiqMxLE7tpc0N7hVeuPlJBvry70y85dIGwybeK6gAO/XFSYRjJpL+BZ9iLRl
	 OTHwclxjrFL6Ya4ar4cCw7U4QJ3ROKTtS2HiRRainHXiA7G85XwfZbk2CY3qye8q9X
	 ww7oIBvf6RSRvZyQkKJWft8G8hePgUbG1wlxxW2qvUpX0JdIKGM9UXd6/DdmEy5JAz
	 4hlJADT7PYY/vxup/PoVR5CafbyH9+VE1uVGj1AYXFnR7w9uirAgqwMP3smbURR+SB
	 ZZD0GbPVoYSlB+lqYa2ygHbcb8El1lq930MAJ1DxAVYKiYnZmKVB+d+wOjBZiPIic9
	 Gm1+xiMe3uiTg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH mptcp-next 0/2] mptcp: Squash-to patches for "mptcp: more
 fixes for the in-kernel PM"
Date: Tue, 27 Aug 2024 15:35:09 +0200
Message-Id: <20240827-selftests-mptcp-longer-tests-v1-0-ec11c05fe980@kernel.org>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA3WzWYC/yWMSQqAMAwAvyI5G6hVcPmKeFCbakBraYoI4t8te
 pxhmBuEApNAl90Q6GThwyUo8gzmdXQLIZvEoJWuVKNrFNpsJImCu4+zx+1IUcBf2XIqVVs0ozE
 tpIUPZPn69j38vaMrwvA8L6C1EJJ6AAAA
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=670; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=T0nRLX07r05WHx8ejnftR79CZ0RktI2Ei/1vQk1Q4I4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmzdYUEdyqVm4ptD9LJcIVWL5tACwYvmNy4dLVz
 mQI6zGIGnyJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZs3WFAAKCRD2t4JPQmmg
 c3+hD/9mo0i+3vW234EJ989gkLlkpV5EzrHpwOj5mBEBTrTVCbQLrQOduoK4y9AU9/B5mqanEmz
 k66qWiEqT/4jDrb0sKhdK0k8k44anpyiNwfOxMT4NrrWnpmxopXW2SHkkPzFSUntW4lt2+JAJ/9
 Xt/1aqC1n+gNB6TtWUz5OiQKZWnJnICF5ezHQEtg0thqDydQfKVwUObP7AYNnPkad0uZz/qz9V2
 p6FYUGA9UwfwJFC/qVennYx9WsnoOjHHL+hn5Nu3aFgcD4gkcqLXQ/HlZw5eBiGiUTm0X7HySph
 gHq1x8vz5yUkxiKJ0ZhbmehpPTkM51PCdoJrtNayHQQUTFLeuco3xEboMVrNv3xocsCTSNRSCt0
 XaK3Mf+9lzPlUtBzif/JtukQnzAsr6yxwebb2IJ7mNQz/XCuvdbToh5wbuMhJkIcc3ogvXPdhPY
 TyswUx+lX1UlaiFenNEaW8A8I/hne13w5VNv4D00GsBr214L9Yf2+RJY+0Bnh1EORqgHqhY2Opp
 hQ5ob2mTA2UAnbj8PHHHHc0YGvJ6Z5il8l0kCPAlC9E6eKix6HBTucFORoK/FrYs1HhFcsCIQ3I
 ggI03mFfPgMm9jEJhSCB+fr4wwSsghw0TYawtByn8W+1pO8oFb/u1SSYj0RpnP591yrB9rG68Xu
 o1EFmNBox9ECIIg==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

These two small squash-to patches would avoid issues recently seen on
the Netdev CI when this series has been sent upstream.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (2):
      Squash to "selftests: mptcp: join: check re-re-adding ID 0 endp"
      Squash to "selftests: mptcp: join: check re-re-adding ID 0 signal"

 tools/testing/selftests/net/mptcp/mptcp_join.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---
base-commit: a69c43e7eeeb5c959245dc2a20e6b41bc7afccb3
change-id: 20240827-selftests-mptcp-longer-tests-f3b30918add9

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

