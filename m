Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238D3ECF
	for <mptcp@lists.linux.dev>; Wed, 22 Jan 2025 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737558237; cv=none; b=W4DgLNw41JDYkIGuuZeMNvLYNtQ98pgM87tvzzoBd9P6HpIMVCK7Y4hdFH4TQKAeCpma86wHBwrJ6xFGbQqR3yh4pIFh1DXIurjge2JaqjK+fTq8yjq5RnsInKo+6MnAdTukvRO8lmp1gd/6Cm+gJNs8d7CtKWpoM7tzNReA4Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737558237; c=relaxed/simple;
	bh=3BFcvVmCrTUExAjl+iJufmitkY2nz+Mlfil+ISxJecU=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=XcTpktJjWT3XP8L2N653+hC9qnNIaj4AyKxfR55/tTCtsS6PylakqTToz08tbfXEZ23etzi5doBOX4VIpLZGZ4vg4cUwwiDCwS2bFUIKD+FtTBYjkCfFWGxEldtvkG4HRptzpD7Oe33piYWm+m+nvgXNTnDqDeHrN/hemZGtggc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MymRoCkP; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MymRoCkP"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2167141dfa1so19892515ad.1
        for <mptcp@lists.linux.dev>; Wed, 22 Jan 2025 07:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737558235; x=1738163035; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItKLLDmuM2BQzLOXvDhYi+1MEjSLQyTuk9jYQzxWmFE=;
        b=MymRoCkPF+8rfBiBTBtU03Vgima77l1gK3Ia9ImHTNindrCDbSvpiesfw9UR614IB9
         vHRWIrhJBbRL+602jJtTcfGyzJwMhF9rglSGIjaQhmf3iCPOymCDKpm6V4Z2BvTOjSj3
         bLS1yXyPDxOtXaqtjb9rTqHgRdVXBQ6jBe54sUkaGxcP2NviqOwCEBN+LPZPs1JwKrWq
         kkv2aVf5By5X1vXo4C65wxSE9e2zoQKWSqtNXH71WiRyOdeyCoLxkidNBkPG9h5RDTuo
         j4RJ75pF+oeDO8mEpRsO/FsU3sDtBikjnHSVfjqlEzPif8mUIML0iOAcdlO1UEV4wtnO
         ZOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737558235; x=1738163035;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ItKLLDmuM2BQzLOXvDhYi+1MEjSLQyTuk9jYQzxWmFE=;
        b=O02Cw89IB+5E1dD6D/Zq4W1OtMAvyIfm58b+vak5+9hJzxeCgbmqf7KhaZOa8oHXF1
         LcAQzOCJ3KAFP+QeUNIZvf7QjTt165AsNClgMcOyrJDwOyGYRkBEIGrrNeHhXuU2lGwB
         cLtQ74RLf+fU/g65fCnsNY0akvhh6PVKHPTNDcDRbXQxPhmi0z3TW0bj1Vf3l4ve9R/O
         fmZxzOPaYHEuhrB02A/HHBX6GZWJEjFc6hB+Bl9FyaNXXcCepnmBSh1dv8yltAvJW+Df
         Oiim4jYGRdvE7ns2dMAmb6dMVVtU/IfgPSCMRJd8KJsv1G8Myww1HJ8BF1+MPF99nUb7
         QLgA==
X-Gm-Message-State: AOJu0YyJefZWJLr5gA4L+2B0V2u5IbapLnX7jo9RgZ1M4zSSnRGseojA
	HMPm7qBbmY3mnrvQvNtVUex5unuZ3jHWbOJpk0lH0HAze2RhdsU=
X-Gm-Gg: ASbGncvpDW5MStC1SL3r3qw/iRsiJ7FI1nKIUxJqh6Sfguetjs1NCJniljQEp4LkqQP
	ygjwi3b2c+S/TpjTuhr56qYPOJAWl/Xy4/0O1Ds5AwzaPpyc23oRRESX4moRPG27wG+VaGt6pbe
	H75LEWGcUOULDzhN9644dp5liWkrFhKJltcTtxRw8QHJTfGxFz5TO8ZLFQQX1/LrecoDrI+XLlE
	qMKgi1A9x0YuZk8yCSSMGklzuqDIIlM0MRUupRX3O6JhuRqokcHqLBPJyoJ7PASzy6LOh/F7w7b
	yX7c
X-Google-Smtp-Source: AGHT+IHeMiqHIlET1llgvf6L+jwsF48aKFgv4EFgoQEgOBt6AFyBKux/S9ICgFAXy3nnDzsaGWrabg==
X-Received: by 2002:a17:902:dace:b0:215:b1e3:c051 with SMTP id d9443c01a7336-21c35ca2eedmr316132185ad.11.1737558235197;
        Wed, 22 Jan 2025 07:03:55 -0800 (PST)
Received: from [127.0.0.1] ([20.169.14.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3e05f9sm96796165ad.180.2025.01.22.07.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 07:03:54 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250122-mptcp-issue-540-v3-0-4aeed3022f23@kernel.org>
References: <20250122-mptcp-issue-540-v3-0-4aeed3022f23@kernel.org>
Subject: Re: [PATCH mptcp-next v3 0/2] mptcp: pm: only set fullmesh for
 subflow endp
Message-ID: <e46344e8-88b1-b41d-b402-76c2c2ffc5d5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jan 2025 15:03:54 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

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
uns/12910004094

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/222b8bb817c3
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D927547


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
