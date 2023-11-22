Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC442BAE9
	for <mptcp@lists.linux.dev>; Wed, 22 Nov 2023 04:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lybVvCp6"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-778a6c440faso318874585a.3
        for <mptcp@lists.linux.dev>; Tue, 21 Nov 2023 20:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700628556; x=1701233356; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJJMadwzO+Q9uklsYAcoCcdfoAGv+Mhn9T1lNqZp5XI=;
        b=lybVvCp6VGarc6a5o4OQoi/XN9D1qVTALceMC0Sh+7qoO+yoNraxwEUE7WoszY1ps8
         BK28Rki+oz/UCWLM3CJJVSFywfc5szcMLJoMV8DndSg+HFwWOV31OvEIo6gKxa8INAfK
         avDercTsu+zbR8TINYZ9d54XjQoxLhVlFmLoc/aamoyCR8EP1Q1/FvQBf12+dv0N337Q
         86pQfZrvRJtzvWJTpA/XmpqA5yexTQ8fO8IlNKUQc4l+vSFAEC+++f3XNTZBYUZiE8h9
         pD4d88QZKPLkm2Zenbtaw/YyH80EqHY06JywaxKClpdBwoy1rLQnakpjLwGaiJoYOuhl
         RO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700628556; x=1701233356;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mJJMadwzO+Q9uklsYAcoCcdfoAGv+Mhn9T1lNqZp5XI=;
        b=pAoIbtDvv0S64PrEVblm5pXGuw0XAdTrmexy5q75vNJwHROfhF+awI7vtMmf1CWglj
         z8V0pYVWdiluZM8Vr6xtkWAYJGUTXfekzd39YPbX+eF+kXo8Q1zXFKU7AL5QuNdBCvN2
         LwW65fpAF4jeczlzIXDY+HCVtOaqcftJSBnGHVl59Imj800UeR+jHiaN3CbqdqTrKheq
         oLSfI9hc1QdXVy2qqWhbsgWN2fUJUFELYNLjrhBG3yoBmMuy3M1kXFLURZ/4H8JTZlde
         7xf5A6A5rH9oS61qjmB5zfbwkbh1noq4coxrmTBVJGrxGOfKBeODRMpgmyF/iR/i7GlE
         MtKQ==
X-Gm-Message-State: AOJu0YyCrHxPT6Q2bX5WGDXfjDLS2J3a9C9Lb1XHFXtDbDB+YIjA5SAw
	gwNIuSMl4gioNdX4sfGZxJdQU2d00UWu
X-Google-Smtp-Source: AGHT+IF6KycqSSUiUaW5OOwzRsAsPC8IBMNTu+E7KFuLFVpoAZNO49EkWovwmDkNsyItinsyz0PnoQ==
X-Received: by 2002:a05:620a:384c:b0:777:72a1:efae with SMTP id po12-20020a05620a384c00b0077772a1efaemr955086qkn.67.1700628556445;
        Tue, 21 Nov 2023 20:49:16 -0800 (PST)
Received: from [127.0.0.1] ([20.49.54.5])
        by smtp.gmail.com with ESMTPSA id h9-20020ac87149000000b00419b094537esm4142804qtp.59.2023.11.21.20.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 20:49:15 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <14a1120c9bc792ead2b926208ce85b5f10cb99fd.1700624540.git.geliang.tang@suse.com>
References:
 <14a1120c9bc792ead2b926208ce85b5f10cb99fd.1700624540.git.geliang.tang@suse.com>
Subject: =?UTF-8?Q?Re=3A_Squash_to_=22selftests/bpf=3A_Add_?=
 =?UTF-8?Q?bpf=5Fburst_scheduler=22=3A_Tests_Result?= =?UTF-8?Q?s?=
Message-ID: <1a241bfb-de8d-3639-10f6-97bb68690425@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Nov 2023 04:49:15 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4522476651151360
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4522476651151360/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6211326511415296
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6211326511415296/su=
mmary/summary.txt

- KVM Validation: normal (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5648376557993984
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5648376557993984/summary/summary.txt

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/5085426604572672
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/5085426604572672/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/9712119a0a4b


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
Bot operated by Matthieu Baerts (Tessares)
