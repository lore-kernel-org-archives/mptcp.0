Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716B9362
	for <mptcp@lists.linux.dev>; Tue, 27 Sep 2022 22:54:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664319258; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Q92zspZQ1Bp6lphPLHNlxD7/mnfwPBtfNQueTREZBSbFYlBROUl+UAj8boELB7Ul2RSnNCKpewZVxGMDVubAPYg4WDegXSvyWzavPmNEfoTDbgCW6hPRwToQR8iYQBZmSD7ctfVGZTGhKKBOyyLueD0bHYyube7GHqhv2HJ41QY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664319258; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
	bh=HXMMnmNeswQ7/QJOpmsNwOSx8TJ02Ysw1r+nHV6Ug9A=; 
	b=ITIyr7KM4R5Ml0Etxtxo/DePMaLxch+hH6H3moQCxvPhwOBEKH801/sZM96K7yLfd9S03orBBPgQssdQObpSGecENTV5RT4oLRUSZkHsNnLDon6XVDB5djyYaGVln5FoiWs1X2x9saKBEARsKEmgEytLfb+1ldwE22HrETUNwUQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664319258;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=HXMMnmNeswQ7/QJOpmsNwOSx8TJ02Ysw1r+nHV6Ug9A=;
	b=fznx6LPE2os96cFonvpUYDF138ZTxQzxZkfRDGZjlaGxl+4uq+bN8TC0CLfUhIBW
	iuMQRqZSi8AAb4NuqvpMYZ6Qei0zeqUbSDBr8fajNeHQg2mPrlgp25TedLNW9O17Oqb
	iSoj+vvX9K5tUhG+KqtYZIzpiqr7BADcbvNjwwsU=
Received: from localhost.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1664319256137893.4506186453959; Wed, 28 Sep 2022 00:54:16 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220927225341.14165-1-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v12 0/7] mptcp: Fast Open Mechanism
Date: Tue, 27 Sep 2022 22:53:34 +0000
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
The next options in userspace are available:=20
a) sendto(..., ..., ..., MSG_FASTOPEN, ..., ...);
b) setsockopt(..., SOL_TCP, TCP_FASTOPEN, ..., ...);

These patches implement Appendix-B of RFC8684 (MPTFO).

We would like to credit Paulo Abeni, Mat Martineau, Matthieu Baerts and
Benjamin Hesmans for advices and ideas that improved these patches.

Dmytro Shytyi (5):
  mptcp: introduce MSG_FASTOPEN flag.
  mptcp: fix retrans., add mptfo vars to msk
  mptcp: add subflow_v(4,6)_send_synack()
  mptcp: add TCP_FASTOPEN option
  selftests: mptfo initiator/listener

Matthieu Baerts (2):
  mptcp: sockopt: make 'tcp_fastopen_connect' generic
  mptcp: add TCP_FASTOPEN_NO_COOKIE support

 include/net/mptcp.h                           |   9 ++
 include/net/tcp.h                             |   3 +
 net/ipv4/tcp.c                                |  20 +++-
 net/ipv4/tcp_fastopen.c                       |  19 ++--
 net/mptcp/Makefile                            |   2 +-
 net/mptcp/fastopen.c                          |  62 +++++++++++
 net/mptcp/options.c                           |   5 +
 net/mptcp/protocol.c                          |  21 ++--
 net/mptcp/protocol.h                          |   9 ++
 net/mptcp/sockopt.c                           |  21 ++--
 net/mptcp/subflow.c                           |  42 ++++++++
 tools/testing/selftests/net/mptcp/mptfo.sh    |  13 +++
 .../selftests/net/mptcp/mptfo_initiator.c     |  43 ++++++++
 .../selftests/net/mptcp/mptfo_listener.c      | 100 ++++++++++++++++++
 14 files changed, 342 insertions(+), 27 deletions(-)
 create mode 100644 net/mptcp/fastopen.c
 create mode 100644 tools/testing/selftests/net/mptcp/mptfo.sh
 create mode 100644 tools/testing/selftests/net/mptcp/mptfo_initiator.c
 create mode 100644 tools/testing/selftests/net/mptcp/mptfo_listener.c

--=20
2.34.1


