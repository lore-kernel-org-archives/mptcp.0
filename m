Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7EB1990D9
	for <mptcp@lists.linux.dev>; Mon, 27 Oct 2025 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576076; cv=none; b=sZcvNVfD20SBf/guQlTh3z6fEQOmRpnecs7An6DROAolwTEBdO0RIcxrP95nLoN9jcue5FdaXN40aUTfVIr/Rv//HirPvxTl7wnEDnZxKzugks3m6Xq7MHsUeKo0FAgKTVCjyJnqSMyjR0UyhN9V19dJ9DeCrRvz0VWkTJqZq6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576076; c=relaxed/simple;
	bh=zB/8pFYSeKaxyOG2iGOVz0Z6H6IUgzsut7cm9tOlw9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=lQT0pe4NsgnO/LjRnaCJxwyPEz1Tr6HEa8hnpRw2jk6UkRcovfXsuxBVQdo3GQkMplhOW8ILFUIgn4uXoBFwjCFjXKp4xeQ/VWmbh6qcyVME0Pc5TaYU6Hd8dHD0pYCdmWfw9LlhieMdI36BDIThqAa0V109xhIBvPoiOkiDqG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g3/FgqYd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g3/FgqYd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761576073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lKLmPordTrD7LUBbkxUs11zrgr+6UgmsE+K7mEBwktM=;
	b=g3/FgqYduKVShHMHzC6RR4jDWMQl4K400IOWFN28CI1feQ+8TsJ5Cjhz8/b0MVKUWlXfIP
	TY/REdD4eN+Ewa++Gbl9kte6gYWumCq+k9CbFghi+X7dkHL38+5c6AcodcJMqXlC6+TGvg
	ENYHuXVp7gsK5ejhiuzcdQ/3k4YyNhE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-yHcwrq19MP62WNxChFp_Bw-1; Mon,
 27 Oct 2025 10:41:10 -0400
X-MC-Unique: yHcwrq19MP62WNxChFp_Bw-1
X-Mimecast-MFC-AGG-ID: yHcwrq19MP62WNxChFp_Bw_1761576069
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BFECA1800D87;
	Mon, 27 Oct 2025 14:41:08 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.10])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 57DA130001A2;
	Mon, 27 Oct 2025 14:41:06 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: Mat Martineau <martineau@kernel.org>,
	geliang@kernel.org
Subject: [PATCH v7 mptcp-next 1/4] DO-NOT-MERGE: mptcp: enabled by default
Date: Mon, 27 Oct 2025 15:40:49 +0100
Message-ID: <7a8077a36ad600454d4050f567c15af9a1399189.1761575881.git.pabeni@redhat.com>
In-Reply-To: <cover.1761575881.git.pabeni@redhat.com>
References: <cover.1761575881.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NZnTJq3MM0Zw-e_CdzgQG2pDxVP4S1NMSnnUDeiR7P4_1761576069
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Matthieu Baerts <matttbe@kernel.org>

This commit is useful for automated builds, e.g. from Intel's kbuild.

Signed-off-by: Matthieu Baerts <matttbe@kernel.org>
---
 net/mptcp/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/Kconfig b/net/mptcp/Kconfig
index b755fc9b6660..f674915dc31e 100644
--- a/net/mptcp/Kconfig
+++ b/net/mptcp/Kconfig
@@ -5,6 +5,7 @@ config MPTCP
 	select SKB_EXTENSIONS
 	select CRYPTO_LIB_SHA256
 	select CRYPTO
+	default y
 	help
 	  Multipath TCP (MPTCP) connections send and receive data over multiple
 	  subflows in order to utilize multiple network paths. Each subflow
-- 
2.51.0

