Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D870A55
	for <mptcp@lists.linux.dev>; Tue, 20 Sep 2022 12:52:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663678369; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=CCymgW7crFONxZo0t3heimbeltrr+DpjmV2vfR0DekpxeQhNRwQwY319sVYYL5WZi2id20m+kQFlKOrlDaEnBqoo9a4YoYgCJbAWkQ++FeHkQLo36EagABwfe1OQKZ8qh+LX+9l9VUVPDbFCcLVphsqUUPDhkwdDbQgFPt8lGPQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663678369; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
	bh=06EmSvAGxwW4E4t+xEpb8/nU+uWzK+OSou10hcNBjl4=; 
	b=HEKhRrUhkCpufH1VItNirkX8ttRANcrol5DQI2fnt75EeDeZA12MUavnyrmfXekQN612G26trtLdYl1kweOOrcBwszsn0vQZJ8K/wap1Ta5k2YBJxNkpQ5pFoLJULHMdXqkZoZSoul8eheAwf2ILC6xI8xESi1h3Sih43fvEm7s=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663678369;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=06EmSvAGxwW4E4t+xEpb8/nU+uWzK+OSou10hcNBjl4=;
	b=QZQowJmzAF4kRAm/u+fwVL/3MCUCaQw/lNLGaVTNpKuUS85U4rNsUeehvAj1aoDn
	bR81+D2rbbvKfvrvJkk7erxFpbdgZN82FPvMhAXt9gJmZN5OUFh1Y0YJbPHdXD+Tpn8
	2GLScceQmwQ7in3BKbNGilhroZvPS71xEIW8Ygjc=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663678367411565.8783274784522; Tue, 20 Sep 2022 14:52:47 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220920125243.2880-1-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v8 0/7] mptcp: Fast Open Mechanism
Date: Tue, 20 Sep 2022 14:52:36 +0200
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

[PATCH v8] includes "client-server" partial support for:
1. MPTCP cookie request from client (seems OK).
2. MPTCP cookie offering from server (seems OK).
3. MPTCP SYN+DATA+COOKIE from client (seems OK).
4. subsequent write + read on the opened socket (seems OK).
=3D=3D=3DChanges between v7 and v8
- We change from 0impact approach on existing TCP code to
  full reusage of existing and available functions.
- Code is refactored (Max. reuse of existing linux kernel code).
- fastopen.c is reduced to minima.
- Other comments from mailing list are coming in the next version.
=3D=3D=3DFuture work
-Adress the appearance of "MPTCP FIN" as duplicated acks.
-Integrate presented in the last patch selftests.=20

Dmytro Shytyi (7):
  add mptcp_stream_connect to protocol.h
  add mptcp_setsockopt_fastopen
  reuse tcp_sendmsg_fastopen()
  mptfo variables for msk, options. Fix loop retrans
  Fix unxpctd val of subflow->map_seq(dscrd packet)
  add skb to mskq in tcp_fastopen_add_skb()
  selftests: mptfo initiator/listener

 include/net/tcp.h                             |  5 +-
 net/ipv4/tcp.c                                | 18 +++-
 net/ipv4/tcp_fastopen.c                       | 55 +++++++++--
 net/ipv4/tcp_input.c                          | 11 ++-
 net/mptcp/Makefile                            |  2 +-
 net/mptcp/fastopen.c                          | 46 +++++++++
 net/mptcp/options.c                           |  9 ++
 net/mptcp/protocol.c                          | 19 ++--
 net/mptcp/protocol.h                          | 14 ++-
 net/mptcp/sockopt.c                           |  3 +
 tools/testing/selftests/net/mptcp/mptfo.sh    | 13 +++
 .../selftests/net/mptcp/mptfo_initiator.c     | 41 ++++++++
 .../selftests/net/mptcp/mptfo_listener.c      | 98 +++++++++++++++++++
 13 files changed, 311 insertions(+), 23 deletions(-)
 create mode 100644 net/mptcp/fastopen.c
 create mode 100644 tools/testing/selftests/net/mptcp/mptfo.sh
 create mode 100644 tools/testing/selftests/net/mptcp/mptfo_initiator.c
 create mode 100644 tools/testing/selftests/net/mptcp/mptfo_listener.c

--=20
2.25.1


