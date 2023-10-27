Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5CC37167
	for <mptcp@lists.linux.dev>; Fri, 27 Oct 2023 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aXg7HcDj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698418782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2TgN1k3djcVBmCZhn0kDF8iwk3GH5FHUSi3X/tAxMxY=;
	b=aXg7HcDjjME2S2iKjuvrmYeKEaDo8/NxUQLJ08k5m7+n+BAhmPP4O+ryQ7kGXhffBdlxzu
	RhxKczUNOJ7lkpbZC8eIQmIM0rPFuL85Y3gs1/ml2H29Xh05HFfdGeNGPzY1StAQyadXr6
	VmIFak4LjXxX1NzFWXZl49xqZozBXjw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-cC9KdadeNNa1Daq7dmlz9A-1; Fri, 27 Oct 2023 10:59:40 -0400
X-MC-Unique: cC9KdadeNNa1Daq7dmlz9A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3175b9a0094so199306f8f.0
        for <mptcp@lists.linux.dev>; Fri, 27 Oct 2023 07:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698418779; x=1699023579;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2TgN1k3djcVBmCZhn0kDF8iwk3GH5FHUSi3X/tAxMxY=;
        b=s3Vk/ItQtbZRhx7sJ+1h7x+Xfh0gobT1QJDgdoDFkKgd3rnHCc0l5CdC7fgl5xbYsl
         Chh1eBvPJbawuKTKieFxkQ3MPHdrqYO6PSI/FE7piwpCeXQPd81a9muZOtVktAcoFE/0
         AF72eVFwGtthE4tcPV+bbt8a1CFRj1owBWglq0pahfmQu8gpOWbAkN12OnKQyv6L7s68
         372EnwNPgexGtG8g5v8T+vH48TWV+fsnaolSk2BcGTl3ujbtd4NshKej3GM1GohMG7KL
         Ar8nYkWJgoX5mfY23776eCZhHL6MfGwJn0U00PWyuQp3hYvfklUtOazCXY7zwfrwJ2tJ
         8P8A==
X-Gm-Message-State: AOJu0YzyPfxDN69FjCyT0DDIt6JiHWrbMkqdaR3VQOgUYAx+2M5ThEML
	3rO8JxxKb6GSPYus1zjwQKdG9GD6c1AOwk5DB1cnWMeZe3Ef+M3MdZnYqIlceb0cgut5qugdZQj
	D7q1Y9tIKw5+YgnxjOTTNFXhhLOM2N1mbL1uxsCoSwfbZtNj0e7fcKWKxNxyH6f59DsB2p2mN
X-Received: by 2002:a5d:598f:0:b0:32f:51c6:cd6c with SMTP id n15-20020a5d598f000000b0032f51c6cd6cmr2220880wri.2.1698418779179;
        Fri, 27 Oct 2023 07:59:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJhr7KKUX1X03+1zNNKXPtLna8lWz43oljA3/pXEYKON9fH+fJ+TNwQ23Rerc6xeXlUtPAsw==
X-Received: by 2002:a5d:598f:0:b0:32f:51c6:cd6c with SMTP id n15-20020a5d598f000000b0032f51c6cd6cmr2220859wri.2.1698418778660;
        Fri, 27 Oct 2023 07:59:38 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-232-178.dyn.eolo.it. [146.241.232.178])
        by smtp.gmail.com with ESMTPSA id g5-20020a056000118500b0032da022855fsm1939264wrx.111.2023.10.27.07.59.37
        for <mptcp@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 07:59:37 -0700 (PDT)
Message-ID: <69ab206d701874dd5ac39c45ef27affe1a67517a.camel@redhat.com>
Subject: Re: mptcp: deal with large GSO size.: Build Failure
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Date: Fri, 27 Oct 2023 16:59:36 +0200
In-Reply-To: <7dafaff8-20c1-be33-8044-e05d01a1399d@gmail.com>
References: <ce93989da39fd2e47baa4506fbbf4c2049c2da13.1698416467.git.pabeni@redhat.com>
	 <7dafaff8-20c1-be33-8044-e05d01a1399d@gmail.com>
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

On Fri, 2023-10-27 at 14:42 +0000, MPTCP CI wrote:
> Hi Paolo,
>=20
> Thank you for your modifications, that's great!
>=20
> But sadly, our CI spotted some issues with it when trying to build it.
>=20
> You can find more details there:
>=20
>   https://patchwork.kernel.org/project/mptcp/patch/ce93989da39fd2e47baa45=
06fbbf4c2049c2da13.1698416467.git.pabeni@redhat.com/
>   https://github.com/multipath-tcp/mptcp_net-next/actions/runs/6668654076
>=20
> Status: failure
> Initiator: MPTCPimporter
> Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/3ec0ab80=
00a0

It looks like the (upstream) tree is broken:

 kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_new':
  kernel/bpf/task_iter.c:919:14: error: 'CSS_TASK_ITER_PROCS'
undeclared (first use in this function)
    919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
        |              ^~~~~~~~~~~~~~~~~~~
  kernel/bpf/task_iter.c:919:14: note: each undeclared identifier is
reported only once for each function it appears in
  kernel/bpf/task_iter.c:919:36: error: 'CSS_TASK_ITER_THREADED'
undeclared (first use in this function)
    919 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
        |                                    ^~~~~~~~~~~~~~~~~~~~~~
  kernel/bpf/task_iter.c:927:60: error: invalid application of 'sizeof'
to incomplete type 'struct css_task_iter'
    927 |         kit->css_it =3D bpf_mem_alloc(&bpf_global_ma,
sizeof(struct css_task_iter));
        |                                                          =20
^~~~~~
  kernel/bpf/task_iter.c:930:9: error: implicit declaration of function
'css_task_iter_start'; did you mean 'task_seq_start'? [-
Werror=3Dimplicit-function-declaration]
    930 |         css_task_iter_start(css, flags, kit->css_it);
        |         ^~~~~~~~~~~~~~~~~~~
        |         task_seq_start


/P

