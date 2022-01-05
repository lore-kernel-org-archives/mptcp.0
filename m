Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82F32CA0
	for <mptcp@lists.linux.dev>; Wed,  5 Jan 2022 15:57:33 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id z29so163798479edl.7
        for <mptcp@lists.linux.dev>; Wed, 05 Jan 2022 07:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C7zGPZuJSopLvqGh8GZ6exc6w0u1cXbCYnQTOZawGT4=;
        b=nJWwdupjnx6V321BYzulHMsGmPXE06Wf+2HCj7aEt5Oo8g/nrzin1ouFHGaWGXro4c
         EmE3WDbbBHWWbnaUVIo3YV+daAfr55wft31DCKlYMKZEs35yUwrdkeyMrY199/b3j6jb
         bx3SqbZYWTn7i6sAD+uKMpqV17KnvbGzj+hbGtKzycq7iXdOY/UnwCSkyLllBsakquOM
         lUysmWQ6vHF8E2BtTPe3lytjjY7soqGCPCFbq0wBqyd03m/M4kYXiSnpAmZkx5hY76LK
         SCNL2cuSGEH4V94EgK3pQjnGxWGSeZJyq5cz4NtzSXAEbKSfvj+UtVM1A6v6dug9Qt9+
         cNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C7zGPZuJSopLvqGh8GZ6exc6w0u1cXbCYnQTOZawGT4=;
        b=fIM9ptHRFkFiE92dC9yKZsXnD6stmMxwHrC4z6a8ZBiIpxnfFaG/4maGEjfx1QTjT2
         qIaHiZVp7dh4XmOMWOluedT04Qay7DQWu2TNE/f/J5h8KnwLpOCLpGDOZxIUHlwEMppH
         uLZOq/8kad960q0h8MgwzOuw1yb26VwuEnzLByk1RlasqXcCaA+4TOXDaFd5kStpEz69
         EyirXxpbXya884OK0cCgwbUq5/q6u8V3toCxgDwt59Nelsx6omxgj+Mdh/hhNlRP2obF
         lWaMCDKnXqnRGcVl7taNE4hcSnkHbm9Ixtl4W0oZNvobni21qWKeSs9O/bUIOpwu132z
         CsvA==
X-Gm-Message-State: AOAM533SICSgvk0McUDP4ft+4EBL+Hpxr0vYtor2HEGP8UEPumHW6bEq
	ieeZ3/buzkYnQG+OaqINxNC8tCXXSW7zbFM40YA=
X-Google-Smtp-Source: ABdhPJzGSLe65CqX0f/q3RMFVatdI2NwNRswJ0tt41kX9NtwbH3UMcs3KiMlHTn5E5PdaI66YxnogQ==
X-Received: by 2002:a17:907:97ca:: with SMTP id js10mr42571051ejc.640.1641398251745;
        Wed, 05 Jan 2022 07:57:31 -0800 (PST)
Received: from tsr-vdi-mbaerts.nix.tessares.net (static.23.216.130.94.clients.your-server.de. [94.130.216.23])
        by smtp.gmail.com with ESMTPSA id c30sm12399684ejj.190.2022.01.05.07.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 07:57:31 -0800 (PST)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH mptcp-next v8 5/8] mptcp: clarify when options can be used
Date: Wed,  5 Jan 2022 16:56:59 +0100
Message-Id: <20220105155702.165123-6-matthieu.baerts@tessares.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220105155702.165123-1-matthieu.baerts@tessares.net>
References: <20220105155702.165123-1-matthieu.baerts@tessares.net>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFC8684 doesn't seem to clearly specify which MPTCP options can be used
together.

Some options are mutually exclusive -- e.g. MP_CAPABLE and MP_JOIN --,
some can be used together -- e.g. DSS + MP_PRIO --, some can but we
prefer not to -- e.g. DSS + ADD_ADDR -- and some have to be used
together at some points -- e.g. MP_FAIL and DSS.

We need to clarify this as a base before allowing other modifications.

For example, does it make sense to send a RM_ADDR with an MPC or MPJ?
This remains open for possible future discussions.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/options.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 2f94069808a4..8553b928c5bf 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1264,8 +1264,27 @@ static u16 mptcp_make_csum(const struct mptcp_ext *mpext)
 void mptcp_write_options(__be32 *ptr, const struct tcp_sock *tp,
 			 struct mptcp_out_options *opts)
 {
-	/* DSS, MPC, MPJ, ADD_ADDR, FASTCLOSE and FAIL are mutually exclusive,
-	 * see mptcp_established_options*()
+	/* Which options can be used together?
+	 *
+	 * X: mutually exclusive
+	 * O: often used together
+	 * C: can be used together in some cases
+	 * P: could be used together but we prefer not to (optimisations)
+	 *
+	 *  Opt: | MPC  | MPJ  | DSS  | ADD  |  RM  | PRIO | FAIL |  FC  |
+	 * ------|------|------|------|------|------|------|------|------|
+	 *  MPC  |------|------|------|------|------|------|------|------|
+	 *  MPJ  |  X   |------|------|------|------|------|------|------|
+	 *  DSS  |  X   |  X   |------|------|------|------|------|------|
+	 *  ADD  |  X   |  X   |  P   |------|------|------|------|------|
+	 *  RM   |  C   |  C   |  C   |  C   |------|------|------|------|
+	 *  PRIO |  X   |  C   |  C   |  C   |  C   |------|------|------|
+	 *  FAIL |  X   |  X   |  C   |  X   |  X   |  X   |------|------|
+	 *  FC   |  X   |  X   |  X   |  X   |  X   |  X   |  X   |------|
+	 *  RST  |  X   |  X   |  X   |  X   |  X   |  X   |  O   |  O   |
+	 * ------|------|------|------|------|------|------|------|------|
+	 *
+	 * The same applies in mptcp_established_options() function.
 	 */
 	if (likely(OPTION_MPTCP_DSS & opts->suboptions)) {
 		struct mptcp_ext *mpext = &opts->ext_copy;
-- 
2.33.1

