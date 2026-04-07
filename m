Received: from mta-spfb-e01.commufa.jp (mta-spfb-e01.commufa.jp [106.153.250.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7A538758D
	for <mptcp@lists.linux.dev>; Tue,  7 Apr 2026 23:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.153.250.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775606113; cv=none; b=cif3trnWh3LxKujxdOYxpJnu4U/QIwDQC6UYMspiEPTmFfttuW+AdAc9dccJsBA1yi4LI+DDw+w+5kUbVksedEOArW43R9iDAf0dbVPdZOrLSoP3lt2GxxtdIHJbFy45ihIK9z66Ed4mfuxb+zcQ8qZVo5wwZX5N3IiumgF2S5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775606113; c=relaxed/simple;
	bh=9mg5M8JzStoGX6OAzSWgtKp2QSwMmuyfhSPRDpb/kwM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fM33i6Z2O5W04mFyb6W0JUbCwEOQ4NhA5F4pz30gOuTFjgZfP1SN8DvNKcL+0JmzS+eBoFtIZlT8vVcO4XGQw2k1MN8vIOreRiHVkzvtqL9E4f2ZTtozyBM/eSm38zPhcZGJ+waVauzvY9zWvBY6yk3gu0WXVKe3FSKq2jAHblA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sf.commufa.jp; spf=pass smtp.mailfrom=sf.commufa.jp; dkim=pass (2048-bit key) header.d=sf.commufa.jp header.i=@sf.commufa.jp header.b=CjHntgTf; arc=none smtp.client-ip=106.153.250.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sf.commufa.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sf.commufa.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sf.commufa.jp header.i=@sf.commufa.jp header.b="CjHntgTf"
Received: from mta-snd-e03.commufa.jp by mta-sp-e03.commufa.jp with ESMTP
          id <20260407235239077.ORIO.29338.mta-snd-e03.commufa.jp@commufa.jp>
          for <mptcp@lists.linux.dev>; Wed, 8 Apr 2026 08:52:39 +0900
Received: from sf.commufa.jp by mta-snd-e03.commufa.jp with ESMTP
          id <20260407235238296.IGFN.20493.sf.commufa.jp@commufa.jp>
          for <mptcp@lists.linux.dev>; Wed, 8 Apr 2026 08:52:38 +0900
Reply-To: export@stsglobalcompany.com
From: STS GLOBAL COMPANY <cubsuper@sf.commufa.jp>
To: mptcp@lists.linux.dev
Subject: Re: Inquiry about your products
Date: 07 Apr 2026 16:52:37 -0700
Message-ID: <20260407034631.7D7C0F15FC485954@sf.commufa.jp>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Authentication-Info: gah09h46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sf.commufa.jp; s=default-1th84yt82rvi; t=1775605959;
 bh=9mg5M8JzStoGX6OAzSWgtKp2QSwMmuyfhSPRDpb/kwM=;
 h=Reply-To:From:To:Subject:Date;
 b=CjHntgTfgf1xDVwlabX3e4PyNS7XAfxSSwKOm14wFxIsC/Bdyx+gLu24b7VOv2EQawDWHQFw
 g6jFUtfYaYK0vKeRlzHRxQbPEXlZc0I03MLRTLq706urDT4cP+YMzDaMfWNEGVZb4wKw4P9Lrc
 Y5CjYh0fnBHvIyo/2zGL8RnjR9AHwP5f6Bq+t3XWOTBshUjNdOT0Dj9kVlLmfJAVmHO9H23a5B
 8qKPo36oQ8dYdP+/xe9KyjdNy7k9RaNfeNgXRmuXpkYSdJkKlkw5fXmsDSvmplpCo/N3V9g96x
 7vX3vIxoNHBWhv40eBzQATuqwtJdxKOrIhc2+oqIRa7HnT1Q==

Hi Dear,

I am writing to enquire about your product and would appreciate=20
it if you could provide further information, including pricing,=20
specifications, and availability.

Please also let me know if there are any brochures or additional=20
details you can share.

I look forward to your response.

Best Regards
Nesmith Jones
STS GLOBAL COMPANY., LTD.
(Purchasing manager)
287/308 Liap Khlong Lam Ko Phai Road
LAT KRABANG - 10520
 THAILAND=20=20
