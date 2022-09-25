Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4B64682
	for <mptcp@lists.linux.dev>; Sun, 25 Sep 2022 23:26:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664148366; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Y9eDWX3dKl2i5EcJLBjIGpvLOKV+JW1YR0crRbEoc4A53o7jLYCXAFci6uz8W6bCHg+kbbEXoslY7D2oVe2pmddqhpo8asmKwq8qMCUr6pEwH1su343d2DwYZ5zRXyi9Jf3cm1jNHVa+0JzyeFfXZIZjza4KpsXhEEvnIh/SjoU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664148366; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
	bh=ZWmSmSWCEUGkFHMkAmMbeR4tT+kZrN/8PxHc/Kty1FI=; 
	b=H96J14Bcbg4z+TrXeiaXYTMyNgenaGYdb8wo3Io4E3IrKPJFdWZkYEk2q8XAQBf1fZbFcqe50Who7RiwW8HEb71Pa3JwVnrAwxEBCmYRxWszy1fPZbCFQ2cN1oYleuGR+iueQkb70efonbfTzYEllsjFzo+Rz+ZlrOmVwPZ6+po=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664148366;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=ZWmSmSWCEUGkFHMkAmMbeR4tT+kZrN/8PxHc/Kty1FI=;
	b=HPS19QmmT5dVg8m+QYHk3ul+kic9iWnPAD41WuKJ2yRJlMM9dp4eEU7axCX5AweE
	dpD5AuYCxOMJT9rNcp/YN9640AurlkED1cIB+ZpWHiwOZvAepPY7i9L7ayvf3A0t0R2
	PiHKh1WsZ5ZJGutNdv0TIAcSExncx7LkdsFKZPJc=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 166414836495953.164129838644726; Mon, 26 Sep 2022 01:26:04 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220925232601.25252-1-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v11 0/4] mptcp: Fast Open: Initiator
Date: Mon, 26 Sep 2022 01:25:57 +0200
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

These patches focus on the Initiator side.
These patches implement: sendto(..., ..., ..., MSG_FASTOPEN, ..., ...);
We would like to credit Paulo Abeni, Mat Martineau, Matthieu Baerts and
Benjamin Hesmans for advices and ideas that improved these patches.
Without this collaboration this state of work would not be presented.

Origins of these patches were in the root of discovery of the
possibility to _reuse the TCP FASTOPEN option in the linux
upstream MPTCP_ (First commit was sent to the mailing list on 22 OCT=20
2021: see https://lore.kernel.org/mptcp/
17ca66cd439.10a0a3ce11621928.1543611905599720914@shytyi.net/').

Dmytro Shytyi (4):
  mptcp: add mptcp_setsockopt_fastopen
  mptcp: add mptcp_stream_connect to *.h
  mptcp: add mptcp_subflow_conn_sock()
  mptcp: reuse tcp_sendmsg_fastopen()

 include/net/mptcp.h  |  9 +++++++++
 include/net/tcp.h    |  3 +++
 net/ipv4/tcp.c       | 21 ++++++++++++++++-----
 net/mptcp/Makefile   |  2 +-
 net/mptcp/fastopen.c | 37 +++++++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c | 35 +++++++++++++++++++++++++++++++----
 net/mptcp/protocol.h |  5 +++++
 net/mptcp/sockopt.c  |  3 +++
 8 files changed, 105 insertions(+), 10 deletions(-)
 create mode 100644 net/mptcp/fastopen.c

--=20
2.25.1


