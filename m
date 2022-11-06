Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEB1291A
	for <mptcp@lists.linux.dev>; Sun,  6 Nov 2022 15:24:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1667748272; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=XbR//9T9pkgFJfIaCFMb/X6K/BvP4rRfdh6d7PC/raLXhnJkYUJ3LOF5hOF6v3oKACP1Fy2GL7nTrnd/vfFPyUBfdns7wemTfDA7X0YI4gYoXfzCXCBl88r2vLQaKOGZyNSX/akQTGJv9elsRIX7mx6n5nIf0AoA8goW23ir7lc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1667748272; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
	bh=6dMZY5UfJ3qIL6ecG14iPdwjCJMjJMZxVLZlW18C0hc=; 
	b=bGAzk6JXXGwSJbZogfosf9+42ug5o1TRH/qHKXbX90l4C5C402SKD5gHv2oAVNSENTjuR7eGO36Y7h5cgOTvQjwzCp/Gf3LdcnhqWClQjMiG+dqdF8LVIl1SOPQLk9CEqHHEf+SU1Qi3Ti9MfuUq9LgnfrCCOwCoWhzyJpJz4eY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=shytyi.net;
	spf=pass  smtp.mailfrom=dmytro@shytyi.net;
	dmarc=pass header.from=<dmytro@shytyi.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1667748272;
	s=hs; d=shytyi.net; i=dmytro@shytyi.net;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=6dMZY5UfJ3qIL6ecG14iPdwjCJMjJMZxVLZlW18C0hc=;
	b=TjhB950lHVzt5LQo+jiewyXoWD3T6oOy7feniJyI0f+l6OWVCQq/lmK6vIUGs6Qj
	yrjgMkIrQW49roboaQZ34+2yC/mvWfbULpNXaTobEjpuYH5VVtq9nnssytB6RUCF8zK
	CzZtzctQm08nUjcKEKe3K2r8RDeglm1abSDyJqoI=
Received: from localhost.localdomain (vps-940813d4.vps.ovh.net [198.244.188.50]) by mx.zoho.eu
	with SMTPS id 1667748269642405.62576879203186; Sun, 6 Nov 2022 16:24:29 +0100 (CET)
From: Dmytro Shytyi <dmytro@shytyi.net>
To: mptcp@lists.linux.dev
Cc: Dmytro Shytyi <dmytro@shytyi.net>
Message-ID: <20221106152411.655-1-dmytro@shytyi.net>
Subject: [RFC PATCH mptcp-next v15 0/5] mptcp: Fast Open Mechanism
Date: Sun,  6 Nov 2022 15:24:06 +0000
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
v14 -> v15:
 - Reduce code size to perform MPTFO selftests. Reuse run_tests_lo().
 - In v15 proposed change of selftests introduce a reproducible issue.

Observed behavior:=20
# INFO: with MPTFO start
# ns2 MPTCP -> ns1 (10.0.1.1:10054      ) MPTCP (duration    81ms) [ OK ]
# ns2 MPTCP -> ns1 (10.0.1.1:10055      ) MPTCP (duration    85ms) [ FAIL ]=
 file received by server does not match (in, out):
# -rw------- 1 root root 4561948 Nov  6 14:44 /tmp/tmp.9LKqAENkkp
# Trailing bytes are:
# MPTCP_TEST_FILE_END_MARKER
# -rw------- 1 root root 4560528 Nov  6 14:46 /tmp/tmp.sZoeneg8ix
# Trailing bytes are:
# MPTCP_TEST_FILE_END_MARKER

