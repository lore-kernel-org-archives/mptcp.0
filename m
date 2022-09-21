Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D6B2F56
	for <mptcp@lists.linux.dev>; Wed, 21 Sep 2022 12:56:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663764963; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=hvBzcc4TNlFpRJEQUFTP9mQh+M6B8NbtVLeSDfTXe4rfhq4BD8f6nKlwGTklpcR98/X57lsF9p8L7+JpF36O6oZUuzEz0rfFaubb+IKUE6YyBlSr/62yxmxrJaUenPOH6MgS5x3BwXDB4PcW0tzN3NJoKK+xBW+dOTV48+qM4t4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663764963; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
	bh=pOxzuNo5QBTOaI7tT5VCwiy+r6uF2zsTeURJy6t6bKU=; 
	b=jMTb7FuN/EZs3xjE1x6oQjwLUMxlHMyvWVO/zj29PORJNIhAzq/nRSWCi3+/JWVRyNOzEETgRzxthu+rBaZKHjvjqLLR/Uc3PfhmCLHNnFVGvGSK3xiQ8eH751S9xAkmnSpSz3RaX+vQzanKbkhaGebOPzjVUOL2cJeM2MKRot8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663764963;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=pOxzuNo5QBTOaI7tT5VCwiy+r6uF2zsTeURJy6t6bKU=;
	b=XxZzByVOBlRQVaTFieHgy1YF8jvebfDiRcCYmg5Iv/bvwkt4U474CfOSfj3nbKN1
	mNH9X2Ox0PCTRzEN+H+0bCUOl/Wek3GGs5CGTDfh7IRYAC1ifz5fvQT2r2AERY3Dn4+
	jqgkVr+Hs+z2NuwymWvmQioQoGrYPoMAmtCeX8Z8=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663764962033783.7281300277183; Wed, 21 Sep 2022 14:56:02 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220921125558.19483-1-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v9 0/6] mptcp: Fast Open Mechanism
Date: Wed, 21 Sep 2022 14:55:52 +0200
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

[PATCH v9] includes "client-server" partial support for:
1. MPTCP cookie request from client (seems OK).
2. MPTCP cookie offering from server (seems OK).
3. MPTCP SYN+DATA+COOKIE from client (seems OK).
4. subsequent write + read on the opened socket (seems OK).
=3D=3D=3DChanges between v8 and v9
- Code is refactored (Max. reuse of existing linux kernel code).
- impact on fastopen.c is reduced to minima due to added function
subflow_v4_send_synack().
=3D=3D=3DFuture work
-Adress the appearance of "MPTCP FIN" as duplicated acks.
-Integrate presented in the last patch selftests.=20

Dmytro Shytyi (6):
  mptcp: add mptcp_stream_connect to protocol.h
  mptcp: add mptcp_setsockopt_fastopen
  mptcp: reuse tcp_sendmsg_fastopen()
  mptcp: fix retrans., add mptfo vars to msk
  mptcp: add subflow_v(4,6)_send_synack()
  selftests: mptfo initiator/listener

 include/net/tcp.h                             |   3 +
 net/ipv4/tcp.c                                |  24 ++++-
 net/ipv4/tcp_fastopen.c                       |  19 ++--
 net/mptcp/Makefile                            |   2 +-
 net/mptcp/fastopen.c                          |  46 ++++++++
 net/mptcp/options.c                           |   5 +
 net/mptcp/protocol.c                          |  35 +++++-
 net/mptcp/protocol.h                          |  10 ++
 net/mptcp/sockopt.c                           |   3 +
 net/mptcp/subflow.c                           |  70 ++++++++++++
 tools/testing/selftests/net/mptcp/mptfo.sh    |  13 +++
 .../selftests/net/mptcp/mptfo_initiator.c     |  43 ++++++++
 .../selftests/net/mptcp/mptfo_listener.c      | 100 ++++++++++++++++++
 13 files changed, 356 insertions(+), 17 deletions(-)
 create mode 100644 net/mptcp/fastopen.c
 create mode 100644 tools/testing/selftests/net/mptcp/mptfo.sh
 create mode 100644 tools/testing/selftests/net/mptcp/mptfo_initiator.c
 create mode 100644 tools/testing/selftests/net/mptcp/mptfo_listener.c

--=20
2.25.1


