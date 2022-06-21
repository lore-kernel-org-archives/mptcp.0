Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D978E747B
	for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 17:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1655832215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zduH8uaZcAHo2NbiT8xUZB5EHlogKwIN6MiufFddsms=;
	b=Ar45sErCm0mn+Ku+Dcr85t3aQwHDuZIfldfrR7iPbJ8jelMz6IatIO0YzDIS/opnbIRC/u
	D+o2BWAQjtHTdxVr36wTrKi80n+ketpEVBPcmhgkqKVkLtelvBwHrw0B2nciuCh4Ev6rsD
	5054BAXC8ePef7Eo+d5ezByuq5JPM3E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-boRM78jENm-WFKEw_OFo_Q-1; Tue, 21 Jun 2022 13:23:34 -0400
X-MC-Unique: boRM78jENm-WFKEw_OFo_Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4723680029D
	for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 17:23:34 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.164])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9E6B140CFD0A
	for <mptcp@lists.linux.dev>; Tue, 21 Jun 2022 17:23:33 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v5 mptcp-net 1/6] mptcp: fix error mibs accounting
Date: Tue, 21 Jun 2022 19:23:12 +0200
Message-Id: <3a7b0695362fe7228484d2a2bc97fc26ca68f919.1655829222.git.pabeni@redhat.com>
In-Reply-To: <cover.1655829222.git.pabeni@redhat.com>
References: <cover.1655829222.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The current accounting for MP_FAIL and FASTCLOSE is not very
accurate: both can be increased even when the related option is
not really sent. Move the accounting into the correct place.

Fixes: eb7f33654dc1 ("mptcp: add the mibs for MP_FAIL")
Fixes: 1e75629cb964 ("mptcp: add the mibs for MP_FASTCLOSE")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c | 6 +++---
 net/mptcp/pm.c      | 1 -
 net/mptcp/subflow.c | 4 +---
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index be3b918a6d15..0bfa6662447c 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -765,6 +765,7 @@ static noinline bool mptcp_established_options_rst(struct sock *sk, struct sk_bu
 	opts->suboptions |= OPTION_MPTCP_RST;
 	opts->reset_transient = subflow->reset_transient;
 	opts->reset_reason = subflow->reset_reason;
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPRSTTX);
 
 	return true;
 }
@@ -788,6 +789,7 @@ static bool mptcp_established_options_fastclose(struct sock *sk,
 	opts->rcvr_key = msk->remote_key;
 
 	pr_debug("FASTCLOSE key=%llu", opts->rcvr_key);
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFASTCLOSETX);
 	return true;
 }
 
@@ -807,7 +809,7 @@ static bool mptcp_established_options_mp_fail(struct sock *sk,
 	*size = TCPOLEN_MPTCP_FAIL;
 	opts->suboptions |= OPTION_MPTCP_FAIL;
 	opts->fail_seq = subflow->map_seq;
-
+	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
 	pr_debug("MP_FAIL fail_seq=%llu", opts->fail_seq);
 
 	return true;
@@ -833,13 +835,11 @@ bool mptcp_established_options(struct sock *sk, struct sk_buff *skb,
 		    mptcp_established_options_mp_fail(sk, &opt_size, remaining, opts)) {
 			*size += opt_size;
 			remaining -= opt_size;
-			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFASTCLOSETX);
 		}
 		/* MP_RST can be used with MP_FASTCLOSE and MP_FAIL if there is room */
 		if (mptcp_established_options_rst(sk, skb, &opt_size, remaining, opts)) {
 			*size += opt_size;
 			remaining -= opt_size;
-			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPRSTTX);
 		}
 		return true;
 	}
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 2a57d95d5492..3c7f07bb124e 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -309,7 +309,6 @@ void mptcp_pm_mp_fail_received(struct sock *sk, u64 fail_seq)
 		pr_debug("send MP_FAIL response and infinite map");
 
 		subflow->send_mp_fail = 1;
-		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_MPFAILTX);
 		subflow->send_infinite_map = 1;
 	} else {
 		pr_debug("MP_FAIL response received");
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 5351d54e514a..57d2d8d933d0 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -958,10 +958,8 @@ static enum mapping_status validate_data_csum(struct sock *ssk, struct sk_buff *
 				 subflow->map_data_csum);
 	if (unlikely(csum)) {
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_DATACSUMERR);
-		if (subflow->mp_join || subflow->valid_csum_seen) {
+		if (subflow->mp_join || subflow->valid_csum_seen)
 			subflow->send_mp_fail = 1;
-			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_MPFAILTX);
-		}
 		return subflow->mp_join ? MAPPING_INVALID : MAPPING_DUMMY;
 	}
 
-- 
2.35.3

