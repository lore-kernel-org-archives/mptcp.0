Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF47F449990
	for <mptcp@lists.linux.dev>; Thu,  9 Jul 2026 19:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783624785; cv=none; b=edob0KVGEngNM+KIfbBzgdyNacUXRNyyMn8zrJp7RlqrSIaWB5lI8GVYwNY3/rM/pWjVTV8JeYkFCehJjOe85Ln8UQlncleSEzGyfiacQx88A3n0GvM92fs8K7VBz4nloYqdHHIAvpbQuI/59INn6NvJzQV9F6Ph5E1cQDInZ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783624785; c=relaxed/simple;
	bh=ag2iaJNRSatXfZcIQOXwJLWZ7MP77+wFc5guU6LKKE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a0CnNuJtWkqV6WXdRQyW7gcx3tmK5riFarcsr64tj1xZUh/1eNMg8AykkKSOCPzX9lBxzAdygWFgtPVx8RFOx4DmFpKsuaOuhUks9XMBs3UmMTnAVa+b8WNVWI1wl5nYnSRBFiRko2Rum4/1E9NjpgGhC1IIDLeyB08qoQkroEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLKcMp9v; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLKcMp9v"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8ff88549786so2112226d6.3
        for <mptcp@lists.linux.dev>; Thu, 09 Jul 2026 12:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783624783; x=1784229583; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8lTAkLkaFfueQ/1V07Pbb9gud8KYPki4tliZP1BPO3s=;
        b=aLKcMp9vMyP9j8tktePDqxufomPt3qg47lNtVnwTI9WXhFDy+fKt2cK9iIUG1FF2DU
         xBvgrgL8O6OgB+DyQrL5WOccaQWDW4HyaedUtCZmpry9D0DQj5DlvkywYTinAfZvqdBd
         jvWNfs2ilVxr/JpUWaAyOOb0w2YnKUefzzQP1BE4JwkwyC/RvkrJG4YVun8MA40+PxfX
         07t7DyCiVhGYniOCZySWAt1EfaPL3p0Ap5OESpgZfMOiY4xAH8Xp00MYAdmZdNK+YdIk
         /shA9SmepOyNmedtw/uGMswSK5QwYUG/fnWFx3I4Wf3jhE5TabpH5xPLzeUxNL6nzW5u
         ZI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783624783; x=1784229583;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8lTAkLkaFfueQ/1V07Pbb9gud8KYPki4tliZP1BPO3s=;
        b=kC8jaMMJB73tKqZlXj5G2PDPYBaSlxSqaxSL6wYbRkhzCmyd/z4XX0DGqxox2q10PI
         TseoImjSjrEqn69FpTpGEB3FLCj7L2DiN8ylb48aFR3+9capGJ+upuHXo34rSnawBpGI
         lFfC0XA8mY8W1Qe48KvMGvQS1tKNdKGboKpIX3xV7D+wQCJMnL6sJR0UwLB1nGBM7JCa
         LGtSJR4POxpWomUn7JUQfPGIQ4wNffwqtjzs/R+FuwVSnNpdLfWcFGdRPUiRPhzQogjI
         2lXjMdESZL3WcjeEtC2pqGyiphyW/wjLnmBmqefPEmkFR/MsqQpFFSnbJze5a+zJoMH2
         Bndg==
X-Forwarded-Encrypted: i=1; AHgh+Rq2zzVQWq/DpV7hctLunaOJi9fPs8DdMsd3dKwv3PO/03Lbsx6/rXcdXkRCOaNLD8O9Pf35LA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9+GJ9+ZvcShFPUO9US/qFo02O9N6ZayA/Ynmu70spI2+5EB6p
	v+XE0+tlfl65r6VR2NFFGrTC1IlTVYVA9YyjdnviUvZfqaIloirC14Rk
X-Gm-Gg: AfdE7clkVU4tpKRKPgoXUPUf6H503vhMoMBp0+PnJEaczPPLRn84bfeLJoILhiQiwir
	Yy22HL+9nNvH9dpOzlUo2jgIdhkOCtSouGxbLuRTE1kpM9G+OlUmCzsk1x+mjOVaygPmIw2ma3Q
	b9kgtVKvnxd5Ub1d5mTDp1g1A6lHOUQ0Vx0elkOrGLZ235qRt4Zm50TUTrW+LFpFJKVEHQek4pd
	fyqYyzT8bE5UqF1NC/FIzH26qW3sVBcRnN/J9/W8cBP4R/UHt28BMHP9TcGC2aoS3Eokm0q1ryP
	OBC7q5PEM179p9h6K7ClzTu6tYwza/l0AY7SQhvnGYhy8UpNRruxbq/YG2ipSdBIyXK/gRN5SC+
	eRMNMoilhl6Mb8wzp/yuVMMtwOWPuKmvuK43IKLj7/jv0XCO31cYn1ZNnQBL7YMt/Rrg5wiYp/0
	UFE6wdBpNL7uY7QlmROzvrWMDMBarCorf7P7mFnEZXusdhQXihnoijBbvovT4doW+h5RPmiLAs3
	FOgOm5OrdyKuWVqHD4ykviBpSBNvZTE
