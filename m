Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E6223BD
	for <mptcp@lists.linux.dev>; Mon, 10 Oct 2022 22:31:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1665441098; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ElUVzV7v158r8vPFXXFE6OwJVxy9h8kQ7gJwyIUVANECi+JrzPU/Ub/2C9VF0YAikegFFUoCmY6S2l8z5qPZE56uHIWMoyoCGb40bcEcoGpjP08jybs3HCCA/YfW+XyfKCRdg7xHhXXRWBRoGLSTgkywsPBEooiE/wMAfyJIhOE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1665441098; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
	bh=6byqg0mw5tELLB2KXlDojQ3W8NHR4egyFYOMtR7/FZM=; 
	b=SJ8Fwvn/doOss22M8Omt1FcLYAMnL5M7KqKM8grgx24wCm1uywsot7vzpBGos/+RAcKaRe273MBwYwIwIBnZAUk/8mnkE7EAAVNWF4oqfTfCCxH3EQr9a8iFa/mCtHtfND5+NbaLK2tKYh/C0XdCYfqTd1o80JEF9ua+7cyVN/8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1665441098;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=6byqg0mw5tELLB2KXlDojQ3W8NHR4egyFYOMtR7/FZM=;
	b=V2lGthI6mHgIw9fqiboa0QHemD17DEEx26MIGDuu5ydMwD/DN8UUePY/blPLEzRF
	dvjmxcT5mGvVaT7LS4qfYZb9SgeJkzYIrVGimoief+pw1zzn46nBs0hQ/eTsPVwH4dq
	kfNlMEwVfwqd5yvWRAp9/GMeVBhaaV8hpNbOmfZU=
Received: from localhost.localdomain (vps-940813d4.vps.ovh.net [198.244.188.50]) by mx.zoho.eu
	with SMTPS id 1665441095045610.1526515602617; Tue, 11 Oct 2022 00:31:35 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20221010223122.1809-1-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v14 0/5] mptcp: Fast Open Mechanism
Date: Mon, 10 Oct 2022 22:31:22 +0000
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

These patches focus on the Initiator and partially on Listener side.
The next options in userspace are available:
a) sendto(..., ..., ..., MSG_FASTOPEN, ..., ...);
b) setsockopt(..., SOL_TCP, TCP_FASTOPEN, ..., ...);

These patches implement Appendix-B of RFC8684 (MPTFO).

We would like to credit Paulo Abeni, Mat Martineau, Matthieu Baerts and
Benjamin Hesmans for advices and ideas that improved these patches.

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>
---
v13 -> v14:
 - rebase on top of Paolo's patch: mptcp: factor out mptcp_connect().
 - add IPv6 only check for subflow_v6_send_synack().
 - new helper for sockopt (first subflow only) is used.
 - integrate selftests.
 - modify treq.
---
Dmytro Shytyi (5):
  mptcp: introduce MSG_FASTOPEN flag.
  mptcp: implement delayed seq generation for passive fastopen
  mptcp: add subflow_v(4,6)_send_synack()
  mptcp: add TCP_FASTOPEN sock option
  selftests: mptcp: mptfo Initiator/Listener

 net/mptcp/Makefile                            |   2 +-
 net/mptcp/fastopen.c                          |  97 ++++++++++++
 net/mptcp/options.c                           |   5 +
 net/mptcp/protocol.c                          |  11 +-
 net/mptcp/protocol.h                          |   9 ++
 net/mptcp/sockopt.c                           |   5 +-
 net/mptcp/subflow.c                           |  42 ++++++
 .../selftests/net/mptcp/mptcp_connect.c       | 140 +++++++++++++-----
 .../selftests/net/mptcp/mptcp_connect.sh      |  77 ++++++++++
 9 files changed, 346 insertions(+), 42 deletions(-)
 create mode 100644 net/mptcp/fastopen.c

--=20
2.34.1


