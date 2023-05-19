Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500E365F
	for <mptcp@lists.linux.dev>; Fri, 19 May 2023 07:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684479820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AO6FrKETDxtjwZlPW7uOFlquyK0V4HPBSRGqDWXQSkQ=;
	b=Fdg6V7scPCmvJLXjwPieFzWdiF/5VRX/ZRUlxfPjITbowu4/qmHicONQq/Zwf/wW5IKiNy
	K0vGPiAlCLESX16l9TTgFqEaomKGhIcmw9XN1NWRUYjQtpl9lZ9CyZNPtR1fjufYNTKbn7
	7n2AgfQbHYBaXKbMBSmXzAoVREMRj8s=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-VFgxrK3_NWqfJvu2juTSxw-1; Fri, 19 May 2023 03:03:39 -0400
X-MC-Unique: VFgxrK3_NWqfJvu2juTSxw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-623a2273194so185896d6.1
        for <mptcp@lists.linux.dev>; Fri, 19 May 2023 00:03:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684479818; x=1687071818;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AO6FrKETDxtjwZlPW7uOFlquyK0V4HPBSRGqDWXQSkQ=;
        b=lOVM8kZ2xTkKbH46ylmnmK/wcj4Nr5RGbWqlcrGJuFMimuAvWKB9eI3+Nrlh91pOZE
         jXDX9PTfpAR5fgK9fE1s9v7e9rrn54ESVH65ps2qDQ6Eg/Sh5GGasBycS33coq4I2+2J
         3BzlRi+clyyi7QYAzZ0cwBO3ny1K99h+m92lO5cXMuoXoViKTeN8B0Djy6v91hxKNO9/
         vLdfU8Z+S7dWJrvNy0b40Hokdfx2tAzUGq3zhJJWqZmnK/r53iLvHPyvc6e07+DHElVX
         Io2I03YYZlgjtinExu4RD503Z1Jn8J/GVEDdMCqqebp7sKes79uLtXNEEfAhNq7RO3WQ
         e4yQ==
X-Gm-Message-State: AC+VfDxU5F34kZ0tvq0egGFNw/p19FSUlh0dhEYE+efGK21c3IfxonF5
	43Uk2ERpQyy7uggjszdbxgLgpzalB8VL/C79oJEytzXA1lqMppZF4p0R2XuRiInO1O9TmFg5BhT
	UISrzzu+QdhGBZwdt2quDg9jG6tmOm3HUdAVo2UiUe3kt38Dijs557UZ3KiPAPL85I9JWpGkf
X-Received: by 2002:a05:622a:1807:b0:3f4:e9bc:22e with SMTP id t7-20020a05622a180700b003f4e9bc022emr1827828qtc.6.1684479818367;
        Fri, 19 May 2023 00:03:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6BUCiCzvfH/myFG2WFBflK6Gx/teuqCEhH/D9Vu6ZsviyVitCxU40SBkwkkR9/nJxiMj21wQ==
X-Received: by 2002:a05:622a:1807:b0:3f4:e9bc:22e with SMTP id t7-20020a05622a180700b003f4e9bc022emr1827789qtc.6.1684479817890;
        Fri, 19 May 2023 00:03:37 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-235-104.dyn.eolo.it. [146.241.235.104])
        by smtp.gmail.com with ESMTPSA id t16-20020ac87610000000b003f4c8d3716asm1076035qtq.93.2023.05.19.00.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 00:03:37 -0700 (PDT)
Message-ID: <d01c8817dd76a6d427a72a752eafb2027969fd38.camel@redhat.com>
Subject: Re: mptcp: fix active subflow finalization.: Build Failure
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev, Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 19 May 2023 09:03:35 +0200
In-Reply-To: <9cdc6ccf-3529-8fad-5a49-4c1fd8d6feeb@gmail.com>
References: <41d7df9d8669b5fbfe70cd5551efc9245007ae6c.1684427027.git.pabeni@redhat.com>
	 <9cdc6ccf-3529-8fad-5a49-4c1fd8d6feeb@gmail.com>
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

On Thu, 2023-05-18 at 17:31 +0000, MPTCP CI wrote:
> Hi Paolo,
>=20
> Thank you for your modifications, that's great!
>=20
> But sadly, our CI spotted some issues with it when trying to build it.
>=20
> You can find more details there:
>=20
>   https://patchwork.kernel.org/project/mptcp/patch/41d7df9d8669b5fbfe70cd=
5551efc9245007ae6c.1684427027.git.pabeni@redhat.com/
>   https://github.com/multipath-tcp/mptcp_net-next/actions/runs/5016483061

The failures are caused by the pre-existing sparse warning around
mptcp_sk_clone(), that this series rename as mptcp_sk_clone_init(). I
guess there is some CI rule to waive the error for the old/previous
function name?!? Any idea to make it generic?

/P

