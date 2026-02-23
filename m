Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98352EDD45;
	Mon, 23 Feb 2026 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860683; cv=none; b=DfiJkp1vPDuCIB1jUvgl86p3Za9xB/fM8G/E156NjCpdWPJ/DgNh4DGH/i1wz3acPupZbFahgF9sqD86vWowGJpXF/M1uyRi/OuyypD5lFnp4+g6umJ/0bR1PEpqDNgLsq/FCJxFnO7fwSBPbSHvjoSp/VZeYRGCi8G/WP/riAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860683; c=relaxed/simple;
	bh=Dweq7oqtgV5vV7+Nk9lIGffgPM0V6SHAR+/STKKhKtU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L/Z5EwQkkMmU87IRk0swzhmOrO0fVp8K4ye1EhyrqXiGWqelSVPTNLfSwAgTnd9Ivq5b3Zan24dneFTSy5hHin3xh1Ise9el9PkKRygH2MQZZu1wD1TsnKWYRkuGEtX3vKqbTabSR5Cp57YZRqM4PPhlRL4PrDYDEY8wfNDxAEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lr1Bx+YA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lr1Bx+YA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC44C19423;
	Mon, 23 Feb 2026 15:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771860683;
	bh=Dweq7oqtgV5vV7+Nk9lIGffgPM0V6SHAR+/STKKhKtU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lr1Bx+YA/mLGpWK9i1+lMlKfCmdsGpaW6StW6iWN021zkTDatH6HLTnxBWOLIFf2i
	 eVEIicffRptiEyYY/pQk/dB/Ts5KfrrmcfW6bqkHRAq9zAhL1tgOkR4RdmXyTUTljq
	 /k901WJ/6qkFZO9c1vOvE7FWR171DS5ccb/Q+U+Z+I21m5N7O3T0FrpN4toJObCcin
	 UTT3CEufeb0zC4KR3UvAl/0wj5BYEn8wMoUraIXSLr0qXGR58ZNkU/JNM5a4dxw8GJ
	 kqL+Kba3X2Ka3yWU8Fe33sWS1wM6YuIDaK0wJwDDXXkcQKRRqyarkhnqMzhOGgn30A
	 M3SHglLyNvQIQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Mon, 23 Feb 2026 16:28:39 +0100
Subject: [PATCH iproute2-next v2 2/3] utils: timestamp: add JSON support
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-ipr-monitor-json-v2-2-f91fccccf917@kernel.org>
References: <20260223-ipr-monitor-json-v2-0-f91fccccf917@kernel.org>
In-Reply-To: <20260223-ipr-monitor-json-v2-0-f91fccccf917@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1652; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=Dweq7oqtgV5vV7+Nk9lIGffgPM0V6SHAR+/STKKhKtU=;
 b=kA0DAAoWfCLwwvNHCpcByyZiAGmccsejWdm87T3yB8ZgmVTPJrzXj9IvS2d+K3zeRMoG7YWJj
 4h1BAAWCgAdFiEEG4ZZb5nneg10Sk44fCLwwvNHCpcFAmmccscACgkQfCLwwvNHCperpgD9E8nf
 jeUOoIdIzMc6YljYLJlp9TYXo7znMstVuO6X7kIBAMZYD96Ijewz3OqwZnDOgEYyIlf2WcRQNvP
 UJLcBUQIF
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Supporting JSON is easy with the helpers. The biggest modification is to
extract the end value. Different keys are used depending on the short or
long timestamp option being used, to ease the parsing.

No behavioural changes intended for the moment, this is a preparation for a
future usage of print_timestamp() within a JSON context.

Like in other helpers supporting JSON, the output stream 'fp' is ignored,
which is fine, because it is always set to 'stdout'.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
v2: ignore 'fp' which is always set to 'stdout' (Stephen)
---
 lib/utils.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/utils.c b/lib/utils.c
index 13e8c098..1215fe31 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -1277,21 +1277,23 @@ int print_timestamp(FILE *fp)
 {
 	struct timeval tv;
 	struct tm *tm;
+	char ts[40];
 
 	gettimeofday(&tv, NULL);
 	tm = localtime(&tv.tv_sec);
 
 	if (timestamp_short) {
-		char tshort[40];
+		size_t len;
 
-		strftime(tshort, sizeof(tshort), "%Y-%m-%dT%H:%M:%S", tm);
-		fprintf(fp, "[%s.%06ld] ", tshort, tv.tv_usec);
+		len = strftime(ts, sizeof(ts), "%Y-%m-%dT%H:%M:%S", tm);
+		snprintf(ts + len, sizeof(ts) - len, ".%06ld", tv.tv_usec);
+		print_string(PRINT_ANY, "timestamp_short", "[%s] ", ts);
 	} else {
 		char *tstr = asctime(tm);
 
 		tstr[strlen(tstr)-1] = 0;
-		fprintf(fp, "Timestamp: %s %ld usec\n",
-			tstr, tv.tv_usec);
+		snprintf(ts, sizeof(ts), "%s %ld usec", tstr, tv.tv_usec);
+		print_string(PRINT_ANY, "timestamp", "Timestamp: %s\n", ts);
 	}
 
 	return 0;

-- 
2.51.0

