Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232B57B
	for <mptcp@lists.linux.dev>; Fri, 23 Sep 2022 00:15:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1663892138; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=WXLO+y7ubqHJs45t7FyuxsXcRprbvKogjQXrMiCa33TlcTDbg5qiY03rvF2YCH0zBCNpM8RenI4fiaKNoWPBvCFzkokH93CdLHieZyqoSxML7gTq7EKBc0izGAsPfXXfGifYZQQVH6Jmqr7HrLdlyDLKCVshpgKBVmfu4NR6xLs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1663892138; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
	bh=xLTO5D4cZoZ1tpwI9w3uy7WkDCd8V9zFvXLo/ILlvPE=; 
	b=SKQQSibIJL0MoHBBz/2LBJCqcTEXZwjeUBLxYCI9QSmph22Qxe7vTQp8wvbCKRD9V+RYq+uIIdCG6wNptODIrQLMqQJHOijp5rfsFznwlZXgibZqIumpnxEo/BTMxI43+qTPIVR8hgat51CRaZyzYaRic971+5qlBtGvPburUys=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1663892138;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=xLTO5D4cZoZ1tpwI9w3uy7WkDCd8V9zFvXLo/ILlvPE=;
	b=f8pAujCtFpR0I4ZGrdH/KTWC8X/4VBd3rnY3pezK1G/ElJCU8N2xHGdqXIfEN+nZ
	wi5WRCC7OTnSPNovMZ5nIKOoTiM5PmLmoehUIVYzX8JLfXdhJbjF0UMEfCDSW81uT5h
	GYSNf/l9GgpVFjd8W0ARM+tnst4U8dhf/VURZ83s=
Received: from doris.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1663892136459751.3301645067417; Fri, 23 Sep 2022 02:15:36 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20220923001530.9722-1-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v10 0/3] mptcp: Fast Open Mechanism:
Date: Fri, 23 Sep 2022 02:15:27 +0200
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

Compared to the previous patches, these focus on the sender side.

Dmytro Shytyi (3):
  mptcp: add mptcp_setsockopt_fastopen
  mptcp: add mptcp_stream_connect to *.h
  mptcp: reuse tcp_sendmsg_fastopen()

 include/net/tcp.h    |  3 +++
 net/ipv4/tcp.c       | 23 ++++++++++++++++++-----
 net/mptcp/Makefile   |  2 +-
 net/mptcp/fastopen.c | 32 ++++++++++++++++++++++++++++++++
 net/mptcp/protocol.c | 22 ++++++++++++++++++----
 net/mptcp/protocol.h |  6 ++++++
 net/mptcp/sockopt.c  |  3 +++
 7 files changed, 81 insertions(+), 10 deletions(-)
 create mode 100644 net/mptcp/fastopen.c

--=20
2.25.1


