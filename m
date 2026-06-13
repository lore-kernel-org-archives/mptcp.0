Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC6F21FF2E
	for <mptcp@lists.linux.dev>; Sat, 13 Jun 2026 19:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781377330; cv=pass; b=QWndMHT3y1M9UBGKHTKDJERmuRQSvHZaQl6s21428jsvw3lR3RgCFfTJQZI2hbw2AcoKZsmWK3R25aV5EQum2hvxH+SmtjEpavFTx7Ycd4WBDJj6bGbwN0FVRQagqzb+1Yj7BKsn+3Jgeoa8ny7SzjVBrkwJm+3dbpbgChk3b5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781377330; c=relaxed/simple;
	bh=JaMEVAP8n7E/CdqyGl2jSR7m7rW2Xnx0q8VzZ5HVO0E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sCzxgDOOfcIx7npj48UniCm2GX8YiltY5Q7qTG6zdYpMebSGPDBGt3RPWuK2Ud+ne3s/SDRpZdq4mum3hsv1gFyUj9eN9divKFMCeq6UeVRzFdeUQgKGTcTibdP9t6AlvriECcghGeUqhaYGgSh8bUS0OxxGUFL2z3sYsiOZadw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=fail (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=PYU1dSy5 reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="PYU1dSy5"
ARC-Seal: i=1; a=rsa-sha256; t=1781377324; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XqMckbyZTHzm6xeHnqMT6GWw4voct0Ga2k8zHM4GeDFIw9DBacIsIRuxRA8OjMqHC3SHOlFF0rH5w1dR75m/eyZho1eYFE/pLyK8MrEkdDElH2US/TrP9zgsF5F7Vx0SKTZqDt4SChHwzZZY4hnNk5FHZF5fimoCT3M0JLRba/E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781377324; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JaMEVAP8n7E/CdqyGl2jSR7m7rW2Xnx0q8VzZ5HVO0E=; 
	b=d47eHOBEGZpabW4KNP8xHJu9YT9RXmlfAgXPNVDD7sGT5omL9CrvohVC5UDnt4/C5vgU2v1x2r2BlJj7cDY7rh+hBKsfh40P+eeAbhc6Ra3Yg+GeInsGUyLaHAdwZcQCDPjBr77YcNe/sKMMQ+z0isO+6JzkHLK7paF2cmiRxHA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781377324;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=JaMEVAP8n7E/CdqyGl2jSR7m7rW2Xnx0q8VzZ5HVO0E=;
	b=PYU1dSy55B3yBR3Hww56XLa5HcZNOq2hU9sGpgZyRxRvKbU08wpATz2pzt7ikuPH
	HOBmZcAdFqIxWlbbeb63EH9d7nqYkjmECYZtkAarwkb9qW79RdHmq4lvezEuBIFJ2hu
	E2EcrZ79RQi1jmjCbathPql9ygIapXVG+yMeaL1M=
Received: by mx.zohomail.com with SMTPS id 1781377322235215.63041458357316;
	Sat, 13 Jun 2026 12:02:02 -0700 (PDT)
Message-ID: <4d0a6bddd7f7ed4ac86130a1a56efc8d04f35432.camel@mpiricsoftware.com>
Subject: Re: [PATCH net v3] mptcp: pm: fix memory leak from
 alloc-during-teardown race
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org, 
	pabeni@redhat.com, janak@mpiric.us, kalpan.jani@mpiricsoftware.com
Date: Sun, 14 Jun 2026 00:31:54 +0530
In-Reply-To: <20260611003613.3184956-1-shardul.b@mpiricsoftware.com>
References: <20260611003613.3184956-1-shardul.b@mpiricsoftware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ZohoMailClient: External

Hi All,

Following up on v3 with the harness result I said I would report [1].

v3, seeded with the corpus that hits the unpatched leak: ~71 hours /
~284 VM-hours across 4 VMs, zero kmemleak reports.

As a control, the same harness on the v2 kernel still reproduces the
disconnect/reuse residual sashiko flagged (the 64-byte
mptcp_pm_addr_entry from the ANNOUNCE append). So the path stays
exercised and KMEMLEAK is live- the v3 zero is the unconditional free
closing that residual leak.


[1]:
https://lore.kernel.org/all/73704f7d4212390acdb20332d73d456cf75690d2.camel@=
mpiricsoftware.com/

Thanks,
Shardul
