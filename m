Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8D33C6A38
	for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 19:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785179448; cv=none; b=CfsR4Wj3ENFkOPvbSOzzp1omWjcs15QrLJb81jXfLuBQcLbctPEc2KfE6AL8JwjGL+YhkPVAek1EXBigv6fEV6QQyv1BB/QOjULxB+4cptBYtIeSErSa23cJWh4Hdgq7WCwfa8JOFhBnFeZV2dOXFK0avX9GsB3jPOuc8x1kFOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785179448; c=relaxed/simple;
	bh=/bYESjV5LJX3RNZwZ7d9ZlJ9KLOzrOFqxGUZ9U89t18=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=aPcC976znr0qnvUgrDc/fiQ0pZji9MuJJ/Wu+O/lRe3DDdW1FXsKTUAQluQvdkQPbLJoF/Qv3V+Y0Z2CA1L3idI9SwR8HQ6uamD8mf7IzAWBXo++Gj1VoWqyI+GCH3wCSYfKE/ptCpXub/zaFytH5obeVNgCtsJQcTYQUtMo47Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rc9uHBGi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rc9uHBGi"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cea3004256so33091835ad.0
        for <mptcp@lists.linux.dev>; Mon, 27 Jul 2026 12:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785179446; x=1785784246; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ChfNOtpGZ5Pv5IgDXUybTjqnZuBx8xw6bl4tXlHNaIw=;
        b=rc9uHBGi+H0WwtkVX5SXZJ6X+CfofLc80yiHYR7CT1fGUCNuJ1EsS/C9h4L7EatUdx
         Fp7/NcPlOBLTMmtWhZpgKDbS0UITbaaTSR6Y2AekuDxbtZB94BWB6hzod/G3ripIPTp3
         D1iuzqztIferwuFNPFfe+YEj8HkdT0Ippf9bpDbMWy0pPEdstt1L8R/XGJHpvvG5BA7Q
         JMiWvPqcac9L88gI2jI+i2b3QIl/Qlu+SsIOgn+USPKdWILc3jcBF+evRYI9FZEGPAR5
         9d0ELviNjA2jeEiRQaDMSupowAnGcTgqPi+0g27PU2agPoMKfRIQVHjnF+ynTarWuvey
         3Kbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785179446; x=1785784246;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ChfNOtpGZ5Pv5IgDXUybTjqnZuBx8xw6bl4tXlHNaIw=;
        b=QnuSC/ezTay1d7k+ZMGst8wOwF+1ZQncJ9KMujxqC3tQsTkJGW535Ud88PS1c9DZlv
         ggDjcjnnHu9Dhn1gq4Bh0u2ChbqrJdkXLTaGtDZdFAw5laGHxhvSBUgQiDBWQL76EQjs
         wjQfH7F8eBxzZ2gN219Uusfo8TkCsNXhYVMfF37eF/karpouUw8yUM+R9lMc6QnKnEM2
         2EJD3KRB8r+B5zJqFNVmsxSCn/suOmCBMLXcRmd8MdUXucuVbcq75SC7H1xwcZ7NPH2S
         Qrlz/knR7sX41f2Nqnq8/AP+4mf5baBOhRn79ZxPsDr04lXTcY58dO3LFyMyHCbZHTla
         2c2g==
X-Gm-Message-State: AOJu0YyJiYuPHp2M7t9s1c7aN5szlsW7rWchfzcctVtwT/Pq4Z9iKQD3
	9vFpahTM1pxfY26dgTwZ/dQKSu4ZogyPTUj2KLskHoEAZbwaxiFSyiTApwS4
X-Gm-Gg: AR+sD13//ellCxwOJ8UiwpzQk+4a0oJj2/7yJgZKYpK0ZxjUl7GUE1VhX2gtpa6f8Dr
	xlxGUbhN0hi03JbC++3mdgsLiVeCisgxVA/h7sBBcNd2XiIDwUgOoxh6fuWoSbk912xVmjSor0B
	F2i4IBZ68mQIjrSuBxecGFU8bK0FuUldpDE6F1U5vQonHbGE5e7fIU0yLSsds6O8je/KIicaK7i
	cYag+m0Ul0H9G5clEOr4ITkJ4qKTnvoRP3cvtiU7cCtSNZ+OfvrS+vU5yWoiD683wv+YmmUdG1C
	/PhIFUeA8S//VHK/ILhV9gowcB17oPYbeV2gAiAo3otqdcnFZvQo1XukDr39xJfTi5kUDpDwxmr
	7oUu/zn63M8BgHpMiEuyemmp8S0sP+2crKqfcyV8jedK77pOeLLVGB+qRIDybYv1uRQD6uHVcPc
	qkO6QaEY7a6VY55iCMKQ==
X-Received: by 2002:a17:903:1a6f:b0:2cc:9179:335 with SMTP id d9443c01a7336-2d00f24d5b1mr4913745ad.8.1785179445993;
        Mon, 27 Jul 2026 12:10:45 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.176])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc579127sm30433744eec.21.2026.07.27.12.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 12:10:45 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20260727-mptcp-pm-userspace-id0-case-v1-0-9877f02a9bae@kernel.org>
References:
 <20260727-mptcp-pm-userspace-id0-case-v1-0-9877f02a9bae@kernel.org>
Subject: Re: [PATCH mptcp-net 0/6] mptcp: pm: userspace: properly deal with
 the ID0 case
Message-ID: <e11d7f18-0b7b-a69f-8ae5-c9ae60ee664f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 19:10:44 +0000
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
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/302936=
99277

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2ab5cea4a522
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1135314


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
