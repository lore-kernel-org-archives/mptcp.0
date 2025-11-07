Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F230226462E
	for <mptcp@lists.linux.dev>; Fri,  7 Nov 2025 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762500195; cv=none; b=NfsXCW2aWoRpvtOXwEw+iBSygq7GufSlRN+oheGtCY3zlDGoMQx3wHC5xze/DW4yHd8u69KrRnvIhqt5yNec7ynHcZTZkolo3vHqntOL+I5F9EjXaMx+xonbl0xMW64jFUUO1ZrRd+ahKzXEhxh+B/uHh6PsNpdZkpFx6lpLTLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762500195; c=relaxed/simple;
	bh=npJxr8JK20UhI3k3djHTQ+Jf+nQDMGJMy4v6b7SVPDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=rsOx+Lt0ul8mFbjwGppLIjDrLGFnq9arQIeU8X0LeGHgf48gERcjffdupUR8vTcnifC76Fj/S0DnqXUeVlYDdLcJTPWI+6cp9E+An14HtoiS22Jo52cTL1E5ong37WkMPTbYgVzpEQjhbQnZYVf03c85LoP9JWQTPWoxd7tnPzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gAw4+qIq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAw4+qIq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762500192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dcoKEUTLc7Yjrx6neZCZZSxeke9OEcae0f9KIuNcuAY=;
	b=gAw4+qIqdE560r2rHE/qmYdsKNEj4zPVb1jrVbeUnd4o3hE4AV8J56gsf7/n4gmrg7XYZX
	DZNoSxUEU8f4ZODwJgJvRN5dRDhhcXFBTvqZPVVhADhyP9VnciTnSIHwAdf9c8uFRs9Hvg
	H2h801Uu2aEzrj4sbwuRbVzVN2DWIYY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-cy2t9_69PPyMoLeuZPUltg-1; Fri,
 07 Nov 2025 02:23:10 -0500
X-MC-Unique: cy2t9_69PPyMoLeuZPUltg-1
X-Mimecast-MFC-AGG-ID: cy2t9_69PPyMoLeuZPUltg_1762500190
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E289C1800357;
	Fri,  7 Nov 2025 07:23:09 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.157])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B13191800362;
	Fri,  7 Nov 2025 07:23:08 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: geliang@kernel.org
Subject: [PATCH v2 mptcp-net 0/2] mptcp: fix duplicate reset
Date: Fri,  7 Nov 2025 08:23:02 +0100
Message-ID: <cover.1762500073.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oBOTZK130B8l9jLyRl1EvqF5fdTpRnykV6hqZ0ZonSk_1762500190
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The actual fix is in patch 2/2, while patch 1/2 is there just to make
the change tidy/more easily reviewable.
---
v1 -> v2:
  - drop FASTCLOSE flag entirely

Paolo Abeni (2):
  mptcp: decouple mptcp fastclose from tcp close
  mptcp: fix duplicate reset on fastclose

 net/mptcp/protocol.c | 50 ++++++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 18 deletions(-)

-- 
2.51.0

