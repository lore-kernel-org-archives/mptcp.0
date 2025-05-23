Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E620314A627
	for <mptcp@lists.linux.dev>; Fri, 23 May 2025 06:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747982160; cv=none; b=oQ/tuATlvN7RqmM18ZNscJ1qTEF2kSeVD0j2rxibLcKXu8hRCSy3zpbMzLPkD9cdMza7zbaAkdfnpGSAhrvvDo+iWveQAXUZIk03vFlS7HB8z11e/cBlrbU3zVmGQZxHYlZLr6+oK1ujinJE6sWfn4bv6TAXgDVwEkISw91ecJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747982160; c=relaxed/simple;
	bh=dxKb1QTvFkNTlttMFCCmEyefttRoBW72iMVZ9qgfAhQ=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=tAFzstWEVNaUEdLxoDYVi/pYh4fC1dSVztM+wY/MsoTTfdUNnTuDDvLsN9d4qOJAUxhv6GeVwACpJ5DzQY5bzCRDD5LFKU/kapHT60hcOgOkwXZOV8yCfyewlAKp+iQkQiQWUU0nztvSDBXzlPSwBEtAtg1UHxrgfT21U0Y5t8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6FwMEfp; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6FwMEfp"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c5f720c717so68209185a.0
        for <mptcp@lists.linux.dev>; Thu, 22 May 2025 23:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747982158; x=1748586958; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCfuc7xoJoPp4HFvke7ds1UeMWHrCWuZRC+oZwvSAxw=;
        b=P6FwMEfpqbkMxmoIzhYoWKgFORFL5gTCIJHnDiSsFxLaPhcfPhpMrKPUKepziKIGy1
         qWS3OHidpdhFhPKkO60dc0qzQhtfX+9x+TRFmL8svEBGJTqcNgOLtPeJs7Re1H6Bg+/C
         z2PVQxBukGsaL5N7QrorTxIlNxcAKvZm+9ZByGvHL0fYSMOo04cUahDXpCCOeOSmW80v
         YwO10cNBdvxja4H08WHPvchGWHtBHlxa4cEp3Mg4VD+/8hC4qU8emiGS9tGhwTf4Hz+i
         wfw/Cft6/S8Vdi9u+M3ontrjXynxaAXs8YxgWr9V8Wt1OS8tG+E8quyEbVcso/qcAUCy
         ZYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747982158; x=1748586958;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HCfuc7xoJoPp4HFvke7ds1UeMWHrCWuZRC+oZwvSAxw=;
        b=exh1HD7ELZxWLrW3uzj7igXdYUBjnQrNbC2fDHiM4f+gE0qLeMrdrke3c7qBaqCDYx
         MPoQWnej+Toz6n7bHK27hZHJgqd32NYAJsIJ+6ZwJ9kcWlbrF5zW9WRyOQehqgFWFUEK
         sGQgr0WdzFLgxm3AyN7PerU7nAu2o5lMQxPiWG+zQmuyg3YvgB+M7xwnB+SVZkdyEtjO
         vM5LETw2XUhxJGCYCKejed3UIt99o75o/nhgGznDhh/GIGeDWLlX5hbjX8i7mN0/LdmD
         C2xQwUGEFJZJnopvzh6zKpq5vqqbf6ux+ljM4elHZdpNVV/oc4cuaKiPdcaLfkir8iSb
         dhew==
X-Gm-Message-State: AOJu0YwrYL4SnraopKV1wI2mo/JvuZ/PPEqXiwf5fqIsY4+Vvdy4BVs3
	1fjXZ44OuIl1uaRPiJc/YADlWsGEtmAYF/l+cdX1iZdbM+V8IjSss+4=
X-Gm-Gg: ASbGncsuD2aaaAGKPPRpnZHANRs0DfT1ANtGGxjny7HaEBHl9JGaxvQHJ3vg7l587Fa
	jNXuehljKbAmdnS7Txb2xbdY1VTy0ZOvnL6PAX4PGAdOiKMc7GjedWYl2VIesIvr3C9ld/kPGQi
	aHgM13JViwcycjzBu1pQDHvXcVT+5Md0nVfbfGXFS4cp2oYUJHYgfnizxNwcPq7uMVh6kIMOQit
	ktzhSeljBZopS8THCjKtuWF7rdwtiG4yXiyokDFeC7ITchtrQix5NiRHchagURm14pS/kt3JoIn
	YvKNolvUonF73K/J1xLRtmzP9JJZbA3/5aBaZcvA9hLzZs7buwZzlJVJ7ZJ4EnD+
X-Google-Smtp-Source: AGHT+IEgdFjIw/TjAeVV+JlQVHgKhiPP5QPPg7d+J3AsBsecRDlrOzOFEL0Me3G0SU+IEpr4tvdDyw==
X-Received: by 2002:a05:620a:1a97:b0:7ca:f010:665c with SMTP id af79cd13be357-7cee2259aefmr355468785a.6.1747982157719;
        Thu, 22 May 2025 23:35:57 -0700 (PDT)
Received: from [127.0.0.1] ([52.184.158.37])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468cd124sm1130288385a.100.2025.05.22.23.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 23:35:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250523034433.1373-1-liuhangbin@gmail.com>
References: <20250523034433.1373-1-liuhangbin@gmail.com>
Subject: Re: [PATCH net-next] selftests: net: move wait_local_port_listen
 to lib.sh
Message-ID: <d6490c86-dd65-21e4-0343-1cf9d42767f0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 May 2025 06:35:56 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Hangbin,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/15202060946

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6dae34f54456
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D965637


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
