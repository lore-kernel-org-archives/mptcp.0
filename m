Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795815485;
	b=OIk1N3J4g1uoevRJcaJ7OKEMCreuNf8ub+cV3xRssCu1jEy+vrESFkvvqUMiiZwJNxKa
	 CAc2fA5qMRG44o/OrQjlwnkcwuNcunOp9FcsGK0INBNl8GUoCQ5TWATe6lPgrH5b7Vi3D
	 NBkuRlP35R2Dzjb5eIYqmG2chHq3ukTWQUASKPOphElabo/bN5fTCwVMdvUFpex6Cxc+B
	 tZEJwPhqh6tv7HdbsvzheSpviP6+LyFyXIpLHLUzmFxvcrv+9L1Q6YVIqzSWgICgj9HvW
	 etlhmvaZO5PFny4YbjBlwD/dKe1LV8ISlFUpfElTvgMWkSnmS3hCnpS55xCMWb9FD5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795815485;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=5Tyjug1HXAO8p9JtbK3tNaWqFP2zoj73Dx5OEOiGp8g=;
	b=QZn4Z/79tKjEcM1mMPxZpuCyn8nzkhWDWn99t4hU7XIutu3HrrWLp/WWPn+9ekWxe+6r
	 9Vcs13L7um+WJMBKqdfM4gSFXws/WCaZP3iO3JoyM/3zLIPaw19CgQiYcFtiCLH+LKpup
	 GQozINPP2VluryFxYPXJTYBSa8o0hV83wPSq6yGd5BNU7M+OjhPp7MrIGv/cbqoh8kAGW
	 fj1YtutFVqNacBFYrqsrfavwEkmx04rxoa4ckweUNFiQMV277vnpbJWr2D1Hm1z7AfRRG
	 3Tf2tUvVErsordkViSV/Q1XwvG1jqHCH1je53z0x8SlSuMK23Cpb/hboVtbROhlL99Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FB2+MAlY;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC41B606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 21:38:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC41B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FB2+MAlY
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-386c336eab8so4983996eec.0
        for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 13:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795815484; x=1796420284; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Tyjug1HXAO8p9JtbK3tNaWqFP2zoj73Dx5OEOiGp8g=;
        b=FB2+MAlYX5Zy5VifBdqXncmgTz7/DtmvkEJVXtineAVmngwD0deRbotIdVsI51ZaY/
         tqfSpDcPkqx8QX3NYh2gbEGoQeLeFfxaGIs6eUjQ+M9Sqo/rdtagNTEJgyAg0QQ+Xz41
         fbqjtEsfSp5ST0UQirFivA+VcbWRR7HFJC7qN4X95/7LlAbDeKORwDTwV1pzzbEYm9Jy
         yTEmEDcWNsRuVFNK/hLkM0hxgW/JFHpLoKVZmHzSdaZzyVWhkzzLA/QINdkei0fx2zDp
         GUcml6N12LdCdb1oAUz85qn3V5wnB+9FbNVFTWObyyJDHbZ9sO8bQEkLs7RrcRcm+KCE
         q63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795815484; x=1796420284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Tyjug1HXAO8p9JtbK3tNaWqFP2zoj73Dx5OEOiGp8g=;
        b=SkIuIZzjdHhUjC362EPPP7TYxoZxrlVRlFtXv1Sz+8D1LwYBKlk8LbF5OOUnidRQRr
         Tf4eDMhVj5pWWGasSuinco1BA7KXh6MwyBlnTvcRO2BsKc4F2h5ZTELhKUBJz0y3SKn5
         ieatWk8P1y9M1ndiJzxeZan9AJWJE1ltAFi9pjP5CLr7sBFyQx011OeAGjU/VpfxdXHJ
         RDDTTOqaPz+FQ/Log0cHrRIw32O5b4NagEBG3kxwuvaG2EL6VyULx0iLBjQBmqrGF2JV
         qbIjzRulmYr03/+4MF6VlahxMlHM5guSX7SVCF9QF3fM58yqLrcXEjElR6N5p5JgQuFX
         hF7w==
