Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795067563;
	b=FIgKAl5ZIDQtOOL85+q0ai+HQ2iKEZmAHwqdGd66Ne2yVquiLaMAawcLLPuI4zs1Wjyl
	 9/XmGrg+sea3LzhPszerqqOfhRHpLh4T6tqOTpnb1zrDyvzSb+S29mGgtJcqrs/UTh2cl
	 +8nOWOo+c+t7gQTOD+h3C3dFqoL+/3XTje4FFCoasgja/g+lQVeJJr6/re70tObkJU4bT
	 qFNE+Uh9Yze0URrrfqQoR79QmyTA+PERmL/vadbotqagLCqV/15NrGdUHP0vAm0fG8xfu
	 OnVSu+yhGEKovCpKLjUTqUX4RrLsBDra42At68ZQXOGfa+y4wGQuibZ8b21xF8O4fug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067563;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Message-ID:
	 In-Reply-To:References:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Importance:User-Agent:X-Mailer;
	bh=gVrxQjI5ik/4WskL2N5A9ARYn6B/tVEvpRwdXIhzp0g=;
	b=HFj/FMKtc0oxpZUKF7ACtQIXbGp1FNRhzR4dGbRZGDkzX5RrSWebYqAiJe5b4r6m+wHa
	 fa9JJc1wuj94xkbEjJ08/KY5JziNUo4rf3vOg7Z5Nb4a35yp12EyZd073jSPmj0ciJstg
	 vKDdXogIN5C9aVKuz3gRzK/4/87RfF3PHW0VOE8a2s+dEqCS1sjaRbKWsO7iOVAUZuLtT
	 XFtFDJOaZVwqRGCRpdUnedovGGja/E0u8dOf+s/AhpHU/zJSBIjpx0HENH83hPvzWAi7N
	 Jf4/ZXqEKo7WXEYmmEaWKGkGqX+5XANvDPwhjYYH5od9wZINVDeg36PWIwTTfcntRSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mpiricsoftware.com;
	spf=pass smtp.mailfrom=mpiricsoftware.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EC7606A320
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 05:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9EC7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1795067555; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Fj2pHgyha+NZ1SVhHNzJPjAqZcsiC/Fq4NucERMdtt4srn9Ya6ZCyo5lcygFvuA62RP2yj6VdNLd6iwYSHkqwUaGsOTV9UBdsGDWKQV0e3zHgX0/y0S8wXIYtbsmO8ZprbY1PahePNo+obin4PP3qhfLNND+gj4qM3nIMmkChRI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795067555; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gVrxQjI5ik/4WskL2N5A9ARYn6B/tVEvpRwdXIhzp0g=; 
	b=JPk/qKi1rlnfc0VEECw/tuWR+o1EXIamCDVhH5k4Mmq4d/5tdLR8boillFRe20XGnWLqiyqW1fubDSFivonIpKywYc9DcHiXL8pjU02KHntUcx0yqssc/LJOxcM2gkjvyBzIVtOCDf607zB6pafJJYb0k70abAMiYZElfCP5iLY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: a=rsa-sha256; b=h2LOwLjodugbwScAt7/6xPeuX68+QrkMBJOtHDVA9q3SaFA9y73522nvIXrqY0rAxe+KrRYWre+3piiWYJkcac6x16InjAtZxstQxa3hUaX2KznDm7sda6lwdV4Bks6+pAUukJ0cqmerJrdpHaDYa6/LEpBufT0YbSsiQhsg8Ag=; c=relaxed/relaxed; s=mpiric; d=mpiricsoftware.com; v=1; bh=gVrxQjI5ik/4WskL2N5A9ARYn6B/tVEvpRwdXIhzp0g=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1795067553868269.0704554044745; Wed, 18 Nov 2026 21:52:33 -0800 (PST)
Date: Thu, 19 Nov 2026 11:22:33 +0530
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: "Matthieu Baerts" <matttbe@kernel.org>
Cc: "Mptcp" <mptcp@lists.linux.dev>, "pabeni" <pabeni@redhat.com>,
	"shardul.b" <shardul.b@mpiricsoftware.com>,
	"Mpiric Private Limited" <janak@mpiric.us>,
	"kalpanjani009" <kalpanjani009@gmail.com>
Message-ID: <1a1f25d283d.893171a8130292.1132649012904149972@mpiricsoftware.com>
In-Reply-To: <e78c7751-80ca-4026-a3b1-a782d82e09af@kernel.org>
References: <1a1e7f71a64.801c4dc0528499.8854228492193794083@mpiricsoftware.com> <e78c7751-80ca-4026-a3b1-a782d82e09af@kernel.org>
Subject: Re: Gentle Reminder: Review Request for MPTCP Issue #349 (v5 Patch
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

Hi Matt,

Thanks for getting back to me and for the update.

Sure, I'll rebase the series on the latest upstream tree, review the changes against the updated checks, and resend the latest version.

Thanks for your guidance and time!

Cheers,
Kalpan Jani


From: Matthieu Baerts <matttbe@kernel.org>
To: "Kalpan Jani"<kalpan.jani@mpiricsoftware.com>
Cc: "Mptcp"<mptcp@lists.linux.dev>, "pabeni"<pabeni@redhat.com>, "shardul.b"<shardul.b@mpiricsoftware.com>, "Mpiric Private Limited"<janak@mpiric.us>, "kalpanjani009"<kalpanjani009@gmail.com>
Date: Wed, 18 Nov 2026 15:48:27 +0530
Subject: Re: Gentle Reminder: Review Request for MPTCP Issue #349 (v5 Patch Series)

 > Hi Kalpan,
 > 
 > On 17/11/2026 06:24, Kalpan Jani wrote:
 > > I would like to kindly follow up on my v5 patch series for Issue #349.
 > > 
 > > Link: https://lore.kernel.org/all/20260915093506.465110-1-
 > > kalpan.jani@mpiricsoftware.com/
 > 
 > Thank you for your reminder, and for your patience. On my side, my plan
 > is to finish all the series I have in progress, especially the fixes
 > ones, but I will try to do some reviews in between.
 > 
 > > The patch series has passed the Sashiko tests and CI runs. I would
 > > appreciate it if you could take a look whenever you get a chance.
 > 
 > When you have a chance, do you mind rebasing it, and re-sending the last
 > version? In between we got netdev sashiko doing some more advanced
 > cross-reviews, and we don't want to be blocked by items it would find
 > when sending this series upstream later on.
 > 
 > Cheers,
 > Matt
 > -- 
 > Sponsored by the NGI0 Core fund.
 > 
 > 


