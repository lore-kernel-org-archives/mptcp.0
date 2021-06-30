Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [216.205.24.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9610C168
	for <mptcp@lists.linux.dev>; Wed, 30 Jun 2021 11:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1625053347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4KGNnxSjVoiRIXSLGapbo97A6hT+lwVaG9rqf5CJVY0=;
	b=NYMAqNwwwFdQPMGYxb18Qqx6qfYTaO13aet7gEQHlB5FxdoVbq+WiXzeotEndBmBqs8Hzi
	T1FMM+LvneLLuWc/t4uEiBpq/MfeyC8vm7CagwHYrh/Ddi+Rfa8jbXCZbvsICVl8yBsvPX
	v1Mvv+lbG/2DNziBFss6Y+d2woaMUvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-oAHFK9YIOe-6XKZUBGui3g-1; Wed, 30 Jun 2021 07:42:26 -0400
X-MC-Unique: oAHFK9YIOe-6XKZUBGui3g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8229804141;
	Wed, 30 Jun 2021 11:42:24 +0000 (UTC)
Received: from gerbillo.redhat.com (ovpn-115-108.ams2.redhat.com [10.36.115.108])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 94F636788B;
	Wed, 30 Jun 2021 11:42:22 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Davide Caratti <dcaratti@redhat.com>,
	Mat Martineau <mathew.j.martineau@linux.intel.com>,
	mptcp@lists.linux.dev
Subject: [PATCH net] tcp: consistently disable header prediction for mptcp
Date: Wed, 30 Jun 2021 13:42:13 +0200
Message-Id: <7f941e06e6434902ea4a0a572392f65cd2745447.1625053058.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16

The MPTCP receive path is hooked only into the TCP slow-path.
The DSS presence allows plain MPTCP traffic to hit that
consistently.

Since commit e1ff9e82e2ea ("net: mptcp: improve fallback to TCP"),
when an MPTCP socket falls back to TCP, it can hit the TCP receive
fast-path, and delay or stop triggering the event notification.

Address the issue explicitly disabling the header prediction
for MPTCP sockets.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/200
Fixes: e1ff9e82e2ea ("net: mptcp: improve fallback to TCP")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
Notes:
- I'm unable to disable header prediction consistently for MPTCP
  sockets touching only MPTCP code
- possible alternatives could be:
  - hook MPTCP in the TCP fastpath, too
  - try to pull again commit 45f119bf936b ("tcp: remove header prediction")
    avoiding the regression noded in 31770e34e43d ("tcp: Revert "tcp: remove
    header prediction"")
  I choose this option as the hopefully less invasive one.
---
 include/net/tcp.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index d05193cb0d99..b42b3e6731ed 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -682,6 +682,10 @@ static inline u32 __tcp_set_rto(const struct tcp_sock *tp)
 
 static inline void __tcp_fast_path_on(struct tcp_sock *tp, u32 snd_wnd)
 {
+	/* mptcp hooks are only on the slow path */
+	if (sk_is_mptcp((struct sock *)tp))
+		return;
+
 	tp->pred_flags = htonl((tp->tcp_header_len << 26) |
 			       ntohl(TCP_FLAG_ACK) |
 			       snd_wnd);
-- 
2.26.3

