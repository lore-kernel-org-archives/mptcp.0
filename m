Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DA414F121
	for <mptcp@lists.linux.dev>; Fri,  3 May 2024 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764843; cv=none; b=VaRG0YlLoBCBVLatKWOPlaZSs/6ygG/9Dl/bqZhqGN4dkdprPzTpyZEY9/aVMU90CnFj7WivczdL44e6lDhw+XRGpT4sB0Fl+K0D0LYnI0oNffgGl053nRGjIs5PozumFwn6C5blH3oDRKeSVCfsn6SMWpD95K3TKdj8iCxE5qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764843; c=relaxed/simple;
	bh=QHrzXoKBGbSszZUhAyIi5ily8po8cRed6Cp/+9bpMA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pwGsg1d8JfnyhR4zWeNO8ThkoJGUYmA2cJ6LgXICc4sAyDMJvYRc71jyhQzxvBqF/unN/57NldhOYqwq+jeGTSM3/Wb0DPlqXbWEytZcpsXPhf5QcK8L/Ngv+utOmOMkCZ37IFj+wSFyQLQdTG4AR96L02LNc9hKPsWseR0M2BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=So2HzOoF; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="So2HzOoF"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34da04e44a2so13734f8f.1
        for <mptcp@lists.linux.dev>; Fri, 03 May 2024 12:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714764840; x=1715369640; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=thr8xqOZrByCL9GPaDBY1dMYAk6XNElAOErwG9Vli34=;
        b=So2HzOoFraKqEePhD835WueVR6HRZ5gLJN7yObnK7xTXthWpR01HY3kgJHWR6Ofxmm
         vXJLXMRfisprR/oOoUtgIapoMBkOJ7befttkqT+aPOPCcwGnsN07sRI/j+oiUYcHQg/a
         b1uW66CG7juh2+IPC2iKjFUaGM7x5UVST/HWmYfW5FwZcaydN/5GWkF+qdrSlFwmy28d
         HiBGvfHKtWh15ATahCDTDVOJJ3+RBFBVcbC3C8VbLeK3zzPbBGA8YXOusbTnocUnXKzF
         auSAclaxENSyMkVjJcMieQnfdawBAALK32VLy2+FHBSAwoqbza8GrZBOuRYpG03oOFl4
         SCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714764840; x=1715369640;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=thr8xqOZrByCL9GPaDBY1dMYAk6XNElAOErwG9Vli34=;
        b=xF8VD+VwEEVgyjxIxXkU8HZRGVsvgVQ6DbVknUbWsCYs5JlAbjkFbjzaKsC5ov1hw4
         uyo92+iKAf3fCo1h1A5jWXsH4AfU1uW97+p0lvfsRTa3EJ+hsgppIJtYRmrmLGTs4ADI
         IiILkyGbA9KTOpvq93XAA99iPU+dTVPlmMqMdV1F0atIFG3bByVq2/rdMF8U0TbhgkZ9
         t3SixEvIvYWFH11nz/Q4W+KfenH35Qs8fqDLNtljSa7b9Bk5V2dticheqktukM6Yieys
         07Dn6Ryazxr+SHcTd+ThInDNTjOH5lNDC1TRLwPQ/1SuzEVNbiZf0awsPDTpnHrXtAmh
         YZHA==
X-Gm-Message-State: AOJu0Yxqxsg12OJuzzjYxurUD1pSxLyM0ju1gDwISlKUZkUf0l9od7Nn
	8S60Qv9/oY9Zgw3DshZadnkLDOyawkyPtoL4onEQz37e5jR5CNXlg63HR7Lt
X-Google-Smtp-Source: AGHT+IEgGr2BUMVUumu24GeWsV047D2NzdiOf6BT+4ek5K6jralhjQHtxUYZMYO3HaAM8nZAlvf5RA==
X-Received: by 2002:a5d:6c62:0:b0:34c:e0d6:c260 with SMTP id r2-20020a5d6c62000000b0034ce0d6c260mr3205553wrz.47.1714764840180;
        Fri, 03 May 2024 12:34:00 -0700 (PDT)
Received: from [127.0.1.1] ([2001:41d0:700:80a3::])
        by smtp.gmail.com with ESMTPSA id y10-20020a170906470a00b00a4e24d259edsm2021469ejq.167.2024.05.03.12.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 12:33:59 -0700 (PDT)
