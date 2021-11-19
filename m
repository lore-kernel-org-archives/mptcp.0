Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48832C83
	for <mptcp@lists.linux.dev>; Fri, 19 Nov 2021 14:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1637332121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K5J74Mu1G8wQTJihUKx9JZPZVqeHh/vB5/vkuhev9ow=;
	b=gR1qXk4ji+jicsoJSLvgGpKdWQQT7DJyYYVs94Ru391F08HycGohD3S193uoCdjcQqVH6x
	QsrpFV+iCtZJJjJU9KQK8zABUdoGiY0xauypD1acHyYTzPNwtkICvssbhF/ONGmdSl8vyX
	tLX2eGd6LmRny961cx+Tvsm7ABneCjw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-560-Hx1sGePdNgioga9QVRFqwA-1; Fri, 19 Nov 2021 09:28:38 -0500
X-MC-Unique: Hx1sGePdNgioga9QVRFqwA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AA86802E62;
	Fri, 19 Nov 2021 14:28:37 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.39.193.42])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1FFE160657;
	Fri, 19 Nov 2021 14:28:35 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: mptcp@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net 0/2] mptcp: fix 3rd ack rtx timer
Date: Fri, 19 Nov 2021 15:27:53 +0100
Message-Id: <cover.1637331462.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11

Eric noted that the MPTCP code do the wrong thing to schedule
the MPJ 3rd ack timer. He also provided a patch to address the
issues (patch 1/2).

To fix for good the MPJ 3rd ack retransmission timer, we additionally
need to set it after the current ack is transmitted (patch 2/2)

Note that the bug went unnotice so far because all the related
tests required some running data transfer, and that causes
MPTCP-level ack even on the opening MPJ subflow. We now have
explicit packet drill coverage for this code path.

Eric Dumazet (1):
  mptcp: fix delack timer

Paolo Abeni (1):
  mptcp: use delegate action to schedule 3rd ack retrans

 net/mptcp/options.c  | 32 ++++++++-------------------
 net/mptcp/protocol.c | 51 ++++++++++++++++++++++++++++++++++++--------
 net/mptcp/protocol.h | 17 ++++++++-------
 3 files changed, 60 insertions(+), 40 deletions(-)

-- 
2.33.1

