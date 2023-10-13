Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7661C280
	for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 15:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="feoXkNAN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697212434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p6iVBMFDFvuRVCDHZbPgrs6L6z8clwCcnFXOvCZQHGI=;
	b=feoXkNANjG60VCk4CT7FBZgoNPfWd/kQTMzljpak+elY1/yPkEVMogJqZ0ak6hiU8Arhqu
	m5pdK28tQDkITJOSeR0ayoPXO8G3DlwrmXG3Eu49xcfoMhHtFVVAgjcK4TKKDiOZ758Yux
	twEYNZym793xR8rEckUDWZ0812Eq92k=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-2gE5XRagOxiJ7PxWC7WCrA-1; Fri, 13 Oct 2023 11:53:47 -0400
X-MC-Unique: 2gE5XRagOxiJ7PxWC7WCrA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2c5073588cbso8331881fa.3
        for <mptcp@lists.linux.dev>; Fri, 13 Oct 2023 08:53:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697212426; x=1697817226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6iVBMFDFvuRVCDHZbPgrs6L6z8clwCcnFXOvCZQHGI=;
        b=xAmmogQhCQX41aAJvdwNset8r8Umw0/U6NkO35CgfrRGO2kD2/VyiQYXgDusI6PStQ
         762P4b3mSaaMVVBX5nUV2GioPWL2l00kQyByrniF1mV15CKE9phW/CmmOxP+H9/N0iLH
         4EbrQ6xyHSHwFb37qwtut50YO8YJ85+yojGvmTnqFJtq+7EMv7cl10jODvRRx/Y/kxCw
         jsPAN1chgTW2z24R52Y0iIboEvZy1YxsUXFUaIC3pubiBIChEhr5u2Glh6mHJDtbSH9p
         egV8li50LoE4eipdIFHkmSGd+dfdcPDefRLUFeSc3yLAxv05euH29augkugl8Rvgy3D4
         iocg==
X-Gm-Message-State: AOJu0Yzg2S0sDaQf6iUJcKnu3L8AQvQ/s8V0l0Hh6gwMAjBHwKS0y/dV
	sZF7fVFeZ+6tic8OOMXRU5D4nywc+Gnbj0O3uRTMui7I7frDK4x6Vz2s91PuwIKe8ScN+k9oJra
	Anw8knqci/zluIPILkxPfTdrKtGfmaCw=
X-Received: by 2002:ac2:53b9:0:b0:507:9640:f256 with SMTP id j25-20020ac253b9000000b005079640f256mr2804975lfh.36.1697212426074;
        Fri, 13 Oct 2023 08:53:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqGMhkYjYeBy4sITkZM0jLXw5pI5f3l4jRwaq+QeBHBRuweCotTaqLPYVnjkzfOmRLgqugw+SAFyQpqkKlS3w=
X-Received: by 2002:ac2:53b9:0:b0:507:9640:f256 with SMTP id
 j25-20020ac253b9000000b005079640f256mr2804960lfh.36.1697212425670; Fri, 13
 Oct 2023 08:53:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <36fe14dbd444daf86a22cfa5fb50d590324e7b58.1697190267.git.dcaratti@redhat.com>
 <ee31bfb2-9fe0-4d20-ad6f-1627d048613d@kernel.org>
In-Reply-To: <ee31bfb2-9fe0-4d20-ad6f-1627d048613d@kernel.org>
From: Davide Caratti <dcaratti@redhat.com>
Date: Fri, 13 Oct 2023 17:53:34 +0200
Message-ID: <CAKa-r6vwzXYMcn7aP_ap+aHsApCngjwBRraUEk=zQSV2WngJ3g@mail.gmail.com>
Subject: Re: [PATCH mptcp-next] Squash to: "net: mptcp: use policy generated
 by YAML spec"
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello Matthieu,

On Fri, Oct 13, 2023 at 5:07=E2=80=AFPM Matthieu Baerts <matttbe@kernel.org=
> wrote:
>
> Hi Davide,
>

>
> I'm not sure to understand your modification: is it just a test patch to
> check that the CI is OK with the modifications, or do you want to have
> this patch included in the tree?

yes the goal was to check NLA_POLICY_EXACT_LEN() with CI (we already
have it, but better to double check on top of the whole series).
By the way , I see a failure but it doesn't seem real (I hope :) )

> Because I guess we cannot just accept this patch, we also need a
> modification of the YAML spec and the YNL tool. Then this file you
> modified here will be re-generated, and we will get this new result, no?

right, I have a series ready that also includes the parser of
'exact-len:' key in specfiles (and a de-uglified yaml spec, as per
Jakub's comment). If you are ok with it, I will send this series
directly to netdev - then, 'export' and 'net-next' will slightly
differ until the next merge. Let me know if that is ok for you,

thanks,
--=20
davide