Analysis:
- It seems like at the second round when data supposed to be sent in SYN, o=
utput data misses first 1420 bytes, that should be a part of the [Syn] pack=
et.=20
- With local tests (without selftest) the server in userspace receives the =
data in the SYN during the second round.
- To confirm that data is sent in SYN, the tcpdump was launched during test=
s (context of tests with tcpdump: in func sock_connect_mptcp the var was ch=
anged: char wbuf[8192] to char wbuf[511] for observavility purposes.
Output of pcap is presented below.
root@9a011dab3a59:/mnt/mptcp_net-next/tools/testing/selftests/net/mptcp# tc=
pdump -r 635ee290-Fz3fsx-ns2-ns1-MPTCP-MPTCP-10.0.1.1-10042-listener.pcap |=
 grep -w "[S]"
reading from file 635ee290-Fz3fsx-ns2-ns1-MPTCP-MPTCP-10.0.1.1-10042-listen=
er.pcap, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 65535
20:51:50.770789 sit0  In  IP 10.0.1.2.32944 > 10.0.1.1.10042: Flags [S], se=
q 980486723, win 64240, options [mss 1460,sackOK,TS val 2478157679 ecr 0,no=
p,wscale 7,tfo  cookiereq,nop,nop,mptcp capable v1], length 0
20:51:50.770807 sit0  Out IP 10.0.1.1.10042 > 10.0.1.2.32944: Flags [S.], s=
eq 1788401934, ack 980486724, win 65160, options [mss 1460,nop,nop,sackOK,n=
op,wscale 7,tfo  cookie de367be85d45564d,nop,nop,mptcp capable v1 {0x2b0209=
6a5416249e}], length 0
root@9a011dab3a59:/mnt/mptcp_net-next/tools/testing/selftests/net/mptcp# tc=
pdump -r 635ee290-Fz3fsx-ns2-ns1-MPTCP-MPTCP-10.0.1.1-10043-listener.pcap |=
 grep -w "[S]"
reading from file 635ee290-Fz3fsx-ns2-ns1-MPTCP-MPTCP-10.0.1.1-10043-listen=
er.pcap, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 65535
20:51:53.766945 sit0  In  IP 10.0.1.2.50620 > 10.0.1.1.10043: Flags [S], se=
q 831892394:831892905, win 64240, options [mss 1460,sackOK,TS val 247816067=
5 ecr 0,nop,wscale 7,tfo  cookie de367be85d45564d,nop,nop,mptcp capable v1]=
, length 511
20:51:53.766965 sit0  Out IP 10.0.1.1.10043 > 10.0.1.2.50620: Flags [S.], s=
eq 4054084662, ack 831892906, win 65160, options [mss 1460,sackOK,TS val 19=
54362321 ecr 2478160675,nop,wscale 7,mptcp capable v1 {0x7bf8471b32013c7d}]=
, length 0
root@9a011dab3a59:/mnt/mptcp_net-next/tools/testing/selftests/net/mptcp# tc=
pdump -r 635ee290-Fz3fsx-ns2-ns1-MPTCP-MPTCP-10.0.1.1-10044-listener.pcap |=
 grep -w "[S]"
reading from file 635ee290-Fz3fsx-ns2-ns1-MPTCP-MPTCP-10.0.1.1-10044-listen=
er.pcap, link-type LINUX_SLL2 (Linux cooked v2), snapshot length 65535
20:51:57.084750 sit0  In  IP 10.0.1.2.43624 > 10.0.1.1.10044: Flags [S], se=
q 835270974:835271485, win 64240, options [mss 1460,sackOK,TS val 247816399=
3 ecr 0,nop,wscale 7,tfo  cookie de367be85d45564d,nop,nop,mptcp capable v1]=
, length 511
20:51:57.084772 sit0  Out IP 10.0.1.1.10044 > 10.0.1.2.43624: Flags [S.], s=
eq 650287874, ack 835271486, win 65160, options [mss 1460,sackOK,TS val 195=
4365639 ecr 2478163993,nop,wscale 7,mptcp capable v1 {0x7b3cb5cf253aec1b}],=
 length 0

---

Dmytro Shytyi (5):
  mptcp: introduce MSG_FASTOPEN flag
  mptcp: implement delayed seq generation for passive fastopen
  mptcp: add subflow_v(4,6)_send_synack()
  mptcp: add TCP_FASTOPEN sock option
  selftests: mptcp: mptfo Initiator/Listener

 net/mptcp/Makefile                            |   2 +-
 net/mptcp/fastopen.c                          |  66 ++++++++++
 net/mptcp/options.c                           |   5 +
 net/mptcp/protocol.c                          |  20 +--
 net/mptcp/protocol.h                          |  18 +++
 net/mptcp/sockopt.c                           |   5 +-
 net/mptcp/subflow.c                           |  42 ++++++
 .../selftests/net/mptcp/mptcp_connect.c       | 121 +++++++++++++-----
 .../selftests/net/mptcp/mptcp_connect.sh      |  21 +++
 9 files changed, 253 insertions(+), 47 deletions(-)
 create mode 100644 net/mptcp/fastopen.c

--=20
2.34.1


