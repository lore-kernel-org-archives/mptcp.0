Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B48EADD
	for <mptcp@lists.linux.dev>; Tue,  2 Jan 2024 11:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQ+TBVls"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6da47688fd9so550301b3a.0
        for <mptcp@lists.linux.dev>; Tue, 02 Jan 2024 03:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704196684; x=1704801484; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YzFxQqfPlNYaApbN8D9otuMUGbeFj8cM5vDrPkNQuU=;
        b=GQ+TBVlsgF/OTPyrv2ig9DmzBpIm5ppL7AdynvKmcYeDVdO3zF2Qu4eAw3YhPDlj2s
         kE7kOTR4chUKK3KJEdH2KJDvWXvk8ov7yOZGtcdr+6s1LXNcd1eqj6b6X/yt0kmSv5Or
         zMip0UjxEuh6asHttD9Tn5YPMMTvnPX0Kaf8SH1u2ztQP+EU6P0mlQorJulDMbRwFs/k
         8hWeY9OJbiVsQrIBAJwLij8U3Bcf8n3UFFW+t6XghbSQiinTOcNmLPx4ZG/jOQzYYlWf
         ImVRFeGxTOp7MIQVYgeyR6oHNkLk35egf9meS24yTrQNUPy1dlzEpVVripZLoCKAacH/
         NM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704196684; x=1704801484;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6YzFxQqfPlNYaApbN8D9otuMUGbeFj8cM5vDrPkNQuU=;
        b=SAYnWVXTHM3iXnplIOFa1x61s9b5mf39KIKBIvc/aDLPAjLnyQ/CskHXA7DHhed6NT
         Fx++nzA+vWV+TkwGR0YaCnRGk5APYTCeGzBEiYOX/Fzfx48ldjOEmQU2oaH3HIQaigfV
         pRL5RIWi1qEgJDay2ZWj0NqGlw3v1yJKJheQGSyxhJS0mrezAiepCM3IOCg8PIGwD2o/
         Pyu7dizu/hw+0r4kW9h4vZK/7nG2IQAvdKyADfBFYQ5t6sh61uvCZbMGAJM/QPcz9KkV
         nk+WL+QbfS5W8FwWIu7Dz8RnV5R0EWdgI7Obd4VKtoQMhfxykzwom/j5KqFDYAj6zMXS
         aNVQ==
X-Gm-Message-State: AOJu0Yxsz3gvdb0CFt5k3fXnPZ2emrW8Zu/Kt7fx0QR48J9dVsM8Vq8U
	+fzTwiIjMZLnNvsO9cRTHg==
X-Google-Smtp-Source: AGHT+IEkuStxNIzFgpfxw5MkHk6Kyr/XqGbKwq0R8jK+jrXCM3EzOj2a8/nu6onE+3fcJZ0MhXsXQA==
X-Received: by 2002:a05:6a00:80ce:b0:6d9:a0a2:a7c0 with SMTP id ei14-20020a056a0080ce00b006d9a0a2a7c0mr4943199pfb.66.1704196683903;
        Tue, 02 Jan 2024 03:58:03 -0800 (PST)
Received: from [127.0.0.1] ([4.227.115.2])
        by smtp.gmail.com with ESMTPSA id a23-20020aa78657000000b006d9b8e1971dsm14858147pfo.191.2024.01.02.03.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 03:58:03 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@linux.dev>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <21d0da867665e8fc693b12e3cecd4610efced6e2.1703904325.git.geliang.tang@linux.dev>
References:
 <21d0da867665e8fc693b12e3cecd4610efced6e2.1703904325.git.geliang.tang@linux.dev>
Subject: Re: selftests: mptcp: flush userspace addrs list: Tests Results
Message-ID: <12b4818d-e419-8572-49d9-d33144b01034@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jan 2024 11:58:02 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/4573549566885888
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4573549566885888/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5136499520307200
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5136499520307200/summary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts containing file =
conclusion.txt"}:
  - Task: https://cirrus-ci.com/task/6262399427149824
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6262399427149824/su=
mmary/summary.txt

- {"code":404,"message":
  - "Can't find artifacts =
containing file conclusion.txt"}:
  - Task: https://cirrus-ci.=
com/task/5699449473728512
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5699449473728512/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/3797d85eb2dc


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