From: Gregory Detal <gregory.detal@gmail.com>
Date: Fri, 03 May 2024 19:33:25 +0000
Subject: [PATCH mptcp-next] Squash to "mptcp: add bpf_mptcp_sched_ops" --
 fix bpf access
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240503-bpf_fix_access-v1-1-5a714318ea64@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAQ8NWYC/x2MQQqAIBAAvxJ7TrDUiL4SEbZttYdM3Igg+nvSc
 RhmHhBKTAJd8UCii4WPkKEqC8DNh5UUz5mh1rXVThs1xWVc+B49Iokobxo9tS1WzljIUUyU7T/
 sYY8nRhXoPmF43w8MX/tmbAAAAA==
To: MPTCP Upstream <mptcp@lists.linux.dev>
Cc: Gregory Detal <gregory.detal@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714764839; l=2414;
 i=gregory.detal@gmail.com; s=20240430; h=from:subject:message-id;
 bh=QHrzXoKBGbSszZUhAyIi5ily8po8cRed6Cp/+9bpMA4=;
 b=7pzFZH8w6x4JMYMrzBGJQumF4cPxtOUC0+7xEgFy44PoiR/iHN2mIFRBcdh0w0vXuHzR22bVB
 SYiQxPJvjOeBVPMWGoscht2DWVyp8qRj1Eb5E8Xs4Z3opFPJ8hMCwxV
X-Developer-Key: i=gregory.detal@gmail.com; a=ed25519;
 pk=TziJDop3YEG3Ywr6io7U9Iy2jaAY3l0hTh8KdwDKXQM=

The current behavior allows to write to mptcp_sock at offset that is
defined in mptcp_subflow_context and vice versa.

This fixes this by splitting the checks for each struct type.

Signed-off-by: Gregory Detal <gregory.detal@gmail.com>
---
 net/mptcp/bpf.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/net/mptcp/bpf.c b/net/mptcp/bpf.c
index 208e5d3f066f..57c47bb430b1 100644
--- a/net/mptcp/bpf.c
+++ b/net/mptcp/bpf.c
@@ -47,24 +47,32 @@ static int bpf_mptcp_sched_btf_struct_access(struct bpf_verifier_log *log,
 	size_t end;
 
 	t = btf_type_by_id(reg->btf, reg->btf_id);
-	if (t != mptcp_sock_type && t != mptcp_subflow_type) {
-		bpf_log(log, "only access to mptcp sock or subflow is supported\n");
-		return -EACCES;
-	}
 
-	switch (off) {
-	case offsetof(struct mptcp_sock, snd_burst):
-		end = offsetofend(struct mptcp_sock, snd_burst);
-		break;
-	case offsetof(struct mptcp_subflow_context, scheduled):
-		end = offsetofend(struct mptcp_subflow_context, scheduled);
-		break;
-	case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
-		end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
-		break;
-	default:
-		bpf_log(log, "no write support to %s at off %d\n",
-			t == mptcp_sock_type ? "mptcp_sock" : "mptcp_subflow_context", off);
+	if (t == mptcp_sock_type) {
+		switch (off) {
+		case offsetof(struct mptcp_sock, snd_burst):
+			end = offsetofend(struct mptcp_sock, snd_burst);
+			break;
+		default:
+			bpf_log(log, "no write support to mptcp_sock at off %d\n",
+				off);
+			return -EACCES;
+		}
+	} else if (t == mptcp_subflow_type) {
+		switch (off) {
+		case offsetof(struct mptcp_subflow_context, scheduled):
+			end = offsetofend(struct mptcp_subflow_context, scheduled);
+			break;
+		case offsetof(struct mptcp_subflow_context, avg_pacing_rate):
+			end = offsetofend(struct mptcp_subflow_context, avg_pacing_rate);
+			break;
+		default:
+			bpf_log(log, "no write support to mptcp_subflow_context at off %d\n",
+				off);
+			return -EACCES;
+		}
+	} else {
+		bpf_log(log, "only access to mptcp sock or subflow is supported\n");
 		return -EACCES;
 	}
 

---
base-commit: 56030f9d3812071365435354c0eb5ffb3504e58a
change-id: 20240503-bpf_fix_access-a360b88c1534

Best regards,
-- 
Gregory Detal <gregory.detal@gmail.com>

