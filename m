Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B7028DA5
	for <mptcp@lists.linux.dev>; Wed, 25 Oct 2023 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZIMKdvWD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698241750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dPiIMmMbY1cYYJxNL7uiR3SQUAm2eaV8B5kbDdQQO6A=;
	b=ZIMKdvWDBC4AD5QVXRNBBYlB9cWQ/2F478XbHut/c3Xq2uMzC9uR1OcqfaErJlYFV913Zu
	xGJhZN8ggsO+FaYD33ZZ5aZjgDgkwYuNw77sHxAxLgT1DXm+Shid4nVBn1LvcWc5o3n/rS
	2OPG5imZX+938QVE9aibs5MxXoyVr9E=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-50BbLF8SNOeLKeRhlOhGrQ-1; Wed, 25 Oct 2023 09:48:58 -0400
X-MC-Unique: 50BbLF8SNOeLKeRhlOhGrQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-507d2e15086so1308164e87.1
        for <mptcp@lists.linux.dev>; Wed, 25 Oct 2023 06:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698241737; x=1698846537;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C+FBy7j+UscI5hRgAfAFa6mgEZdbgMkSmr4F2qKqMP0=;
        b=T15hvTH57yfMcfmOPkaU/r9+FO+ffy53UA8RkDw5ITQWYokUguCkg3gyL7LJI/xE4S
         p6B2HNM0PzzZxYl/gqKAcGRz59AjWIYMJIzUGbM9mW9Zw5+YVF0J+RtHK5u3/v9HA9Li
         QGaJqOHMpYjAWzWxxpDZXlZXHC3YF7Fejs5BZwt2LZe1xmlZL57jQCDOh/i1bWS5wqZL
         WBxbNijACoXGTx/4f03fVlN2gQrM2odCOPmHuihN6NqNrs1wgxFyHxIoKsDfgwJKEys+
         W3BGOIv2l7h2x0oNVEDckmaNSEw+e3+F04PhOKnDxTrtkR9/4abaj+djvpYFHqDNhfII
         kTgQ==
X-Gm-Message-State: AOJu0YxGtScnMUjJjUju4AZGwyAs6ew2plbnDpnaMIb7Bx3wBi5C1+Gm
	sdy2zUTw7uFEUmMbrxHe/RoZyk+FUvbxvBl8WWNW9iAtGuXzgH3zqmK3srL6oG0mMJXmiWWUSdy
	WjUHBTVS72HIPa5k=
X-Received: by 2002:a05:6512:3b21:b0:508:1a11:16e6 with SMTP id f33-20020a0565123b2100b005081a1116e6mr909667lfv.2.1698241737509;
        Wed, 25 Oct 2023 06:48:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGELiz73Ars3ifhTm/Nm0fTnz/Fa2njbwHuQw0/bI4RiuAtJNEZN3536/KqPyQZgv+4JK1wXA==
X-Received: by 2002:a05:6512:3b21:b0:508:1a11:16e6 with SMTP id f33-20020a0565123b2100b005081a1116e6mr909640lfv.2.1698241737075;
        Wed, 25 Oct 2023 06:48:57 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-10.dyn.eolo.it. [146.241.235.10])
        by smtp.gmail.com with ESMTPSA id b59-20020a509f41000000b005402b190108sm6260252edf.39.2023.10.25.06.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 06:48:56 -0700 (PDT)
Message-ID: <bfd0a37b09540fd3cf4107f9bea1b9efb70d5b33.camel@redhat.com>
Subject: Re: [PATCH net-next 1/9] mptcp: add a new sysctl for make after
 break timeout
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Mat Martineau <martineau@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	netdev@vger.kernel.org, mptcp@lists.linux.dev
Date: Wed, 25 Oct 2023 15:48:08 +0200
In-Reply-To: <20231024175454.11b3305b@kernel.org>
References: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org>
	 <20231023-send-net-next-20231023-2-v1-1-9dc60939d371@kernel.org>
	 <20231024175454.11b3305b@kernel.org>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2023-10-24 at 17:54 -0700, Jakub Kicinski wrote:
> On Mon, 23 Oct 2023 13:44:34 -0700 Mat Martineau wrote:
> > +=09=09.procname =3D "close_timeout",
> > +=09=09.maxlen =3D sizeof(unsigned int),
> > +=09=09.mode =3D 0644,
> > +=09=09.proc_handler =3D proc_dointvec_jiffies,
>=20
> Silly question - proc_dointvec_jiffies() works fine for unsigned types?

AFAICS, yes: proc_dointvec_jiffies() internally uses
__do_proc_dointvec(), which parses the buffer to a 'long' local
variable and then do_proc_dointvec_jiffies_conv() converts it to
integer taking care of possible overflows.

Cheers,

Paolo

