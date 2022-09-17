Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83165C81
	for <mptcp@lists.linux.dev>; Sat, 17 Sep 2022 22:29:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663453759; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=PLLy0/qlIw5p2+WrWuz9ufFEYKXq/fct7QkeldfyIp18249dKkCHkUlkcRrsKJN8b92otNdOHuYYFZzhJ4J2ud1pqSHqHZ79/wY/XJhlDnF5FHNt8cOfsJ78rvWWBVgVla6thyeTPGG72I3JYoWahPk+cEFxl2IJFeivp+AeEEA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663453759; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
	bh=WrW6dKT4biOdXWrzeXlaXNPMrqvEsrFWAz8wXtRjYuU=; 
	b=koUg7HCCQP85L7ERYleZY5+QAHa9cvXP4xJkhan7Z8vQrH2aIZFssZWZGwVy5yo6bHdGx/conhq90E1Yf3fOZ8iLdb9OWA2nSyrea2FsKPH85f6JB5j0NOZF+5+eRMbnduAfnGNpDUUkWdPrSCUKbXzr2YMWaz4dKMn5d1Mm3+w=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663453759;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=WrW6dKT4biOdXWrzeXlaXNPMrqvEsrFWAz8wXtRjYuU=;
	b=RFxTlhfGUT3QDeKEF0JVCz069p5a0zYR20cP7/fu+bsXvR0xqUqLPb9iHCC3dx+T
	I+5Qy2j7OUXBGHWkMlRzLp9ob5IuIC6GShpQMf6qAlFEb6adFAkBl7NWQ9VUk03lJXO
	6wghPZG+Hzn7A1e7aHRhEJHBQkj0gwdmyV1y0E+o=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663453756632762.6722366044186; Sun, 18 Sep 2022 00:29:16 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220917222853.2406-1-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v7 00/11] mptcp: Fast Open Mechanism
Date: Sun, 18 Sep 2022 00:28:42 +0200
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8

[PATCH v7] includes "client-server" partial support for:
1. MPTCP cookie request from client (seems OK).
2. MPTCP cookie offering from server (seems OK).
3. MPTCP SYN+DATA+COOKIE from client (seems OK).
4. subsequent write + read on the opened socket (seems OK).

=3D=3D=3DChanges between v6 and v7
- Order of commits is changed.
- Code is refactored
=3D=3D=3DPros/Cons of v7:
- little modifications of existing TCP code in linux kernel.
- relatively decreased size of the patch (in comparison with v6)
due to reuse of some functions in tcp_fastopen.c.
=3D=3D=3DFuture work:
-Adress the appearance of "MPTCP FIN" as duplicated acks.=20

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>

Dmytro Shytyi (11):
  Add separate fastopen.c file.
  add mptcp_stream_connect to protocol.h
  Initiator: MSG_FASTOPEN sendto(). request cookie
  rfree(), rmem_uncharge() prototypes to protocol.h
  Initiator: add locks() to mptcp_sendmsg_fastopen.
  add mptcp_setsockopt_fastopen
  mptfo variables for msk, options. Fix loop retrans
  Fix unxpctd val of subflow->map_seq(dscrd packet)
  Listener: Add received skb to msk
  mptcp_fastopen_add_skb() helpers (skb to msk)
  selftests: mptfo initiator/listener

 include/net/tcp.h                             |  27 ++
 net/ipv4/tcp_fastopen.c                       |  38 +-
 net/ipv4/tcp_input.c                          |  20 +-
 net/mptcp/Makefile                            |   2 +-
 net/mptcp/fastopen.c                          | 331 ++++++++++++++++++
 net/mptcp/options.c                           |   3 +
 net/mptcp/protocol.c                          |  12 +-
 net/mptcp/protocol.h                          |  56 ++-
 net/mptcp/sockopt.c                           |   3 +
 net/mptcp/subflow.c                           |   8 +-
 tools/testing/selftests/net/mptcp/mptfo.sh    |  13 +
 .../selftests/net/mptcp/mptfo_initiator.c     |  41 +++
 .../selftests/net/mptcp/mptfo_listener.c      |  98 ++++++
 13 files changed, 614 insertions(+), 38 deletions(-)
 create mode 100644 net/mptcp/fastopen.c
 create mode 100644 tools/testing/selftests/net/mptcp/mptfo.sh
 create mode 100644 tools/testing/selftests/net/mptcp/mptfo_initiator.c
 create mode 100644 tools/testing/selftests/net/mptcp/mptfo_listener.c

--=20
2.25.1


