Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8595338E8B6
	for <mptcp@lists.linux.dev>; Fri, 22 May 2026 10:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779445919; cv=none; b=ndY7cQ22+O71vdXMVZbE6yE19TGVLjh3H3rmQCTwc273snHlZzi2t1zefV3vdDiMl28yGbkSJw2GDIjefrj1xqahppue6XWMZhR+fS81pVUk48zT8PeuCLXdrDIbwqet1zIQoY5bnv43KDYY//qxHyUMXJgH3U9eC6As+7eDTq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779445919; c=relaxed/simple;
	bh=6pj+YMYjrXcCvVfjT1J0t2el7/g8Sxt7GZkphbz7EXA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=qoHbiY+mEzTHGYSUu3E3RSEIMfBa0BAyCgU45ioCT6YSN7VRX9rkbKHVpQeAKwA87/chtToqdsAQPGD8dqRwXufnV4F3CYANqpxGhUxdeEHDmlnKr9bqlfgiONmMiwQI2sw/SMIggNyvUo0nLMwTYajjHaK9uDCn0iZo/2oyh8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdMv3LsS; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdMv3LsS"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2f0ad52830cso9208923eec.1
        for <mptcp@lists.linux.dev>; Fri, 22 May 2026 03:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779445917; x=1780050717; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msIJmSTdMDO6CQdQRtMheFVhBhOqRGERp0t1bMHycys=;
        b=NdMv3LsSU/ZqBPmyIG67EAWKR2T7CwCHVe9nDdrXF4IWa3Yen9X9lPn8xbZkphZ5D3
         DMeoonIuhDfe8qeZQ1peDy0adjOSsWLJJV+cOw0rrtqupVXn27AXHmiiJNdez1rrNRdg
         If/m+9tC8YfnraWKEvv2fSc6PywoWT0czkfJHO7NFRs0YiyRJf1IMJczGuNxFmN/35YC
         kr7V1kIZFgJpJvtdf9ooWcavIJjtW5TwPwvsDK8JSENELgwtSI0zf9zZjGMtyerWgFQ1
         u9QKBAlqTmLxQxDdvc5qbnGXXq1MLTU/edMbe6sA1pL3MKTCMUzdUejBHKJdImo5Oct3
         o0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779445917; x=1780050717;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=msIJmSTdMDO6CQdQRtMheFVhBhOqRGERp0t1bMHycys=;
        b=QGQhM7J7J7TlscbxriEaWpm/t5OTSmzWuGLbOvZBqOFHrCN2MJVxe+yK2Lj7EJo0qP
         TrpBGmn8mkvJh6X6sBac3+tZAcpslvZucq+PyexLXQiopC3qP5/X9BAwsca6ME3SlY/t
         QN2N7gRIeu6XLo4D9IzDRmMnd4i0Hop+q4wfrIg73Pk835mnE9CHd2Ks5RJSilL1TLUu
         DRHp+nErBoIJL+l/CIs7YHtWfo58005etEuU+RhGrTwGInbmuyd2Ys2VS9oKpSOMGDM+
         puu2KtOMu8nVYpxlCsRKmivnYVvtpSeWaZh6XGjnEn53PEm4eQzWW6uWLDy2WmTjEuh9
         w6KQ==
X-Gm-Message-State: AOJu0YxArbIGZvUnvSNBvhFh14n0J+t8iZfbwmun2VCobfgoHkgVH4oE
	9wDp6ppKiXhuIilQJD7oJhPlTiJoR7VmAK8gDNEae/+35zVo8l/n/7ZFbvLQ
X-Gm-Gg: Acq92OEFlsmkjbfS2MIrmJbhfG9nL82PSg676RvCCWU0RZxQwY/EcRuocO3dpNeL5YR
	AYoG4ihL5J5rc9GxCnP2MZlPjxmNiJojP92i5gKGV9Law+7zSHVKYfAByej+ajzC+HRSgvxNRIm
	jm2fJCS+4EdVdcm0SgstKMGicw3V1J04cLTYtzx1OCBFu3EVVBRyR0ZxQxey9Wrw4zSaTKNpjMj
	Fkjlad0bbRcqVg4moj76IfnXSiWKIOIewd1sArJd+49oPdBqBAFVAdKRzoR6JSnY9X02LOdWuxL
	tRrINIFehaqsBmcoFYZKqF2yPw/R06wCDdz1keQ1raP/zI5X3fgvqJo4oEMXxM48tQjHvSAX9Gb
	69N7nqEZgb2kYsJGUpumVX2PR9kn+2cNluyrShw/hAdZxduVO7lqwfiWky/vgowSWtsCoM33vNv
	n2yNmAYGrdMuJnaV3fZkP4xOm9PQ+gThKZYLIclZSbCwlRIb8=
X-Received: by 2002:a05:7301:198f:b0:2d0:239a:23cb with SMTP id 5a478bee46e88-304491858e0mr1368989eec.16.1779445917483;
        Fri, 22 May 2026 03:31:57 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.201.88])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm878410eec.13.2026.05.22.03.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 03:31:57 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Tao Cui <cuitao@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260522085049.1896537-1-cuitao@kylinos.cn>
References: <20260522085049.1896537-1-cuitao@kylinos.cn>
Subject: Re: [PATCH mptcp-next] mptcp: pm: add WARN_ON_ONCE guards on
 extra_subflows underflow
Message-ID: <1b2b5eba-35fc-b12a-8f4b-e306e0ebc119@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 10:31:56 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Tao,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/262786=
64847

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f4dfb60196d3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1099223


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
