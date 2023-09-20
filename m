Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCB430FB3
	for <mptcp@lists.linux.dev>; Wed, 20 Sep 2023 12:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695213942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cGIbfzhIX6ZSIyZIa+3FwlnucdsPKPcj78y3dvKs1VI=;
	b=aHbOmNRRKh2U7t/vGWbOy8AY+C9+SfuO42tb7SwdBfEFuW6WZxlRVeqF9x6BblIL+EXLkX
	UHOfsEJXA8QKA9cA5FN4jEYM5VycNxk5/qcDIuZAaF31LFQBd0ZF/gdNsOq1iKb9BEMpxb
	rwj5PndN99Lpv+Li2MlAemu30SDB6Ro=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-262-vQN5kOJqPdm6yo_V34fhVQ-1; Wed, 20 Sep 2023 08:45:41 -0400
X-MC-Unique: vQN5kOJqPdm6yo_V34fhVQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C3553C23FE5
	for <mptcp@lists.linux.dev>; Wed, 20 Sep 2023 12:45:41 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.123])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8E41B1004058
	for <mptcp@lists.linux.dev>; Wed, 20 Sep 2023 12:45:40 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Subject: [PATCH mptcp-next 0/4] mptcp: performance improvemets
Date: Wed, 20 Sep 2023 14:45:33 +0200
Message-ID: <cover.1695208066.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Cool subj just to catch more attention;)

This is a follow-up the yday mtg and to the discussion started from
issues/437.

The first 3 patches implement a working support for rcvlowat, with the
intended and relevant side effect of avoiding most TCP-level immediate
acks.

The existing check in:

https://elixir.bootlin.com/linux/latest/source/net/ipv4/tcp_input.c#L5534

newarly always triggers immediate ack, as the any data received
on the subflow is usually immediately moved into the msk. That is, we
nearly always have: tp->rcv_nxt == tp->copied_seq.

That causes an unneeded large amount of (tcp-level) ack. After patch
3, MPTCP behaves much more alike plain TCP, compressing/delaying many
unneeded immediate ack and moving some of them at recvmsg() time.

Such change has quite a relevant effect on the max tput, ranging
from -4% to + 40% depending on the specific setup.
The small regression happens on CPU-bounded bulk transfers, with
not-so-large write buffer and can be elimitated increasing the write
buffer size. Even in such scenario, the overall efficency (B/W divided
by the total CPU cycles consumed) increases.
My personal take is that overall this for the better.

The last patch gives some speed-up to the tx path, just by using the
'correct' (or better) helper to memcpy the data from the user-space
into the kernel buffer.

Paolo Abeni (4):
  mptcp: properly account fastopen data
  mptcp: use plain bool instead of custom binary enum
  mptcp: give rcvlowat some love.
  mptcp: use copy_from_iter helpers on transmit..

 net/mptcp/fastopen.c |  1 +
 net/mptcp/protocol.c | 42 +++++++++++++++++++++++++-----------------
 net/mptcp/protocol.h | 27 +++++++++++++++++++++------
 net/mptcp/sockopt.c  | 31 +++++++++++++++++++++++++++++++
 net/mptcp/subflow.c  | 24 ++++++++++++++++--------
 5 files changed, 94 insertions(+), 31 deletions(-)

-- 
2.41.0

