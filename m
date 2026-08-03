Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04DA30F7FB
	for <mptcp@lists.linux.dev>; Mon,  3 Aug 2026 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752242; cv=none; b=Fe50CfSmtrl3u6kgehOs5GEtPAg2wucyHCtxTDW5mifnwMpA9DkmAAz3BjOMiSpxBwyLYvYQ2vxTRK4Ngz+g9zERunOpYHi5D327bBT/WEkcMGmDjF2idJsLWw4XmXXAw7Y12xS0F9ra+MC8nkoYte+RK0JU9spLXwkfQObhp10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752242; c=relaxed/simple;
	bh=/qLc2gWv7y+4U8/zB4uj0/aX43tdrF/vB8+n9Yo9a7c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=u+zfGIRHBpi8yDAkXBWV+x2oX1dXu5dYqALH8r15Xnam59ia9lhqSoRSbuEOcq6OJDAkJCG6UslS6WqWiUMKsv0TJ2Nyr+qpN35ezj28yk4hGjK9WkEFi7/9TVaCud+mvwjwMEsyCSLgXJKg0bxx9HPFtiY+wjJfonmnngyeygw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1vi7BA7; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1vi7BA7"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51bfe810293so14843071cf.1
        for <mptcp@lists.linux.dev>; Mon, 03 Aug 2026 03:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785752240; x=1786357040; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P+lbQwAjQpIfJy2ldhwp9wU0+jjBnWsFUwspXl7do6o=;
        b=L1vi7BA7WsoL6rRXqlcdB4d2+CRcD7hsZzWQqPHbRX2+Ekny7l0S3634ApzW78gLwo
         GqUp22xQETZzW4KGY7jjnSSvIqTWLlxGWKLp6RtIXWmqwCAFs0+heAkW5uQTQm8VaI15
         vAw/IXuojAMrg2IFFqJGWRVn0wVdPDn64rXBByRHwwRd7w0wChGn1Y2Bw2Y7B1u5HrCP
         Lc60xCRvevDmTKiX9uJczJTk3dlyGuwekvTe9amjY56RpFWp/Sn79uglvHXKV03ylrap
         3GCagQ+GEoDA/vhh4uMhMXZ5qM5CWhUzzpPNQWQb/ysZijECVqMsrQ648ZR9fSiufQdX
         Qhyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785752240; x=1786357040;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P+lbQwAjQpIfJy2ldhwp9wU0+jjBnWsFUwspXl7do6o=;
        b=St9Pt43TBQWswBjh22FALBNtMBaZ4sDqNyaFUJ6YsE5UCfM5QLY8Nc4k7efJhjKmQ2
         3VxIOJRhMbiET6lGhmNxvUTzsqrTOOvOSTX+Qov3LboNmTsDdM7qLh8vftNvGl0Zr25E
         JjS0rz04b6nu4+3Zlc9/jmEjZDVlBpkOUNvRrcdzi4lBEJH0c3/BIGaUK+TLIAlXD/VE
         nTimSATfxDeQc+egV21l8xkY6LAPNjjPTqjeeI9TB4YR3GRqXxijaxwPndckTlLJdTuZ
         dBs74/O3BOf/c7qT8Hl9cdLogBFi1ai0BKL16DmywXDDDKWk4qpWuHEj9nqO9+9fCqJT
         XuPg==
X-Gm-Message-State: AOJu0Ywh/tZ8fDKi0GSlaXDl/SVsmnDvYp7Eu6aoyb0efnETNkZF/7BZ
	65BIsK5PxzmiIbaJzCjf25M/86uK2yVdDD+NqJvGSkrNF4zpCz0pg0g=
X-Gm-Gg: AR+sD12I9Qp3pTwseqciLZP+pLUPX9ZWLINzsTKeMIlfdjhvFduI5ZSnL05XyveE/ZK
	B6zL88OCvIASZaJEyK8tcyNOlUWAWcoY+v2qmzJIjmeMV4L4mT2ye1P8sasFNyfWQq7aFP1nVCv
	8g8KAJacTe0B+/rcbw8ix+2FRLr5fQkWcbHBoA0/AjPXvqvw/l/A7w/kSieqQuhXX/gSLhJ2fvu
	6hlTY1FLdbSKPXM+VZGFQeddamD6+LAz2eGkq3vwP34qBWbsarigWV9PiP0OgbUrBAoK7Nq/Mh+
	l9QB+LFDdAk4uw91kNQsN8MikicO1xF8AZfsbe2Xuuit3N2uPM3v+9El9EO01w47gjI7cHwL9lp
	Fkl1AevrXqumg/4WFyEQFuk26hersa8fj3vbEbksJa94wJJQj92oUNCYusx9IKGwxB9ZrqNS42u
	hLHrzaxCLE7dsvq0S/N+2VeFAp44j29mArgZYpzklhjyZUsKAmrNDW/JLktiAG9R85nT6PRmed
X-Received: by 2002:a05:622a:1183:b0:51c:167d:b345 with SMTP id d75a77b69052e-52b56752f6amr161875731cf.24.1785752239721;
        Mon, 03 Aug 2026 03:17:19 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.13.160])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4eb6a84csm57197761cf.18.2026.08.03.03.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 03:17:18 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260617114508.253716-1-kalpan.jani@mpiricsoftware.com>
References: <20260617114508.253716-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-next v3] mptcp: honour configured min/max RTO in
 retransmit paths
Message-ID: <76d69c81-0af0-0e6e-eff1-baf5ff9ac9bf@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 10:17:18 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/308017=
14443

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/35d366633996
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1112899


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
