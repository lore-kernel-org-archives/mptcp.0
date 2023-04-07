Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D429110E
	for <mptcp@lists.linux.dev>; Fri,  7 Apr 2023 07:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680854203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pdSOwDvV0JC8xQOK+j3wUx6TIuS7GUt6hnkyLFi/mZ8=;
	b=FduspKxMUNDMxlGngjif5aHEbaXLqUk+w1p2gJicS1988h00O1o1pqRP0SuU+j/+GuDqhB
	euoAq/XemewODYr+W1vZR61HYSrGJz2rJyZVzi14M74BGvKKpln+4yQXYe4ERU6hRDjwtZ
	g/wFevzifsepRByv49LSs/ydc6eHV9A=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-CAIFnT7uMW2M4ssmM0GuWw-1; Fri, 07 Apr 2023 03:56:42 -0400
X-MC-Unique: CAIFnT7uMW2M4ssmM0GuWw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-3e03178131bso4542531cf.1
        for <mptcp@lists.linux.dev>; Fri, 07 Apr 2023 00:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680854202;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pdSOwDvV0JC8xQOK+j3wUx6TIuS7GUt6hnkyLFi/mZ8=;
        b=N79BHTa7LUDKpqjtxdg4dl4r72OH/TVqNFfESJMSn82zOTgIeftPelmR45aYNPTA4g
         0rJGD2q+Ifm0UPHNm8y2d9mFrzIbjXZU1lFhpNsMXcF0A8fqsh+XUw4P/18/7h6/zjWO
         bIVhuc+HSJpv70FzoiFMm9QOlMK6wtWAZS6o9NTZLJdUAfpIEyFYElBPgYtWJx8OJlq/
         ZxPVOAESELFAZworHr1C23nH6oBn84NTt1Vya9PHI9Dqs5v2TRKbncZk2St1uGbtN7yK
         qg8EEAlqnhwohqCLGD+lbscSLCGuDT/bXRofZuKlT10l1LpOVNGg2dpf/iR/NAtzBfdU
         DZZg==
X-Gm-Message-State: AAQBX9do9Bz/ffQTaH3vzFN2KINRkipazvlr8EWkyfFuS/w5D48NWd5e
	9G7mjdulM0wgOTmDuA7NOkWp3SqXiWiN3B7dpQxIRGD5YqwfiPzysN56u8xTcqgWgZvPGf+1wpV
	hYQiumoM82ptnTXuvCx/gDFnGOg==
X-Received: by 2002:a05:622a:1a9a:b0:3c0:40c3:b8fd with SMTP id s26-20020a05622a1a9a00b003c040c3b8fdmr2591191qtc.6.1680854201998;
        Fri, 07 Apr 2023 00:56:41 -0700 (PDT)
X-Google-Smtp-Source: AKy350aHHqGQ2DdIRjMyhMTYabzfy2LjQYQMvatnYfK+IBUf1TD0utS2fiWWVobFKl76bVZ31IpDdw==
X-Received: by 2002:a05:622a:1a9a:b0:3c0:40c3:b8fd with SMTP id s26-20020a05622a1a9a00b003c040c3b8fdmr2591184qtc.6.1680854201765;
        Fri, 07 Apr 2023 00:56:41 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-227-151.dyn.eolo.it. [146.241.227.151])
        by smtp.gmail.com with ESMTPSA id d23-20020a05620a141700b00746803d7e8dsm1111468qkj.113.2023.04.07.00.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 00:56:41 -0700 (PDT)
Message-ID: <7bc87c2f4acbe8157414b11936072efb07ad7f50.camel@redhat.com>
Subject: Re: [PATCH RFC mptcp-net-next 3/5] Documentation: netlink: add a
 YAML spec for mptcp
From: Paolo Abeni <pabeni@redhat.com>
To: Davide Caratti <dcaratti@redhat.com>, mptcp@lists.linux.dev
Date: Fri, 07 Apr 2023 09:56:39 +0200
In-Reply-To: <cb2ed01dd8797078c39c014e8c19eab5ddf1f0f2.1680801697.git.dcaratti@redhat.com>
References: <cover.1680801697.git.dcaratti@redhat.com>
	 <cb2ed01dd8797078c39c014e8c19eab5ddf1f0f2.1680801697.git.dcaratti@redhat.com>
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
[...]
> +attribute-sets:
> +  -
> +    name: addr
> +    name-prefix: mptcp_pm_addr_attr_
> +    attributes:
> +      -
> +        name: unspec
> +        type: unused
> +        value: 0

This entry should not be needed, the tool should add it by default and
keep the first item with value =3D=3D 1.

> +  -
> +    name: attr
> +    name-prefix: mptcp_pm_attr_
> +    attributes:
> +      -
> +        name: unspec
> +        type: unused
> +        value: 0
> +      -
> +        name: addr
> +        type: nest
> +        nested-attributes: addr
> +      -
> +        name: rcv_add_addrs
> +        type: u32
> +      -
> +        name: subflows
> +        type: u32
> +      -
> +        name: token
> +        type: u32
> +      -
> +        name: loc_id
> +        type: u8
> +      -
> +        name: addr_remote
> +        type: nest
> +        nested-attributes: addr

Is this the definition requiring patch 2/5 ?

Are there other attribute set requiring such change?

Thanks!

Paolo

