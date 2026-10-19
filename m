Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432993;
	b=X+Zk7xg0ANx1n9393VIwOk+i2cJXhIfBYNeOhzBFNGuCux4Evj1ya9uyJ4wquU/0zlQS
	 vWWX8FCpntmFsuGkgCVdqv0bZD6a+DnkS/EK+DLSiFxrP8apM37F8AL/su3bN+9SO9gIb
	 Ge5AGSNcxTB7KPZ7u556Ilp51wYOvigmRLre0/xPxvnGqXPD33Y3DiSzqESagbNSMZS0G
	 FTrFV5lCOYzKFJVsHPM+3qACHjtCxyqo3glC+YYZHPkbexktDeWFEqTOKP/MRb3V1f09e
	 0hT39RTUWyfaYmrNK7H6iQ+Dx/hJIveSnbaKzbdW6dtrKxkJFN75ze8YBgQgRUXbprw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432993;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ue2+5jvwOdOOfjIA59IBRoMSh9MNJhMOHGs/BOw+LtM=;
	b=3T2VZWIN7PO7/djAS6FKXusIPm8k3Sk8ZyWhorE1CXMd+TrvpFBK3fQnfzXwcHv1r7WD
	 MEJQkkRRzY2pFsXMI5mzN1mgcyp8dqgrF4mpb7A0xqTSNrEHJfp1iCZ9ho+cI5BQ9+KZ5
	 6uCBtR+Xbdt3poukpZg/+y5lfHM7/QKHE+oMKpnqqE7UGKVNQUQTu98748VLnV03UHw7X
	 zqGbG8cUkSI3vKSHqbf8al5oxJRoW6HigawMC3NQ65KNMaIluFwte6HGzm062UoN10XNg
	 wY4J2JH088QXkx2EGrCIXzEkhPf7wKTWOMn1vc1C7k2Codm3ngj7HN/33IMSLNOeP8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RXdmvkjF;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC867606A319
	for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 18:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC867606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RXdmvkjF
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-16079d54c17so5256023c88.0
        for <mptcp@lists.linux.dev>; Mon, 19 Oct 2026 11:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792432992; x=1793037792; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ue2+5jvwOdOOfjIA59IBRoMSh9MNJhMOHGs/BOw+LtM=;
        b=RXdmvkjF1Nv3OFpU+kkX+/OxOGtyngmTKoRwRVMOAstt8YtbVBANTuQl5Bwp6NqMTr
         OK+RHnnTvNAbIe0VwvSNnbAb06dVU15V3rYcfsH/D5ZvozBzq0VKVyvusLs/GlDe/WWl
         rbQg4J12SMWpt6vL7VDgo4gOtW0l6sDhw75CvFZn+xoeLTKKnwBPprxoI6Y+xA2SZa9b
         xlPu6M/SYDj9PBbxWoaQu3YwiNlVoLutm8phlJittugKEb1ojMu2+DvN0AhRx8UEbS5m
         azo5c85pYB2nMd5L01oFH8RpxYCfdWIgI7l/CRVKLiO1hqaiQ8t3JUhrbACjKT1AKc72
         aPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792432992; x=1793037792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ue2+5jvwOdOOfjIA59IBRoMSh9MNJhMOHGs/BOw+LtM=;
        b=sO03O/5BXjBhH3AvCVo4S2vyu5xIFTUScYUVn9Y9gGQMGdEcBQ8FlbuWjnKm2N51ny
         UI3kj6RdjOnp3NAeXP4cOWZzRECRHoR6GBTUW1PzDbII6MwNqLIePp5AKR2vX/Nic1Dy
         9ORjN3yfpQSXRdDxAWetSqUsSq07ms1RX6Zz9G+lflk1hxTYjWt12dV7Eyfouxa+Cw9P
         A9nOBHtS+tTpHd45K2NFsn1O/KQ+v4F3EeTQ54nfMklG8nbuH/xo8jbh7H/zB3xF3+G/
         ZgQeOUHuVTXohD9p3CMfq31zCZgLlj5gUQRawiv7bBs9VWSyXol9JkR7pXhzWKqRc3e8
         coaw==
X-Gm-Message-State: AFq9FYKAdIa7hg6pP8riXrp3eqCcaxUOPRY5TLk+3BVlWl+6PDA6qtG7
	xSM1WWs36KD6bHaRcUs8/kSySbvW8x8kxbbYkhBOnZBG9lcL5PxROw7EmPAEPA==
X-Gm-Gg: AYBFou1ak+GId3MlFL+TuCH3qHqzaUJwK67eDPFB3XD08zF38uAqCqop+Ou3RuHdPVl
	5dKpIj4HdwcBKoQjxUypXypgYn3L5w2EhpW8Ve/0FcNuSueqPgC5A89yxQGATQgjk/qjua3E0RW
	N3iS3IrtetsZYEQDCdYzlf2S+gMbBPr6wV0NipI1OzFmO148kQycZjE/OZZPa8q/PkvAFYjBNvt
	T8BHmT4kaepdeixBcgZpJqBBJITtwfC+LhBiPB/oLYg3CWD0x8I9vIfAY2Kpr/KZeoMSmmpiwx6
	SwGjH/y6PqNdA+SwWTwgXMVLHA0KKvaYacmSMTJGMVo0jG8zrU9vatxfmyEjtfwlKYmEjBkc91o
	rOYaLMoKGmxCwuw+jeQnFfxSCM9POitQaLtteaVx2AfC/5S/YHS0qN3ZY4aHlv6i2mXLB2n2Rhk
	3xxltb6LBF2nIDR0er2QEmYRVhQxbr15r9WaG/EF47spMigCTNKPaUnxj0XgQJ3VMCZTgBtos7H
	juQ+UXI7omdFfKRKA==
X-Received: by 2002:a05:701b:4346:b0:151:2e62:fe5b with SMTP id a92af1059eb24-18512b42d3cmr12669404c88.22.1792432991468;
        Mon, 19 Oct 2026 11:03:11 -0700 (PDT)
Received: from vscode-11-19.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-18319d3b880sm28400604c88.10.2026.10.19.11.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 11:03:10 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-net v2 0/2] mptcp: pm: in-kernel: fullmesh: re-add of the initial subflow endp
Date: Mon, 19 Oct 2026 18:03:03 +0000
Message-ID: <20261019180306.382039-1-w453y.me@gmail.com>
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
is already used, or picks its reset remote address.

Patch 1 fixes that, patch 2 adds tests for it.

Found with a router flapping one of its links: the link carrying the
initial subflow never rejoined the existing connections. Tested on top
of the export branch (they also apply on export-net): the new tests fail
without patch 1, and the whole mptcp_join.sh passes with it.

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

 net/mptcp/pm_kernel.c                         | 19 +++++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 64 +++++++++++++++++++
 2 files changed, 82 insertions(+), 1 deletion(-)

-- 
2.43.0

