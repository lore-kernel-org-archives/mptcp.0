Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713DD311C3F
	for <mptcp@lists.linux.dev>; Wed, 12 Nov 2025 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964722; cv=none; b=HU0XY8+2+z/Cqsq9PSA+/3FC74ctvItMAOokYnltxyRwP1ckGZj5ZAO3dDFBP1KhUEHoZq3dprmPVepxHLZXPiCsfWKkOsCydD+tDwCQO5jHfOS0KIAAvvfUP444U7eYGjRJ3v4Mh/38NsUaISNyVAOy8gHoS3eoCbT0ZlFPRFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964722; c=relaxed/simple;
	bh=fti7cZNya1a374oe6jjffz6LN7YFMKsrRH1/Osl0Cgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AU8HFwK5g5mukO30GKh0O6prfSlN0+73u0Zak5nQJO/fQx1WfhGXO4D7Rp7qfYhqpW8GjAcpLV29mqOS8g6jhAySePhziP0xju7i/rm/20mQAc1Z3ZH087OZC6JBoHgPq+cmWBDK6RmHnhVyU0137A/EojI+9xp0FdkyJ0FkA7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6fI1w9n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6fI1w9n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB06C4AF09;
	Wed, 12 Nov 2025 16:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762964722;
	bh=fti7cZNya1a374oe6jjffz6LN7YFMKsrRH1/Osl0Cgk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=f6fI1w9nBNXgUNX1Z5OjS//oa+/hhn9EcdYN6qHb9/n+Vqh+zVb/FZOCkh6dZPeoi
	 GNCIVFvoe3w55fbVSBLmZeOZf7enx1dsQx9BHLLMX/bqjd+8qS9F+Wn/+G5PzalJUY
	 6DWWS0lnzcMwHj8T7Ky+ijI0NfAIWkkhJurZsRYU0qYExppL3U0gfkbSLAZy+yBg11
	 ExKS7wcFkQZRPSjji/D+b2FbzwfwETRmWNV+XhDjSJQFok4guLpqusnYiNr3XQy/e0
	 6tndh3zcVKjnn9U5HiDmfJG3UvI6BMAvTjldpROqOH559Kqwt3lCDJ5XJ4sUKEOR7X
	 C84JAtvsl1WGg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 12 Nov 2025 17:24:45 +0100
Subject: [PATCH iproute-mptcp 2/6] man: mptcp: fix minor typos
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-laminar-v1-2-e23dbf584aa4@kernel.org>
References: <20251112-laminar-v1-0-e23dbf584aa4@kernel.org>
In-Reply-To: <20251112-laminar-v1-0-e23dbf584aa4@kernel.org>
To: MPTCP Linux <mptcp@lists.linux.dev>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1189; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=fti7cZNya1a374oe6jjffz6LN7YFMKsrRH1/Osl0Cgk=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGDJFtryMarA+XKRo5bh/97SjnZrXPz6/8D3E+UG18On5n
 qon3++421HKwiDGxSArpsgi3RaZP/N5FW+Jl58FzBxWJpAhDFycAjCRCW8YGeY8uaIhWf3ok/As
 3u7MnB3HK5bMzzufcOfqKtmQI95BtWqMDCcjP+z/5DtNVmv1HXuuGaqyQR4Tws71/H+0+pmMR5t
 oGxsA
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

- 'signaled' -> 'signalled'

- 'a implicit' -> 'an implicit'

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 man/man8/ip-mptcp.8 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man/man8/ip-mptcp.8 b/man/man8/ip-mptcp.8
index e4a55f6c..500dc671 100644
--- a/man/man8/ip-mptcp.8
+++ b/man/man8/ip-mptcp.8
@@ -156,7 +156,7 @@ ID.
 
 .TP
 .BR signal
-The endpoint will be announced/signaled to each peer via an MPTCP ADD_ADDR
+The endpoint will be announced/signalled to each peer via an MPTCP ADD_ADDR
 sub-option. Typically, a server would be responsible for this. Upon reception of
 an ADD_ADDR sub-option, the other peer, typically the client side, can try to
 create additional subflows, see
@@ -207,7 +207,7 @@ is then optional.
 .BR implicit
 In some scenarios, an MPTCP
 .BR subflow
-can use a local address mapped by a implicit endpoint created by the
+can use a local address mapped by an implicit endpoint created by the
 in-kernel path manager. Once set, the implicit flag cannot be removed, but
 other flags can be added to the endpoint. Implicit endpoints cannot be
 created from user-space.

-- 
2.51.0

