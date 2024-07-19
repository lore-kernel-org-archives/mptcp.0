Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD9D13B587
	for <mptcp@lists.linux.dev>; Fri, 19 Jul 2024 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721394855; cv=none; b=MhVx3f0GwbXL8xkxfSvb1QhiIBDVwV3yMbiwD2VK7Ua3Ush18pRFiM+FMt4Ut/s+FoTYiNe3j+cgo9PyFqUlZjypKNcC4TyKarTFwReDW9r7w7gTHSMywEbESF7oKzZY4AGHBGSZWSaPQPfwgBBdUiKx8yiE9x50O0lZZP57hVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721394855; c=relaxed/simple;
	bh=GygNLHz9F2quw7zLFV2PQxemcYX8C69jLwX+TPe1yOk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=jPdQqpQnSQTPGOrOu+y8mYPzhvdWe1Pj2/9QjsMBVSV4zsm6/V8LmeI+olDhMg/01v1/fGMMn5JPK0mOzT+cxfGQBKLAgPECkCleWTdaj5QqfO5B/j29tPcv55U3amZHRr6u+9FpVJiYfHBvsxS6HT8JErj0u5vmz+pPLL7XmF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgpyfDtX; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgpyfDtX"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d93147ac6bso1079604b6e.0
        for <mptcp@lists.linux.dev>; Fri, 19 Jul 2024 06:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721394853; x=1721999653; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fc2yVwtTTl2xfatOgKRn/3F4kfCVn8ggUkhryQdTdQ8=;
        b=YgpyfDtXbvxHWYdkkl1inYV9D20s8SHX2GjYbPImqAbpg4+AlLsyETDxkP4dTopLqN
         ptbkui4yoFaeF1sry7DkUhSYh0+bJiAq54aarSsMW6jylk5CnLAygfmHQ80C+iGJad1X
         tdPt1l14G1z1APbyE3XMl4TpB06ptKF9OiMnaFV8SZEYYItFLwstG0X2hS7orS8QUUCG
         KYTCyn41GKe371Q24O+wVFzh0t6hCqlskeOBjUOE/lrvmcxINOqWF8gy+h28qo8G/wzy
         vD57asdTMYN9s/qL3SllUSv6zIbhXmt0Wf/sSqI46fq9ZOLrcXFtEsd/wz3EBZ10AQ5k
         4Maw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721394853; x=1721999653;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fc2yVwtTTl2xfatOgKRn/3F4kfCVn8ggUkhryQdTdQ8=;
        b=T83kf9VbkSIq/onP7tkMImAqhStREtxbPPEMsta342bbx06Gsz6Bux2lX7JcZcxms4
         59mZGyH2VEZdtEUW0J0IR6B8md5yohBzYe4Qbt0FuVdNLe9F22BxZ/DLs5P6yD3IwSKv
         BdVjgrXBhpyXucl8roEgSc5Lsgpql1NLKWzRFzGaGBV4DlkDqxOTV3i3M83KfzjE/UJX
         bCZY6HeE+mAl2s9na6YXyzL2NQ5xnGrIIm7rN4cyaYGU88OJiVMLnx+xV6f8gMqpeqLW
         uJhNXSA1qQ72T481v48KYl09t2FmwNTDXq5F8ESLyS7flEpYNOuQu3n8reYC+WZKOgAP
         +Caw==
X-Gm-Message-State: AOJu0Yxb9RzFTyf4hVpodxMTV04bh6u3bucJfGk4oKY6PXgj1OuiuCcg
	BXlZKC3DdoBRsfYRB1FVBb02eTnLgNF71F/sjib0FBAIPUmN51A=
X-Google-Smtp-Source: AGHT+IGfhSiXWRYAsm+SYDQk0BpFFtVUC2ebCO6mqddVjPMbhSV2/ijZ0fsrN3z60OCIWghjUI8aSQ==
X-Received: by 2002:a05:6808:3099:b0:3d9:33e9:e339 with SMTP id 5614622812f47-3dad1f11f2fmr9016211b6e.9.1721394852596;
        Fri, 19 Jul 2024 06:14:12 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.78.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a19909b4adsm76174785a.134.2024.07.19.06.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 06:14:12 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
References: <20240719-mptcp-pm-avail-v3-0-e96b5591ced3@kernel.org>
Subject: Re: [PATCH mptcp-net v3 00/20] mptcp: fix endpoints with 'signal'
 and 'subflow' flags
Message-ID: <2a3e1c6f-f609-30b4-7d70-e17af15ec0db@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jul 2024 13:14:11 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10008156976

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/91587d83fab7
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D872530


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
