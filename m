Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BDC1F0E26
	for <mptcp@lists.linux.dev>; Fri,  3 Oct 2025 14:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759500123; cv=none; b=L/+otoHHUm/+fF8qQAadlUB71vVL4lFE9pjxc0upYTzqHEBOWUsENx18Vy5LFENydK7ZL15GUaoUTjl19tYB2woe9sDKso9MSaJz25Ab3fSoKV1LBKoP5B5FrRY9PFFdMbufgZbzGXyw8oPHkqImRL3OBKKcDjWsESi26yE8cnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759500123; c=relaxed/simple;
	bh=SCQ8Xb7reEqXG2dGDHPdixMk+cLwWuEn4yVA3U8cm9w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=l1EJIJcodUvu1h+EovUoXiTPJ4swfBmCwKfnpbwcSq0tUmQOafKNeNriHkenSGb5513MFn8XhS8P3xYSkZKFLN2CI9QaZrEPDhRZkbrfQ4/CeEh52EubCx5/fwkiPDmgwFMPyP/9m7r/st2MHAc9FViFRr2tqLVWHNpP4jrcHN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NZOM3ctK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZOM3ctK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759500119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4FZinxvqb9PDtGlLc5BpxA59lUldusP+j0A1kGvkpG8=;
	b=NZOM3ctKD0O4GrDuz13vfgcTie3kxG/lC2YOVvPV58ay0vqDiqeXyGElxtySo4eoHUxw1K
	pDlcg1Br4K7lVCosZ4hGZf5PesxDDNcKe57ZLndlup/il/qUrOdQ6mkwGuA5TRA506MIkE
	ssEZ4yZP+2vUaQ7/pdHH59QqXMSD4Q4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-i6lAtcqKNxeIssjBwSYz4Q-1; Fri,
 03 Oct 2025 10:01:57 -0400
X-MC-Unique: i6lAtcqKNxeIssjBwSYz4Q-1
X-Mimecast-MFC-AGG-ID: i6lAtcqKNxeIssjBwSYz4Q_1759500116
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA3771800291
	for <mptcp@lists.linux.dev>; Fri,  3 Oct 2025 14:01:56 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.53])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E9E9618004D8
	for <mptcp@lists.linux.dev>; Fri,  3 Oct 2025 14:01:55 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH v4 mptcp-next 2/8] mptcp: cleanup fallback data fin reception
Date: Fri,  3 Oct 2025 16:01:40 +0200
Message-ID: <82ab62f0ec0c02bbb90bd119c0d4021ce6165ce0.1759499837.git.pabeni@redhat.com>
In-Reply-To: <cover.1759499837.git.pabeni@redhat.com>
References: <cover.1759499837.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GUmCsbkoUTuBYoOV7xF0LSawulOvGZviAFi8fK2f6Dc_1759500116
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

MPTCP currently generate a dummy data_fin for fallback socket
when the fallback subflow has completed data reception using
the current ack_seq.

We are going to introduce backlog usage for the msk soon, even
for fallback sockets: the ack_seq value will not match the most recent
sequence number seen by the fallback subflow socket, as it will ignore
data_seq sitting in the backlog.

Instead use the last map sequence number to set the data_fin,
as fallback (dummy) map sequences are always in sequence.

Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v2 -> v3:
  - keep the close check in subflow_sched_work_if_closed, fix
    CI failures
---
 net/mptcp/subflow.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e8325890a3223..b9455c04e8a46 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1285,6 +1285,7 @@ static bool subflow_is_done(const struct sock *sk)
 /* sched mptcp worker for subflow cleanup if no more data is pending */
 static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ssk)
 {
+	const struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = (struct sock *)msk;
 
 	if (likely(ssk->sk_state != TCP_CLOSE &&
@@ -1303,7 +1304,8 @@ static void subflow_sched_work_if_closed(struct mptcp_sock *msk, struct sock *ss
 	 */
 	if (__mptcp_check_fallback(msk) && subflow_is_done(ssk) &&
 	    msk->first == ssk &&
-	    mptcp_update_rcv_data_fin(msk, READ_ONCE(msk->ack_seq), true))
+	    mptcp_update_rcv_data_fin(msk, subflow->map_seq +
+				      subflow->map_data_len, true))
 		mptcp_schedule_work(sk);
 }
 
-- 
2.51.0

