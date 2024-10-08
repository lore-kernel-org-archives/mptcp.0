Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5789420ADEA
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728408747; cv=none; b=lUu5DnxFmBnA4CiW/s1mh57I5fuV34w+6UFsrdqJ/EOLeFcL7INJl/BE7EhfASK9ZkjZB/avcNNqsW/I03JaAuhJj3l7NU1pwkf/mRGK2yT6J6jk4cu0bz2rhY1Ey+akmTImB+uLhtv95URm6ieC2db5uUTiQ+1VZx+C1Vk8838=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728408747; c=relaxed/simple;
	bh=kEX81wnVgfpvL97ttAXc3+HDiq5VfbxHHcg0ow9dcyU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OzAkgGWGh7uD2d5k/djn290cYKEl1oK5g0WHF/1PbXLym3HVFl86HFwcnMe/q1yOBMDiamfln0DePR5Eg/xrakwgENPKaJd5/ey2tFPuuh6XLOxmSOdVbcv7YcCg0N7Er2XfTtb23VWitg+BJGbUOyHoSQyhQkj16jLM02hJADk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZCmizZcy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCmizZcy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728408745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+RlX8vyw+i0RIcRrnrZudVuNUymipXRi1wFQ/92vHiA=;
	b=ZCmizZcyFhfOXYbW8aMAfnDvXLoN6LK4tlSbQJ5FH9JK26M3txmOhmKYfYkiV/BeVQj87D
	b+RVXDGCwJhMoSrn2hoZkEakezWG6nsi6PpsZ3DG7tCAdjzXqcwzfweOiLgYk7Hohia5gr
	jGQTLVA7skOzhpAwOa+M5UbxmnCmnn0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-klMFQt3TP5KE6Z53Ehn-ZA-1; Tue,
 08 Oct 2024 13:32:24 -0400
X-MC-Unique: klMFQt3TP5KE6Z53Ehn-ZA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FB0019560AA
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 17:32:23 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.45.225.139])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5334619560A3
	for <mptcp@lists.linux.dev>; Tue,  8 Oct 2024 17:32:22 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next] mptcp: use "middlebox interference" for MP_TCPRST in case map_valid is false
Date: Tue,  8 Oct 2024 19:31:00 +0200
Message-ID: <4b2cee91613e597a172b46bb0d9d3143053c52da.1728408247.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

RFC8684 suggests use of "Middlebox interference (code 0x06)" in case of
MPJ subflow that carries data at TCP level with no DSS sub-option. This
is generally the case when mpext is NULL or mpext->use_map is 0: use a
dedicated value of 'mapping_status' and use it before closing the socket
in subflow_check_data_avail().

Link: https://github.com/multipath-tcp/mptcp_net-next/issues/518#issuecomment-2389156143
Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 net/mptcp/subflow.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 61482f8b425b..77da7a33598a 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -960,7 +960,8 @@ enum mapping_status {
 	MAPPING_EMPTY,
 	MAPPING_DATA_FIN,
 	MAPPING_DUMMY,
-	MAPPING_BAD_CSUM
+	MAPPING_BAD_CSUM,
+	MAPPING_NODSS
 };
 
 static void dbg_bad_map(struct mptcp_subflow_context *subflow, u32 ssn)
@@ -1118,7 +1119,7 @@ static enum mapping_status get_mapping_status(struct sock *ssk,
 		}
 
 		if (!subflow->map_valid)
-			return MAPPING_INVALID;
+			return MAPPING_NODSS;
 
 		goto validate_seq;
 	}
@@ -1332,7 +1333,7 @@ static bool subflow_check_data_avail(struct sock *ssk)
 		status = get_mapping_status(ssk, msk);
 		trace_subflow_check_data_avail(status, skb_peek(&ssk->sk_receive_queue));
 		if (unlikely(status == MAPPING_INVALID || status == MAPPING_DUMMY ||
-			     status == MAPPING_BAD_CSUM))
+			     status == MAPPING_BAD_CSUM || status == MAPPING_NODSS))
 			goto fallback;
 
 		if (status != MAPPING_OK)
@@ -1385,7 +1386,13 @@ static bool subflow_check_data_avail(struct sock *ssk)
 			 * subflow_error_report() will introduce the appropriate barriers
 			 */
 			subflow->reset_transient = 0;
-			subflow->reset_reason = MPTCP_RST_EMPTCP;
+			switch (status) {
+			case MAPPING_NODSS:
+				subflow->reset_reason = MPTCP_RST_EMIDDLEBOX;
+				break;
+			default:
+				subflow->reset_reason = MPTCP_RST_EMPTCP;
+			}
 
 reset:
 			WRITE_ONCE(ssk->sk_err, EBADMSG);
-- 
2.46.0

