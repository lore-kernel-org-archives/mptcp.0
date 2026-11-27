Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791448;
	b=OUfgRkY9J7GQh1zL1MUSeM3pISfe9u0K1HzsL1J+5jAExvUs7BNEs4G2roMfGmtu/ipu
	 InC7zr1c1qGj8g8DbJU65MioDiJqw7XOipaEpGxKibo386zzzAJ3AAgWRqDGEO80P1sOh
	 8OaZ4l78doZ1N7sYzCQcfMabxu67DBII5+xS/HP60CUscLS5Vwu3vtcMDLsEuIgAU8PVi
	 qPrUHufMCuvc/91wrt8rib1nDjSk96b7FQvigp3HnS1VPw8WVpyF609eVVxnvMoAXDA36
	 8h3PBuCcBfCXHMPxwZ5NADd+Y6AGUNnx8ovS1akBJwIVfMPchljk02osGO6t1QKSb5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791448;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=otHGx8gIjbplwlS4iw/HJBOo8L5zEkqWLLOxTdIAlVw=;
	b=ke6kIn2Ih39fgQuz7rfTfZVyznZSCOtERPTe0rdXi28Q9Pe01Hxsph1mjXrp/x8r0VNh
	 gS5OurVRkUj2W4ePHFBHGa8Cj0HOUkMobTenM+R3/pNApvB0aAYdPv926kSaOGZ3D50CH
	 0fV3TaJVxyvfkx+in15HNydIh5UzBndd389lZXzFa4uC2f8al46xrDuIGWaOQ1uF61Azw
	 nPtdyHcjCoLG+dEy/GUQ3n5jIHZ2Dd7WKffJnoiQL9rBvw4Uyu459qzVHAP7Di+trS3ON
	 wn2i2sH1zfzmfNqqSRC/peqWtmlOknt/gVUpSFv8AtEruVPPV0uO0YUWwAvgaDDGVfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="xAPFx//O";
	arc=none smtp.remote-ip=209.85.160.44
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE85606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 14:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEE85606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xAPFx//O
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-451a49abd8aso7932448fac.3
        for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 06:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795791447; x=1796396247; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=otHGx8gIjbplwlS4iw/HJBOo8L5zEkqWLLOxTdIAlVw=;
        b=xAPFx//O0igWUtgiBtVw+lWVfYSQjNaoa62LqS6ZnLIS30MiCya94wiVdnlOvueyv7
         nH/61uFgUpbw+bFWIdllriLBb5jKNg17hQ7XGjckmunzN+mPwE8ZBjXDMxL6kgpWfHdg
         1hxp2DOOz2jj5uoez4NVqfxS/zxIxAMeCjwbs3uNRFzJw0UfH0c6fdDprFOP6AOdgoYL
         Tdf8w1M+QUxi5XDGq+qaOIOAeNpNAXkx8eqs4fqggY2/KobHOCxb58+GVvSRgl/fEhkr
         WbOggdGBSoUaSh44jDP2baDEcpMqHQg5wde0mmAod3uYcgqfouto7eUq9FiYgozbSb9K
         GDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795791447; x=1796396247;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=otHGx8gIjbplwlS4iw/HJBOo8L5zEkqWLLOxTdIAlVw=;
        b=TqxUp6efGl+2pvCEYbBg08nsIXB4NCZIRd2Og15gcfHbqJwDOgkZ5qrLDx33jhvd27
         KBN6+21GLHehvD6neNTjVMiA22tOoR3NvmpU6FwYwqJ54A9YJtgoCliKbw6mrrWL2aE8
         +8qDnFCt22TQY/l7VtyqKINDwKE4fKV1czZYz06WKaJHNipKwtVTzootX7yE7A3YKYfz
         zwogsQqgz98RbBeeQ9G+36vATFanbOUadAu2fmYF+thauAPH9tOymDacBlzIQFGGAaPt
         AdeLf57CBovKf0bsreIPIJ2t/ZyPmNfSQD+4HAPQKVz/GFuQSayxjONnZxCpLqFovHdy
         5jHA==
X-Gm-Message-State: APuU4Z81XiXf80pjOe69QOtZm3MeRgb1WA4H4nfi2EblD5f6WqDXiNTO
	XlxGITa7PnmUVVjzM2O4gRJHKXwW4KxxVxq01SIOBmp1blAmfpwLzKgov8N/8eg=
X-Gm-Gg: AZFdTZdLuBKp7nrKDI4QuNrUGxJW7dLA5VJVGLOEhRvLW0MvoeKXynVG8Audkfwllwa
	p7UINMdr8a0+juOpqcepzCnZdl2EtlCOGzGkeJkaxlh1SxGNNOHIpadaH7vjvz6F7MICDFRQYr9
	BN9uJ9EMGxfhzIBdRy4WmMND7RKMBy89qdb8imbz5FWELRkQ7K93sDp50RWT9/4g+mc74o7Rqzd
	TbiEjG7AkzjxaP2t/2EDO1DwiAflwEl1vl6GD0+GHUavtI+kfvAwLNesbf9CkRtPGrHS4CrZyt9
	8rSk7HstmBEFFGs4FYFIRM7AIpwQb3WR29hzxD74LKSGfI12efbIA4XCFq1nohwE2Ha49fw92mG
	c+3lspLktHFNgAOWndNCxsgER95FR0O8f8iQGibvjVoGndqD0tlnS7KxLkAJwZ+O8rnZPMcYlV9
	x8ooEO12aiTyfrebjV2bxbixMRmDrmw/Tiu0c2vDznNOTjZATz//XgAaDHv9ODWwjo+n6abj3Un
	c7bApPEUikgQXS1F0nT17azGbmWY3CqJIDzYm8tolOwFrCqctHauYhbDMZAIJz5OOqLWC6T13bD
	NPNHPATAIVOH33E5FueZPUikDR1nZ8mO7wEpd/EHzxkC2g==
X-Received: by 2002:a05:6870:6109:b0:4a7:4a7a:1e27 with SMTP id 586e51a60fabf-4bc84b1d52dmr22411176fac.48.1795791446641;
        Fri, 27 Nov 2026 06:57:26 -0800 (PST)
Received: from github.com ([172.206.179.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc5fc97bb2sm21420358fac.9.2026.11.27.06.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 06:57:25 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1795783388.git.tanggeliang@kylinos.cn>
References: <cover.1795783388.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v11 0/7] mptcp: add MSG_ZEROCOPY support
Message-ID: <b64fa550-9887-9a75-f6ba-d0b21c02b527@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 14:57:24 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_regressions =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 4 failed test(s): regression:sched-clientlim =
regression:sched-serverlim(2) regression:sched-weak-secondary(3) =
validation:sched-loss(2) =E2=9A=A0=EF=B8=8F  (1 improvements, 43 new =
outliers to review)
- Task: https://github.com/multipath-tcp/mptcp_net-next=
/actions/runs/46004391728

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/490d6634d8=
51
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1224465


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
