Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794893100;
	b=qlQvN340as72nxHQQdFtYAhFZczCaA0GsEmTfiWnCi/p4a/uCRZwgcnT1S/BeejfbXY7
	 OvyCeK7iyFG2wusVnPnmbxIlUE1NYwgVKZfg15kt8nRMRHqn37A701SdfKnlmencAGBGZ
	 YBxrdrfk+69lyptOJT3MQZZUSSunaeaD5r1h68l/OVTX30e7hPPMFXIZqwoplJeMjtorB
	 xkXxQydwIUwBXs6B5x7W5nk5ayB9CdqIHFUmXKZnubyF/xMlyRlBeah4Opy//HI87g1ds
	 yGc6hU6MDWBD8y0KFei1K7yXJQ9StKHiNMUGVvSPQfx4V68k7ADOBvyzWb7l6TWfpVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794893100;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Message-ID:
	 In-Reply-To:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Importance:User-Agent:X-Mailer;
	bh=DkiVBPa+8SzkbRTDHFoOIqhN6C0tER0KD9wyV10ouEA=;
	b=ogu09dzzygUXCyNFT5QwfHs01uxhHJZ5gG8I+MDSxeULC26zRNTnAufXZ4MIjmyNuXQG
	 c6yLzMLj/7EL9TtXOQbJ+67kgBUzJuCxUPA6g7/KN0SjirO/ksOUEPdOXcDpUWsbCA5p8
	 Dc8AcHfIAIGk29bT6pLhsBhDvf2Suukw9i9wv2dKbAkZzpyuKD9FVT6719qw7hKOivARH
	 HH+FO4XNl7v2hEPA/kBUISaBRPr1/A8WTZ8BfrPIZULViYuD599EcG8buOEqPefvnlkwR
	 2A4/RPCULIWDAeXATfqX1Be2LaK017Ol0JTgzQdSIgDlgO/Njg6XQL/40X7oJ853GBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76637606A31C
	for <mptcp@lists.linux.dev>; Tue, 17 Nov 2026 05:25:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76637606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1794893094; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=M/KHP8qWeweXBWsJYNYyAt3nX8RXk+uSRxYdNUwjPPPR4kKo5/B/It8pjwVgPbqYuGsYIMEjg9+W4FhcmsoIPx31RgVuj15r1j9sRdw8U9wptJmHieHviYK8Fow0Sd77llWQ2DzviHIIyVkhCjUDgQkZBrrTPhhgAWWmDPHZX70=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794893094; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DkiVBPa+8SzkbRTDHFoOIqhN6C0tER0KD9wyV10ouEA=; 
	b=Kl/gyR61j4ARPLonmAtEsnerP0CBdsEcAtkIKCyfbKAt9BsTzQIb/cz1XU8CCF1Aw6AkFTUefaCG/Z5lL1vC4NZVDIqE7FGfoLgluJXb5869P90CZsVUceHPMGN06SYDlDMDc1epFYAX+1ylU8qeb5JJcCEBXLD5kxHuFJpTIy0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: a=rsa-sha256; b=Gqg7TVmJDYUROYQMyWEjMY94cOhwYTGcXyiTF1X1Rug323iFQVYkFy/pxkWS61exqk8gI5WDNw6GnRjEtJildmDRgBUjL/zuG8jCSqeWg6J2vNKmdBfD29misKSjxwvUbmgj3egYC+SQ9h5KKOGrL+v477i9ROavKxDXzFiqivo=; c=relaxed/relaxed; s=mpiric; d=mpiricsoftware.com; v=1; bh=DkiVBPa+8SzkbRTDHFoOIqhN6C0tER0KD9wyV10ouEA=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1794893093618711.0640835493346; Mon, 16 Nov 2026 21:24:53 -0800 (PST)
Date: Tue, 17 Nov 2026 10:54:53 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Mptcp" <mptcp@lists.linux.dev>
Cc: "Matttbe" <matttbe@kernel.org>, "pabeni" <pabeni@redhat.com>,
	"shardul.b" <shardul.b@mpiricsoftware.com>,
	"Mpiric Private Limited" <janak@mpiric.us>,
	"kalpanjani009" <kalpanjani009@gmail.com>
Message-ID: <1a1e7f71a64.801c4dc0528499.8854228492193794083@mpiricsoftware.com>
In-Reply-To: 
Subject: Gentle Reminder: Review Request for MPTCP Issue #349 (v5 Patch
 Series)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi All,

I would like to kindly follow up on my v5 patch series for Issue #349.

Link: https://lore.kernel.org/all/20260915093506.465110-1-kalpan.jani@mpiricsoftware.com/

The patch series has passed the Sashiko tests and CI runs. I would appreciate it if you could take a look whenever you get a chance.

Please let me know if there are any concerns or improvements needed from my side.

Thanks for your time and consideration!

Cheers,
Kalpan Jani


