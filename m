Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE462FB7
	for <mptcp@lists.linux.dev>; Thu, 24 Jun 2021 12:02:55 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id h4so4540853pgp.5
        for <mptcp@lists.linux.dev>; Thu, 24 Jun 2021 05:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RW3L3q0q+03j/0yjJpTt4Uv4Tn1MfFFntAArFsMTcIs=;
        b=ovu4/EV4815wS+zjZD8cSsdHo4fwWYkIFIkj+hhfY7kcMkdSQqvCwUhj7rLcNIUzCv
         OIe9wLFU27+rGWGBa4r+I2NMt8snAEBsFsl0q8ELT4KEc+MmUFWkKPDUmi+Mia7h3P9+
         DcIsKNEkoRX86yCvDIV7HVAildKz8NcCmWR98P5ys1uUX4O2VdMWwv6JrGeiHTzyeo07
         z8/o56piJCdHSg8c5OsroNQp0JaAkNoQ0eCgO6VKh7xpTBnJ5Hx4YM4N5dIsYA5K7yGL
         xFneH2gB6WGX2MO/8nxMaZXgEGcJz8tJmqZlnqMT8wohFRiPaLWvvsnUPH4DlGglmQna
         vbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RW3L3q0q+03j/0yjJpTt4Uv4Tn1MfFFntAArFsMTcIs=;
        b=bwAoFGHij5E+LvJPt/e+Xf30zmm4ZI4GPkDAasG8cgz+O8l5v4So9o2OW5KcTcq0Ef
         5TWKytaHF48MnW8zXLZ9TcZTGcXbuspvKuJvpZUrgIROlh8IyDax4A0+Blg8xnELPh4B
         6pGijLUazDJ7rNcsP3RFwK+M/doA6Gs8AXu1fkW6t7RBFpPpQqcCAhxgDdrjlts1V+MF
         44bY5jnnX8Xr3Lkf4qLylrUID8aYcvwdKojuYpm4vOZKtCkKI5QcKuFokUfOM1b1uHSk
         q6Bd8LhD5uKxOOAGa3LUkX0tP1GpRO1kDNUcOlQrTUWMrs7EcVjumFEBcL9Vi4yuqLAy
         k4ug==
X-Gm-Message-State: AOAM530vHA2LpNamSmDZWki6aoEsEPV+o8ye/5djDvuXbTg1F3ncNEdt
	OMKhmGMKpUVedOYGwRhLQBDkQMeQAA1XWw==
X-Google-Smtp-Source: ABdhPJzAjFAhlc9Q9tOb613OA5QQSeeUK9YauR5Ty7NpW1epDjRpJtiDUt3yDkcm9qmHwouY314uig==
X-Received: by 2002:a63:461d:: with SMTP id t29mr4465657pga.442.1624536175334;
        Thu, 24 Jun 2021 05:02:55 -0700 (PDT)
Received: from MiBook.. ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id h24sm2863824pfn.180.2021.06.24.05.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 05:02:55 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <geliangtang@gmail.com>
Subject: [MPTCP][PATCH v2 mptcp-next 3/5] mptcp: send out MP_FAIL when data checksum fail
Date: Thu, 24 Jun 2021 20:02:44 +0800
Message-Id: <92e3fde76e7efe8c6a5efaae133b21ad637c47e8.1624535762.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <1755dbb007864483285783ca4c9a1b25923ab99a.1624535761.git.geliangtang@gmail.com>
References: <cover.1624535761.git.geliangtang@gmail.com> <a3f24604a58ac18c29284160503bd8fd19169334.1624535761.git.geliangtang@gmail.com> <1755dbb007864483285783ca4c9a1b25923ab99a.1624535761.git.geliangtang@gmail.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a bad checksum is detected, send out the MP_FAIL suboption.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 net/mptcp/subflow.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 0b5d4a3eadcd..13e53a6bd3a1 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -913,6 +913,7 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
 	csum = csum_partial(&header, sizeof(header), subflow->map_data_csum);
 	if (unlikely(csum_fold(csum))) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
+		subflow->send_mp_fail = 1;
 		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
 	}
 
@@ -1159,6 +1160,20 @@ static bool subflow_check_data_avail(struct sock *ssk)
 	return false;
 
 fallback:
+	if (subflow->send_mp_fail) {
+		if (mptcp_has_another_subflow_established(ssk)) {
+			mptcp_subflow_reset(ssk);
+			while ((skb = skb_peek(&ssk->sk_receive_queue)))
+				sk_eat_skb(ssk, skb);
+		} else {
+			pr_fallback(msk);
+			__mptcp_do_fallback(msk);
+		}
+
+		WRITE_ONCE(subflow->data_avail, 0);
+		return true;
+	}
+
 	/* RFC 8684 section 3.7. */
 	if (subflow->mp_join || subflow->fully_established) {
 		/* fatal protocol error, close the socket.
-- 
2.31.1

