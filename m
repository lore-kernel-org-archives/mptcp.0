Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792566211;
	b=bf8kMEOI3vDHSz652CxOaQqBFF9ByTWx+Hg+SdxWlEqSkXrATTIPpgfhlk13Am3560Xn
	 JLA4vzwPR8ydKSFZNtNTMJ73PjEumVJP0qbf29vF5SBeMiBzBvPhz9UMBhqku3gyl1YEf
	 IV6GWwvn9LSx0W6wFi9zCar2f5mxkvH3CvebGwI93F/7rRM5wA+aQsHYegX8RaunXMaB7
	 /1atj+/MXCbZLv056Io0svQMRYdSk1e3U89gK/vBKa70LNo59G6U+zgJchYmScqBxKyYB
	 OAFw7f9bfj291dfaWpmvfTv7gmyON+5I5livvRNzEw1nvOivRgaare+hCtOqIE9ofmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=T5CTsJvIdrQrEx5pVM217SrtHPKQQ0RoBTVVrNwpDu4=;
	b=NnOR2J/MZDg9WN1UzAn10OfIec7YHxmFcOYiZu3EQ/eU4RTrMp9CzNGZXPBpavHHEZqB
	 +2gKvYraUMYFxrC58aua3w5bmBQVghe7VoeS2zaJQItaVMsIBhKl8THmV7fl6um2DtRJ4
	 Dr3uwHBz2L30jda8z/WqwbyfVitPNXtFBoxTWaixpDLPtGed3M4KTFn7tEkkSi7vOIY2B
	 6U0VyaSzYmF1ojgo9Vf38DXOTPLLNVYxi5YHGTdNG4chbuD50P7yFKAgDkrZF2rmOoWan
	 DN8dvc4qF7fhfJnjm9SUhcV3fDOru10qaTxM6yC+lpzpHsuIM9lleBK8VsrflVdX/9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ONGOrO6O;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D00606A319
	for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 07:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62D00606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ONGOrO6O
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3282db206d3so937320eec.0
        for <mptcp@lists.linux.dev>; Wed, 21 Oct 2026 00:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792566210; x=1793171010; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T5CTsJvIdrQrEx5pVM217SrtHPKQQ0RoBTVVrNwpDu4=;
        b=ONGOrO6O4IavRuOuFUACBHxNj8AZgaMyUmmy8b9E+4ByKhwAgEHYCMNZgTsWTonnmY
         VnsxvqUbMSOZ+a4pjvVFwhmp8YpjIRXU3MFEUzZxEMt5qB+SBjny83QnuWMSpsp4OsZC
         U+2aOMF7hBqfPZ0vMuDhM9GoNUrBzkieTaTyVP86PXyvZbw7RDwsiHvMG/wCcPyeyht1
         9UlPK0UmBp+vDunvYreYj95B9zYOacGdJUODn08ZvASfp3c12X47zZENq3vCb+CY3L3i
         jInnPq1/QehmxbB9x7RVmg7FmU7dPad098Zu89bh6FDSliwuUDTpMIOFkySIutgwgkni
         iVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792566210; x=1793171010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T5CTsJvIdrQrEx5pVM217SrtHPKQQ0RoBTVVrNwpDu4=;
        b=kMCUKeAmtMivzPm2aUFAPX+wpExeF/fkxVgoKEX6B2bmH8W01HDlsDipjJnPxsB8Gc
         u7rInmbJof+UItuUYBZU+Xad0bF+BQ8m7aT1z9SyKJIU7MNmRIm/sKM3RbKGYpsQn+9f
         y5UcXM4+LY6O35/91wLLfDnM9RuTlxlEvBMWXyHbCn0yzoJAw1sN/hmwY+g8Z+Qe22Qj
         axEmTB4fJSA0WWGRMugjU85BLar0Ic7V1v+eom6OHVZSpgGqais5nsnmSRTZMmHKmNmT
         lJXU/OVFQllMjEU4amhPpB02asmTDQLYgO4yJsW2e97g6ROgEVwg9c8dgoN0jToCnTJj
         hPUA==
X-Gm-Message-State: AFq9FYL9WGbsgBrP3JjWTL23BnKRP6uIANKXxV5or4xt9+ujFoQYFG54
	aeOuXIBpnMFdv4FO14RQtmAPQubuBds5Dlo+6ABz4X8s0hHdJvDTx/NDKspG+A==
X-Gm-Gg: AYBFou2cbQY5BngWb+nvPXQc797ktIoTRMIehoA/Q9RpSmqeXaAZrFo9c9nGq970D6Q
	fLiPUrKh60OQ8nGmPH9tJO5UHRvdeM+GppYbfG6viyVIXh2VmUJPhUCXgnOEnSGukou7hZR+gvJ
	znCQ9aBuNj7XvIBqr65jSTuxO4fbBSmNaBAapji39vs87rAjPTYbqqGoCP1lNyKG3LiBlTaXAli
	qyED1xDpktamH+v9nIQu6gmaReBy2LdXbF63E+uSir3nOjQumLzhjlXdgoBlnmlClnvquY58uXk
	k0kRVz4KNGk4HXBdXUs2MYL1BM4yYmClABim5RaDhcRWbj9qVqhjw7uLQ5AJUQSTVzPSpuQK04z
	rRAQ/0KTZh0LlFhCYqKBSoXuTD678J3/e1kTueLx3j7V0HgqEDLOjXagxxDeAKK1fOq0UO9Jpni
	rpPGQN8cZmTarRgcujvT0oWrH+QRh9ORCydJ7o7I0U8Obie0F2j661wKBV0nfYx7s3D1AEXk90/
	tVITdjtYXJ6n9zGqXxGDZ1Pb8iTRkOtnaBM3IHuOBKcZw2sXSLlP/F//ITp
X-Received: by 2002:a05:693c:65db:b0:352:4f11:8118 with SMTP id 5a478bee46e88-3674e64d912mr2319910eec.40.1792566210345;
        Wed, 21 Oct 2026 00:03:30 -0700 (PDT)
Received: from mptcp-lab.w453y.xyz ([59.164.88.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3674198f1d8sm6468910eec.24.2026.10.21.00.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:03:29 -0700 (PDT)
From: Abdul Wasey <w453y.me@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH mptcp-net v5 0/2] mptcp: pm: in-kernel: fullmesh: re-add of the initial subflow endp
Date: Wed, 21 Oct 2026 07:03:22 +0000
Message-ID: <20261021070324.50533-1-w453y.me@gmail.com>
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
of export-net: the new tests fail without patch 1, except the one adding
another endpoint, which already worked and guards against breaking it.
The whole mptcp_join.sh passes with patch 1. Patch 2 uses iptables like
the other tests there: when merged with net-next, it will need the same
conversion to nftables as the others.

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

 net/mptcp/pm_kernel.c                         |  33 +++++-
 .../testing/selftests/net/mptcp/mptcp_join.sh | 108 ++++++++++++++++++
 2 files changed, 140 insertions(+), 1 deletion(-)

-- 
2.43.0

