Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793176083;
	b=5XSdeRngYS0lcSYrF6AuDvpfENwWSlvR/RE6IqEks+Ro2eIaDexWKK0osWD5/yquErLg
	 xm/W6vkBb9l6nOyZ8dk+VZrrDZfeN5BJ8CbIufcjvqRu9Yf1iKRplSEE7qH9gmFgbuBwt
	 rQxlgwIpER3ZL3oNXMAp7teSGCM3yACegro7qiTz1LRePtnXM1Ka5l49E9MFyEeZLW95k
	 OZfToD+X9baC8V9chTSub8WBbJQg/O3aloMvnGmGUbJVMgPaMMy9cM1ja77G9ETPtkbW8
	 8qfKqUtDDkwzk3+GuaIWzPgQLdwMFR+lkvboLxSMLwm6vMVCtRCK2cntla9R5ZmL1wQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793176083;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=0bnX4zX60YCKha46Olc23P+m1jc7sXIyWg6WYH4xiMU=;
	b=ZlsZeF6RiKxTHkgfRnhZxc8EbjnOjuJZsDVLl7mcMIiXHookUr7rK4UF6wEW21jvLgJK
	 OaGQgyDEUNvyX6iuTkjY9yVbrAN44sHyDXNjk5SJ3UYyOhulpIrF/o5CVsTIZ4nDiCwhv
	 05Mm+2Ozpc05zsXvy6z7jeOMCMjwUQ9bYriEfW0RW6wwg8vHgOS1WdMEoEyt5TkhejQPm
	 /lF7Dhg8NUNthDFlLCQYdE54MHh7mfA01ch5YblRncoJYyAg1RjjQTO+b6SB2d6nphmHe
	 K7zSKt+bD7QeSg0y5Zqa7TLBpF/+EHbfe/qtotbyuGTMnl+eYI2YByUw1mCwmsDzHsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9269606A327
	for <mptcp@lists.linux.dev>; Wed, 28 Oct 2026 08:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9269606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1793176061; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=K9KXXsIoeflA+v9Z3fkrILA9gvzbeazaV1aAIC13VANv8uX1m7Jwcp8S+CaobepRlZPuzkBwd+tfHCpd2DNe830PT3IdVAD8xx92vImUCikN52QfDeLPnq0/hAMqC19EqoeqGdlh1wnKi5nnIAL8DB3rdBId+xg41fWSpE4T3T4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793176061; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0bnX4zX60YCKha46Olc23P+m1jc7sXIyWg6WYH4xiMU=; 
	b=C7WGm5F4sxQnVOjvPXsf+e+7m44Qx7g16VKSoVtGhO+RUyJphK/jiQashg3THOor/sDhT+VElOHyVaXzXxqdPC27inxtw4OX6pl118DaGsJxzIwDDo3ujOEuDFeDON6jA/umb8XzCPIdfZFfbI82tIwLR8R0XXAjqPDEFSmEgLk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1793176061;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=0bnX4zX60YCKha46Olc23P+m1jc7sXIyWg6WYH4xiMU=;
	b=T+sbWaTE7xO5jaYbVPfVvlRYoaES3heyLxul6sxLS4/Rs8T3E2WVXw6rQL8kGA0J
	s5TgU+JuUTxqyTlT4Hrn40qKCHDQ0y3eY+hDDIh6yEDLVt4d5dmqoPA2r5N0XYJlpsU
	KIws2U4lhIhVtgBEErF1uJG1kxDwZhzPtNt+dT94=
Received: by smtp.zohomail.com with SMTPS id 1793176059486104.36534309557874;
	Wed, 28 Oct 2026 01:27:39 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next v11 2/2] mptcp: hide seq counters without net_admin
Date: Wed, 28 Oct 2026 13:57:01 +0530
Message-ID: <20261028082704.1609493-3-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028082704.1609493-1-kalpan.jani@mpiricsoftware.com>
References: <1ec0c2b5-a0fa-44e8-9ae8-dca9b7f90ec6@kernel.org>
 <20261028082704.1609493-1-kalpan.jani@mpiricsoftware.com>
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The MPTCP inet-diag response includes data sequence numbers that
should not be exposed to users without CAP_NET_ADMIN.

Clear mptcpi_write_seq, mptcpi_snd_una and mptcpi_rcv_nxt in diagnostic
responses for unprivileged users. Apply this restriction in the
inet-diag callback, leaving the MPTCP_INFO getsockopt path unchanged.

Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
 net/mptcp/mptcp_diag.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/mptcp/mptcp_diag.c b/net/mptcp/mptcp_diag.c
index 9ed7a6be1e628..970f849f4345c 100644
--- a/net/mptcp/mptcp_diag.c
+++ b/net/mptcp/mptcp_diag.c
@@ -215,6 +215,12 @@ static void mptcp_diag_get_info(struct sock *sk, struct inet_diag_msg *r,
 		return;
 
 	mptcp_diag_fill_info(msk, info);
+
+	if (!net_admin) {
+		info->mptcpi_write_seq = 0;
+		info->mptcpi_snd_una = 0;
+		info->mptcpi_rcv_nxt = 0;
+	}
 }
 
 static const struct inet_diag_handler mptcp_diag_handler = {
-- 
2.43.0

