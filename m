Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA44C811E4
	for <mptcp@lists.linux.dev>; Wed, 24 Jan 2024 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706132217; cv=none; b=av/o0KNWePefqprt4za/QhHXdOtpcCdGD2ni2+wpHXEm8CGEomlG/TmCZ3UalVASRloien6aw7gs0jFtmrFPUxyMsPjNHSuyyQ2zD6nNtgRzJrmYpIs8OPgxgV6Ql/65V+LcyZpcL1EeH735o9E4N3hFN0z3LQRfNx7qpvOJuY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706132217; c=relaxed/simple;
	bh=cpkUMNCixjYuP8U8bjfCrJkCjl+7BvNRQl66qLhf+L4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CJINSPdWlTsLm8pS8f8YQBEEvuIP07K1fdZHW8ZjHELUwIm7RaDopC7+C/TKuCANTL5EDYHgWktZRZ5kww/MdZNv+q2iyuCvVxd3JCzWgvaFfe9P+nKkHNowxps+w0gcDxMbXC8dEoKQPULpre0cv6NiF3VvgSZ2N+q3a5bvjRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ajyeX1Ux; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajyeX1Ux"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706132214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fjxcHb69xyhYSiWyhhPL+8HDEtm3imBIJfJQfe+osTM=;
	b=ajyeX1Ux3vr4Ug4FmNooLLAOX2oJmXE8cmUrrOd1/tvzP+sLAxQXINg+/xgnavUBgT7CGx
	bAqWYFKMUPSZn5w3oA254VBteivWGP0g1Tg+WeV2cGCgy9sXNBFnHY9ZYaYbRA75cS1Kxs
	TJ3AF+hi/ZwdhlvbLEnfWWYtPeIKkYk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-23OcJpFlNPm_N_bPO3CkPg-1; Wed, 24 Jan 2024 16:36:52 -0500
X-MC-Unique: 23OcJpFlNPm_N_bPO3CkPg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 939268489A0
	for <mptcp@lists.linux.dev>; Wed, 24 Jan 2024 21:36:52 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.29])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 237A21121306
	for <mptcp@lists.linux.dev>; Wed, 24 Jan 2024 21:36:51 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net] mptcp: really cope with fastopen race.
Date: Wed, 24 Jan 2024 22:36:44 +0100
Message-ID: <02fe7afaec6fac65fc2da5922efe25d6ebdebc88.1706132185.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Fastopen and PM-trigger subflow shutdown can race, as reported by
syzkaller.

In my first attempt to close such race, I missed the fact that
the subflow status can change again before the subflow_state_change
callback is invoked.

Address the issue additionally copying with all the states directly
reachable from TCP_FIN_WAIT1.

Fixes: 1e777f39b4d7 ("mptcp: add MSG_FASTOPEN sendmsg flag support")
Fixes: 4fd19a307016 ("mptcp: fix inconsistent state on fastopen race")
Reported-by: syzbot+c53d4d3ddb327e80bc51@syzkaller.appspotmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 4a32d3d11fb6..de04b97e8dd1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -1171,7 +1171,8 @@ static inline bool subflow_simultaneous_connect(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 
-	return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_FIN_WAIT1) &&
+	return (1 << sk->sk_state) &
+	       (TCPF_ESTABLISHED | TCPF_FIN_WAIT1 | TCPF_FIN_WAIT2 | TCPF_CLOSING) &&
 	       is_active_ssk(subflow) &&
 	       !subflow->conn_finished;
 }
-- 
2.43.0

