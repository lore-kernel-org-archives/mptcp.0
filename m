Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1988D24F29
	for <mptcp@lists.linux.dev>; Tue, 15 Nov 2022 17:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1668534397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3/FzwimesOEkkRWM2yBSpfrHmaHRyWcM3ps6CazJ9W4=;
	b=HejiFE+smSbYIvCTb8oUskZrA95ri6tuM6JHksdEsDz7jfzxAGcc817Puz4iY1fn63g7U0
	fwkbEwvgV5W5cjpOV7nJ/lNumQTG/1PWGdF0cTBvdeGj2CYl1+jPqlL2C8wlhZQxdoSkqJ
	FHZoN+0M4Q86tz53EGWbheOne/1XP5w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-EXvmF4N9PL-FvDU4JnkhgA-1; Tue, 15 Nov 2022 12:46:36 -0500
X-MC-Unique: EXvmF4N9PL-FvDU4JnkhgA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3550D1C05AC2
	for <mptcp@lists.linux.dev>; Tue, 15 Nov 2022 17:46:36 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.192.149])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B929C2166B2B
	for <mptcp@lists.linux.dev>; Tue, 15 Nov 2022 17:46:35 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 0/2] mptcp: more fastopen follow-up
Date: Tue, 15 Nov 2022 18:45:11 +0100
Message-Id: <cover.1668531722.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

The last bunch of mptcp fast open follow-up I have planned.

This aims at reducing the number of unnecessary mptcp_crypto_key_sha()
invocation, calling such primitive at most once per MPC subflow
and caching the result as subflow level.

The first patch should be inserted just before

"mptcp: implement delayed seq generation for passive fastopen"

while the 2nd one is a squash-to, still to the above.

Note that this will cause a trivial conflict in "DO-NOT-MERGE: mptcp:
use kmalloc on kasan build"

-- 
2.38.1