X-Gm-Message-State: APuU4Z87LF5eAEIp+6GTP3WJZBp6DWXyL1FqXUc6uLjvIeN6wbwvHQuE
	mcnd0AhE69wC3IZ427t1ITpxgVk9Aiak7V6sFoCa9c13Wk69GuYiPTM0oAtQEA==
X-Gm-Gg: AZFdTZdKHnoZhApVn9sRYEWdrAfJsuuTtQVRckGoeemRpRc2lalnTbzpp9hz4tBODtt
	j4yaLy6SpDDQMALA6iEqznJFSCnCTOWRj1oLLG+OjADeTx2UfSBJb5TkT4pMOX2VRm1c256vYcg
	eCAFGZ/GOQ6DKxnZg9dvINzy5isXXNaF9umVJrDZxVtSIUdxtNs2JaCnGOWl7IUDMMyf5n2YM36
	zDL2X5KyT2d3MRbBSZ22G05hhSCDT3Wm1vNkWSeotkF3mmSoGZ4O8OAvRqGd25JdwDQx3D1Hjcb
	db6UHyVpZE+Sb/8Ka0hApRTcNpl38G+Fdum11ZMXlw1iPWqxn+FNZFEjOrG1Zi9Yp6Qcr0ANucB
	i9/VVPiBh2Xxv1aEGO10b+YOfao/71yEkrVjLWUGGzeg1+yR68O/UfSl8l3JoJhy+51o5M1TJFi
	rn9qevbx9/qaeR5VDUv2DXpJhTjNmn/OFChDU1g5sNENrC1Jgr7N+z714PDtVcEJL1swwpoQOWA
	5VMm4vDAMJmk3y4DUilgm926FimVELThwtIOzz//dT12Ixi8NjcBDs+Pmxgo3iTzy40+j7SFjtH
	A7awtqXrkTJcRpCNI9Zq/GM53cf5FrCr5JQ=
X-Received: by 2002:a05:701b:4588:10b0:1b2:6b17:28e6 with SMTP id a92af1059eb24-1b5568c3439mr22943519c88.9.1795815483515;
        Fri, 27 Nov 2026 13:38:03 -0800 (PST)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567ff27bsm67825547c88.6.2026.11.27.13.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 13:38:03 -0800 (PST)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Mohit P. Tahiliani" <tahiliani@nitk.edu.in>,
	Gang Yan <gang.yan@linux.dev>
Subject: [PATCH mptcp-net v10 0/2] mptcp: pm: in-kernel: fullmesh: re-add of the initial subflow endp
Date: Fri, 27 Nov 2026 21:37:54 +0000
Message-ID: <20261127213756.4154872-1-w453y.me@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With fullmesh endpoints, removing and re-adding the endpoint used by the
initial subflow never creates a new subflow from it: the closed initial
subflow stays in the conn_list, and makes the PM think the remote ID 0
is already used, or picks its reset remote address. If the initial
subflow was the only one, no address is left for the remote ID 0 at all.

Patch 1 fixes that, patch 2 adds tests for it.

Found with a router flapping one of its links: the link carrying the
initial subflow never rejoined the existing connections. Tested on top
of export-net: the new tests fail without patch 1, and the whole
mptcp_join.sh passes with it.

Changes in v10, after the review of v9 by Gang and Matthieu:
- Patch 1: use fill_remote_addr() for the remote ID 0 fallback, instead
  of duplicating it.
- Patch 1: drop the comment above mptcp_subflow_is_closed(), and shorten
  the one above the fallback.
- Rebased on top of export-net.
- v9: https://lore.kernel.org/mptcp/20261126101818.3916631-1-w453y.me@gmail.com/

