Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F22224CF
	for <mptcp@lists.linux.dev>; Thu, 12 Sep 2024 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141479; cv=none; b=GYD/TEMRVqJs4jU3A1qhCuPec42Rsrsxw//s+mrpviD9FlQlnqW7RgYfqjSQa6jc+Fb3bYuQ3eUKwKvkjH8iN0nYugaTTPy/vh6/2NbxMuJxXzVo6HmVhwFiVdCFxLbQfjbavAhWpoVhsz/KH+JKoAYgaSNJK0ZAIYHhw0U4uwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141479; c=relaxed/simple;
	bh=LRrKNJgeLLvpBU5zmLdzTe6Q48o5TN0fZb9hz1CCKg8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=UBW5Gw6fCD/NHFbj3BwiAzgNU6GXmo/wIuErtuJ/YAVKj9pfQ8dz/vqFKfE45SZAIYuUliaLyY7o0TCscIrDfD5HhWgIIk7cGCm4Mochpp9+fEnatURtQ6Kuyp4yCyx0+AFBPWVjAccsI/DShwKWQG3PwcyPWayjCsKLBgw4gRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOZqz5g8; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOZqz5g8"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-458362e898aso7109361cf.0
        for <mptcp@lists.linux.dev>; Thu, 12 Sep 2024 04:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726141477; x=1726746277; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onLECxJI2b2+WyZbafLp0qlIHt+o3oKQNcAiwi/nrE4=;
        b=TOZqz5g8t2CixdWbHHmbZlKwC1YEUpA7Cun6fgoWytEeal5/aDleG89OvS7Istsfnf
         WwhaMxFTJxywgdyHfb3qkI3i7fyKcU77f0dHmBvm7HuvrSVoiAcdvw1s0YvDH3rO4Pp8
         Ud87aiOPQfdk3VCTVna6C3/VjeDsQyMkLEcFSt0XiCRpMhw1qJKXfxEbfUflUmlTywiL
         pKBjYXXeVSDAuw4kRN53FH2syFeqlFTG/vbKyzkOC/v8hwyNoSJOyFqbS+0heptz3ol3
         po+ln29+/p/ghXuabP++bodwCDUC+pUzRk81jlpTAEQawnQ+8WOYOHGEaAITNdDsP1BW
         lSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726141477; x=1726746277;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=onLECxJI2b2+WyZbafLp0qlIHt+o3oKQNcAiwi/nrE4=;
        b=EUaO1KV3VmnvQqnwSIlMclYvfsQBcUfDabNxhi7UrgnnMdFSY5c0D+8deEn8n63beg
         NGxe2PnG+T3sLDoGqbETJDhwR+g+CkV8IYplWud9KTK95C5lxfTu6YovnqtGM4Llwpla
         LMbMgcbMXAoim540GiaxKbpzRzLZ2dw9nRjabxRTI0CVwxyjiPhbclA0SFtyrZuOWYIN
         6Kp1AXIjzam5N2aDoxu/O0LUTMcqE2lFzzSfVfW7/iGgCqpXrsD4wvzZXfiYGqMK1TPY
         3YPErjDpAUnHr65ZpWudTMSmj4/QIl7kHun1OoJe7fsqVOSJEBH+tp7e8qEYsWm7dfxV
         bReA==
X-Gm-Message-State: AOJu0Yw+I5INQyiptQ049gzAV/O7cYSw9DRhfp3H/MOsMeXV+rhdCZR5
	sNkrw+aCpsbklM9cqowTFmRbuqr9+zOISzyK0pgNKQyPU/1SAU5c6LbD
X-Google-Smtp-Source: AGHT+IHmSVCswko52BawCiE91DcUnzE4I+vgQvgntGFN5gWWt1nbppBeHpZkms5GIZjDfPYnaE0TIA==
X-Received: by 2002:ac8:574f:0:b0:458:39f0:f67f with SMTP id d75a77b69052e-458602df912mr32332241cf.24.1726141476836;
        Thu, 12 Sep 2024 04:44:36 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.14.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822f608b9sm51758451cf.64.2024.09.12.04.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 04:44:36 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1726132802.git.tanggeliang@kylinos.cn>
References: <cover.1726132802.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v5 0/5] add mptcp_subflow bpf_iter
Message-ID: <761d8550-fc4a-c98a-f013-dc69a1c7e58a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Sep 2024 11:44:35 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10829533086

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f12243725ecc
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D889689


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
