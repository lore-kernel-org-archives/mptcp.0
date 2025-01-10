Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14E3212FAA
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 16:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736527439; cv=none; b=bRfz7E8xoqQ6tfvohqHMRXRnbqLgkqc5vyDEhPI8JDj2TmAReDJ+YAzwv8w1SovJ7W9htMi7hsDOcgQ3NzkhlOeoEXJ5f0hjrIoCSLHR0VqtHN0cGFimxZqJlPG3SM0A3iyjbwtSgwkpFjLV+X+x8ifz9NQlcZKz48jSThoNLa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736527439; c=relaxed/simple;
	bh=NpW+pyS8FsAROT7HXwB400q95amIwBjtAJalRwZrEh0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=M+om3F1zLEljOde7Gp/iLEj4G8tjsQ9FY4l3MUh3s1wKN2nWJNP/Wsf5eWSmuryqGCVFxhVYiUrig3C05wiyNa0S15rIDlKKwbfRzO2qcE+JbeALA/p5g29dAuCYtstjpapoRIwEhqWoECXTODT8piN/t0DhjJNzMYNxVQJzHac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FTBNDD0n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTBNDD0n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736527436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Q0PhwkyrIQtqx8GM0T1htJvYwZjkGaUaQOh+J1W4m8=;
	b=FTBNDD0n7H6FBr4Ze7Zi79TVgbiykgugc8QzcQVmK9uIEubCo+Z6zYpFjSTsERsMJCyYGX
	3iNC5i1u8T9n5aYfPTbGq9ijuYur79A8zLySyL+o/VP/3gJf0K8aFYN2V2WlJjeJHblCTF
	/67q3Y9xRi3F4tQ9vRJ+Ltcm3Y0k1PE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-faDYxTTKMdK63gLaJf96Yw-1; Fri,
 10 Jan 2025 11:43:53 -0500
X-MC-Unique: faDYxTTKMdK63gLaJf96Yw-1
X-Mimecast-MFC-AGG-ID: faDYxTTKMdK63gLaJf96Yw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DBE5019560BB
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 16:43:51 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.199])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0DD8319560AD
	for <mptcp@lists.linux.dev>; Fri, 10 Jan 2025 16:43:50 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 1/3] mptcp: be sure to send ack when mptcp-level window re-opens
Date: Fri, 10 Jan 2025 17:43:41 +0100
Message-ID: <26d417180de679371f052baa0a8acdb7456f3aef.1736527092.git.pabeni@redhat.com>
In-Reply-To: <cover.1736527092.git.pabeni@redhat.com>
References: <cover.1736527092.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KgTAiF8C8W1qwqOq_GI3SNsKH9Ko1b3aVO_kZQIpqFw_1736527432
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

mptcp_cleanup_rbuf() is responsible to send acks when the user-space
reads enough data to update the receive windows significantly.

It tries hard to avoid acquiring the subflow sockets locks by checking
conditions similar to the ones implemented at the TCP level.

To avoid too much code duplication - the MPTCP protocol can't reuse the
TCP helpers as part of the relevant status is maintained into the msk
socket - and multiple costly window size computation, mptcp_cleanup_rbuf
uses a rough estimate for the most recently advertised window size:
the MPTCP receive free space, as recorded as at last-ack time.

Unfortunately the above does not allow mptcp_cleanup_rbuf() to detect
a zero to non-zero win change in some corner cases, skipping the
tcp_cleanup_rbuf call and leaving the peer stuck.

After commit ea66758c1795 ("tcp: allow MPTCP to update the announced
window"), MPTCP has actually cheap access to the announced window value.
Use it in mptcp_cleanup_rbuf() for a more accurate ack generation.

Fixes: e3859603ba13 ("mptcp: better msk receive window updates")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/options.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index a62bc874bf1e..123f3f297284 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -607,7 +607,6 @@ static bool mptcp_established_options_dss(struct sock *sk, struct sk_buff *skb,
 	}
 	opts->ext_copy.use_ack = 1;
 	opts->suboptions = OPTION_MPTCP_DSS;
-	WRITE_ONCE(msk->old_wspace, __mptcp_space((struct sock *)msk));
 
 	/* Add kind/length/subtype/flag overhead if mapping is not populated */
 	if (dss_size == 0)
@@ -1288,7 +1287,7 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 			}
 			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_RCVWNDCONFLICT);
 		}
-		return;
+		goto update_wspace;
 	}
 
 	if (rcv_wnd_new != rcv_wnd_old) {
@@ -1313,6 +1312,9 @@ static void mptcp_set_rwin(struct tcp_sock *tp, struct tcphdr *th)
 		th->window = htons(new_win);
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_RCVWNDSHARED);
 	}
+
+update_wspace:
+	WRITE_ONCE(msk->old_wspace, tp->rcv_wnd);
 }
 
 __sum16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)
-- 
2.47.1

