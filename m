Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BAB30E858
	for <mptcp@lists.linux.dev>; Mon, 10 Nov 2025 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762785664; cv=none; b=gkkblJaqF1aCAFd0zHVQKNL4EZaZUmV0OlOO4Y0F6bHKtvlCsKixi5RUzne64WBnIFBU+RRU2Xljss755SlNCjjBUW84YX/3+gKSkKHv58EKzeU5qfDNI1Ix5CuWAdOoUloaxZnimI1kIullZAtgoaOUieoi6s9h5vMSNwJUUFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762785664; c=relaxed/simple;
	bh=tNs3Dn42bz5oGgFm3lAGYgJYxDfWYNk2z4jrYcNSb8Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=S3z6QSkyZI2pf0r4vhlW6dCPfxo9ARCAeLqagMFWM5WO4IpnKFSt4EdO9AnuuZFsD/zr2aUprecG8ZM9pN3fDffMbfDnnOzUu5uD4tE642xIz6MqjRVtx65rpPIIc+tKk3gFJcpdxo1BiPXSecW1pJhuayf77y/5zAIlrO1peWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ra2rEWzv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ra2rEWzv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762785660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=REutQJ9rB/BclfuKvK3SLsO+ruOmsJe1i2XImu+mytE=;
	b=Ra2rEWzvZT0Gmp8bvotJQ2/m5oV0KrAB+3erOVGK0NA2FePz0Yf6RXLLf41i9SZTFaXK28
	3h2/e+AtsVxtxlYoE7CzN6so2Rpr4GqcOgcI4t9Yj0aE8Gwp/rOeZLNBgSe7L7Yjdz9RDm
	whJEViQ7XLWI70YfKHixyvm3QktkXWM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-dx9fgCQAOSCgOzfACgWphg-1; Mon,
 10 Nov 2025 09:40:59 -0500
X-MC-Unique: dx9fgCQAOSCgOzfACgWphg-1
X-Mimecast-MFC-AGG-ID: dx9fgCQAOSCgOzfACgWphg_1762785658
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32C2A1800473
	for <mptcp@lists.linux.dev>; Mon, 10 Nov 2025 14:40:58 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.226.92])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4D1EF196FC8B
	for <mptcp@lists.linux.dev>; Mon, 10 Nov 2025 14:40:56 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-net 0/2] mptcp: a couple of fixes
Date: Mon, 10 Nov 2025 15:40:44 +0100
Message-ID: <cover.1762785316.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vc3bjVNlCtKgtVIy3lbgsFywmOGwiLvmueVEQE4ODOg_1762785658
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

The first patch addresses a recently filed issue, 2nd one is due to
code inspection while investigating the mentioned issue.

Paolo Abeni (2):
  mptcp: do not fallback when OoO is present
  mptcp: do not drop partial packets.

 net/mptcp/protocol.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

-- 
2.51.1

