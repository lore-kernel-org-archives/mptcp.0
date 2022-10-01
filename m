Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02DA1FBA
	for <mptcp@lists.linux.dev>; Sat,  1 Oct 2022 03:15:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1664594116; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=AUgsq7K/mhkFgE/zJlrB00ikxQFDDBtjUX+tRB4H0wSyw/LaVx27lcr3+K6rcTbMweCe4KFxrbbAreOZbHvafduUzbgIk7pBpvQjdM8MkGjXp6GMPU3yNZjynkUrkY/WswTfvlQfPM1ROOvS/fVwyuooHmtz1Jvg5hWPDztah8A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1664594116; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
	bh=2ponHxMUg8t0PdLk1Z1iU/btOATCR1AfVB6XpGNTSng=; 
	b=Lk1e6+vWqhU7GRoXD2cbHHmYcL1sC6jk03eB6BR+JZsSXrhn7ewbgB6Cs5c1ZW8HYj5HtYf/b+AcTQUOxPxZqEN3UdnTzOsB8ViQ7ZX8elrozBLBtHaG6pNDUfIlwtJn45LsHD74O0ZEjbTPNcuQJuINgN/5ojvH+L15pdnsH9M=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1664594116;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=2ponHxMUg8t0PdLk1Z1iU/btOATCR1AfVB6XpGNTSng=;
	b=C/Hh00URDtd4JlzG6KuoMJYV85x2S7y7CtpPmuGOo60SSu+k/OoWelIdMcY5XSEO
	FUVlE+/dVq4cD3/YzJvwG+vt7S6TChSZcsGnOimLSH/hMULPqnY0EAlCzO5u5wVAaP1
	qWuTvIXJZ1zdlThT6jbc9GC3nYvsei3D0CtHaPko=
Received: from localhost.localdomain (243.34.22.93.rev.sfr.net [93.22.34.243]) by mx.zoho.eu
	with SMTPS id 1664594115147870.075323181002; Sat, 1 Oct 2022 05:15:15 +0200 (CEST)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20221001031502.29152-1-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v13 0/7] mptcp: Fast Open Mechanism
Date: Sat,  1 Oct 2022 03:14:55 +0000
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

Dmytro Shytyi (7):
  mptcp: add __mptcp_pre_connect() helper
  mptcp: add __mptcp_stream_connect() helper
  mptcp: introduce MSG_FASTOPEN flag.
  mptcp: implement delayed seq generation for passive fastopen
  mptcp: add subflow_v(4,6)_send_synack()
  mptcp: add TCP_FASTOPEN sock option
  selftests: mptfo initiator/listener

 net/mptcp/Makefile                            |   2 +-
 net/mptcp/fastopen.c                          |  96 +++++++++++++++++
 net/mptcp/options.c                           |   5 +
 net/mptcp/protocol.c                          |  64 +++++++----
 net/mptcp/protocol.h                          |  13 +++
 net/mptcp/sockopt.c                           |   5 +-
 net/mptcp/subflow.c                           |  42 ++++++++
 tools/testing/selftests/net/mptcp/mptfo.sh    |  13 +++
 .../selftests/net/mptcp/mptfo_initiator.c     |  43 ++++++++
 .../selftests/net/mptcp/mptfo_listener.c      | 100 ++++++++++++++++++
 10 files changed, 360 insertions(+), 23 deletions(-)
 create mode 100644 net/mptcp/fastopen.c
 create mode 100644 tools/testing/selftests/net/mptcp/mptfo.sh
 create mode 100644 tools/testing/selftests/net/mptcp/mptfo_initiator.c
 create mode 100644 tools/testing/selftests/net/mptcp/mptfo_listener.c

--=20
2.34.1


