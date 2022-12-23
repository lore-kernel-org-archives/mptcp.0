Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6199233CE
	for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 18:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1671820379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1OkkLAiINc8fyBSR7ofk9agv+sUGThvhYB2/L1KpZJQ=;
	b=HxWKOaE17IL731V1vMC/OySv7tF368FTX+8FuC0oeHdrYeeEociCvYyM8T5W8NGuevngNQ
	zW8E8WX0uw4NQt7b5jJNhEXTlY7OVeZy1Bx7TgQtbJl2HTBpEagbuM8ySKhtr5/+me+0TP
	LO9zBj5EGP3kqekwBED7g61l64V7OC0=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-179-JuQcmzFGMmCYV9CDpFzt6w-1; Fri, 23 Dec 2022 13:32:58 -0500
X-MC-Unique: JuQcmzFGMmCYV9CDpFzt6w-1
Received: by mail-ua1-f72.google.com with SMTP id y19-20020ab048d3000000b004397143cdfeso1810169uac.2
        for <mptcp@lists.linux.dev>; Fri, 23 Dec 2022 10:32:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1OkkLAiINc8fyBSR7ofk9agv+sUGThvhYB2/L1KpZJQ=;
        b=uXi6Car4VDaFr0cohif/I0DToXHh8ogjvW5GLwRIrnyjkdIRxaVG5tt2jppKbBp13U
         3oxAGjVubRGR3qvIOymGH9bqiEXuNsZOWHYB8QJeBZm1YoTN2b18VK4wGZxOsfLwYY5y
         DfTRtGZTHHXwMmUvmBGwkd96YOPD0i4jEBhXRvl2K8dS0TJRLDCeoT+HGvXTpKKhY1XT
         bJhpxNFXh5GqH/PtsJukaKbFeV1C7aeO5M4zLrscsb0UPBK2qFx9UGU16yaCLf2pKj20
         AKip3/ep2AbD5mpo6GRTQLy9O4c1vrcYIQ4nVoCE+3cL1uq2R7J19Vjcn7/aFdkbqwCZ
         I5rw==
X-Gm-Message-State: AFqh2krQg2z6P+0k1ai5emU8T0Xb5IGzLvHxlKc8+tLnj4Szi1sI/TE2
	BhcyK8+gh08r/AcSWnug64Ov4M0LNNdM1k8jqiIoMd4mEnO3zdt/dHkPLZJJH4k0Vh60hkqpras
	jZYCp5ohbpt+Qvno=
X-Received: by 2002:a1f:9110:0:b0:3c7:eefd:c8ba with SMTP id t16-20020a1f9110000000b003c7eefdc8bamr3912650vkd.5.1671820377557;
        Fri, 23 Dec 2022 10:32:57 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvdZJPPV4J6nD7vtNZ/uUo1SLZP0dRh52YbyDdNIghcbS9HFAMxRPaYJuVfn2qa3UBgauKerg==
X-Received: by 2002:a1f:9110:0:b0:3c7:eefd:c8ba with SMTP id t16-20020a1f9110000000b003c7eefdc8bamr3912640vkd.5.1671820377290;
        Fri, 23 Dec 2022 10:32:57 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-101-173.dyn.eolo.it. [146.241.101.173])
        by smtp.gmail.com with ESMTPSA id s21-20020a05620a0bd500b006fa4ac86bfbsm2713520qki.55.2022.12.23.10.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 10:32:56 -0800 (PST)
Message-ID: <f20959a74ad5b3f57f9f8ec5af958eec47ace5f5.camel@redhat.com>
Subject: Re: [PATCH mptcp-next 1/3] mptcp: explicitly specify sock family at
 subflow creation time
From: Paolo Abeni <pabeni@redhat.com>
To: Matthieu Baerts <matthieu.baerts@tessares.net>, mptcp@lists.linux.dev
Date: Fri, 23 Dec 2022 19:32:54 +0100
In-Reply-To: <2deb7590-9c5e-0e7e-37ec-e447391f74bf@tessares.net>
References: <cover.1671799401.git.pabeni@redhat.com>
	 <7d3aae6493caa1563d1aaadc79d299c01077f28a.1671799401.git.pabeni@redhat.com>
	 <93c4e8a6-4797-9c10-5ae5-7499d6e2bed4@tessares.net>
	 <a9cddc311804ebc183c0b1568c296b23932d7dd4.camel@redhat.com>
	 <2deb7590-9c5e-0e7e-37ec-e447391f74bf@tessares.net>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2022-12-23 at 17:08 +0100, Matthieu Baerts wrote:
> On 23/12/2022 17:01, Paolo Abeni wrote:
> 
> > Do you mean that we should allow mixed
> > ipv4/ipv6 subflows only if mptcp family is ipv6? that is doable, I
> > think, just slightly different from what is implemented here.
> 
> Maybe we don't need to change, we just need to decide which behaviour we
> want.
> 
> Is it OK to have a mix of v4 and v6 subflows if the socket has been
> created with AF_INET family? In this case, the family is just for the
> initial subflow and not the next ones.
> 
> That's maybe fine but it might be strange that for the server side,
> AF_INET6 is required to accept both IPv4 and IPv6 subflows.

Ok, adapting to that does not look like a big change. I'll try to cook
it.

Thanks,

Paolo

