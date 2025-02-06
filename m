Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0BB227575
	for <mptcp@lists.linux.dev>; Thu,  6 Feb 2025 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738838619; cv=none; b=eW3MpzN9x4jZm+iYJbtKC9ky5LSJyvQaSR1IOeKBvB8i7PJC4rtHzfjkq5+4hLTWpIr037MXwgOdy3vpMQ6cbyhqcxjOlsbQjX/nL52uvcn6Oo3ZEj6IzQ88nPZuLkutlr2cw5hMgNaK/E/YmF1TZ9jAGz/T3Iz7sdTk304QjJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738838619; c=relaxed/simple;
	bh=F5z65RsVq296Q7G5gBMf8/3aP47RMnsqKBBPixCdYWM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=DnDaC68eNQP1IPfaGEOBnY0RKHB8ieqnWEfgYmKaHbHR+bFklWVbEXqeFTEBtNbRFcKtvnV6kttizw0kvCgcamEPocJznxBLVWAYNH/V4g/A8r/q6MHj7QDaxEcI1AVHdgRb9z7qBu1CUVQxK9/k/vXJJPchSR8Z+f1ktewGd0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IH4sTl03; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IH4sTl03"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-46b1d40ac6bso5879161cf.0
        for <mptcp@lists.linux.dev>; Thu, 06 Feb 2025 02:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738838617; x=1739443417; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdsajPeGjNnr/w5VCYRDk/4+xJ5JlOrNIx926tdf4+4=;
        b=IH4sTl03rCj5dziEH+SPEhBoDZWDN+5Q0nqbd4kptXGeIikOJQDp56C70OSWVzpTYs
         zqFHOZLBd245m8LRcZnSrgIsDpXz34prGKSA9FMUWGDZJg92x83/m4Xr3PJL3d5VICzc
         KpkINeZrlmVwI9CWbJW9dRntqo8LV31cxJfuTET2Ysc0IdZs+zsCI4/EtvxO7FzYpdPH
         VF6rL9s8pp5n9Ry9BGTZEza2acT1zzcNIokS5zpmP4jC8CXMdnoNc1RFQ9wYbek5rfhq
         aaRLuAg6O+0XU79DgAVrXlKo3468Lq2RguPUsbfMZhxM7jChuLILY2FRFzfHgkIPiS2u
         1whA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738838617; x=1739443417;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OdsajPeGjNnr/w5VCYRDk/4+xJ5JlOrNIx926tdf4+4=;
        b=O2aEdUSFBz9Wj4sClTfgQkFLZo31M/7uAT0tC1nhd4GbW2ad9BWvWbs7rhob5CNxdC
         hX2NVVDMj+kIVZ2v/4a0DBE5RB+6sNvNtGDLsUb+mLZyhk2j53CPmZZAVDvNBOL+4Psb
         wuoHgQH4aBorcGlxzgOAzTPIZTqWVuKkh5WJ9VTuyPx/jb+etqTk7sYc9HpQPXgnLWMO
         AGXmcpE0mO7AgoXRiH9v7e7gTFaV9cN0K2o4SjfNtBfL/Qj9bUC5MZI/3rqfZXcRzQ6u
         G4IlVeBQK65r78KkS3iNYk0tnZEJBlxmzXn7MKcIV4fBnxNRbY9avFDuWrDKOD9sU6uv
         /L9Q==
X-Gm-Message-State: AOJu0YxxWyouQohFszUPfbUndaN1wypX+z/VWRHnFUVg7ZF7rz24vyhR
	dlwYLHbv6WMMK3qg9SGuBchwg54mapjmW+xLMUADIntLhF/5YmXmqjfC
X-Gm-Gg: ASbGncsAZ7aQLz+BKRNTjz0hCmUUFt4w/S3riLnTXDt6QdQUtjggopLn+ehaDKo5jzx
	2H0yDhA2/lm5ZUCsKHQ7e8xnT+865ZnmuchRtB2xRr1ftagqDZWSyzIpueL3OSRqo22uCecqkr3
	0Nlkp5oOb1TBYMsrV2dxcuN18gXYsbImNdaHkxBMMgY2guxncGOaEUIidOZxPwun8qINK0cbQgi
	Oa32j30rLtDssihBXQAmNyHk+fPDKYX9YD98FIoq+owywuo7pWeflh8yHLaUBCqC/FqhUIyHcdE
	DoEAUcO4CbRIhEhrrDOeeaq3gfo=
X-Google-Smtp-Source: AGHT+IH82If8JC+ZdXn6StumyGIteWYM94T/CHGZdNgvcu77wPf2Vd2H70F3F8y8IF4hPoZAf8bhpQ==
X-Received: by 2002:ac8:5ace:0:b0:466:9197:b4fa with SMTP id d75a77b69052e-4703371b2b7mr36247121cf.21.1738838616725;
        Thu, 06 Feb 2025 02:43:36 -0800 (PST)
Received: from [127.0.0.1] ([20.25.192.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47153bec61fsm4231321cf.80.2025.02.06.02.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 02:43:35 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1738832147.git.tanggeliang@kylinos.cn>
References: <cover.1738832147.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v13 0/9] use bpf_iter in bpf schedulers
Message-ID: <6ac8f7c4-32c2-83da-994f-0a09c8e0b2d6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Feb 2025 10:43:34 +0000
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
Critical: Global Timeout =E2=9D=8C
- KVM Validation: btf-normal (only =
bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/13175549245

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/56925d3521fd
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D931123


If there are some issues, you can=
 reproduce them using the same environment as
the one used by the CI thanks=
 to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
