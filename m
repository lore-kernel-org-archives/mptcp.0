Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183F71CD28
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428991; cv=none; b=odQOUwcJz3cwETzUDsa3tPJiJbjzbq9B+RducTe/5uzK9ArOPKl5VCsMKhRpM/HSkmtxLyTM5cHIq3UgkxGkBqd+oYHRK0rByTrk8fzf7zdYFUnZh1J7UVnu87Ww2I3PhtenCpMmFpMbZ81XpIzr0Vp4+zSx+tZqTIJaqoaPlmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428991; c=relaxed/simple;
	bh=2zzc5B7C9WvsTcfmq0/eBm9mkqKNXmlc922j9Jw9xVc=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:From:To:
	 Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 X-Scanned-By:X-Mimecast-Spam-Score:X-Mimecast-Originator:
	 Content-Transfer-Encoding:Content-Type; b=LF9TGrpVQd09E80UiYARP0kDrDEbjBLcfMrXETwFoPiT3I5HAn1K58ablYHwLJ6LmVDKRCl/paXT96OD5CoPmG4YIipZa5e9g/ClA7nPXEoow3NkspKy0RB2ZsvWa7tWnJWUaV72oettidfpUG2b+jQkNZ4f4SohxikTgcq5bnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FWgxjTG/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWgxjTG/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705428988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g62sdjsj0410fQnTGPvmV4Nc6x9d5pW53LC0rzjTZRY=;
	b=FWgxjTG/Tu/5zhAr78SnE3qkLVu1munCabdCJTQeF4Ahs2VnV1qLPgXSSi6XXGnYyPxfyl
	YBBKAbR6DQQro7KAfbyw1J3wWLpMuUvrsEfX2OsSots06xGHSxKLIGkf/pZKkKjUspO1Dw
	1OqEediKELtBs1awyHTtoZR5mW8z+JM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-3jPGCAZXPuSTZMdkbZQm3g-1; Tue, 16 Jan 2024 13:16:26 -0500
X-MC-Unique: 3jPGCAZXPuSTZMdkbZQm3g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E280890F60
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 18:16:26 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.11])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D25E01121306
	for <mptcp@lists.linux.dev>; Tue, 16 Jan 2024 18:16:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 5/5] mptcp: annotate lockless accesses around read-mostly fields
Date: Tue, 16 Jan 2024 19:16:14 +0100
Message-ID: <4f4ba04c46b432b5f2a95bb75d85912bcb937cfb.1705427537.git.pabeni@redhat.com>
In-Reply-To: <cover.1705427537.git.pabeni@redhat.com>
References: <cover.1705427537.git.pabeni@redhat.com>
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

The following MPTCP socket fieds:

can_ack
fully_established
rcv_data_fin
snd_data_fin_enable
rcv_fastclose
use_64bit_ack

are accessed without any lock, add the appropriate annotation.

The schema is safe as each field can change its value at most
once in the whole mptcp socket life cycle.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/mptcp/protocol.c | 14 +++++++-------
 net/mptcp/sockopt.c  |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bc472f1294e1..744b4d6f15f4 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3156,16 +3156,16 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	WRITE_ONCE(msk->flags, 0);
 	msk->cb_flags = 0;
 	msk->recovery = false;
-	msk->can_ack = false;
-	msk->fully_established = false;
-	msk->rcv_data_fin = false;
-	msk->snd_data_fin_enable = false;
-	msk->rcv_fastclose = false;
-	msk->use_64bit_ack = false;
-	msk->bytes_consumed = 0;
+	WRITE_ONCE(msk->can_ack, false);
+	WRITE_ONCE(msk->fully_established, false);
+	WRITE_ONCE(msk->rcv_data_fin, false);
+	WRITE_ONCE(msk->snd_data_fin_enable, false);
+	WRITE_ONCE(msk->rcv_fastclose, false);
+	WRITE_ONCE(msk->use_64bit_ack, false);
 	WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(sk)));
 	mptcp_pm_data_reset(msk);
 	mptcp_ca_reset(sk);
+	msk->bytes_consumed = 0;
 	msk->bytes_acked = 0;
 	msk->bytes_received = 0;
 	msk->bytes_sent = 0;
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index c40f1428e602..da37e4541a5d 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -942,7 +942,7 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *info)
 	mptcp_data_unlock(sk);
 
 	slow = lock_sock_fast(sk);
-	info->mptcpi_csum_enabled = msk->csum_enabled;
+	info->mptcpi_csum_enabled = READ_ONCE(msk->csum_enabled);
 	info->mptcpi_token = msk->token;
 	info->mptcpi_write_seq = msk->write_seq;
 	info->mptcpi_retransmits = inet_csk(sk)->icsk_retransmits;
-- 
2.43.0

