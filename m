Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ADF15E5A9
	for <mptcp@lists.linux.dev>; Thu,  2 May 2024 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714668020; cv=none; b=gwwq6RHLTS17t0NMKYm9mILWHD/fzwZIaEMj1FncZUeZuEbRvyUMeUXWT2jtyJ+5PmrozNnd0JedOVRlEDfErpB8s0CfVtg3YuoCnWVv3n2C5mL1wLvYexoylPaiEnAtLitR69UbcExxHB7Hb4Q6FA8Ul6wPE6zzMCt4pkq+DfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714668020; c=relaxed/simple;
	bh=I90x9TVGnN2Hv1kpG3iW6v21axngBVZRnubcCNbIXPY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=KbDK/IrVOrNEp8HugfY+SX6PXDr38BSSbRSArf4e8LrW+3D4OComMd/MvAydCiCN0XKzgITOONgt2qUk3MFwYsPseraN6R7yi59z9vWHj3xCs0KFhshkhvlpkfY9g0I4HQqA8B9Wb9zRxBEmAdYX27yE+LxaUzaIVT39evkTiQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K7w5WcFz; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K7w5WcFz"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78edc3e7cd9so590933085a.1
        for <mptcp@lists.linux.dev>; Thu, 02 May 2024 09:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714668018; x=1715272818; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRsf0S3JNVzVner/IJFMTq/U70v1TkMzp8fo/s4Iyns=;
        b=K7w5WcFz9Jj+xwR4rKife4gWoe3a4la801/pPTQIm6OfEXHq1NACtHBsH0k0NVff4c
         Timsf83vDBczQJmO9AKsequbvt23mIYAeCqSEdL6adNNXSBVkao996SU/UCG+dtPLpDe
         tZA5d7OhjQwKpofie2k26NN4Hd2d6DkljAbHo3ZwNZbhk9KlKGSP9i/shR/O44GTm79V
         LfGee63ZRZ1jWDYxEmV+gZtJNTq+RFTTACIIaNCTd0rXW65Cj8pR+Ld6pIIdcMFs9Enb
         GAxYzz+NnScOuhc/wtpaCsGycxitV1Gcp4JZzyb8SaD5ApuI8sK6rDG8JCGbNg868itN
         KFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714668018; x=1715272818;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PRsf0S3JNVzVner/IJFMTq/U70v1TkMzp8fo/s4Iyns=;
        b=H3jvq900drZiY6O0mf0Ch0+dLAijSEvPqgawph0JsQ/wyI9PxAJRRUk2OW0PflYtgH
         EDXJOJZI/5IXZ3lDWiIDHfyDVfdw5T9YEiklYGZWZviUtGNYfUbQCKhiBlu67D5TDYGQ
         waPkbNUlTszfg2cp77Rt8XBALHKS1eI2kmmN2Gqp0PsQu19q+higrTqwVyMKWjSuUYEu
         2UrhxfMB99+Bqab5l77oGn8VYso85LN6xHPU7VK6t17FTkJdTf0S85PYWTd3MgqogPGL
         pqpSDc99E9Wnkfp19mwnoCq3hfFJFrsurY8L/rxXkTovLUSHDyw5hrJKphrjiB54e2SN
         L6ug==
X-Gm-Message-State: AOJu0YwjJX4cBz/sstY3cTN6mqrhf8kl2WKqZeLPuPHzAKWSeuC4jAHd
	lpHnvE6MaC4R/bkQtD+7y15CEdpVD1nuuipNt32E3Jy5mi/1wxk=
X-Google-Smtp-Source: AGHT+IFiV6EIdrvRlDFc/HBLRU0G+TX2UNNrGW1kpmvFOWRTq+px4emR0AopNlCz/JGiCtXwnbLzdg==
X-Received: by 2002:a05:620a:12f6:b0:790:8110:f7a with SMTP id f22-20020a05620a12f600b0079081100f7amr84958qkl.65.1714668018091;
        Thu, 02 May 2024 09:40:18 -0700 (PDT)
Received: from [127.0.0.1] ([40.76.106.62])
        by smtp.gmail.com with ESMTPSA id x8-20020ae9e648000000b0078f1044bd68sm489558qkl.50.2024.05.02.09.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 09:40:17 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: "Shi-Sheng Yang" <fourcolor4c@gmail.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240502154740.249839-1-fourcolor4c@gmail.com>
References: <20240502154740.249839-1-fourcolor4c@gmail.com>
Subject: Re: [PATCH] [PATCH v2 net-next] mptcp: fix typos in comments
Message-ID: <f6957dca-fc24-a67d-4dc1-2098b6285a31@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 May 2024 16:40:17 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Shi-Sheng,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/8926914986

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/a9a443be8da7
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D849948


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
