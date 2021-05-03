Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C3172
	for <mptcp@lists.linux.dev>; Mon,  3 May 2021 08:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1620030737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jtMsv/p347BbY//GWzZaBPdk+A8VTRzf3nGU92Uy9hg=;
	b=fZHUyaeMbdw7q8gHe+9O13uKtt2VuxV8uuMwpTwTDmQ3xvY+4eA4T6nILdLPqhmC9nVpO9
	kpjrOEkRn75G4uItZRFvxGT0duYnu+r7WNuJkCbqwvFf6GKXzgW8vva0lnfBUizw4F4Yel
	BOdMxLqeP4F3YzifU+b4VLPRtrj3PJE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-hhGbKlhVPcqw_iLd43c3tw-1; Mon, 03 May 2021 04:32:14 -0400
X-MC-Unique: hhGbKlhVPcqw_iLd43c3tw-1
Received: by mail-wr1-f69.google.com with SMTP id 93-20020adf80e60000b0290106fab45006so3480789wrl.20
        for <mptcp@lists.linux.dev>; Mon, 03 May 2021 01:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jtMsv/p347BbY//GWzZaBPdk+A8VTRzf3nGU92Uy9hg=;
        b=JHhGrk9OYPqJEPfioRjcqwWQlBA976lfP6Ymqnf5hxa3j5jdvROkE+cV+ZysIZaKNg
         rrX80YDztKh6hhBCvKmgfNGaTtupRpFiHOYF+eP40fzubL1DqIXayWJXHQ7CcwTRJOWS
         MW63qELkr0ehPbSj9zslkBuS+kjzd1aLEKNrysVxShn4AVkLkqOkUfOCDv3557IwhXHU
         lQQyLH10CWR3H11HCMcdwrfy+2B9bVUdtTOGs7OIb1oU4XVvC/qTe5YXIpWRA8IdiFOA
         wAiOf3yh+lyB8Sgh1RVBUBV8deEOJgF6HeJd6evKLeQDlJ4+nsbLNVXE1qVFG2em3xOe
         Gq7Q==
X-Gm-Message-State: AOAM530bIqEp79QLIgYauds4Ly5C/neKBkvXEqxz/m189KWmFOscezXW
	tw85lLhGaVDrP01L2yPEVd3YntNRtRU5a18rebiOcoo9pw/xM4+cogdNA0lcgyn4x3jFTRsIu7a
	Uy8lyG92hOf8VL3dyGOiywP+LvVHW8iI=
X-Received: by 2002:a1c:1c2:: with SMTP id 185mr19813844wmb.66.1620030733551;
        Mon, 03 May 2021 01:32:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8T2Zt7ZXTAu3VTrgNAbNTAiZzDcgUJPSO1ABwQd8IXmtmYGXbXeyKMm0wIVws2+t4apv0VAP3PDoZCj8qPQo=
X-Received: by 2002:a1c:1c2:: with SMTP id 185mr19813820wmb.66.1620030733320;
 Mon, 03 May 2021 01:32:13 -0700 (PDT)
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <199d0f80d00540b5861a51b5baf27363@shmbx05.spreadtrum.com>
In-Reply-To: <199d0f80d00540b5861a51b5baf27363@shmbx05.spreadtrum.com>
From: Paolo Abeni <pabeni@redhat.com>
Date: Mon, 3 May 2021 10:32:02 +0200
Message-ID: <CAF6piCLgdRdzZ37ng1ycGB+TEfstTL58yqZa2ANFUZCdPj1=-A@mail.gmail.com>
Subject: Re: Ask about MPTCP development progress and MPTCP in Kernel 5.4 GKI
To: =?UTF-8?B?5ZC0546R6ZyHIChKZWFzb24gV3Up?= <jeason.wu@unisoc.com>
Cc: =?UTF-8?B?5Lu75ZCv5YekIChTZXJlbmEgUmVuKQ==?= <Serena.Ren@unisoc.com>, 
	mptcp@lists.linux.dev
Authentication-Results: relay.mimecast.com;
	auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pabeni@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

First thing first, please use the mptcp devel mailing list
(mptcp@lists.linux.dev) for this kind of questions. I added the
relevant email address in CC.

On Sun, Apr 25, 2021 at 9:47 AM =E5=90=B4=E7=8E=91=E9=9C=87 (Jeason Wu) <je=
ason.wu@unisoc.com> wrote:
> 1. Is there a timeline for the release of the next MPTCP version? About w=
hen?

MPTCP development is tracked publicly via:

https://github.com/multipath-tcp/mptcp_net-next/projects/

https://github.com/multipath-tcp/mptcp_net-next/issues/

> 2. The MPTCP source code on GitHub is ported to Kernel5.4, and several pa=
rts will be modified to the original structure, which will cause GKI to fai=
l. Is there any solution to this problem? Does the MPTCP team consider aski=
ng Google to make some changes on Kernel5.4 to better pass the GKI detectio=
n so that more users can use MPTCP?

The out of tree MPTCP implementation hosted by mptcp.org has separated
development. If there are any interoperability issues between the
official Linux implementation and the out-of-tree one, please file an
issue on:

https://github.com/multipath-tcp/mptcp_net-next/issues/

Please note that google has not direct governance on the Linux kernel.
Google, as many others, contribute to its development. Major changes
are discussed and agreed on the relevant ML or if possible at
conferences.

It's not clear to me what are the 'GKI' failures you refer to. As said
if you observe some bugs please file an issue and report as much
technical info as possible.

Cheers,

Paolo

