Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAFF1DA5F
	for <mptcp@lists.linux.dev>; Mon,  6 May 2024 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715001344; cv=none; b=SGWOjUbivnTHW8GLta3RYqmcyVuDQ92FeEJZzX/EU2UsgDmZ1QpCg0slOCCFme8hutUqfTlCO+exd0carEtAbd4a2B8ZaBSg3jFZZlCVn5APpXcd04IXcUIkXNyt81cKoZtGxXy4ceZPWvMCs9czC0+PlUY7B5/u9mmnYnIXUsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715001344; c=relaxed/simple;
	bh=dfcJdaZ7y156NpFFDWjI3RcBhv8C8Ud/gfYRbyiOVCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jKMGBNAe90O/O1n9wLt8VuoHzBNHYP2YfQpQbNzGcuR68QCKLGXs0dkqxwW0J+mMMEMG6KKF3oHo6wQJIt9jX0oF7JqNgMFFW3NvOBHk0WhGAWbQX1kcu9yWNf4/v0YW9fkO3gOGUNn9RyJrnWHrFUK0d7s55RX4Wor6Md/Jero=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QC4/DkuK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QC4/DkuK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45962C116B1;
	Mon,  6 May 2024 13:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715001343;
	bh=dfcJdaZ7y156NpFFDWjI3RcBhv8C8Ud/gfYRbyiOVCE=;
	h=From:Date:Subject:To:Cc:From;
	b=QC4/DkuKnuTChIEwqpEcX8cAIR8C5suKS2v2H9i044hUSmlGwjInShcH00m0QUOH5
	 gy+k2WBvq/CT4hKAMlue/NhSnVZWKVfbw8wXUZVvzo874QVc5frS5BfSpZkFftxLOA
	 ILmILeN9ObfxjZABGk6yGkkQQww8pcdjQ4Uik5vH+9lX6r/vLfDkvybEO8f0zJTPEj
	 6vN4zbPPal/y8YH4KylkFIcAZhVY10FaG0tKiVkPO1snB6rehOWEEVsGGcPx+ypHtv
	 /EBKLS1To+n7GpJkNLZigyBeakpBhLGRmBfpFQw0/8MIRIYN0j7JLYxl8JWK9KdO0V
	 PHmqiYCsmL5Sg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 06 May 2024 15:15:32 +0200
Subject: [PATCH mptcp-next RFC] mptcp: socket option to check for fallback
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-getsockopt-tcp_is_mptcp-v1-1-4f044660f7c3@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPPXOGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUwMz3fTUkuL85Oz8ghLdkuSC+Mzi+NwCIEPX3Ng0LTXZyMzY0sJQCai
 7oCg1LbMCbHK0EkRJXmpFiUKQm7NSbG0tAPIMTZt5AAAA
To: mptcp@lists.linux.dev
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3752; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=dfcJdaZ7y156NpFFDWjI3RcBhv8C8Ud/gfYRbyiOVCE=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmONf+kqT4A0YN5kF2bpool9V19OdahZ2AYkZa8
 tNIlawrO6qJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZjjX/gAKCRD2t4JPQmmg
 c0lkD/9FRfO+qrHLUV0/Z+kBcLXgPsn/dDT2C/nau0KNrX/RG278WRWl8iczyazKARZIfVXL5e0
 qrrtWl/hxVyhjUkmFCxLGtSXsjfrdrq2xtI2EX1jdjCCXPeGhL4iz7/o50LrzL5bX64AGFVqKUz
 D0RpotWEDhETWel1SpGuPBiy1QBVy1rATBtApcoV8Tgir0Q7RMjECzpXcn5rMwNN9A1Lr6H9Yx8
 mX1ydPh/fs6tLc+wLiGziGDyPj5WNkqs9xB0z3dzqF+7u52kuVV2DFKISYjP6AQFK6qKIsSokRT
 EzPPg/pKSe03Vnbh1v7fzJ2AwHMcKijvaWPHsH+xlTgYQ0Li20wmpsXKFUCaIjT7K9Flyi9S5vY
 61E41kEfisftpoGhiqWoyCIbesvReQz0xxpfh3QjQ5ZXBa+6bAUp2RPaxZQ+vYSm5TFRLVTkOfE
 uAbcRtEuvbDKkADjpstaV1aL/hgGYGcEUPQyTGFNDVc25a8svTjw6fktTNWmy6JgieKAHqG6+4e
 jFmAfpusiF4Cj1kkMvE2YL7PF+GLqyYSBdZe4KNgWaOqXvg9WKJHUzeOd/QBgfU67/qqZoslMsP
 NeBEcgt8zBnUWZl97v8M7vePAq0lNey8CfqWP0W8EJbO1jd6Jm3DdZRn3B/RE8Yekwk7GTRHUOr
 iCHPm18sC053Wag==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A way for an application to know if the connection fell back to TCP is
