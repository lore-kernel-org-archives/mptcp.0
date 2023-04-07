Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB661FA9
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 08:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680854636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dQRqgs//cE5inrvjcypICiuPqsFDntkPP0dbUZf2btI=;
	b=PEYYeXXpcahV9AwWAfjmr+jHa5KeyYFoxxoxVT6yZ0FwlRVpnVsBcyjvo32aO+HoChGRFO
	2PvHglyrzEQleR/zAZa7DGWdWF7D3VdCZObvxvu+lr2qguvC9UTlAVilnuxQeK3xNU5/rE
	F02TkkpvOo0ECWB/ol8QJ0/I+73L5Fo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-qouuxQTSOA2q8_DakgmscQ-1; Fri, 07 Apr 2023 04:03:55 -0400
X-MC-Unique: qouuxQTSOA2q8_DakgmscQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-74610f3f19fso43340785a.0
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 01:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680854635; x=1683446635;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dQRqgs//cE5inrvjcypICiuPqsFDntkPP0dbUZf2btI=;
        b=WwFmbXfPWX+GPvsR7zXmGRafnQ7ckPf1PInY+NrdLHrkBFVaqft/G1m9lTkuFUOOZc
         6MKr+k2Af7gQKJePElZs6nu1FESlqR+lnCoHYA0ddry0/fTFZUg0kl2I4JptLeJmvuTd
         eJYlpnO4nubVhX8k7FZH95v0p0hPcCa8SKf6JV5UmqvRMh1rvQyt85HxUcfSi0NcvDAS
         SSvMT5TIVGOxeAGFnwp+sTR7UGR0UFUILCqMe5+jxeGzHTy5oFHWX2U4no1VBjGQS+pf
         baAdV+qBBdvDbQzOfB8FGw2vYFZaLfJdcOvQjAUPE7q7MMcCqsAW1NcuB5XT54oLeuqI
         2wIg==
X-Gm-Message-State: AAQBX9cd8/WTuMIcBKSPOTPWlkXqV2rQVfGSpG/55Hx2m2RKmI0JXyqC
	w6/ZzuU9uA+SB0PmMmHJByAn/RuAnWWrL2TNG2CQZtt6SF9Sd+Q40Tof5XcRYvIA31q7aSYUx2U
	dHCfzd6dYxipcfJg=
X-Received: by 2002:a05:622a:1a16:b0:3e6:30c4:656f with SMTP id f22-20020a05622a1a1600b003e630c4656fmr2841391qtb.3.1680854634768;
        Fri, 07 Apr 2023 01:03:54 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y4FPffbHP3jUP7C4lNCS8iiMDnOjDa71Xcmm0RdIj+/GuK++ROkwy9sMDzw3Fr3u/NqOapwg==
X-Received: by 2002:a05:622a:1a16:b0:3e6:30c4:656f with SMTP id f22-20020a05622a1a1600b003e630c4656fmr2841369qtb.3.1680854634492;
        Fri, 07 Apr 2023 01:03:54 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-227-151.dyn.eolo.it. [146.241.227.151])
        by smtp.gmail.com with ESMTPSA id bm20-20020a05620a199400b00746ac77366fsm1126880qkb.12.2023.04.07.01.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 01:03:54 -0700 (PDT)
Message-ID: <8e3d2141bb0c0bcfbac0fba2bc3107d08fa2e9a3.camel@redhat.com>
Subject: Re: [PATCH RFC mptcp-net-next 5/5] net/mptcp: use netlink policy
 generated from YAML spec
From: Paolo Abeni <pabeni@redhat.com>
To: Davide Caratti <dcaratti@redhat.com>, mptcp@lists.linux.dev
Date: Fri, 07 Apr 2023 10:03:52 +0200
In-Reply-To: <c4f10d6368a1bf580dd3b4cbcdafa1a71e398404.1680801697.git.dcaratti@redhat.com>
References: <cover.1680801697.git.dcaratti@redhat.com>
	 <c4f10d6368a1bf580dd3b4cbcdafa1a71e398404.1680801697.git.dcaratti@redhat.com>
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

On Thu, 2023-04-06 at 19:31 +0200, Davide Caratti wrote:
>  $ ./tools/net/ynl/ynl-gen-c.py --mode kernel  \
>  > --spec Documentation/netlink/specs/mptcp.yaml --header \
>  > -o net/mptcp/pm_nl.h
>  $ ./tools/net/ynl/ynl-gen-c.py --mode kernel  \
>  > --spec Documentation/netlink/specs/mptcp.yaml --source \
>  > -o net/mptcp/pm_nl.c

perhaps:=C2=A0

pm_nl_autogen.{c,h}

or

pm_nl_spec.{c,h}

to avoid confusion vs pm_netlink ?

Thanks!

Paolo

