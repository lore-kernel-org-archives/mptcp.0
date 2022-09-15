Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC127670E
	for <mptcp@lists.linux.dev>; Thu, 15 Sep 2022 23:56:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663286186; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=NdO7GFid73CvEOmXzUq8YgWT6AHpgl8Soikxq7lYHHicxRFzpTqmmoiGA1bhgkH0FJiSK4KRAvRna9pnkMk94zAv3dWHQIlm2KiT5lp8ZUplY77Z6ar14KL7ogvQ6EjPFU0AZ7Ow32U7X9IWIYO35kzeMtFSJdS9mVl5o+BmN6Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663286186; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
	bh=Y80QJLPwdF6KT/UGcTZqU/Yh2JFjVOE2qKDdenCUVNA=; 
	b=OpWGhIUboA2+OOSAseJUscbodMZv37gyk6pKjJtHLULN25ORCH3FNtw3mgz3oeN1xocCfkm2e6AiRKSjBfTXJ64SKeXdz46ysW6CTvHMQlLQr2+zxNN4NsZMxdslsL1sFLBRS7GKG67ST7D8ToPLT/rmp244PbCFhFwYlYpUiTg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663286186;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Y80QJLPwdF6KT/UGcTZqU/Yh2JFjVOE2qKDdenCUVNA=;
	b=evcZ7uEYEdeIfCkGtl3ZJsT+GWWzjfBAf2Spu4EO8FT6qICW/rKhlTUuR/MkPK/w
	0koCyuYs6y4ehMhl3lqLTdEwS85WtWRfAaWTUBfT6DWyTFns9J9Yxl1oibwE+Dh1oOw
	Usc/3BPjJWjRcU1W2Nm3BfMQD5AMaHB6WBOO4EoI=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 166328618316291.4507614531318; Fri, 16 Sep 2022 01:56:23 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220915235604.26018-1-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v6 0/9] mptcp: Fast Open Mechanism
Date: Fri, 16 Sep 2022 01:55:55 +0200
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

[PATCH v6] includes "client-server" partial support for:
1. MPTCP cookie request from client (seems OK).
2. MPTCP cookie offering from server (seems OK).
3. MPTCP SYN+DATA+COOKIE from client (seems OK).
4. subsequent write + read on the opened socket (seems OK).

=3D=3D=3DChanges between v4 and v6
- All data sent by the initiator received by listener in userspace.
- No more infinite re-transmissions of the same packet in the
end of the second connection.
- =E2=80=9DWARNING in sk stream kill queues=E2=80=9D, when skb is added to
msk queue - is fixed.
- Fix the second (discarded) packet that is re-transmitted in the
end of 2nd session.
- We have (in the v4 it is not present) the FIN in the end of the
2nd (TFO data+cookie+syn) session.
- All comments from the mailing list are implemented.
- Properly remove the TS from TCP options.

=3D=3D=3DPros/Cons of v6:
- NO modifications of existing TCP code in linux kernel.
- Increased size of the patch.
=3D=3D=3DFuture work:
-Adress the appearance of "MPTCP FIN" as duplicated acks.

Signed-off-by: Dmytro Shytyi <dmytro@shytyi.net>

Dmytro Shytyi (9):
  Add separate fastopen.c file.
  Initiator: MSG_FASTOPEN sendto(). request cookie
  rfree(), rmem_uncharge() prototypes to protocol.h
  Initiator: add locks() to mptcp_sendmsg_fastopen.
  Fix unxpctd val of subflow->map_seq(dscrd packet)
  mptfo variables for msk, options. Fix loop retrans
  Listener: Add received skb to msk
  mptcp_fastopen_add_skb() helpers (skb to msk)
  selftests: mptfo initiator/listener

 net/mptcp/Makefile                            |   2 +-
 net/mptcp/fastopen.c                          | 553 ++++++++++++++++++
 net/mptcp/options.c                           |   3 +
 net/mptcp/protocol.c                          |  12 +-
 net/mptcp/protocol.h                          |  63 +-
 net/mptcp/sockopt.c                           |   3 +
 net/mptcp/subflow.c                           |   8 +-
 tools/testing/selftests/net/mptcp/mptfo.sh    |  13 +
 .../selftests/net/mptcp/mptfo_initiator.c     |  41 ++
 .../selftests/net/mptcp/mptfo_listener.c      |  98 ++++
 10 files changed, 785 insertions(+), 11 deletions(-)
 create mode 100644 net/mptcp/fastopen.c
 create mode 100644 tools/testing/selftests/net/mptcp/mptfo.sh
 create mode 100644 tools/testing/selftests/net/mptcp/mptfo_initiator.c
 create mode 100644 tools/testing/selftests/net/mptcp/mptfo_listener.c

--=20
2.25.1