to use getsockopt(MPTCP_INFO) and look for errors. The issue with this
technique is that the same errors -- EOPNOTSUPP (IPv4) and ENOPROTOOPT
(IPv6) -- are returned if there was a fallback, or if the kernel doesn't
support this socket option. The userspace then has to look at the kernel
version to know what to expect.

It is not clean, and it doesn't take into account older kernels where
the socket option has been backported. A cleaner way would be to expose
this info to the TCP socket level. In case of MPTCP socket where no
fallback happened, the socket options for the TCP level will be handled
in MPTCP code, in mptcp_getsockopt_sol_tcp(). If not, that will be in
TCP code, in do_tcp_getsockopt(). So one simply has to return 1, while
the other can return 0.

If the socket option is not supported, an error will be reported:
EOPNOTSUPP (95 - Operation not supported) for MPTCP sockets, ENOPROTOOPT
(92 - Protocol not available) for TCP sockets.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Notes:
  - This is linked to a discussion we had at the last meeting: having a
    cleaner way, not having to check the kernel version. But maybe it is
    fine to look at the kernel version? I mean: 5.16 is quite old now,
    maybe too late for that kind of patch?
  - During these discussions, I thought we had to also look at the
    mptcpi_flags field from the 'struct mptcp_info', and check if
    MPTCP_INFO_FLAG_FALLBACK was set: that's not needed, and this
    simplify a bit what needs to be done to check for a fallback:
    https://github.com/multipath-tcp/mptcp.dev/pull/6
  - Maybe it is enough to optimise the getsockopt(MPTCP_INFO) like this?
    https://lore.kernel.org/mptcp/20240418-mptcp-getsockopt-info-opti-v1-1-7138a96eb50c@kernel.org/

    Note: typically, it is not possible to do a getsockopt() with an
    optlen of size 0 from higher level lib (Python, Go, Rust, etc.).
    Maybe we would need a similar optimisation for optlen <= 4?
---
 include/uapi/linux/tcp.h | 2 ++
 net/ipv4/tcp.c           | 3 +++
 net/mptcp/sockopt.c      | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index c07e9f90c084..dbf896f3146c 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -135,6 +135,8 @@ enum {
 #define TCP_AO_GET_KEYS		41	/* List MKT(s) */
 #define TCP_AO_REPAIR		42	/* Get/Set SNEs and ISNs */
 
+#define TCP_IS_MPTCP		43	/* Is MPTCP being used? */
+
 #define TCP_REPAIR_ON		1
 #define TCP_REPAIR_OFF		0
 #define TCP_REPAIR_OFF_NO_WP	-1	/* Turn off without window probes */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 95ca73937a1c..39ee5a107544 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4363,6 +4363,9 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 
 		return err;
 	}
+	case TCP_IS_MPTCP:
+		val = 0;
+		break;
 	default:
 		return -ENOPROTOOPT;
 	}
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 2edaf1a16005..e50262b8942e 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1354,6 +1354,8 @@ static int mptcp_getsockopt_sol_tcp(struct mptcp_sock *msk, int optname,
 		return mptcp_put_int_option(msk, optval, optlen, msk->nodelay);
 	case TCP_NOTSENT_LOWAT:
 		return mptcp_put_int_option(msk, optval, optlen, msk->notsent_lowat);
+	case TCP_IS_MPTCP:
+		return mptcp_put_int_option(msk, optval, optlen, 1);
 	}
 	return -EOPNOTSUPP;
 }

---
base-commit: f16f6f211e692c812d4d5b24e8eff95188ecb62c
change-id: 20240506-getsockopt-tcp_is_mptcp-735fec263981

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>