X-Received: by 2002:a05:6214:c87:b0:8fe:49d6:fb76 with SMTP id 6a1803df08f44-8fec3810ff7mr93576996d6.57.1783624782634;
        Thu, 09 Jul 2026 12:19:42 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd87c8d4csm25507836d6.44.2026.07.09.12.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 12:19:42 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Gang Yan <gang.yan@linux.dev>,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] mptcp: only set DATA_FIN when a mapping is present
Date: Thu,  9 Jul 2026 15:19:25 -0400
Message-ID: <20260709191925.2811195-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

mptcp_get_options() clears only the status group of struct
mptcp_options_received; data_seq, subflow_seq and data_len are filled in
by mptcp_parse_option() exclusively inside the DSS mapping block, which
runs only when the DSS M (mapping present) bit is set.

A peer can send a DSS option with the DATA_FIN flag set but the mapping
bit clear. The parser then records mp_opt->data_fin while leaving
data_len and data_seq uninitialized. For a zero-length segment
mptcp_incoming_options() evaluates

	if (mp_opt.data_fin && mp_opt.data_len == 1 &&
	    mptcp_update_rcv_data_fin(msk, mp_opt.data_seq, mp_opt.dsn64))

which reads the uninitialized data_len and data_seq; KMSAN reports an
uninit-value in mptcp_incoming_options(). The stale data_seq can also be
fed into the receive-side DATA_FIN sequence tracking.

Record the DATA_FIN flag only when the DSS option carries a mapping, so
data_fin is never set without data_seq and data_len also being present.
data_fin is part of the status group that mptcp_get_options() clears up
front, so on the no-map path it stays zero and the zero-length DATA_FIN
branch is simply skipped. A DATA_FIN is always transmitted together with
a mapping (mptcp_write_data_fin() sets use_map along with data_seq and
data_len), so legitimate DATA_FIN handling is unaffected.

Move the pr_debug() that logs the parsed DSS flags below the mapping
block, so it reports the final data_fin value instead of the stale one
it would otherwise print before the assignment.

Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machine")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v3:
 - Move the pr_debug() DSS flag log below the mapping block so it prints
   the final data_fin value (Gang Yan).  data_fin is now assigned only
   inside the use_map block, so logging it earlier would report a stale
   value.  No functional change to the fix.
v2: adopt Paolo Abeni's suggested approach - do not set mp_opt->data_fin
    at all unless a mapping is present, rather than gating the consumer in
    mptcp_incoming_options() (v1).  data_fin then defaults to the value
    mptcp_get_options() already clears it to (0) on the no-map path, so
    the uninitialized data_len/data_seq are never read.

Link to v1: https://lore.kernel.org/all/20260617215725.1116295-1-michael.bommarito@gmail.com/
Link to v2: https://lore.kernel.org/all/20260707171730.2679013-1-michael.bommarito@gmail.com/

 net/mptcp/options.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index dff3fd5d3b559..1b74ca5b6a595 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -157,17 +157,11 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		ptr++;
 
 		flags = (*ptr++) & MPTCP_DSS_FLAG_MASK;
-		mp_opt->data_fin = (flags & MPTCP_DSS_DATA_FIN) != 0;
 		mp_opt->dsn64 = (flags & MPTCP_DSS_DSN64) != 0;
 		mp_opt->use_map = (flags & MPTCP_DSS_HAS_MAP) != 0;
 		mp_opt->ack64 = (flags & MPTCP_DSS_ACK64) != 0;
 		mp_opt->use_ack = (flags & MPTCP_DSS_HAS_ACK);
 
-		pr_debug("data_fin=%d dsn64=%d use_map=%d ack64=%d use_ack=%d\n",
-			 mp_opt->data_fin, mp_opt->dsn64,
-			 mp_opt->use_map, mp_opt->ack64,
-			 mp_opt->use_ack);
-
 		expected_opsize = TCPOLEN_MPTCP_DSS_BASE;
 
 		if (mp_opt->use_ack) {
@@ -178,12 +172,18 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 		}
 
 		if (mp_opt->use_map) {
+			mp_opt->data_fin = (flags & MPTCP_DSS_DATA_FIN) != 0;
 			if (mp_opt->dsn64)
 				expected_opsize += TCPOLEN_MPTCP_DSS_MAP64;
 			else
 				expected_opsize += TCPOLEN_MPTCP_DSS_MAP32;
 		}
 
+		pr_debug("data_fin=%d dsn64=%d use_map=%d ack64=%d use_ack=%d\n",
+			 mp_opt->data_fin, mp_opt->dsn64,
+			 mp_opt->use_map, mp_opt->ack64,
+			 mp_opt->use_ack);
+
 		/* Always parse any csum presence combination, we will enforce
 		 * RFC 8684 Section 3.3.0 checks later in subflow_data_ready
 		 */
-- 
2.53.0

