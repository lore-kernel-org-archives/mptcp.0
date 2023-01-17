Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BB62FAE
	for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 15:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1673968641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zr6K83S46FT3wyBgCeisoN/prAS3P5UYjFVBqVEITq4=;
	b=Mm2vCRkczWtxNtEA0ckoIQZY4XQ28gPfIyPJcenSlCxuTNLfAoj0aFLhD0CO/x8nVlY0/4
	atmfEEeUHxhkPIjMMWy0hSzVHblu89grnQZui9XO2BSJvaR7z1t8UTeVxP6A3iOq87aUM7
	sJk6FN3AnT/F3xRjxuAuZIH//DacpfA=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-199-un4VOZ_DOL2FU0OImD5xAg-1; Tue, 17 Jan 2023 10:17:11 -0500
X-MC-Unique: un4VOZ_DOL2FU0OImD5xAg-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-4dd4d4591f7so130533347b3.15
        for <mptcp@lists.linux.dev>; Tue, 17 Jan 2023 07:17:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zr6K83S46FT3wyBgCeisoN/prAS3P5UYjFVBqVEITq4=;
        b=7vnoTCgzVFx/0wTbsC8CYi9Lre55n3HkazwQvwYaIsjWxk0Q81xYYwPkLGcfmrbAH2
         7PH63gjeWiPNw0eaG+QB393pYcyuZTZU3UPATd1ispUeVkloYMz5mgQRPjUS8TEIJnWG
         k+iytDeFwlQfdu5h+Q8xRO4VbMBSexT4m3P6pkP7xeXGfDgF3K3YYGt0/A3mVPXu/A7s
         BtZugJb3+xtA8inCeaRByim3MdczlorU4p9IQXaubSHUd8yKKVwBpAYWL9u4xXnpx5ie
         1jUVERXLferqeXPKsV6jVQ8/y1RfVq/natDm/Ap6tYOr3BE8YHefyoHirh7slGDa7Mhw
         siFA==
X-Gm-Message-State: AFqh2koyQOKxzDMaUKrUA3pmAkMHeLngZMrgoo1bma967kMXK5IhlsF8
	K7tjwWIzJ4jEINaOvT7Eq0QlQJIOyahWtmbO1F/qfIf/WrK2gjwwA81IMrktzzJsLW3RSttDZsm
	+dn4HH0XscFXzZBnwmGJOiSA2V8t96XGUA5EZFXFw+/1SVUHd8It64TdTxyFM9jyI
X-Received: by 2002:a81:7858:0:b0:4d8:c3ba:8ceb with SMTP id t85-20020a817858000000b004d8c3ba8cebmr2896860ywc.25.1673968626483;
        Tue, 17 Jan 2023 07:17:06 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuao7N5j/lXxpoXKWaulurVinSeO83w0zJbvjBs5koRLyzTm2A8Mvg3ymK1guK5HKbaoR8ySQ==
X-Received: by 2002:a81:7858:0:b0:4d8:c3ba:8ceb with SMTP id t85-20020a817858000000b004d8c3ba8cebmr2896839ywc.25.1673968626108;
        Tue, 17 Jan 2023 07:17:06 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-115-179.dyn.eolo.it. [146.241.115.179])
        by smtp.gmail.com with ESMTPSA id w26-20020a05620a0e9a00b006fa22f0494bsm783535qkm.117.2023.01.17.07.17.04
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 07:17:05 -0800 (PST)
Message-ID: <34427514068a43680daf294f1049b82d069de2a2.camel@redhat.com>
Subject: Re: selinux: Implement mptcp_add_subflow hook: Tests Results
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Tue, 17 Jan 2023 16:17:03 +0100
In-Reply-To: <3def7f4f-7fc7-b4c2-28a4-5d501b1d4c91@gmail.com>
References: <ef05d6be7333148d39b579e9b4b4ca7edbb8472c.1673940640.git.pabeni@redhat.com>
	 <3def7f4f-7fc7-b4c2-28a4-5d501b1d4c91@gmail.com>
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37)
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

On Tue, 2023-01-17 at 09:09 +0000, MPTCP CI wrote:
> Hi Paolo,
>=20
> Thank you for your modifications, that's great!
>=20
> Our CI did some validations and here is its report:
>=20
> - KVM Validation: normal (except selftest_mptcp_join):
>   - Unstable: 2 failed test(s): packetdrill_syscalls selftest_simult_flow=
s =F0=9F=94=B4:
>   - Task: https://cirrus-ci.com/task/4799310072643584
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/4799310072643584/=
summary/summary.txt
>=20
> - KVM Validation: normal (only selftest_mptcp_join):
>   - Success! =E2=9C=85:
>   - Task: https://cirrus-ci.com/task/5925209979486208
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/5925209979486208/=
summary/summary.txt
>=20
> - KVM Validation: debug (except selftest_mptcp_join):
>   - Unstable: 2 failed test(s): packetdrill_syscalls selftest_diag =F0=9F=
=94=B4:
>   - Task: https://cirrus-ci.com/task/5362260026064896
>   - Summary: https://api.cirrus-ci.com/v1/artifact/task/5362260026064896/=
summary/summary.txt

Note that packetdrill failures are expected: the
close_before_accept.pkt script should be updated accordingly

I can reproduce - to some extent, say once in many runs  - the diag
failure. I'll investigate it.

I can't reproduce the simult_flows fail, which is quite suspect to me.
I think this series should not impact on such test in any way.=20

/P