Changes in v9, after the review of v8 by Matthieu:
- Patch 2: drop the test adding another endpoint after the removal of
  the initial one: it already passed without patch 1.
- Patch 2: merge the test with the initial subflow alone into the first
  one, to save the setup time: after the re-add, both endpoints are
  removed, then the initial one is re-added alone.
- Rebased on top of export-net.
- v8: https://lore.kernel.org/mptcp/20261024111842.1069878-1-w453y.me@gmail.com/

Changes in v8, after the review of v7 by Sashiko on mptcp and on netdev,
and the MPTCP CI:
- Patch 2: use nftables in the "after reset" test, as the rest of
  mptcp_join.sh does now: export-net also got be3b69f3cedf, so
  ${iptables} was empty there too, and the test failed on v7.
- Patch 2: stop the transfer and the event listeners before marking that
  test as skipped: when all features are expected, the skip exits.
- v7: https://lore.kernel.org/mptcp/20261023110321.403874-1-w453y.me@gmail.com/

Changes in v7, after the review of v6 by Sashiko on netdev:
- Patch 2: in the two tests with the initial subflow alone, wait until
  the PM worker has accounted the initial subflow endpoint before
  removing it: a join on a third endpoint is created in the same worker
  run, then that endpoint is removed. v6 only detected the race.
- Patch 2: wait a bit before counting the subflows after the removal,
  as the other tests do: the closed subflow can still be listed.
- v6: https://lore.kernel.org/mptcp/20261022085041.211318-1-w453y.me@gmail.com/

Changes in v6, after the review of v5 by Sashiko on netdev:
- Patch 1: in the commit message, the closed initial subflow keeps its
  remote address: only the destination port is zeroed, not the address.
- Patch 2: skip the "after reset" test if the iptables rule cannot be
  added, instead of passing, and check that the reset closed the
  subflow.
- Patch 2: in the two tests with the initial subflow alone, check it is
  gone after the removal of its endpoint: the ESTABLISHED event comes
  before the PM worker accounts that endpoint, so a removal right after
  it can miss the subflow.
- v5: https://lore.kernel.org/mptcp/20261021070324.50533-1-w453y.me@gmail.com/

Changes in v5:
- Patch 1: when no subflow is left to take the remote ID 0 address from,
  use the remote address of the MPTCP socket, as fill_remote_addr()
  does. Without it, v4 also broke adding another endpoint after the
  removal of the initial one, when it was the only subflow (Sashiko on
  netdev).
- Patch 2: add two tests for the initial subflow alone: re-adding its
  endpoint, and adding another endpoint.
- v4: https://lore.kernel.org/mptcp/20261019190558.465270-1-w453y.me@gmail.com/

Changes in v4:
- Patch 2: only check the joins when the iptables rule has been added
  (Sashiko).
- v3: https://lore.kernel.org/mptcp/20261019185512.458313-1-w453y.me@gmail.com/

Changes in v3:
- Patch 2: use iptables instead of init_nftables(), which is only in
  net-next (Sashiko).
- v2: https://lore.kernel.org/mptcp/20261019180306.382039-1-w453y.me@gmail.com/

Changes in v2:
- Patch 1: also skip the subflows in TCP_CLOSE: the initial subflow can
  be disconnected and its context reset, clearing the 'closing' flag and
  zeroing its remote address (Sashiko).
- Patch 2: validate this case too, by resetting the initial subflow
  before removing its endpoint.
- v1: https://lore.kernel.org/mptcp/20261019170751.200446-1-w453y.me@gmail.com/

Abdul Wasey (2):
  mptcp: pm: in-kernel: fullmesh: skip closed subflows
  selftests: mptcp: join: re-add the initial subflow endp with fullmesh

 net/mptcp/pm_kernel.c                         | 21 ++++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 79 +++++++++++++++++++
 2 files changed, 99 insertions(+), 1 deletion(-)

-- 
2.43.0

