Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E833C76A0
	for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792085279; cv=none; b=R5BqjwjR+CdXQbx0fAWoAxN1Uu6cET9PJVBWlZe0d3IXP2xyEj24OoTW+OV+Z/vu89kueE5tK6/Ylad13VVs94kf9I8RRRC3Z1UjJA2SvdbUXy4pKQhEV4zZVZ9IjJHlxt6O72VZhnn5gbzTAlwtuPVthsfHHBlJtAZiw9eYmx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792085279; c=relaxed/simple;
	bh=y2mkOEHKUxXVBd/IWbDPzwSX5HUO7BmO5CkroPoNbos=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=J9eNFTBqjjFpCUND6m22oVnY+VGRfZ6Aw0imJv/fi1SL7QfV3ytCNd4o1ZaZLPTopA+IWbjVz0ka3VXHyG8+Gpv94tkR8sV5WEkgaUbmGBUwY/fHmCIGLRK9U1TQ7zp4Q/Sj9Zu8H+hm77VYzdkbwsAF9oOMZ7i2QGlZOlSYOoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUk3UeTe; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUk3UeTe"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-917aca1aee5so19759206d6.2
        for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 10:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792085268; x=1792690068; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=esfHFRZ4F5hZtFdhgOTb1x1u0WLU5PKpDjszCCKGI7w=;
        b=DUk3UeTeK15ws91kBs9/He7fc65Yf0kwYpX6vepofnrfXAhy8FGBBJ8sW92jkBheF5
         iRpHKPaBE5p7HhM1jCS7Rwd3LsvAc2QdARmHgp6YgHn7OP7YC1xgMphyaeFGKz3ZrF6R
         yx+8FTVOk4FclERI+te/aphNY2/bY/JCXDfbI1X4gRn66wFGetiPr1atpxz/KAOU/Ghi
         nAPfr87U9L/x6bVANz2fi6ThVUREw6/rzq5NLbXlj9PwOwrGJW/kzpF82VAodtNqMQ7N
         4s+V4a9zAw97GkIyetu4Su3gQwhnwhm+oYMYbZa/gEomTmidVZjgxFWE9DuEDgsXJuHL
         ZZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792085268; x=1792690068;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=esfHFRZ4F5hZtFdhgOTb1x1u0WLU5PKpDjszCCKGI7w=;
        b=VuSgn7HEqkC/vw02HWYO8MwI/gkEoBW+3CbgXByKMqLOySgLugAqa67tf/XceIQ6d1
         ZJKFJ/C3OPRWE85LV2YEhF3eY8z6O9g7Vu0hcIioAEiMoTDNRBf179B+wM1jGUL0JVSC
         oDT4ZnZ2+l7nEmJKWEOaJlxeFk8nnXKS0geGElL3tZlZ9dsZJMwrCET7DbLEuqS/UxfI
         AgihmLwb3xGhVlrQVPmUB4WqaVnDSrdDn6otKC+drWr1dPOGQ+h+7sCfpurL7KURxZ6t
         EDclDFzee0xHpHbRx7To8I/QZUowwQcN02yjioQW+AFTqzcQW8hLvO07DWPytpX+Gxmh
         f2cA==
X-Gm-Message-State: AFq9FYJJMLtfNuA0PFv/AeR88BYSaUNyPKapsXgk+bS3gn0iVMVWn8PP
	7icguPjktNl5lB1aAcEqikVChEVAI1HLWYVdii1NP5sDSxVecMZLCfQ=
X-Gm-Gg: AYBFou17LlddTmNW4mpbk1mvma+nt0/ANCYoCF71AQvUL0jcGB++l6oCAiiTrvx8nSh
	KnxawjtdfWTjY9yJlKWCZWcwYGZamww6Wj+lXqswYRbQv5vlZd1yuk5pojK2rCtm6bHZxwV50vO
	+KYiSDbjqkct0USvhdkwmtMfes1Vlm4dA1ju+fGeyhLvtEguBuSFqLN+q/239yuJkUPtmI5dUSQ
	0Y3f3wcGO5LylvBRh+8sgTQZrKw/Ei3sXTzQk72+KEAAqLcQwCTqPOGLZzEpIZ1VYfjAlF9ttoT
	pJSi9ZcAl+XuDk5yFLkpfURNKlZAyiN2TI6GKiEc9zyLe2YyGQHiGHK2Rp2rqSu9bcZnCP6DZia
	EPJmQPSvNuyXEg3X9zKKE9iPxQcXnppheqjieKQksiFQsADTbItxUt3IbOVe82Ig5RFTS+9i3In
	GQRA8GAqgrBFLNJLk4LTgl2liZ23c1gzQRQpDlk2APqvYmRWLtIZrtDRZijxVwCmSo6aqPf3lrf
	/T0SFysBG2OMgs=
X-Received: by 2002:a05:6214:3484:b0:91b:bcad:116d with SMTP id 6a1803df08f44-91bbcad1207mr40709836d6.28.1792085268197;
        Thu, 15 Oct 2026 10:27:48 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.101.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcbaae539sm786846d6.20.2026.10.15.10.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 10:27:47 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20261015-mptcp-first-disco-id-reset-v2-1-49b71541b059@kernel.org>
References:
 <20261015-mptcp-first-disco-id-reset-v2-1-49b71541b059@kernel.org>
Subject: Re: [PATCH mptcp-net v2] mptcp: disconnect: reset first subflow's
 local_id
Message-ID: <411636b7-3eac-22d6-ee3d-d98d134f7527@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 17:27:46 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/38770828855

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/408d73cac9=
ba
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1186634


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
