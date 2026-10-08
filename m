Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FF443846B
	for <mptcp@lists.linux.dev>; Thu,  8 Oct 2026 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791456976; cv=none; b=K0dj/I+mAl9gbTYfHWuj/MBn+sbX20au0SXggqnGU2ts/g+Gs+mmZ438OCLSouacsjWHa09ie/snzA/bQQdCvui92IMYZ2BSGbd7MFeDfKOLONXCFafYIhjQ/CWHHkj/K/b284K9ZSogbWgEAbAD1Vi4JiIQCziICa74H5dkmNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791456976; c=relaxed/simple;
	bh=ZBry7OTdHtSDUzVOKivy7oyNdCgnRP4KKbGWFwWs09Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=iiwyVSdhV0kWmskvsojfePRqMPAULotxQ9cFN06ywpcigZrVRu9/g2TBUWiyo3TzfW4GTBOyK3Ha7z+OTsgk8YIOydFkqRVdOUu1F1WXejudhKnyzyvKB+aA4HccFfoxSCwWuz9b4ZpaIX3RO08r/mjuSdh+9JYcQqrsFch9JcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1ukifsp; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1ukifsp"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-504ae5941faso452368b6e.3
        for <mptcp@lists.linux.dev>; Thu, 08 Oct 2026 03:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456974; x=1792061774; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xVgZwKbWZywUNlpf6eB/vyhy9OqPXZcZ0UHTEb/5/jA=;
        b=g1ukifspO6GJ4iU3vtMiH/7wZNf0zpPHm1kb4DUUSS36MjNr0EpKZDKsXCFMYsLg94
         Mf46ANXnkTplXw78dSpITocimqtPBD5rhGTeGYoies0UxdWLW+XQZ6vDsMDdh/7cQZjA
         owb/4FTx9NyHR7OlWw2rfmOIic6acy4zuwLp1QB2h4VHcaHSXtupqtU1RI7QsKINL854
         ILNboVClZ6qqf3Zf9uIsow/my2YXMcChEF+aTFifZ/4mHd7usMQJJArWMUngPDDQ46IE
         qoTrLYO7ae2YTjtPqednrUWoSSRGd9kAyV19ov6pQ1JaR/kKLttRZBi3vNcdpocqUjv9
         Woqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456974; x=1792061774;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xVgZwKbWZywUNlpf6eB/vyhy9OqPXZcZ0UHTEb/5/jA=;
        b=QBfv8jZJEjxdiYo7NHOmCaPlnrYe9pOzBWVDN21V71QDWyD4Ri7X01x27J39IAW/tk
         BFghtVX6niTMniyIoKZQrBY2PfccZKa+eFTU3Z3ox4tlOgQAhLkSDZLTQbOvblc9Bqq1
         /aS01wdEi2yYYREATZ0wLz4ciURnBPIoFpfn8jaSELjCT7Un2MCNQMbwarG9pRwHvkTb
         cXT/4HoGSDBaioSXxatoBlfKsCzWuWnv6FWX0QWezlIh2sIFHoTyIIcJH3TBlz8AJ7+A
         2VvqkbP960+LrVgFogD8Gt9VTQb3Lhp29mv4QtKwduYTMfkS25E5yqjs6f33YXiwrnQb
         wvhg==
X-Gm-Message-State: AFuF++nlF4SERoNmA7BHQcAlhUl5VtUPd9R8imxYNTC7JESJcC2saYar
	AiSroddDwBEasFXPOhfyMd5IkN1R9g1qREScyRLwT2W+3DrNezrPhIAGAqsW
X-Gm-Gg: AYBFou00y/oLREeaE1+rDxP6JKNGr4oLiiQhm0PLGmcEepViCvGGuibZ7CLQc1s5g3W
	G+iwA/lZvYX+mWvA8zr3eh17NxusISRDcYe6S08lY04jUMgVpVNPHHPnqzGHVduM2kEY61ErQAj
	dwe++x7TLSYGe3btr2NpKGfEIwPVOvt35HeWRzvmGmJi24oe1muDbqnjLcyQSI/fHh4nxXNsqHR
	IjH2ozL8vES3LAm840bd0TSzfv7uEAA+M1e1JK+SLIKB6uPQG7e8Oqh3lOSvamTS4wsZLRdDaBd
	piBJbwrwgKPfsnQq+cIqeEjWouWC18xnHgZE17MEzzAFDzmfAtUme/n81SHRGMYdsmnnOzYlcXy
	wtAw+5opprd9D/IlP97ANHJ7AO2/RGXjxREViGdwh6bjAqvMXCTFoR+tVvlSFmsH4w2i2iAKk4a
	uK12u77H3N03dk6QQpMo4EDTuukAQqi97J1QfeL3dBItCJYKJJQeopXtxfxsKXPdJV/Q0qQsFoy
	M1Cvz2GJsaruQ==
X-Received: by 2002:a05:6808:1308:b0:4f4:550a:3a88 with SMTP id 5614622812f47-4fc44c392e6mr4347605b6e.16.1791456973615;
        Thu, 08 Oct 2026 03:56:13 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.15.183])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4fc49a7594bsm4818360b6e.17.2026.10.08.03.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:56:11 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: T S Rameshkumar <rameshsv06@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261008095231.103186-1-rameshkumar.t@phytecembedded.in>
References: <20261008095231.103186-1-rameshkumar.t@phytecembedded.in>
Subject: Re: [PATCH] mptcp: push queued data on passive TFO subflows
 becoming established
Message-ID: <ce247326-f8e8-f190-c0b5-22cc79b8e450@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 10:56:10 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi T,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_syscalls =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/37761463175

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/4cb33181b6=
87
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1181518


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
