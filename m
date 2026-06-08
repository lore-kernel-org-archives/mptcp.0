Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8368838C406
	for <mptcp@lists.linux.dev>; Mon,  8 Jun 2026 09:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780910132; cv=none; b=DN4OhobqjMUJcIR1gB7sB7NGkDVk3SV00/g4C9vKidXymBRduv8FLjn47UHKTxuQE1WSmROj9Xs1UwGrtCHS6gac8JOJ8f8SyDIe99temDxZXOWv2z74aeE5cZt1trNr1QijWFNjzJAdI/9D9Z3YQYt+CDqUK7amwRd9H5/21/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780910132; c=relaxed/simple;
	bh=cWHBd8AEprJyeVakCZZ70IyT0SYRxUkLzYfpNT9qDX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PBL+s/3nNM9kVGpR/vaERDB3Sglz4yZCqGZKPYMWoPB1pcvKLmLzIU47sfZ344fk4bUFF+7qsddKxHADIIbSA1EFnAaMeYEZu5Q6x1sO3G5Fpk5Zc3BfbWfT1H75Re4yCAXQFwGQS7uon+e+w+8Xlg/SeYjtVQy0NPhETK//Lnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3JTDTTA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3JTDTTA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D7D1F00893;
	Mon,  8 Jun 2026 09:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780910131;
	bh=fMFzg638xkTZz2exPL4yRHGjFsEfTTN0OCAhl4cfVIw=;
	h=From:To:Cc:Subject:Date;
	b=K3JTDTTARQAgJ38y8wEU6cDkxRaxPnA8et9XnZZRZ594fm+bXlrYCYjE6IquScgCh
	 f3sCjxKPMAucTEmamZbOizpyeg1/4Mz0eH/hegMZZoeikBua9jPSRFYnfx87RW0xo8
	 jlcTVjA/VdVMuPkgAUJNPp/dr8p652d3n/sBBK0IW+PNCNHbZauwDHZ9We/IN/I81B
	 PqjSoEJSRY5w5EriKW5ri+QfT2j0eT71VkMveRvXvDi7BHjxyRh8Ocp9ody0fVOO7C
	 FUI6UTvxpx5B5Bcl38gcueY17+FhZE7RtVApFaGDNlv5MRqreRl68KAbsZ4Ci1BtYh
	 G35YKfmQn7fCA==
From: Geliang Tang <geliang@kernel.org>
To: mptcp@lists.linux.dev
Cc: Geliang Tang <tanggeliang@kylinos.cn>
Subject: [PATCH mptcp-next v3 0/2] implement .splice_eof
Date: Mon,  8 Jun 2026 17:15:19 +0800
Message-ID: <cover.1780909894.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - drop do_tcp_splice_eof helper.
 - invoke __mptcp_push_pending in mptcp_splice_eof.
 - use lock_sock_nested in mptcp_splice_eof.
 - set splice_eof in mptcp_v6_stream_ops too.

RESEND:
 - to trigger ai review.
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1773740361.git.tanggeliang@kylinos.cn/

v2:
 - add sk_state check in mptcp_splice_eof. (Matt)
 - call mptcp_rps_record_subflows in mptcp_splice_eof. (Matt)
 - update commit logs.

This set implements .splice_eof for MPTCP and tests it.

v1:
 - Link: https://patchwork.kernel.org/project/mptcp/cover/cover.1770023932.git.tanggeliang@kylinos.cn/

Geliang Tang (2):
  mptcp: implement .splice_eof
  selftests: mptcp: connect: trigger splice_eof

 net/mptcp/protocol.c                          | 31 +++++++++++++++++++
 .../selftests/net/mptcp/mptcp_connect.c       |  2 +-
 2 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.43.0

